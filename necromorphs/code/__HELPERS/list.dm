
//Returns the bottom(first) element from the list and removes it from the list (typical stack function)
/proc/antipop(list/listfrom)
	if (listfrom.len > 0)
		var/picked = listfrom[1]
		listfrom -= picked
		return picked
	return null
