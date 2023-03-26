/obj/item/bodypart/chest/necromorph/exploder
	name = BODY_ZONE_CHEST
	desc = "It's impolite to stare at a person's chest."
	icon_static = 'necromorphs/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "chest"
	max_damage = 200
	px_x = 0
	px_y = 0
	stam_damage_coeff = 1
	max_stamina_damage = 120
	wound_resistance = 10

/obj/item/bodypart/head/necromorph/exploder
	name = BODY_ZONE_HEAD
	desc = "Didn't make sense not to live for fun, your brain gets smart but your head gets dumb."
	icon_static = 'necromorphs/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "head"
	max_damage = 200
	px_x = 0
	px_y = -8
	stam_damage_coeff = 1
	max_stamina_damage = 100
	wound_resistance = 5

/obj/item/bodypart/arm/left/necromorph/exploder
	name = "yellow pustule"
	desc = "Did you know that the word 'sinister' stems originally from the \
		Latin 'sinestra' (left hand), because the left hand was supposed to \
		be possessed by the devil? This arm appears to be possessed by no \
		one though."
	icon_static = 'necromorphs/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "l_arm"
	max_damage = 50
	max_stamina_damage = 50
	body_damage_coeff = 0.75
	px_x = -6
	px_y = 0
	wound_resistance = 0
	integrity_failure = 0.25
	var/list/datum/action/cooldown/necro/exploding_actions

/obj/item/bodypart/arm/left/necromorph/exploder/Initialize(mapload)
	. = ..()
	exploding_actions = list(
		new /datum/action/cooldown/necro/explode(src),
		new /datum/action/cooldown/necro/charge/exploder(src),
	)

/obj/item/bodypart/arm/left/necromorph/exploder/Destroy()
	exploding_actions = null
	return ..()

/obj/item/bodypart/arm/left/necromorph/exploder/attach_limb(mob/living/carbon/new_limb_owner, special)
	if(..())
		for(var/datum/action/cooldown/necro/ability as anything in exploding_actions)
			ability.Grant(new_limb_owner)
		return TRUE

/obj/item/bodypart/arm/left/necromorph/exploder/drop_limb(special)
	for(var/datum/action/cooldown/necro/ability as anything in exploding_actions)
		ability.Remove(owner)
	..()

/obj/item/bodypart/arm/left/necromorph/exploder/atom_break()
	..()
	explode()

/obj/item/bodypart/arm/left/necromorph/exploder/proc/explode()
	explosion(get_turf(loc ? loc : owner), 0, 0, 2, 1, smoke = TRUE, explosion_cause = src)
	qdel(src)

/obj/item/bodypart/arm/right/necromorph/exploder
	name = "right arm"
	desc = "Over 87% of humans are right handed. That figure is much lower \
		among humans missing their right arm."
	icon_static = 'necromorphs/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "l_arm"
	max_damage = 50
	body_damage_coeff = 0.75
	px_x = 6
	px_y = 0
	max_stamina_damage = 50
	wound_resistance = 0

/obj/item/bodypart/leg/left/necromorph/exploder
	name = "left leg"
	desc = "Some athletes prefer to tie their left shoelaces first for good \
		luck. In this instance, it probably would not have helped."
	icon_static = 'necromorphs/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "l_arm"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 12
	max_stamina_damage = 50
	wound_resistance = 0

/obj/item/bodypart/leg/right/necromorph/exploder
	name = "right leg"
	desc = "You put your right leg in, your right leg out. In, out, in, out, \
		shake it all about. And apparently then it detaches.\n\
		The hokey pokey has certainly changed a lot since space colonisation."
	icon_static = 'necromorphs/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "l_arm"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	body_damage_coeff = 0.75
	px_x = 2
	px_y = 12
	max_stamina_damage = 50
	wound_resistance = 0
