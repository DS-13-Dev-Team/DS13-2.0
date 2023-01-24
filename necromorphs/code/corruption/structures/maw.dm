#define CHEW_CHANCE 80
#define BASE_DAMAGE 10
#define DAMAGE_TO_BIOMASS_MULTIPLIER 0.2

/obj/structure/necromorph/maw
	name = "maw"
	desc = "The abyss stares back at you."
	icon = 'necromorphs/icons/effects/corruption.dmi'
	icon_state = "maw"
	max_integrity = 70
	density = FALSE
	var/obj/structure/marker/marker
	//Things we're currently eating, lazylist
	var/list/eating

/obj/structure/necromorph/maw/Initialize(mapload, obj/structure/marker/marker)
	.=..()
	if(!marker)
		return INITIALIZE_HINT_QDEL
	src.marker = marker
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_ATOM_INITIALIZED_ON = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/necromorph/maw/Destroy()
	if(marker)
		LAZYREMOVE(marker.active_maws, src)
		marker = null
	return ..()

/obj/structure/necromorph/maw/proc/on_entered(atom/source, mob/living/carbon/human/arrived)
	if(ishuman(arrived) && !isnecromorph(arrived))
		LAZYADD(eating, arrived)
		ADD_TRAIT(arrived, TRAIT_FLOORED, src)
		ADD_TRAIT(arrived, TRAIT_IMMOBILIZED, src)
		LAZYADD(marker.active_maws, src)

//Returns amount of biomass obtained
/obj/structure/necromorph/maw/proc/chew_target(delta_time)
	. = 0
	for(var/mob/living/carbon/human/target as anything in eating)
		if(DT_PROB(CHEW_CHANCE, delta_time))
			var/obj/item/bodypart/part = pick(target.bodyparts)
			. += part.take_damage(BASE_DAMAGE*delta_time, BRUTE, MELEE, TRUE, DOWN, 50)*DAMAGE_TO_BIOMASS_MULTIPLIER
			flick("maw_v", src)

/obj/structure/necromorph/maw/proc/target_moved(mob/living/carbon/human/moved)
	if(moved.loc != src.loc)
		REMOVE_TRAIT(moved, TRAIT_FLOORED, src)
		REMOVE_TRAIT(moved, TRAIT_IMMOBILIZED, src)
		LAZYREMOVE(eating, moved)
		if(!eating)
			LAZYREMOVE(marker.active_maws, src)

/datum/action/cooldown/necro/corruption/maw
	name = "Maw"
	place_structure = /obj/structure/necromorph/maw
	cost = 50
	marker_only = TRUE

#undef CHEW_CHANCE
#undef BASE_DAMAGE
#undef DAMAGE_TO_BIOMASS_MULTIPLIER
