/datum/action/cooldown/necro/shoot
	name = "Shoot"
	desc = "Shoot projectiles at your enemies."
	cooldown_time = 1.5 SECONDS
	click_to_activate = TRUE
	var/windup_time = 0
	var/projectiletype = /obj/projectile/bullet/biobomb

/datum/action/cooldown/necro/shoot/Activate(atom/target)
	. = TRUE
	owner.face_atom(target)
	pre_fire(target)
	var/mob/living/carbon/human/necromorph/necro = owner
	necro.play_necro_sound(SOUND_ATTACK, VOLUME_MID, 3)
	if(windup_time > 0)
		StartCooldown(windup_time)
		sleep(windup_time)
	var/turf/startloc = get_turf(owner)
	var/obj/projectile/P = new projectiletype(startloc)
	P.def_zone = owner.zone_selected
	P.starting = startloc
	P.firer = owner
	//We don't want to hit other necromorphs
	P.ignored_factions = owner.faction
	P.fired_from = owner
	P.yo = target.y - startloc.y
	P.xo = target.x - startloc.x
	P.original = target
	P.preparePixelProjectile(target, owner)
	P.fire()
	StartCooldown()
	INVOKE_ASYNC(src, PROC_REF(post_fire))

/datum/action/cooldown/necro/shoot/proc/pre_fire()
	return

/datum/action/cooldown/necro/shoot/proc/post_fire()
	return

/obj/projectile/bullet/biobomb
	name = "acid bolt"
	icon = 'necromorphs/icons/obj/projectiles.dmi'
	icon_state = "acid_large"

	speed = 1
	pixel_speed_multiplier = 0.3

	impact_effect_type = /obj/effect/temp_visual/biombomb_impact

	damage = 0
	damage_type = BURN
	// We deal damage by exposing reagent at victims
	nodamage = TRUE

	armor_flag = ACID
	//We deal real damage by exposing reagent at victims, though we need run armour checks
	armour_penetration = 50
	eyeblur = 5

	var/acid_type = /datum/reagent/toxin/acid
	//Amount of acid we expose at target when it is hit
	var/acid_amount = 5

/obj/projectile/bullet/biobomb/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(. == BULLET_ACT_HIT)
		var/datum/reagent/acid = GLOB.chemical_reagents_list[acid_type]
		if(isliving(target))
			acid.expose_mob(target, TOUCH, acid_amount, TRUE)
		else if (isturf(target))
			acid.expose_turf(target, acid_amount)
		else
			acid.expose_obj(target, acid_amount)

/obj/effect/temp_visual/biombomb_impact
	name = "\improper acid bolt impact"
	icon = 'necromorphs/icons/obj/projectiles.dmi'
	icon_state = "impact_acid_1"
	color = COLOR_MUZZLE_ACID

/obj/effect/temp_visual/biombomb_impact/Initialize(mapload)
	icon_state = "impact_acid_[rand(1, 4)]"
	return ..()
