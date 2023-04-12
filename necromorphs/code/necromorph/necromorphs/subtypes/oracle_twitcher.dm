/mob/living/carbon/human/necromorph/otwitcher
	class = /datum/necro_class/otwitcher
	necro_species = /datum/species/necromorph/otwitcher
	pixel_x = -8
	base_pixel_x = -8

/mob/living/carbon/human/necromorph/otwitcher/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.twitcher_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/otwitcher
	display_name = "Oracle Twitcher"
	desc = "Extremely rare twitcher variant achieved by infecting an oracle operative."
	ui_icon = 'necromorphs/icons/necromorphs/twitcher_oracle.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/otwitcher
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 210
	actions = list(
	)
	minimap_icon = "otwitcher"

/datum/species/necromorph/otwitcher
	name = "Oracle Twitcher"
	id = SPECIES_NECROMORPH_TWITCHER_ORACLE
	speedmod = 1.2
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/otwitcher,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/otwitcher,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/otwitcher,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/otwitcher,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/otwitcher,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/otwitcher,
	)
