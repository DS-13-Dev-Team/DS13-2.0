/datum/component/regenerate
	var/duration = 5 SECONDS

	var/mob/living/carbon/human/necromorph/target_necro

	var/max_limbs = 1
	var/heal_amount = 40

	var/tick_interval = 0.2 SECONDS
	var/shake_interval = 0.5 SECONDS

	var/lasting_damage_heal = 999999
	var/limb_lasting_damage = 0	//When a limb is replaced, the mob suffers lasting damage equal to the limb's health * this value
	var/biomass_limb_cost = 0	//When a limb is replaced, the marker transfers biomass to the mob, equal to the limb's health * this value
	var/biomass_lasting_damage_cost = 0	//When lasting_damage is healed, the marker transfers biomass to the mob, equal to the damage healed * this value
	var/burn_heal_mult = 1	//When healing burn damage, each point of heal_amount can heal this many points of actual burn damage

	//Runtime stuff
	var/list/regenerating_organs = list()
	var/tick_timer
	var/tick_step

	var/next_use_time

/datum/component/regenerate/Initialize(...)
	. = ..()
	target_necro = parent
	INVOKE_ASYNC(src, PROC_REF(start))

/datum/component/regenerate/proc/start()
	tick_step = 1 / (duration / tick_interval)
	var/list/missing_limbs = list()
	var/count_limbs = 0

	for(var/limb_tag in target_necro.dna.species.bodypart_overrides)

		var/obj/item/bodypart/bp = target_necro.get_bodypart(limb_tag)

		if(bp)
			continue
		else if(!bp)
			missing_limbs |= limb_tag

		if (max_limbs <= count_limbs)
			continue

		if(bp)
			if(!bp.can_be_disabled)
				continue
			if(bp.bodypart_disabled)
				qdel(bp)
				bp = null
		if(!bp)
			regenerating_organs |= limb_tag
			count_limbs++

	//Special effect:
	//If the user is missing two or more limbs, rplays a special sound
	if (missing_limbs.len >= 2)
		target_necro.play_necro_sound(SOUND_REGEN, VOLUME_MID, 1)

	duration *= (1 + (missing_limbs.len * 0.25))	//more limbs lost, the longer it takes

	//Lets play the animations
	for(var/limb_type in regenerating_organs)
		target_necro.dna.species:regenerate_limb(target_necro, limb_type, duration)

	target_necro.shake_animation(30)
	start_stun()
	addtimer(CALLBACK(src, .proc/finish_stun), CEILING(duration, 10), TIMER_STOPPABLE)

	//And lets start our timer
	tick_timer = addtimer(CALLBACK(src, .proc/tick), tick_interval, TIMER_STOPPABLE)

/datum/component/regenerate/proc/start_stun()
	ADD_TRAIT(target_necro, TRAIT_INCAPACITATED, src)
	ADD_TRAIT(target_necro, TRAIT_IMMOBILIZED, src)
	ADD_TRAIT(target_necro, TRAIT_HANDS_BLOCKED, src)

/datum/component/regenerate/proc/finish_stun()
	REMOVE_TRAIT(target_necro, TRAIT_INCAPACITATED, src)
	REMOVE_TRAIT(target_necro, TRAIT_IMMOBILIZED, src)
	REMOVE_TRAIT(target_necro, TRAIT_HANDS_BLOCKED, src)

/datum/component/regenerate/proc/tick()
	shake_interval -= tick_interval
	var/remaining_heal = target_necro.heal_bodypart_damage(brute = heal_amount * tick_step)
	if (remaining_heal)
		target_necro.heal_bodypart_damage(burn = heal_amount * tick_step * burn_heal_mult)
	if (shake_interval <= 0)
		shake_interval = initial(shake_interval)
		target_necro.shake_animation(30)

	if (world.time < next_use_time) //Queue next tick
		tick_timer = addtimer(CALLBACK(src, .proc/tick), tick_interval, TIMER_STOPPABLE)
	else
		finish()

/datum/component/regenerate/proc/finish()

	//Lets finish up. The limb regrowing animations should be done by now
	//Here we actually create the freshly grown limb
	for(var/limb_type in regenerating_organs)
		var/limb_path = target_necro.dna.species.bodypart_overrides[limb_type]
		var/obj/item/bodypart/O = new limb_path()

		O.replace_limb(target_necro, TRUE)
		O.update_limb(is_creating = TRUE)

		if (limb_lasting_damage)
			target_necro.adjustLastingDamage(O.max_damage*limb_lasting_damage)

		if (biomass_limb_cost)
			var/biomass_delta = O.max_damage*biomass_limb_cost
			if (biomass_delta)
				to_chat(target_necro, "Regenerating [O] at a cost of [biomass_delta] kg biomass")

	if (lasting_damage_heal)
		var/lasting_heal = min(lasting_damage_heal, target_necro.getLastingDamage())
		target_necro.adjustLastingDamage(lasting_heal*-1)

	regenerating_organs = list()
	tick_timer = null
	return

// Buffs a necromorph after regenerating
/datum/component/statmod/regenerate_afterbuff

	var/duration = 8 SECONDS
	var/started_at
	var/stopped_at

	var/ongoing_timer

	statmods = list(
					STATMOD_ATTACK_SPEED = 1,
					STATMOD_MOVESPEED_MULTIPLICATIVE = 1.4,
					STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE = 0.6
	)

/datum/component/statmod/regenerate_afterbuff/Initialize(duration)
	. = ..()
	if (duration)
		src.duration = duration

	INVOKE_ASYNC(src, PROC_REF(start))

/datum/component/statmod/regenerate_afterbuff/proc/start()
	started_at	=	world.time
	var/mob/living/M = parent
	if (!M.get_filter("afterbuff"))
		var/newfilter = filter(type="outline", size = 1, color = rgb(255,0,0,128))
		M.add_filter("afterbuff", 1, newfilter)

	ongoing_timer = addtimer(CALLBACK(src, PROC_REF(stop)), duration, TIMER_STOPPABLE)

/datum/component/statmod/regenerate_afterbuff/proc/stop()
	deltimer(ongoing_timer)
	stopped_at = world.time
	var/mob/living/M = parent
	if (M.get_filter("afterbuff"))
		M.remove_filter("afterbuff")

	qdel(src)
