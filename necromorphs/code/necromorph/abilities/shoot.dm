
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

/datum/action/cooldown/necro/shoot/Activate(atom/target)
	StartCooldown()
	owner.face_atom(target)

	//First of all, lets check if we're currently able to shoot
	if (!can_shoot())
		return FALSE

	//Can't shoot yourself
	if (target == src)
		return FALSE

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

	return TRUE

/datum/action/cooldown/necro/shoot/proc/windup_animation(atom/target)
	sleep(windup_time)

/datum/action/cooldown/necro/shoot/proc/fire_animation()
	return

/***********************
	Safety Checks
************************/
/datum/action/cooldown/necro/shoot/proc/can_shoot()
	if (isliving(src))
		var/mob/living/L = src
		if (L.incapacitated())
			return FALSE

	return TRUE


//Only used for repeat shooting
/datum/action/cooldown/necro/shoot/proc/can_fire()
	return TRUE

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

/obj/projectile/bullet/cyst/weak
	damage = 30
