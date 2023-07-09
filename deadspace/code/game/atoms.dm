/atom
	//Misc:
	var/list/statmods	//This is a list which we don't initialise to save on object creating costs. use lazyprocs to init at runtime when needed

/atom/set_density(new_value)
	.=..()
	if(!isnull(.))
		SEND_SIGNAL(src, COMSIG_ATOM_SET_DENSITY, ., new_value)

//Should return list or nukk
/atom/proc/can_see_marker()
	return null

/atom/proc/CanCorrupt(corruption_dir)
	if(!density)
		return TRUE
	if(flags_1 & ON_BORDER_1)
		if(dir != REVERSE_DIR(corruption_dir))
			return TRUE
	return FALSE

//Considering the checks corruption does we assume turf is not dense
//Add density checks if you will need this proc outside of corruption spreading
/turf/CanCorrupt(corruption_dir)
	for(var/atom/movable/thing as anything in contents)
		if(!thing.CanCorrupt(corruption_dir))
			return
	return TRUE
