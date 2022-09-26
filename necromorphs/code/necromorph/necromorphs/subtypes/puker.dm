/datum/necro_class/puker
	display_name = "puker"
	desc = "A tough and flexible elite who fights by dousing enemies in acid, and is effective at all ranges. Good for crowd control and direct firefights"
	necromorph_type_path = /mob/living/carbon/necromorph/puker
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "puker"

/mob/living/carbon/necromorph/puker
	class = /datum/necro_class/puker
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/puker,
		/obj/item/bodypart/head/necromorph/puker,
		/obj/item/bodypart/l_arm/necromorph/puker,
		/obj/item/bodypart/r_arm/necromorph/puker,
		/obj/item/bodypart/l_leg/necromorph/puker,
		/obj/item/bodypart/r_leg/necromorph/puker,
		)

/mob/living/carbon/necromorph/puker/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.puker_sounds[audio_type]), volume, vary, extra_range)
