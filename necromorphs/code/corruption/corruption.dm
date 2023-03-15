#define GROWING 1
#define DECAYING 2

/obj/structure/corruption
	name = ""
	desc = "There is something scary in it."
	icon = 'necromorphs/icons/effects/new_corruption.dmi'
	icon_state = "corruption-1"
	base_icon_state = "corruption"
	layer = NECROMORPH_CORRUPTION_LAYER
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_NECROMORPHS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_NECROMORPHS)
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

/obj/structure/corruption/Initialize(mapload, datum/corruption_node/new_master)
	.=..()
	for(var/obj/structure/corruption/corruption in loc)
		if(corruption == src)
			continue
		return INITIALIZE_HINT_QDEL

	if(!new_master)
		return INITIALIZE_HINT_QDEL

	var/turf/our_loc = loc
	if(istype(our_loc))
		our_loc.necro_corrupted = TRUE

	set_master(new_master)

	START_PROCESSING(SScorruption, src)
	state = GROWING

	atom_integrity = 3
	SEND_SIGNAL(loc, COMSIG_TURF_NECRO_CORRUPTED, src)

	//I hate that you can't just override update_integrity()
	RegisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED, PROC_REF(on_integrity_change))

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_location_entered)
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/corruption/Destroy()
	var/turf/our_loc = loc
	if(istype(our_loc))
		our_loc.necro_corrupted = FALSE
	if(master)
		for(var/direction in GLOB.cardinals)
			master.remove_turf_to_spread(get_step(src, direction), direction)
		SEND_SIGNAL(loc, COMSIG_TURF_NECRO_UNCORRUPTED, src)
		master.remaining_weed_amount++
		master.corruption -= src
	master = null
	STOP_PROCESSING(SScorruption, src)
	return ..()

/obj/structure/corruption/Moved(turf/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	var/turf/our_loc = loc
	if(istype(old_loc))
		old_loc.necro_corrupted = FALSE
	if(istype(our_loc))
		our_loc.necro_corrupted = TRUE

/obj/structure/corruption/process(delta_time)
	switch(state)
		if(GROWING)
			repair_damage(3*delta_time)
			return
		if(DECAYING)
			take_damage(3*delta_time)
			return
	. = PROCESS_KILL
	CRASH("Corruption was processing with state: [isnull(state) ? "NULL" : state]")

/obj/structure/corruption/proc/on_location_entered(atom/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(isliving(arrived) && !isnecromorph(arrived))
		arrived.AddComponent(/datum/component/corruption_absorbing, master.marker)

/obj/structure/corruption/proc/on_master_delete()
	master.corruption -= src
	var/datum/corruption_node/old_master = master
	for(var/datum/corruption_node/node as anything in old_master.marker.nodes)
		if(node.remaining_weed_amount > 0 && IN_GIVEN_RANGE(src, node.parent, node.control_range))
			set_master(node)
			return
	master = null
	state = DECAYING
	START_PROCESSING(SScorruption, src)

/obj/structure/corruption/proc/on_integrity_change(atom/source, old_integrity, new_integrity)
	SIGNAL_HANDLER
	if(master)
		if(old_integrity >= max_integrity)
			START_PROCESSING(SScorruption, src)
			state = GROWING
			for(var/direction in GLOB.cardinals)
				master.remove_turf_to_spread(get_step(src, direction), direction)
		else if(new_integrity >= max_integrity)
			STOP_PROCESSING(SScorruption, src)
			state = null
			for(var/direction in GLOB.cardinals)
				master.add_turf_to_spread(get_step(src, direction), direction)
	alpha = clamp(255*new_integrity/max_integrity, 20, 215)

// Doesn't do any safety checks, make sure to do them first
/obj/structure/corruption/proc/set_master(datum/corruption_node/new_master)
	if(master)
		master.remaining_weed_amount++
		master.corruption -= src
		master.marker.markernet.removeVisionSource(src)
	master = new_master
	new_master.remaining_weed_amount--
	new_master.corruption += src
	if(state == DECAYING)
		state = GROWING
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

/obj/structure/corruption/CanCorrupt(corruption_dir)
	return TRUE

#undef GROWING
#undef DECAYING
