/obj/item/bodypart/chest/necromorph/exploder
	name = BODY_ZONE_CHEST
	limb_id = SPECIES_NECROMORPH_EXPLODER
	icon_static = 'deadspace/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "chest"
	max_damage = 200
	px_x = 0
	px_y = 0
	wound_resistance = 10
	biomass = 15

/obj/item/bodypart/head/necromorph/exploder
	name = BODY_ZONE_HEAD
	limb_id = SPECIES_NECROMORPH_EXPLODER
	icon_static = 'deadspace/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "head"
	max_damage = 200
	px_x = 0
	px_y = -8
	wound_resistance = 5
	biomass = 7.5

/obj/item/bodypart/arm/left/necromorph/exploder
	name = "yellow pustule"
	limb_id = SPECIES_NECROMORPH_EXPLODER
	bodypart_flags = BP_IS_MOVEMENT_LIMB | BP_NO_PAIN | STOCK_BP_FLAGS_ARMS & ~(BP_HAS_BONES|BP_HAS_TENDON|BP_HAS_ARTERY)
	icon_static = 'deadspace/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "l_arm"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	px_x = -2
	px_y = 12
	wound_resistance = 0
	biomass = 10 //Assuming it doesn't explode, it's packed with biomass
	integrity_failure = 0.25
	var/list/datum/action/cooldown/necro/exploding_actions

//Projectile hits exploder pustle? BOOM!
/obj/item/bodypart/arm/left/necromorph/exploder/bullet_act(obj/projectile/P)
	explosion(get_turf(src), 0, 0, 3, 2, 4, TRUE, FALSE, FALSE, TRUE, explosion_cause = src)
	qdel(src)
	. = ..()

//Somehow got your hands on a pustle without it exploding? Free grenade!
/obj/item/bodypart/arm/left/necromorph/exploder/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	explosion(get_turf(src), 0, 0, 3, 2, 4, TRUE, FALSE, FALSE, TRUE, explosion_cause = src)
	qdel(src)
	. = ..()

//Sanity check for if the limb somehow doesn't explode when it should, explodes on limb destruction
/obj/item/bodypart/arm/left/necromorph/exploder/atom_break()
	explosion(get_turf(src), 0, 0, 3, 2, 4, TRUE, FALSE, FALSE, TRUE, explosion_cause = src)
	. = ..()

/obj/item/bodypart/arm/right/necromorph/exploder
	name = "right arm"
	limb_id = SPECIES_NECROMORPH_EXPLODER
	bodypart_flags = BP_IS_MOVEMENT_LIMB | BP_NO_PAIN | STOCK_BP_FLAGS_ARMS & ~(BP_HAS_BONES|BP_HAS_TENDON|BP_HAS_ARTERY)
	icon_static = 'deadspace/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "r_arm"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	px_x = 2
	px_y = 12
	wound_resistance = 0
	biomass = 5
