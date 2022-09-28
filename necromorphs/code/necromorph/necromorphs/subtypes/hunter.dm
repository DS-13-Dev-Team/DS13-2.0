/datum/necro_class/hunter
	display_name = "hunter"
	desc = "A rapidly regenerating vanguard, designed to lead the charge, suffer a glorious death, then get back up and do it again.\
	Avoid fire though."
	necromorph_type_path = /mob/living/carbon/necromorph/hunter
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "hunter"

/mob/living/carbon/necromorph/hunter
	class = /datum/necro_class/hunter
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/hunter,
		/obj/item/bodypart/head/necromorph/hunter,
		/obj/item/bodypart/l_arm/necromorph/hunter,
		/obj/item/bodypart/r_arm/necromorph/hunter,
		/obj/item/bodypart/l_leg/necromorph/hunter,
		/obj/item/bodypart/r_leg/necromorph/hunter,
		)

/mob/living/carbon/necromorph/hunter/play_necro_sound(audio_type, volume, vary, extra_range)
//	playsound(src, pick(GLOB.hunter_sounds[audio_type]), volume, vary, extra_range)
