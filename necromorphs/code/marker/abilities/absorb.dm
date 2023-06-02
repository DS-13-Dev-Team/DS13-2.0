#define NUTRIMENTS_TO_BIOMASS_MULTIPLIER 0.25

/datum/action/cooldown/necro/psy/absorb
	name = "Absorb"
	desc = "Absorbs all pieces of biological matter within a two tile radius of the target location. Only works on or near corruption, or in sight of the marker"
	cost = 10

/datum/action/cooldown/necro/psy/absorb/PreActivate(turf/target, mob/camera/marker_signal/caller)
	target = get_turf(target)
	if(!target)
		return FALSE
	if(target.necro_corrupted)
		return ..()
	for(var/turf/neraby as anything in RANGE_TURFS(2, target))
		if(neraby.necro_corrupted)
			return ..()
	if(IN_GIVEN_RANGE(target, caller.marker, 6) && can_see(target, caller.marker, 6))
		return ..()
	to_chat(target, span_warning("Biomass may only be claimed when the target is <b>near the marker, or corruption</b>"))
	return FALSE

/datum/action/cooldown/necro/psy/absorb/Activate(turf/target, mob/camera/marker_signal/caller)
	target = get_turf(target)
	var/absorbed_biomass = 0
	var/list/absorbed_atoms = list()
	for(var/obj/item/item in view(2, target))
		if(item.biomass)
			absorbed_biomass += item.biomass
			absorbed_atoms += item
		if(item.reagents?.flags & OPENCONTAINER)
			for(var/datum/reagent/consumable/reagent in item.reagents.reagent_list)
				absorbed_biomass += reagent.nutriment_factor * NUTRIMENTS_TO_BIOMASS_MULTIPLIER
				item.reagents.remove_reagent(reagent.type, reagent.volume)
			//If it is food and wasn't added to the list before
			if(istype(item, /obj/item/food) && !item.biomass)
				absorbed_atoms += item

	if(!absorbed_biomass)
		to_chat(caller, span_warning("No things containing asborbable biomass found."))
		return TRUE
	..()
	for(var/obj/item/item as anything in absorbed_atoms)
		new /obj/effect/temp_visual/decoy/absorb(get_turf(item), item, target)
		qdel(item)
	caller.marker.change_marker_biomass(absorbed_biomass * 0.4)
	caller.marker.change_signal_biomass(absorbed_biomass * 0.6)
	to_chat(caller, span_notice("Gained total of [absorbed_biomass] biomass from absorbing [length(absorbed_atoms)] thing\s!"))
	return TRUE

/obj/effect/temp_visual/decoy/absorb
	plane = ABOVE_LIGHTING_PLANE
	layer = LIGHTING_SECONDARY_LAYER

/obj/effect/temp_visual/decoy/absorb/Initialize(mapload, atom/mimiced_atom, turf/target)
	var/animate_duration = rand(4, 7)
	//wait time + second animate duration
	duration = animate_duration + 4
	.=..()
	if(!target)
		return INITIALIZE_HINT_QDEL
	add_filter("necro_outline", 1, outline_filter(1, COLOR_BRIGHT_ORANGE))
	//wait some time before start the animation
	animate(src, time = animate_duration)
	animate(pixel_x = src.pixel_x - ((src.x-target.x)*world.icon_size), pixel_y = src.pixel_y - ((src.y-target.y)*world.icon_size), transform = matrix(0, 0, 0, 0, 0, 0), time = 4)

#undef NUTRIMENTS_TO_BIOMASS_MULTIPLIER
