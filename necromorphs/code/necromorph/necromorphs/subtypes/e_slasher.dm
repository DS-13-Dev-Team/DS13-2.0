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
	ui_icon = 'necromorphs/icons/necromorphs/slasher_enhanced.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/slasher/enhanced
	tier = 2
	biomass_cost = 125
	biomass_spent_required = 680
	melee_damage_lower = 18
	melee_damage_upper = 22
	max_health = 215
	actions = list(
		/datum/action/cooldown/necro/charge/slasher/enhanced,
		/datum/action/cooldown/necro/dodge/enhanced,
		/datum/action/cooldown/necro/shout,
		/datum/action/cooldown/necro/scream,
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
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_3.ogg'
	)

/datum/action/cooldown/necro/charge/slasher/enhanced
	cooldown_time = 20 SECONDS
	charge_delay = 0.75 SECONDS
	charge_time = 4 SECONDS

/datum/action/cooldown/necro/dodge/enhanced
	cooldown_time = 6 SECONDS
