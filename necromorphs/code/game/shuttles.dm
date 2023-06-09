/obj/machinery/computer/shuttle/sprawl_transport
	name = "transport shuttle console"
	desc = "A console that controls the transport shuttle."
	circuit = /obj/item/circuitboard/computer/sprawl_transport_shuttle
	shuttleId = "trasport_sprawl"
	possible_destinations = "sprawl_east;sprawl_center;sprawl_west"
	req_access = list()

/obj/item/circuitboard/computer/sprawl_transport_shuttle
	name = "Transport Shuttle (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/sprawl_transport

/datum/map_template/shuttle/cargo/sprawl
	prefix = "necromorphs/maps/"
	suffix = "sprawl"
	name = "cargo ferry (Sprawl)"

/datum/map_template/shuttle/mining/sprawl
	prefix = "necromorphs/maps/"
	suffix = "sprawl"
	name = "mining shuttle (Sprawl)"

/datum/map_template/shuttle/transport_sprawl
	prefix = "necromorphs/maps/"
	port_id = "transport"
	suffix = "sprawl"
	name = "transport shuttle (Sprawl)"
