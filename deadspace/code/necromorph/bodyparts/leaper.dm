/obj/item/bodypart/chest/necromorph/leaper
	name = BODY_ZONE_CHEST
	limb_id = SPECIES_NECROMORPH_LEAPER
	icon_static = 'deadspace/icons/necromorphs/leaper.dmi'
	icon_state = "chest"
	max_damage = 200
	biomass = 10
	wound_resistance = 5
	px_x = 0
	px_y = 0

/obj/item/bodypart/head/necromorph/leaper
	name = BODY_ZONE_HEAD
	limb_id = SPECIES_NECROMORPH_LEAPER
	icon_static = 'deadspace/icons/necromorphs/leaper.dmi'
	icon_state = "head"
	max_damage = 65
	biomass = 3
	wound_resistance = 0
	px_x = 0
	px_y = -8
	base_pixel_x = -12
	base_pixel_y = -11

//Leapers use arms to walk
/obj/item/bodypart/arm/left/necromorph/leaper
	name = "left arm"
	limb_id = SPECIES_NECROMORPH_LEAPER
	icon_static = 'deadspace/icons/necromorphs/leaper.dmi'
	icon_state = "l_arm"
	bodypart_flags = (BP_IS_MOVEMENT_LIMB | BP_IS_GRABBY_LIMB | BP_NO_PAIN | BP_HAS_BLOOD | BP_CAN_BE_DISLOCATED)
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	biomass = 6
	wound_resistance = -3
	px_x = -2
	px_y = 12

/obj/item/bodypart/arm/right/necromorph/leaper
	name = "right arm"
	limb_id = SPECIES_NECROMORPH_LEAPER
	icon_static = 'deadspace/icons/necromorphs/leaper.dmi'
	icon_state = "r_arm"
	bodypart_flags = (BP_IS_MOVEMENT_LIMB | BP_IS_GRABBY_LIMB | BP_NO_PAIN | BP_HAS_BLOOD | BP_CAN_BE_DISLOCATED)
	attack_verb_continuous = list("claws", "stomps")
	attack_verb_simple = list("claws", "stomp")
	max_damage = 50
	biomass = 6
	wound_resistance = -3
	px_x = 2
	px_y = 12

//Leaper tails don't count as a movement limb, but are responsible for some very damaging combos
//Remove the tail, cripple their damage
/obj/item/bodypart/leg/right/necromorph/leaper
	name = "right tail"
	desc = "A long stringy piece of flesh held haphazardly together with tendons and bone, it looks very sharp at the tip."
	limb_id = SPECIES_NECROMORPH_LEAPER
	icon_static = 'deadspace/icons/necromorphs/leaper.dmi'
	icon_state = "r_leg" //Bodyparts are picky about dmi state names not lining up with the body_zone
	body_zone = BODY_ZONE_R_LEG
	plaintext_zone = "right tail"
	bodypart_flags = (BP_NO_PAIN | BP_HAS_BLOOD | BP_CAN_BE_DISLOCATED)
	attack_verb_continuous = list("stabs", "slices")
	attack_verb_simple = list("stabs", "slices")
	max_damage = 35
	force = 13 //You could probably use it like a knife or a whip if you are desperate
	throwforce = 20 //It's practically a limp spear
	biomass = 3.5 //The tail is practically a piece of flesh with a sharp bit at the end, not much biomass
	wound_resistance = -10
	sharpness = SHARP_POINTY
	base_pixel_x = -26
	base_pixel_y = -15
	can_be_disabled = FALSE

/obj/item/bodypart/leg/left/necromorph/leaper
	name = "left tail"
	desc = "A long stringy piece of flesh held haphazardly together with tendons and bone, it looks very sharp at the tip."
	limb_id = SPECIES_NECROMORPH_LEAPER
	icon_static = 'deadspace/icons/necromorphs/leaper.dmi'
	icon_state = "l_leg" //Bodyparts are picky about dmi state names not lining up with the body_zone
	body_zone = BODY_ZONE_L_LEG
	plaintext_zone = "left tail"
	bodypart_flags = (BP_NO_PAIN | BP_HAS_BLOOD | BP_CAN_BE_DISLOCATED)
	attack_verb_continuous = list("stabs", "slices")
	attack_verb_simple = list("stabs", "slices")
	max_damage = 35
	force = 13 //You could probably use it like a knife or a whip if you are desperate
	throwforce = 15 //It's practically a limp spear
	biomass = 3.5
	wound_resistance = -10
	sharpness = SHARP_POINTY
	base_pixel_x = -26
	base_pixel_y = -15
	can_be_disabled = FALSE


