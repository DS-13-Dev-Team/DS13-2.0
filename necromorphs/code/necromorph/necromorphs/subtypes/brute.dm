/mob/living/carbon/human/necromorph/brute
	class = /datum/necro_class/brute
	necro_species = /datum/species/necromorph/brute
	pixel_x = -16
	base_pixel_x = -16
	status_flags = CANSTUN|CANUNCONSCIOUS

	var/next_attack_delay = 0
	var/spec_attack_delay = 25

/mob/living/carbon/human/necromorph/brute/Initialize(mapload, obj/structure/marker/marker_master)
	. = ..()
	RegisterSignal(src, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(spec_unarmedattack))

/mob/living/carbon/human/necromorph/brute/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_LIVING_UNARMED_ATTACK)

/mob/living/carbon/human/necromorph/brute/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.brute_sounds[audio_type]), volume, vary, extra_range)

/mob/living/carbon/human/necromorph/brute/proc/spec_unarmedattack(datum/source, atom/target, proximity, modifiers)
	if(world.time >= next_attack_delay)
		if (istype(target, /mob/living/carbon/human))
			var/mob/living/carbon/human/mob_target = target
			var/fling_dir = pick((dir & (NORTH|SOUTH)) ? list(WEST, EAST, dir|WEST, dir|EAST) : list(NORTH, SOUTH, dir|NORTH, dir|SOUTH)) //Fling them somewhere not behind nor ahead of the charger.
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
			next_attack_delay = spec_attack_delay + world.time
			return COMPONENT_CANCEL_ATTACK_CHAIN

	//Return parent as a fallback if something went wrong
	return

/datum/necro_class/brute
	display_name = "Brute"
	desc = "A powerful linebreaker and assault specialist, the brute can smash through almost any obstacle, and its tough \
	frontal armor makes it perfect for assaulting entrenched positions.\nVery vulnerable to flanking attacks"
	ui_icon = 'necromorphs/icons/necromorphs/brute.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/brute
	melee_damage_lower = 10
	melee_damage_upper = 16
	max_health = 510
	necro_armor = list(ARMOR_FRONT = 30, ARMOR_FLANK = 20, ARMOR_BACK = 10, CURL_ARMOR_MULT = 1.5, ARMOR_PROTECTION = 300)
	actions = list(
		/datum/action/cooldown/necro/long_charge,
		/datum/action/cooldown/necro/slam,
		/datum/action/cooldown/necro/curl,
	)
	minimap_icon = "brute"

/datum/species/necromorph/brute
	name = "Brute"
	id = SPECIES_NECROMORPH_BRUTE
	burnmod = 0.75
	stunmod = 0.15
	speedmod = 2
	species_mob_size = MOB_SIZE_LARGE
	special_step_sounds = list(
		'necromorphs/sound/effects/footstep/brute_step_1.ogg',
		'necromorphs/sound/effects/footstep/brute_step_2.ogg',
		'necromorphs/sound/effects/footstep/brute_step_3.ogg',
		'necromorphs/sound/effects/footstep/brute_step_4.ogg',
		'necromorphs/sound/effects/footstep/brute_step_5.ogg',
		'necromorphs/sound/effects/footstep/brute_step_6.ogg'
	)
	deathsound = list(
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_death.ogg'
	)
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/brute,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/brute,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/brute,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/brute,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/brute,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/brute,
	)
