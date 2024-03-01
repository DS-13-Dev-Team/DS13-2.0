/obj/item/bodypart/chest/necromorph/exploder
	name = BODY_ZONE_CHEST
	limb_id = SPECIES_NECROMORPH_EXPLODER
	icon_static = 'deadspace/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "chest"
	max_damage = 200
	px_x = 0
	px_y = 0
	wound_resistance = 15
	biomass = 15

/obj/item/bodypart/head/necromorph/exploder
	name = BODY_ZONE_HEAD
	limb_id = SPECIES_NECROMORPH_EXPLODER
	icon_static = 'deadspace/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "head"
	max_damage = 200
	px_x = 0
	px_y = -8
	wound_resistance = 0
	biomass = 7.5
	base_pixel_y = -30

///The pustule shouldn't get BP_IS_MOVEMENT_LIMB, since pressure is what causes a pustule to explode in lore
/obj/item/bodypart/arm/left/necromorph/exploder
	name = "yellow pustule"
	limb_id = SPECIES_NECROMORPH_EXPLODER
	bodypart_flags = (BP_NO_PAIN | BP_HAS_BLOOD | BP_CAN_BE_DISLOCATED)
	icon_static = 'deadspace/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "l_arm"
	interaction_flags_item = INTERACT_ITEM_ATTACK_HAND_PICKUP //We want to be able to pick up and throw the pustle
	w_class = WEIGHT_CLASS_BULKY //But we don't want to store it
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	px_x = -2
	px_y = 12
	wound_resistance = 0
	biomass = 10 //Assuming it doesn't explode, it's packed with biomass
	integrity_failure = 0.5 //breaks at roughly 50% health
	base_pixel_x = -27

//If someone happens to cut off the limb correctly it won't spontaniously cuban pete like a bottle of nitroglycerin
/obj/item/bodypart/arm/left/necromorph/exploder/dismember(dismember_type, silent, clean)
	if(dismember_type == DROPLIMB_EDGE) //Most guns don't cause DROPLIMB_EDGE, so this is mostly for melee
		playsound(get_turf(src), 'sound/effects/dismember.ogg', 80, TRUE) //clean has no sound, but we still want to have a audio cue that it's cut off
		. = ..(silent = FALSE, clean = TRUE) //This makes sure the pustule doesn't throw itself and explodes
	else if(dismember_type == DROPLIMB_BLUNT || DROPLIMB_BURN) //Otherwise, cuban pete
		. = ..()
		explosion(get_turf(src), 0, 2, 3, 2, 5, TRUE, FALSE, FALSE, TRUE, explosion_cause = src)

//Did a projectile hit a pustle that is laying around? BOOM!
/obj/item/bodypart/arm/left/necromorph/exploder/bullet_act(obj/projectile/P)
	explosion(get_turf(src), 0, 2, 3, 2, 5, TRUE, FALSE, FALSE, TRUE, explosion_cause = src)
	qdel(src)
	. = ..()

//Somehow got your hands on a pustle without it exploding? Free grenade!
/obj/item/bodypart/arm/left/necromorph/exploder/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	explosion(get_turf(src), 0, 2, 3, 2, 5, TRUE, FALSE, FALSE, TRUE, explosion_cause = src)
	qdel(src)

//Sanity check for if the limb somehow doesn't explode when it should, explodes on destruction
/obj/item/bodypart/arm/left/necromorph/exploder/atom_break()
	. = ..()
	explosion(get_turf(src), 0, 2, 3, 2, 5, TRUE, FALSE, FALSE, TRUE, explosion_cause = src)

/obj/item/bodypart/arm/right/necromorph/exploder
	name = "right arm"
	limb_id = SPECIES_NECROMORPH_EXPLODER
	bodypart_flags = (BP_IS_MOVEMENT_LIMB | BP_IS_GRABBY_LIMB | BP_NO_PAIN | BP_HAS_BLOOD | BP_CAN_BE_DISLOCATED)
	icon_static = 'deadspace/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "r_arm"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	px_x = 2
	px_y = 12
	wound_resistance = -10
	biomass = 5

/obj/item/bodypart/leg/right/necromorph/exploder
	name = "fused legs"
	desc = "Two legs fused together to form a thick, meaty stalk."
	plaintext_zone = "fused legs"
	limb_id = SPECIES_NECROMORPH_EXPLODER
	bodypart_flags = (BP_IS_MOVEMENT_LIMB | BP_NO_PAIN | BP_HAS_BLOOD | BP_CAN_BE_DISLOCATED)
	dismemberable = FALSE //Technically this is actually a part of the chest, so we don't want this to come off
	can_be_disabled = TRUE //We do however, want humans to be able to immobilize the exploder
	disable_threshold = 1
	icon_static = null //Since the leg is part of the chest sprite, we don't want a sprite ontop of the sprite
	icon_state = null
	max_damage = 60 //Bit stronger due to it being two limbs fused together
	wound_resistance = -5
	biomass = 0 //Handled in chest due to sprite funnies

/obj/item/bodypart/leg/left/necromorph/exploder
	name = "nub"
	desc = "The fleshy remains of a leg that was fused together. This is useless."
	plaintext_zone = "leg nub"
	limb_id = SPECIES_NECROMORPH_EXPLODER
	bodypart_flags = (BP_NO_PAIN) //We don't want this to have anything, as it's just a nub to hide the "X IS MISSING" examine text
	dismemberable = FALSE
	can_be_disabled = FALSE
	is_pseudopart = TRUE //This will prevent the limb from having standard functions
	icon_static = null
	icon_state = null
	max_damage = 150
	biomass = 0 //Just a nub, not worth anything
