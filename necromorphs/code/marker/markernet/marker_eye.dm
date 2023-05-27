GLOBAL_LIST_EMPTY(markers_signals)
/mob/camera/marker_signal
	name = "Signal"
	icon_state = "markersignal-"
	icon = 'necromorphs/icons/signals/eye.dmi'
	plane = MARKER_SIGNAL_PLANE
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	invisibility = INVISIBILITY_MARKER_SIGNAL
	see_invisible = SEE_INVISIBLE_MARKER_SIGNAL
	sight = SEE_MOBS|SEE_OBJS|SEE_TURFS
	mouse_opacity = MOUSE_OPACITY_ICON
	movement_type = GROUND|FLYING
	hud_type = /datum/hud/marker
	interaction_range = null
	var/psy_energy = 0
	var/psy_energy_maximum = 900
	var/psy_energy_generation = 1.5
	var/updatedir = null
	var/list/abilities
	var/list/visibleChunks
	var/obj/structure/marker/marker
	var/static_visibility_range = 16

/mob/camera/marker_signal/Initialize(mapload, obj/structure/marker/master)
	visibleChunks = list()
	abilities = list()
	.=..()
	if(!master)
		return INITIALIZE_HINT_QDEL
	marker = master
	GLOB.markers_signals += src
	AddElement(/datum/element/movetype_handler)
	icon_state += "[rand(1, 25)]"
	master.marker_signals += src
	if(!loc)
		forceMove(get_turf(marker))
	master.markernet.eyes += src

	var/datum/action/prey_sightings/action = new(src)
	action.Grant(src)

	for(var/datum/action/cooldown/necro/psy/ability as anything in subtypesof(/datum/action/cooldown/necro/psy))
		if((initial(ability.marker_flags) & SIGNAL_ABILITY_MARKER_ONLY) && !istype(src, /mob/camera/marker_signal/marker))
			continue
		ability = new ability(src)
		abilities += ability
		if(!marker.active)
			if(initial(ability.marker_flags) & SIGNAL_ABILITY_PRE_ACTIVATION)
				ability.Grant(src)
		else
			if(initial(ability.marker_flags) & SIGNAL_ABILITY_POST_ACTIVATION)
				ability.Grant(src)

	if(marker.active)
		for(var/datum/action/cooldown/necro/corruption/ability as anything in subtypesof(/datum/action/cooldown/necro/corruption))
			if(initial(ability.marker_only) && !istype(src, /mob/camera/marker_signal/marker))
				continue
			ability = new ability(src)
			ability.Grant(src)

	START_PROCESSING(SSobj, src)

/mob/camera/marker_signal/Destroy()
	STOP_PROCESSING(SSobj, src)
	GLOB.markers_signals -= src
	if(marker)
		marker.markernet.eyes -= src
		marker.marker_signals -= src
		marker = null
	for(var/datum/markerchunk/chunk as anything in visibleChunks)
		chunk.remove(src)
	return ..()

/mob/camera/marker_signal/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	for(var/datum/markerchunk/chunk as anything in visibleChunks)
		client.images += chunk.active_masks
	marker.markernet.visibility(src)

/mob/camera/marker_signal/process(delta_time)
	change_psy_energy(psy_energy_generation)

/mob/camera/marker_signal/Move(NewLoc, direct, glide_size_override = 32)
	if(updatedir)
		setDir(direct)//only update dir if we actually need it, so overlays won't spin on base sprites that don't have directions of their own

	if(glide_size_override)
		set_glide_size(glide_size_override)
	if(NewLoc)
		abstract_move(NewLoc)
		update_parallax_contents()
	else
		var/turf/destination = get_turf(src)

		if((direct & NORTH) && y < world.maxy)
			destination = get_step(destination, NORTH)

		else if((direct & SOUTH) && y > 1)
			destination = get_step(destination, SOUTH)

		if((direct & EAST) && x < world.maxx)
			destination = get_step(destination, EAST)

		else if((direct & WEST) && x > 1)
			destination = get_step(destination, WEST)

		abstract_move(destination)

/mob/camera/marker_signal/forceMove(atom/destination)
	abstract_move(destination) // move like the wind
	return TRUE

/mob/camera/marker_signal/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	..()
	if(client)
		marker.markernet.visibility(src)
		update_static(old_loc)
	return TRUE

/mob/camera/marker_signal/DblClickOn(atom/A, params)
	if(check_click_intercept(params, A))
		return

	if(istype(A, /mob/living/carbon/human/necromorph))
		possess_necromorph(A)
		return

	if(istype(A, /atom/movable/screen/cameranet_static))
		// Find a turf below the location we clicked at
		var/list/list_params = params2list(params)
		var/list/view = getviewsize(src.client.view)
		var/list/screen_loc = splittext(list_params["screen-loc"], ",")
		var/x = splittext(screen_loc[1], ":")
		x = src.x-round(view[1]*0.5, 1)+text2num(x[1])
		var/y = splittext(screen_loc[2], ":")
		y = src.y-round(view[2]*0.5, 1)+text2num(y[1])
		A = locate(x, y, src.z)

	// Otherwise just jump to the turf
	if(A.loc)
		abstract_move(get_turf(A))

/mob/camera/marker_signal/ClickOn(atom/A, params)
	if(check_click_intercept(params,A))
		return

	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		if(LAZYACCESS(modifiers, MIDDLE_CLICK))
			ShiftMiddleClickOn(A)
			return
		if(LAZYACCESS(modifiers, CTRL_CLICK))
			CtrlShiftClickOn(A)
			return
		ShiftClickOn(A)
		return
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		if(LAZYACCESS(modifiers, CTRL_CLICK))
			CtrlMiddleClickOn(A)
		else
			MiddleClickOn(A, params)
		return
	if(LAZYACCESS(modifiers, ALT_CLICK))
		AltClickNoInteract(src, A)
		return
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		CtrlClickOn(A)
		return

	if(world.time <= next_move)
		return
	A.attack_marker_signal(src)

/atom/proc/attack_marker_signal(mob/camera/marker_signal/user)
	return FALSE

/mob/camera/marker_signal/verb/leave_horde()
	set name = "Leave the Horde"
	set category = "Necromorph"

	qdel(src)

/mob/camera/marker_signal/verb/possess_necromorph(mob/living/carbon/human/necromorph/necro in world)
	set name = "Possess Necromorph"
	set category = "Object"
	if(necro.stat == DEAD)
		to_chat(src, span_notice("This vessel was damaged beyond use!"))
		return
	necro.controlling = src
	mind.transfer_to(necro, TRUE)
	abstract_move(null)

/mob/camera/marker_signal/proc/change_psy_energy(amount)
	psy_energy = clamp(psy_energy+amount, 0, psy_energy_maximum)
	if(hud_used)
		var/datum/hud/marker/our_hud = hud_used
		var/filter = our_hud.psy_energy.get_filter("alpha_filter")
		animate(filter, x = clamp(HUD_METER_PIXEL_WIDTH*(psy_energy/psy_energy_maximum), 0, HUD_METER_PIXEL_WIDTH), time = 0.5 SECONDS)
		our_hud.foreground_psy.maptext = MAPTEXT("[round(psy_energy, 1)]/[psy_energy_maximum] | +[psy_energy_generation] psy/sec")

/mob/camera/marker_signal/proc/update_biomass_hud(hud_override)
	var/datum/hud/marker/our_hud = hud_override || hud_used
	our_hud?.foreground_bio.maptext = MAPTEXT("[round(marker.signal_biomass, 1)] | +[marker.last_biomass_income*marker.signal_biomass_percent] bio/sec")

/mob/camera/marker_signal/verb/become_master()
	set name = "Become master signal"
	set category = "Necromorph"

	if(!marker.active)
		to_chat(src, span_notice("Marker is not active yet!"))
		return
	if(marker.camera_mob)
		to_chat(src, span_notice("There is a player controlling the marker already!"))
		return
	var/mob/camera/marker_signal/marker/camera = new /mob/camera/marker_signal/marker(get_turf(src), marker)
	marker.camera_mob = camera
	camera.real_name = camera.name
	camera.ckey = src.ckey
	camera.change_psy_energy(psy_energy)
	qdel(src)

/mob/camera/marker_signal/marker
	name = "Marker"
	icon_state = "mastersignal"
	icon = 'necromorphs/icons/signals/mastersignal.dmi'
	invisibility = INVISIBILITY_OBSERVER
	see_invisible = SEE_INVISIBLE_OBSERVER
	hud_type = /datum/hud/marker
	interaction_range = null
	pixel_x = -7
	pixel_y = -7
	///Used when spawning necromorphs
	var/image/necro_preview
	///Necro class of a necromorph we are going to spawn
	var/spawning_necromorph

/mob/camera/marker_signal/marker/Initialize(mapload, obj/structure/marker/master)
	. = ..()
	master?.marker_ui_action.Grant(src)
	icon_state = "mastersignal"
	verbs -= /mob/camera/marker_signal/verb/become_master

/mob/camera/marker_signal/marker/Destroy()
	marker?.camera_mob = null
	return ..()

/mob/camera/marker_signal/marker/update_biomass_hud(hud_override)
	var/datum/hud/marker/our_hud = hud_override || hud_used
	our_hud?.foreground_bio.maptext = MAPTEXT("[round(marker.marker_biomass, 1)] | +[marker.last_biomass_income*(1-marker.signal_biomass_percent)] bio/sec")

/mob/camera/marker_signal/marker/verb/downgrade()
	set name = "Downgrade to normal signal"
	set category = "Necromorph"

	var/mob/camera/marker_signal/signal = new /mob/camera/marker_signal(get_turf(src), marker)
	signal.real_name = signal.name
	signal.ckey = src.ckey
	signal.change_psy_energy(psy_energy)
	qdel(src)

/mob/camera/marker_signal/marker/ClickOn(atom/A, params)
	if(check_click_intercept(params,A))
		return

	var/list/modifiers = params2list(params)
	if(spawning_necromorph)
		if(LAZYACCESS(modifiers, LEFT_CLICK))
			if(!LAZYACCESS(modifiers, SHIFT_CLICK))
				spawn_necromorph(A)
				detach_necro_preview()
			else
				spawn_necromorph(A)
			return
		else if(LAZYACCESS(modifiers, RIGHT_CLICK))
			detach_necro_preview()
			return
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		if(LAZYACCESS(modifiers, MIDDLE_CLICK))
			ShiftMiddleClickOn(A)
			return
		if(LAZYACCESS(modifiers, CTRL_CLICK))
			CtrlShiftClickOn(A)
			return
		ShiftClickOn(A)
		return
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		if(LAZYACCESS(modifiers, CTRL_CLICK))
			CtrlMiddleClickOn(A)
		else
			MiddleClickOn(A, params)
		return
	if(LAZYACCESS(modifiers, ALT_CLICK))
		AltClickNoInteract(src, A)
		return
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		CtrlClickOn(A)
		return

	if(world.time <= next_move)
		return
	A.attack_marker_signal(src)

/mob/camera/marker_signal/marker/proc/spawn_necromorph(turf/A)
	if(marker.spent_biomass < marker.necro_classes[spawning_necromorph].biomass_spent_required)
		to_chat(src, span_warning("Not enough biomass spent!"))
		return
	if(marker.marker_biomass < marker.necro_classes[spawning_necromorph].biomass_cost)
		to_chat(src, span_warning("Not enough biomass!"))
		return
	A = get_turf(A)
	if(!A)
		return
	if(A.density)
		to_chat(src, span_warning("Location is dense!"))
		return
	for(var/atom/movable/movable as anything in A)
		if(movable.density)
			to_chat(src, span_warning("Location has dense objects on it!"))
			return
	//In case there was a nearby spawnloc but nest was behind a wall
	var/spawnloc_cantsee
	for(var/atom/spawnloc as anything in marker.necro_spawn_atoms)
		if(!IN_GIVEN_RANGE(spawnloc, A, 4))
			continue
		var/turf/turf_loc = get_turf(spawnloc)
		if(!can_see(turf_loc, A, 4))
			spawnloc_cantsee = TRUE
			continue
		marker.marker_biomass -= marker.necro_classes[spawning_necromorph].biomass_cost
		var/path = marker.necro_classes[spawning_necromorph].necromorph_type_path
		var/mob/living/carbon/human/necromorph/mob = new path(A, marker)
		if(marker.use_necroqueue && length(marker.marker_signals-src))
			var/mob/camera/marker_signal/signal = pick(marker.marker_signals-src)
			signal.possess_necromorph(mob)
		return
	if(!spawnloc_cantsee)
		to_chat(src, span_warning("There are no possible spawn locations nearby!"))
	else
		to_chat(src, span_warning("Nearby spawn location cant see this turf!"))

/mob/camera/marker_signal/marker/proc/attach_necro_preview(datum/necro_class/class)
	necro_preview = new /image/necromorph_subtype(class.ui_icon, null, "preview")
	var/mob/living/carbon/human/necromorph/necro = class.necromorph_type_path
	necro_preview.pixel_x = initial(necro.base_pixel_x)
	necro_preview.pixel_y = initial(necro.base_pixel_y)
	client.images += necro_preview
	mouse_move_intercept = src
	spawning_necromorph = class.type

/mob/camera/marker_signal/marker/proc/detach_necro_preview()
	if(mouse_move_intercept == src)
		mouse_move_intercept = null
	spawning_necromorph = null
	client.images -= necro_preview
	necro_preview = null

/mob/camera/marker_signal/marker/proc/mouse_movement_intercepted(atom/intercepted)
	necro_preview.loc = get_turf(intercepted)
