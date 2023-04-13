/*
	Slam is an AOE melee attack, primarily used by the necromorph brute.
	Slam strikes a three-tile arc either side of an epicentre.
	Any mobs in the affected area take heavy damage. This damage is multiplied if the victim is lying down, or otherwise incapacitated
	Any standing mobs in the affected area which are smaller than the attacker, will be knocked down for a time
	Any dense nonmob atoms in the affected area are hit twice
*/

/*
	action/cooldown
*/
/datum/action/cooldown/necro/slam
	name = "Slam"
	desc = "The brute's signature move."
	click_to_activate = TRUE
	cooldown_time = 8 SECOND
	var/atom/movable/user		//The mob or thing doing the slam attack
	var/turf/epicentre			//The turf we've targeted with the slam
	var/damage	=	40			//Base damage dealt
	var/power = 1				//Used for damage to atoms
	var/down_factor = 2			//Base damage is multiplied by this on lying targets
	var/weaken_time = 3			//Number of life ticks victims are weakened (knocked down) for. A life tick is generally 1 second
	var/windup_time	= 2 SECONDS	//How long the attack is telegraphed for

	//Extra runtime vars
	var/cached_pixels_x			//Cache the user's pixel offsets so we can revert to them
	var/cached_pixels_y
	var/slam_timer				//Timer handle for slam
	var/x_direction = 0
	var/list/affected_turfs
	var/list/affected_turfs_secondary

/datum/action/cooldown/necro/slam/Activate(atom/target)
	StartCooldown()

	var/direction = get_dir(owner, target)
	target = get_step(owner, direction)

	//First of all, lets check if we're currently able to charge
	if (!owner.can_slam(target, TRUE))
		return

	var/mob/living/carbon/human/necromorph/N = owner
	N.play_necro_sound(SOUND_SHOUT, VOLUME_HIGH, 1, 3)

	epicentre = get_turf(target)
	user = owner
	if (isliving(user))
		//Lets face the thing
		var/mob/living/L = user
		L.face_atom(epicentre)

		//We'll stun the user so they can't move during the animation
		//The extra number added to windup time is the total of all the little sleeps used throughout the process
		var/stuntime = CEILING((windup_time + 13), 10) //Stuntime is in life ticks, so we divide by 10, and round up to the nearest integer
		L.Stun(stuntime, TRUE) //Passing true here bypasses species resistance

	//Here we start the windup.
	cached_pixels_x = user.pixel_x
	cached_pixels_y = user.pixel_y



	//If the epicentre is offset on our X axis, we'll have an extra factor on the animation
	if (epicentre.x > user.x)
		x_direction = 1
	else if (epicentre.x < user.x)
		x_direction = -1


	//We do the windup animation. This involves the user slowly rising into the air, and tilting back if striking horizontally
	animate(user, transform=turn(matrix(), (25*(x_direction*-1))), pixel_y = cached_pixels_y + 16, time = windup_time)

	//Start a timer
	slam_timer = addtimer(CALLBACK(src, .proc/finish), windup_time, TIMER_STOPPABLE)

	//While that's running, lets quickly calculate the affected turfs
	LAZYADD(affected_turfs, epicentre)
	var/dir2centre = get_dir(user, epicentre)
	//We add the turfs that are at + and - 45 degrees from that direction
	LAZYADD(affected_turfs, get_step(user, turn(dir2centre, 45)))
	LAZYADD(affected_turfs, get_step(user, turn(dir2centre, -45)))

	//Next lets add secondary turfs
	for (var/turf/T in affected_turfs)
		var/turf/T2 = get_step(T, dir2centre)
		if (istype(T2))
			LAZYADD(affected_turfs_secondary,T2)

	return TRUE

/datum/action/cooldown/necro/slam/proc/finish()
	//Lets finish the slamming animation. We drop sharply back to the floor
	//And, if we had an x offset, we'll also strike there
	animate(user, transform=turn(matrix(), (35*x_direction)), pixel_y = cached_pixels_y-8, pixel_x = cached_pixels_x + 24*x_direction, time = 3, easing = BACK_EASING)

	sleep(2)
	//Wait a little, then we strike

	//The heavier the damage, the louder the sound. This is a fancy trick i learned
	//Playing a sound several times slightly overlapping, makes, it MUCH louder
	playsound(epicentre, 'necromorphs/sound/weapons/heavysmash.ogg', 100, 1, 20,20)
	if (damage > 15)
		spawn(1)
			playsound(epicentre, 'necromorphs/sound/weapons/heavysmash.ogg', 100, 1, 20,20)
	if (damage > 30)
		spawn(2)
			playsound(epicentre, 'necromorphs/sound/weapons/heavysmash.ogg', 100, 1, 20,20)


	//Now lets damage all the things
	for (var/turf/T in affected_turfs)

		for (var/atom/A in T.contents)
			A.shake_animation(damage)	//Shake things!

			//Mobs take damage, with more if they're lying down
			if (isliving(A))
				var/mob/living/L = A
				var/tempdamage = damage
				if (L.body_position == LYING_DOWN)
					tempdamage *= down_factor
				L.Paralyze(weaken_time)
				L.take_overall_damage(tempdamage, 0,0,0, user)
				shake_camera(L, 3, damage/10) //Shake camera of mobs too
			else
				//Atoms get ex_acted
				var/effective_power = power
				if (A.density)
					effective_power++
				if (effective_power)
					A.ex_act(4-effective_power, user)

		affected_turfs = list()

		var/effective_power = power
		if (T.density)
			effective_power++
		if (effective_power)
			T.shake_animation(damage)	//Shake the turf itself
			T.ex_act(4-effective_power, user)
			if (!QDELETED(T) && T.density)
				//If the turf is dense (walls, but not floors) then it gets hit a second time
				T.ex_act(4-power, user)


	//Now we weaken these values for the next round
	damage *= 0.5
	weaken_time = round(weaken_time*0.5, 1)
	power = min(power-1, 0)

	//Secondary turfs damage, copypaste of above
	for (var/turf/T in affected_turfs_secondary)

		for (var/atom/A in T.contents)
			A.shake_animation(damage)	//Shake things!

			//Mobs take damage, with more if they're lying down
			if (isliving(A))
				var/mob/living/L = A
				var/tempdamage = damage
				if (L.body_position == LYING_DOWN)
					tempdamage *= down_factor
				L.Paralyze(weaken_time)
				L.apply_damage(damage, def_zone = BODY_ZONE_CHEST)//Slam is too big to be precisely targeted, always aims center mass
				//L.take_overall_damage(tempdamage, 0,0,0, user)
				shake_camera(L, 3, damage/10) //Shake camera of mobs too
			else
				//Atoms get ex_acted
				var/effective_power = power
				if (A.density)
					effective_power++
				if (effective_power)
					A.ex_act(4-effective_power, user)

		var/effective_power = power
		if (T.density)
			effective_power++
		if (effective_power)
			T.shake_animation(damage)	//Shake the turf itself
			T.ex_act(4-effective_power, user)

	affected_turfs_secondary = list()

	//Wait a bit longer before we return to neutral
	sleep(3)
	stop()



//Stop is called after a successful finish, or on aborting
/datum/action/cooldown/necro/slam/proc/stop()
	deltimer(slam_timer)
	//Lets smoothly slide back to a normal stance
	animate(user, transform=matrix(), pixel_y = cached_pixels_y, pixel_x = cached_pixels_x, time = 7)
	spawn(7)
		var/mob/living/L = user
		if (istype(L))
			L.SetStun(0, TRUE)


/atom/movable/proc/can_slam(atom/target, error_messages = TRUE)
	if (!target)
		target = get_step(src, dir)

	var/dist = get_dist(src, target)
	if (dist > 1)
		if(error_messages) to_chat(src, "You are too far away from [target], get closer first!")
		return FALSE
	if (dist < 1)
		if(error_messages) to_chat(src, "You can't slam yourself!")
		return FALSE


	return TRUE

/mob/living/can_slam(atom/target, error_messages = TRUE)
	if (incapacitated())
		return FALSE

	.=..()
