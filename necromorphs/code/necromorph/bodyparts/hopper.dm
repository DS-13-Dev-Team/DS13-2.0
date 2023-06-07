/obj/item/bodypart/chest/necromorph/leaper/hopper
	name = BODY_ZONE_CHEST
	limb_id = SPECIES_NECROMORPH_LEAPER_HOPPER
	icon_static = 'necromorphs/icons/necromorphs/leaper_hopper.dmi'
	icon_state = "chest"
	max_damage = 200
	px_x = 0
	px_y = 0
	wound_resistance = 10

/obj/item/bodypart/head/necromorph/leaper/hopper
	name = BODY_ZONE_HEAD
	limb_id = SPECIES_NECROMORPH_LEAPER_HOPPER
	icon_static = 'necromorphs/icons/necromorphs/leaper_hopper.dmi'
	icon_state = "head"
	max_damage = 200
	px_x = 0
	px_y = -8
	wound_resistance = 5

//Leapers use arms to walk
/obj/item/bodypart/leg/left/necromorph/leaper/hopper
	name = "left arm"
	limb_id = SPECIES_NECROMORPH_LEAPER_HOPPER
	icon_static = 'necromorphs/icons/necromorphs/leaper_hopper.dmi'
	icon_state = "l_leg"
	body_part = LEG_LEFT
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 12
	wound_resistance = 0

/obj/item/bodypart/leg/right/necromorph/leaper/hopper
	name = "right arm"
	limb_id = SPECIES_NECROMORPH_LEAPER_HOPPER
	icon_static = 'necromorphs/icons/necromorphs/leaper_hopper.dmi'
	icon_state = "r_leg"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	body_damage_coeff = 0.75
	px_x = 2
	px_y = 12
	wound_resistance = 0
