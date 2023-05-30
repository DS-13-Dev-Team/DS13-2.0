/datum/action/cooldown/necro/corruption
	name = "Generic corruption placement ability"
	cooldown_time = 0.1 SECONDS
	click_to_activate = TRUE
	var/cost = 0
	var/image/template
	var/obj/structure/necromorph/place_structure = /obj/structure/necromorph
	var/marker_only = FALSE

/datum/action/cooldown/necro/corruption/New(Target, original, cooldown)
	..()
	name += " | Cost: [cost] bio"
	template = new /image/necromorph_subtype(initial(place_structure.icon), null, initial(place_structure.icon_state))
	template.pixel_x = initial(place_structure.base_pixel_x)
	template.pixel_y = initial(place_structure.base_pixel_y)

/datum/action/cooldown/necro/corruption/set_click_ability(mob/on_who)
	.=..()
	owner.mouse_move_intercept = src
	owner.client.images += template

/datum/action/cooldown/necro/corruption/unset_click_ability(mob/on_who, refund_cooldown)
	.=..()
	owner.mouse_move_intercept = null
	owner.client.images -= template
	template.loc = null

/datum/action/cooldown/necro/corruption/Activate(atom/target)
	var/mob/camera/marker_signal/signal = owner
	var/current_biomass = istype(signal, /mob/camera/marker_signal/marker) ? signal.marker.marker_biomass : signal.marker.signal_biomass
	if(current_biomass < cost)
		to_chat(signal, span_warning("Not enough biomass!"))
		return TRUE
	var/turf/target_turf = get_turf(target)
	if(!target_turf.necro_corrupted)
		to_chat(signal, span_warning("Turf isn't corrupted!"))
		return
	if(locate(/obj/structure/necromorph) in target_turf)
		to_chat(signal, span_warning("There is another structure on this turf!"))
		return
	for(var/atom/movable/movable as anything in target_turf)
		if(movable.density)
			to_chat(signal, span_warning("Turf is obstructed!"))
			return
	if(istype(signal, /mob/camera/marker_signal/marker))
		signal.marker.change_marker_biomass(-cost)
	else
		signal.marker.change_signal_biomass(-cost)
	var/obj/structure/necromorph/structure = new place_structure(target_turf, signal.marker)
	structure.dir = template.dir
	..()
	return TRUE

/datum/action/cooldown/necro/corruption/proc/mouse_movement_intercepted(atom/intercepted)
	var/turf/turf_loc = get_turf(intercepted)
	template.loc = turf_loc
	template.color = can_place(turf_loc) ? COLOR_GREEN : COLOR_RED

/datum/action/cooldown/necro/corruption/proc/can_place(turf/turf_loc)
	if(!turf_loc || turf_loc.density)
		return
	if(!turf_loc.necro_corrupted || locate(/obj/structure/necromorph) in turf_loc)
		return
	//Remove this loop if it causes too much lag when hovering over a pile of items
	for(var/atom/movable/movable as anything in turf_loc)
		if(movable.density)
			return
	return TRUE
