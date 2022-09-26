/datum/necro_class/twitcher
	display_name = "twitcher"
	desc = "An elite soldier displaced in time, blinks around randomly and is difficult to hit. Charges extremely quickly"
	necromorph_type_path = /mob/living/carbon/necromorph/twitcher
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "twitcher"

/mob/living/carbon/necromorph/twitcher
	class = /datum/necro_class/twitcher
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/twitcher,
		/obj/item/bodypart/head/necromorph/twitcher,
		/obj/item/bodypart/l_arm/necromorph/twitcher,
		/obj/item/bodypart/r_arm/necromorph/twitcher,
		/obj/item/bodypart/l_leg/necromorph/twitcher,
		/obj/item/bodypart/r_leg/necromorph/twitcher,
		)

/mob/living/carbon/necromorph/twitcher/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.twitcher_sounds[audio_type]), volume, vary, extra_range)
