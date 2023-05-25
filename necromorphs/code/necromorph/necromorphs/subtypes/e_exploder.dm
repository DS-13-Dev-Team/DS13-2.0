/mob/living/carbon/human/necromorph/exploder/enhanced
	class = /datum/necro_class/exploder/enhanced
	necro_species = /datum/species/necromorph/exploder/enhanced
	pixel_x = -8
	base_pixel_x = -8

/mob/living/carbon/human/necromorph/exploder/enhanced/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.exploder_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/exploder/enhanced
	display_name = "Enhanced Exploder"
	desc = "An expendable suicide bomber, the exploder's sole purpose is to go out in a blaze of glory, and hopefully take a few people with it."
	ui_icon = 'necromorphs/icons/necromorphs/exploder/exploder_enhanced.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/exploder/enhanced
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
		/datum/action/cooldown/necro/shout,
	)
	minimap_icon = "e_exploder"
	implemented = FALSE

/datum/species/necromorph/exploder/enhanced
	name = "Enhanced Exploder"
	id = SPECIES_NECROMORPH_EXPLODER_ENHANCED
	speedmod = 1.7
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/exploder/enhanced,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/exploder/enhanced,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/exploder/enhanced,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/exploder/enhanced,
	)
