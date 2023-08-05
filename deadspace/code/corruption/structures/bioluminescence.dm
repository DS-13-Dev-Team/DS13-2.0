/obj/structure/necromorph/lamp
	name = "bioluminescence nodule"
	desc = "A candle to light the way home"
	icon = 'deadspace/icons/effects/corruption.dmi'
	icon_state = "light"
	light_power = 1
	light_inner_range = 2
	light_outer_range = 4
	light_color = COLOR_BRIGHT_ORANGE
	max_integrity = 20

/datum/action/cooldown/necro/corruption/lamp
	name = "Bioluminescence"
	button_icon_state = "bioluminescence"
	place_structure = /obj/structure/necromorph/lamp
	cost = 2
