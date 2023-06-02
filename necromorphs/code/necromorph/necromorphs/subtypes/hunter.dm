
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
		total_brute += (BP.brute_dam * BP.body_damage_coeff)
		total_burn += (BP.burn_dam * BP.body_damage_coeff)
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
	ui_icon = 'necromorphs/icons/necromorphs/hunter.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/hunter
	max_health = 275
	melee_damage_lower = 10
	melee_damage_upper = 16
	actions = list(
		/datum/action/cooldown/necro/regenerate/hunter,
		/datum/action/cooldown/necro/charge/lunge/hunter,
		/datum/action/cooldown/necro/taunt/hunter,
		/datum/action/cooldown/necro/shout,
	)
	minimap_icon = "hunter"
	implemented = TRUE

/datum/species/necromorph/hunter
	name = "Hunter"

	icobase = 'necromorphs/icons/necromorphs/hunter.dmi'
	deform = 'necromorphs/icons/necromorphs/hunter.dmi'

	id = SPECIES_NECROMORPH_HUNTER
	speedmod = 1.6
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/hunter,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/hunter,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/hunter,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/hunter,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/hunter,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/hunter,
	)

	special_step_sounds = list(
		'necromorphs/sound/effects/footstep/ubermorph_footstep_1.ogg',
		'necromorphs/sound/effects/footstep/ubermorph_footstep_2.ogg',
		'necromorphs/sound/effects/footstep/ubermorph_footstep_3.ogg',
		'necromorphs/sound/effects/footstep/ubermorph_footstep_4.ogg'
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

/datum/action/cooldown/necro/charge/lunge/hunter
	name = "Hookblade"
	desc = "A shortrange charge with a swing at the end, pulling in all enemies it hits."

/datum/action/cooldown/necro/charge/lunge/hunter/peter_out_effects()
	set waitfor = FALSE
	var/mob/living/carbon/human/necromorph/N = owner
	N.hookblade_swing(target_atom)

/datum/action/cooldown/necro/charge/lunge/hunter/hit_target(mob/living/carbon/human/necromorph/source, mob/living/target)
	set waitfor = FALSE
	var/mob/living/carbon/human/necromorph/N = owner
	N.hookblade_swing(target)

/*--------------------------------
	Arm Swing
--------------------------------*/

/mob/living/carbon/human/necromorph/proc/hookblade_swing(atom/target)

	if (!target)
		target = dir

	//Okay lets actually start the swing
	. = swing_attack(/datum/component/swing/arm/hunter, target)

	if (.)
		play_necro_sound(SOUND_ATTACK, VOLUME_MID, 1, 2)
		var/sound_effect = pick(list('necromorphs/sound/effects/attacks/big_swoosh_1.ogg',
									'necromorphs/sound/effects/attacks/big_swoosh_2.ogg',
									'necromorphs/sound/effects/attacks/big_swoosh_3.ogg',))
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, sound_effect, VOLUME_LOW, TRUE), 0.8 SECONDS)

//Component subtype
/datum/component/swing/arm/hunter
	left = /obj/effect/temp_visual/swing/hunter_left
	right = /obj/effect/temp_visual/swing/hunter_right

	offsets_left = list(S_NORTH = new /datum/position(-52, -12), S_SOUTH = new /datum/position(-32, -16), S_EAST = new /datum/position(-42, -14), S_WEST = new /datum/position(-40, -10))
	offsets_right = list(S_NORTH = new /datum/position(-36, -12), S_SOUTH = new /datum/position(-56, -18), S_EAST = new /datum/position(-42, -8), S_WEST = new /datum/position(-46, -6))



//Swing FX
/obj/effect/temp_visual/swing/hunter_left
	icon_state = "hunter_left"

/obj/effect/temp_visual/swing/hunter_right
	icon_state = "hunter_right"

//At the end of the windup, just before we start, we'll set the user's density to false
/datum/component/swing/arm/hunter/windup_animation()
	.=..()
	parent:density = FALSE

/datum/component/swing/arm/hunter/hit_mob(mob/living/L)
	. = ..()
	if (.)
		var/fling_dir = pick(GLOB.cardinals - ((parent:dir & (NORTH|SOUTH)) ? list(NORTH, SOUTH) : list(EAST, WEST)))
		var/fling_dist = 2
		var/turf/destination = L.loc
		var/turf/temp

		for(var/i in 1 to fling_dist)
			temp = get_step(destination, fling_dir)
			if(!temp)
				break
			destination = temp
		if(destination != L.loc)
			L.throw_at(destination, fling_dist, 1, parent, TRUE)

/datum/component/swing/arm/hunter/cleanup_effect()
	. = ..()
	addtimer(CALLBACK(parent, TYPE_PROC_REF(/atom/, set_density), TRUE), 15)

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
