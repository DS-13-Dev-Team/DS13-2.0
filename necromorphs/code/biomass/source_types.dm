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
/datum/biomass_source/corruption_absorbing
	mass_per_tick = 0

/datum/biomass_source/corruption_absorbing/absorb_biomass(delta_time)
	var/mob/living/human = source
	var/zone = pick(BODY_ZONE_L_ARM,BODY_ZONE_R_ARM,BODY_ZONE_HEAD,BODY_ZONE_CHEST,BODY_ZONE_L_LEG,BODY_ZONE_R_LEG)
	var/old_damage = human.get_damage_amount(BRUTE)
	human.apply_damage(ABSORB_DAMAGE*delta_time, BRUTE, zone)
	//Make sure we don't get negative biomass
	return max((human.get_damage_amount(BRUTE) - old_damage) * DAMAGE_TO_BIO_RATIO, 0)

#undef ABSORB_DAMAGE
#undef DAMAGE_TO_BIO_RATIO
