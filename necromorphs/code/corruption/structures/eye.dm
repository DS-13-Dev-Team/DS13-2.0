#define MINIMUM_NOTIFY_DELAY (1 MINUTES)

/obj/structure/necromorph/eye
	name = "eye"
	desc = "It knows you. You cannot escape its gaze."
	icon = 'necromorphs/icons/effects/corruption.dmi'
	icon_state = "eye"
	light_power = 1.5
	light_inner_range = 1
	light_outer_range = 2
	light_color = COLOR_BRIGHT_ORANGE
	max_integrity = 30
	var/obj/structure/marker/marker
	var/last_sighting

/obj/structure/necromorph/eye/Initialize(mapload, obj/structure/marker/marker)
	.=..()
	if(!marker)
		return INITIALIZE_HINT_QDEL
	src.marker = marker
	LAZYADD(marker.corruption_eyes, src)
	marker.markernet.addVisionSource(src, VISION_SOURCE_RANGE, FALSE)
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_ATOM_INITIALIZED_ON = PROC_REF(on_entered),
	)
	AddComponent(/datum/component/connect_range, src, loc_connections, 4, FALSE)

/obj/structure/necromorph/eye/Destroy()
	if(marker)
		LAZYREMOVE(marker.corruption_eyes, src)
	marker = null
	return ..()

/obj/structure/necromorph/eye/can_see_marker()
	return RANGE_TURFS(6, src)

/obj/structure/necromorph/eye/proc/on_entered(atom/source, mob/living/carbon/human/arrived)
	if(ishuman(arrived) && !isnecromorph(arrived) && can_see(src, arrived, 4))
		last_sighting = world.time
		if((world.time-marker.last_eye_notify) > MINIMUM_NOTIFY_DELAY)
			marker.last_eye_notify = world.time
			to_chat(arrived, span_notice("A shiver runs down your spine. You are being watched."))
			arrived.playsound_local(get_turf(arrived), get_sfx(SFX_HISS), 50)
			for(var/mob/camera/marker_signal/signal as anything in marker.marker_signals)
				to_chat(signal, span_notice("Human movement detected at [get_area(src)]! ") + SIG_EYEJMPLNK(src, signal))

/mob/camera/marker_signal/Topic(href, list/href_list)
	..()
	if(href_list["jump_to_eye"])
		var/obj/structure/necromorph/eye/eye = locate(href_list["eye_ref"]) in marker.corruption_eyes
		if(eye)
			abstract_move(get_turf(eye))

/datum/action/cooldown/necro/corruption/eye
	name = "Eye"
	place_structure = /obj/structure/necromorph/eye
	cost = 50

#undef MINIMUM_NOTIFY_DELAY

/datum/action/prey_sightings
	name = "Prey Sightings"

/datum/action/prey_sightings/Trigger(trigger_flags)
	if(!..())
		return FALSE
	ui_interact(owner)
	return TRUE

/datum/action/prey_sightings/IsAvailable(feedback)
	if(!istype(owner, /mob/camera/marker_signal))
		if(feedback)
			to_chat(owner, span_warning("You can't see prey sightings!"))
		return FALSE
	return ..()

/datum/action/prey_sightings/ui_host(mob/user)
	return owner

/datum/action/prey_sightings/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PreySightings")
		ui.open()

/datum/action/prey_sightings/ui_state(mob/user)
	return GLOB.always_state

/datum/action/prey_sightings/ui_data(mob/user)
	. = list()
	var/mob/camera/marker_signal/signal = owner
	.["world_time"] = world.time
	.["sightings"] = list()
	for(var/obj/structure/necromorph/eye/eye as anything in signal.marker.corruption_eyes)
		.["sightings"] += list(list(
			"ref" = REF(eye),
			"time" = eye.last_sighting,
			"coords"="[get_area(eye)] ([eye.x], [eye.y], [eye.z])",
		))

/datum/action/prey_sightings/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return
	switch(action)
		if("jump")
			var/obj/structure/necromorph/eye/eye = locate(params["eye_ref"])
			if(istype(eye))
				var/mob/camera/marker_signal/signal = owner
				if(eye.marker == signal.marker)
					signal.abstract_move(get_turf(eye))
