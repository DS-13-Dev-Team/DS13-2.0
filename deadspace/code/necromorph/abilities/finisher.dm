/* This is a finisher, it's supposed to be used against vulnurable survivors that are incapable of resisting the onslaught of necromorphs*/


	/// Every second the target hasn't broken out of the finisher grapple, this amount of damage is dealt to the cranium
#define FINISHER_DAMAGE_PER_SECOND 50
/datum/action/cooldown/necro/finisher
	name = "finisher"
	desc = "Allows you to deal extraordinary amounts of damage to weakened humans, guarantees death of its victims upon completion."
	cooldown_time = 2 SECONDS
	click_to_activate = TRUE
	/// Delay before the finisher does a charge towards its target to force a grapple
	var/charge_delay = 2 SECONDS
	/// The maximum amount of time we're delaying chargeing the target for a finisher
	var/charge_time = 3 SECONDS
	/// Initial damage dealt to the target's head when starting the finisher
	var/charge_damage = 30
	/// If the victim breaks out of the finisher clutches
	var/finisher_stagger = 3 SECONDS
	/// If the current move is being triggered by us or not
	var/actively_moving = FALSE
	var/valid_steps_taken = 0
	var/speed_per_step = 0.50
	var/max_steps_buildup = 2
	var/atom/target_atom
	/// How long the execution is going to take compared to world.time
	var/finisher_time = 3 SECONDS
	//How long the animation to initiate a finisher grapple
	var/exegrab_anim = 0.5 SECONDS
	//How long the animation to finish actually takes
	var/exe_anim = 1 SECONDS

/datum/action/cooldown/necro/finisher/PreActivate(atom/target)
	var/turf/Tr = get_turf(target)
	if(!Tr)
		to_chat(owner, span_notice("You must target a human to finish them!"))
		return FALSE
	if(!ishuman(target))
		for(var/mob/living/carbon/human/hummie in view(1, Tr))
			if(!isnecromorph(hummie))
				target = hummie
				break
	if(target == owner || isnecromorph(target))
		to_chat(owner, span_notice("You can't peform a finisher on a necromorph!"))
		return FALSE

	target_atom = target

	if(isturf(target))
		RegisterSignal(target, COMSIG_ATOM_ENTERED, PROC_REF(on_target_loc_entered))
	else
		var/static/list/loc_connections = list(
			COMSIG_ATOM_ENTERED = PROC_REF(on_target_loc_entered),
		)
		AddComponent(/datum/component/connect_loc_behalf, target, loc_connections)

	return ..()

/datum/action/cooldown/necro/finisher/Activate(atom/target)
	. = TRUE
	// Start pre-cooldown so that the ability can't come up while the finisher is happening
	StartCooldown(charge_time+charge_delay+1)
	addtimer(CALLBACK(src, PROC_REF(do_charge)), charge_delay)

/datum/action/cooldown/necro/finisher/proc/do_charge()
	var/mob/living/carbon/human/necromorph/finisher = owner

	actively_moving = FALSE
	finisher.charging = TRUE
	RegisterSignal(finisher, COMSIG_MOVABLE_BUMP, PROC_REF(on_bump))
	RegisterSignal(finisher, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_move))
	RegisterSignal(finisher, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
	finisher.setDir(get_dir(finisher, target_atom))
	do_rush_indicator(target_atom)

	var/datum/move_loop/new_loop = SSmove_manager.move_towards(finisher, target_atom, priority = MOVEMENT_ABOVE_SPACE_PRIORITY)
	if(!new_loop)
		UnregisterSignal(finisher, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOVABLE_MOVED))
		return
	RegisterSignal(new_loop, COMSIG_MOVELOOP_PREPROCESS_CHECK, PROC_REF(pre_move))
	RegisterSignal(new_loop, COMSIG_MOVELOOP_POSTPROCESS, PROC_REF(post_move))
	RegisterSignal(new_loop, COMSIG_MOVELOOP_STOP, PROC_REF(charge_end))
	RegisterSignal(finisher, COMSIG_MOB_STATCHANGE, PROC_REF(stat_changed))
	RegisterSignal(finisher, COMSIG_LIVING_UPDATED_RESTING, PROC_REF(update_resting))

	SEND_SIGNAL(finisher, COMSIG_STARTED_CHARGE)

/datum/action/cooldown/necro/finisher/proc/on_target_loc_entered(atom/loc, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER
	if(arrived != owner)
		return
	on_bump(owner, target_atom)

/datum/action/cooldown/necro/finisher/proc/pre_move(datum)
	SIGNAL_HANDLER
	actively_moving = TRUE

/datum/action/cooldown/necro/finisher/proc/post_move(datum)
	SIGNAL_HANDLER
	actively_moving = FALSE

/datum/action/cooldown/necro/finisher/proc/charge_end(datum/move_loop/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/necromorph/finisher = source.moving
	UnregisterSignal(finisher, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOVABLE_MOVED, COMSIG_MOB_STATCHANGE, COMSIG_LIVING_UPDATED_RESTING))
	finisher.charging = FALSE
	finisher.remove_movespeed_modifier(/datum/movespeed_modifier/necro_charge)
	StartCooldown()
	SEND_SIGNAL(owner, COMSIG_FINISHED_CHARGE)

	qdel(GetComponent(/datum/component/connect_loc_behalf))
	target_atom = null

/datum/action/cooldown/necro/finisher/proc/stat_changed(mob/source, new_stat, old_stat)
	SIGNAL_HANDLER
	if(new_stat > CONSCIOUS)
		SSmove_manager.stop_looping(owner)

/datum/action/cooldown/necro/finisher/proc/do_rush_indicator(atom/charge_target)
	return

/datum/action/cooldown/necro/finisher/proc/on_move(atom/source, atom/new_loc)
	SIGNAL_HANDLER
	if(!actively_moving)
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/action/cooldown/necro/finisher/proc/on_moved(atom/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/necromorph/finisher = source
	if(++valid_steps_taken <= max_steps_buildup)
		finisher.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/necro_charge, TRUE, -CHARGE_SPEED(src))

	//Light shake with each step
	shake_camera(source, 1.5, 0.5)

	return

/datum/action/cooldown/necro/finisher/proc/on_bump(atom/movable/source, atom/target)
	SIGNAL_HANDLER
	if(ismob(target) || target.uses_integrity)
		hit_target(source, target)
	SSmove_manager.stop_looping(owner)

/datum/action/cooldown/necro/finisher/proc/hit_target(mob/living/carbon/human/necromorph/source, mob/living/target)
	target.attack_necromorph(source, dealt_damage = charge_damage)
	if(isliving(target))
		if(ishuman(target))
			var/mob/living/carbon/human/human_target = target
			if(human_target.check_shields(source, 0, "the [source.name]", attack_type = LEAP_ATTACK))
				source.Stun(6)
				shake_camera(source, 4, 3)
				shake_camera(target, 2, 1)
				return
		///? Do a grab
		target.set_pulledby(source)
		target.setGrabState(GRAB_AGGRESSIVE)
		shake_camera(target, 4, 3)
		shake_camera(source, 2, 3)
		target.visible_message("<span class='danger'>[source] clasps [target] in its grasp! Teeth ripping into the base of [target]'s neck!</span>", "<span class='userdanger'>[source] clasps you in its arms! You feel a sharp pain coming from your neck as [source] digs in!</span>")
		RegisterSignal(target, COMSIG_LIVING_START_PULL, PROC_REF(do_finisher))
	else
		source.visible_message(span_danger("[source] smashes into [target]!"))
		shake_camera(source, 4, 3)
		source.Stun(6)
	///? Finisher deals progressive damage
/datum/action/cooldown/necro/finisher/proc/do_finisher(mob/living/carbon/human/target, mob/living/carbon/human/necromorph/source, delta_time)
	if(target.pulledby.grab_state == GRAB_AGGRESSIVE)
		var/finisher_end = world.time + finisher_time
		var/obj/item/bodypart/target_head = target.get_bodypart(BODY_ZONE_HEAD)
		if(world.time < finisher_end && target.stat != DEAD)
			target.apply_damage(FINISHER_DAMAGE_PER_SECOND * delta_time, BRUTE, target_head)
			///? do exegrab_anim to grab
			do_finisher_indicator(source, target)
			return
		///? do exe_anim to kill off the target
		if(world.time >= finisher_end && target.stat != DEAD)
			target.apply_damage(400, BRUTE, target_head)
	else
		shake_camera(source, 4, 3)
		target.visible_message("<span class='danger'>[target] writhes out of the grasp by [source]! [source] has lost its footing!</span>", "<span class='userdanger'>You wriggle out of [source]'s restraint! Your neck relaxes as teeth of [source] are no longer in.</span>")
		source.Stun(6)
		UnregisterSignal(source, COMSIG_LIVING_START_PULL)

/datum/action/cooldown/necro/finisher/proc/do_finisher_indicator(atom/finisher_source, atom/finish_target)
	return

/datum/action/cooldown/necro/finisher/proc/update_resting(atom/movable/source, resting)
	SIGNAL_HANDLER
	if(resting)
		SSmove_manager.stop_looping(source)
