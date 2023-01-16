/obj/item/bodypart/chest/necromorph
	name = BODY_ZONE_CHEST
	desc = "It's impolite to stare at a person's chest."
	bodytype = BODYTYPE_NECROMORPH|BODYTYPE_ORGANIC
	limb_id = SPECIES_NECROMORPH
	should_draw_greyscale = FALSE
	icon_static = 'necromorphs/icons/necromorphs/slasher/fleshy.dmi'
	icon_state = "chest"
	max_damage = 200
	body_zone = BODY_ZONE_CHEST
	body_part = CHEST
	is_dimorphic = FALSE
	px_x = 0
	px_y = 0
	stam_damage_coeff = 1
	max_stamina_damage = 120
	grind_results = null
	wound_resistance = 10
	acceptable_bodytype = BODYTYPE_NECROMORPH
	can_be_disabled = FALSE

/obj/item/bodypart/chest/necromorph/receive_damage(brute = 0, burn = 0, stamina = 0, blocked = 0, updating_health = TRUE, required_status = null, wound_bonus = 0, bare_wound_bonus = 0, sharpness = NONE, attack_direction = null)
	SHOULD_CALL_PARENT(FALSE)

	var/hit_percent = (100-blocked)/100
	if((!brute && !burn && !stamina) || hit_percent <= 0)
		return FALSE
	if(owner && (owner.status_flags & GODMODE))
		return FALSE	//godmode
	if(required_status && !(bodytype & required_status))
		return FALSE

	var/dmg_multi = CONFIG_GET(number/damage_multiplier) * hit_percent
	brute = round(max(brute * dmg_multi, 0),DAMAGE_PRECISION)
	burn = round(max(burn * dmg_multi, 0),DAMAGE_PRECISION)
	stamina = round(max(stamina * dmg_multi, 0),DAMAGE_PRECISION)
	brute = max(0, brute - brute_reduction)
	burn = max(0, burn - burn_reduction)
	//No stamina scaling.. for now..

	if(!brute && !burn && !stamina)
		return FALSE

	brute *= wound_damage_multiplier
	burn *= wound_damage_multiplier

	/*
	// START WOUND HANDLING
	*/

	// what kind of wounds we're gonna roll for, take the greater between brute and burn, then if it's brute, we subdivide based on sharpness
	var/wounding_type = (brute > burn ? WOUND_BLUNT : WOUND_BURN)
	var/wounding_dmg = max(brute, burn)

	var/mangled_state = get_mangled_state()
	var/bio_state = owner.get_biological_state()
	var/easy_dismember = HAS_TRAIT(owner, TRAIT_EASYDISMEMBER) // if we have easydismember, we don't reduce damage when redirecting damage to different types (slashing weapons on mangled/skinless limbs attack at 100% instead of 50%)

	if(wounding_type == WOUND_BLUNT && sharpness)
		if(sharpness & SHARP_EDGED)
			wounding_type = WOUND_SLASH
		else if (sharpness & SHARP_POINTY)
			wounding_type = WOUND_PIERCE

	//Handling for bone only/flesh only(none right now)/flesh and bone targets
	switch(bio_state)
		// if we're bone only, all cutting attacks go straight to the bone
		if(BIO_JUST_BONE)
			if(wounding_type == WOUND_SLASH)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.6)
			else if(wounding_type == WOUND_PIERCE)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.75)
			if((mangled_state & BODYPART_MANGLED_BONE) && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return
		// note that there's no handling for BIO_JUST_FLESH since we don't have any that are that right now (slimepeople maybe someday)
		// standard humanoids
		if(BIO_FLESH_BONE)
			// if we've already mangled the skin (critical slash or piercing wound), then the bone is exposed, and we can damage it with sharp weapons at a reduced rate
			// So a big sharp weapon is still all you need to destroy a limb
			if(mangled_state == BODYPART_MANGLED_FLESH && sharpness)
				playsound(src, "sound/effects/wounds/crackandbleed.ogg", 100)
				if(wounding_type == WOUND_SLASH && !easy_dismember)
					wounding_dmg *= 0.6 // edged weapons pass along 60% of their wounding damage to the bone since the power is spread out over a larger area
				if(wounding_type == WOUND_PIERCE && !easy_dismember)
					wounding_dmg *= 0.75 // piercing weapons pass along 75% of their wounding damage to the bone since it's more concentrated
				wounding_type = WOUND_BLUNT
			else if(mangled_state == BODYPART_MANGLED_BOTH && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return

	// now we have our wounding_type and are ready to carry on with wounds and dealing the actual damage
	if(owner && wounding_dmg >= WOUND_MINIMUM_DAMAGE && wound_bonus != CANT_WOUND)
		check_wounding(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus, attack_direction)

	for(var/datum/wound/iter_wound as anything in wounds)
		iter_wound.receive_damage(wounding_type, wounding_dmg, wound_bonus)

	/*
	// END WOUND HANDLING
	*/

	//back to our regularly scheduled program, we now actually apply damage if there's room below limb damage cap
	var/can_inflict = max_damage - get_damage()
	var/total_damage = brute + burn
	if(total_damage > can_inflict && total_damage > 0) // TODO: the second part of this check should be removed once disabling is all done
		brute = round(brute * (can_inflict / total_damage),DAMAGE_PRECISION)
		burn = round(burn * (can_inflict / total_damage),DAMAGE_PRECISION)

	if(can_inflict <= 0)
		return FALSE
	if(brute)
		set_brute_dam(brute_dam + brute)
	if(burn)
		set_burn_dam(burn_dam + burn)

	//We've dealt the physical damages, if there's room lets apply the stamina damage.
	if(stamina)
		set_stamina_dam(stamina_dam + round(clamp(stamina, 0, max_stamina_damage - stamina_dam), DAMAGE_PRECISION))

	if(owner && updating_health)
		owner.updatehealth()
		if(stamina > DAMAGE_PRECISION)
			owner.update_stamina()
			owner.stam_regen_start_time = world.time + STAMINA_REGEN_BLOCK_TIME
			. = TRUE
	return update_bodypart_damage_state() || .

/obj/item/bodypart/chest/necromorph/check_wounding(woundtype, damage, wound_bonus, bare_wound_bonus, attack_direction)
	SHOULD_CALL_PARENT(FALSE)

	if(HAS_TRAIT(owner, TRAIT_NEVER_WOUNDED))
		return

	// note that these are fed into an exponent, so these are magnified
	if(HAS_TRAIT(owner, TRAIT_EASILY_WOUNDED))
		damage *= 1.5
	else
		damage = min(damage, WOUND_MAX_CONSIDERED_DAMAGE)

	if(HAS_TRAIT(owner,TRAIT_HARDLY_WOUNDED))
		damage *= 0.85

	if(HAS_TRAIT(owner, TRAIT_EASYDISMEMBER))
		damage *= 1.1

	var/base_roll = rand(1, round(damage ** WOUND_DAMAGE_EXPONENT))
	var/injury_roll = base_roll
	injury_roll += check_woundings_mods(woundtype, damage, wound_bonus, bare_wound_bonus)
	var/list/wounds_checking = GLOB.global_wound_types[woundtype]

	var/limb_damage = get_damage()
	if((limb_damage >= max_damage) || (limb_damage >= max_damage*0.8 && prob(20)))
		var/datum/wound/loss/dismembering = new
		dismembering.apply_dismember(src, woundtype, outright = TRUE, attack_direction = attack_direction)
		return

	// quick re-check to see if bare_wound_bonus applies, for the benefit of log_wound(), see about getting the check from check_woundings_mods() somehow
	if(ishuman(owner))
		var/mob/living/carbon/human/human_wearer = owner
		var/list/clothing = human_wearer.clothingonpart(src)
		for(var/obj/item/clothing/clothes_check as anything in clothing)
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			if(clothes_check.armor.getRating(WOUND))
				bare_wound_bonus = 0
				break

	//cycle through the wounds of the relevant category from the most severe down
	for(var/datum/wound/possible_wound as anything in wounds_checking)
		var/datum/wound/replaced_wound
		for(var/datum/wound/existing_wound as anything in wounds)
			if(existing_wound.type in wounds_checking)
				if(existing_wound.severity >= initial(possible_wound.severity))
					return
				else
					replaced_wound = existing_wound

		if(initial(possible_wound.threshold_minimum) < injury_roll)
			var/datum/wound/new_wound
			if(replaced_wound)
				new_wound = replaced_wound.replace_wound(possible_wound, attack_direction = attack_direction)
			else
				new_wound = new possible_wound
				new_wound.apply_wound(src, attack_direction = attack_direction)
			log_wound(owner, new_wound, damage, wound_bonus, bare_wound_bonus, base_roll) // dismembering wounds are logged in the apply_wound() for loss wounds since they delete themselves immediately, these will be immediately returned
			return new_wound

/obj/item/bodypart/head/necromorph
	name = BODY_ZONE_HEAD
	desc = "Didn't make sense not to live for fun, your brain gets smart but your head gets dumb."
	bodytype = BODYTYPE_NECROMORPH|BODYTYPE_ORGANIC
	limb_id = SPECIES_NECROMORPH
	should_draw_greyscale = FALSE
	icon_static = 'necromorphs/icons/necromorphs/slasher/fleshy.dmi'
	icon_state = "head"
	body_zone = BODY_ZONE_HEAD
	body_part = HEAD
	max_damage = 200
	px_x = 0
	px_y = -8
	stam_damage_coeff = 1
	max_stamina_damage = 100
	wound_resistance = 5
	scars_covered_by_clothes = FALSE
	is_dimorphic = FALSE
	can_be_disabled = FALSE
	show_organs_on_examine = TRUE

/obj/item/bodypart/head/necromorph/receive_damage(brute = 0, burn = 0, stamina = 0, blocked = 0, updating_health = TRUE, required_status = null, wound_bonus = 0, bare_wound_bonus = 0, sharpness = NONE, attack_direction = null)
	SHOULD_CALL_PARENT(FALSE)

	var/hit_percent = (100-blocked)/100
	if((!brute && !burn && !stamina) || hit_percent <= 0)
		return FALSE
	if(owner && (owner.status_flags & GODMODE))
		return FALSE	//godmode
	if(required_status && !(bodytype & required_status))
		return FALSE

	var/dmg_multi = CONFIG_GET(number/damage_multiplier) * hit_percent
	brute = round(max(brute * dmg_multi, 0),DAMAGE_PRECISION)
	burn = round(max(burn * dmg_multi, 0),DAMAGE_PRECISION)
	stamina = round(max(stamina * dmg_multi, 0),DAMAGE_PRECISION)
	brute = max(0, brute - brute_reduction)
	burn = max(0, burn - burn_reduction)
	//No stamina scaling.. for now..

	if(!brute && !burn && !stamina)
		return FALSE

	brute *= wound_damage_multiplier
	burn *= wound_damage_multiplier

	/*
	// START WOUND HANDLING
	*/

	// what kind of wounds we're gonna roll for, take the greater between brute and burn, then if it's brute, we subdivide based on sharpness
	var/wounding_type = (brute > burn ? WOUND_BLUNT : WOUND_BURN)
	var/wounding_dmg = max(brute, burn)

	var/mangled_state = get_mangled_state()
	var/bio_state = owner.get_biological_state()
	var/easy_dismember = HAS_TRAIT(owner, TRAIT_EASYDISMEMBER) // if we have easydismember, we don't reduce damage when redirecting damage to different types (slashing weapons on mangled/skinless limbs attack at 100% instead of 50%)

	if(wounding_type == WOUND_BLUNT && sharpness)
		if(sharpness & SHARP_EDGED)
			wounding_type = WOUND_SLASH
		else if (sharpness & SHARP_POINTY)
			wounding_type = WOUND_PIERCE

	//Handling for bone only/flesh only(none right now)/flesh and bone targets
	switch(bio_state)
		// if we're bone only, all cutting attacks go straight to the bone
		if(BIO_JUST_BONE)
			if(wounding_type == WOUND_SLASH)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.6)
			else if(wounding_type == WOUND_PIERCE)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.75)
			if((mangled_state & BODYPART_MANGLED_BONE) && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return
		// note that there's no handling for BIO_JUST_FLESH since we don't have any that are that right now (slimepeople maybe someday)
		// standard humanoids
		if(BIO_FLESH_BONE)
			// if we've already mangled the skin (critical slash or piercing wound), then the bone is exposed, and we can damage it with sharp weapons at a reduced rate
			// So a big sharp weapon is still all you need to destroy a limb
			if(mangled_state == BODYPART_MANGLED_FLESH && sharpness)
				playsound(src, "sound/effects/wounds/crackandbleed.ogg", 100)
				if(wounding_type == WOUND_SLASH && !easy_dismember)
					wounding_dmg *= 0.6 // edged weapons pass along 60% of their wounding damage to the bone since the power is spread out over a larger area
				if(wounding_type == WOUND_PIERCE && !easy_dismember)
					wounding_dmg *= 0.75 // piercing weapons pass along 75% of their wounding damage to the bone since it's more concentrated
				wounding_type = WOUND_BLUNT
			else if(mangled_state == BODYPART_MANGLED_BOTH && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return

	// now we have our wounding_type and are ready to carry on with wounds and dealing the actual damage
	if(owner && wounding_dmg >= WOUND_MINIMUM_DAMAGE && wound_bonus != CANT_WOUND)
		check_wounding(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus, attack_direction)

	for(var/datum/wound/iter_wound as anything in wounds)
		iter_wound.receive_damage(wounding_type, wounding_dmg, wound_bonus)

	/*
	// END WOUND HANDLING
	*/

	//back to our regularly scheduled program, we now actually apply damage if there's room below limb damage cap
	var/can_inflict = max_damage - get_damage()
	var/total_damage = brute + burn
	if(total_damage > can_inflict && total_damage > 0) // TODO: the second part of this check should be removed once disabling is all done
		brute = round(brute * (can_inflict / total_damage),DAMAGE_PRECISION)
		burn = round(burn * (can_inflict / total_damage),DAMAGE_PRECISION)

	if(can_inflict <= 0)
		return FALSE
	if(brute)
		set_brute_dam(brute_dam + brute)
	if(burn)
		set_burn_dam(burn_dam + burn)

	//We've dealt the physical damages, if there's room lets apply the stamina damage.
	if(stamina)
		set_stamina_dam(stamina_dam + round(clamp(stamina, 0, max_stamina_damage - stamina_dam), DAMAGE_PRECISION))

	if(owner && updating_health)
		owner.updatehealth()
		if(stamina > DAMAGE_PRECISION)
			owner.update_stamina()
			owner.stam_regen_start_time = world.time + STAMINA_REGEN_BLOCK_TIME
			. = TRUE
	return update_bodypart_damage_state() || .

/obj/item/bodypart/head/necromorph/check_wounding(woundtype, damage, wound_bonus, bare_wound_bonus, attack_direction)
	SHOULD_CALL_PARENT(FALSE)

	if(HAS_TRAIT(owner, TRAIT_NEVER_WOUNDED))
		return

	// note that these are fed into an exponent, so these are magnified
	if(HAS_TRAIT(owner, TRAIT_EASILY_WOUNDED))
		damage *= 1.5
	else
		damage = min(damage, WOUND_MAX_CONSIDERED_DAMAGE)

	if(HAS_TRAIT(owner,TRAIT_HARDLY_WOUNDED))
		damage *= 0.85

	if(HAS_TRAIT(owner, TRAIT_EASYDISMEMBER))
		damage *= 1.1

	var/base_roll = rand(1, round(damage ** WOUND_DAMAGE_EXPONENT))
	var/injury_roll = base_roll
	injury_roll += check_woundings_mods(woundtype, damage, wound_bonus, bare_wound_bonus)
	var/list/wounds_checking = GLOB.global_wound_types[woundtype]

	var/limb_damage = get_damage()
	if((limb_damage >= max_damage) || (limb_damage >= max_damage*0.8 && prob(20)))
		var/datum/wound/loss/dismembering = new
		dismembering.apply_dismember(src, woundtype, outright = TRUE, attack_direction = attack_direction)
		return

	// quick re-check to see if bare_wound_bonus applies, for the benefit of log_wound(), see about getting the check from check_woundings_mods() somehow
	if(ishuman(owner))
		var/mob/living/carbon/human/human_wearer = owner
		var/list/clothing = human_wearer.clothingonpart(src)
		for(var/obj/item/clothing/clothes_check as anything in clothing)
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			if(clothes_check.armor.getRating(WOUND))
				bare_wound_bonus = 0
				break

	//cycle through the wounds of the relevant category from the most severe down
	for(var/datum/wound/possible_wound as anything in wounds_checking)
		var/datum/wound/replaced_wound
		for(var/datum/wound/existing_wound as anything in wounds)
			if(existing_wound.type in wounds_checking)
				if(existing_wound.severity >= initial(possible_wound.severity))
					return
				else
					replaced_wound = existing_wound

		if(initial(possible_wound.threshold_minimum) < injury_roll)
			var/datum/wound/new_wound
			if(replaced_wound)
				new_wound = replaced_wound.replace_wound(possible_wound, attack_direction = attack_direction)
			else
				new_wound = new possible_wound
				new_wound.apply_wound(src, attack_direction = attack_direction)
			log_wound(owner, new_wound, damage, wound_bonus, bare_wound_bonus, base_roll) // dismembering wounds are logged in the apply_wound() for loss wounds since they delete themselves immediately, these will be immediately returned
			return new_wound

/obj/item/bodypart/arm/left/necromorph
	name = "left arm"
	desc = "Did you know that the word 'sinister' stems originally from the \
		Latin 'sinestra' (left hand), because the left hand was supposed to \
		be possessed by the devil? This arm appears to be possessed by no \
		one though."
	bodytype = BODYTYPE_NECROMORPH|BODYTYPE_ORGANIC
	limb_id = SPECIES_NECROMORPH
	should_draw_greyscale = FALSE
	icon_static = 'necromorphs/icons/necromorphs/slasher/fleshy.dmi'
	icon_state = "l_arm"
	attack_verb_continuous = list("slaps", "punches")
	attack_verb_simple = list("slap", "punch")
	max_damage = 50
	max_stamina_damage = 50
	body_damage_coeff = 0.75
	px_x = -6
	px_y = 0
	can_be_disabled = FALSE
	wound_resistance = 0

/obj/item/bodypart/arm/left/necromorph/receive_damage(brute = 0, burn = 0, stamina = 0, blocked = 0, updating_health = TRUE, required_status = null, wound_bonus = 0, bare_wound_bonus = 0, sharpness = NONE, attack_direction = null)
	SHOULD_CALL_PARENT(FALSE)

	var/hit_percent = (100-blocked)/100
	if((!brute && !burn && !stamina) || hit_percent <= 0)
		return FALSE
	if(owner && (owner.status_flags & GODMODE))
		return FALSE	//godmode
	if(required_status && !(bodytype & required_status))
		return FALSE

	var/dmg_multi = CONFIG_GET(number/damage_multiplier) * hit_percent
	brute = round(max(brute * dmg_multi, 0),DAMAGE_PRECISION)
	burn = round(max(burn * dmg_multi, 0),DAMAGE_PRECISION)
	stamina = round(max(stamina * dmg_multi, 0),DAMAGE_PRECISION)
	brute = max(0, brute - brute_reduction)
	burn = max(0, burn - burn_reduction)
	//No stamina scaling.. for now..

	if(!brute && !burn && !stamina)
		return FALSE

	brute *= wound_damage_multiplier
	burn *= wound_damage_multiplier

	/*
	// START WOUND HANDLING
	*/

	// what kind of wounds we're gonna roll for, take the greater between brute and burn, then if it's brute, we subdivide based on sharpness
	var/wounding_type = (brute > burn ? WOUND_BLUNT : WOUND_BURN)
	var/wounding_dmg = max(brute, burn)

	var/mangled_state = get_mangled_state()
	var/bio_state = owner.get_biological_state()
	var/easy_dismember = HAS_TRAIT(owner, TRAIT_EASYDISMEMBER) // if we have easydismember, we don't reduce damage when redirecting damage to different types (slashing weapons on mangled/skinless limbs attack at 100% instead of 50%)

	if(wounding_type == WOUND_BLUNT && sharpness)
		if(sharpness & SHARP_EDGED)
			wounding_type = WOUND_SLASH
		else if (sharpness & SHARP_POINTY)
			wounding_type = WOUND_PIERCE

	//Handling for bone only/flesh only(none right now)/flesh and bone targets
	switch(bio_state)
		// if we're bone only, all cutting attacks go straight to the bone
		if(BIO_JUST_BONE)
			if(wounding_type == WOUND_SLASH)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.6)
			else if(wounding_type == WOUND_PIERCE)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.75)
			if((mangled_state & BODYPART_MANGLED_BONE) && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return
		// note that there's no handling for BIO_JUST_FLESH since we don't have any that are that right now (slimepeople maybe someday)
		// standard humanoids
		if(BIO_FLESH_BONE)
			// if we've already mangled the skin (critical slash or piercing wound), then the bone is exposed, and we can damage it with sharp weapons at a reduced rate
			// So a big sharp weapon is still all you need to destroy a limb
			if(mangled_state == BODYPART_MANGLED_FLESH && sharpness)
				playsound(src, "sound/effects/wounds/crackandbleed.ogg", 100)
				if(wounding_type == WOUND_SLASH && !easy_dismember)
					wounding_dmg *= 0.6 // edged weapons pass along 60% of their wounding damage to the bone since the power is spread out over a larger area
				if(wounding_type == WOUND_PIERCE && !easy_dismember)
					wounding_dmg *= 0.75 // piercing weapons pass along 75% of their wounding damage to the bone since it's more concentrated
				wounding_type = WOUND_BLUNT
			else if(mangled_state == BODYPART_MANGLED_BOTH && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return

	// now we have our wounding_type and are ready to carry on with wounds and dealing the actual damage
	if(owner && wounding_dmg >= WOUND_MINIMUM_DAMAGE && wound_bonus != CANT_WOUND)
		check_wounding(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus, attack_direction)

	for(var/datum/wound/iter_wound as anything in wounds)
		iter_wound.receive_damage(wounding_type, wounding_dmg, wound_bonus)

	/*
	// END WOUND HANDLING
	*/

	//back to our regularly scheduled program, we now actually apply damage if there's room below limb damage cap
	var/can_inflict = max_damage - get_damage()
	var/total_damage = brute + burn
	if(total_damage > can_inflict && total_damage > 0) // TODO: the second part of this check should be removed once disabling is all done
		brute = round(brute * (can_inflict / total_damage),DAMAGE_PRECISION)
		burn = round(burn * (can_inflict / total_damage),DAMAGE_PRECISION)

	if(can_inflict <= 0)
		return FALSE
	if(brute)
		set_brute_dam(brute_dam + brute)
	if(burn)
		set_burn_dam(burn_dam + burn)

	//We've dealt the physical damages, if there's room lets apply the stamina damage.
	if(stamina)
		set_stamina_dam(stamina_dam + round(clamp(stamina, 0, max_stamina_damage - stamina_dam), DAMAGE_PRECISION))

	if(owner && updating_health)
		owner.updatehealth()
		if(stamina > DAMAGE_PRECISION)
			owner.update_stamina()
			owner.stam_regen_start_time = world.time + STAMINA_REGEN_BLOCK_TIME
			. = TRUE
	return update_bodypart_damage_state() || .

/obj/item/bodypart/arm/left/necromorph/check_wounding(woundtype, damage, wound_bonus, bare_wound_bonus, attack_direction)
	SHOULD_CALL_PARENT(FALSE)

	if(HAS_TRAIT(owner, TRAIT_NEVER_WOUNDED))
		return

	// note that these are fed into an exponent, so these are magnified
	if(HAS_TRAIT(owner, TRAIT_EASILY_WOUNDED))
		damage *= 1.5
	else
		damage = min(damage, WOUND_MAX_CONSIDERED_DAMAGE)

	if(HAS_TRAIT(owner,TRAIT_HARDLY_WOUNDED))
		damage *= 0.85

	if(HAS_TRAIT(owner, TRAIT_EASYDISMEMBER))
		damage *= 1.1

	var/base_roll = rand(1, round(damage ** WOUND_DAMAGE_EXPONENT))
	var/injury_roll = base_roll
	injury_roll += check_woundings_mods(woundtype, damage, wound_bonus, bare_wound_bonus)
	var/list/wounds_checking = GLOB.global_wound_types[woundtype]

	var/limb_damage = get_damage()
	if((limb_damage >= max_damage) || (limb_damage >= max_damage*0.8 && prob(20)))
		var/datum/wound/loss/dismembering = new
		dismembering.apply_dismember(src, woundtype, outright = TRUE, attack_direction = attack_direction)
		return

	// quick re-check to see if bare_wound_bonus applies, for the benefit of log_wound(), see about getting the check from check_woundings_mods() somehow
	if(ishuman(owner))
		var/mob/living/carbon/human/human_wearer = owner
		var/list/clothing = human_wearer.clothingonpart(src)
		for(var/obj/item/clothing/clothes_check as anything in clothing)
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			if(clothes_check.armor.getRating(WOUND))
				bare_wound_bonus = 0
				break

	//cycle through the wounds of the relevant category from the most severe down
	for(var/datum/wound/possible_wound as anything in wounds_checking)
		var/datum/wound/replaced_wound
		for(var/datum/wound/existing_wound as anything in wounds)
			if(existing_wound.type in wounds_checking)
				if(existing_wound.severity >= initial(possible_wound.severity))
					return
				else
					replaced_wound = existing_wound

		if(initial(possible_wound.threshold_minimum) < injury_roll)
			var/datum/wound/new_wound
			if(replaced_wound)
				new_wound = replaced_wound.replace_wound(possible_wound, attack_direction = attack_direction)
			else
				new_wound = new possible_wound
				new_wound.apply_wound(src, attack_direction = attack_direction)
			log_wound(owner, new_wound, damage, wound_bonus, bare_wound_bonus, base_roll) // dismembering wounds are logged in the apply_wound() for loss wounds since they delete themselves immediately, these will be immediately returned
			return new_wound

/obj/item/bodypart/arm/right/necromorph
	name = "right arm"
	desc = "Over 87% of humans are right handed. That figure is much lower \
		among humans missing their right arm."
	bodytype = BODYTYPE_NECROMORPH|BODYTYPE_ORGANIC
	limb_id = SPECIES_NECROMORPH
	should_draw_greyscale = FALSE
	icon_static = 'necromorphs/icons/necromorphs/slasher/fleshy.dmi'
	icon_state = "l_arm"
	attack_verb_continuous = list("slaps", "punches")
	attack_verb_simple = list("slap", "punch")
	max_damage = 50
	body_damage_coeff = 0.75
	px_x = 6
	px_y = 0
	max_stamina_damage = 50
	can_be_disabled = FALSE
	wound_resistance = 0

/obj/item/bodypart/arm/right/necromorph/receive_damage(brute = 0, burn = 0, stamina = 0, blocked = 0, updating_health = TRUE, required_status = null, wound_bonus = 0, bare_wound_bonus = 0, sharpness = NONE, attack_direction = null)
	SHOULD_CALL_PARENT(FALSE)

	var/hit_percent = (100-blocked)/100
	if((!brute && !burn && !stamina) || hit_percent <= 0)
		return FALSE
	if(owner && (owner.status_flags & GODMODE))
		return FALSE	//godmode
	if(required_status && !(bodytype & required_status))
		return FALSE

	var/dmg_multi = CONFIG_GET(number/damage_multiplier) * hit_percent
	brute = round(max(brute * dmg_multi, 0),DAMAGE_PRECISION)
	burn = round(max(burn * dmg_multi, 0),DAMAGE_PRECISION)
	stamina = round(max(stamina * dmg_multi, 0),DAMAGE_PRECISION)
	brute = max(0, brute - brute_reduction)
	burn = max(0, burn - burn_reduction)
	//No stamina scaling.. for now..

	if(!brute && !burn && !stamina)
		return FALSE

	brute *= wound_damage_multiplier
	burn *= wound_damage_multiplier

	/*
	// START WOUND HANDLING
	*/

	// what kind of wounds we're gonna roll for, take the greater between brute and burn, then if it's brute, we subdivide based on sharpness
	var/wounding_type = (brute > burn ? WOUND_BLUNT : WOUND_BURN)
	var/wounding_dmg = max(brute, burn)

	var/mangled_state = get_mangled_state()
	var/bio_state = owner.get_biological_state()
	var/easy_dismember = HAS_TRAIT(owner, TRAIT_EASYDISMEMBER) // if we have easydismember, we don't reduce damage when redirecting damage to different types (slashing weapons on mangled/skinless limbs attack at 100% instead of 50%)

	if(wounding_type == WOUND_BLUNT && sharpness)
		if(sharpness & SHARP_EDGED)
			wounding_type = WOUND_SLASH
		else if (sharpness & SHARP_POINTY)
			wounding_type = WOUND_PIERCE

	//Handling for bone only/flesh only(none right now)/flesh and bone targets
	switch(bio_state)
		// if we're bone only, all cutting attacks go straight to the bone
		if(BIO_JUST_BONE)
			if(wounding_type == WOUND_SLASH)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.6)
			else if(wounding_type == WOUND_PIERCE)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.75)
			if((mangled_state & BODYPART_MANGLED_BONE) && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return
		// note that there's no handling for BIO_JUST_FLESH since we don't have any that are that right now (slimepeople maybe someday)
		// standard humanoids
		if(BIO_FLESH_BONE)
			// if we've already mangled the skin (critical slash or piercing wound), then the bone is exposed, and we can damage it with sharp weapons at a reduced rate
			// So a big sharp weapon is still all you need to destroy a limb
			if(mangled_state == BODYPART_MANGLED_FLESH && sharpness)
				playsound(src, "sound/effects/wounds/crackandbleed.ogg", 100)
				if(wounding_type == WOUND_SLASH && !easy_dismember)
					wounding_dmg *= 0.6 // edged weapons pass along 60% of their wounding damage to the bone since the power is spread out over a larger area
				if(wounding_type == WOUND_PIERCE && !easy_dismember)
					wounding_dmg *= 0.75 // piercing weapons pass along 75% of their wounding damage to the bone since it's more concentrated
				wounding_type = WOUND_BLUNT
			else if(mangled_state == BODYPART_MANGLED_BOTH && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return

	// now we have our wounding_type and are ready to carry on with wounds and dealing the actual damage
	if(owner && wounding_dmg >= WOUND_MINIMUM_DAMAGE && wound_bonus != CANT_WOUND)
		check_wounding(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus, attack_direction)

	for(var/datum/wound/iter_wound as anything in wounds)
		iter_wound.receive_damage(wounding_type, wounding_dmg, wound_bonus)

	/*
	// END WOUND HANDLING
	*/

	//back to our regularly scheduled program, we now actually apply damage if there's room below limb damage cap
	var/can_inflict = max_damage - get_damage()
	var/total_damage = brute + burn
	if(total_damage > can_inflict && total_damage > 0) // TODO: the second part of this check should be removed once disabling is all done
		brute = round(brute * (can_inflict / total_damage),DAMAGE_PRECISION)
		burn = round(burn * (can_inflict / total_damage),DAMAGE_PRECISION)

	if(can_inflict <= 0)
		return FALSE
	if(brute)
		set_brute_dam(brute_dam + brute)
	if(burn)
		set_burn_dam(burn_dam + burn)

	//We've dealt the physical damages, if there's room lets apply the stamina damage.
	if(stamina)
		set_stamina_dam(stamina_dam + round(clamp(stamina, 0, max_stamina_damage - stamina_dam), DAMAGE_PRECISION))

	if(owner && updating_health)
		owner.updatehealth()
		if(stamina > DAMAGE_PRECISION)
			owner.update_stamina()
			owner.stam_regen_start_time = world.time + STAMINA_REGEN_BLOCK_TIME
			. = TRUE
	return update_bodypart_damage_state() || .

/obj/item/bodypart/arm/right/necromorph/check_wounding(woundtype, damage, wound_bonus, bare_wound_bonus, attack_direction)
	SHOULD_CALL_PARENT(FALSE)

	if(HAS_TRAIT(owner, TRAIT_NEVER_WOUNDED))
		return

	// note that these are fed into an exponent, so these are magnified
	if(HAS_TRAIT(owner, TRAIT_EASILY_WOUNDED))
		damage *= 1.5
	else
		damage = min(damage, WOUND_MAX_CONSIDERED_DAMAGE)

	if(HAS_TRAIT(owner,TRAIT_HARDLY_WOUNDED))
		damage *= 0.85

	if(HAS_TRAIT(owner, TRAIT_EASYDISMEMBER))
		damage *= 1.1

	var/base_roll = rand(1, round(damage ** WOUND_DAMAGE_EXPONENT))
	var/injury_roll = base_roll
	injury_roll += check_woundings_mods(woundtype, damage, wound_bonus, bare_wound_bonus)
	var/list/wounds_checking = GLOB.global_wound_types[woundtype]

	var/limb_damage = get_damage()
	if((limb_damage >= max_damage) || (limb_damage >= max_damage*0.8 && prob(20)))
		var/datum/wound/loss/dismembering = new
		dismembering.apply_dismember(src, woundtype, outright = TRUE, attack_direction = attack_direction)
		return

	// quick re-check to see if bare_wound_bonus applies, for the benefit of log_wound(), see about getting the check from check_woundings_mods() somehow
	if(ishuman(owner))
		var/mob/living/carbon/human/human_wearer = owner
		var/list/clothing = human_wearer.clothingonpart(src)
		for(var/obj/item/clothing/clothes_check as anything in clothing)
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			if(clothes_check.armor.getRating(WOUND))
				bare_wound_bonus = 0
				break

	//cycle through the wounds of the relevant category from the most severe down
	for(var/datum/wound/possible_wound as anything in wounds_checking)
		var/datum/wound/replaced_wound
		for(var/datum/wound/existing_wound as anything in wounds)
			if(existing_wound.type in wounds_checking)
				if(existing_wound.severity >= initial(possible_wound.severity))
					return
				else
					replaced_wound = existing_wound

		if(initial(possible_wound.threshold_minimum) < injury_roll)
			var/datum/wound/new_wound
			if(replaced_wound)
				new_wound = replaced_wound.replace_wound(possible_wound, attack_direction = attack_direction)
			else
				new_wound = new possible_wound
				new_wound.apply_wound(src, attack_direction = attack_direction)
			log_wound(owner, new_wound, damage, wound_bonus, bare_wound_bonus, base_roll) // dismembering wounds are logged in the apply_wound() for loss wounds since they delete themselves immediately, these will be immediately returned
			return new_wound

/obj/item/bodypart/leg/left/necromorph
	name = "left leg"
	desc = "Some athletes prefer to tie their left shoelaces first for good \
		luck. In this instance, it probably would not have helped."
	bodytype = BODYTYPE_NECROMORPH|BODYTYPE_ORGANIC
	limb_id = SPECIES_NECROMORPH
	should_draw_greyscale = FALSE
	icon_static = 'necromorphs/icons/necromorphs/slasher/fleshy.dmi'
	icon_state = "l_arm"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 12
	max_stamina_damage = 50
	can_be_disabled = FALSE
	wound_resistance = 0

/obj/item/bodypart/leg/left/necromorph/receive_damage(brute = 0, burn = 0, stamina = 0, blocked = 0, updating_health = TRUE, required_status = null, wound_bonus = 0, bare_wound_bonus = 0, sharpness = NONE, attack_direction = null)
	SHOULD_CALL_PARENT(FALSE)

	var/hit_percent = (100-blocked)/100
	if((!brute && !burn && !stamina) || hit_percent <= 0)
		return FALSE
	if(owner && (owner.status_flags & GODMODE))
		return FALSE	//godmode
	if(required_status && !(bodytype & required_status))
		return FALSE

	var/dmg_multi = CONFIG_GET(number/damage_multiplier) * hit_percent
	brute = round(max(brute * dmg_multi, 0),DAMAGE_PRECISION)
	burn = round(max(burn * dmg_multi, 0),DAMAGE_PRECISION)
	stamina = round(max(stamina * dmg_multi, 0),DAMAGE_PRECISION)
	brute = max(0, brute - brute_reduction)
	burn = max(0, burn - burn_reduction)
	//No stamina scaling.. for now..

	if(!brute && !burn && !stamina)
		return FALSE

	brute *= wound_damage_multiplier
	burn *= wound_damage_multiplier

	/*
	// START WOUND HANDLING
	*/

	// what kind of wounds we're gonna roll for, take the greater between brute and burn, then if it's brute, we subdivide based on sharpness
	var/wounding_type = (brute > burn ? WOUND_BLUNT : WOUND_BURN)
	var/wounding_dmg = max(brute, burn)

	var/mangled_state = get_mangled_state()
	var/bio_state = owner.get_biological_state()
	var/easy_dismember = HAS_TRAIT(owner, TRAIT_EASYDISMEMBER) // if we have easydismember, we don't reduce damage when redirecting damage to different types (slashing weapons on mangled/skinless limbs attack at 100% instead of 50%)

	if(wounding_type == WOUND_BLUNT && sharpness)
		if(sharpness & SHARP_EDGED)
			wounding_type = WOUND_SLASH
		else if (sharpness & SHARP_POINTY)
			wounding_type = WOUND_PIERCE

	//Handling for bone only/flesh only(none right now)/flesh and bone targets
	switch(bio_state)
		// if we're bone only, all cutting attacks go straight to the bone
		if(BIO_JUST_BONE)
			if(wounding_type == WOUND_SLASH)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.6)
			else if(wounding_type == WOUND_PIERCE)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.75)
			if((mangled_state & BODYPART_MANGLED_BONE) && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return
		// note that there's no handling for BIO_JUST_FLESH since we don't have any that are that right now (slimepeople maybe someday)
		// standard humanoids
		if(BIO_FLESH_BONE)
			// if we've already mangled the skin (critical slash or piercing wound), then the bone is exposed, and we can damage it with sharp weapons at a reduced rate
			// So a big sharp weapon is still all you need to destroy a limb
			if(mangled_state == BODYPART_MANGLED_FLESH && sharpness)
				playsound(src, "sound/effects/wounds/crackandbleed.ogg", 100)
				if(wounding_type == WOUND_SLASH && !easy_dismember)
					wounding_dmg *= 0.6 // edged weapons pass along 60% of their wounding damage to the bone since the power is spread out over a larger area
				if(wounding_type == WOUND_PIERCE && !easy_dismember)
					wounding_dmg *= 0.75 // piercing weapons pass along 75% of their wounding damage to the bone since it's more concentrated
				wounding_type = WOUND_BLUNT
			else if(mangled_state == BODYPART_MANGLED_BOTH && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return

	// now we have our wounding_type and are ready to carry on with wounds and dealing the actual damage
	if(owner && wounding_dmg >= WOUND_MINIMUM_DAMAGE && wound_bonus != CANT_WOUND)
		check_wounding(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus, attack_direction)

	for(var/datum/wound/iter_wound as anything in wounds)
		iter_wound.receive_damage(wounding_type, wounding_dmg, wound_bonus)

	/*
	// END WOUND HANDLING
	*/

	//back to our regularly scheduled program, we now actually apply damage if there's room below limb damage cap
	var/can_inflict = max_damage - get_damage()
	var/total_damage = brute + burn
	if(total_damage > can_inflict && total_damage > 0) // TODO: the second part of this check should be removed once disabling is all done
		brute = round(brute * (can_inflict / total_damage),DAMAGE_PRECISION)
		burn = round(burn * (can_inflict / total_damage),DAMAGE_PRECISION)

	if(can_inflict <= 0)
		return FALSE
	if(brute)
		set_brute_dam(brute_dam + brute)
	if(burn)
		set_burn_dam(burn_dam + burn)

	//We've dealt the physical damages, if there's room lets apply the stamina damage.
	if(stamina)
		set_stamina_dam(stamina_dam + round(clamp(stamina, 0, max_stamina_damage - stamina_dam), DAMAGE_PRECISION))

	if(owner && updating_health)
		owner.updatehealth()
		if(stamina > DAMAGE_PRECISION)
			owner.update_stamina()
			owner.stam_regen_start_time = world.time + STAMINA_REGEN_BLOCK_TIME
			. = TRUE
	return update_bodypart_damage_state() || .

/obj/item/bodypart/leg/left/necromorph/check_wounding(woundtype, damage, wound_bonus, bare_wound_bonus, attack_direction)
	SHOULD_CALL_PARENT(FALSE)

	if(HAS_TRAIT(owner, TRAIT_NEVER_WOUNDED))
		return

	// note that these are fed into an exponent, so these are magnified
	if(HAS_TRAIT(owner, TRAIT_EASILY_WOUNDED))
		damage *= 1.5
	else
		damage = min(damage, WOUND_MAX_CONSIDERED_DAMAGE)

	if(HAS_TRAIT(owner,TRAIT_HARDLY_WOUNDED))
		damage *= 0.85

	if(HAS_TRAIT(owner, TRAIT_EASYDISMEMBER))
		damage *= 1.1

	var/base_roll = rand(1, round(damage ** WOUND_DAMAGE_EXPONENT))
	var/injury_roll = base_roll
	injury_roll += check_woundings_mods(woundtype, damage, wound_bonus, bare_wound_bonus)
	var/list/wounds_checking = GLOB.global_wound_types[woundtype]

	var/limb_damage = get_damage()
	if((limb_damage >= max_damage) || (limb_damage >= max_damage*0.8 && prob(20)))
		var/datum/wound/loss/dismembering = new
		dismembering.apply_dismember(src, woundtype, outright = TRUE, attack_direction = attack_direction)
		return

	// quick re-check to see if bare_wound_bonus applies, for the benefit of log_wound(), see about getting the check from check_woundings_mods() somehow
	if(ishuman(owner))
		var/mob/living/carbon/human/human_wearer = owner
		var/list/clothing = human_wearer.clothingonpart(src)
		for(var/obj/item/clothing/clothes_check as anything in clothing)
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			if(clothes_check.armor.getRating(WOUND))
				bare_wound_bonus = 0
				break

	//cycle through the wounds of the relevant category from the most severe down
	for(var/datum/wound/possible_wound as anything in wounds_checking)
		var/datum/wound/replaced_wound
		for(var/datum/wound/existing_wound as anything in wounds)
			if(existing_wound.type in wounds_checking)
				if(existing_wound.severity >= initial(possible_wound.severity))
					return
				else
					replaced_wound = existing_wound

		if(initial(possible_wound.threshold_minimum) < injury_roll)
			var/datum/wound/new_wound
			if(replaced_wound)
				new_wound = replaced_wound.replace_wound(possible_wound, attack_direction = attack_direction)
			else
				new_wound = new possible_wound
				new_wound.apply_wound(src, attack_direction = attack_direction)
			log_wound(owner, new_wound, damage, wound_bonus, bare_wound_bonus, base_roll) // dismembering wounds are logged in the apply_wound() for loss wounds since they delete themselves immediately, these will be immediately returned
			return new_wound

/obj/item/bodypart/leg/right/necromorph
	name = "right leg"
	desc = "You put your right leg in, your right leg out. In, out, in, out, \
		shake it all about. And apparently then it detaches.\n\
		The hokey pokey has certainly changed a lot since space colonisation."
	bodytype = BODYTYPE_NECROMORPH|BODYTYPE_ORGANIC
	limb_id = SPECIES_NECROMORPH
	should_draw_greyscale = FALSE
	icon_static = 'necromorphs/icons/necromorphs/slasher/fleshy.dmi'
	icon_state = "l_arm"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	body_zone = BODY_ZONE_R_LEG
	body_part = LEG_RIGHT
	body_damage_coeff = 0.75
	px_x = 2
	px_y = 12
	max_stamina_damage = 50
	can_be_disabled = FALSE
	wound_resistance = 0

/obj/item/bodypart/leg/right/necromorph/receive_damage(brute = 0, burn = 0, stamina = 0, blocked = 0, updating_health = TRUE, required_status = null, wound_bonus = 0, bare_wound_bonus = 0, sharpness = NONE, attack_direction = null)
	SHOULD_CALL_PARENT(FALSE)

	var/hit_percent = (100-blocked)/100
	if((!brute && !burn && !stamina) || hit_percent <= 0)
		return FALSE
	if(owner && (owner.status_flags & GODMODE))
		return FALSE	//godmode
	if(required_status && !(bodytype & required_status))
		return FALSE

	var/dmg_multi = CONFIG_GET(number/damage_multiplier) * hit_percent
	brute = round(max(brute * dmg_multi, 0),DAMAGE_PRECISION)
	burn = round(max(burn * dmg_multi, 0),DAMAGE_PRECISION)
	stamina = round(max(stamina * dmg_multi, 0),DAMAGE_PRECISION)
	brute = max(0, brute - brute_reduction)
	burn = max(0, burn - burn_reduction)
	//No stamina scaling.. for now..

	if(!brute && !burn && !stamina)
		return FALSE

	brute *= wound_damage_multiplier
	burn *= wound_damage_multiplier

	/*
	// START WOUND HANDLING
	*/

	// what kind of wounds we're gonna roll for, take the greater between brute and burn, then if it's brute, we subdivide based on sharpness
	var/wounding_type = (brute > burn ? WOUND_BLUNT : WOUND_BURN)
	var/wounding_dmg = max(brute, burn)

	var/mangled_state = get_mangled_state()
	var/bio_state = owner.get_biological_state()
	var/easy_dismember = HAS_TRAIT(owner, TRAIT_EASYDISMEMBER) // if we have easydismember, we don't reduce damage when redirecting damage to different types (slashing weapons on mangled/skinless limbs attack at 100% instead of 50%)

	if(wounding_type == WOUND_BLUNT && sharpness)
		if(sharpness & SHARP_EDGED)
			wounding_type = WOUND_SLASH
		else if (sharpness & SHARP_POINTY)
			wounding_type = WOUND_PIERCE

	//Handling for bone only/flesh only(none right now)/flesh and bone targets
	switch(bio_state)
		// if we're bone only, all cutting attacks go straight to the bone
		if(BIO_JUST_BONE)
			if(wounding_type == WOUND_SLASH)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.6)
			else if(wounding_type == WOUND_PIERCE)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.75)
			if((mangled_state & BODYPART_MANGLED_BONE) && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return
		// note that there's no handling for BIO_JUST_FLESH since we don't have any that are that right now (slimepeople maybe someday)
		// standard humanoids
		if(BIO_FLESH_BONE)
			// if we've already mangled the skin (critical slash or piercing wound), then the bone is exposed, and we can damage it with sharp weapons at a reduced rate
			// So a big sharp weapon is still all you need to destroy a limb
			if(mangled_state == BODYPART_MANGLED_FLESH && sharpness)
				playsound(src, "sound/effects/wounds/crackandbleed.ogg", 100)
				if(wounding_type == WOUND_SLASH && !easy_dismember)
					wounding_dmg *= 0.6 // edged weapons pass along 60% of their wounding damage to the bone since the power is spread out over a larger area
				if(wounding_type == WOUND_PIERCE && !easy_dismember)
					wounding_dmg *= 0.75 // piercing weapons pass along 75% of their wounding damage to the bone since it's more concentrated
				wounding_type = WOUND_BLUNT
			else if(mangled_state == BODYPART_MANGLED_BOTH && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return

	// now we have our wounding_type and are ready to carry on with wounds and dealing the actual damage
	if(owner && wounding_dmg >= WOUND_MINIMUM_DAMAGE && wound_bonus != CANT_WOUND)
		check_wounding(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus, attack_direction)

	for(var/datum/wound/iter_wound as anything in wounds)
		iter_wound.receive_damage(wounding_type, wounding_dmg, wound_bonus)

	/*
	// END WOUND HANDLING
	*/

	//back to our regularly scheduled program, we now actually apply damage if there's room below limb damage cap
	var/can_inflict = max_damage - get_damage()
	var/total_damage = brute + burn
	if(total_damage > can_inflict && total_damage > 0) // TODO: the second part of this check should be removed once disabling is all done
		brute = round(brute * (can_inflict / total_damage),DAMAGE_PRECISION)
		burn = round(burn * (can_inflict / total_damage),DAMAGE_PRECISION)

	if(can_inflict <= 0)
		return FALSE
	if(brute)
		set_brute_dam(brute_dam + brute)
	if(burn)
		set_burn_dam(burn_dam + burn)

	//We've dealt the physical damages, if there's room lets apply the stamina damage.
	if(stamina)
		set_stamina_dam(stamina_dam + round(clamp(stamina, 0, max_stamina_damage - stamina_dam), DAMAGE_PRECISION))

	if(owner && updating_health)
		owner.updatehealth()
		if(stamina > DAMAGE_PRECISION)
			owner.update_stamina()
			owner.stam_regen_start_time = world.time + STAMINA_REGEN_BLOCK_TIME
			. = TRUE
	return update_bodypart_damage_state() || .

/obj/item/bodypart/leg/right/necromorph/check_wounding(woundtype, damage, wound_bonus, bare_wound_bonus, attack_direction)
	SHOULD_CALL_PARENT(FALSE)

	if(HAS_TRAIT(owner, TRAIT_NEVER_WOUNDED))
		return

	// note that these are fed into an exponent, so these are magnified
	if(HAS_TRAIT(owner, TRAIT_EASILY_WOUNDED))
		damage *= 1.5
	else
		damage = min(damage, WOUND_MAX_CONSIDERED_DAMAGE)

	if(HAS_TRAIT(owner,TRAIT_HARDLY_WOUNDED))
		damage *= 0.85

	if(HAS_TRAIT(owner, TRAIT_EASYDISMEMBER))
		damage *= 1.1

	var/base_roll = rand(1, round(damage ** WOUND_DAMAGE_EXPONENT))
	var/injury_roll = base_roll
	injury_roll += check_woundings_mods(woundtype, damage, wound_bonus, bare_wound_bonus)
	var/list/wounds_checking = GLOB.global_wound_types[woundtype]

	var/limb_damage = get_damage()
	if((limb_damage >= max_damage) || (limb_damage >= max_damage*0.8 && prob(20)))
		var/datum/wound/loss/dismembering = new
		dismembering.apply_dismember(src, woundtype, outright = TRUE, attack_direction = attack_direction)
		return

	// quick re-check to see if bare_wound_bonus applies, for the benefit of log_wound(), see about getting the check from check_woundings_mods() somehow
	if(ishuman(owner))
		var/mob/living/carbon/human/human_wearer = owner
		var/list/clothing = human_wearer.clothingonpart(src)
		for(var/obj/item/clothing/clothes_check as anything in clothing)
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			if(clothes_check.armor.getRating(WOUND))
				bare_wound_bonus = 0
				break

	//cycle through the wounds of the relevant category from the most severe down
	for(var/datum/wound/possible_wound as anything in wounds_checking)
		var/datum/wound/replaced_wound
		for(var/datum/wound/existing_wound as anything in wounds)
			if(existing_wound.type in wounds_checking)
				if(existing_wound.severity >= initial(possible_wound.severity))
					return
				else
					replaced_wound = existing_wound

		if(initial(possible_wound.threshold_minimum) < injury_roll)
			var/datum/wound/new_wound
			if(replaced_wound)
				new_wound = replaced_wound.replace_wound(possible_wound, attack_direction = attack_direction)
			else
				new_wound = new possible_wound
				new_wound.apply_wound(src, attack_direction = attack_direction)
			log_wound(owner, new_wound, damage, wound_bonus, bare_wound_bonus, base_roll) // dismembering wounds are logged in the apply_wound() for loss wounds since they delete themselves immediately, these will be immediately returned
			return new_wound

/obj/item/organ/external/tail/necromorph
	name = "tail"
	desc = "A severed tail. What did you cut this off of?"
	visual = TRUE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_EXTERNAL_TAIL

/obj/item/organ/external/tail/necromorph/get_global_feature_list()
	return GLOB.necromorph_tails

/datum/sprite_accessory/necromorph
	em_block = TRUE
	locked = TRUE
