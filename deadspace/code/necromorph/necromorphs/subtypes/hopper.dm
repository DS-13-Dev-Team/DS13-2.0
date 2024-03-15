/mob/living/carbon/human/necromorph/leaper/hopper
	class = /datum/necro_class/leaper/hopper
	necro_species = /datum/species/necromorph/leaper/hopper
	//Hoppers get their own AI for when they aren't being player controlled
	ai_controller = /datum/ai_controller/necromorph
	pass_flags = PASSTABLE | PASSFLAPS
	pixel_x = 0
	pixel_y = 0
	base_pixel_x = 0
	base_pixel_y = 0
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph/leaper/hopper,
		/obj/item/bodypart/head/necromorph/leaper/hopper,
		/obj/item/bodypart/leg/left/necromorph/leaper/hopper,
		/obj/item/bodypart/leg/right/necromorph/leaper/hopper,
		/obj/item/bodypart/arm/right/necromorph/leaper/hopper,
		/obj/item/bodypart/arm/left/necromorph/leaper/hopper
	)

/mob/living/carbon/human/necromorph/leaper/hopper/Initialize(mapload, obj/structure/marker/marker_master)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/carbon/human/necromorph/leaper/hopper/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.leaper_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/leaper/hopper
	display_name = "Hopper"
	desc = "A small ambush and flanking necromorph. Used as scouts and spies, these little monsters can easily hide under objects and scurry into vents. Fares very poorly against armored targets. Will be AI controlled when not being used by a signal."
	ui_icon = 'deadspace/icons/necromorphs/leaper_hopper.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/leaper/hopper
	tier = 0
	nest_allowed = FALSE
	biomass_cost = 38
	biomass_spent_required = 0
	melee_damage_lower = 6
	melee_damage_upper = 10
	max_health = 65
	//Hoppers have really low health, but for balance purposes can tank bullets quite well.
	armor = list(BLUNT = 25, PUNCTURE = 30, SLASH = 10, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 50, FIRE = 0, ACID = 80)
	actions = list(
		/datum/action/cooldown/necro/hide,
		/datum/action/cooldown/necro/charge/leaper,
		/datum/action/cooldown/necro/active/gallop/hopper,
		/datum/action/cooldown/necro/shout,
	)
	minimap_icon = "hopper"
	implemented = TRUE

/datum/species/necromorph/leaper/hopper
	name = "Hopper"
	id = SPECIES_NECROMORPH_LEAPER_HOPPER
	speedmod = 0.5 //Almost as fast as a person, absolutely terrifying
	bodypart_overrides = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/leaper/hopper,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/leaper/hopper,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/leaper/hopper,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/leaper/hopper,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/leaper/hopper,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/leaper/hopper
	)
