/datum/component/corruption_absorbing
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	var/obj/structure/marker/master
	var/datum/biomass_source/bio_source
	var/timerid

/datum/component/corruption_absorbing/Initialize(obj/structure/marker/our_master)
	if(!isliving(parent) || isnecromorph(parent))
		return COMPONENT_INCOMPATIBLE
	master = our_master
	var/mob/living/living = parent
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/on_moved)
	if(living.stat == DEAD)
		RegisterSignal(living, COMSIG_LIVING_REVIVE, .proc/on_revive)
		timerid = addtimer(CALLBACK(src, .proc/start_absorbing), 2 MINUTES, TIMER_STOPPABLE)
	else
		RegisterSignal(living, COMSIG_LIVING_DEATH, .proc/on_death)

/datum/component/corruption_absorbing/Destroy(force, silent)
	if(bio_source)
		master.remove_biomass_source(bio_source)
		bio_source = null
	master = null
	return ..()

/datum/component/corruption_absorbing/InheritComponent(datum/component/new_comp, original, obj/structure/marker/new_master)
	if(!original)
		return
	if(bio_source)
		master.remove_biomass_source(bio_source)
	bio_source = new_master.add_biomass_source(/datum/biomass_source/corruption_absorbing, parent)
	master = new_master

/datum/component/corruption_absorbing/proc/start_absorbing()
	bio_source = master.add_biomass_source(/datum/biomass_source/corruption_absorbing, parent)

/datum/component/corruption_absorbing/proc/on_moved(mob/living/source, turf/old_loc, dir, forced, list/old_locs)
	var/turf/our_loc = source.loc
	//If we remain on a corrupted turf - do nothing
	if(isturf(our_loc) && our_loc.necro_corrupted)
		return
	//We are not on the corrupted turf anymore
	qdel(src)

/datum/component/corruption_absorbing/proc/on_death(mob/living/source, gibbed)
	timerid = addtimer(CALLBACK(src, .proc/start_absorbing), 2 MINUTES, TIMER_STOPPABLE)

/datum/component/corruption_absorbing/proc/on_revive(mob/living/source, full_heal, admin_revive)
	master.remove_biomass_source(bio_source)
	deltimer(timerid)
	bio_source = null
