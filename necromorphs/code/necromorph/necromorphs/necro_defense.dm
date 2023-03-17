/mob/living/carbon/human/necromorph/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	if(SEND_SIGNAL(src, COMSIG_LIVING_UNARMED_ATTACK, attack_target, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	attack_target.attack_necromorph(src, modifiers)

/atom/proc/attack_necromorph(mob/living/carbon/human/necromorph/user, list/modifiers, dealt_damage)
	if(!uses_integrity || (!user.melee_damage_upper && !dealt_damage)) //No damage
		return FALSE
	dealt_damage = dealt_damage ? dealt_damage : rand(user.melee_damage_lower, user.melee_damage_upper)
	user.do_attack_animation(src, user.attack_effect)
	attack_generic(user, dealt_damage, BRUTE, MELEE,TRUE, user.armour_penetration)

/mob/living/carbon/human/necromorph/get_eye_protection()
	return ..() + 2

/mob/living/carbon/human/necromorph/get_ear_protection()
	return INFINITY

/mob/living/carbon/human/necromorph/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	skipcatch = TRUE
	.=..()

/mob/living/attack_necromorph(mob/living/carbon/human/necromorph/user, list/modifiers, dealt_damage)
	dealt_damage = dealt_damage ? dealt_damage : rand(user.melee_damage_lower, user.melee_damage_upper)
	user.do_attack_animation(src, user.attack_effect)
	playsound(loc, 'sound/weapons/slash.ogg', 50, TRUE, -1)
	visible_message(span_danger("[user.name] slashes [src]!"), \
					span_userdanger("[user.name] slashes you!"), span_hear("You hear a cutting of the flesh!"), COMBAT_MESSAGE_RANGE, user)
	to_chat(user, span_danger("You slash [src]!"))
	adjustBruteLoss(dealt_damage)
	log_combat(user, src, "attacked")
	updatehealth()

/mob/living/carbon/human/attack_necromorph(mob/living/carbon/human/necromorph/user, list/modifiers, dealt_damage)
	if(check_shields(user, 0, "the [user.name]"))
		visible_message(span_danger("[user] attempts to touch [src]!"), \
						span_danger("[user] attempts to touch you!"), span_hear("You hear a swoosh!"), null, user)
		to_chat(user, span_warning("You attempt to touch [src]!"))
		return FALSE

	user.do_attack_animation(src, user.attack_effect)
	if (w_uniform)
		w_uniform.add_fingerprint(user)
	dealt_damage = dealt_damage ? dealt_damage : rand(user.melee_damage_lower, user.melee_damage_upper)
	var/damage = prob(90) ? dealt_damage : 0
	if(!damage)
		playsound(loc, 'sound/weapons/slashmiss.ogg', 50, TRUE, -1)
		visible_message(span_danger("[user] lunges at [src]!"), \
						span_userdanger("[user] lunges at you!"), span_hear("You hear a swoosh!"), null, user)
		to_chat(user, span_danger("You lunge at [src]!"))
		return FALSE
	var/obj/item/bodypart/affecting = get_bodypart(ran_zone(user.zone_selected))
	if(!affecting)
		affecting = get_bodypart(BODY_ZONE_CHEST)
	var/armor_block = run_armor_check(affecting, MELEE,"","",10)

	playsound(loc, 'sound/weapons/slice.ogg', 25, TRUE, -1)
	visible_message(span_danger("[user] slashes at [src]!"), \
					span_userdanger("[user] slashes at you!"), span_hear("You hear a sickening sound of a slice!"), null, user)
	to_chat(user, span_danger("You slash at [src]!"))
	log_combat(user, src, "attacked")
	if(!dismembering_strike(user, user.zone_selected)) //Dismemberment successful
		return TRUE
	apply_damage(damage, BRUTE, affecting, armor_block)

/mob/living/carbon/human/necromorph/attack_hand(mob/living/carbon/human/user, list/modifiers)
	.=..()
	if(.) //to allow surgery to return properly.
		return FALSE

	var/martial_result = user.apply_martial_art(src, modifiers)
	if (martial_result != MARTIAL_ATTACK_INVALID)
		return martial_result

	if(user.combat_mode)
		if(LAZYACCESS(modifiers, RIGHT_CLICK))
			user.do_attack_animation(src, ATTACK_EFFECT_DISARM)
			return TRUE
		user.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
		return TRUE
	else
		help_shake_act(user)

/mob/living/carbon/human/necromorph/attack_paw(mob/living/carbon/human/user, list/modifiers)
	if(..())
		if (stat != DEAD)
			var/obj/item/bodypart/affecting = get_bodypart(ran_zone(user.zone_selected))
			apply_damage(rand(1, 3), BRUTE, affecting)

/mob/living/carbon/human/necromorph/attack_animal(mob/living/simple_animal/user, list/modifiers)
	.=..()
	if(.)
		var/damage = rand(user.melee_damage_lower, user.melee_damage_upper)
		switch(user.melee_damage_type)
			if(BRUTE)
				adjustBruteLoss(damage)
			if(BURN)
				adjustFireLoss(damage)
			if(TOX)
				adjustToxLoss(damage)
			if(OXY)
				adjustOxyLoss(damage)
			if(CLONE)
				adjustCloneLoss(damage)
			if(STAMINA)
				adjustStaminaLoss(damage)

/mob/living/carbon/human/necromorph/ex_act(severity, target, origin)
	. = ..()
	if (!severity || QDELETED(src))
		return
	var/brute_loss = 0
	var/burn_loss = 0
	var/bomb_armor = getarmor(null, BOMB)

//200 max knockdown for EXPLODE_HEAVY
//160 max knockdown for EXPLODE_LIGHT

	var/obj/item/organ/internal/ears/ears = getorganslot(ORGAN_SLOT_EARS)
	switch (severity)
		if (EXPLODE_DEVASTATE)
			if(bomb_armor < EXPLODE_GIB_THRESHOLD) //gibs the mob if their bomb armor is lower than EXPLODE_GIB_THRESHOLD
				for(var/thing in contents)
					switch(severity)
						if(EXPLODE_DEVASTATE)
							SSexplosions.high_mov_atom += thing
						if(EXPLODE_HEAVY)
							SSexplosions.med_mov_atom += thing
						if(EXPLODE_LIGHT)
							SSexplosions.low_mov_atom += thing
				gib()
				return
			else
				brute_loss = 500
				var/atom/throw_target = get_edge_target_turf(src, get_dir(src, get_step_away(src, src)))
				throw_at(throw_target, 200, 4)
				damage_clothes(400 - bomb_armor, BRUTE, BOMB)

		if (EXPLODE_HEAVY)
			brute_loss = 60
			burn_loss = 60
			if(bomb_armor)
				brute_loss = 30*(2 - round(bomb_armor*0.01, 0.05))
				burn_loss = brute_loss //damage gets reduced from 120 to up to 60 combined brute+burn
			damage_clothes(200 - bomb_armor, BRUTE, BOMB)
			Unconscious(20) //short amount of time for follow up attacks against elusive enemies like wizards
			Knockdown(200 - (bomb_armor * 1.6)) //between ~4 and ~20 seconds of knockdown depending on bomb armor

		if(EXPLODE_LIGHT)
			brute_loss = 30
			if(bomb_armor)
				brute_loss = 15*(2 - round(bomb_armor*0.01, 0.05))
			damage_clothes(max(50 - bomb_armor, 0), BRUTE, BOMB)
			if (ears && !HAS_TRAIT_FROM(src, TRAIT_DEAF, CLOTHING_TRAIT))
				ears.adjustEarDamage(15,60)
			Knockdown(160 - (bomb_armor * 1.6)) //100 bomb armor will prevent knockdown altogether

	take_overall_damage(brute_loss,burn_loss)

	//attempt to dismember bodyparts
	if(severity >= EXPLODE_HEAVY || !bomb_armor)
		var/max_limb_loss = 0
		var/probability = 0
		switch(severity)
			if(EXPLODE_NONE)
				max_limb_loss = 1
				probability = 20
			if(EXPLODE_LIGHT)
				max_limb_loss = 2
				probability = 30
			if(EXPLODE_HEAVY)
				max_limb_loss = 3
				probability = 40
			if(EXPLODE_DEVASTATE)
				max_limb_loss = 4
				probability = 50
		for(var/X in bodyparts)
			var/obj/item/bodypart/BP = X
			if(prob(probability) && !prob(getarmor(BP, BOMB)) && BP.body_zone != BODY_ZONE_HEAD && BP.body_zone != BODY_ZONE_CHEST)
				BP.receive_damage(INFINITY) //Capped by proc
				BP.dismember()
				max_limb_loss--
				if(!max_limb_loss)
					break

/mob/living/carbon/human/necromorph/getToxLoss()
	return FALSE

/mob/living/carbon/human/necromorph/adjustToxLoss(amount, updating_health = TRUE, forced = FALSE)
	return FALSE

/mob/living/carbon/human/necromorph/adjustStaminaLoss(amount, updating_health = 1, forced = FALSE)
	return FALSE

/mob/living/carbon/human/necromorph/setStaminaLoss(amount, updating_health = 1)
	return FALSE

/mob/living/carbon/human/necromorph/soundbang_act(intensity = 1, stun_pwr = 20, damage_pwr = 5, deafen_pwr = 15)
	return 0
