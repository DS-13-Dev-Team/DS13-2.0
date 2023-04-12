/mob/living/carbon/human/necromorph/divider
	class = /datum/necro_class/divider
	necro_species = /datum/species/necromorph/divider
	pixel_x = -8
	base_pixel_x = -8

/mob/living/carbon/human/necromorph/divider/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.divider_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/divider
	display_name = "Divider"
	desc = "A bizarre walking horrorshow, slow but extremely durable. On death, it splits into five smaller creatures, in an attempt to find a new body to control. The divider is hard to kill, and has several abilities which excel at pinning down a lone target."
	ui_icon = 'necromorphs/icons/necromorphs/divider.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/divider
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 300
	actions = list(
	)
	minimap_icon = "divider"

/datum/species/necromorph/divider
	name = "Divider"
	id = SPECIES_NECROMORPH_DIVIDER
	speedmod = 0.8
	speedmod = 1.4
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/divider,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/divider,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/divider,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/divider,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/divider,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/divider,
	)
