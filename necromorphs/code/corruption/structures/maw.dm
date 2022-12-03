/obj/structure/necromorph/maw
	name = "maw"
	desc = "The abyss stares back at you."
	icon = 'necromorphs/icons/effects/corruption.dmi'
	icon_state = "maw"
	max_integrity = 70
	density = FALSE
	var/obj/structure/marker/marker

	var/list/eating	//Things we're currently eating. Keep chewing as long as one is nearby
	var/chomp_chance = 10	//The chance, per tick, per mob, to do a chomp animation. max 1 per tick
	//Also used as the chance to damage trapped mobs

	var/base_damage = 15
	var/fail_damage = 4
	var/base_difficulty = 60
	var/time_to_escape = 40
	var/target_zone
	var/struggle_prob = 2

/obj/structure/necromorph/maw/Initialize(mapload, obj/structure/marker/marker)
	.=..()
	if(!marker)
		return INITIALIZE_HINT_QDEL
	src.marker = marker
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
		COMSIG_ATOM_INITIALIZED_ON = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/necromorph/maw/Destroy()
	if(marker)
		//biomass manipulations

	marker = null
	return ..()

/obj/structure/necromorph/maw/proc/on_entered(atom/source, mob/living/carbon/human/arrived)
	if(ishuman(arrived) && !isnecromorph(arrived))
		LAZYADD(eating, arrived)
		ADD_TRAIT(arrived, TRAIT_RESTRAINED, src)

//Returns amount of biomass obtained
/obj/structure/necromorph/maw/proc/chew_target()

/obj/structure/necromorph/maw/proc/target_moved(mob/living/carbon/human/moved)
	if(moved.loc != src.loc)
		REMOVE_TRAIT(moved, TRAIT_RESTRAINED, src)
		LAZYREMOVE(eating, moved)

/datum/action/cooldown/necro/corruption/maw
	name = "Maw"
	place_structure = /obj/structure/necromorph/maw
	cost = 50
