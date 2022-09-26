/datum/action/cooldown/necro/charge
	name = "Charge"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"
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
	/// Target dir we are moving to
	var/tmp/target_dir = NONE
	/// Dirs we are allowed to move during the charge
	var/tmp/target_dir_left = NONE
	var/tmp/target_dir_right = NONE

/datum/action/cooldown/necro/charge/New(Target, cooldown, delay, time, speed, damage)
	.=..()
	if(!isnull(delay))
		charge_delay = delay
	if(!isnull(time))
		charge_time = time
	if(!isnull(speed))
		charge_speed = speed
	if(!isnull(damage))
		charge_damage = damage

/datum/action/cooldown/necro/charge/Activate(atom/target_atom)
	// Start pre-cooldown so that the ability can't come up while the charge is happening
	StartCooldown(charge_time+charge_delay+1)
	do_charge(owner, target_atom)

/datum/action/cooldown/necro/charge/proc/do_charge(atom/movable/charger, atom/target_atom)
	if(!target_atom || target_atom == charger)
		return
	var/chargeturf = get_turf(target_atom)
	if(!chargeturf)
		return
	target_dir = get_dir(charger, chargeturf)
	target_dir_left = turn(target_dir, -90)
	target_dir_right = turn(target_dir, 90)

	actively_moving = FALSE
	SEND_SIGNAL(charger, COMSIG_STARTED_CHARGE)
	RegisterSignal(charger, COMSIG_MOVABLE_BUMP, .proc/on_bump)
	RegisterSignal(charger, COMSIG_MOVABLE_PRE_MOVE, .proc/on_move)
	RegisterSignal(charger, COMSIG_MOVABLE_MOVED, .proc/on_moved)
	charger.setDir(target_dir)
	charger.set_dir_on_move = FALSE
	do_charge_indicator(target_atom)

	SLEEP_CHECK_DEATH(charge_delay, charger)

	var/datum/move_loop/move/moving_loop = SSmove_manager.move(charger, target_dir, charge_speed, charge_time, priority = MOVEMENT_ABOVE_SPACE_PRIORITY)
	if(!moving_loop)
		return
	RegisterSignal(moving_loop, COMSIG_MOVELOOP_PREPROCESS_CHECK, .proc/pre_move)
	RegisterSignal(moving_loop, COMSIG_MOVELOOP_POSTPROCESS, .proc/post_move)
	RegisterSignal(moving_loop, COMSIG_PARENT_QDELETING, .proc/charge_end)
	if(ismob(charger))
		RegisterSignal(moving_loop, COMSIG_MOB_STATCHANGE, .proc/stat_changed)
		RegisterSignal(moving_loop, COMSIG_LIVING_UPDATED_RESTING, .proc/update_resting)

/datum/action/cooldown/necro/charge/proc/pre_move(datum)
	SIGNAL_HANDLER
	// If you sleep in Move() you deserve what's coming to you
	actively_moving = TRUE

/datum/action/cooldown/necro/charge/proc/post_move(datum)
	SIGNAL_HANDLER
	actively_moving = FALSE

/datum/action/cooldown/necro/charge/proc/charge_end(datum/move_loop/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/necromorph/charger = source.moving
	UnregisterSignal(charger, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOVABLE_MOVED, COMSIG_MOB_STATCHANGE, COMSIG_LIVING_UPDATED_RESTING))
	SEND_SIGNAL(owner, COMSIG_FINISHED_CHARGE)
	actively_moving = FALSE
	charger.set_dir_on_move = initial(charger.set_dir_on_move)
	StartCooldown()

/datum/action/cooldown/necro/charge/proc/stat_changed(mob/source, new_stat, old_stat)
	SIGNAL_HANDLER
	if(new_stat > CONSCIOUS)
		//This will cause the loop to qdel, triggering an end to our charging
		SSmove_manager.stop_looping(source)

/datum/action/cooldown/necro/charge/proc/do_charge_indicator(atom/charge_target)
	return

/datum/action/cooldown/necro/charge/proc/on_move(atom/source, atom/new_loc)
	SIGNAL_HANDLER
	var/loc_dir = get_dir(source, new_loc)
	if(!actively_moving && loc_dir != target_dir_left && loc_dir != target_dir_right)
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/action/cooldown/necro/charge/proc/on_moved(atom/source)
	SIGNAL_HANDLER
	return

/datum/action/cooldown/necro/charge/proc/on_bump(atom/movable/source, atom/target)
	SIGNAL_HANDLER
	// If we bump ourself (!?) or target doesn't block our movement we continue
	if(owner == target || !target.density)
		return
	if(ismob(target) || target.uses_integrity)
		hit_target(source, target)
	SSmove_manager.stop_looping(source)

/datum/action/cooldown/necro/charge/proc/hit_target(mob/living/carbon/necromorph/source, mob/living/target)
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
	if(resting)
		SSmove_manager.stop_looping(source)

/datum/action/cooldown/necro/charge/slasher
	cooldown_time = 12 SECONDS
	charge_delay = 1 SECONDS
	charge_time = 4 SECONDS

/datum/action/cooldown/necro/charge/slasher/do_charge_indicator(atom/charge_target)
	var/mob/living/carbon/necromorph/source = owner
	var/matrix/new_matrix = matrix(source.transform)
	var/shake_dir = pick(-1, 1)
	new_matrix.Turn(16*shake_dir)
	animate(source, transform = new_matrix, pixel_x = source.pixel_x + 5*shake_dir, time = 1)
	spawn(1)
		animate(source, transform = matrix(), pixel_x = source.pixel_x-5*shake_dir, time = 9, easing = ELASTIC_EASING)
	source.play_necro_sound(SOUND_SHOUT_LONG, VOLUME_HIGH, TRUE, 3)
