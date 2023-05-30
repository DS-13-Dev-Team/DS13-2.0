/obj/item/bodypart/chest/necromorph/leaper
	name = BODY_ZONE_CHEST
	limb_id = SPECIES_NECROMORPH_LEAPER
	icon_static = 'necromorphs/icons/necromorphs/leaper.dmi'
	icon_state = "chest"
	max_damage = 200
	px_x = 0
	px_y = 0
	stam_damage_coeff = 1
	max_stamina_damage = 120
	wound_resistance = 10

/obj/item/bodypart/head/necromorph/leaper
	name = BODY_ZONE_HEAD
	limb_id = SPECIES_NECROMORPH_LEAPER
	icon_static = 'necromorphs/icons/necromorphs/leaper.dmi'
	icon_state = "head"
	max_damage = 200
	px_x = 0
	px_y = -8
	stam_damage_coeff = 1
	max_stamina_damage = 100
	wound_resistance = 5

//Leapers use arms to walk
/obj/item/bodypart/leg/left/necromorph/leaper
	name = "left arm"
	limb_id = SPECIES_NECROMORPH_LEAPER
	icon_static = 'necromorphs/icons/necromorphs/leaper.dmi'
	icon_state = "l_arm"
	body_part = LEG_LEFT
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 12
	max_stamina_damage = 50
	wound_resistance = 0

/obj/item/bodypart/leg/right/necromorph/leaper
	name = "right arm"
	limb_id = SPECIES_NECROMORPH_LEAPER
	icon_static = 'necromorphs/icons/necromorphs/leaper.dmi'
	icon_state = "l_arm"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	body_damage_coeff = 0.75
	px_x = 2
	px_y = 12
	max_stamina_damage = 50
	wound_resistance = 0

/obj/item/organ/external/tail/necromorph/leaper
	name = "tail"
	desc = "A severed tail. What did you cut this off of?"
	visual = TRUE
	icon = 'necromorphs/icons/necromorphs/leaper.dmi'
	icon_state = "necromorph_tail"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_EXTERNAL_TAIL
	feature_key = "necro_tail"
	dna_block = DNA_NECROMORPH_TAIL_BLOCK
	layers = EXTERNAL_BEHIND

/datum/sprite_accessory/necromorph/leaper
	icon = 'necromorphs/icons/necromorphs/leaper.dmi'
	icon_state = "necromorph_tail"
