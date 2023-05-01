
/*
	This returns true if we are adjacent to the target on a cardinal direction
	Returns false if they are diagonal from us, regardless of distance
*/
/atom/proc/cardinally_adjacent(atom/target)
	. = Adjacent(target)
	if (.)
		if ((target.x != x) && (target.y != y))
			return FALSE
