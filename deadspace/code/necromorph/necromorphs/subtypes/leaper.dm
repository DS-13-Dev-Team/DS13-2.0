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
	desc = "A long range ambusher, the leaper can leap on unsuspecting victims from afar, knock them down, and tear them apart with its bladed tail. Not good for prolonged combat though."
	ui_icon = 'deadspace/icons/necromorphs/leaper.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/leaper
	nest_allowed = TRUE
	biomass_cost = 50
	biomass_spent_required = 0
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
		/datum/action/cooldown/necro/charge/leaper = COMSIG_KB_NECROMORPH_ABILITY_CHARGE_DOWN,
		/datum/action/cooldown/necro/active/gallop = COMSIG_KB_NECROMORPH_ABILITY_GALLOP_DOWN,
		/datum/action/cooldown/necro/shout = COMSIG_KB_NECROMORPH_ABILITY_SHOUT_DOWN,
	)
	minimap_icon = "leaper"
	implemented = FALSE

/datum/species/necromorph/leaper
	name = "Leaper"
	id = SPECIES_NECROMORPH_LEAPER
	speedmod = 1.5
	bodypart_overrides = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/leaper,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/leaper,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/leaper,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/leaper,
	)

/datum/species/necromorph/leaper/get_scream_sound(mob/living/carbon/human/necromorph/leaper)
	return pick(
		'deadspace/sound/effects/creatures/necromorph/leaper/leaper_pain_5.ogg',
		'deadspace/sound/effects/creatures/necromorph/leaper/leaper_pain_6.ogg',
		'deadspace/sound/effects/creatures/necromorph/leaper/leaper_pain_7.ogg',
	)
