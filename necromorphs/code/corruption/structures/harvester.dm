#define HARVESTER_CONTROL_RANGE 7

/obj/structure/necromorph/harvester
	name = "harvester"
	icon = 'necromorphs/icons/effects/corruption48x48.dmi'
	icon_state = "whole"
	var/active = FALSE
	var/biomass_per_tick = 0
	var/list/controlled_atoms
	var/obj/structure/marker/marker

/obj/structure/necromorph/harvester/Initialize(mapload, obj/structure/marker/new_master)
	.=..()
	if(!new_master)
		return INITIALIZE_HINT_QDEL
	marker = new_master
	controlled_atoms = list()
	icon_state = "harvester"
	update_icon(UPDATE_OVERLAYS)

/obj/structure/necromorph/harvester/LateInitialize()
	..()
	//If we have corruption beneath - we are growing
	if(locate(/obj/structure/corruption) in loc)
		addtimer(CALLBACK(src, .proc/activate), 3 MINUTES, TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/structure/necromorph/harvester/Destroy()
	marker?.biomass_income -= biomass_per_tick
	for(var/atom/movable/controlled as anything in controlled_atoms)
		UnregisterSignal(controlled, list(COMSIG_PARENT_QDELETING, COMSIG_MOVABLE_MOVED))
		REMOVE_TRAIT(controlled, TRAIT_PRODUCES_BIOMASS, src)
	controlled_atoms = null
	return ..()

/obj/structure/necromorph/harvester/update_overlays()
	.=..()
	var/static/our_overlays
	if (isnull(our_overlays))
		our_overlays = list(
			iconstate2appearance(icon, "tentacle_1"),
			iconstate2appearance(icon, "tentacle_2"),
			iconstate2appearance(icon, "tentacle_3"),
			iconstate2appearance(icon, "tentacle_4"),
			iconstate2appearance(icon, "beak_closed"),
			iconstate2appearance(icon, "beak"),
		)
	if(active)
		. += our_overlays[1]
		. += our_overlays[2]
		. += our_overlays[3]
		. += our_overlays[4]
		. += our_overlays[5]
	else
		. += our_overlays[6]

/obj/structure/necromorph/harvester/on_turf_corrupted()
	.=..()
	addtimer(CALLBACK(src, .proc/activate), 3 MINUTES, TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/structure/necromorph/harvester/on_turf_uncorrupted()
	.=..()
	active = FALSE
	marker.biomass_income -= biomass_per_tick
	for(var/atom/movable/controlled as anything in controlled_atoms)
		UnregisterSignal(controlled, list(COMSIG_PARENT_QDELETING, COMSIG_MOVABLE_MOVED))
		REMOVE_TRAIT(controlled, TRAIT_PRODUCES_BIOMASS, src)
	controlled_atoms.Cut()
	update_icon(UPDATE_OVERLAYS)

/obj/structure/necromorph/harvester/proc/activate()
	if(locate(/obj/structure/corruption) in loc)
		active = TRUE
		FOR_DVIEW(var/atom/movable/controlled, HARVESTER_CONTROL_RANGE, src, INVISIBILITY_LIGHTING)
			if(controlled.biomass_produce && !HAS_TRAIT(controlled, TRAIT_PRODUCES_BIOMASS))
				controlled_atoms += controlled
				RegisterSignal(controlled, COMSIG_PARENT_QDELETING, .proc/on_controlled_delete)
				RegisterSignal(controlled, COMSIG_MOVABLE_MOVED, .proc/on_controlled_moved)
				ADD_TRAIT(controlled, TRAIT_PRODUCES_BIOMASS, src)
				biomass_per_tick += controlled.biomass_produce
		FOR_DVIEW_END
		marker.biomass_income += biomass_per_tick
		update_icon(UPDATE_OVERLAYS)

/obj/structure/necromorph/harvester/proc/on_controlled_delete(atom/movable/controlled, force)
	SIGNAL_HANDLER
	biomass_per_tick -= controlled.biomass_produce
	marker.biomass_income -= controlled.biomass_produce
	controlled_atoms -= controlled
	UnregisterSignal(controlled, list(COMSIG_PARENT_QDELETING, COMSIG_MOVABLE_MOVED))
	REMOVE_TRAIT(controlled, TRAIT_PRODUCES_BIOMASS, src)

/obj/structure/necromorph/harvester/proc/on_controlled_moved(atom/movable/controlled)
	SIGNAL_HANDLER
	if(get_dist(src, controlled) > HARVESTER_CONTROL_RANGE)
		biomass_per_tick -= controlled.biomass_produce
		marker.biomass_income -= controlled.biomass_produce
		controlled_atoms -= controlled
		UnregisterSignal(controlled, list(COMSIG_PARENT_QDELETING, COMSIG_MOVABLE_MOVED))
		REMOVE_TRAIT(controlled, TRAIT_PRODUCES_BIOMASS, src)

#undef HARVESTER_CONTROL_RANGE

/datum/action/cooldown/necro/corruption/harvester
	name = "Harvester"
	marker_only = TRUE
	place_structure = /obj/structure/necromorph/harvester
	cost = 50
