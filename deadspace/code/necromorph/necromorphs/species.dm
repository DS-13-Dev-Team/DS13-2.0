//It exists just for compability. Don't add any vars or special behaviours
/datum/species/necromorph
	name = "Necromorph"
	id = SPECIES_NECROMORPH

	var/icon/icobase
	var/icon/deform

	//There is no way to become it. Period.
	changesource_flags = NONE
	exotic_bloodtype = "X"
	sexes = FALSE
	bodytype = BODYTYPE_HUMANOID|BODYTYPE_ORGANIC|BODYTYPE_NECROMORPH

	max_bodypart_count = 6
	burnmod = 1.2

	examine_limb_id = SPECIES_NECROMORPH
	exotic_bloodtype = "X"
	meat = /obj/item/food/meat/slab/human/mutant/necro
	liked_food = NONE
	disliked_food = NONE
	toxic_food = NONE
	///We don't process reagents
	reagent_flags = NONE
	no_equip = list(
		ITEM_SLOT_OCLOTHING,
		ITEM_SLOT_ICLOTHING,
		ITEM_SLOT_GLOVES,
		ITEM_SLOT_EYES,
		ITEM_SLOT_EARS,
		ITEM_SLOT_MASK,
		ITEM_SLOT_HEAD,
		ITEM_SLOT_FEET,
		ITEM_SLOT_ID,
		ITEM_SLOT_BELT,
		ITEM_SLOT_BACK,
		ITEM_SLOT_DEX_STORAGE,
		ITEM_SLOT_NECK,
		ITEM_SLOT_HANDS,
		ITEM_SLOT_BACKPACK,
		ITEM_SLOT_SUITSTORE,
		ITEM_SLOT_LPOCKET,
		ITEM_SLOT_RPOCKET,
		ITEM_SLOT_HANDCUFFED,
		ITEM_SLOT_LEGCUFFED,
	)

	inherent_traits = list(
		TRAIT_DEFIB_BLACKLISTED,
		TRAIT_BADDNA,
		TRAIT_GENELESS,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOMETABOLISM,
		TRAIT_TOXIMMUNE,
		TRAIT_EASYDISMEMBER,
		TRAIT_NOBREATH,
		TRAIT_NOCRITDAMAGE,
		TRAIT_FEARLESS,
		TRAIT_NO_SOUL,
		TRAIT_CANT_RIDE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RESISTCOLD,
		TRAIT_DISCOORDINATED_TOOL_USER,
		TRAIT_PIERCEIMMUNE,
		TRAIT_IGNOREDAMAGESLOWDOWN,
		TRAIT_NOSOFTCRIT,
		TRAIT_NOHUNGER,
	)

	say_mod = "roars"
	scream_verb = "roars"
	species_language_holder = /datum/language_holder/necro_talk

	species_traits = list(
		NOBLOOD,
		NOTRANSSTING,
		NOZOMBIE,
		NO_UNDERWEAR,
		NOSTOMACH ,
		NO_DNA_COPY,
		AGENDER,
		HAS_FLESH,
		HAS_BONE,
		NOAUGMENTS,
		NOEYESPRITES,
	)

	inherent_traits = list()
	inherent_biotypes = MOB_ORGANIC|MOB_UNDEAD|MOB_HUMANOID
	inherent_factions = list(FACTION_NECROMORPH)
	species_mob_size = MOB_SIZE_HUMAN
	fire_overlay = "generic_burning"

/datum/species/necromorph/check_roundstart_eligible()
	return FALSE

/datum/species/necromorph/random_name(gender,unique,lastname)
	return "[name] [rand(1, 999)]"

/datum/species/necromorph/spec_unarmedattack(mob/living/carbon/human/user, atom/target, modifiers)
	if(user.combat_mode)
		target.attack_necromorph(user, modifiers)
		return TRUE

/datum/species/necromorph/apply_damage(damage, damagetype = BRUTE, def_zone = null, blocked, mob/living/carbon/human/necromorph/H, forced = FALSE, spread_damage = FALSE, sharpness = NONE, attack_direction = null)
	if(H.dodge_shield > 0)
		// Calculate amount of the damage that was blocked by the shield
		var/dodged_damage = min(H.dodge_shield, damage * H.shield_absorb_percent, damage * (100 - blocked) / 100)
		H.reduce_shield(dodged_damage)
		blocked += (dodged_damage / damage) * 100
	return ..()

//Does animations for regenerating a limb
/datum/species/necromorph/proc/regenerate_limb(mob/living/carbon/human/H, limb, duration)
	var/regen_icon = get_icobase()
	var/image/LR = image(regen_icon, H, "[limb]_regen")
	LR.plane = H.plane
	LR.layer = H.layer -0.1 //Slightly below the layer of the mob, so that the healthy limb will draw over it
	flick_overlay(LR, GLOB.clients, duration + 2)

/datum/species/necromorph/proc/get_icobase(mob/living/carbon/human/H, get_deform)
	return (get_deform ? deform : icobase)
