/datum/necro_class/brute
	display_name = "brute"
	desc = "The frontline soldier of the necromorph horde. Slow when not charging, but its blade arms make for powerful melee attacks"
	necromorph_type_path = /mob/living/carbon/necromorph/brute
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "brute"

/mob/living/carbon/necromorph/brute
	class = /datum/necro_class/brute
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/brute,
		/obj/item/bodypart/head/necromorph/brute,
		/obj/item/bodypart/l_arm/necromorph/brute,
		/obj/item/bodypart/r_arm/necromorph/brute,
		/obj/item/bodypart/l_leg/necromorph/brute,
		/obj/item/bodypart/r_leg/necromorph/brute,
		)

/mob/living/carbon/necromorph/brute/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.brute_sounds[audio_type]), volume, vary, extra_range)
