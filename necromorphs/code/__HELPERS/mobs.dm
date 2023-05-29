
//Returns true if the two passed mobs are on the same "team".
//For the purposes of DS13, this is only true if both are necromorphs
/atom/proc/is_allied(atom/B)
	if (isnecromorph(src) && isnecromorph(B))
		return TRUE
	return FALSE

/mob/proc/enemy_in_view(require_standing = FALSE)
	for(var/mob/living/carbon/human/H in dview(center = loc))
		//People who are downed don't count
		if (require_standing && (H.stat))
			continue

		//Other necros don't count
		if (is_allied(H))
			continue

		return TRUE

	return FALSE
