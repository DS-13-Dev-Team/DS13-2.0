/turf/open/floor/plating/deadspace
	icon = 'necromorphs/icons/turf/floors_ds13.dmi'
	base_icon_state = "dank_plating"
	icon_state = "dank_plating"

/turf/open/floor/deadspace
	name = "floor"
	icon = 'necromorphs/icons/turf/floors_ds13.dmi'
	base_icon_state = "dank_tile"
	icon_state = "dank_tile"
	baseturfs = /turf/open/floor/plating/deadspace

/turf/open/floor/deadspace/roller
	base_icon_state = "dank_roller"
	icon_state = "dank_roller"

/turf/open/floor/deadspace/heavy
	base_icon_state = "dank_tile_heavy"
	icon_state = "dank_tile_heavy"

/turf/open/floor/deadspace/medical
	base_icon_state = "dank_tile_medical"
	icon_state = "dank_tile_medical"

/turf/open/floor/deadspace/bathroom
	base_icon_state = "dank_tile_bathroom"
	icon_state = "dank_tile_bathroom"

/turf/open/floor/deadspace/mono
	base_icon_state = "dank_tile_mono"
	icon_state = "dank_tile_mono"

/turf/open/floor/deadspace/hardwood
	base_icon_state = "hardwood"
	icon_state = "hardwood"

/turf/open/floor/deadspace/hardwood/alt
	base_icon_state = "hardwood_alt"
	icon_state = "hardwood_alt"

/turf/open/floor/deadspace/old_rivets
	base_icon_state = "rivets_old"
	icon_state = "rivets_old"

/turf/open/floor/deadspace/old_rivets/older
	base_icon_state = "rivets_olderer"
	icon_state = "rivets_olderer"

/turf/open/floor/deadspace/grate
	base_icon_state = "grate"
	icon_state = "grate"

/turf/open/floor/deadspace/grater //who names this stuff
	base_icon_state = "grater"
	icon_state = "grater"

/turf/open/floor/deadspace/cable_start
	base_icon_state = "cable_start"
	icon_state = "cable_start"

/turf/open/floor/deadspace/cable
	base_icon_state = "cable"
	icon_state = "cable"

/turf/open/floor/deadspace/cable_end
	base_icon_state = "cable_end"
	icon_state = "cable_end"

/turf/open/floor/deadspace/tram
	base_icon_state = "trammiddle"
	icon_state = "trammiddle"

/turf/open/floor/deadspace/tram/grating
	base_icon_state = "tramgrating"
	icon_state = "tramgrating"

/turf/open/floor/deadspace/tram/corner
	base_icon_state = "tramcorner"
	icon_state = "tramcorner"

/turf/open/floor/deadspace/tram/warning
	base_icon_state = "tramwarning"
	icon_state = "tramwarning"

/turf/open/floor/deadspace/random
	base_icon_state = "old"
	icon_state = "old"
	/// Used to define that maximum number of random variants a tile has
	var/rand_max = 5
	/// Used to define the minimum number of random variants a tile has
	var/rand_min = 1

/turf/open/floor/deadspace/random/Initialize(mapload)
	.=..()
	icon_state = "[initial(icon_state)][rand(rand_min,rand_max)]"

/turf/open/floor/deadspace/random/old
	base_icon_state = "old"
	icon_state = "old"
	rand_max = 5
	rand_min = 1

/turf/open/floor/deadspace/random/rivets
	base_icon_state = "rivets"
	icon_state = "rivets"
	rand_max = 4
	rand_min = 0

/turf/open/floor/deadspace/random/slashed
	base_icon_state = "slashed"
	icon_state = "slashed"
	rand_max = 3
	rand_min = 0

/turf/open/floor/deadspace/random/slashed_odd
	base_icon_state = "slashed_odd"
	icon_state = "slashed_odd"
	rand_max = 3
	rand_min = 0

/turf/open/floor/deadspace/random/tech
	base_icon_state = "tech"
	icon_state = "tech"
	rand_max = 6 
	rand_min = 0

/turf/open/floor/deadspace/random/golf_gray
	base_icon_state = "golf_gray"
	icon_state = "golf_gray"
	rand_max = 6
	rand_min = 0

/turf/open/floor/deadspace/random/golf_brown
	base_icon_state = "golf_brown"
	icon_state = "golf_brown"
	rand_max = 6
	rand_min = 0

/turf/open/floor/deadspace/random/maint_left
	base_icon_state = "maint_left"
	icon_state = "maint_left"
	rand_max = 4
	rand_min = 0

/turf/open/floor/deadspace/random/maint_center
	base_icon_state = "maint_center"
	icon_state = "maint_center"
	rand_max = 4
	rand_min = 0

/turf/open/floor/deadspace/random/maint_right
	base_icon_state = "maint_right"
	icon_state = "maint_right"
	rand_max = 4
	rand_min = 0

/turf/open/floor/deadspace/random/rectangles
	base_icon_state = "rectangles"
	icon_state = "rectangles"
	rand_max = 6
	rand_min = 0

/turf/open/floor/deadspace/random/slides
	base_icon_state = "slides"
	icon_state = "slides"
	rand_max = 6
	rand_min = 0

/turf/open/floor/deadspace/random/slides_end
	base_icon_state = "slides_end"
	icon_state = "slides_end"
	rand_max = 6
	rand_min = 0
