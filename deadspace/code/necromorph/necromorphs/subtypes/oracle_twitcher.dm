/mob/living/carbon/human/necromorph/twitcher/enhanced
	maxHealth = 210
	class = /datum/necro_class/twitcher/enhanced
	necro_species = /datum/species/necromorph/twitcher/enhanced
	pixel_x = -8
	base_pixel_x = -8
	dodge_pool_chance = 40
	dodge_pool_usage = 5

/datum/necro_class/twitcher/enhanced
	display_name = "Oracle Twitcher"
	desc = "Extremely rare twitcher variant achieved by infecting an oracle operative."
	ui_icon = 'deadspace/icons/necromorphs/twitcher_oracle.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/twitcher/enhanced
	tier = 2
	biomass_cost = 210
	biomass_spent_required = 1200
	melee_damage_lower = 18
	melee_damage_upper = 22
	armor = list(BLUNT = 50, PUNCTURE = 60, SLASH = 35, LASER = 0, ENERGY = 0, BOMB = 5, BIO = 65, FIRE = 25, ACID = 95)
	minimap_icon = "otwitcher"
	implemented = TRUE

/datum/species/necromorph/twitcher/enhanced
	name = "Oracle Twitcher"
	id = SPECIES_NECROMORPH_TWITCHER_ORACLE
	speedmod = 0.5 //Pretty close to the speed of a human
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/twitcher/enhanced,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/twitcher/enhanced,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/twitcher/enhanced,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/twitcher/enhanced,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/twitcher/enhanced,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/twitcher/enhanced,
	)
