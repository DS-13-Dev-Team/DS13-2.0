/datum/action/cooldown/necro/psy/flicker_mass
	name = "Flicker, Mass"
	desc = "Causes all lights in an area to flicker"
	cost = 50
	cooldown_time = 10 SECONDS

/datum/action/cooldown/necro/psy/flicker_mass/Activate(turf/target, mob/camera/marker_signal/caller)
	target = get_turf(target)
	if(!target)
		return
	var/list/lights = list()
	for (var/obj/machinery/light/L in view(world.view, target))
		lights |= L

	var/area/A = get_area(target)
	for (var/obj/machinery/light/L in A)
		lights |= L

	for (var/obj/machinery/light/L as anything in lights)
		L.flicker()
	..()
	return TRUE
