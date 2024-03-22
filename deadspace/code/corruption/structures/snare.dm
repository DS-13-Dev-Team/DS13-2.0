/obj/structure/necromorph/snare
	name = "snare"
	icon = 'deadspace/icons/effects/corruption.dmi'
	icon_state = "snare"
	max_integrity = 50

/obj/structure/necromorph/snare/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/slippery/necro, 5 SECONDS, NO_SLIP_WHEN_WALKING|SLIDE|GALOSHES_DONT_HELP, null, 1 SECONDS)

/datum/action/cooldown/necro/corruption/snare
	name = "Snare"
	button_icon_state = "snare"
	place_structure = /obj/structure/necromorph/snare
	can_place_in_sight = TRUE
	cost = 40

//This can stay empty, since we don't really need to change anything in the parent
/datum/component/slippery/necro

//The special check, if it wasn't for slippery/clowning existing I wouldn't even do this
/datum/component/slippery/necro/Slip(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(isnecromorph(arrived)) //The entire reason we made a child component, ain't it nasty?
		return
	if(arrived == parent)
		return
	if(!isliving(arrived))
		return
	var/mob/living/victim = arrived
	if(!(victim.movement_type & FLYING) && victim.slip(knockdown_time, parent, lube_flags, paralyze_time, force_drop_items) && callback)
		callback.Invoke(victim)
