/datum/necro_class/leaper
	display_name = "leaper"
	desc = "A long range ambusher, the leaper can leap on unsuspecting victims from afar, knock them down, and tear them apart with its bladed tail. Not good for prolonged combat though."
	necromorph_type_path = /mob/living/carbon/necromorph/leaper
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
		/datum/action/cooldown/necro/leap,
		/datum/action/cooldown/necro/dash
	)
	minimap_icon = "leaper"



/mob/living/carbon/necromorph/leaper
	class = /datum/necro_class/leaper

	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/leaper,
		/obj/item/bodypart/head/necromorph/leaper,
		/obj/item/bodypart/l_arm/necromorph/leaper,
		/obj/item/bodypart/r_arm/necromorph/leaper,
		)

/mob/living/carbon/necromorph/leaper/create_internal_organs()
	internal_organs += new /obj/item/organ/external/tail/necromorph/leaper
	..()

/mob/living/carbon/necromorph/leaper/play_necro_sound(audio_type, volume, vary, extra_range)
//	playsound(src, pick(GLOB.leaper_sounds[audio_type]), volume, vary, extra_range)
