/datum/necro_class/lurker
	display_name = "lurker"
	desc = "Long range fire-support. The lurker is tough and hard to hit as long as its retractible armor is closed. When open it is slow and vulnerable, but fires sharp spines in waves of three."
	necromorph_type_path = /mob/living/carbon/necromorph/lurker
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "lurker"

	var/list/tentacles = list()

/mob/living/carbon/necromorph/lurker
	class = /datum/necro_class/lurker
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/lurker,
		/obj/item/bodypart/head/necromorph/lurker,
		/obj/item/bodypart/l_arm/necromorph/lurker,
		/obj/item/bodypart/r_arm/necromorph/lurker,
		/obj/item/bodypart/l_leg/necromorph/lurker,
		/obj/item/bodypart/r_leg/necromorph/lurker,
		)

/mob/living/carbon/necromorph/lurker/play_necro_sound(audio_type, volume, vary, extra_range)
//	playsound(src, pick(GLOB.lurker_sounds[audio_type]), volume, vary, extra_range)

/mob/living/carbon/necromorph/lurker/create_internal_organs()
	internal_organs += new /obj/item/organ/necromorph/lurker/tentacle
	..()

/mob/living/carbon/necromorph/lurker/Initialize(mapload, marker_master)
	var/static/list/icon/tentacles
	if(isnull(tentacles))
		tentacles = list(
			iconstate2appearance(icon, "necromorph_tentacle_1"),
			iconstate2appearance(icon, "necromorph_tentacle_2"),
			iconstate2appearance(icon, "necromorph_tentacle_3"),
		)
	add_overlay(tentacles)
	return ..()

/obj/item/organ/necromorph/lurker/tentacle
	icon_state = "necromorph_tentacle_1"
	visual = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	zone = BODY_ZONE_CHEST
	maxHealth = STANDARD_ORGAN_THRESHOLD
	high_threshold = STANDARD_ORGAN_THRESHOLD * 0.45
	low_threshold = STANDARD_ORGAN_THRESHOLD * 0.1
