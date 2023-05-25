/proc/get_cone(turf/origin, turf/target, radius, angle)
	. = list()
	origin = get_turf(origin)
	target = get_turf(target)
	if(angle > 360)
		return circle_range_turfs(origin, radius)
	angle *= 0.5
	for(var/turf/t as anything in RANGE_TURFS(radius, origin))
		var/t_angle = get_angle(origin, t)
		var/datum/point/vector/direction = new(_speed = 1, _angle = t_angle, initial_increment = TRUE)
		if(target_in_arc(origin, target, direction, target))
			. += t

/proc/get_view_cone(turf/origin, turf/target, distance, angle)
	if (!istype(origin))
		origin = get_turf(origin)
	var/list/viewlist = list()
	FOR_DVIEW(var/turf/T, distance, origin, 0)
		viewlist += T
	FOR_DVIEW_END
	var/list/conelist = get_cone(origin, target, distance, angle)

	var/list/all = (viewlist & conelist)

	return all

//Checks if target is within arc degrees either side of a specified direction vector from user. All parameters are mandatory
//Rounding explained above
/proc/target_in_arc(atom/origin, atom/target, datum/point/vector/direction, arc)
	origin = get_turf(origin)
	target = get_turf(target)
	if (origin == target)
		return TRUE

	var/datum/point/vector/dirvector = direction.copy_to()
	var/datum/point/vector/dotvector = new(target.x - origin.x, target.y - origin.y)
	. = round(dirvector.x * dotvector.x + dirvector.y * dotvector.y, 0.000001) >= round(cos(arc),0.000001)

//This hella complex proc gets a cone, but divided into several smaller cones. Returns a list of lists, each containing the tiles of the subcone
//No overlapping is allowed, each subcone contains a unique list
/proc/get_multistage_cone(turf/origin, datum/position/direction, distance, angle, stages = 5, clock_direction = CLOCKWISE)
	var/subcone_angle = angle / stages
	var/datum/position/subcone_direction

	//If clockwise, we rotate anticlockwise to the start, by half of the main angle minus half of the subcone angle
	if (clock_direction == CLOCKWISE)
		//And after this we'll add the subcone angle to eacch direction to get the next subcone centre
		subcone_direction = direction.Turn((angle*0.5 - subcone_angle*0.5)*-1)

	//If clockwise, we rotate clockwise to the end, by half of the main angle minus half of the subcone angle
	else if (clock_direction == ANTICLOCKWISE)
		subcone_direction = direction.Turn(angle*0.5 - subcone_angle*0.5)
		subcone_angle *= -1	//And we invert the subcone angle, since we'll still be adding it


	var/list/subcones = list()
	var/list/all_tiles = list()
	for (var/i in 1 to stages)
		//For each stage, we'll get the subcone
		var/list/subcone = get_cone(origin, subcone_direction, distance, abs(subcone_angle))
		subcone -= all_tiles	//Filter out any tiles that are already in another subcone
		//Don't add empty cones to lists
		if (length(subcone) > 0)
			all_tiles += subcone	//Then add ours to the global list
			subcones += list(subcone)	//And add this cone to the list of all the cones


		subcone_direction.SelfTurn(subcone_angle)
	//We only release vectors we created, not those we were given
	subcone_direction = null
	return subcones
