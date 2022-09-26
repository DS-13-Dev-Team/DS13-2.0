/datum/necro_class/ubermorph
	display_name = "ubermorph"
	desc = "A juvenile hivemind. Constantly regenerating, a nigh-immortal leader of the necromorph army. "
	necromorph_type_path = /mob/living/carbon/necromorph/ubermorph
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "ubermorph"

/mob/living/carbon/necromorph/ubermorph
	class = /datum/necro_class/ubermorph
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/ubermorph,
		/obj/item/bodypart/head/necromorph/ubermorph,
		/obj/item/bodypart/l_arm/necromorph/ubermorph,
		/obj/item/bodypart/r_arm/necromorph/ubermorph,
		/obj/item/bodypart/l_leg/necromorph/ubermorph,
		/obj/item/bodypart/r_leg/necromorph/ubermorph,
		)

/mob/living/carbon/necromorph/ubermorph/play_necro_sound(audio_type, volume, vary, extra_range)
//	playsound(src, pick(GLOB.ubermorph_sounds[audio_type]), volume, vary, extra_range)
