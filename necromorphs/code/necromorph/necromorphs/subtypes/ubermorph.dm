/mob/living/carbon/human/necromorph/ubermorph
	class = /datum/necro_class/ubermorph
	necro_species = /datum/species/necromorph/ubermorph

/mob/living/carbon/human/necromorph/ubermorph/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.ubermorph_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/ubermorph
	display_name = "Ubermorph"
	desc = "A juvenile hivemind. Constantly regenerating, a nigh-immortal leader of the necromorph army. "
	ui_icon = 'necromorphs/icons/necromorphs/ubermorph.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/ubermorph
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "ubermorph"

/datum/species/necromorph/ubermorph
	name = "Ubermorph"
	id = SPECIES_NECROMORPH_UBERMORPH
	speedmod = 1.2
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/ubermorph,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/ubermorph,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/ubermorph,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/ubermorph,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/ubermorph,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/ubermorph,
	)
