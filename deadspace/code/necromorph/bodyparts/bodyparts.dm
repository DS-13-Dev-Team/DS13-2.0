/obj/item/bodypart/chest/necromorph
	name = BODY_ZONE_CHEST
	bodytype = BODYTYPE_NECROMORPH|BODYTYPE_ORGANIC
	limb_id = SPECIES_NECROMORPH
	should_draw_greyscale = FALSE
	bodypart_flags = BP_NO_PAIN | STOCK_BP_FLAGS_CHEST & ~(BP_HAS_BONES|BP_HAS_ARTERY)
	icon_static = 'deadspace/icons/necromorphs/base_necromorph.dmi'
	icon_state = "chest"
	icon_dmg_overlay = null
	max_damage = 200
	body_zone = BODY_ZONE_CHEST
	body_part = CHEST
	is_dimorphic = FALSE
	px_x = 0
	px_y = 0
	grind_results = null
	wound_resistance = 10
	acceptable_bodytype = BODYTYPE_NECROMORPH
	can_be_disabled = FALSE
	icon_bloodycover = null
	icon_dmg_overlay = null

/obj/item/bodypart/head/necromorph
	name = BODY_ZONE_HEAD
	bodytype = BODYTYPE_NECROMORPH|BODYTYPE_ORGANIC
	limb_id = SPECIES_NECROMORPH
	should_draw_greyscale = FALSE
	bodypart_flags = BP_NO_PAIN | STOCK_BP_FLAGS_HEAD & ~(BP_HAS_BONES|BP_HAS_ARTERY)
	icon_static = 'deadspace/icons/necromorphs/base_necromorph.dmi'
	icon_state = "head"
	icon_dmg_overlay = null
	body_zone = BODY_ZONE_HEAD
	body_part = HEAD
	max_damage = 200
	px_x = 0
	px_y = -8
	wound_resistance = 5
	is_dimorphic = FALSE
	can_be_disabled = FALSE
	show_organs_on_examine = TRUE
	icon_bloodycover = null
	icon_dmg_overlay = null

/obj/item/bodypart/head/necromorph/attempt_dismemberment(brute as num, burn as num, sharpness)
	if((sharpness & SHARP_EDGED) && (brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_EDGE)
		return dismember(DROPLIMB_EDGE, FALSE, FALSE)

	else if((burn_dam + burn) >= max_damage * DROPLIMB_THRESHOLD_DESTROY)
		return dismember(DROPLIMB_BURN, FALSE, FALSE)

	else if((brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_DESTROY)
		return dismember(DROPLIMB_BLUNT, FALSE, FALSE)

	else if((brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_TEAROFF)
		return dismember(DROPLIMB_EDGE, FALSE, FALSE)

/obj/item/bodypart/arm/left/necromorph
	name = "left arm"
	bodytype = BODYTYPE_NECROMORPH|BODYTYPE_ORGANIC
	limb_id = SPECIES_NECROMORPH
	should_draw_greyscale = FALSE
	bodypart_flags = BP_NO_PAIN | STOCK_BP_FLAGS_ARMS & ~(BP_HAS_BONES|BP_HAS_TENDON|BP_HAS_ARTERY)
	icon_static = 'deadspace/icons/necromorphs/base_necromorph.dmi'
	icon_state = "l_arm"
	icon_dmg_overlay = null
	attack_verb_continuous = list("slaps", "punches")
	attack_verb_simple = list("slap", "punch")
	max_damage = 50
	px_x = -6
	px_y = 0
	can_be_disabled = FALSE
	wound_resistance = 0
	icon_bloodycover = null
	icon_dmg_overlay = null

/obj/item/bodypart/arm/left/necromorph/attempt_dismemberment(brute as num, burn as num, sharpness)
	if((sharpness & SHARP_EDGED) && (brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_EDGE)
		return dismember(DROPLIMB_EDGE, FALSE, FALSE)

	else if((burn_dam + burn) >= max_damage * DROPLIMB_THRESHOLD_DESTROY)
		return dismember(DROPLIMB_BURN, FALSE, FALSE)

	else if((brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_DESTROY)
		return dismember(DROPLIMB_BLUNT, FALSE, FALSE)

	else if((brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_TEAROFF)
		return dismember(DROPLIMB_EDGE, FALSE, FALSE)

/obj/item/bodypart/arm/right/necromorph
	name = "right arm"
	bodytype = BODYTYPE_NECROMORPH|BODYTYPE_ORGANIC
	limb_id = SPECIES_NECROMORPH
	should_draw_greyscale = FALSE
	bodypart_flags = BP_NO_PAIN | STOCK_BP_FLAGS_ARMS & ~(BP_HAS_BONES|BP_HAS_TENDON|BP_HAS_ARTERY)
	icon_static = 'deadspace/icons/necromorphs/base_necromorph.dmi'
	icon_state = "r_arm"
	icon_dmg_overlay = null
	attack_verb_continuous = list("slaps", "punches")
	attack_verb_simple = list("slap", "punch")
	max_damage = 50
	px_x = 6
	px_y = 0
	can_be_disabled = FALSE
	wound_resistance = 0
	icon_bloodycover = null
	icon_dmg_overlay = null

/obj/item/bodypart/arm/right/necromorph/attempt_dismemberment(brute as num, burn as num, sharpness)
	if((sharpness & SHARP_EDGED) && (brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_EDGE)
		return dismember(DROPLIMB_EDGE, FALSE, FALSE)

	else if((burn_dam + burn) >= max_damage * DROPLIMB_THRESHOLD_DESTROY)
		return dismember(DROPLIMB_BURN, FALSE, FALSE)

	else if((brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_DESTROY)
		return dismember(DROPLIMB_BLUNT, FALSE, FALSE)

	else if((brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_TEAROFF)
		return dismember(DROPLIMB_EDGE, FALSE, FALSE)

/obj/item/bodypart/leg/left/necromorph
	name = "left leg"
	bodytype = BODYTYPE_NECROMORPH|BODYTYPE_ORGANIC
	limb_id = SPECIES_NECROMORPH
	should_draw_greyscale = FALSE
	bodypart_flags = BP_NO_PAIN | STOCK_BP_FLAGS_LEGS & ~(BP_HAS_BONES|BP_HAS_TENDON|BP_HAS_ARTERY)
	icon_static = 'deadspace/icons/necromorphs/base_necromorph.dmi'
	icon_state = "l_leg"
	icon_dmg_overlay = null
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	px_x = -2
	px_y = 12
	can_be_disabled = FALSE
	wound_resistance = 0
	icon_bloodycover = null
	icon_dmg_overlay = null

/obj/item/bodypart/leg/left/necromorph/attempt_dismemberment(brute as num, burn as num, sharpness)
	if((sharpness & SHARP_EDGED) && (brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_EDGE)
		return dismember(DROPLIMB_EDGE, FALSE, FALSE)

	else if((burn_dam + burn) >= max_damage * DROPLIMB_THRESHOLD_DESTROY)
		return dismember(DROPLIMB_BURN, FALSE, FALSE)

	else if((brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_DESTROY)
		return dismember(DROPLIMB_BLUNT, FALSE, FALSE)

	else if((brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_TEAROFF)
		return dismember(DROPLIMB_EDGE, FALSE, FALSE)

/obj/item/bodypart/leg/right/necromorph
	name = "right leg"
	bodytype = BODYTYPE_NECROMORPH|BODYTYPE_ORGANIC
	limb_id = SPECIES_NECROMORPH
	should_draw_greyscale = FALSE
	bodypart_flags = BP_NO_PAIN | STOCK_BP_FLAGS_LEGS & ~(BP_HAS_BONES|BP_HAS_TENDON|BP_HAS_ARTERY)
	icon_static = 'deadspace/icons/necromorphs/base_necromorph.dmi'
	icon_state = "r_leg"
	icon_dmg_overlay = null
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	body_zone = BODY_ZONE_R_LEG
	body_part = LEG_RIGHT
	px_x = 2
	px_y = 12
	can_be_disabled = FALSE
	wound_resistance = 0
	icon_bloodycover = null
	icon_dmg_overlay = null

/obj/item/bodypart/leg/right/necromorph/attempt_dismemberment(brute as num, burn as num, sharpness)
	if((sharpness & SHARP_EDGED) && (brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_EDGE)
		return dismember(DROPLIMB_EDGE, FALSE, FALSE)

	else if((burn_dam + burn) >= max_damage * DROPLIMB_THRESHOLD_DESTROY)
		return dismember(DROPLIMB_BURN, FALSE, FALSE)

	else if((brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_DESTROY)
		return dismember(DROPLIMB_BLUNT, FALSE, FALSE)

	else if((brute_dam + brute) >= max_damage * DROPLIMB_THRESHOLD_TEAROFF)
		return dismember(DROPLIMB_EDGE, FALSE, FALSE)
