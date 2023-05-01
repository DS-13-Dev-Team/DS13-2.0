
//Version optimised for mass testing
//Takes a list of target atoms to test
//Returns back the same list as an associative, with target as key, and true/false as value telling us whether we succeeded or failed in hitting
/proc/check_trajectory_mass(list/targets, atom/firer as mob|obj, pass_flags = PASSTABLE, obj_flags = null, allow_sleep = FALSE)
	if(!istype(firer))
		return 0

	var/turf/origin = get_turf(firer)
	var/obj/projectile/test/trace = new /obj/projectile/test(origin) //Making the test....

	if(!isnull(obj_flags))
		trace.obj_flags = obj_flags
	trace.pass_flags = pass_flags

	if(allow_sleep)
		for(var/atom/A as anything in targets)
			trace.result = null
			trace.forceMove(origin)
			targets[A] = trace.fire(direct_target = A) //Test it!
			CHECK_TICK
	else
		for(var/atom/A as anything in targets)
			trace.result = null
			trace.forceMove(origin)
			targets[A] = trace.fire(direct_target = A) //Test it!

	QDEL_NULL(trace) //No need for it anymore
	return targets //Send it back to the gun!

//"Tracing" projectile
/obj/projectile/test //Used to see if you can hit them.
	invisibility = 101 //Nope!  Can't see me!
	yo = null
	xo = null
	var/obstacle = null
	var/result = null //To pass the message back to the gun.

/obj/projectile/test/Bump(atom/A as mob|obj|turf|area, forced = 0)
	if(A == firer)
		forceMove(A.loc)
		return //cannot shoot yourself
	if(istype(A, /obj/projectile))
		return

	obstacle = A
	if(A == original)

		result = TRUE
		return
	result = FALSE
	return

/obj/projectile/test/fire(angle, atom/direct_target)
	var/turf/curloc = get_turf(src)
	var/turf/targloc = get_turf(direct_target)
	if(!curloc || !targloc)
		return FALSE

	if (curloc == targloc)
		return TRUE

	original = direct_target

	//plot the initial trajectory
	preparePixelProjectile(direct_target, curloc)
	return process(targloc)

/obj/projectile/test/process(turf/targloc)

	//Every step along the trajectory, we may populate this list with sub-steps.
	//If populated we follow it
	var/list/steps = list()
	var/loops = 0
	while(!QDELETED(src)) //Loop on through!
		if(loops++ >= 100)
			qdel(src)
			CRASH("Raytracing projectile passed 100 loops, terminating")

		if((!( targloc ) || loc == targloc))
			targloc = locate(min(max(x + xo, 1), world.maxx), min(max(y + yo, 1), world.maxy), z) //Finding the target turf at map edge

		var/turf/newloc
		if (!length(steps))
			trajectory.increment()	// increment the current location
			var/datum/position/location = trajectory.return_position()		// update the locally stored location data

			//TODO: Figure out why this happens
			if (!location)
				return FALSE

			newloc = trajectory.return_turf()

			//If we're moving diagonally, then we need some more complex resolution
			if (!loc.cardinally_adjacent(newloc))
				steps = get_line(loc, newloc)

				newloc = antipop(steps)


		else
			newloc = antipop(steps)


		Move(newloc)


		//Check this again, our attempted move may have just set it
		if(!isnull(result))
			return result

		var/turf/T = get_turf(src)
		if (T == original)
			obstacle = original
			return TRUE

		var/atom/A = locate(original) in T
		if(A) //We are on our target's turf, we can hit them
			obstacle = A
			return TRUE

		//If we get here, lets set our location to the newloc and ignore blockers
		forceMove(newloc)


/obj/projectile/test/Destroy()
	obstacle = null
	result = null
	. = ..()
