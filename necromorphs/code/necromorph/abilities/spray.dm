
/datum/action/cooldown/necro/spray
	name = "Vomit"
	desc = "A close range attack that covers a large area for area denial."
	click_to_activate = TRUE

	var/angle = 100
	var/length = 2.5
	var/atom/target_atom

	var/stun = TRUE
	var/duration = 3 SECONDS
	var/windup = 1.8 SECONDS
	var/is_processing = FALSE
	cooldown_time = 12 SECONDS

	var/list/affected_turfs = list()

	var/affect_origin = FALSE	//If true, the origin turf is affected as well

	var/particle_color = "#FFFFFF"

	var/ongoing_timer

	var/obj/item/chem_atom
	var/datum/reagents/chem_holder
	var/volume_tick = 1.1
	var/reagent_type = /datum/reagent/acid/necromorph

/datum/action/cooldown/necro/spray/Destroy(force, ...)
	. = ..()

/datum/action/cooldown/necro/spray/PreActivate(atom/target)
	if(owner.incapacitated())
		return FALSE

	var/mob/living/carbon/human/necromorph/N = owner
	N.play_necro_sound(SOUND_PAIN, VOLUME_MID, 3)
	N.shake_animation(30)
	addtimer(CALLBACK(src, PROC_REF(preactivation_proc)), 9)
	addtimer(CALLBACK(N, TYPE_PROC_REF(/mob/living/carbon/human/necromorph, play_necro_sound), SOUND_SHOUT_LONG, VOLUME_HIGH, 3), 18)
	owner.face_atom(target)
	target_atom = target
	. = ..()

/datum/action/cooldown/necro/spray/proc/preactivation_proc()
	var/mob/living/carbon/human/necromorph/N = owner
	N.play_necro_sound(SOUND_PAIN, VOLUME_HIGH, 3)
	N.shake_animation(30)

/datum/action/cooldown/necro/spray/Activate(atom/target)
	. = ..()
	chem_atom = new(owner)
	chem_holder = new (2**24)
	chem_holder.my_atom = chem_atom
	chem_holder.add_reagent(reagent_type, chem_holder.maximum_volume)

	addtimer(CALLBACK(src, PROC_REF(start)), windup)
	return TRUE

/datum/action/cooldown/necro/spray/proc/start()

	//A duration of 0 lasts indefinitely, until something stops it
	if (duration)
		ongoing_timer = addtimer(CALLBACK(src, PROC_REF(stop)), duration, TIMER_STOPPABLE)

	recalculate_cone()

	if (stun && isliving(owner))
		start_stun()
		addtimer(CALLBACK(src, PROC_REF(end_stun)), duration)

	if(!is_processing)
		SSnecroabilite.processing += src
		is_processing = TRUE

/datum/action/cooldown/necro/spray/proc/stop()
	SSnecroabilite.processing -= src
	is_processing = FALSE
	deltimer(ongoing_timer)
	QDEL_NULL(chem_holder)
	QDEL_NULL(chem_atom)

/datum/action/cooldown/necro/spray/process_abilitie()
	for (var/t in affected_turfs)
		var/turf/T = t
		chem_holder.trans_to(T, volume_tick)
		for (var/atom/movable/A in T)
			chem_holder.trans_to(A, volume_tick)

/datum/action/cooldown/necro/spray/proc/start_stun()
	ADD_TRAIT(owner, TRAIT_INCAPACITATED, src)
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, src)

/datum/action/cooldown/necro/spray/proc/end_stun()
	REMOVE_TRAIT(owner, TRAIT_INCAPACITATED, src)
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, src)

/datum/action/cooldown/necro/spray/proc/set_target(datum/new_target, target_object)
	target_atom = new_target
	if (target_object)
		target = target_object
		if (isliving(owner))
			owner.face_atom(target_object)

	//Only recalc if this is set
	if (angle)
		recalculate_cone()

/datum/action/cooldown/necro/spray/proc/recalculate_cone()
	var/list/previous_turfs = affected_turfs.Copy()
	affected_turfs = list()
	affected_turfs = get_view_cone(owner, target_atom, length, angle)

	//Don't remove this if we're going to affect the origin
	if (!affect_origin)
		affected_turfs -= get_turf(owner)

	//We will do raytrace testing to see which turfs we actually have line of sight to
	var/list/new_turfs = affected_turfs - previous_turfs
	if (LAZYLEN(new_turfs))
		//Check trajectory returns an assoc list with true/false as value of whether the tile is reachable
		new_turfs = check_trajectory_mass(new_turfs, owner)
		for (var/turf in new_turfs)
			//If the value is false, LOS was blocked, so we remove it from affected turfs
			if (!new_turfs[turf])
				affected_turfs -= turf


	//If affecting origin, add this in, as it may or may not be already present
	if (affect_origin)
		affected_turfs |= get_turf(owner)
