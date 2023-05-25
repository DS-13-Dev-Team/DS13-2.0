
//A swing is an area-of-effect melee attack which strikes in a multistage cone, hitting each subcone in succession over some time period
/datum/component/swing

	var/status
	var/mob/living/user
	var/power = 1


	var/started_at
	var/stopped_at

	var/ongoing_timer

	var/atom/source
	var/datum/position/target_direction
	var/angle
	var/range
	var/windup
	var/effect_type
	var/damage
	var/damage_flags
	var/stages
	var/swing_direction
	var/cooldown = 1 SECOND
	var/duration = 1 SECOND



	//Authortime
	//------------------
	//After the attack finishes, leave the effect there for this time before deleting it
	var/effect_cleanup_delay = 	0.75 SECONDS

	var/hitsound = 'sound/weapons/slice.ogg'

	//IF true, this attack hits where the user is aiming
	//Default behaviour targets a random bodypart
	var/precise = TRUE


	var/obj/effect/effect/swing/effect
	var/current_stage
	var/list/cones
	var/rotation_step
	var/step_delay

	var/progress

	var/raytrace = TRUE



/datum/component/swing/New(atom/user, atom/source, atom/target, angle = 90, range = 3, duration = 1 SECOND, windup = 0, cooldown = 0,  effect_type, damage = 1, damage_flags = 0, stages = 8, swing_direction = CLOCKWISE)
	.=..()
	if (isliving(user))
		src.user = user

	//Target could be an atom to aim at, or a direction to swing in
	if (isatom(target))
		if ((get_turf(source) == get_turf(target)))
			//If source and target are on the same turf, we cant aim at the target
			target_direction = NewFromDir(user.dir)
		else
			target_direction = DirectionBetween(parent, target)
			if (src.user)
				src.user.face_atom(target)
	else
		target_direction = NewFromDir(target)

	if (!source)
		src.source = get_turf(parent)

	else
		src.source = source
	src.angle = angle
	src.range = range
	src.duration = duration
	src.windup = windup
	src.cooldown = cooldown
	src.effect_type = effect_type
	src.damage = damage
	src.damage_flags = damage_flags
	src.stages = stages
	src.swing_direction = swing_direction
	INVOKE_ASYNC(src, .proc/start)


/datum/component/swing/Destroy()
	target_direction = null
	.=..()

/datum/component/swing/proc/start()
	started_at	=	world.time
	windup_animation()

	//Alright lets get our cone
	var/list/cones = get_multistage_cone(source, target_direction, range, angle, stages, swing_direction)

	//Lets correct the number of stages now, it may be less than originally specified
	stages = cones.len


	//How long are we going to sleep between each stage?
	step_delay = duration / stages

	setup_effect()



	//Alright lets begin!
	var/continue_swing = TRUE
	for (current_stage in 1 to stages)
		var/list/cone = cones[current_stage]

		for (var/turf/T as anything in cone)
			//debug_mark_turf(T)
			continue_swing = hit_turf(T)
			if (!continue_swing)
				interrupt_effect()
				effect.shake_animation(30)
				break //Something stopped us!
		if (!continue_swing)
			break
		sleep(step_delay)

	stop()


/datum/component/swing/proc/windup_animation()
	sleep(windup)


/datum/component/swing/proc/get_effect_starting_direction()
	return target_direction.Turn((angle*0.6)*(-1 * swing_direction))


/datum/component/swing/proc/setup_effect()
	rotation_step = angle / stages

	var/turn_angle = angle * 1.1 * swing_direction	//We want to overshoot a little for dramatic effect


	var/datum/position/starting_direction = get_effect_starting_direction()

	//TODO: Create the arm effect
	effect = new effect_type(get_turf(source), source, starting_direction.Rotation())
	starting_direction = null
	var/atom/A = parent
	if (effect.inherit_order)
		effect.plane = A.plane
		effect.layer = A.layer+0.1

	animate(effect, transform = effect.transform.Turn(turn_angle), time = duration, easing = CIRCULAR_EASING)


//The swing has stopped midway. But since animate technically jumps to the end, we can't just stop the animation and expect the
//swing effect to be stopped at the right place, it would be at the end.
//So instead we have to figure out where it should be, and put it there
/datum/component/swing/proc/interrupt_effect()
	//First of all, we figure out how far along we are from start to finish
	var/timepercent = current_stage / stages

	//Stop the ongoing animation
	animate(effect)

	//Get the direction it started at
	var/datum/position/starting_direction = get_effect_starting_direction()


	//Figure out how far it should be rotated, and do so
	var/turn_angle = angle * 1.1 * swing_direction * timepercent
	starting_direction.SelfTurn(turn_angle*0.8)	//We'll do 80% of this instantly, and animate the last 20%


	//Setup the transform
	var/matrix/M = starting_direction.Rotation()
	starting_direction = null
	M.Scale(1)

	//And apply it
	effect.transform = M

	//Now lastly, lets animate that last 20%
	animate(effect, transform = effect.transform.Turn(turn_angle*0.2), time = step_delay)

/datum/component/swing/proc/cleanup_effect()
	QDEL_NULL(effect)



/*
	Hitting procs
*/
//Hits a turf and the mobs in it
/datum/component/swing/proc/hit_turf(turf/T)
	for (var/mob/living/L in T)
		hit_mob(L)

	//Return true to continue the swing
	return TRUE

/datum/component/swing/proc/hit_mob(mob/living/L)

	if (L == user)
		return FALSE
	var/atom/A = effect
	if (raytrace && !check_trajectory(L, source, pass_flags = A.pass_flags_self))
		return FALSE


	L.apply_damage(damage, damage_flags, def_zone = get_target_zone(L))
	playsound(L, hitsound, VOLUME_MID, 1)
	return TRUE

/datum/component/swing/proc/get_target_zone(mob/living/target)
	if (precise && user)
		return check_zone(user.zone_selected)
	else
		return ran_zone()


/datum/component/swing/proc/stop()
	deltimer(ongoing_timer)
	stopped_at = world.time
	spawn(effect_cleanup_delay)
		cleanup_effect()
	ongoing_timer = addtimer(CALLBACK(src, PROC_REF(finish_cooldown)), cooldown, TIMER_STOPPABLE)



/datum/component/swing/proc/finish_cooldown()
	deltimer(ongoing_timer)
	qdel(src)


/datum/component/swing/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed





/***********************
	Safety Checks
************************/
//Access Proc
/atom/proc/can_swing(swing_type = /datum/component/swing)

	var/datum/component/swing/E = GetComponents(swing_type)
	if(istype(E))
		if (E.stopped_at)
			to_chat(src, span_notice("[E] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
		else
			to_chat(src, span_notice("You're already swinging"))
		return FALSE

	return TRUE


/mob/living/can_swing(swing_type = /datum/component/swing)
	if (incapacitated())
		return FALSE

	//This is a bit hackish
	if (istype(swing_type, /datum/component/swing/arm))
		//If this fails, then they have no arms to swing with
		if (!get_swing_dir())
			return FALSE
	.=..()


/atom/proc/swing_attack(swing_type = /datum/component/swing, atom/source, atom/target, angle = 90, range = 3, duration = 1 SECOND, windup = 0, cooldown = 0,  effect_type, damage = 1, damage_flags = 0, stages = 8, swing_direction = CLOCKWISE)
	if (!can_swing(swing_type))
		return FALSE

	AddComponent(src, swing_type, source, target, angle, range, duration, windup, cooldown, effect_type, damage, damage_flags, stages, swing_direction)
	return TRUE



//Visuals


/obj/effect/effect/swing
	icon = 'necromorphs/icons/mob/necromorph/swinging_limbs.dmi'
	var/inherit_order = TRUE
	pass_flags = PASSMOB | PASSTABLE

/obj/effect/effect/swing/New(location, atom/holder, matrix/starting_rotation)
	//TODO: Make the effect move with the holder atom
	starting_rotation = starting_rotation.Scale(1)
	transform = starting_rotation
	pixel_x = holder.pixel_x
	pixel_y = holder.pixel_y
	.=..()
