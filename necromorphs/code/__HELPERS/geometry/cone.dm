/proc/get_cone(turf/origin, turf/target, radius, angle)
	.=list()
	origin = get_turf(origin)
	target = get_turf(target)
	if(angle > 360)
		return circle_range_turfs(origin, radius)
	angle *= 0.5
	var/targetAngle = ATAN2(target.x - origin.x, target.y - origin.y)
	var/startAngle = targetAngle-angle
	var/endAngle = targetAngle+angle
	var/r2 = radius * (radius + 0.5)
	for(var/turf/t as anything in RANGE_TURFS(radius, origin))
		var/xTurf = t.x - origin.x
		var/yTurf = t.y - origin.y
		var/turfAngle = ATAN2(xTurf, yTurf)
		if(turfAngle >= startAngle && turfAngle <= endAngle && (xTurf**2 + yTurf**2) <= r2 \
			&& ((startAngle < 180) ? turfAngle <= (startAngle - 360) : TRUE) && ((endAngle > -180) ? turfAngle >= (endAngle + 360) : TRUE))
			.+= t

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
