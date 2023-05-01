/proc/get_cone(turf/origin, turf/target, radius, angle)
	. = list()
	origin = get_turf(origin)
	target = get_turf(target)
	if(angle > 360)
		return circle_range_turfs(origin, radius)
	angle *= 0.5
	for(var/turf/t as anything in RANGE_TURFS(radius, origin))
		var/t_angle = get_angle(origin, t)
		var/datum/point/vector/direction = new(_angle = t_angle, initial_increment = TRUE)
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
