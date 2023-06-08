/mob/living/carbon/human/necromorph/ubermorph
	class = /datum/necro_class/ubermorph
	necro_species = /datum/species/necromorph/ubermorph

/mob/living/carbon/human/necromorph/ubermorph/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.ubermorph_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/ubermorph
	display_name = "Ubermorph"
	desc = "A juvenile hivemind. Constantly regenerating, a nigh-immortal leader of the necromorph army. "
	ui_icon = 'necromorphs/icons/necromorphs/ubermorph.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/ubermorph
	melee_damage_lower = 10
	melee_damage_upper = 25
	max_health = INFINITY
	implemented = TRUE
	actions = list(
		/datum/action/cooldown/necro/regenerate/ubermorph,
		/datum/action/cooldown/necro/frenzy_shout/ubermorph,
		/datum/action/cooldown/necro/charge/lunge/ubermorph,
		/datum/action/cooldown/necro/sense,
	)
	minimap_icon = "ubermorph"

/datum/species/necromorph/ubermorph
	name = "Ubermorph"
	id = SPECIES_NECROMORPH_UBERMORPH
	speedmod = 1.2
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/ubermorph,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/ubermorph,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/ubermorph,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/ubermorph,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/ubermorph,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/ubermorph,
	)

	special_step_sounds = list(
		'necromorphs/sound/effects/footstep/ubermorph_footstep_1.ogg',
		'necromorphs/sound/effects/footstep/ubermorph_footstep_2.ogg',
		'necromorphs/sound/effects/footstep/ubermorph_footstep_3.ogg',
		'necromorphs/sound/effects/footstep/ubermorph_footstep_4.ogg'
	)

/datum/action/cooldown/necro/regenerate/ubermorph
	name = "Regenerate"
	desc = "Regrows a missing limb and restores some of your health."
	max_limbs = 2

/datum/action/cooldown/necro/regenerate/ubermorph/finish()
	if(!owner.GetComponent(/datum/component/statmod/regenerate_afterbuff))
		owner.AddComponent(/datum/component/statmod/regenerate_afterbuff)
	. = ..()

/datum/action/cooldown/necro/frenzy_shout/ubermorph
	var/obj/effect/temp_visual/expanding_circle/EC

/datum/action/cooldown/necro/frenzy_shout/ubermorph/Activate(atom/target)
	. = ..()
	if(.)
		var/mob/living/carbon/human/necromorph/N = owner
		N.play_necro_sound(SOUND_SHOUT_LONG, VOLUME_MAX, 1, 6)
		shake_camera(N, 6, 4)

		for (var/mob/living/L in view(7, N))
			if (!faction_check(N.faction, L.faction) && L.stat != DEAD)
				L.take_overall_damage(15)

		//Lets do some cool effects
		effect_circle()
		addtimer(CALLBACK(src, PROC_REF(effect_circle)), 4)
		addtimer(CALLBACK(src, PROC_REF(effect_circle)), 8)

/datum/action/cooldown/necro/frenzy_shout/ubermorph/proc/effect_circle()
	EC = new /obj/effect/temp_visual/expanding_circle(owner.loc, 1.5 SECONDS, 1.5,"#ff0000")
	EC.pixel_y += 40	//Offset it so it appears to be at our mob's head

/datum/action/cooldown/necro/charge/lunge/ubermorph
	name = "Lunge"
	desc = "A shortrange charge which causes heavy internal damage to one victim. Often fatal."

/datum/action/cooldown/necro/charge/lunge/ubermorph/PreActivate(atom/target)
	. = ..()

/datum/action/cooldown/necro/charge/lunge/ubermorph/Activate(atom/target)
	if(!isliving(target_atom))
		target_atom =  autotarget_enemy_mob(target, 2, owner, 999)
	. = ..()
