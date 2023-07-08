
/datum/action/cooldown/necro/charge/lunge
	name = "Lunge"
	var/datum/position/cached_pixels

/datum/action/cooldown/necro/charge/lunge/Activate(atom/target_atom)
	. = ..()
	//Do a chargeup animation
	var/mob/living/M = owner
	M.face_atom(get_turf(target_atom))
	var/datum/position/pixel_offset = new ((owner.x - target_atom.x), (owner.y - target_atom.y))
	pixel_offset.x *= -24
	pixel_offset.y *= -24
	cached_pixels = new (owner.pixel_x, owner.pixel_y)
	animate(owner, pixel_x = owner.pixel_x + pixel_offset.x, pixel_y = owner.pixel_y + pixel_offset.y, time = charge_delay, easing = BACK_EASING)

/datum/action/cooldown/necro/charge/lunge/do_charge(mob/living/carbon/human/necromorph/charger, atom/target_atom)
	animate(owner, pixel_y = cached_pixels.y, pixel_x = cached_pixels.x, time = 0.5 SECONDS, easing = BACK_EASING)
	cached_pixels = null
	. = ..()
