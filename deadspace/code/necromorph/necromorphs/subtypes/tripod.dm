/mob/living/carbon/human/necromorph/tripod
	maxHealth = 475
	class = /datum/necro_class/tripod
	necro_species = /datum/species/necromorph/tripod
	pixel_x = -54
	base_pixel_x = -54

/mob/living/carbon/human/necromorph/tripod/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.tripod_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/tripod
	display_name = "Tripod"
	desc = "A heavy skirmisher, the tripod is adept at leaping around open spaces and fighting against multiple distant targets."
	ui_icon = 'deadspace/icons/necromorphs/tripod.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/tripod
	melee_damage_lower = 10
	melee_damage_upper = 16
	actions = list(
	)
	minimap_icon = "tripod"

/datum/species/necromorph/tripod
	name = "Tripod"
	id = SPECIES_NECROMORPH_TRIPOD
	speedmod = 1.5
	burnmod = 1
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/tripod,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/tripod,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/tripod,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/tripod,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/tripod,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/tripod,
	)

/datum/species/necromorph/tripod/get_scream_sound(mob/living/carbon/human/necromorph/tripod)
	return pick(
		'deadspace/sound/effects/creatures/necromorph/tripod/tripod_shout_1.ogg',
		'deadspace/sound/effects/creatures/necromorph/tripod/tripod_shout_4.ogg',
		'deadspace/sound/effects/creatures/necromorph/tripod/tripod_shout_long_3.ogg',
		'deadspace/sound/effects/creatures/necromorph/tripod/tripod_shout_long_5.ogg',
	)
