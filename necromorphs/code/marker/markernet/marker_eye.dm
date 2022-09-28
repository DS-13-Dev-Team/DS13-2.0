/mob/camera/marker_signal
	name = "Signal"
	icon_state = "markersignal-"
	icon = 'necromorphs/icons/signals/eye.dmi'
	plane = MARKER_SIGNAL_PLANE
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
	var/atom/movable/screen/cameranet_static/cameranet_static

/mob/camera/marker_signal/Initialize(mapload, obj/structure/marker/master)
	visibleChunks = list()
	abilities = list()
	cameranet_static = new(null, src)
	.=..()
	if(master)
		marker = master
	else
		return INITIALIZE_HINT_QDEL
	AddElement(/datum/element/movetype_handler)
	icon_state += "[rand(1, 25)]"
	master.marker_signals += src
	forceMove(get_turf(marker))
	master.markernet.eyes += src

	for(var/datum/action/cooldown/necro/psy/ability as anything in subtypesof(/datum/action/cooldown/necro/psy))
		ability = new ability(src)
		abilities += ability
		if((initial(ability.required_marker_status) & SIGNAL_ABILITY_PRE_ACTIVATION) && !marker.active)
			ability.Grant(src)
		else if((initial(ability.required_marker_status) & SIGNAL_ABILITY_POST_ACTIVATION) && marker.active)
			ability.Grant(src)

	START_PROCESSING(SSprocessing, src)

/mob/camera/marker_signal/Destroy()
	marker.markernet.eyes -= src
	marker.marker_signals -= src
	marker = null
	for(var/datum/markerchunk/chunk as anything in visibleChunks)
		chunk.remove(src)
	.=..()
	QDEL_NULL(cameranet_static)

/mob/camera/marker_signal/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	for(var/datum/markerchunk/chunk as anything in visibleChunks)
		client.images += chunk.active_masks
	marker.markernet.visibility(src)
	var/view = client.view || world.view
	cameranet_static.update_o(view)
	cameranet_static.RegisterSignal(client, COMSIG_VIEW_SET, /atom/movable/screen/cameranet_static/proc/on_view_change)
	client.screen += cameranet_static

/mob/camera/marker_signal/Logout()
	// Without if() this will runtime if you close dream seeker hosting the build
	if(canon_client)
		cameranet_static.UnregisterSignal(canon_client, COMSIG_VIEW_SET)
	return ..()

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

	if(istype(A, /mob/living/carbon/necromorph))
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

/mob/camera/marker_signal/verb/leave_horde()
	set name = "Leave the Horde"
	set category = "Necromorph"

	qdel(src)

/mob/camera/marker_signal/verb/possess_necromorph(mob/living/carbon/necromorph/necro in world)
	set name = "Possess Necromorph"
	set category = "Object"

	necro.controlling = src
	mind.transfer_to(necro, TRUE)
	//moveToNullspace()
	//We don't want to use doMove() here
	abstract_move(null)

/mob/camera/marker_signal/proc/change_psy_energy(amount)
	psy_energy = clamp(psy_energy+amount, 0, psy_energy_maximum)
	if(hud_used)
		var/datum/hud/marker/our_hud = hud_used
		var/filter = our_hud.psy_energy.get_filter("alpha_filter")
		animate(filter, x = clamp(PSYBAR_PIXEL_WIDTH*(psy_energy/psy_energy_maximum), 0, PSYBAR_PIXEL_WIDTH), time = 0.5 SECONDS)
		var/psy_string = max(0, psy_energy)
		if(round(psy_string, 1) == psy_string)
			psy_string = "[psy_string].0"
		our_hud.foreground.maptext = MAPTEXT("[psy_string]/[psy_energy_maximum] | +[psy_energy_generation] psy/seс")

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

/mob/camera/marker_signal/marker/Initialize(mapload, obj/structure/marker/master)
	. = ..()
	icon_state = "mastersignal"

/mob/camera/marker_signal/marker/Destroy()
	marker?.camera_mob = null
	return ..()
