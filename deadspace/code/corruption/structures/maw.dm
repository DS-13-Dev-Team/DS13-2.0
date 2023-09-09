#define MAW_DAMAGE_PER_SECOND 15

// Human biomass = their limbs
/obj/structure/necromorph/maw
	name = "maw"
	icon = 'deadspace/icons/effects/corruption.dmi'
	icon_state = "maw"
	max_integrity = 30
	can_buckle = TRUE
	max_buckled_mobs = INFINITY
	// Biomass that will be slowly given to the marker
	var/processing_biomass = 0
	var/obj/structure/marker/marker
	var/datum/biomass_source/our_source

/obj/structure/necromorph/maw/Initialize(mapload, obj/structure/marker/marker)
	.=..()
	if(!marker)
		return INITIALIZE_HINT_QDEL
	src.marker = marker

/obj/structure/necromorph/maw/Destroy()
	marker?.remove_biomass_source(our_source)
	our_source = null
	marker = null
	return ..()

/// Doesn't do any ANY safety checks. Use with caution
/obj/structure/necromorph/maw/proc/bite_human(mob/living/carbon/human/target, delta_time)
	if(length(target.bodyparts) <= 1)
		var/obj/item/bodypart/part = target.bodyparts[1]
		processing_biomass += part.biomass * 1.2
		qdel(target)
		continue

	var/obj/item/bodypart/part = pick(target.bodyparts)
	var/iteration = 0
	while(istype(part, /obj/item/bodypart/chest) && iteration++ < 5)
		part = pick(target.bodyparts - part)

	if(iteration >= 5)
		stack_trace("Maw tried to bite a human but couldn't find a non-chest bodypart")
		continue

	// If damage is above 80%
	if(part.get_damage() >= part.max_damage * 0.8)
		processing_biomass += part.biomass * 1.2
		part.drop_limb(FALSE, TRUE)
		qdel(part)
	else
		processing_biomass += part.biomass * 0.1
		part.receive_damage(MAW_DAMAGE_PER_SECOND * delta_time, 0, sharpness = SHARP_EDGED|SHARP_POINTY)

/// Doesn't do any ANY safety checks. Use with caution
/obj/structure/necromorph/maw/proc/bite_living(mob/living/target, delta_time)
	if(target.stat != DEAD || target.health > target.maxHealth * 0.1)
		target.adjustBruteLoss(MAW_DAMAGE_PER_SECOND * delta_time, TRUE)
		processing_biomass += target.mob_size * 0.5
		return
	//Might need some balance
	processing_biomass += target.mob_size * 5
	qdel(target)

/obj/structure/necromorph/maw/is_buckle_possible(mob/living/target, force, check_loc)
	if(!..())
		return FALSE
	if(isnecromorph(target))
		return FALSE
	return TRUE


/obj/structure/necromorph/maw/user_buckle_mob(mob/living/M, mob/user, check_loc)
	if(!isnecromorph(M))
		to_chat(user, span_warning("[src] refuses to consume [M]!"))
		return FALSE

	if(!do_after_mob(user, M, 2 SECONDS, IGNORE_HELD_ITEM|DO_PUBLIC, TRUE, CALLBACK(src, PROC_REF(buckle_mob_check), M)))
		return

	return ..()

/obj/structure/necromorph/maw/proc/buckle_mob_check(mob/living/buckling)
	if(QDELING(src))
		return
	if(buckling.buckled)
		return
	return TRUE

/obj/structure/necromorph/maw/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	if(buckled_mob.buckled != src || !user.CanReach(buckled_mob))
		return
	if(!do_after_mob(
		user, buckled_mob, 2 SECONDS, IGNORE_HELD_ITEM|DO_PUBLIC, TRUE,
		CALLBACK(src, PROC_REF(still_buckled), buckled_mob)
		))
		return
	return ..()

/obj/structure/necromorph/maw/proc/still_buckled(mob/living/buckled_mob)
	return buckled_mob.buckled == src

/obj/structure/necromorph/maw/post_buckle_mob(mob/living/M)
	if(length(buckled_mobs) <= 1)
		our_source = marker.add_biomass_source(/datum/biomass_source/maw, src)

/obj/structure/necromorph/maw/post_unbuckle_mob(mob/living/M)
	if(!length(buckled_mobs))
		marker.remove_biomass_source(our_source)

/obj/structure/necromorph/maw/relaymove(mob/living/user, direction)
	if(SEND_SIGNAL(src, COMSIG_ATOM_RELAYMOVE, user, direction) & COMSIG_BLOCK_RELAYMOVE)
		return
	if(!do_after(user, src, 2 SECONDS, IGNORE_HELD_ITEM|DO_PUBLIC) || (user.buckled != src))
		return
	unbuckle_mob(user, TRUE)


#undef MAW_DAMAGE_PER_SECOND
