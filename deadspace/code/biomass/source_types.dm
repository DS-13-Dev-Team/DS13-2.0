/datum/biomass_source/baseline
	remaining_mass = INFINITY //Never runs out
	mass_per_tick = 0.5

/// It's not supposed to ever deplet
/datum/biomass_source/baseline/absorb_biomass(delta_time)
	return mass_per_tick * delta_time

/datum/biomass_source/harvester
	mass_per_tick = 0

/// It's not supposed to ever deplet
/datum/biomass_source/harvester/absorb_biomass(delta_time)
	var/obj/structure/necromorph/harvester/harvester = source
	if(harvester.active)
		return harvester.biomass_per_tick * delta_time

#define ABSORB_DAMAGE 10
#define DAMAGE_TO_BIO_RATIO 0.5
/datum/biomass_source/maw
	mass_per_tick = 0

/datum/biomass_source/maw/absorb_biomass(delta_time)
	var/obj/structure/necromorph/maw/maw = source
	for(var/mob/living/target as anything in maw.buckled_mobs)


#undef ABSORB_DAMAGE
#undef DAMAGE_TO_BIO_RATIO
