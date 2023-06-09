
/mob/proc/enemy_in_view(require_standing = FALSE)
	for(var/mob/living/carbon/human/H in dview(center = loc))
		//People who are downed don't count
		if (require_standing && (H.stat))
			continue

		//Other necros don't count
		if (faction_check(faction, H.faction))
			continue

		return TRUE

	return FALSE

/**
 * This somewhat complex proc attempts to find a valid enemy target nearby.
 *
 * Arguments:
 * * Origin:		Where do we search around?\
 * * Searchrange:	How far around origin do we search?
 * * User:			Who is doing the searching? This is used for is_allied. If not passed, all mobs will be considered?
 * * Reach:		Target must be within Reach tiles of the user
 */
/proc/autotarget_enemy_mob(atom/origin, searchrange = 1, mob/living/user = null, reach = 0)
	var/list/search_tiles = RANGE_TURFS(searchrange, origin)
	var/list/prime_targets = list()	//Main targets, we pick one
	var/list/secondary_targets	=	list()	//Used only if there are no prime targets
	for (var/t in search_tiles)
		var/turf/T = t
		for (var/mob/living/L in T)

			if (L.stat == DEAD)
				continue	//Never target a dead mob

			if (user && faction_check(user.faction, L.faction))
				continue	//Don't target our allies

			if (reach && (get_dist(user, L) > reach))
				continue	//Got to be near the user

			//Alright all safety checks passed, we have a valid target. But how valid?
			if (L.body_position == LYING_DOWN)
				//Lying targets are low priority
				secondary_targets.Add(L)

			else
				prime_targets.Add(L)

	if (prime_targets.len)
		return pick(prime_targets)

	else if (secondary_targets.len)
		return pick(secondary_targets)

	else
		return origin
