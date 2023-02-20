/datum/action/cooldown/necro/psy/scry
	name = "Scry"
	desc = "Reveals a targeted area in a 6 tile radius for a duration of 1 minute. Creates a spooky ethereal glow there too."
	button_icon_state = "scry"
	cost = 20
	click_through_static = TRUE

/datum/action/cooldown/necro/psy/scry/Activate(atom/target)
	var/mob/camera/marker_signal/caller = owner
	var/turf/target_turf = get_turf(target)
	if(target_turf)
		..()
		new /obj/effect/temp_visual/scry(target_turf, caller.marker.markernet)
		return TRUE

/obj/effect/temp_visual/scry
	anchored = TRUE
	light_color = "#ffff00"
	light_inner_range = 1
	light_outer_range = 4
	light_power = 1
	duration = 1 MINUTES

/obj/effect/temp_visual/scry/Initialize(mapload, datum/markernet/visual_net)
	. = ..()
	if(visual_net)
		visual_net.addVisionSource(src, VISION_SOURCE_RANGE)
	else
		return INITIALIZE_HINT_QDEL

/obj/effect/temp_visual/scry/can_see_marker()
	return RANGE_TURFS(6, src)
