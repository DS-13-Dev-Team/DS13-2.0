/mob/living/carbon/human/necromorph/slasher
	class = /datum/necro_class/slasher
	necro_species = /datum/species/necromorph/slasher

/mob/living/carbon/human/necromorph/slasher/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.slasher_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/slasher
	display_name = "Slasher"
	desc = "The frontline soldier of the necromorph horde. Slow when not charging, but its blade arms make for powerful melee attacks"
	necromorph_type_path = /mob/living/carbon/human/necromorph/slasher
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
		/datum/action/cooldown/necro/charge/slasher,
		/datum/action/cooldown/necro/shout,
		/datum/action/cooldown/necro/dodge,
	)
	minimap_icon = "slasher"

/datum/species/necromorph/slasher
	name = "Slasher"
	id = SPECIES_NECROMORPH_SLASHER
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph/slasher,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph/slasher,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/slasher,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph/slasher,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph/slasher,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/slasher,
	)
