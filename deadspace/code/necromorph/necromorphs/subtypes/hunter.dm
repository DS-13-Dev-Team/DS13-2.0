
#define CUMULATIVE_BURN_DAMAGE	0.5
#define FAKEDEATH_HEAL_TIME	4 SECONDS
#define ARM_SWING_RANGE_HUNTER	3

/mob/living/carbon/human/necromorph/hunter
	class = /datum/necro_class/hunter
	necro_species = /datum/species/necromorph/hunter

/mob/living/carbon/human/necromorph/hunter/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.hunter_sounds[audio_type]), volume, vary, extra_range)

/mob/living/carbon/human/necromorph/hunter/proc/can_false_death()
	if(GetComponent(/datum/component/regenerate/hunter_passive))
		return TRUE
	return FALSE

/mob/living/carbon/human/necromorph/hunter/handle_death_check()
	var/total_burn = 0
	var/total_brute = 0
	for(var/obj/item/bodypart/BP as anything in bodyparts) //hardcoded to streamline things a bit
		total_brute += BP.brute_dam
		total_burn += BP.burn_dam
	var/damage = getOxyLoss() + getToxLoss() - getCloneLoss() - total_burn - total_brute
	if(damage >= maxHealth)

		if(total_burn >= (maxHealth * 0.5))
			return TRUE

		if (getLastingDamage() >= maxHealth)
			return TRUE

		if (can_false_death())
			AddComponent(/datum/component/regenerate/hunter_passive)
			play_necro_sound(SOUND_DEATH, VOLUME_HIGH)

		return FALSE

	return FALSE

/datum/necro_class/hunter
	display_name = "Hunter"
	desc = "A rapidly regenerating vanguard, designed to lead the charge, suffer a glorious death, then get back up and do it again. \
	Avoid fire though."
	ui_icon = 'deadspace/icons/necromorphs/hunter.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/hunter
	nest_allowed = FALSE
	tier = 3
	biomass_cost = 400
	biomass_spent_required = 950
	max_health = 275
	melee_damage_lower = 18
	melee_damage_upper = 22
	actions = list(
		/datum/action/cooldown/necro/swing/hunter = COMSIG_KB_NECROMORPH_ABILITY_HUNTERSWING_DOWN,
		/datum/action/cooldown/necro/taunt/hunter = COMSIG_KB_NECROMORPH_ABILITY_TAUNT_DOWN,
		/datum/action/cooldown/necro/regenerate/hunter = COMSIG_KB_NECROMORPH_ABILITY_REGENERATE_DOWN,
		/datum/action/cooldown/necro/shout = COMSIG_KB_NECROMORPH_ABILITY_SHOUT_DOWN,
	)
	minimap_icon = "hunter"
	implemented = TRUE

/datum/species/necromorph/hunter
	name = "Hunter"

	icobase = 'deadspace/icons/necromorphs/hunter.dmi'
	deform = 'deadspace/icons/necromorphs/hunter.dmi'

	id = SPECIES_NECROMORPH_HUNTER
	speedmod = 1.6
	burnmod = 1.3
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/hunter,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/hunter,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/hunter,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/hunter,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/hunter,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/hunter,
	)

	special_step_sounds = list(
		'deadspace/sound/effects/footstep/ubermorph_footstep_1.ogg',
		'deadspace/sound/effects/footstep/ubermorph_footstep_2.ogg',
		'deadspace/sound/effects/footstep/ubermorph_footstep_3.ogg',
		'deadspace/sound/effects/footstep/ubermorph_footstep_4.ogg'
	)

/datum/species/necromorph/hunter/get_scream_sound(mob/living/carbon/human/necromorph/hunter)
	return pick(
		'deadspace/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_5.ogg',
		'deadspace/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_6.ogg',
		'deadspace/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_3.ogg',
	)

/datum/species/necromorph/hunter/apply_damage(damage, damagetype, def_zone, blocked, mob/living/carbon/human/necromorph/H, forced, spread_damage, sharpness, attack_direction)
	if(H.health - damage <= 0)
		return H.handle_death_check()
	. = ..()

/datum/action/cooldown/necro/regenerate/hunter
	desc = "Regrows a missing limb and restores some of your health."
	cooldown_time = 30 SECONDS
	duration = 8 SECONDS
	lasting_damage_heal = 20
	heal_amount = 30
	burn_heal_mult = 0.33

/datum/action/cooldown/necro/regenerate/hunter/PreActivate(atom/target)
	. = ..()
	target_necro.play_necro_sound(SOUND_PAIN, VOLUME_HIGH, 1, 3)

/datum/action/cooldown/necro/swing/hunter
	name = "Hookblade"
	desc = "A shortrange charge with a swing at the end, pulling in all enemies it hits."
	visual_type = /obj/effect/temp_visual/swing/hunter

/datum/action/cooldown/necro/swing/hunter/windup()
	var/mob/living/carbon/human/necromorph/necromorph = owner
	necromorph.play_necro_sound(SOUND_ATTACK, VOLUME_MID, 1, 2)
	return ..()

/datum/action/cooldown/necro/swing/hunter/hit_mob(mob/living/L)
	. = ..()
	if (.)
		var/fling_dir = pick(GLOB.cardinals - ((owner.dir & (NORTH|SOUTH)) ? list(NORTH, SOUTH) : list(EAST, WEST)))
		var/fling_dist = 2
		var/turf/destination = L.loc
		var/turf/temp

		for(var/i in 1 to fling_dist)
			temp = get_step(destination, fling_dir)
			if(!temp)
				break
			destination = temp
		if(destination != L.loc)
			L.throw_at(destination, fling_dist, 1, owner, TRUE)

/obj/effect/temp_visual/swing/hunter
	base_icon_state = "hunter"
	icon_state = "hunter_left"
	variable_icon = TRUE

/datum/action/cooldown/necro/taunt/hunter
	desc = "Provides a defensive buff to the hunter, and a larger one to his allies."
	type_buff = /datum/component/statmod/taunt_buff
	var/obj/effect/temp_visual/expanding_circle/EC

/datum/action/cooldown/necro/taunt/hunter/Activate()
	owner:play_necro_sound(SOUND_SHOUT_LONG, VOLUME_MAX, 1, 3)
	. = ..()
	EC = new /obj/effect/temp_visual/expanding_circle(owner.loc, 1.5 SECONDS, 1.5,"#ff0000")
	EC.pixel_y += 40	//Offset it so it appears to be at our mob's head
	addtimer(CALLBACK(src, PROC_REF(effects)), 4)
	addtimer(CALLBACK(src, PROC_REF(effects)), 8)

/datum/action/cooldown/necro/taunt/hunter/proc/effects()
	EC = new /obj/effect/temp_visual/expanding_circle(owner.loc, 1.5 SECONDS, 1.5,"#ff0000")
	EC.pixel_y += 40	//Offset it so it appears to be at our mob's head

/*
	Passive regen is triggered during false death
*/
/datum/component/regenerate/hunter_passive
	duration = 8 SECONDS
	max_limbs = 5
	lasting_damage_heal = 35
	burn_heal_mult = 0.01
	heal_amount = 100

/datum/component/statmod/taunt_buff
	//These stats apply to self
	statmods = list(STATMOD_MOVESPEED_ADDITIVE = 0.15,
					STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE = 0.85
	)
