/obj/structure/marker/Initialize(mapload)
	.=..()
	GLOB.necromorph_markers += src
	markernet = new
	markernet.addVisionSource(src, VISION_SOURCE_RANGE)

	for(var/datum/necro_class/class as anything in subtypesof(/datum/necro_class))
		necro_classes[class] = new class()

	necro_spawn_atoms += src

	//Add the baseline income
	add_biomass_source(/datum/biomass_source/baseline)

	START_PROCESSING(SSobj, src)

/obj/structure/marker/Destroy()
	STOP_PROCESSING(SSobj, src)
	for(var/datum/biomass_source/source as anything in biomass_sources)
		remove_biomass_source(source)
	necro_spawn_atoms = null
	GLOB.necromorph_markers -= src
	for(var/mob/camera/marker_signal/signal as anything in marker_signals)
		signal.show_message(span_userdanger("You feel like your connection with the Marker breaks!"))
		qdel(signal)
	marker_signals = null
	QDEL_NULL(markernet)
	.=..()

/obj/structure/marker/update_icon_state()
	icon_state = (active ? "marker_giant_dormant" : "marker_giant_active_anim")
	return ..()

/obj/structure/marker/process(delta_time)
	var/income = 0
	for(var/datum/biomass_source/source as anything in biomass_sources)
		income += source.absorb_biomass(delta_time)
	biomass += income*(1-signal_biomass_percent)
	signal_biomass += income*signal_biomass_percent
	last_biomass_income = income

/obj/structure/marker/proc/hive_mind_message(mob/sender, message)
	for(var/mob/dead/observer/observer as anything in GLOB.current_observers_list)
		if(!observer?.client?.prefs || !(observer.client.prefs.chat_toggles & CHAT_NECROMORPH))
			continue
		observer.show_message("[FOLLOW_LINK(observer, sender)] [message]")

	for(var/mob/camera/marker_signal/signal as anything in marker_signals)
		signal.show_message(message)

	for(var/mob/living/carbon/human/necromorph/necro as anything in necromorphs)
		necro.show_message(message)

/obj/structure/marker/proc/add_necro(mob/living/carbon/human/necromorph/necro)
	// If the necro is part of another hivemind, they should be removed from that one first
	if(necro.marker != src)
		necro.marker.remove_necro(necro, TRUE)
	necro.marker = src
	necromorphs |= necro
	markernet.addVisionSource(necro, VISION_SOURCE_VIEW, TRUE)

/obj/structure/marker/proc/remove_necro(mob/living/carbon/human/necromorph/necro, hard=FALSE, light_mode = FALSE)
	if(necro.marker != src)
		return
	markernet.removeVisionSource(necro)
	necromorphs -= necro
	necro.marker = null

/obj/structure/marker/proc/activate()
	active = TRUE
	for(var/mob/camera/marker_signal/eye as anything in marker_signals)
		for(var/datum/action/cooldown/necro/psy/ability as anything in eye.abilities)
			if((ability.marker_flags & SIGNAL_ABILITY_PRE_ACTIVATION))
				ability.Remove(eye)
			if((ability.marker_flags & SIGNAL_ABILITY_POST_ACTIVATION))
				ability.Grant(eye)
		for(var/datum/action/cooldown/necro/corruption/ability as anything in subtypesof(/datum/action/cooldown/necro/corruption))
			if(initial(ability.marker_only) && !istype(eye, /mob/camera/marker_signal/marker))
				continue
			ability = new ability(eye)
			ability.Grant(eye)
	new /datum/corruption_node/atom/marker(src, src)
	update_icon(UPDATE_ICON_STATE)

/obj/structure/marker/CanCorrupt(corruption_dir)
	return TRUE

/obj/structure/marker/can_see_marker()
	return RANGE_TURFS(12, src)

/mob/dead/observer/verb/join_horde()
	set category = "Necromorph"
	set name = "Join the Horde"

	if(!length(GLOB.necromorph_markers))
		to_chat(src, span_notice("There are no markers to join!"))
	else
		var/obj/structure/marker/marker = tgui_input_list(src, "Pick a marker to join", "Join Horde", GLOB.necromorph_markers)
		if(!marker)
			return
		var/mob/camera/marker_signal/eye = new(get_turf(marker), marker)
		eye.ckey = src.ckey

/obj/structure/marker/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NecromorphMarker")
		ui.open()

/obj/structure/marker/ui_state(mob/user)
	return GLOB.always_state

/obj/structure/marker/can_interact(mob/user)
	if(!ismarkereye(user))
		return FALSE
	return TRUE

/obj/structure/marker/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/necromorphs)
	)

/obj/structure/marker/ui_data(mob/user)
	. = list()
	.["biomass"] = biomass
	.["biomass_income"] = last_biomass_income
	.["biomass_invested"] = spent_biomass
	.["use_necroqueue"] = use_necroqueue
	.["signal_biomass"] = signal_biomass
	.["signal_biomass_percent"] = signal_biomass_percent

/obj/structure/marker/ui_static_data(mob/user)
	. = list()
	.["necromorphs"] = list()
	.["sprites"] = list()
	var/datum/asset/spritesheet/necromorphs/sheet = get_asset_datum(/datum/asset/spritesheet/necromorphs)
	for(var/sprite in sheet.sprites)
		var/list/data = sheet.sprites[sprite]
		.["sprites"][sprite] = data[1]
	for(var/datum/necro_class/class as anything in necro_classes)
		class = necro_classes[class]
		.["necromorphs"] += list(list(
			"name" = class.display_name,
			"desc" = class.desc,
			"cost" = class.biomass_cost,
			"type" = class.type,
			"biomass_required" = class.biomass_spent_required,
		))

/obj/structure/marker/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return

	switch(action)
		if("switch_necroqueue")
			use_necroqueue = !use_necroqueue
			return TRUE
		if("spawn_necromorph")
			var/class = text2path(params["class"])
			if(!class || !(class in necro_classes))
				return
			camera_mob.detach_necro_preview()
			camera_mob.attach_necro_preview(necro_classes[class])
		if("set_signal_biomass_percent")
			var/percent = text2num(params["percentage"]) || 0.1
			signal_biomass_percent = CLAMP01(percent)
		if("change_signal_biomass")
			var/remove_biomass = text2num(params["biomass"])
			if(!remove_biomass)
				return
			remove_biomass = clamp(remove_biomass, -signal_biomass, biomass)
			biomass -= remove_biomass
			signal_biomass += remove_biomass
			return TRUE

/obj/structure/marker/proc/add_biomass_source(source_type, datum/source)
	var/datum/biomass_source/new_source = new source_type(src, source)
	biomass_sources += new_source
	return new_source

/obj/structure/marker/proc/remove_biomass_source(datum/biomass_source/source)
	biomass_sources -= source
	qdel(source)
