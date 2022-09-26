/datum/necro_class/exploder
	display_name = "exploder"
	desc = "An expendable suicide bomber, the exploder's sole purpose is to go out in a blaze of glory, and hopefully take a few people with it."
	necromorph_type_path = /mob/living/carbon/necromorph/exploder
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "exploder"

/mob/living/carbon/necromorph/exploder
	class = /datum/necro_class/exploder
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/exploder,
		/obj/item/bodypart/head/necromorph/exploder,
		/obj/item/bodypart/l_arm/necromorph/exploder,
		/obj/item/bodypart/r_arm/necromorph/exploder,
		/obj/item/bodypart/l_leg/necromorph/exploder,
		/obj/item/bodypart/r_leg/necromorph/exploder,
		)

/mob/living/carbon/necromorph/exploder/play_necro_sound(audio_type, volume, vary, extra_range)
//	playsound(src, pick(GLOB.exploder_sounds[audio_type]), volume, vary, extra_range)
