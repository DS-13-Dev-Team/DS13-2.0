//TODO: Wait for Ketrai's sprites
/obj/structure/corruption
	name = ""
	desc = "There is something scary in it."
	icon = 'necromorphs/icons/effects/corruption.dmi'
	icon_state = "corruption-1"
	layer = BELOW_OPEN_DOOR_LAYER
	//smoothing_flags = SMOOTH_BITMASK
	anchored = TRUE
	max_integrity = 25
	integrity_failure = 5
	//Smallest alpha we can get in on_integrity_change()
	alpha = 20
	resistance_flags = UNACIDABLE
	obj_flags = CAN_BE_HIT
	interaction_flags_atom = NONE
	/// Node that keeps us alive
	var/datum/corruption_node/master
	/// The Marker we are part of. Mainly used by corruption to get marker net
	var/obj/structure/marker/marker

/obj/structure/corruption/Initialize(mapload, datum/corruption_node/new_master)
	.=..()
	for(var/obj/structure/corruption/corruption in loc)
		if(corruption == src)
			continue
		stack_trace("multiple corruption spawned at ([loc.x], [loc.y], [loc.z])")
		return INITIALIZE_HINT_QDEL

	if(new_master)
		set_master(new_master)
	else
		var/obj/structure/marker/marker = pick(GLOB.necromorph_markers)
		//Search for a node if we don't have any
		for(var/datum/corruption_node/node as anything in marker.nodes)
			if(node.remaining_weed_amount > 0 && IN_GIVEN_RANGE(src, node.parent, node.control_range))
				set_master(node)
				break
		if(!master)
			return INITIALIZE_HINT_QDEL

	SScorruption.growing += src

	atom_integrity = 3
	SEND_SIGNAL(loc, COMSIG_TURF_NECRO_CORRUPTED, src)

	//I hate that you can't just override update_integrity()
	RegisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED, .proc/on_integrity_change)

/obj/structure/corruption/Destroy()
	SEND_SIGNAL(loc, COMSIG_TURF_NECRO_UNCORRUPTED, src)
	if(master)
		master.remaining_weed_amount++
		master.corruption -= src
	master = null
	SScorruption.growing -= src
	SScorruption.decaying -= src
	.=..()

/obj/structure/corruption/proc/on_master_delete()
	master.corruption -= src
	var/datum/corruption_node/old_master = master
	for(var/datum/corruption_node/node as anything in old_master.marker.nodes)
		if(node.remaining_weed_amount > 0 && IN_GIVEN_RANGE(src, node.parent, node.control_range))
			set_master(node)
			return
	master = null
	SScorruption.growing -= src
	SScorruption.decaying += src

/obj/structure/corruption/proc/on_integrity_change(datum/source, old_integrity, new_integrity)
	SIGNAL_HANDLER
	if(master)
		if(old_integrity >= max_integrity)
			SScorruption.growing |= src
			for(var/direction in GLOB.cardinals)
				master.remove_turf_to_spread(get_step(src, direction), direction)
		else if(new_integrity >= max_integrity)
			SScorruption.growing -= src
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
	SScorruption.decaying -= src
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

/obj/structure/corruption/hardened
	resistance_flags = UNACIDABLE|INDESTRUCTIBLE

/obj/structure/corruption/hardened/on_master_delete()
	..()
	resistance_flags &= INDESTRUCTIBLE
