/obj/structure/necromorph/node/branch
	name = "branch"
	icon = 'necromorphs/icons/effects/corruption.dmi'
	icon_state = "minigrowth"
	corruption_node_type = /datum/corruption_node/branch
	max_integrity = 45

/datum/corruption_node/branch
	remaining_weed_amount = 80
	control_range = 5

/datum/action/cooldown/necro/corruption/branch
	name = "Branch"
	place_structure = /obj/structure/necromorph/node/branch
	cost = 5
