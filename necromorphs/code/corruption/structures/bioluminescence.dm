/obj/structure/necromorph/lamp
	name = "bioluminescence nodule"
	desc = "A candle to light the way home"
	icon = 'necromorphs/icons/effects/corruption.dmi'
	icon_state = "light"
	light_power = 1
	light_range = 8
	light_color = COLOR_BRIGHT_ORANGE
	max_integrity = 20

/datum/action/cooldown/necro/corruption/lamp
	name = "Bioluminescence"
	place_structure = /obj/structure/necromorph/lamp
	cost = 10
