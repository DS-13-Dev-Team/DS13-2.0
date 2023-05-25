/mob/living/carbon/human/necromorph/leaper/enhanced
	class = /datum/necro_class/leaper/enhanced
	necro_species = /datum/species/necromorph/leaper/enhanced
	pixel_x = -16
	pixel_y = -18
	base_pixel_x = -16
	base_pixel_y = -18
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/leaper/enhanced,
		/obj/item/bodypart/head/necromorph/leaper/enhanced,
		/obj/item/bodypart/leg/left/necromorph/leaper/enhanced,
		/obj/item/bodypart/leg/right/necromorph/leaper/enhanced,
	)

/mob/living/carbon/human/necromorph/leaper/enhanced/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.leaper_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/leaper/enhanced
	display_name = "Enhanced Leaper"
	desc = "A long range ambusher, the leaper can leap on unsuspecting victims from afar, knock them down, and tear them apart with its bladed tail. Not good for prolonged combat though."
	ui_icon = 'necromorphs/icons/necromorphs/leaper.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/leaper/enhanced
	nest_allowed = TRUE
	biomass_cost = 50
	biomass_spent_required = 0
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "e_leaper"
	implemented = FALSE

/datum/species/necromorph/leaper/enhanced
	name = "Enhanced Leaper"
	id = SPECIES_NECROMORPH_LEAPER_ENHANCED
	speedmod = 1.5
	bodypart_overrides = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/leaper/enhanced,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/leaper/enhanced,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/leaper/enhanced,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/leaper/enhanced,
	)
	external_organs = list(
		/obj/item/organ/external/tail/necromorph/leaper/enhanced = "Leaper Tail",
	)
