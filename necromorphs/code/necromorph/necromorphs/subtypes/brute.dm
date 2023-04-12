/mob/living/carbon/human/necromorph/brute
	class = /datum/necro_class/brute
	necro_species = /datum/species/necromorph/brute
	pixel_x = -16
	base_pixel_x = -16

/mob/living/carbon/human/necromorph/brute/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.brute_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/brute
	display_name = "Brute"
	desc = "A powerful linebreaker and assault specialist, the brute can smash through almost any obstacle, and its tough \
	frontal armor makes it perfect for assaulting entrenched positions.\nVery vulnerable to flanking attacks"
	ui_icon = 'necromorphs/icons/necromorphs/brute.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/brute
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 510
	actions = list(
		/datum/action/cooldown/necro/long_charge
	)
	minimap_icon = "brute"

/datum/species/necromorph/brute
	name = "Brute"
	id = SPECIES_NECROMORPH_BRUTE
	burnmod = 0.75
	stunmod = 0.15
	speedmod = 2
	species_mob_size = MOB_SIZE_LARGE
	special_step_sounds = list(
		'necromorphs/sound/effects/footstep/brute_step_1.ogg',
		'necromorphs/sound/effects/footstep/brute_step_2.ogg',
		'necromorphs/sound/effects/footstep/brute_step_3.ogg',
		'necromorphs/sound/effects/footstep/brute_step_4.ogg',
		'necromorphs/sound/effects/footstep/brute_step_5.ogg',
		'necromorphs/sound/effects/footstep/brute_step_6.ogg'
	)
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/brute,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/brute,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/brute,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/brute,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/brute,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/brute,
	)
