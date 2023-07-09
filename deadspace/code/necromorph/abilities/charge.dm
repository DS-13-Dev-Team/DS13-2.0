/datum/action/cooldown/necro/charge
	name = "Charge"
	desc = "Allows you to charge at a chosen position."
	cooldown_time = 1.5 SECONDS
	click_to_activate = TRUE
	/// Delay before the charge actually occurs
	var/charge_delay = 0.3 SECONDS
	/// The maximum amount of time we can charge
	var/charge_time = 10 SECONDS
	/// The sleep time before moving in deciseconds while charging
	var/charge_speed = 4
	/// The damage the charger does when bumping into something
	var/charge_damage = 30
	/// If the current move is being triggered by us or not
	var/actively_moving = FALSE
	var/valid_steps_taken = 0
	var/speed_per_step = 0.15
	var/max_steps_buildup = 14

	var/atom/target_atom

/datum/action/cooldown/necro/charge/PreActivate(atom/target)
	var/turf/T = get_turf(target)
	if(!T)
		return FALSE
	if(!ishuman(target_atom))
		for(var/mob/living/carbon/human/hummie in view(1, T))
			if(!isnecromorph(hummie))
				target_atom = hummie
				break
	if(target_atom == owner || isnecromorph(target_atom))
		return FALSE
	src.target_atom = target_atom
	. = ..()

/datum/action/cooldown/necro/charge/Activate(atom/target)
	. = TRUE
	// Start pre-cooldown so that the ability can't come up while the charge is happening
	StartCooldown(charge_time+charge_delay+1)
	addtimer(CALLBACK(src, PROC_REF(do_charge), owner), charge_delay)

/datum/action/cooldown/necro/charge/proc/do_charge(mob/living/carbon/human/necromorph/charger)
	actively_moving = FALSE
	charger.charging = TRUE
	SEND_SIGNAL(charger, COMSIG_STARTED_CHARGE)
	RegisterSignal(charger, COMSIG_MOVABLE_BUMP, PROC_REF(on_bump))
	RegisterSignal(charger, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_move))
	RegisterSignal(charger, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
	charger.setDir(get_dir(charger, target_atom))
	do_charge_indicator(target_atom)

	var/datum/move_loop/new_loop = SSmove_manager.move_towards(charger, target_atom, priority = MOVEMENT_ABOVE_SPACE_PRIORITY)
	if(!new_loop)
		return
	RegisterSignal(new_loop, COMSIG_MOVELOOP_PREPROCESS_CHECK, PROC_REF(pre_move))
	RegisterSignal(new_loop, COMSIG_MOVELOOP_POSTPROCESS, PROC_REF(post_move))
	RegisterSignal(new_loop, list(COMSIG_PARENT_QDELETING, COMSIG_MOVELOOP_STOP), PROC_REF(charge_end))
	RegisterSignal(charger, COMSIG_MOB_STATCHANGE, PROC_REF(stat_changed))
	RegisterSignal(charger, COMSIG_LIVING_UPDATED_RESTING, PROC_REF(update_resting))

/datum/action/cooldown/necro/charge/proc/pre_move(datum)
	SIGNAL_HANDLER
	actively_moving = TRUE

/datum/action/cooldown/necro/charge/proc/post_move(datum)
	SIGNAL_HANDLER
	actively_moving = FALSE

/datum/action/cooldown/necro/charge/proc/charge_end(datum/move_loop/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/necromorph/charger = source.moving
	UnregisterSignal(charger, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOVABLE_MOVED, COMSIG_MOB_STATCHANGE, COMSIG_LIVING_UPDATED_RESTING, COMSIG_MOVELOOP_STOP))
	charger.charging = FALSE
	charger.remove_movespeed_modifier(/datum/movespeed_modifier/necro_charge)
	SEND_SIGNAL(owner, COMSIG_FINISHED_CHARGE)
	actively_moving = FALSE
	StartCooldown()

//Called when we reach max time or range
//Drain the user's stamina?
/datum/action/cooldown/necro/charge/proc/stop_peter_out()
	if (isliving(owner))
		peter_out_effects()
	SSmove_manager.stop_looping(owner)

//Called when the charge reaches max time or range
/datum/action/cooldown/necro/charge/proc/peter_out_effects()
	return

/datum/action/cooldown/necro/charge/proc/stat_changed(mob/source, new_stat, old_stat)
	SIGNAL_HANDLER
	if(new_stat > CONSCIOUS)
		//This will cause the loop to qdel, triggering an end to our charging
		stop_peter_out()

/datum/action/cooldown/necro/charge/proc/do_charge_indicator(atom/charge_target)
	return

/datum/action/cooldown/necro/charge/proc/on_move(atom/source, atom/new_loc)
	SIGNAL_HANDLER
	if(!actively_moving)
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/action/cooldown/necro/charge/proc/on_moved(atom/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/necromorph/charger = source
	if(++valid_steps_taken <= max_steps_buildup)
		charger.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/necro_charge, TRUE, -CHARGE_SPEED(src))

	//If we have entered the same turf as our target then it must have been nondense. Let's hit it
	if (source.loc == target_atom.loc || source.loc == target_atom)
		. = on_bump(source, target_atom)
	else
		//Light shake with each step
		shake_camera(source, 1.5, 0.5)

	return

/datum/action/cooldown/necro/charge/proc/on_bump(atom/movable/source, atom/target)
	SIGNAL_HANDLER
	if(ismob(target) || target.uses_integrity)
		hit_target(source, target)
	SSmove_manager.stop_looping(owner)

/datum/action/cooldown/necro/charge/proc/hit_target(mob/living/carbon/human/necromorph/source, mob/living/target)
	target.attack_necromorph(source, dealt_damage = charge_damage)
	if(isliving(target))
		if(ishuman(target))
			var/mob/living/carbon/human/human_target = target
			if(human_target.check_shields(source, 0, "the [source.name]", attack_type = LEAP_ATTACK))
				source.Stun(6)
				shake_camera(source, 4, 3)
				shake_camera(target, 2, 1)
				return
		shake_camera(target, 4, 3)
		shake_camera(source, 2, 3)
		target.visible_message("<span class='danger'>[source] slams into [target]!</span>", "<span class='userdanger'>[source] tramples you into the ground!</span>")
		target.Knockdown(6)
	else
		source.visible_message(span_danger("[source] smashes into [target]!"))
		shake_camera(source, 4, 3)
		source.Stun(6)

/datum/action/cooldown/necro/charge/proc/update_resting(atom/movable/source, resting)
	SIGNAL_HANDLER
	if(resting)
		SSmove_manager.stop_looping(source)
