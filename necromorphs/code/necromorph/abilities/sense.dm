/datum/action/cooldown/necro/sense
	name = "Sense"
	desc = "Reveals nearby living creatures around you, to yourself and allies."
	cooldown_time = 3 SECONDS
	var/duration = 9 SECONDS
	var/range_sense = 9
	var/range_buff = 9
	var/list/seen = list()
	var/list/trackers = list()
	var/list/seers = list()
	var/obj/effect/temp_visual/expanding_circle/EC

/datum/action/cooldown/necro/sense/PreActivate(atom/target)
	. = ..()

/datum/action/cooldown/necro/sense/Activate(atom/target)
	var/turf/centre = get_turf(owner)
	var/list/turfs_buff = RANGE_TURFS(range_buff, centre)
	var/list/turfs_sense = RANGE_TURFS(range_sense, centre)
	for (var/mob/living/L in GLOB.mob_living_list)
		if (L.stat == DEAD)
			continue	//Gotta be alive to see or be seen

		var/turf/T = get_turf(L)
		if (T in turfs_sense)
			seen += L //We can see this mob

		//To se things you've got to be:
			//In the correct faction
			//Have a client
			//Near enough to the owner
			//Alive and conscious
		if ((!owner.faction || faction_check(owner.faction, L.faction)) && L.client && (T in turfs_buff) && !L.stat)
			//This mob gets to see
			seers += L

/*	for (var/mob/living/L in seen)
		for (var/mob/living/S in seers)
			if (L == S)
				continue //Don't see yourself
			var/atom/movable/screen/movable/tracker/TR = new (S,L, duration)
			var/mutable_appearance/ma = new /mutable_appearance(L)
			TR.appearance = ma
			trackers += TR */

	addtimer(CALLBACK(src, PROC_REF(finish)), duration)
	StartCooldown()

	//Lets do some cool effects
	effects()
	addtimer(CALLBACK(src, PROC_REF(effects)), 4)
	addtimer(CALLBACK(src, PROC_REF(effects)), 8)

	var/found = null
	//And finally lets search for a living crewmember
	for (var/datum/mind/M as anything in GLOB.mob_living_list)
		if (ishuman(M.current))

			//We dont care about the dead
			var/mob/living/carbon/human/H = M.current
			if (H.stat == DEAD)
				continue

			if (faction_check(owner.faction, M.current.faction))
				continue

			//Only detect people on our floor
			if (H.z != owner.z)
				continue

			//Got one!
			found =  H
			break
	if (found)
		to_chat(owner, span_notice("There is a living human [get_dist(owner, found)]m away!"))
	else
		to_chat(owner, span_notice("There are no living prey on this floor"))

/datum/action/cooldown/necro/sense/proc/effects()
	EC = new /obj/effect/temp_visual/expanding_circle(owner.loc, 2 SECONDS, 2)
	EC.pixel_y += 40	//Offset it so it appears to be at our mob's head

/datum/action/cooldown/necro/sense/proc/finish()
	QDEL_LIST(trackers)
