/obj/structure/necromorph/node/propagator
	name = "propagator"
	icon = 'necromorphs/icons/effects/corruption.dmi'
	icon_state = "growth"
	corruption_node_type = /datum/corruption_node/propagator
	max_integrity = 200

/datum/corruption_node/propagator
	remaining_weed_amount = 300
	control_range = 12

/datum/action/cooldown/necro/corruption/propagator
	name = "Propagator"
	place_structure = /obj/structure/necromorph/node/propagator
	cost = 20
