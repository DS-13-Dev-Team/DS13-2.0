/mob/living/carbon/human/necromorph/exploder
	class = /datum/necro_class/exploder
	necro_species = /datum/species/necromorph/exploder

/mob/living/carbon/human/necromorph/exploder/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.exploder_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/exploder
	display_name = "Exploder"
	desc = "An expendable suicide bomber, the exploder's sole purpose is to go out in a blaze of glory, and hopefully take a few people with it."
	ui_icon = 'necromorphs/icons/necromorphs/exploder/exploder.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/exploder
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
		/datum/action/cooldown/necro/shout,
	)
	minimap_icon = "exploder"

/datum/species/necromorph/exploder
	name = "Exploder"
	id = SPECIES_NECROMORPH_EXPLODER
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/exploder,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/exploder,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/exploder,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/exploder,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/exploder,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/exploder,
	)
