/obj/structure/necromorph/node
	name = "root"
	icon = 'necromorphs/icons/effects/corruption.dmi'
	icon_state = "minigrowth"
	corruption_node_type = /datum/corruption_node/root
	max_integrity = 45

/datum/corruption_node/root
	remaining_weed_amount = 60
	control_range = 12

/datum/action/cooldown/necro/corruption/root
	name = "Root"
	place_structure = /obj/structure/necromorph/node
	cost = 10
