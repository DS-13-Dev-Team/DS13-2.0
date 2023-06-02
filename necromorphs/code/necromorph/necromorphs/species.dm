//It exists just for compability. Don't add any vars or special behaviours
/datum/species/necromorph
	name = "Necromorph"
	id = SPECIES_NECROMORPH
	//There is no way to become it. Period.
	changesource_flags = NONE
	exotic_bloodtype = "X"
	sexes = FALSE
	bodytype = BODYTYPE_HUMANOID|BODYTYPE_ORGANIC|BODYTYPE_NECROMORPH

	max_bodypart_count = 6

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
		TRAIT_CAN_STRIP,
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
		NOAUGMENTS
	)

	inherent_traits = list()
	inherent_biotypes = MOB_ORGANIC|MOB_UNDEAD|MOB_HUMANOID
	inherent_factions = list(FACTION_NECROMORPH)
	species_mob_size = MOB_SIZE_HUMAN

/datum/species/necromorph/check_roundstart_eligible()
	return FALSE

/datum/species/necromorph/random_name(gender,unique,lastname)
	return "[name] [rand(1, 999)]"

/datum/species/necromorph/apply_damage(damage, damagetype = BRUTE, def_zone = null, blocked, mob/living/carbon/human/necromorph/H, forced = FALSE, spread_damage = FALSE, sharpness = NONE, attack_direction = null)
	if(H.dodge_shield > 0)
		var/percent_no_defend = 100-blocked
		if(HAS_TRAIT(H, TRAIT_DODGEARMOR_FULL))
			percent_no_defend -= 100
		else
			percent_no_defend -=  H.necro_armors.get_dir_armor(attack_direction, H.dir)
		percent_no_defend /= 100
		if(percent_no_defend <= 0)
			blocked = 100
			return ..()
		var/absorbed_damage = min(H.dodge_shield, round(damage * percent_no_defend))
		H.reduce_shield(absorbed_damage)
		blocked += (absorbed_damage / damage) * 100
	return ..()
