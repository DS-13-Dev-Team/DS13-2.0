/obj/item/bodypart/chest/necromorph/leaper/hopper
	name = BODY_ZONE_CHEST
	limb_id = SPECIES_NECROMORPH_LEAPER_HOPPER
	icon_static = 'deadspace/icons/necromorphs/leaper_hopper.dmi'
	icon_state = "chest"
	max_damage = 100
	px_x = 0
	px_y = 0
	wound_resistance = 0
	biomass = 4

/obj/item/bodypart/head/necromorph/leaper/hopper
	name = BODY_ZONE_HEAD
	limb_id = SPECIES_NECROMORPH_LEAPER_HOPPER
	icon_static = 'deadspace/icons/necromorphs/leaper_hopper.dmi'
	icon_state = "head"
	max_damage = 15
	px_x = 0
	px_y = -8
	wound_resistance = -5
	biomass = 2

//Leapers use arms to walk
/obj/item/bodypart/leg/left/necromorph/leaper/hopper
	name = "left arm"
	limb_id = SPECIES_NECROMORPH_LEAPER_HOPPER
	bodypart_flags = (BP_IS_MOVEMENT_LIMB | BP_IS_GRABBY_LIMB | BP_NO_PAIN | BP_HAS_BLOOD | BP_CAN_BE_DISLOCATED)
	icon_static = 'deadspace/icons/necromorphs/leaper_hopper.dmi'
	icon_state = "l_leg"
	body_part = LEG_LEFT
	max_damage = 15
	px_x = -2
	px_y = 12
	wound_resistance = -10
	biomass = 2

/obj/item/bodypart/leg/right/necromorph/leaper/hopper
	name = "right arm"
	limb_id = SPECIES_NECROMORPH_LEAPER_HOPPER
	bodypart_flags = (BP_IS_MOVEMENT_LIMB | BP_IS_GRABBY_LIMB | BP_NO_PAIN | BP_HAS_BLOOD | BP_CAN_BE_DISLOCATED)
	icon_static = 'deadspace/icons/necromorphs/leaper_hopper.dmi'
	icon_state = "r_leg"
	max_damage = 15
	px_x = 2
	px_y = 12
	wound_resistance = -10
	biomass = 2

/obj/item/bodypart/arm/right/necromorph/leaper/hopper
	name = "tail"
	limb_id = SPECIES_NECROMORPH_LEAPER_HOPPER
	bodypart_flags = (BP_NO_PAIN | BP_HAS_BLOOD | BP_CAN_BE_DISLOCATED)
	icon_static = 'deadspace/icons/necromorphs/leaper_hopper.dmi'
	icon_state = "r_arm"
	max_damage = 10
	wound_resistance = -10
	biomass = 1

/obj/item/bodypart/arm/left/necromorph/leaper/hopper
	name = "malformed tail"
	desc = "A tail that appears to not have grown correctly, it appears useless."
	limb_id = SPECIES_NECROMORPH_LEAPER_HOPPER
	bodypart_flags = (BP_NO_PAIN)
	dismemberable = FALSE
	is_pseudopart = TRUE
	icon_static = null
	icon_state = null
	max_damage = 10
	biomass = 1

