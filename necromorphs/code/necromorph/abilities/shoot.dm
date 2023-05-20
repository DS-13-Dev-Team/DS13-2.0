
/datum/action/cooldown/necro/shoot
	name = "Shoot"

	click_to_activate = TRUE
	var/projectile_type
	var/base_accuracy
	var/list/dispersion
	var/total_shots = 1
	var/windup_time
	var/fireanimtime
	var/list/fire_sound
	var/power = 1
	cooldown_time = 1 SECONDS
	var/nomove	=	0

	//Data generated during runtime
	var/shot_num = 1

	//When false, this extension is deleted when cooldown finishes
	//If true, the extension will remain, and can be used to fire repeqatedly without remaking it
	var/persist = FALSE


	var/starting_pixel_offset_x
	var/starting_pixel_offset_y

/datum/action/cooldown/necro/shoot/PreActivate(atom/target)
	if (isliving(owner))
		var/mob/living/L = owner
		if (L.incapacitated())
			return FALSE

	//Can't shoot yourself
	if (target == src)
		return FALSE

	. = ..()

/datum/action/cooldown/necro/shoot/Activate(atom/target)
	StartCooldown()
	owner.face_atom(target)

	var/mob/living/L
	var/target_zone = BODY_ZONE_CHEST
	if (isliving(owner))
		L = owner
		target_zone = L.zone_selected
	else
		target_zone = ran_zone()

	//First of all, if nomove is set, lets paralyse the owner
	if (nomove && L)
		var/stoptime = windup_time
		if (isnum(nomove))
			stoptime += nomove

		if (stoptime)
			L.Paralyze(stoptime, TRUE)

	//Now lets windup the shot(s)
	if (windup_time)

		windup_animation(target)

	if (fireanimtime)
		addtimer(CALLBACK(src, PROC_REF(fire_animation)), fireanimtime)

	for(shot_num in 1 to total_shots)
		var/obj/projectile/P = new projectile_type(get_turf(owner))
		if (starting_pixel_offset_x)
			P.pixel_x += starting_pixel_offset_x
		if (starting_pixel_offset_y)
			P.pixel_y += starting_pixel_offset_y
		P.firer = owner
		P.def_zone = target_zone
		P.preparePixelProjectile(target, owner)
		P.fire()

		if (fire_sound)
			playsound(owner, pick(fire_sound), VOLUME_MID, 1)

	play_attack_sound()
	return TRUE

/datum/action/cooldown/necro/shoot/proc/windup_animation(atom/target)
	sleep(windup_time)

/datum/action/cooldown/necro/shoot/proc/fire_animation()
	return

/datum/action/cooldown/necro/shoot/proc/play_attack_sound()
	return

/datum/action/cooldown/necro/shoot/biobomb
	name = "Shoot biobomb"

	cooldown_time = 12 SECONDS
	projectile_type = /obj/projectile/bullet/cyst/weak
	nomove = 2 SECONDS
	windup_time = 1.25 SECONDS
	fireanimtime = 4

	fire_sound = list(
		'necromorphs/sound/effects/creatures/necromorph/cyst/cyst_fire_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/cyst/cyst_fire_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/cyst/cyst_fire_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/cyst/cyst_fire_4.ogg'
	)

/datum/action/cooldown/necro/shoot/biobomb/windup_animation(atom/target)
	var/mob/living/L = owner
	var/x_direction
	if (target.x > L.x)
		x_direction = 1
	else if (target.x < L.x)
		x_direction = -1


	//We do the windup animation. This involves the user slowly rising into the air, and tilting back if striking horizontally
	animate(L, transform=turn(matrix(), (25*(x_direction*-1))),pixel_x = L.pixel_x + 8*(x_direction*-1), time = windup_time, flags = ANIMATION_PARALLEL)
	sleep(windup_time)

/datum/action/cooldown/necro/shoot/biobomb/fire_animation()
	var/mob/living/L = owner
	var/matrix/M = matrix()
	animate(L, transform=M,pixel_x = L.pixel_x, time = 0.8 SECOND, flags = ANIMATION_PARALLEL)

/datum/action/cooldown/necro/shoot/biobomb/play_attack_sound()
	var/mob/living/carbon/human/necromorph/N = owner
	N.play_necro_sound(SOUND_ATTACK, VOLUME_MID, 3)

/obj/projectile/bullet/cyst/weak
	damage = 30

/datum/action/cooldown/necro/shoot/snapshoot
	name = "Snapshoot"
	projectile_type = /obj/projectile/bullet/acid/puker_snap

/datum/action/cooldown/necro/shoot/snapshoot/play_attack_sound()
	var/mob/living/carbon/human/necromorph/N = owner
	N.play_necro_sound(SOUND_ATTACK, VOLUME_MID, 3)

//Snapshot projectile. Lower damage, limited range
/obj/projectile/bullet/acid/puker_snap
	icon_state = "acid_small"
	damage = 13.5
	speed = 1.25
	range = 5
	impact_type = /obj/effect/projectile/impact


/datum/action/cooldown/necro/shoot/longshoot
	name = "Longshoot"
	projectile_type = /obj/projectile/bullet/acid/puker_long

/datum/action/cooldown/necro/shoot/longshoot/play_attack_sound()
	var/mob/living/carbon/human/necromorph/N = owner
	N.play_necro_sound(SOUND_ATTACK, VOLUME_MID, 3)

//Longshot projectile. Good damage, no range limits, slower moving
/obj/projectile/bullet/acid/puker_long
	name = "acid blast"
	icon_state = "acid_large"
	speed = 1.75
	damage = 25
