
/datum/action/cooldown/necro/spray
	name = "Spray"

	var/targetloc_x
	var/targetloc_y
	var/atom/target_atom
	var/status
	var/angle
	var/length

	var/stun = FALSE
	var/duration

	var/list/affected_turfs = list()
	var/turf/direction

	var/affect_origin = FALSE	//If true, the origin turf is affected as well


	//Registry:
	var/datum/click_handler/spray/spray_handler	//Click handler for aiming the spray
	var/datum/effect_system/spray/fx	//Particle system for chem particles
	var/fx_type = /datum/effect_system/spray


	var/particle_color = "#FFFFFF"

/datum/action/cooldown/necro/spray/Destroy(force, ...)
	QDEL_NULL(fx)
	. = ..()

/datum/action/cooldown/necro/spray/PreActivate(atom/target)
	if(owner.incapacitated())
		return FALSE
	. = ..()

/datum/action/cooldown/necro/spray/Activate(atom/target)
	. = ..()
	owner.face_atom(target)

	recalculate_cone()

	//Make sure we don't get double fx
	if (fx)
		QDEL_NULL(fx)

	//Lets create the chemspray fx
	fx = new fx_type
	fx.set_up(location = owner, direction = direction, angle = angle, length = length)
	fx.particle_color = particle_color
	fx.start()

	if (stun && isliving(owner))
		start_stun()
		addtimer(CALLBACK(src, PROC_REF(end_stun)), duration)

	return TRUE

/datum/action/cooldown/necro/spray/proc/start_stun()
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, src)

/datum/action/cooldown/necro/spray/proc/end_stun()
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, src)

/datum/action/cooldown/necro/spray/proc/set_target_loc(newloc_x, newloc_y, target_object)
	targetloc_x = newloc_x
	targetloc_y = newloc_y
	if (target_object)
		target_atom = target_object
		if (isliving(owner))
			owner.face_atom(target_object)

	//Only recalc if this is set
	if (angle)
		recalculate_cone()

/datum/action/cooldown/necro/spray/proc/recalculate_cone()
	var/list/previous_turfs = affected_turfs.Copy()
	affected_turfs = list()
	direction = get_direction()
	affected_turfs = get_view_cone(owner, direction, length, angle)

	//Don't remove this if we're going to affect the origin
	if (!affect_origin)
		affected_turfs -= get_turf(owner)

	//We will do raytrace testing to see which turfs we actually have line of sight to
	var/list/new_turfs = affected_turfs - previous_turfs
	if (LAZYLEN(new_turfs))
		//Check trajectory returns an assoc list with true/false as value of whether the tile is reachable
		new_turfs = check_trajectory_mass(new_turfs, owner, PASS_FLAG_TABLE | PASS_FLAG_NOMOB)
		for (var/turf in new_turfs)
			//If the value is false, LOS was blockd, so we remove it from affected turfs
			if (!new_turfs[turf])
				affected_turfs -= turf


	//If affecting origin, add this in, as it may or may not be already present
	if (affect_origin)
		affected_turfs |= get_turf(owner)

	if (fx)
		fx.set_direction(direction)

/datum/action/cooldown/necro/spray/proc/get_direction()
	//As long as we're not on the same turf, we can do this easily
	var/turf/ourloc
	if (isturf(owner.loc))
		ourloc = owner.loc
	else
		var/atom/A = get_atom_on_turf(owner)
		ourloc = A

	if (!(ourloc ~= target))
		return locate(ourloc.x - target:x, ourloc.y - target:y, ourloc.z)

	else
		return get_step(owner, owner.dir)

/***********************
	Spray visual effect
************************/
/*
	Particle System
	Sprays particles in a cone
*/
/datum/effect_system/spray
	effect_type  = /obj/effect/particle_effect/spray

/datum/effect_system/spray/set_up(number = 3, cardinals_only = FALSE, location, direction, angle, length)
	. = ..()

/obj/effect/particle_effect/spray
	name = "spray"
	icon = 'icons/effects/effects.dmi'
	icon_state = "spray"
	color = "#FF0000"

