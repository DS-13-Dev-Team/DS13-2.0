/atom/set_density(new_value)
	.=..()
	if(!isnull(.))
		SEND_SIGNAL(src, COMSIG_ATOM_SET_DENSITY, ., new_value)

/atom/proc/can_see_marker()
	return list()

/atom/proc/CanCorrupt(corruption_dir)
	if((flags_1 & ON_BORDER_1) && (corruption_dir & ~turn(dir, 180)))
		return TRUE

//Considering the checks corruption does we assume turf is not dense
//Add density checks if you will need this proc outside of corruption spreading
/turf/CanCorrupt(corruption_dir)
	for(var/atom/movable/thing as anything in contents)
		if(density && !thing.CanCorrupt(corruption_dir))
			return
	return TRUE
