
#define CUMULATIVE_BURN_DAMAGE	0.5
#define FAKEDEATH_HEAL_TIME	4 SECONDS
#define ARM_SWING_RANGE_HUNTER	3

/mob/living/carbon/human/necromorph/hunter
	class = /datum/necro_class/hunter
	necro_species = /datum/species/necromorph/hunter

/mob/living/carbon/human/necromorph/hunter/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.hunter_sounds[audio_type]), volume, vary, extra_range)

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
		/datum/action/cooldown/necro/shout,
	)
	minimap_icon = "hunter"

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

/datum/action/cooldown/necro/charge/lunge/hunter/hit_target(mob/living/carbon/human/necromorph/source, mob/living/target)
	var/mob/living/carbon/human/necromorph/N = owner
	N.hookblade_swing(target)

/*--------------------------------
	Arm Swing
--------------------------------*/

/mob/living/carbon/human/necromorph/proc/hookblade_swing(atom/target)

	if (!target)
		target = dir

	//Okay lets actually start the swing
	.=swing_attack(swing_type = /datum/component/swing/arm/hunter,
	source = src,
	target = target,
	angle = 150,
	range = ARM_SWING_RANGE_HUNTER,
	duration = 0.65 SECOND,
	windup = 0,
	cooldown = 0,//5 SECONDS, //TODO: Uncomment this
	damage = 12.5,
	damage_flags = MELEE,
	stages = 8)

	if (.)
		play_necro_sound(SOUND_ATTACK, VOLUME_MID, 1, 2)
		var/sound_effect = pick(list('necromorphs/sound/effects/attacks/big_swoosh_1.ogg',
									'necromorphs/sound/effects/attacks/big_swoosh_2.ogg',
									'necromorphs/sound/effects/attacks/big_swoosh_3.ogg',))
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, sound_effect, VOLUME_LOW, TRUE), 0.8 SECONDS)

//Component subtype
/datum/component/swing/arm/hunter
	precise = FALSE
	left = /obj/effect/effect/swing/hunter_left
	right = /obj/effect/effect/swing/hunter_right

	offsets_left = list(S_NORTH = new /datum/position(-52, -12), S_SOUTH = new /datum/position(-32, -16), S_EAST = new /datum/position(-42, -14), S_WEST = new /datum/position(-40, -10))
	offsets_right = list(S_NORTH = new /datum/position(-36, -12), S_SOUTH = new /datum/position(-56, -18), S_EAST = new /datum/position(-42, -8), S_WEST = new /datum/position(-46, -6))



//Swing FX
/obj/effect/effect/swing/hunter_left
	icon_state = "hunter_left"

/obj/effect/effect/swing/hunter_right
	icon_state = "hunter_right"

//At the end of the windup, just before we start, we'll set the user's density to false
/datum/component/swing/arm/hunter/windup_animation()
	.=..()
	user.density = FALSE



/datum/component/swing/arm/hunter/hit_mob(mob/living/L)
	.=..()
	if (.)
		//If we hit someone, we'll pull them in a direction which is generally towards us
		//Since our density is false, they can pass through us
		var/push_angle = rand_between(140, 220)

		var/datum/position/push_direction = target_direction.Turn(push_angle)
		L.throw_at(push_direction, 200)
		push_direction = null
