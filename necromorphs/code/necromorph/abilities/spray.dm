
/datum/action/cooldown/necro/spray
	name = "Vomit"
	desc = "A close range attack that covers a large area for area denial."
	click_to_activate = TRUE

	var/angle = 100
	var/length = 2.5
	var/atom/target_atom

	var/stun = FALSE
	var/duration = 3 SECONDS
	var/windup = 1.8 SECONDS
	cooldown_time = 12 SECONDS

	var/list/affected_turfs = list()
	var/datum/position/direction

	var/affect_origin = FALSE	//If true, the origin turf is affected as well


	//Registry:
	var/datum/effect_system/spray/fx	//Particle system for chem particles
	var/fx_type = /datum/effect_system/spray


	var/particle_color = "#FFFFFF"

/datum/action/cooldown/necro/spray/Destroy(force, ...)
	QDEL_NULL(fx)
	. = ..()

/datum/action/cooldown/necro/spray/PreActivate(atom/target)
	if(owner.incapacitated())
		return FALSE

	var/mob/living/carbon/human/necromorph/N = owner
	N.play_necro_sound(SOUND_PAIN, VOLUME_MID, 3)
	N.shake_animation(30)
	addtimer(CALLBACK(src, PROC_REF(preactivation_proc)), 9)
	addtimer(CALLBACK(N, TYPE_PROC_REF(/mob/living/carbon/human/necromorph, play_necro_sound), SOUND_SHOUT_LONG, VOLUME_HIGH, 3), 18)
	owner.face_atom(target)
	target_atom = target
	. = ..()

/datum/action/cooldown/necro/spray/proc/preactivation_proc()
	var/mob/living/carbon/human/necromorph/N = owner
	N.play_necro_sound(SOUND_PAIN, VOLUME_HIGH, 3)
	N.shake_animation(30)

/datum/action/cooldown/necro/spray/Activate(atom/target)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(start)), windup)
	return TRUE

/datum/action/cooldown/necro/spray/proc/start()
	recalculate_cone()

	//Make sure we don't get double fx
	if (fx)
		QDEL_NULL(fx)

	//Lets create the chemspray fx
	fx = new fx_type
	fx.attach(owner)
	fx.set_up(location = owner, direction = direction, angle = angle, length = length)
	fx.particle_color = particle_color
	fx.start()

	if (stun && isliving(owner))
		start_stun()
		addtimer(CALLBACK(src, PROC_REF(end_stun)), duration)

/datum/action/cooldown/necro/spray/proc/start_stun()
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, src)

/datum/action/cooldown/necro/spray/proc/end_stun()
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, src)

/datum/action/cooldown/necro/spray/proc/set_target(datum/new_target, target_object)
	target_atom = new_target
	if (target_object)
		target = target_object
		if (isliving(owner))
			owner.face_atom(target_object)

	//Only recalc if this is set
	if (angle)
		recalculate_cone()

/datum/action/cooldown/necro/spray/proc/recalculate_cone()
	var/list/previous_turfs = affected_turfs.Copy()
	affected_turfs = list()
	affected_turfs = get_view_cone(owner, target_atom, length, angle)

	//Don't remove this if we're going to affect the origin
	if (!affect_origin)
		affected_turfs -= get_turf(owner)

	//We will do raytrace testing to see which turfs we actually have line of sight to
	var/list/new_turfs = affected_turfs - previous_turfs
	if (LAZYLEN(new_turfs))
		//Check trajectory returns an assoc list with true/false as value of whether the tile is reachable
		new_turfs = check_trajectory_mass(new_turfs, owner)
		for (var/turf in new_turfs)
			//If the value is false, LOS was blocked, so we remove it from affected turfs
			if (!new_turfs[turf])
				affected_turfs -= turf


	//If affecting origin, add this in, as it may or may not be already present
	if (affect_origin)
		affected_turfs |= get_turf(owner)

	if (fx)
		var/angle_to_target = get_angle(owner, target_atom)
		var/datum/point/vector/new_direction = new(_angle = angle_to_target, initial_increment = TRUE)
		fx.set_direction(new_direction)

/***********************
	Spray visual effect
************************/
/*
	Particle System
	Sprays particles in a cone
*/
/datum/effect_system/spray
	effect_type  = /obj/effect/particle_effect/spray
	var/duration = 3 SECONDS
	var/particles_per_tick = 3
	var/particle_color
	var/particle_lifetime = null	//Overrides lifetime on particles if nonzero
	var/datum/position/direction
	var/angle
	var/length
	var/randpixel = 12
	var/datum/point/base_offset	//A flat offset added to the starting position of all particles
	var/datum/point/relative_offset	//An offset that is multiplied by the aim direction before being added to the starting position
	var/datum/point/relative_offset_rotated //The above but with the rotation baked in

/datum/effect_system/spray/set_up(number = 3, cardinals_only = FALSE, location, direction, angle, length)
	. = ..()
	src.direction = direction
	src.angle = angle
	src.length = length
	if (particle_lifetime)
		particle_lifetime *= length

/datum/effect_system/spray/proc/set_direction(datum/point/vector/new_direction)
	if (!direction)
		direction = new(new_direction.x, new_direction.y)
	else
		direction.x = new_direction.x
		direction.y = new_direction.y

	if (relative_offset)
		var/datum/point/N = new /datum/point(0, 1)
		var/angle = (Atan2(direction.y, direction.x) - Atan2(N.y, N.x))
		relative_offset_rotated = relative_offset * matrix().Turn(angle)

/datum/effect_system/spray/start()
	//A duration of zero lasts until manually stopped
	if (duration > 0)
		addtimer(CALLBACK(src, PROC_REF(end)), duration)

	START_PROCESSING(SSfastprocess, src)
	//tick()

/datum/effect_system/spray/proc/end()
	qdel(src)

/datum/effect_system/spray/process()
	if(QDELETED(src))
		return

	for (var/i in 1 to particles_per_tick)
		generate_effect()

/datum/effect_system/spray/generate_effect()
	if(holder)
		location = get_turf(holder)
	var/datum/point/offset = new /datum/point(rand_between(-randpixel, randpixel), rand_between(-randpixel, randpixel))
	if (base_offset)
		offset.x += base_offset.x
		offset.y += base_offset.y

	if (relative_offset_rotated)
		offset.x += relative_offset_rotated.x
		offset.y += relative_offset_rotated.y

	var/particle_angle = rand_between(0, angle) - angle*0.5	//We subtract half the angle to centre it
	var/dir_angle = angle2dir(particle_angle)
	var/turf/dir_step = get_step(holder, dir_angle)
	var/datum/point/dir_effect = new /datum/point(holder.x - dir_step.x, holder.y - dir_step.y)
	var/obj/effect/effect = new effect_type(location, dir_effect, particle_lifetime, length, offset, particle_color)

	return effect

/obj/effect/particle_effect/spray
	name = "spray"
	icon = 'necromorphs/icons/effects/effects.dmi'
	icon_state = "spray"
	color = "#FF0000"

	var/datum/point/pixel_delta
	var/datum/point/origin_pixels

	var/scale_x_start = 	1
	var/scale_y_start = 	1
	var/alpha_start	=	255

	var/scale_x_end = 	2
	var/scale_y_end = 	4
	var/alpha_end	=	0

	var/matrix/target_transform
	var/matrix/starting_transform

	var/lifespan	=	0.25 SECOND
	var/datum/position/direction

	var/list/random_icons

/obj/effect/particle_effect/spray/New(loc, datum/position/direction, lifespan, range, datum/position/offset, color)

	if (random_icons)
		icon_state = pick(random_icons)

	//Set starting pixel offset
	if (offset)
		pixel_x = offset.x
		pixel_y = offset.y



	//Rotate towards facing direction
	src.direction = direction
	if (direction)
		var/datum/position/v = new /datum/position(0, 1)
		var/cos_angle = direction.x * v.x + y * v.y
		var/sin_angle = direction.x * v.y - y * v.x
		starting_transform = matrix(cos_angle, sin_angle, 0, -sin_angle, cos_angle, 0)
	else
		starting_transform = matrix()
	target_transform = matrix(starting_transform)

	if (color)
		src.color = color

	//Set starting scale
	starting_transform.Scale(scale_x_start, scale_y_start)

	//Setup expiration
	if (lifespan)
		//Lifespan will already be multiplied by range if one was passed in
		//If null is passed in, we use our own
		src.lifespan = lifespan
	else
		src.lifespan *= range
	QDEL_IN(src, src.lifespan)

	//Lets calculate the destination pixel_loc
	origin_pixels = new /datum/point((x-1) * 32 + pixel_x + 16, (y-1) * 32 + pixel_y + 16)
	pixel_delta = direction
	pixel_delta.x *= range * 32
	pixel_delta.y *= range * 32

	//And the transform we'll eventually transition to
	target_transform.Scale(scale_x_end, scale_y_end)

	.=..()

/obj/effect/particle_effect/spray/Initialize(mapload)
	. = ..()
	animation()

//I bladed this proc off into an async one to avoid hanging initialize()
/obj/effect/particle_effect/spray/proc/animation()
	set waitfor = FALSE
	//Lets start the animation!
	animate(src, transform = starting_transform, time = 0)
	animate(
	pixel_x = pixel_x+pixel_delta.x,
	pixel_y = pixel_y+pixel_delta.y,
	transform = target_transform,
	alpha = alpha_end,
	time = lifespan,
	flags = ANIMATION_LINEAR_TRANSFORM)
