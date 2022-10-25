/datum/action/cooldown/necro/psy/flicker
	name = "Meddle"
	desc = "A context sensitive spell which does different things depending on the target. Interfaces with machines, moves items, messes with computers and office appliances."
	cost = 10

/datum/action/cooldown/necro/psy/flicker/PreActivate(obj/target, mob/camera/marker_signal/caller)
	if(isobj(target))
		return FALSE
	return ..()

/datum/action/cooldown/necro/psy/flicker/Activate(obj/target, mob/camera/marker_signal/caller)
	..()
	target.meddle_act(caller)
	return TRUE

#define SHAKE_ANIMATION_OFFSET 4

/obj/proc/meddle_act(mob/user)
	var/direction = prob(50) ? -1 : 1
	animate(src, pixel_x = pixel_x + SHAKE_ANIMATION_OFFSET * direction, time = 1, easing = QUAD_EASING | EASE_OUT, flags = ANIMATION_PARALLEL)
	animate(pixel_x = pixel_x - (SHAKE_ANIMATION_OFFSET * 2 * direction), time = 1)
	animate(pixel_x = pixel_x + SHAKE_ANIMATION_OFFSET * direction, time = 1, easing = QUAD_EASING | EASE_IN)

#undef SHAKE_ANIMATION_OFFSET
