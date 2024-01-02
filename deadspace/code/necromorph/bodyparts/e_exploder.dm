/obj/item/bodypart/chest/necromorph/exploder/enhanced
	name = BODY_ZONE_CHEST
	limb_id = SPECIES_NECROMORPH_EXPLODER_ENHANCED
	icon_static = 'deadspace/icons/necromorphs/exploder/exploder_enhanced.dmi'
	icon_state = "chest"
	max_damage = 200
	px_x = 0
	px_y = 0
	wound_resistance = 10
	biomass = 10

/obj/item/bodypart/head/necromorph/exploder/enhanced
	name = BODY_ZONE_HEAD
	limb_id = SPECIES_NECROMORPH_EXPLODER_ENHANCED
	icon_static = 'deadspace/icons/necromorphs/exploder/exploder_enhanced.dmi'
	icon_state = "head"
	max_damage = 200
	px_x = 0
	px_y = -8
	wound_resistance = 5
	biomass = 9

/obj/item/bodypart/arm/left/necromorph/exploder/enhanced
	name = "red pustule"
	limb_id = SPECIES_NECROMORPH_EXPLODER_ENHANCED
	icon_static = 'deadspace/icons/necromorphs/exploder/exploder_enhanced.dmi'
	icon_state = "l_arm"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 75
	px_x = -2
	px_y = 12
	wound_resistance = 0
	biomass = 16 //The majority of biomass is in the arm, due to the much bigger explosion

/obj/item/bodypart/arm/right/necromorph/exploder/enhanced
	name = "right arm"
	limb_id = SPECIES_NECROMORPH_EXPLODER_ENHANCED
	icon_static = 'deadspace/icons/necromorphs/exploder/exploder_enhanced.dmi'
	icon_state = "r_arm"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 75
	px_x = 2
	px_y = 12
	wound_resistance = 0
	biomass = 7

/obj/item/bodypart/leg/right/necromorph/exploder/enhanced
	name = "fused legs"
	desc = "Two legs fused together to form a thick, meaty stalk."
	plaintext_zone = "fused legs"
	limb_id = SPECIES_NECROMORPH_EXPLODER_ENHANCED
	bodypart_flags = BP_NO_PAIN | STOCK_BP_FLAGS_LEGS & ~(BP_HAS_BONES|BP_HAS_TENDON|BP_HAS_ARTERY)
	dismemberable = FALSE
	can_be_disabled = TRUE
	disable_threshold = 1
	icon_static = null
	icon_state = null
	max_damage = 100
	biomass = 0 //Handled in chest due to sprite funnies

/obj/item/bodypart/leg/left/necromorph/exploder/enhanced
	name = "nub"
	desc = "The fleshy remains of a leg that was fused together. This is useless."
	plaintext_zone = "leg nub"
	limb_id = SPECIES_NECROMORPH_EXPLODER_ENHANCED
	bodypart_flags = BP_NO_PAIN
	dismemberable = FALSE
	can_be_disabled = FALSE
	is_pseudopart = TRUE
	icon_static = null
	icon_state = null
	max_damage = 200
	biomass = 0

