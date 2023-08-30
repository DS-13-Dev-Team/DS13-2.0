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
	prefix = "deadspace/maps/"
	suffix = "sprawl"
	name = "cargo ferry (Sprawl)"

/datum/map_template/shuttle/mining/sprawl
	prefix = "deadspace/maps/"
	suffix = "sprawl"
	name = "mining shuttle (Sprawl)"

/datum/map_template/shuttle/transport_sprawl
	prefix = "deadspace/maps/"
	port_id = "transport"
	suffix = "sprawl"
	name = "transport shuttle (Sprawl)"

/datum/map_template/shuttle/cargo/mara
	prefix = "deadspace/maps/"
	suffix = "mara"
	name = "cargo ferry (Mara 17)"

/datum/map_template/shuttle/emergency/mara
	prefix = "deadspace/maps/"
	suffix = "mara"
	name = "emergency shuttle (Mara 17)"

/datum/map_template/shuttle/cargo/aegis
	prefix = "deadspace/maps/"
	suffix = "aegis"
	name = "cargo ferry (Aegis VII)"

/datum/map_template/shuttle/emergency/aegis_first
	prefix = "deadspace/maps/"
	suffix = "aegis1"
	name = "emergency shuttle 1 (Aegis VII)"

/datum/map_template/shuttle/emergency/aegis_second
	prefix = "deadspace/maps/"
	suffix = "aegis2"
	name = "emergency shuttle 2 (Aegis VII)"
