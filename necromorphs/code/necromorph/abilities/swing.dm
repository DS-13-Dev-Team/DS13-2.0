/datum/action/cooldown/necro/swing
	name = "Swing"
	desc = "Swinging."
	cooldown_time = 5 SECONDS
	click_to_activate = TRUE
	var/swing_time = 1.5 SECONDS
	var/angle = 150
	var/range = 3
	var/visual_type = /obj/effect/temp_visual/swing
	var/hitsound = 'sound/weapons/slice.ogg'
	var/damage = 10
	var/knockdown_time = 2 SECONDS

/datum/action/cooldown/necro/swing/Activate(atom/target)
	. = TRUE
	owner.face_atom(target)

	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, src)

	var/turf/our_loc = get_turf(owner)
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

	StartCooldown()

	INVOKE_ASYNC(src, PROC_REF(execute_swing), stages)

/datum/action/cooldown/necro/swing/proc/execute_swing(list/list/stages)
	var/sleep_time = swing_time/length(stages)
	var/turf/our_loc = get_turf(owner)

	var/obj/effect/temp_visual/swing/effect = new visual_type(our_loc, swing_time, angle)
	for(var/list/stage as anything in stages)
		var/list/to_check = stage.Copy()
		while(length(to_check))
			var/turf/turf_to_check = to_check[1]
			var/list/line = get_line(our_loc, turf_to_check)
			to_check -= line
			var/turf/previous_turf = our_loc
			for(var/turf/T as anything in line)
				if(!T.CanPass(effect, get_dir(previous_turf, T)))
					break
				line -= T
				previous_turf = T

			stage -= line

		for(var/turf/T as anything in stage)
			hit_turf(T)

		sleep(sleep_time)

	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, src)

/datum/action/cooldown/necro/swing/proc/hit_turf(turf/T)
	for(var/mob/living/L in T)
		hit_mob(L)

/datum/action/cooldown/necro/swing/proc/hit_mob(mob/living/L)
	//Shouldn't happen, but who knows
	if(L == owner)
		return

	L.Knockdown(knockdown_time)
	L.apply_damage(damage, BRUTE, owner.zone_selected)
	playsound(L, hitsound, VOLUME_MID, TRUE)
	return TRUE

/obj/effect/temp_visual/swing
	name = "tentacle"
	icon = 'necromorphs/icons/necromorphs/swinging_limbs.dmi'
	icon_state = "harvester_tentacle"
	randomdir = FALSE
	pixel_x = -64
	pixel_y = -64

/obj/effect/temp_visual/swing/Initialize(mapload, duration, angle)
	src.duration = duration
	. = ..()
	var/matrix/new_matrix = matrix()
	new_matrix.Turn(-angle)
	animate(src, duration, transform = new_matrix)
