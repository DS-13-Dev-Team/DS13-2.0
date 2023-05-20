
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
