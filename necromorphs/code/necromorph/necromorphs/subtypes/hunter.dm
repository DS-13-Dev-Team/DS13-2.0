/mob/living/carbon/human/necromorph/hunter
	class = /datum/necro_class/hunter
	necro_species = /datum/species/necromorph/hunter

/mob/living/carbon/human/necromorph/hunter/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.hunter_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/hunter
	display_name = "Hunter"
	desc = "A rapidly regenerating vanguard, designed to lead the charge, suffer a glorious death, then get back up and do it again. \
	Avoid fire though."
	ui_icon = 'necromorphs/icons/necromorphs/hunter.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/hunter
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 100
	actions = list(
	)
	minimap_icon = "hunter"

/datum/species/necromorph/hunter
	name = "Hunter"
	id = SPECIES_NECROMORPH_HUNTER
	speedmod = 1.6
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/hunter,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/hunter,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/hunter,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/hunter,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/hunter,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/hunter,
	)
