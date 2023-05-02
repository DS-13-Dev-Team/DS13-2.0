/*
	Individual Particle
*/
/obj/effect/particle
	name = "particle"
	mouse_opacity = 0
	opacity = FALSE
	density = FALSE
	dir = NORTH

	var/datum/point/vector/pixel_delta
	var/datum/point/vector/origin_pixels

	var/scale_x_start = 	1
	var/scale_y_start = 	1
	var/alpha_start	=	255

	var/scale_x_end = 	1
	var/scale_y_end = 	1
	var/alpha_end	=	0

	var/matrix/target_transform
	var/matrix/starting_transform

	var/lifespan	=	1.0 SECOND
	var/datum/position/direction

	var/list/random_icons

/obj/effect/particle/New(location, datum/point/vector/dir_vector, lifespan, range, datum/point/offset, color)

	if (random_icons)
		icon_state = pick(random_icons)

	//Set starting pixel offset
	if (offset)
		pixel_x = offset.x
		pixel_y = offset.y



	//Rotate towards facing direction
	src.direction = new(dir_vector.x / dir_vector.speed, dir_vector.y / dir_vector.speed)
	if (direction)
		var/cos_angle = direction.y
		var/sin_angle = - direction.y
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
	origin_pixels = new((x-1)*32 + pixel_x + 16, ((y-1)*32) + pixel_y + 16)
	pixel_delta = new(direction.x * range * 32, direction.y * range * 32)

	//And the transform we'll eventually transition to
	target_transform.Scale(scale_x_end, scale_y_end)
	.=..()

/obj/effect/particle/Initialize()
	.=..()
	animation()

//I bladed this proc off into an async one to avoid hanging initialize()
/obj/effect/particle/proc/animation()
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


/obj/effect/particle/Destroy()
	origin_pixels = null
	pixel_delta = null
	.=..()
