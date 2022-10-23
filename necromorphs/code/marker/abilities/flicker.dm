/datum/action/cooldown/necro/psy/flicker
	name = "Flicker"
	desc = "Causes a targeted light to flicker."
	cost = 10

/datum/action/cooldown/necro/psy/flicker/PreActivate(obj/machinery/light/target, mob/camera/marker_signal/caller)
	if(!istype(target, /obj/machinery/light))
		return FALSE
	return ..()

/datum/action/cooldown/necro/psy/flicker/Activate(obj/machinery/light/target, mob/camera/marker_signal/caller)
	..()
	target.flicker()
	return TRUE
