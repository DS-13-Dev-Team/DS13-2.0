/datum/component/swing
	var/atom/target
	var/swing_time = 1.5 SECONDS
	var/angle = 150
	var/range = 3
	var/visual_type = /obj/effect/temp_visual/swing
	var/obj/effect/temp_visual/visual_effect
	var/swing_direction
	var/datum/position/offset = new(0, 0)
	var/hitsound = 'sound/weapons/slice.ogg'
	var/damage = 10
	var/knockdown_time = 2 SECONDS

/datum/component/swing/Initialize(atom/target)
	. = ..()
	src.target = target
	INVOKE_ASYNC(src, PROC_REF(start))

/datum/component/swing/proc/start()
	parent:face_atom(target)
	windup_animation()

	ADD_TRAIT(parent, TRAIT_IMMOBILIZED, src)

	var/turf/our_loc = get_turf(parent)
	target = get_turf(target)

	var/angle_to_target = ATAN2(target.x - our_loc.x, target.y - our_loc.y)
	var/smallest_angle = SIMPLIFY_DEGREES(angle_to_target - (angle / 2))
	var/biggest_angle = SIMPLIFY_DEGREES(angle_to_target + (angle / 2))

	var/list/list/stages[ROUND_UP(angle/30)]

	for(var/i=1 to length(stages))
		stages[i] = list()

	for(var/turf/T as anything in RANGE_TURFS(range, our_loc)-our_loc)
		var/angle_to_turf = SIMPLIFY_DEGREES(ATAN2(T.x - our_loc.x, T.y - our_loc.y))
		if(angle_to_turf >= smallest_angle && angle_to_turf <= biggest_angle && get_dist_euclidian(our_loc, T) <= range)
			stages[ROUND_UP(SIMPLIFY_DEGREES(angle_to_turf - smallest_angle)/30)] += T

	INVOKE_ASYNC(src, PROC_REF(execute_swing), stages)

/datum/component/swing/proc/execute_swing(list/list/stages)
	var/sleep_time = swing_time/length(stages)
	var/turf/our_loc = get_turf(parent)

	setup_effect(our_loc)
	for(var/list/stage as anything in stages)
		var/list/to_check = stage.Copy()
		while(length(to_check))
			var/turf/turf_to_check = to_check[1]
			var/list/line = get_line(our_loc, turf_to_check)
			to_check -= line
			var/turf/previous_turf = our_loc
			for(var/turf/T as anything in line)
				if(!T.CanPass(visual_effect, get_dir(previous_turf, T)))
					break
				line -= T
				previous_turf = T

			stage -= line

		for(var/turf/T as anything in stage)
			hit_turf(T)

		sleep(sleep_time)

	REMOVE_TRAIT(parent, TRAIT_IMMOBILIZED, src)

/datum/component/swing/proc/windup_animation()
	return

/datum/component/swing/proc/setup_effect(turf/our_loc)
	visual_effect = new visual_type(our_loc, swing_time, angle, swing_direction)
	RegisterSignal(visual_effect, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_effect))

/datum/component/swing/proc/cleanup_effect()
	return

/datum/component/swing/proc/hit_turf(turf/T)
	for(var/mob/living/L in T)
		hit_mob(L)

/datum/component/swing/proc/hit_mob(mob/living/L)
	//Shouldn't happen, but who knows
	if(L == parent)
		return

	L.Knockdown(knockdown_time)
	L.apply_damage(damage, BRUTE, parent:zone_selected)
	playsound(L, hitsound, VOLUME_MID, TRUE)
	return TRUE

/obj/effect/temp_visual/swing
	name = "tentacle"
	icon = 'necromorphs/icons/necromorphs/swinging_limbs.dmi'
	icon_state = "harvester_tentacle"
	randomdir = FALSE

/obj/effect/temp_visual/swing/Initialize(mapload, duration, angle, swing_direction)
	src.duration = duration
	. = ..()
	var/turn_angle = angle * 1.1 * swing_direction
	animate(src, duration, transform = transform.Turn(turn_angle),  easing = CIRCULAR_EASING)

/atom/proc/can_swing(swing_type = /datum/component/swing)
	return TRUE

/mob/living/can_swing(swing_type = /datum/component/swing)
	if (incapacitated())
		return FALSE

	//This is a bit hackish
	if (istype(swing_type, /datum/component/swing/arm))
		//If this fails, then they have no arms to swing with
		if (!get_swing_dir())
			return FALSE

	. = ..()

/atom/proc/swing_attack(swing_type = /datum/component/swing, atom/target)
	if (!can_swing(swing_type))
		return FALSE

	AddComponent(swing_type, target)
	return TRUE
