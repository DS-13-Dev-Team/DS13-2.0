/mob/living/carbon/human/necromorph/twitcher
	class = /datum/necro_class/twitcher
	necro_species = /datum/species/necromorph/twitcher
	pixel_x = -8
	base_pixel_x = -8

/mob/living/carbon/human/necromorph/twitcher/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.twitcher_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/twitcher
	display_name = "Twitcher"
	desc = "An elite soldier displaced in time, blinks around randomly and is difficult to hit. Charges extremely quickly"
	ui_icon = 'deadspace/icons/necromorphs/twitcher.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/twitcher
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 110
	actions = list(
	)
	minimap_icon = "twitcher"

/datum/species/necromorph/twitcher
	name = "Twitcher"
	id = SPECIES_NECROMORPH_TWITCHER
	speedmod = 0.8
	burnmod = 1.1
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/twitcher,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/twitcher,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/twitcher,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/twitcher,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/twitcher,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/twitcher,
	)

/datum/species/necromorph/twitcher/get_scream_sound(mob/living/carbon/human/necromorph/twitcher)
	return pick(
		'deadspace/sound/effects/creatures/necromorph/twitcher/twitcher_shout_long_2.ogg',
		'deadspace/sound/effects/creatures/necromorph/twitcher/twitcher_shout_long_5.ogg',
		'deadspace/sound/effects/creatures/necromorph/twitcher/twitcher_shout_long_2.ogg',
		'deadspace/sound/effects/creatures/necromorph/twitcher/twitcher_shout_1.ogg',
	)
