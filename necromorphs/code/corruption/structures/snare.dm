/obj/structure/necromorph/snare
	name = "snare"
	icon = 'necromorphs/icons/effects/corruption.dmi'
	icon_state = "snare"
	max_integrity = 50

/obj/structure/necromorph/snare/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/slippery, 7 SECONDS, NO_SLIP_WHEN_WALKING|SLIDE|GALOSHES_DONT_HELP, null, 2 SECONDS)
