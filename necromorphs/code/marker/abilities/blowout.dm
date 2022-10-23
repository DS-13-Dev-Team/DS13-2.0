/datum/action/cooldown/necro/psy/blowout
	name = "Blowout"
	desc = "Destroys a target wall light, with an explosion of sparks."
	cost = 40

/datum/action/cooldown/necro/psy/blowout/PreActivate(obj/machinery/light/target, mob/camera/marker_signal/caller)
	if(!istype(target, /obj/machinery/light))
		return FALSE
	return ..()

/datum/action/cooldown/necro/psy/blowout/Activate(obj/machinery/light/target, mob/camera/marker_signal/caller)
	..()
	target.break_light_tube()
	return TRUE
