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

/proc/get_circle_turfs(turf/center, radius)
    . = list()
    var/x = -radius
    var/y = 0
    var/err = 2-2*radius
    do
        . += locate(center.x-x, center.y+y, center.z)
        . += locate(center.x-y, center.y-x, center.z)
        . += locate(center.x+x, center.y-y, center.z)
        . += locate(center.x+y, center.y+x, center.z)
        radius = err
        if(radius <= y)
            err += ++y*2+1
        if(radius > x || err > y)
            err += ++x*2+1
    while(x<0)
