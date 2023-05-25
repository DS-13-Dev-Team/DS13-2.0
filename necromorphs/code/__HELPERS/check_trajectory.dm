//Procs to check if a target atom can be reached from the current. Essentially raytracing

//Helper proc to check if you can hit them or not.
/proc/check_trajectory(atom/target as mob|obj, atom/firer as mob|obj, pass_flags=PASSTABLE|PASSGLASS|PASSGRILLE, obj_flags = null)
	if(!istype(target) || !istype(firer))
		return 0

	//If its in the same turf, just say yes
	if (get_turf(target) == get_turf(firer))
		return TRUE

	var/obj/projectile/test/trace = new /obj/projectile/test(get_turf(firer)) //Making the test....
	//Set the flags and pass flags to that of the real projectile...
	if(!isnull(obj_flags))
		trace.obj_flags = obj_flags
	trace.pass_flags = pass_flags

	trace.trajectory_ignore_forcemove = TRUE
	trace.forceMove(firer)
	trace.trajectory_ignore_forcemove = FALSE
	trace.preparePixelProjectile(target, firer)
	var/output = trace.fire(target) //Test it!
	QDEL_NULL(trace) //No need for it anymore
	return output //Send it back to the gun!

//Version optimised for mass testing
//Takes a list of target atoms to test
//Returns back the same list as an associative, with target as key, and true/false as value telling us whether we succeeded or failed in hitting
/proc/check_trajectory_mass(list/targets, atom/firer as mob|obj, pass_flags = PASSTABLE, obj_flags = null, allow_sleep = FALSE)
	if(!istype(firer))
		return 0

	var/turf/origin = get_turf(firer)
	var/obj/projectile/test/trace = new /obj/projectile/test(origin) //Making the test....
	trace.firer = firer

	if(!isnull(obj_flags))
		trace.obj_flags = obj_flags
	trace.pass_flags = pass_flags

	if(allow_sleep)
		for(var/atom/A as anything in targets)
			trace.result = null
			trace.trajectory_ignore_forcemove = TRUE
			trace.forceMove(firer)
			trace.trajectory_ignore_forcemove = FALSE
			trace.preparePixelProjectile(A, firer)
			targets[A] = trace.fire(direct_target = A) //Test it!
			CHECK_TICK
	else
		for(var/atom/A as anything in targets)
			trace.result = null
			trace.trajectory_ignore_forcemove = TRUE
			trace.forceMove(firer)
			trace.trajectory_ignore_forcemove = FALSE
			trace.preparePixelProjectile(A, firer)
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

	if(isnum(angle))
		set_angle(angle)
	var/turf/starting = get_turf(src)
	if(isnull(Angle)) //Try to resolve through offsets if there's no angle set.
		if(isnull(xo) || isnull(yo))
			stack_trace("WARNING: Projectile [type] deleted due to being unable to resolve a target after angle was null!")
			qdel(src)
			return
		var/turf/target = locate(clamp(starting + xo, 1, world.maxx), clamp(starting + yo, 1, world.maxy), starting.z)
		set_angle(get_angle(src, target))
	original_angle = Angle
	if(!nondirectional_sprite)
		var/matrix/matrix = new
		matrix.Turn(Angle)
		transform = matrix
	trajectory_ignore_forcemove = TRUE
	forceMove(starting)
	trajectory_ignore_forcemove = FALSE
	trajectory = new(starting.x, starting.y, starting.z, pixel_x, pixel_y, Angle, SSprojectiles.global_pixel_speed)
	last_projectile_move = world.time
	fired = TRUE
	SEND_SIGNAL(src, COMSIG_PROJECTILE_FIRE)

	return process_hitscan(targloc)

/obj/projectile/test/process_hitscan(turf/targloc)
	var/safety = range * 10
	record_hitscan_start(RETURN_POINT_VECTOR_INCREMENT(src, Angle, MUZZLE_EFFECT_PIXEL_INCREMENT, 1))
	while(loc)
		if(paused)
			stoplag(1)
			continue

		if(targloc == get_turf(src))
			return TRUE

		if(!isnull(result))
			return result

		if(safety-- <= 0)
			return FALSE //Kill!

		pixel_move(1, TRUE)

/obj/projectile/test/Destroy()
	obstacle = null
	result = null
	. = ..()
