/mob/living/carbon/human/necromorph/leaper/hopper
	class = /datum/necro_class/leaper/hopper
	necro_species = /datum/species/necromorph/leaper/hopper
	pixel_x = 0
	pixel_y = 0
	base_pixel_x = 0
	base_pixel_y = 0
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/leaper/hopper,
		/obj/item/bodypart/head/necromorph/leaper/hopper,
		/obj/item/bodypart/leg/left/necromorph/leaper/hopper,
		/obj/item/bodypart/leg/right/necromorph/leaper/hopper,
	)

/mob/living/carbon/human/necromorph/leaper/hopper/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.leaper_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/leaper/hopper
	display_name = "Hopper"
	desc = "A long range ambusher, the leaper can leap on unsuspecting victims from afar, knock them down, and tear them apart with its bladed tail. Not good for prolonged combat though."
	ui_icon = 'necromorphs/icons/necromorphs/leaper_hopper.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/leaper/hopper
	nest_allowed = TRUE
	biomass_cost = 50
	biomass_spent_required = 0
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "hopper"
	implemented = FALSE

/datum/species/necromorph/leaper/hopper
	name = "Hopper"
	id = SPECIES_NECROMORPH_LEAPER_HOPPER
	speedmod = 1.5
	bodypart_overrides = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/leaper/hopper,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/leaper/hopper,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/leaper/hopper,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/leaper/hopper,
	)
