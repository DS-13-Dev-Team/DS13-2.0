/mob/can_see_marker()
	. = list()
	for(var/turf/T in view(src))
		. += T
