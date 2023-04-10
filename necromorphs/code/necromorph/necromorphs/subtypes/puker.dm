/mob/living/carbon/human/necromorph/puker
	class = /datum/necro_class/puker
	necro_species = /datum/species/necromorph/puker

/mob/living/carbon/human/necromorph/puker/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.puker_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/puker
	display_name = "Puker"
	desc = "A tough and flexible elite who fights by dousing enemies in acid, and is effective at all ranges. Good for crowd control and direct firefights"
	ui_icon = 'necromorphs/icons/necromorphs/puker/puker.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/puker
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "puker"

/datum/species/necromorph/puker
	name = "Puker"
	id = SPECIES_NECROMORPH_PUKER
	speedmod = 1.6
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/puker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/puker,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/puker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/puker,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/puker,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/puker,
	)
