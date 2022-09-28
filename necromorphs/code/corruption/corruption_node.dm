/datum/corruption_node
	/// Amount of corruption we can keep
	var/remaining_weed_amount = 25
	/// How far can we spread corruption
	var/control_range = 5
	/// Atom we are bound to in real world
	var/atom/parent
	/// The Marker we are part of. Mainly used by corruption to get marker net
	var/obj/structure/marker/marker
	/// A list of corruption that have us as a master
	var/list/corruption
	/// An assoc list of turfs = amount of OUR corruption near it
	var/list/turfs_to_watch
	/// A list of turfs to spread
	var/list/turfs_to_spread

/datum/corruption_node/New(atom/new_parent, obj/structure/marker/marker)
	if(!new_parent)
		qdel(src)
		CRASH("Tried to spawn a corruption node without parent in real world.")

	if(!marker)
		if(length(GLOB.necromorph_markers))
			marker = pick(GLOB.necromorph_markers)
		else
			qdel(src)
			CRASH("Tried to spawn a corruption node without marker.")
	corruption = list()
	turfs_to_watch = list()
	turfs_to_spread = list()
	parent = new_parent
	src.marker = marker
	marker.nodes += src
	RegisterSignal(new_parent, COMSIG_PARENT_QDELETING, .proc/on_parent_delete)
	RegisterSignal(new_parent, COMSIG_ATOM_BREAK, .proc/on_parent_break)

/datum/corruption_node/Destroy()
	for(var/obj/structure/corruption/corrupt as anything in corruption)
		corrupt.on_master_delete()
	SScorruption.spreading -= src
	marker.nodes -= src
	marker = null
	parent = null
	return ..()

/datum/corruption_node/proc/on_parent_delete(atom/source)
	SIGNAL_HANDLER
	qdel(src)

/datum/corruption_node/proc/on_parent_break(atom/source)
	SIGNAL_HANDLER
	qdel(src)

/datum/corruption_node/proc/spread()
	for(var/turf/T as anything in turfs_to_spread)
		var/corruption_dir = turfs_to_watch[T]
		dir_loop:
			for(var/dir in GLOB.cardinals)
				if(!(corruption_dir & dir))
					continue
				var/turned_dir = turn(dir, 180)
				//Checks if we can leave our turf and enter the next one
				if(get_step(T, turned_dir).CanCorrupt(turned_dir) && T.CanCorrupt(dir))
					if(remaining_weed_amount > 0 && IN_GIVEN_RANGE(T, parent, control_range))
						new /obj/structure/corruption(T, src)
						break dir_loop
					else
						for(var/datum/corruption_node/node as anything in marker.nodes)
							if(node.remaining_weed_amount > 0 && IN_GIVEN_RANGE(T, node.parent, node.control_range))
								new /obj/structure/corruption(T, node)
								break dir_loop

/datum/corruption_node/proc/add_turf_to_spread(turf/T, direction)
	if(!T)
		return
	if(turfs_to_watch[T])
		turfs_to_watch[T] |= direction
		return
	turfs_to_watch[T] = direction
	if(!(locate(/obj/structure/corruption) in T))
		RegisterSignal(T, COMSIG_TURF_NECRO_CORRUPTED, .proc/on_nearby_turf_corrupted)
		RegisterSignal(T, COMSIG_TURF_CHANGED, .proc/on_turf_changed)
		if(isspaceturf(T) || istype(T, /turf/open/openspace))
			return
		RegisterSignal(T, COMSIG_ATOM_SET_DENSITY, .proc/on_turf_set_density)
		if(!T.density)
			turfs_to_spread += T
			SScorruption.spreading |= src
	else
		RegisterSignal(T, COMSIG_TURF_NECRO_UNCORRUPTED, .proc/on_nearby_turf_uncorrupted)

/datum/corruption_node/proc/remove_turf_to_spread(turf/T, direction)
	if(!T)
		return
	if((turfs_to_watch[T] &= ~direction))
		return
	turfs_to_watch -= T
	turfs_to_spread -= T
	UnregisterSignal(T, list(COMSIG_TURF_NECRO_CORRUPTED, COMSIG_TURF_CHANGED, COMSIG_ATOM_SET_DENSITY, COMSIG_TURF_NECRO_UNCORRUPTED))
	if(!length(turfs_to_spread))
		SScorruption.spreading -= src

//One of the turs was replaced, check if we can spread
/datum/corruption_node/proc/on_turf_changed(turf/source, flags)
	SIGNAL_HANDLER
	if(isspaceturf(source) || !istype(source, /turf/open/openspace))
		UnregisterSignal(source, COMSIG_ATOM_SET_DENSITY)
		turfs_to_spread -= source
		return
	if(source.density)
		RegisterSignal(source, COMSIG_ATOM_SET_DENSITY, .proc/on_turf_set_density)
		turfs_to_spread -= source
		return
	turfs_to_spread |= source
	SScorruption.spreading |= src

/datum/corruption_node/proc/on_turf_set_density(turf/source, old_density, new_density)
	SIGNAL_HANDLER
	if(old_density)
		turfs_to_spread += source
		SScorruption.spreading |= src
	else
		turfs_to_spread -= source
		if(!length(turfs_to_spread))
			SScorruption.spreading -= src

/datum/corruption_node/proc/on_nearby_turf_corrupted(turf/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, list(COMSIG_TURF_NECRO_CORRUPTED, COMSIG_TURF_CHANGED, COMSIG_ATOM_SET_DENSITY))
	turfs_to_spread -= source
	if(!length(turfs_to_spread))
		SScorruption.spreading -= src
	RegisterSignal(source, COMSIG_TURF_NECRO_UNCORRUPTED, .proc/on_nearby_turf_uncorrupted)

/datum/corruption_node/proc/on_nearby_turf_uncorrupted(turf/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, COMSIG_TURF_NECRO_UNCORRUPTED)
	RegisterSignal(source, COMSIG_TURF_NECRO_CORRUPTED, .proc/on_nearby_turf_corrupted)
	RegisterSignal(source, COMSIG_TURF_CHANGED, .proc/on_turf_changed)
	if(isspaceturf(source) || istype(source, /turf/open/openspace))
		return
	RegisterSignal(source, COMSIG_ATOM_SET_DENSITY, .proc/on_turf_set_density)
	if(!source.density)
		turfs_to_spread += source
		SScorruption.spreading |= src

/* SUBTYPES */
/datum/corruption_node/corruption
	/// con for an overlay applied to parent
	var/overlay_icon = 'necromorphs/icons/effects/corruption.dmi'
	/// icon_state for an overlay applied to parent
	var/overlay_icon_state = "minigrowth"
	/// Overlay applied to corruption, contains a node sprite
	var/image/overlay

/datum/corruption_node/corruption/New(obj/structure/corruption/new_parent)
	. = ..()
	overlay = iconstate2appearance(overlay_icon, overlay_icon_state)
	new_parent.add_overlay(overlay)
	new_parent.set_master(src)

/datum/corruption_node/corruption/Destroy()
	parent.cut_overlay(overlay)
	return ..()

//Shouldn't be used outside of testing
/obj/structure/corruption/node
/obj/structure/corruption/node/Initialize(mapload, datum/corruption_node/new_master)
	for(var/obj/structure/corruption/corruption in loc)
		if(corruption == src)
			continue
		new /datum/corruption_node/corruption(corruption)
		return INITIALIZE_HINT_QDEL
	new_master = new /datum/corruption_node/corruption(src)
	return ..()

/datum/corruption_node/marker
	remaining_weed_amount = 49
	control_range = 7

/datum/corruption_node/marker/New(atom/new_parent)
	..()
	if(QDELING(src))
		return
	var/parent_turf = get_turf(new_parent)
	qdel(locate(/obj/structure/corruption) in parent_turf)
	new /obj/structure/corruption/hardened(parent_turf, src)
