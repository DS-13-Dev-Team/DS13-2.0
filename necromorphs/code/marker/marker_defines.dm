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
	///Whether we should us necroqueue when spawning necromorphs
	var/use_necroqueue = TRUE
	var/mob/camera/marker_signal/marker/camera_mob
	var/datum/markernet/markernet
	var/list/marker_signals = list()
	var/list/necromorphs = list()
	/// Biomass stored
	var/biomass = 0
	/// Biomass signals can use
	var/signal_biomass = 0
	/// Biomass marker spent since the start of the round
	var/spent_biomass = 0
	/// Income per tick
	var/biomass_income = 0
	var/list/datum/necro_class/necro_classes = list()
	/// A list of all corruption nodes
	var/list/nodes = list()
	/// A list of atoms that let us spawn necromorphs 6 tiles away from them
	var/list/necro_spawn_atoms = list()
