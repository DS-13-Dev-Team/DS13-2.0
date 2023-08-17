/obj/item/storage/lunchbox
	desc = "A little lunchbox. This one is the colors of the rainbow!"
	attack_verb_continuous = list("lunched")
	attack_verb_simple = list("lunched")
	icon = 'deadspace/icons/obj/storage.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	flags_1 = CONDUCT_1

	force = 3
	throwforce = 5
	throw_speed = 1
	throw_range = 4
	stamina_damage = 23
	stamina_cost = 10
	stamina_critical_chance = 5

/obj/item/storage/lunchbox/Initialize()
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_total_storage = 8

/obj/item/storage/lunchbox/egov
	name = "EarthGov brand lunchbox"
	icon_state = "lunchbox_egov"
	inhand_icon_state = "toolbox_blue"
	desc = "A little lunchbox. This one is branded with the EarthGov logo!"

/obj/item/storage/lunchbox/scaf
	name = "Sovereign Colonies lunchbox"
	icon_state = "lunchbox_scaf"
	inhand_icon_state = "toolbox_red"
	desc = "A little lunchbox. This one is branded with the Sovereign Colonies logo! This one looks rather old, almost collectible..."

/obj/item/storage/lunchbox/cec
	name = "CEC lunchbox"
	icon_state = "lunchbox_cec"
	inhand_icon_state = "toolbox_yellow"
	desc = "A little lunchbox. This one is branded with the CEC logo!"

/obj/item/storage/lunchbox/unitology
	name = "Unitology lunchbox"
	icon_state = "lunchbox_unit"
	inhand_icon_state = "toolbox_syndi"
	desc = "A little lunchbox. This one is a sleek black and red, with a Marker symbol in the middle of it. made of a durable steel!"
