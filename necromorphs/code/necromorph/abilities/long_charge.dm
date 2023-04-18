/datum/action/cooldown/necro/long_charge
	name = "Toggle Charging"
	desc = "Toggles the movement-based charge on and off."
	var/charge_type = CHARGE_BRUTE
	var/next_move_limit = 0
	var/turf/lastturf = null
	var/charge_dir = null
	var/charge_ability_on = FALSE
	var/valid_steps_taken = 0
	var/crush_sound = "punch"
	var/speed_per_step = 0.15
	var/steps_for_charge = 7
	var/max_steps_buildup = 14
	var/crush_living_damage = 20
	var/next_special_attack = 0 //Little var to keep track on special attack timers.
	var/plasma_use_multiplier = 1
	///If this charge should keep momentum on dir change and if it can charge diagonally
	var/agile_charge = FALSE

/datum/action/cooldown/necro/long_charge/Destroy()
	if(charge_ability_on)
		charge_off()
	return ..()

/datum/action/cooldown/necro/long_charge/Activate(atom/target)
	if(charge_ability_on)
		charge_off()
		return TRUE
	charge_on()
	return TRUE

/datum/action/cooldown/necro/long_charge/proc/charge_on(verbose = TRUE)
	var/mob/living/carbon/human/necromorph/charger = owner
	charge_ability_on = TRUE
	RegisterSignal(charger, COMSIG_MOVABLE_MOVED, PROC_REF(update_charging))
	RegisterSignal(charger, COMSIG_ATOM_DIR_CHANGE, PROC_REF(on_dir_change))
	if(verbose)
		to_chat(charger, span_notice("We will charge when moving, now."))

/datum/action/cooldown/necro/long_charge/proc/charge_off(verbose = TRUE)
	var/mob/living/carbon/human/necromorph/charger = owner
	if(charger.charging != CHARGE_OFF)
		do_stop_momentum()
	UnregisterSignal(charger, list(COMSIG_MOVABLE_MOVED, COMSIG_ATOM_DIR_CHANGE))
	if(verbose)
		to_chat(charger, span_notice("We will no longer charge when moving."))
	valid_steps_taken = 0
	charge_ability_on = FALSE


/datum/action/cooldown/necro/long_charge/proc/on_dir_change(datum/source, old_dir, new_dir)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/necromorph/charger = owner
	if(charger.charging == CHARGE_OFF)
		return
	if(!old_dir || !new_dir || old_dir == new_dir || agile_charge) //Check for null direction from help shuffle signals
		return
	do_stop_momentum()


/datum/action/cooldown/necro/long_charge/proc/update_charging(datum/source, atom/oldloc, direction, Forced, old_locs)
	SIGNAL_HANDLER
	if(Forced)
		return

	var/mob/living/carbon/human/necromorph/charger = owner
	if(charger.throwing || oldloc == charger.loc)
		return

	if(charger.charging == CHARGE_OFF)
		if(charger.dir != direction) //It needs to move twice in the same direction, at least, to begin charging.
			return
		charge_dir = direction
		if(!check_momentum(direction))
			charge_dir = null
			return
		charger.charging = CHARGE_BUILDINGUP
		handle_momentum()
		spec_check(source, oldloc, direction, Forced, old_locs)
		return

	if(!check_momentum(direction))
		do_stop_momentum()
		return

	handle_momentum()
	spec_check(source, oldloc, direction, Forced, old_locs)

/datum/action/cooldown/necro/long_charge/proc/spec_check(datum/source, atom/oldloc, direction, Forced, old_locs)
	switch(charge_type)
		if(CHARGE_BRUTE)
			var/list/turfs = list(get_step(source, turn(direction, 90)), get_step(source, turn(direction, -90)))
			for (var/turf/T in turfs)
				for (var/mob/A in T)
					if(!do_crush(owner, A))
						return

/datum/action/cooldown/necro/long_charge/proc/do_start_crushing()
	var/mob/living/carbon/human/necromorph/charger = owner
	RegisterSignal(charger, COMSIG_MOVABLE_BUMP, PROC_REF(do_crush))
	charger.charging = CHARGE_ON
	charger.update_icons()

/datum/action/cooldown/necro/long_charge/proc/do_stop_crushing()
	var/mob/living/carbon/human/necromorph/charger = owner
	UnregisterSignal(charger, COMSIG_MOVABLE_BUMP)
	if(valid_steps_taken > 0) //If this is false, then do_stop_momentum() should have it handled already.
		charger.charging = CHARGE_BUILDINGUP
		charger.update_icons()


/datum/action/cooldown/necro/long_charge/proc/do_stop_momentum(message = TRUE)
	var/mob/living/carbon/human/necromorph/charger = owner
	if(message && valid_steps_taken >= steps_for_charge) //Message now happens without a stun condition
		charger.visible_message(span_danger("[charger] skids to a halt!"),
		span_warning("We skid to a halt."), null, 5)
	valid_steps_taken = 0
	next_move_limit = 0
	lastturf = null
	charge_dir = null
	charger.remove_movespeed_modifier(/datum/movespeed_modifier/necro_charge)
	if(charger.charging >= CHARGE_ON)
		do_stop_crushing()
	charger.charging = CHARGE_OFF
	charger.update_icons()


/datum/action/cooldown/necro/long_charge/proc/check_momentum(newdir)
	var/mob/living/carbon/human/necromorph/charger = owner
	if((newdir && ISDIAGONALDIR(newdir) || charge_dir != newdir) && !agile_charge) //Check for null direction from help shuffle signals
		return FALSE

	if(next_move_limit && world.time > next_move_limit)
		return FALSE

	if(charger.pulling)
		return FALSE

	if(charger.incapacitated())
		return FALSE

	if(charge_dir != charger.dir && !agile_charge)
		return FALSE

	if(charger.pulledby)
		return FALSE

	if(lastturf && (!isturf(lastturf) || isspaceturf(lastturf) || (charger.loc == lastturf))) //Check if the Crusher didn't move from his last turf, aka stopped
		return FALSE

	return TRUE


/datum/action/cooldown/necro/long_charge/proc/handle_momentum()
	set waitfor = FALSE
	var/mob/living/carbon/human/necromorph/charger = owner

	if(charger.pulling && valid_steps_taken)
		charger.stop_pulling()

	next_move_limit = world.time + 0.5 SECONDS

	if(++valid_steps_taken <= max_steps_buildup)
		if(valid_steps_taken == steps_for_charge)
			do_start_crushing()
		else if(valid_steps_taken == max_steps_buildup)
			charger.charging = CHARGE_MAX
		charger.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/necro_charge, TRUE, -CHARGE_SPEED(src))

	if(valid_steps_taken > steps_for_charge)

		switch(charge_type)
			if(CHARGE_BRUTE) //Necro Brute
				var/shake_dist = min(round(CHARGE_SPEED(src) * 5), 8)
				for(var/mob/living/carbon/victim in range(shake_dist, charger))
					if(victim.stat == DEAD)
						continue
					if(victim.client)
						shake_camera(victim, 1, 1)
					if(victim.loc != charger.loc || !victim.lying_prev)
						continue
					charger.visible_message(span_danger("[charger] runs [victim] over!"),
						span_danger("We run [victim] over!"), null, 5)
					victim.take_overall_damage(CHARGE_SPEED(src) * 10, BRUTE,MELEE)
					animation_flash_color(victim)

	lastturf = charger.loc


/datum/action/cooldown/necro/long_charge/proc/speed_down(amt)
	if(valid_steps_taken == 0)
		return
	valid_steps_taken -= amt
	if(valid_steps_taken <= 0)
		valid_steps_taken = 0
		do_stop_momentum()
	else if(valid_steps_taken < steps_for_charge)
		do_stop_crushing()

#define PRECRUSH_STOPPED -1
#define PRECRUSH_PLOWED -2
#define PRECRUSH_ENTANGLED -3

/proc/precrush2signal(precrush)
	switch(precrush)
		if(PRECRUSH_STOPPED)
			return
		if(PRECRUSH_PLOWED)
			return
		if(PRECRUSH_ENTANGLED)
			return
		else
			return NONE

// Charge is divided into two acts: before and after the crushed thing taking damage, as that can cause it to be deleted.
/datum/action/cooldown/necro/long_charge/proc/do_crush(datum/source, atom/crushed)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/necromorph/charger = owner
	if(charger.incapacitated() || charger.now_pushing)
		return NONE

	if(!(charge_type & CHARGE_BRUTE) && !isliving(crushed))
		do_stop_momentum()
		return

	var/precrush = crushed.pre_crush_act(charger, src) //Negative values are codes. Positive ones are damage to deal.
	switch(precrush)
		if(null)
			CRASH("[crushed] returned null from do_crush()")
		if(PRECRUSH_STOPPED)
			return //Already handled, no need to continue.
		if(PRECRUSH_PLOWED)
			return
		if(PRECRUSH_ENTANGLED)
			return

	var/preserved_name = crushed.name

	if(isliving(crushed))
		var/mob/living/crushed_living = crushed
		playsound(crushed_living.loc, crush_sound, 25, 1)
		if(crushed_living.buckled)
			crushed_living.buckled.unbuckle_mob(crushed_living)
		animation_flash_color(crushed_living)

		if(precrush > 0)
			log_combat(charger, crushed_living, "necro charged")
			//There is a chance to do enough damage here to gib certain mobs. Better update immediately.
			crushed_living.apply_damage(precrush, BRUTE, BODY_ZONE_CHEST)
			if(QDELETED(crushed_living))
				charger.visible_message(span_danger("[charger] anihilates [preserved_name]!"),
				span_danger("We anihilate [preserved_name]!"))
				return

		return precrush2signal(crushed_living.post_crush_act(charger, src))

	if(isobj(crushed))
		var/obj/crushed_obj = crushed
		playsound(crushed_obj.loc, "punch", 25, 1)
		crushed_obj.take_damage(precrush, BRUTE, "melee")
		if(QDELETED(crushed_obj))
			charger.visible_message(span_danger("[charger] crushes [preserved_name]!"),
			span_danger("We crush [preserved_name]!"))
			return
		return precrush2signal(crushed_obj.post_crush_act(charger, src))

	if(isturf(crushed))
		var/turf/crushed_turf = crushed
		switch(precrush)
			if(1 to 3)
				crushed_turf.ex_act(precrush)

		if(QDELETED(crushed_turf))
			charger.visible_message(span_danger("[charger] plows straight through [preserved_name]!"),
			span_warning("We plow straight through [preserved_name]!"))
			return

		charger.visible_message(span_danger("[charger] rams into [crushed_turf] and skids to a halt!"),
		span_warning("We ram into [crushed_turf] and skid to a halt!"))
		do_stop_momentum(FALSE)
		return



// ***************************************
// *********** Pre-Crush
// ***************************************

//Anything called here will have failed CanPass(), so it's likely dense.
/atom/proc/pre_crush_act(mob/living/carbon/human/necromorph/charger, datum/action/cooldown/necro/long_charge/charge_datum)
	return //If this happens it will error.


/obj/pre_crush_act(mob/living/carbon/human/necromorph/charger, datum/action/cooldown/necro/long_charge/charge_datum)
	if((resistance_flags & INDESTRUCTIBLE) || charger.charging < CHARGE_ON)
		charge_datum.do_stop_momentum()
		return PRECRUSH_STOPPED
	if(anchored)
		if(flags_1 & ON_BORDER_1)
			if(dir == REVERSE_DIR(charger.dir))
				. = (CHARGE_SPEED(charge_datum) * 80) //Damage to inflict.
				charge_datum.speed_down(3)
				return
			else
				. = (CHARGE_SPEED(charge_datum) * 160)
				charge_datum.speed_down(1)
				return
		else
			. = (CHARGE_SPEED(charge_datum) * 240)
			charge_datum.speed_down(2)
			return

	for(var/m in buckled_mobs)
		unbuckle_mob(m)
	return (CHARGE_SPEED(charge_datum) * 20) //Damage to inflict.

/obj/vehicle/unmanned/pre_crush_act(mob/living/carbon/human/necromorph/charger, datum/action/cooldown/necro/long_charge/charge_datum)
	return (CHARGE_SPEED(charge_datum) * 10)

/obj/vehicle/sealed/mecha/pre_crush_act(mob/living/carbon/human/necromorph/charger, datum/action/cooldown/necro/long_charge/charge_datum)
	return (CHARGE_SPEED(charge_datum) * 240)

/obj/structure/razorwire/pre_crush_act(mob/living/carbon/human/necromorph/charger, datum/action/cooldown/necro/long_charge/charge_datum)
	if(resistance_flags & INDESTRUCTIBLE || charger.charging < CHARGE_ON)
		charge_datum.do_stop_momentum()
		return PRECRUSH_STOPPED
	if(anchored)
		var/charge_damage = (CHARGE_SPEED(charge_datum) * 45)  // 2.1 * 45 = 94.5 max damage to inflict.
		. = charge_damage
		charge_datum.speed_down(3)
		return
	return (CHARGE_SPEED(charge_datum) * 20) //Damage to inflict.


/mob/living/pre_crush_act(mob/living/carbon/human/necromorph/charger, datum/action/cooldown/necro/long_charge/charge_datum)
	return (stat == DEAD ? 0 : CHARGE_SPEED(charge_datum) * charge_datum.crush_living_damage)

/turf/pre_crush_act(mob/living/carbon/human/necromorph/charger, datum/action/cooldown/necro/long_charge/charge_datum)
	if(charge_datum.valid_steps_taken >= charge_datum.max_steps_buildup)
		return 2 //Should dismantle, or at least heavily damage it.
	return 3 //Lighter damage.


// ***************************************
// *********** Post-Crush
// ***************************************

/atom/proc/post_crush_act(mob/living/carbon/human/necromorph/charger, datum/action/cooldown/necro/long_charge/charge_datum)
	return PRECRUSH_STOPPED //By default, if this happens then movement stops. But not necessarily.


/obj/post_crush_act(mob/living/carbon/human/necromorph/charger, datum/action/cooldown/necro/long_charge/charge_datum)
	if(anchored) //Did it manage to stop it?
		charger.visible_message(span_danger("[charger] rams into [src] and skids to a halt!"),
		span_warning("We ram into [src] and skid to a halt!"))
		if(charger.charging > CHARGE_OFF)
			charge_datum.do_stop_momentum(FALSE)
		return PRECRUSH_STOPPED
	var/fling_dir = pick(GLOB.cardinals - ((charger.dir & (NORTH|SOUTH)) ? list(NORTH, SOUTH) : list(EAST, WEST))) //Fling them somewhere not behind nor ahead of the charger.
	var/fling_dist = min(round(CHARGE_SPEED(charge_datum)) + 1, 3)
	if(!step(src, fling_dir) && density)
		charge_datum.do_stop_momentum(FALSE) //Failed to be tossed away and returned, more powerful than ever, to block the charger's path.
		charger.visible_message(span_danger("[charger] rams into [src] and skids to a halt!"),
			span_warning("We ram into [src] and skid to a halt!"))
		return PRECRUSH_STOPPED
	if(--fling_dist)
		for(var/i in 1 to fling_dist)
			if(!step(src, fling_dir))
				break
	charger.visible_message("[span_warning("[charger] knocks [src] aside.")]!",
	span_warning("We knock [src] aside.")) //Canisters, crates etc. go flying.
	charge_datum.speed_down(2) //Lose two turfs worth of speed.
	return PRECRUSH_PLOWED

/obj/machinery/vending/post_crush_act(mob/living/carbon/human/necromorph/charger, datum/action/cooldown/necro/long_charge/charge_datum)
	if(!anchored)
		return ..()
	if(density)
		return PRECRUSH_STOPPED
	charger.visible_message(span_danger("[charger] slams [src] into the ground!"),
	span_warning("We slam [src] into the ground!"))
	return PRECRUSH_PLOWED

/obj/vehicle/post_crush_act(mob/living/carbon/human/necromorph/charger, datum/action/cooldown/necro/long_charge/charge_datum)
	take_damage(charger.class.melee_damage_upper, BRUTE, MELEE)
	if(density && charger.move_force <= move_resist)
		charger.visible_message(span_danger("[charger] rams into [src] and skids to a halt!"),
		span_warning("We ram into [src] and skid to a halt!"))
		charge_datum.do_stop_momentum(FALSE)
		return PRECRUSH_STOPPED
	charge_datum.speed_down(2) //Lose two turfs worth of speed.
	return NONE

/mob/living/post_crush_act(mob/living/carbon/human/necromorph/charger, datum/action/cooldown/necro/long_charge/charge_datum)
	if(density && ((mob_size == charger.mob_size && charger.charging <= CHARGE_MAX) || mob_size > charger.mob_size))
		charger.visible_message(span_danger("[charger] rams into [src] and skids to a halt!"),
		span_warning("We ram into [src] and skid to a halt!"))
		charge_datum.do_stop_momentum(FALSE)
		step(src, charger.dir)
		return PRECRUSH_STOPPED

	switch(charge_datum.charge_type)
		if(CHARGE_BRUTE)
			Paralyze(CHARGE_SPEED(charge_datum) * 20)

	if(anchored)
		charge_datum.do_stop_momentum(FALSE)
		charger.visible_message(span_danger("[charger] rams into [src] and skids to a halt!"),
			span_warning("We ram into [src] and skid to a halt!"))
		return PRECRUSH_STOPPED

	switch(charge_datum.charge_type)
		if(CHARGE_BRUTE)
			var/fling_dir = pick((charger.dir & (NORTH|SOUTH)) ? list(WEST, EAST, charger.dir|WEST, charger.dir|EAST) : list(NORTH, SOUTH, charger.dir|NORTH, charger.dir|SOUTH)) //Fling them somewhere not behind nor ahead of the charger.
			var/fling_dist = min(round(CHARGE_SPEED(charge_datum)) + 1, 3)
			var/turf/destination = loc
			var/turf/temp

			for(var/i in 1 to fling_dist)
				temp = get_step(destination, fling_dir)
				if(!temp)
					break
				destination = temp
			if(destination != loc)
				throw_at(destination, fling_dist, 1, charger, TRUE)

			charger.visible_message(span_danger("[charger] rams [src]!"),
			span_danger("We ram [src]!"))
			charge_datum.speed_down(1) //Lose one turf worth of speed.
			return PRECRUSH_PLOWED

	charge_datum.do_stop_momentum(FALSE)
	return PRECRUSH_STOPPED


/mob/living/proc/emote_gored()
	return

/obj/proc/crushed_special_behavior()
	return NONE

#undef PRECRUSH_STOPPED
#undef PRECRUSH_PLOWED
#undef PRECRUSH_ENTANGLED
