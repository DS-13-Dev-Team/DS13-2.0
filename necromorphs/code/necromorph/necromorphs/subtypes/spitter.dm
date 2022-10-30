/mob/living/carbon/human/necromorph/spitter
	class = /datum/necro_class/spitter
	necro_species = /datum/species/necromorph/spitter

/mob/living/carbon/human/necromorph/spitter/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.spitter_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/spitter
	display_name = "Spitter"
	desc = "A midline skirmisher with the ability to spit acid at medium range. Works best when accompanied by slashers to protect it from attacks. Weak and fragile in direct combat."
	ui_icon = 'necromorphs/icons/necromorphs/spitter.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/spitter
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "spitter"

/datum/species/necromorph/spitter
	name = "Spitter"
	id = SPECIES_NECROMORPH_SPITTER
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph/spitter,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph/spitter,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/slasher,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph/spitter,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph/spitter,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/spitter,
	)
