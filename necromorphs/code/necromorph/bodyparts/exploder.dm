/obj/item/bodypart/chest/necromorph/exploder
	name = BODY_ZONE_CHEST
	limb_id = SPECIES_NECROMORPH_EXPLODER
	icon_static = 'necromorphs/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "chest"
	max_damage = 200
	px_x = 0
	px_y = 0
	wound_resistance = 10

/obj/item/bodypart/head/necromorph/exploder
	name = BODY_ZONE_HEAD
	limb_id = SPECIES_NECROMORPH_EXPLODER
	icon_static = 'necromorphs/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "head"
	max_damage = 200
	px_x = 0
	px_y = -8
	wound_resistance = 5

//This is an arm actually. It's just used for walking
/obj/item/bodypart/leg/left/necromorph/exploder
	name = "yellow pustule"
	limb_id = SPECIES_NECROMORPH_EXPLODER
	icon_static = 'necromorphs/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "l_leg"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 12
	wound_resistance = 0
	integrity_failure = 0.25
	var/list/datum/action/cooldown/necro/exploding_actions

/obj/item/bodypart/leg/left/necromorph/exploder/Initialize(mapload)
	. = ..()
	exploding_actions = list(
		new /datum/action/cooldown/necro/explode(src),
		new /datum/action/cooldown/necro/charge/exploder(src),
	)

/obj/item/bodypart/leg/left/necromorph/exploder/Destroy()
	exploding_actions = null
	return ..()

/obj/item/bodypart/leg/left/necromorph/exploder/attach_limb(mob/living/carbon/new_limb_owner, special)
	if(..())
		for(var/datum/action/cooldown/necro/ability as anything in exploding_actions)
			ability.Grant(new_limb_owner)
		return TRUE

/obj/item/bodypart/leg/left/necromorph/exploder/drop_limb(special)
	for(var/datum/action/cooldown/necro/ability as anything in exploding_actions)
		ability.Remove(owner)
	..()

/obj/item/bodypart/leg/left/necromorph/exploder/atom_break()
	..()
	explode()

/obj/item/bodypart/leg/left/necromorph/exploder/proc/explode()
	explosion(get_turf(loc ? loc : owner), 0, 0, 2, 1, smoke = TRUE, explosion_cause = src)
	qdel(src)

/obj/item/bodypart/leg/right/necromorph/exploder
	name = "right arm"
	limb_id = SPECIES_NECROMORPH_EXPLODER
	icon_static = 'necromorphs/icons/necromorphs/exploder/exploder.dmi'
	icon_state = "l_leg"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 50
	body_damage_coeff = 0.75
	px_x = 2
	px_y = 12
	wound_resistance = 0
