/mob/living/carbon/human/necromorph/brute
	class = /datum/necro_class/brute
	necro_species = /datum/species/necromorph/brute

/mob/living/carbon/human/necromorph/brute/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.brute_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/brute
	display_name = "brute"
	desc = "The frontline soldier of the necromorph horde. Slow when not charging, but its blade arms make for powerful melee attacks"
	necromorph_type_path = /mob/living/carbon/human/necromorph/brute
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "brute"

/datum/species/necromorph/brute
	name = "Exploder"
	id = SPECIES_NECROMORPH_BRUTE
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/brute,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/brute,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph/brute,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph/brute,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph/brute,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph/brute,
	)
