/mob/living/carbon/human/necromorph/exploder
	class = /datum/necro_class/exploder
	necro_species = /datum/species/necromorph/exploder
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/exploder,
		/obj/item/bodypart/head/necromorph/exploder,
		/obj/item/bodypart/arm/left/necromorph/exploder,
		/obj/item/bodypart/arm/right/necromorph/exploder,
		/obj/item/bodypart/leg/left/necromorph/exploder,
		/obj/item/bodypart/leg/right/necromorph/exploder,
	)

/mob/living/carbon/human/necromorph/exploder/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.exploder_sounds[audio_type]), volume, vary, extra_range)

/mob/living/carbon/human/necromorph/exploder/has_hand_for_held_index(i)
	return TRUE //Exploders don't have real arms, so we need to do some weird stuff to prevent runtimes

/datum/necro_class/exploder
	display_name = "Exploder"
	desc = "An expendable suicide bomber, the exploder's sole purpose is to go out in a blaze of glory, and hopefully take a few people with it."
	ui_icon = 'deadspace/icons/necromorphs/exploder/exploder.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/exploder
	tier = 1
	biomass_cost = 75
	biomass_spent_required = 0
	melee_damage_lower = 4
	melee_damage_upper = 8
	max_health = 100
	armor = list(BLUNT = 25, PUNCTURE = 30, SLASH = 5, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 65, FIRE = 0, ACID = 100)
	actions = list(
		/datum/action/cooldown/necro/shout,
		/datum/action/cooldown/necro/explode,
		/datum/action/cooldown/necro/charge/exploder,
	)
	minimap_icon = "exploder"
	implemented = TRUE
	nest_allowed = TRUE

/datum/species/necromorph/exploder
	name = "Exploder"
	id = SPECIES_NECROMORPH_EXPLODER
	speedmod = 1.7
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/exploder,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/exploder,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/exploder,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/exploder,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/exploder,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/exploder,
	)

	special_step_sounds = list(
		'deadspace/sound/effects/footstep/exploder_footstep_1.ogg',
		'deadspace/sound/effects/footstep/exploder_footstep_2.ogg',
		'deadspace/sound/effects/footstep/exploder_footstep_3.ogg',
		'deadspace/sound/effects/footstep/exploder_footstep_4.ogg',
		'deadspace/sound/effects/footstep/exploder_footstep_5.ogg',
		'deadspace/sound/effects/footstep/exploder_footstep_6.ogg',
		'deadspace/sound/effects/footstep/exploder_footstep_7.ogg',
	)

/datum/species/necromorph/exploder/get_scream_sound(mob/living/carbon/human/necromorph/exploder)
	return pick(
		'deadspace/sound/effects/creatures/necromorph/exploder/exploder_pain_1.ogg',
		'deadspace/sound/effects/creatures/necromorph/exploder/exploder_pain_2.ogg',
		'deadspace/sound/effects/creatures/necromorph/exploder/exploder_pain_3.ogg',
		'deadspace/sound/effects/creatures/necromorph/exploder/exploder_pain_4.ogg',
		'deadspace/sound/effects/creatures/necromorph/exploder/exploder_pain_5.ogg',
	)

/datum/species/necromorph/exploder/get_deathgasp_sound(mob/living/carbon/human/H)
	return pick(
		'deadspace/sound/effects/creatures/necromorph/exploder/exploder_death_1.ogg',
		'deadspace/sound/effects/creatures/necromorph/exploder/exploder_death_2.ogg',
		'deadspace/sound/effects/creatures/necromorph/exploder/exploder_death_3.ogg',
	)
