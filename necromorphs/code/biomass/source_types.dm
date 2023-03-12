/datum/biomass_source/baseline
	remaining_mass = INFINITY //Never runs out
	mass_per_tick = 0.1

/// It's not supposed to ever deplet
/datum/biomass_source/baseline/absorb_biomass(delta_time)
	return mass_per_tick * delta_time

/datum/biomass_source/harvester
	remaining_mass = INFINITY //Never runs out
	mass_per_tick = 0

/// It's not supposed to ever deplet
/datum/biomass_source/harvester/absorb_biomass(delta_time)
	var/obj/structure/necromorph/harvester/harvester = source
	if(harvester.active)
		return harvester.biomass_per_tick * delta_time
