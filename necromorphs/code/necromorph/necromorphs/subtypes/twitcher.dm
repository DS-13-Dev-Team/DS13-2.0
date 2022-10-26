/mob/living/carbon/human/necromorph/twitcher
	class = /datum/necro_class/twitcher
	necro_species = /datum/species/necromorph/twitcher

/mob/living/carbon/human/necromorph/twitcher/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.twitcher_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/twitcher
	display_name = "twitcher"
	desc = "An elite soldier displaced in time, blinks around randomly and is difficult to hit. Charges extremely quickly"
	necromorph_type_path = /mob/living/carbon/human/necromorph/twitcher
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "twitcher"

/datum/species/necromorph/twitcher
	name = "Twitcher"
	id = SPECIES_NECROMORPH_TWITCHER
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph/twitcher,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph/twitcher,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/twitcher,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph/twitcher,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph/twitcher,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/twitcher,
	)
