/mob/living/carbon/human/necromorph/lurker
	class = /datum/necro_class/lurker
	necro_species = /datum/species/necromorph/lurker
	pixel_x = -16
	base_pixel_x = -16

/mob/living/carbon/human/necromorph/lurker/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.lurker_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/lurker
	display_name = "Lurker"
	desc = "An elite soldier displaced in time, blinks around randomly and is difficult to hit. Charges extremely quickly"
	ui_icon = 'necromorphs/icons/necromorphs/lurker/lurker.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/lurker
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 65
	actions = list(
	)
	minimap_icon = "lurker"

/datum/species/necromorph/lurker
	name = "Lurker"
	id = SPECIES_NECROMORPH_LURKER
	speedmod = 1.4
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/lurker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/lurker,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/lurker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/lurker,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/lurker,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/lurker,
	)
