/mob/living/carbon/human/necromorph/leaper
	class = /datum/necro_class/leaper
	necro_species = /datum/species/necromorph/leaper
	pixel_x = -16
	pixel_y = -18
	base_pixel_x = -16
	base_pixel_y = -18
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/leaper,
		/obj/item/bodypart/head/necromorph/leaper,
		/obj/item/bodypart/arm/left/necromorph/leaper,
		/obj/item/bodypart/arm/right/necromorph/leaper,
		/obj/item/bodypart/leg/left/necromorph/leaper,
		/obj/item/bodypart/leg/right/necromorph/leaper,
	)

/mob/living/carbon/human/necromorph/leaper/Initialize(mapload, obj/structure/marker/marker_master)
	. = ..()
	AddComponent(/datum/component/wallrun)

/mob/living/carbon/human/necromorph/leaper/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.leaper_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/leaper
	display_name = "Leaper"
	desc = "A long range ambusher, the leaper can leap or gallop onto a victim, knock them down, and then tear them apart with its bladed tails and claws. Best at hit and run tactics."
	ui_icon = 'deadspace/icons/necromorphs/leaper.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/leaper
	tier = 1
	nest_allowed = TRUE
	biomass_cost = 65
	biomass_spent_required = 0
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 110
	armor = list(BLUNT = 55, PUNCTURE = 25, SLASH = 15, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 50, FIRE = 0, ACID = 80)
	actions = list(
		/datum/action/cooldown/necro/charge/leaper,
		/datum/action/cooldown/necro/swing/leaper,
		/datum/action/cooldown/necro/active/gallop,
		/datum/action/cooldown/necro/shout,
	)
	minimap_icon = "leaper"
	implemented = TRUE

/datum/species/necromorph/leaper
	name = "Leaper"
	id = SPECIES_NECROMORPH_LEAPER
	speedmod = 1.5
	bodypart_overrides = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/leaper,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/leaper,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/leaper,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/leaper,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/leaper,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/leaper,
	)

	special_step_sounds = list(
		'deadspace/sound/effects/footstep/leaper_footstep_1.ogg',
		'deadspace/sound/effects/footstep/leaper_footstep_2.ogg',
		'deadspace/sound/effects/footstep/leaper_footstep_3.ogg',
		'deadspace/sound/effects/footstep/leaper_footstep_4.ogg',
		'deadspace/sound/effects/footstep/leaper_footstep_5.ogg',
	)

/datum/species/necromorph/leaper/get_scream_sound(mob/living/carbon/human/necromorph/leaper)
	return pick(
		'deadspace/sound/effects/creatures/necromorph/leaper/leaper_pain_5.ogg',
		'deadspace/sound/effects/creatures/necromorph/leaper/leaper_pain_6.ogg',
		'deadspace/sound/effects/creatures/necromorph/leaper/leaper_pain_7.ogg',
	)
