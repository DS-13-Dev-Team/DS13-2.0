GLOBAL_LIST_EMPTY(necromorph_markers)
/obj/structure/marker
	name = "Marker"
	icon = 'necromorphs/icons/obj/marker_giant.dmi'
	icon_state = "marker_giant_dormant"
	appearance_flags = PIXEL_SCALE|LONG_GLIDE
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	pixel_x = -33
	base_pixel_x = -33
	move_resist = MOVE_FORCE_OVERPOWERING
	density = TRUE
	var/active = FALSE
	var/mob/camera/marker_signal/camera_mob
	var/datum/markernet/markernet
	var/list/marker_signals = list()
	var/list/necromorphs = list()
	var/invested_biomass
	var/unavailable_biomass
	var/list/datum/necro_class/necro_classes = list()
	/// A list of all corruption nodes
	var/list/nodes = list()
