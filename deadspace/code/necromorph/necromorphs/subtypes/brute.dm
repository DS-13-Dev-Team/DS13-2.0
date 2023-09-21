/mob/living/carbon/human/necromorph/brute
	class = /datum/necro_class/brute
	necro_species = /datum/species/necromorph/brute
	pixel_x = -16
	base_pixel_x = -16
	status_flags = CANSTUN|CANUNCONSCIOUS

	var/next_attack_delay = 0
	var/spec_attack_delay = 25

/mob/living/carbon/human/necromorph/brute/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.brute_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/brute
	display_name = "Brute"
	desc = "A powerful linebreaker and assault specialist, the brute can smash through almost any obstacle, and its tough \
	frontal armor makes it perfect for assaulting entrenched positions.\nVery vulnerable to flanking attacks"
	ui_icon = 'deadspace/icons/necromorphs/brute.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/brute
	tier = 3
	biomass_cost = 360
	biomass_spent_required = 950
	melee_damage_lower = 24
	melee_damage_upper = 28
	max_health = 510
	necro_armor = list(ARMOR_FRONT = 30, ARMOR_FLANK = 20, ARMOR_BACK = 10, CURL_ARMOR_MULT = 1.5, ARMOR_PROTECTION = 300)
	actions = list(
		/datum/action/cooldown/necro/slam = COMSIG_KB_NECROMORPH_ABILITY_SLAM_DOWN,
		/datum/action/cooldown/necro/long_charge = COMSIG_KB_NECROMORPH_ABILITY_CHARGE_DOWN,
		/datum/action/cooldown/necro/shoot/brute = COMSIG_KB_NECROMORPH_ABILITY_LONGSHOT_DOWN,
		/datum/action/cooldown/necro/curl = COMSIG_KB_NECROMORPH_ABILITY_CURL_DOWN,
	)
	minimap_icon = "brute"
	implemented = TRUE
	var/armor_front = 20
	var/armor_flank = 20

/datum/species/necromorph/brute
	name = "Brute"
	id = SPECIES_NECROMORPH_BRUTE
	burnmod = 0.75
	stunmod = 0.15
	speedmod = 4
	species_mob_size = MOB_SIZE_LARGE
	special_step_sounds = list(
		'deadspace/sound/effects/footstep/brute_step_1.ogg',
		'deadspace/sound/effects/footstep/brute_step_2.ogg',
		'deadspace/sound/effects/footstep/brute_step_3.ogg',
		'deadspace/sound/effects/footstep/brute_step_4.ogg',
		'deadspace/sound/effects/footstep/brute_step_5.ogg',
		'deadspace/sound/effects/footstep/brute_step_6.ogg'
	)
	deathsound = list(
		'deadspace/sound/effects/creatures/necromorph/brute/brute_death.ogg'
	)
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/brute,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/brute,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/brute,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/brute,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/brute,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/brute,
	)

/datum/species/necromorph/brute/get_scream_sound(mob/living/carbon/human/necromorph/brute)
	return pick(
		'deadspace/sound/effects/creatures/necromorph/brute/brute_pain_1.ogg',
		'deadspace/sound/effects/creatures/necromorph/brute/brute_pain_2.ogg',
		'deadspace/sound/effects/creatures/necromorph/brute/brute_pain_3.ogg',
		'deadspace/sound/effects/creatures/necromorph/brute/brute_pain_extreme.ogg',
	)

//TODO: REWRITE THIS COMPLETELY
/datum/species/necromorph/brute/spec_unarmedattack(mob/living/carbon/human/necromorph/brute/user, atom/target, modifiers)
	if(!user.combat_mode)
		return
	if(world.time < user.next_attack_delay)
		return
	user.next_attack_delay = user.spec_attack_delay + world.time
	if (istype(target, /mob/living/carbon/human))
		var/mob/living/carbon/human/mob_target = target
		var/fling_dir = pick((user.dir & (NORTH|SOUTH)) ? list(WEST, EAST, user.dir|WEST, user.dir|EAST) : list(NORTH, SOUTH, user.dir|NORTH, user.dir|SOUTH)) //Fling them somewhere not behind nor ahead of the charger.
		var/fling_dist = rand(2,5)
		var/turf/destination = mob_target.loc
		var/turf/temp

		for(var/i in 1 to fling_dist)
			temp = get_step(destination, fling_dir)
			if(!temp)
				break
			destination = temp
		if(destination != mob_target.loc)
			mob_target.throw_at(destination, fling_dist, 1, src, TRUE)
	return ..()

/datum/species/necromorph/brute/apply_damage(damage, damagetype, def_zone, blocked, mob/living/carbon/human/necromorph/H, forced, spread_damage, sharpness, attack_direction)
	//TODO: Handle front armour here
	switch(turn(attack_direction, dir2angle(H.dir)))
		if(NORTH)
			blocked += H.armor_front
		if(NORTHEAST, NORTHWEST)
			blocked += (H.armor_front + H.armor_flank) / 2
		if(EAST, WEST)
			blocked += H.armor_flank
		if(SOUTHEAST, SOUTHWEST)
			blocked += H.armor_flank / 2
	return ..()

#define WINDUP_TIME 1.25 SECONDS

/datum/action/cooldown/necro/shoot/brute
	name = "Bio-bomb"
	desc = "A moderate-strength projectile for longrange shooting."
	cooldown_time = 12 SECONDS
	windup_time = WINDUP_TIME
	projectiletype = /obj/projectile/bullet/biobomb/brute

/datum/action/cooldown/necro/shoot/brute/pre_fire(atom/target)
	var/x_direction = 0
	if (target.x > owner.x)
		x_direction = -1
	else if (target.x < owner.x)
		x_direction = 1

	//We do the windup animation. This involves the user slowly rising into the air, and tilting back if striking horizontally
	animate(
		owner,
		transform = turn(matrix(), 25*x_direction),
		pixel_x = owner.base_pixel_x + 8*x_direction,
		time = WINDUP_TIME,
		flags = ANIMATION_PARALLEL
	)

	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, src)

/datum/action/cooldown/necro/shoot/brute/post_fire()
	sleep(0.4 SECONDS)
	animate(owner, transform = matrix(), pixel_x = owner.base_pixel_x, time = 0.8 SECOND, flags = ANIMATION_PARALLEL)
	sleep(0.8 SECONDS)
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, src)

#undef WINDUP_TIME

/obj/projectile/bullet/biobomb/brute
	name = "acid bolt"
	icon = 'deadspace/icons/obj/projectiles.dmi'
	icon_state = "acid_large"

	speed = 0.8
	pixel_speed_multiplier = 0.5

	acid_type = /datum/reagent/toxin/acid/fluacid
	acid_amount = 3
