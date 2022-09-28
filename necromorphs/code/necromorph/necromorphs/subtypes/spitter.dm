/datum/necro_class/spitter
	display_name = "spitter"
	desc = "A midline skirmisher with the ability to spit acid at medium range. Works best when accompanied by slashers to protect it from attacks. Weak and fragile in direct combat."
	necromorph_type_path = /mob/living/carbon/necromorph/spitter
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "spitter"

/mob/living/carbon/necromorph/spitter
	class = /datum/necro_class/spitter
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/spitter,
		/obj/item/bodypart/head/necromorph/spitter,
		/obj/item/bodypart/l_arm/necromorph/spitter,
		/obj/item/bodypart/r_arm/necromorph/spitter,
		/obj/item/bodypart/l_leg/necromorph/spitter,
		/obj/item/bodypart/r_leg/necromorph/spitter,
		)

/mob/living/carbon/necromorph/spitter/play_necro_sound(audio_type, volume, vary, extra_range)
//	playsound(src, pick(GLOB.spitter_sounds[audio_type]), volume, vary, extra_range)
