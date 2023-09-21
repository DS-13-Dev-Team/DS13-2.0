/mob/living/carbon/human/necromorph/slasher/enhanced
	class = /datum/necro_class/slasher/enhanced
	necro_species = /datum/species/necromorph/slasher/enhanced
	pixel_x = -8
	base_pixel_x = -8

/mob/living/carbon/human/necromorph/slasher/enhanced/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.enhanced_slasher_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/slasher/enhanced
	display_name = "Enhanced Slasher"
	desc = "The frontline soldier of the necromorph horde. Slow when not charging, but its blade arms make for powerful melee attacks"
	ui_icon = 'deadspace/icons/necromorphs/slasher_enhanced.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/slasher/enhanced
	nest_allowed = TRUE
	tier = 2
	biomass_cost = 125
	biomass_spent_required = 680
	melee_damage_lower = 18
	melee_damage_upper = 22
	max_health = 215
	actions = list(
		/datum/action/cooldown/necro/charge/slasher/enhanced = COMSIG_KB_NECROMORPH_ABILITY_CHARGE_DOWN,
		/datum/action/cooldown/necro/dodge/enhanced = COMSIG_KB_NECROMORPH_ABILITY_DODGE_DOWN,
		/datum/action/cooldown/necro/shout = COMSIG_KB_NECROMORPH_ABILITY_SHOUT_DOWN,
		/datum/action/cooldown/necro/scream = COMSIG_KB_NECROMORPH_ABILITY_SCREAM_DOWN,
	)
	minimap_icon = "e_slasher"
	implemented = TRUE

/datum/species/necromorph/slasher/enhanced
	name = "Enhanced Slasher"
	id = SPECIES_NECROMORPH_SLASHER_ENHANCED
	burnmod = 1.1
	speedmod = 1.5
	species_mob_size = MOB_SIZE_LARGE
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/slasher/enhanced,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/slasher/enhanced,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/slasher/enhanced,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/slasher/enhanced,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/slasher/enhanced,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/slasher/enhanced,
	)

	deathsound = list(
		'deadspace/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_1.ogg',
		'deadspace/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_2.ogg',
		'deadspace/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_3.ogg'
	)

/datum/species/necromorph/slasher/enhanced/get_scream_sound(mob/living/carbon/human/necromorph/slasher/enhanced)
	return pick(
		'deadspace/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_extreme.ogg',
		'deadspace/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_3.ogg',
		'deadspace/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_5.ogg',
	)

/datum/action/cooldown/necro/charge/slasher/enhanced
	cooldown_time = 20 SECONDS
	charge_delay = 0.75 SECONDS
	charge_time = 4 SECONDS

/datum/action/cooldown/necro/dodge/enhanced
	cooldown_time = 6 SECONDS
