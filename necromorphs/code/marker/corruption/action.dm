/datum/action/cooldown/necro/corruption
	name = "Generic corruption placement ability"
	cooldown_time = 0.1 SECONDS
	click_to_activate = TRUE
	var/cost = 0
	var/image/template
	var/obj/structure/necromorph/place_structure = /obj/structure/necromorph
	var/marker_only = FALSE
	var/required_marker_status = SIGNAL_ABILITY_PRE_ACTIVATION|SIGNAL_ABILITY_POST_ACTIVATION

/datum/action/cooldown/necro/corruption/New(Target, original, cooldown)
	..()
	template = new /image/necromorph_subtype(initial(place_structure.icon), null, initial(place_structure.icon_state))
	template.layer = ABOVE_ALL_MOB_LAYER
	template.plane = ABOVE_LIGHTING_PLANE
	template.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	template.pixel_x = initial(place_structure.base_pixel_x)
	template.pixel_y = initial(place_structure.base_pixel_y)

/datum/action/cooldown/necro/corruption/Trigger(trigger_flags, atom/target)
	if(!IsAvailable())
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_ACTION_TRIGGER, src) & COMPONENT_ACTION_BLOCK_TRIGGER)
		return FALSE
	if(!owner)
		return FALSE
	if(click_to_activate)
		if(target)
			// For automatic / mob handling
			return InterceptClickOn(owner, null, target)
		if(owner.click_intercept == src)
			owner.click_intercept = null
			owner.client.images -= template
			if(owner.mouse_move_intercept == src)
				owner.mouse_move_intercept = null
		else
			owner.click_intercept = src
			template.loc = null
			owner.client.images += template
			owner.mouse_move_intercept = src
		for(var/datum/action/cooldown/ability in owner.actions)
			ability.UpdateButtons()
		return TRUE
	return PreActivate(owner)

/datum/action/cooldown/necro/corruption/InterceptClickOn(mob/living/caller, params, atom/target)
	if(!IsAvailable())
		return FALSE
	if(!target)
		return FALSE
	PreActivate(target)
	caller.click_intercept = null
	caller.client.images -= template
	if(caller.mouse_move_intercept == src)
		caller.mouse_move_intercept = null
	return TRUE

/datum/action/cooldown/necro/corruption/Activate(atom/target)
	var/mob/camera/marker_signal/signal = owner
	var/current_biomass = ismarkereye(signal) ? signal.marker.biomass : signal.marker.signal_biomass
	if(current_biomass < cost)
		to_chat(signal, span_warning("Not enough biomass!"))
		return
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
	if(ismarkereye(signal))
		signal.marker.biomass -= cost
	else
		signal.marker.signal_biomass -= cost
	new place_structure(target_turf, signal.marker)
	return TRUE

/datum/action/cooldown/necro/corruption/UpdateButton(atom/movable/screen/movable/action_button/button, status_only = FALSE, force = FALSE)
	if(!button)
		return
	if(!status_only)
		button.name = name
		button.desc = desc
		if(owner?.hud_used && background_icon_state == ACTION_BUTTON_DEFAULT_BACKGROUND)
			var/list/settings = owner.hud_used.get_action_buttons_icons()
			if(button.icon != settings["bg_icon"])
				button.icon = settings["bg_icon"]
			if(button.icon_state != settings["bg_state"])
				button.icon_state = settings["bg_state"]
		else
			if(button.icon != button_icon)
				button.icon = button_icon
			if(button.icon_state != background_icon_state)
				button.icon_state = background_icon_state

		ApplyIcon(button, force)

	if(!IsAvailable())
		button.color = transparent_when_unavailable ? rgb(128,0,0,128) : rgb(128,0,0)
	else
		button.color = rgb(255,255,255,255)
		. = TRUE
	var/time_left = max(next_use_time - world.time, 0)
	if(text_cooldown)
		button.maptext = MAPTEXT("<b>[round(time_left/10, 0.1)]</b>")
	if(!owner || time_left == 0)
		button.maptext = ""
	if(IsAvailable() && owner.click_intercept == src)
		button.color = COLOR_GREEN
	//This is kind of spaghetti but any other implementation would require me to change a lot of lines
	//Feel free to shit me for this
	else if(owner.mouse_move_intercept == src)
		owner.mouse_move_intercept = null

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
