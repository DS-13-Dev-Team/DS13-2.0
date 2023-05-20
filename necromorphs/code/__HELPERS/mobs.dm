
//Returns true if the two passed mobs are on the same "team".
//For the purposes of DS13, this is only true if both are necromorphs
/atom/proc/is_allied(atom/B)
	if (isnecromorph(src) && isnecromorph(B))
		return TRUE
	return FALSE
