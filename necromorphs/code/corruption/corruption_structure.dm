#define GROWING 1
#define DECAYING 2

/obj/structure/necromorph
	name = "necromorph sturcture"
	desc = "There is something scary in it."
	icon = 'necromorphs/icons/effects/corruption.dmi'
	icon_state = "maw"
	anchored = TRUE
	max_integrity = 25
	resistance_flags = UNACIDABLE
	obj_flags = CAN_BE_HIT
	/// Weed below this structure, if it's dying then we are dying as well
	var/obj/structure/corruption/master
	/// If we are growing or decaying
	var/state = null

/obj/structure/necromorph/Initialize(mapload)
	..()
	RegisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED, .proc/on_integrity_change)
	return INITIALIZE_HINT_LATELOAD

/obj/structure/necromorph/LateInitialize()
	..()
	update_signals(null, loc)

/obj/structure/necromorph/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	..()
	update_signals(old_loc, loc)
	return TRUE

/obj/structure/necromorph/proc/update_signals(atom/old_loc, atom/new_loc)
	if(old_loc)
		UnregisterSignal(old_loc, list(COMSIG_TURF_NECRO_CORRUPTED, COMSIG_TURF_NECRO_UNCORRUPTED))
	if(new_loc)
		if(locate(/obj/structure/corruption) in loc)
			RegisterSignal(new_loc, COMSIG_TURF_NECRO_UNCORRUPTED, .proc/on_turf_uncorrupted)
			state = GROWING
			START_PROCESSING(SScorruption, src)
		else
			RegisterSignal(new_loc, COMSIG_TURF_NECRO_CORRUPTED, .proc/on_turf_corrupted)
			state = DECAYING
			START_PROCESSING(SScorruption, src)

/obj/structure/necromorph/proc/on_turf_uncorrupted(turf/source)
	SIGNAL_HANDLER
	state = DECAYING
	START_PROCESSING(SScorruption, src)

/obj/structure/necromorph/proc/on_turf_corrupted(turf/source)
	SIGNAL_HANDLER
	state = GROWING
	START_PROCESSING(SScorruption, src)

/obj/structure/necromorph/process(delta_time)
	if(state == GROWING)
		repair_damage(3*delta_time)
	else if(state == DECAYING)
		take_damage(3*delta_time)
	else
		. = PROCESS_KILL
		CRASH("Corruption was processing while state was [isnull(state) ? "NULL" : state]")

/obj/structure/necromorph/proc/on_integrity_change(atom/source, old_integrity, new_integrity)
	SIGNAL_HANDLER
	if(master)
		if((old_integrity >= new_integrity) && state != DECAYING)
			state = GROWING
			START_PROCESSING(SScorruption, src)
		else if(new_integrity >= max_integrity)
			state = null
			STOP_PROCESSING(SScorruption, src)

/obj/structure/necromorph/play_attack_sound(damage_amount, damage_type, damage_flag)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/necromorph/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(damage_flag == MELEE)
		switch(damage_type)
			if(BRUTE)
				damage_amount *= 0.25
			if(BURN)
				damage_amount *= 2
	return ..()

/obj/structure/necromorph/CanCorrupt(corruption_dir)
	return TRUE

#undef GROWING
#undef DECAYING
