
/proc/TurfBlockedNonWindow(turf/loc)
	for(var/obj/O in loc)
		if(O.density && !istype(O, /obj/structure/window))
			return TRUE
	return FALSE

/proc/LinkBlocked(turf/A, turf/B)
	if(isnull(A) || isnull(B))
		return TRUE
	var/adir = get_dir(A, B)
	var/rdir = get_dir(B, A)
	if(adir & (adir - 1))//is diagonal direction
		var/turf/iStep = get_step(A, adir & (NORTH|SOUTH))
		if(!iStep.density && !LinkBlocked(A, iStep) && !LinkBlocked(iStep, B))
			return FALSE

		var/turf/pStep = get_step(A,adir & (EAST|WEST))
		if(!pStep.density && !LinkBlocked(A, pStep) && !LinkBlocked(pStep, B))
			return FALSE
		return TRUE

	if(DirBlocked(A, adir))
		return TRUE
	if(DirBlocked(B, rdir))
		return TRUE
	return FALSE

/proc/DirBlocked(turf/loc, direction)
	for(var/obj/structure/window/D in loc)
		if(!D.density)
			continue
		if(D.dir == direction)
			return TRUE

	for(var/obj/machinery/door/D in loc)
		if(!D.density)
			continue
		if(istype(D, /obj/machinery/door/window))
			if(D.dir == direction)
				return TRUE
		else
			return TRUE	// it's a real, air blocking door
	for(var/obj/structure/mineral_door/D in loc)
		if(D.density)
			return TRUE
	for(var/obj/structure/barricade/B in loc)
		if(!B.density)
			continue
		if(B.dir == direction)
			return TRUE
	return FALSE
