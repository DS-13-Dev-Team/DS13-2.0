
/datum/element/accelerate_on_crossed/Attach(datum/target)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = /atom.proc/accelerate_crosser,
	)
	target.AddElement(/datum/element/connect_loc, connections)

///Speeds up necro on crossed
/atom/proc/accelerate_crosser(datum/source, atom/movable/crosser)
	SIGNAL_HANDLER
	//TO DO ADD BUFFS FOR NECRO on WEEDS

