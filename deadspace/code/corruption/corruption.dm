#define GROW 1
#define SPREAD 2
#define DECAY 3

/obj/structure/corruption
	name = ""
	desc = "There is something scary in it."
	icon = 'deadspace/icons/effects/new_corruption.dmi'
	icon_state = "corruption-1"
	base_icon_state = "corruption"
	layer = NECROMORPH_CORRUPTION_LAYER
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_NECROMORPHS
	canSmoothWith = SMOOTH_GROUP_NECROMORPHS + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS
	anchored = TRUE
	max_integrity = 20
	integrity_failure = 0.5
	//Smallest alpha we can get in on_integrity_change()
	alpha = 20
	resistance_flags = UNACIDABLE
	obj_flags = CAN_BE_HIT
	interaction_flags_atom = NONE
	/// Node that keeps us alive
	var/datum/corruption_node/master
	/// If we are growing or decaying
	var/state = null
	/// Bitmask of directions we can potentially spread to (those directions have open turfs)
	var/dirs_to_spread
	/// The list of turfs that the corruption will not be able to grow over
	var/static/list/blacklisted_turfs = list(
		/turf/open/space,
		/turf/open/chasm,
		/turf/open/lava,
		/turf/open/water,
		/turf/open/openspace,
	)

/obj/structure/corruption/Initialize(mapload, datum/corruption_node/new_master)
	.=..()
	for(var/obj/structure/corruption/corruption in loc)
		if(corruption == src)
			continue
		return INITIALIZE_HINT_QDEL

	if(!new_master)
		return INITIALIZE_HINT_QDEL

	if(isturf(loc))
		var/turf/our_loc = loc
		our_loc.necro_corrupted = TRUE
	else
		return INITIALIZE_HINT_QDEL

	set_master(new_master)

	state = GROW

	atom_integrity = 3
	//I hate that you can't just override update_integrity()
	RegisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED, PROC_REF(on_integrity_change))

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_location_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

	update_dirs_to_spread()

	START_PROCESSING(SScorruption, src)

	SEND_SIGNAL(loc, COMSIG_TURF_NECRO_CORRUPTED, src)

/obj/structure/corruption/Destroy()
	if(isturf(loc))
		var/turf/our_loc = loc
		our_loc.necro_corrupted = FALSE
		for(var/obj/structure/corruption/corruption in loc)
			if(corruption != src)
				our_loc.necro_corrupted = TRUE
				break
	if(master)
		master.remaining_weed_amount++
		master.corruption -= src
		SEND_SIGNAL(loc, COMSIG_TURF_NECRO_UNCORRUPTED, src)
	master = null
	STOP_PROCESSING(SScorruption, src)
	return ..()

/obj/structure/corruption/Moved(turf/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	if(istype(old_loc))
		old_loc.necro_corrupted = FALSE
	if(isturf(loc))
		var/turf/our_loc = loc
		our_loc.necro_corrupted = TRUE
		update_dirs_to_spread(old_loc)
	else if(!QDELING(src))
		qdel(src)

/obj/structure/corruption/process(delta_time)
	switch(state)
		if(GROW)
			repair_damage(3*delta_time)
			return
		if(SPREAD)
			var/obj/structure/stairs/stairs = locate(/obj/structure/stairs) in loc
			if(stairs)
				if(!stairs.isTerminator())
					stairs = null
				else
					var/turf/above_turf = GetAbove(loc)
					var/turf/check_turf = get_step_multiz(loc, (stairs.dir|UP))
					if(above_turf?.CanZPass(src, UP, ZMOVE_STAIRS_FLAGS))
						if(check_turf?.Enter(src, TRUE) && !check_turf.necro_corrupted)
							if(master.remaining_weed_amount > 0 && get_dist(check_turf, master.parent) <= master.control_range)
								new /obj/structure/corruption(check_turf, master)

			if(!dirs_to_spread)
				return

			for(var/direction in GLOB.cardinals - stairs?.dir)
				if(!(dirs_to_spread & direction))
					continue
				var/turf/check_turf = get_step(src, direction)
				if(check_turf.Enter(src, TRUE))
					//Check if our nodes can be used
					if(master.remaining_weed_amount > 0 && get_dist(check_turf, master.parent) <= master.control_range)
						new /obj/structure/corruption(check_turf, master)
						continue
					//Otherwise search for a a nearby node
					for(var/datum/corruption_node/node as anything in master.marker.nodes-master)
						if(node.remaining_weed_amount > 0 && IN_GIVEN_RANGE(check_turf, node.parent, node.control_range))
							new /obj/structure/corruption(check_turf, node)
			return
		if(DECAY)
			take_damage(3*delta_time)
			return
	. = PROCESS_KILL
	CRASH("Corruption was processing with state: [isnull(state) ? "NULL" : state]")

/obj/structure/corruption/proc/on_location_entered(atom/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(isliving(arrived) && !isnecromorph(arrived))
		arrived.AddComponent(/datum/component/corruption_absorbing, master.marker)

/obj/structure/corruption/proc/update_dirs_to_spread(turf/old_loc)
	dirs_to_spread = 0

	if(old_loc)
		for(var/potential_dir in GLOB.cardinals)
			var/turf/turf = get_step(old_loc, potential_dir)
			UnregisterSignal(turf, list(COMSIG_TURF_CHANGE, COMSIG_TURF_NECRO_CORRUPTED, COMSIG_TURF_NECRO_UNCORRUPTED))

	for(var/potential_dir in GLOB.cardinals)
		var/turf/turf = get_step(loc, potential_dir)
		RegisterSignal(turf, COMSIG_TURF_CHANGE, PROC_REF(on_nearby_turf_change))

		if(!isopenturf(turf) || is_type_in_list(turf, blacklisted_turfs))
			continue

		if(!turf.necro_corrupted)
			RegisterSignal(turf, COMSIG_TURF_NECRO_CORRUPTED, PROC_REF(on_nearby_turf_corrupted))
			dirs_to_spread |= potential_dir
		else
			RegisterSignal(turf, COMSIG_TURF_NECRO_UNCORRUPTED, PROC_REF(on_nearby_turf_uncorrupted))

	update_spread_state()

/obj/structure/corruption/proc/update_spread_state()
	if(master && !get_integrity_lost())
		state = SPREAD

/obj/structure/corruption/proc/on_nearby_turf_change(turf/source, path, list/new_baseturfs, flags, list/post_change_callbacks)
	dirs_to_spread &= ~get_dir(loc, source)
	UnregisterSignal(source, list(COMSIG_TURF_NECRO_CORRUPTED, COMSIG_TURF_NECRO_UNCORRUPTED))
	post_change_callbacks += CALLBACK(src, PROC_REF(nearby_turf_changed), source)

/obj/structure/corruption/proc/nearby_turf_changed(turf/source)
	if(!isopenturf(source) || is_type_in_list(source, blacklisted_turfs))
		return

	if(!source.necro_corrupted)
		RegisterSignal(source, COMSIG_TURF_NECRO_CORRUPTED, PROC_REF(on_nearby_turf_corrupted))
		dirs_to_spread |= get_dir(loc, source)
	else
		RegisterSignal(source, COMSIG_TURF_NECRO_UNCORRUPTED, PROC_REF(on_nearby_turf_uncorrupted))

/obj/structure/corruption/proc/on_nearby_turf_corrupted(turf/source)
	dirs_to_spread &= ~get_dir(loc, source)
	update_spread_state()

/obj/structure/corruption/proc/on_nearby_turf_uncorrupted(turf/source)
	dirs_to_spread |= get_dir(loc, source)
	update_spread_state()

/obj/structure/corruption/proc/on_master_delete()
	master.corruption -= src
	var/datum/corruption_node/old_master = master
	for(var/datum/corruption_node/node as anything in old_master.marker.nodes)
		if(node.remaining_weed_amount > 0 && IN_GIVEN_RANGE(src, node.parent, node.control_range))
			set_master(node)
			return
	master = null
	state = DECAY

/obj/structure/corruption/proc/on_integrity_change(atom/source, old_integrity, new_integrity)
	SIGNAL_HANDLER
	if(master)
		if(old_integrity >= max_integrity)
			state = GROW
		else if(new_integrity >= max_integrity)
			update_spread_state()
	alpha = clamp(255*new_integrity/max_integrity, 20, 215)

// Doesn't do any safety checks, make sure to do them first
/obj/structure/corruption/proc/set_master(datum/corruption_node/new_master)
	if(!new_master)
		return
	if(master)
		master.remaining_weed_amount++
		master.corruption -= src
		if(master.marker != new_master.marker)
			master.marker.markernet.removeVisionSource(src)
	master = new_master
	new_master.remaining_weed_amount--
	new_master.corruption += src
	if(state == DECAY)
		state = GROW
	new_master.marker.markernet.addVisionSource(src, VISION_SOURCE_RANGE)

/obj/structure/corruption/play_attack_sound(damage_amount, damage_type, damage_flag)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/corruption/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(damage_flag == MELEE)
		switch(damage_type)
			if(BRUTE)
				damage_amount *= 0.25
			if(BURN)
				damage_amount *= 2
	.=..()

/obj/structure/corruption/can_see_marker()
	return RANGE_TURFS(1, src)


#undef GROW
#undef SPREAD
#undef DECAY
