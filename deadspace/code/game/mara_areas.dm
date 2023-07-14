/*

Mara 17, an icy planet god knows where (i didint know where to put it), a prototype map for DS13 lowpop, hopefully it's fun - Asi

I specially thank here DTtraitor and Kapu for helping with the weather system, without em, the map would not be possible,
aswell as having a fancy storm system to make it cool.

The Current areas will be the following


EXTERIOR = The 'Outskirts' of Mara 17, beyond and the exterior of the Iris outpost
INTERIOR = Most areas inside of the Iris outpost.

Note: There was a hatch on the map and another 2 files for an easter egg, but due funds and spriter being busy it wasnt possible to add,
maybe on the future.


*/

// EXTERIOR

/area/mara17
	name = "Mara 17"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "explored"

/area/mara17/exterior
	name = "Mara 17 Exterior"
	icon_state = "explored"
	ambience_index = AMBIENCE_MINING
	outdoors = TRUE


// INTERIOR

/area/mara17/interior
	name = "Mara 17 Interior"
	icon_state = "station"

/area/mara17/interior/caves // Basically to cover all of the rocks in the lower & upper & middle levels.
	name = "Mara 17 Interior Caves"
	icon_state = "noruins"

// UPPER LEVEL - Buildings on the High Level

///// MEDICAL BAY /////

/area/mara17/interior/upper/medical
	name = "Iris Outpost - Medical Bay"
	icon_state = "med_central"

/area/mara17/interior/upper/medical/morgue
	name = "Iris Outpost - Medical Bay - Morgue"
	icon_state = "morgue"

/area/mara17/interior/upper/medical/cmo
	name = "Iris Outpost - Medical Bay - Medical Director Office"
	icon_state = "CMO"

///// ENGINIEERING /////

/area/mara17/interior/upper/enginieering
	name = "Iris Outpost - Enginieering"
	icon_state = "engie"

/area/mara17/interior/upper/enginieering/interior
	name = "Iris Outpost - Enginieering Bay"
	icon_state = "engi_lobby"

/area/mara17/interior/upper/enginieering/ce
	name = "Iris Outpost - Chief Enginieer Office"
	icon_state = "ce_office"

///// WAREHOUSE /////

/area/mara17/interior/upper/warehouse
	name = "Iris Outpost - Storage Warehouse"
	icon_state = "storage"

///// CARGO /////

/area/mara17/interior/upper/cargo
	name = "Iris Outpost - Cargo Bay"
	icon_state = "cargo_bay"

/area/mara17/interior/upper/cargo/cargo_tech
	name = "Iris Outpost - Cargo Tech Office"
	icon_state = "cargo_office"

/area/mara17/interior/upper/cargo/quartermaster
	name = "Iris Outpost - Cargo Bay - Quartermaster Office"
	icon_state = "quart_office"

///// TELECOMMUNICATIONS /////

/area/mara17/interior/upper/tcomms
	name = "Iris Outpost - Telecommunications Control Room"
	icon_state = "tcomsatcomp"

/area/mara17/interior/upper/tcomms/comms
	name = "Iris Outpost - Telecommunications"
	icon_state = "tcomsatcham"

///// MINING /////

/area/mara17/interior/upper/mining
	name = "Iris Outpost - Mining Facility"
	icon_state = "mining"

/area/mara17/interior/upper/mining/tool_storage
	name = "Iris Outpost - Mining Facility - Mining Tool Storage"
	icon_state = "mining_storage"

/area/mara17/interior/upper/mining/locker_room
	name = "Iris Outpost - Mining Facility - Locker Room"
	icon_state = "mining_dock"

/area/mara17/interior/upper/mining/ore_storage
	name = "Iris Outpost - Mining Facility - Ore Storage"
	icon_state = "mining_production"

/area/mara17/interior/upper/mining/barracks
	name = "Iris Outpost - Mining Facility - Mining Barracks"
	icon_state = "mining_living"

/area/mara17/interior/upper/mining/bathrooms
	name = "Iris Outpost - Mining Facility - Restroom"
	icon_state = "restrooms"

/area/mara17/interior/upper/mining/relax_room
	name = "Iris Outpost - Mining Facility - R&R Room"
	icon_state = "mining_cafe"

///// EVACUATION BAY (Aka Trash disposal) /////

/area/mara17/interior/upper/evacuation
	name = "Iris Outpost - Trash Disposal Area"
	icon_state = "disposal"

///// CIVILIAN AREAS /////

/area/mara17/interior/upper/civilian
	name = "Iris Outpost - Employee Upper Barracks"
	icon_state = "dorms"

///// OBSERVATION DOME /////

/area/mara17/interior/upper/observation
	name = "Iris Outpost - Scientific Observation Post"
	icon_state = "hall"

/area/mara17/interior/upper/observation/comms
	name = "Iris Outpost - Scientific Observation Post - Communications Room"
	icon_state = "rec"

/area/mara17/interior/upper/observation/dorms
	name = "Iris Outpost - Scientific Observation Post - Crew Dormitories"
	icon_state = "dorms"

/area/mara17/interior/upper/observation/bathroom
	name = "Iris Outpost - Scientific Observation Post - Bathroom"
	icon_state = "restrooms"

/area/mara17/interior/upper/observation/storage
	name = "Iris Outpost - Scientific Observation Post - Auxiliary Storage"
	icon_state = "emergency_storage"

///// WATCHTOWER /////

/area/mara17/interior/upper/watchtower
	name = "Iris Outpost - Watchtower"
	icon_state = "checkpoint"

///// ACCESS/ENTRACE AREAS /////

/area/mara17/interior/upper/access1
	name = "Iris Outpost - Access 1"
	icon_state = "checkpoint"

/area/mara17/interior/upper/access2
	name = "Iris Outpost - Access 2"
	icon_state = "checkpoint"

/area/mara17/interior/upper/access3
	name = "Iris Outpost - Access 3"
	icon_state = "checkpoint"

// ABANDONED AREAS - South Area of the map //

/area/mara17/interior/upper/abandoned
	name = "Iris Outpost - Abandoned Area"
	icon_state = "unknown"

/area/mara17/interior/upper/abandoned/romero_interior
	name = "Iris Outpost - Romero Outpost Interior"
	icon_state = "station"

/area/mara17/interior/upper/abandoned/romero_commander
	name = "Iris Outpost - Romero Outpost - Commander Office"
	icon_state = "vacant_room"

/area/mara17/interior/upper/abandoned/romero_checkpoint
	name = "Iris Outpost - Romero Outpost - Commander Office"
	icon_state = "checkpoint"

/area/mara17/interior/upper/abandoned/romero_storage
	name = "Iris Outpost - Romero Outpost - Commander Office"
	icon_state = "storage"

/area/mara17/interior/upper/abandoned/romero_aux
	name = "Iris Outpost - Romero Outpost - Auxiliary Building"
	icon_state = "station"

/area/mara17/interior/upper/abandoned/romero_storage
	name = "Iris Outpost - Romero Outpost - Auxiliary Armory"
	icon_state = "storage"

/area/mara17/interior/upper/abandoned/romero_res_medbay
	name = "Iris Outpost - Romero Outpost - Specimen Dissection Room"
	icon_state = "patients"

/area/mara17/interior/upper/abandoned/romero_pen
	name = "Iris Outpost - Romero Outpost - Specimen Pen"
	icon_state = "sec_prison"


// MEDIUM LEVEL - Areas in the middle level

/area/mara17/interior/medium
	name = "Mara 17 Interior - Outpost Underground"
	icon_state = "crew_quarters"

///// CIVILIAN AREAS /////

/area/mara17/interior/medium/barracks
	name = "Mara 17 Interior - Barracks"
	icon_state = "dorms"

/area/mara17/interior/medium/restroom
	name = "Mara 17 Interior - Restroom"
	icon_state = "restrooms"

/area/mara17/interior/medium/janitor
	name = "Mara 17 Interior - Janitorial Storage"
	icon_state = "janitor"

/area/mara17/interior/medium/clothing_storage
	name = "Mara 17 Interior - Winter Gear Storage"
	icon_state = "laundry_room"

/area/mara17/interior/medium/hydrophonics
	name = "Mara 17 Interior - Hydrophonics"
	icon_state = "hydro"

/area/mara17/interior/medium/workshop
	name = "Mara 17 Interior - Workshop"
	icon_state = "engine_storage"

/area/mara17/interior/medium/chapel
	name = "Mara 17 Interior - Church of Unitology Chapel"
	icon_state = "chapel"

///// CANTEEN /////

/area/mara17/interior/medium/canteen
	name = "Mara 17 Interior - Canteen"
	icon_state = "cafeteria"

///// BAR /////

/area/mara17/interior/medium/bar
	name = "Mara 17 Interior - Bar"
	icon_state = "bar"

///// SMES ROOM /////

/area/mara17/interior/medium/smes
	name = "Mara 17 Interior - SMES Room 1#"
	icon_state = "maint_electrical"

/area/mara17/interior/medium/smes2
	name = "Mara 17 Interior - SMES Room 2#"
	icon_state = "maint_electrical"

///// RESEARCH /////

/area/mara17/interior/medium/research_dept
	name = "Mara 17 Interior - Research & Development"
	icon_state = "science"

/area/mara17/interior/medium/research_lab
	name = "Mara 17 Interior - R&D Lab"
	icon_state = "research"

/area/mara17/interior/medium/research_test
	name = "Mara 17 Interior - R&D Lab Testing Site"
	icon_state = "ord_test"

/area/mara17/interior/medium/research_breakroom
	name = "Mara 17 Interior - Research Break Room"
	icon_state = "lounge"

/area/mara17/interior/medium/research_rd
	name = "Mara 17 Interior - Research Director Office"
	icon_state = "rd_office"

///// LOWER MINING /////

/area/mara17/interior/medium/mining/
	name = "Iris Outpost - Lower Mining Facility"
	icon_state = "mining_labor"

/area/mara17/interior/medium/mining/ore_storage
	name = "Iris Outpost - Lower Mining Facility - Ore Storage"
	icon_state = "mining_production"

///// COMMAND /////

/area/mara17/interior/medium/command_center
	name = "Mara 17 Interior - Command Center"
	icon_state = "bridge"

/area/mara17/interior/medium/command_meeting
	name = "Mara 17 Interior - Command Conference Room"
	icon_state = "meeting"

/area/mara17/interior/medium/hop_office
	name = "Mara 17 Interior - Head of Personnel Office"
	icon_state = "hop_office"

/area/mara17/interior/medium/capt_office
	name = "Mara 17 Interior - Overseer Office"
	icon_state = "captain"

// PSYCHOLOGIST //

/area/mara17/interior/medium/psychology
	name = "Mara 17 Interior - Psychologist Office"
	icon_state = "psychology"

///// SECURITY /////

/area/mara17/interior/medium/security_center
	name = "Mara 17 Interior - Security Center"
	icon_state = "security"

/area/mara17/interior/medium/sec_barracks
	name = "Mara 17 Interior - Security Barracks"
	icon_state = "securitylockerroom"

/area/mara17/interior/medium/armory
	name = "Mara 17 Interior - Emergency Armory"
	icon_state = "armory"

/area/mara17/interior/medium/warden_office
	name = "Mara 17 Interior - Warden's Office"
	icon_state = "warden"

/area/mara17/interior/medium/evidence_1
	name = "Mara 17 Interior - Evidence Room 1#"
	icon_state = "investigate_office"

/area/mara17/interior/medium/evidence_2
	name = "Mara 17 Interior - Evidence Room 2#"
	icon_state = "investigate_office"

/area/mara17/interior/medium/sec_armory
	name = "Mara 17 Interior - Security Armory"
	icon_state = "armory"

/area/mara17/interior/medium/detective_office
	name = "Mara 17 Interior - Detective Office"
	icon_state = "detective"

/area/mara17/interior/medium/hos_office
	name = "Mara 17 Interior - Head of Security Office"
	icon_state = "sec_hos"

/area/mara17/interior/medium/perma
	name = "Mara 17 Interior - Permanent Confinement"
	icon_state = "sec_prison"

///// ABANDONED AREAS /////

/area/mara17/interior/medium/abandoned
	name = "Mara 17 - Abandoned Structure"
	icon_state = "unknown"

/area/mara17/interior/medium/abandoned/watchtower1
	name = "Mara 17 - Abandoned Watchtower 1#"
	icon_state = "unknown"

/area/mara17/interior/medium/abandoned/watchtower2
	name = "Mara 17 - Abandoned Watchtower 2#"
	icon_state = "unknown"

///// LOWER MARA AREAS /////

/area/mara17/interior/lower
	name = "Mara 17 - Lower Level"
	icon_state = "unknown"

/area/mara17/interior/lower/sec_checkpoint
	name = "Mara 17 - Lower Security Checkpoint"
	icon_state = "checkpoint"

/area/mara17/interior/lower/scaf_storage1
	name = "Mara 17 - SCAF Equipment Storage"
	icon_state = "storage"

/area/mara17/interior/lower/scaf_storage2
	name = "Mara 17 - SCAF Equipment Storage - Auxiliary Supplies Room"
	icon_state = "storage_wing"

/area/mara17/interior/lower/scaf_storage_hallway
	name = "Mara 17 - SCAF Equipment Storage Hallway"
	icon_state = "hall"

/area/mara17/interior/lower/aux_storage
	name = "Mara 17 - Auxiliary Storage"
	icon_state = "emergency_storage"

/area/mara17/interior/lower/tunnel
	name = "Mara 17 - Maintenance Tunnels"
	icon_state = "centralmaint"

/area/mara17/interior/lower/room1
	name = "Mara 17 - Abandoned Room 1"
	icon_state = "vacant_room"

/area/mara17/interior/lower/room2
	name = "Mara 17 - Abandoned Room 2"
	icon_state = "vacant_room"

/area/mara17/interior/lower/room3
	name = "Mara 17 - Abandoned Room 3"
	icon_state = "vacant_room"

/area/mara17/interior/lower/room4
	name = "Mara 17 - Abandoned Room 4"
	icon_state = "vacant_room"

/area/mara17/interior/lower/room5
	name = "Mara 17 - Abandoned Room 5"
	icon_state = "vacant_room"

/area/mara17/interior/lower/room6
	name = "Mara 17 - Abandoned Room 6"
	icon_state = "vacant_room"

/area/mara17/interior/lower/room7
	name = "Mara 17 - Abandoned Room 7"
	icon_state = "vacant_room"

/area/mara17/interior/lower/room8
	name = "Mara 17 - Abandoned Room 8"
	icon_state = "vacant_room"

/area/mara17/interior/lower/room9
	name = "Mara 17 - Abandoned Room 9"
	icon_state = "vacant_room"

/area/mara17/interior/lower/room10
	name = "Mara 17 - Abandoned Room 10"
	icon_state = "vacant_room"

/area/mara17/interior/lower/room11
	name = "Mara 17 - Abandoned Room 11"
	icon_state = "vacant_room"

/area/mara17/interior/lower/old_chapel
	name = "Mara 17 - Abandoned Chapel"
	icon_state = "chapel"

/area/mara17/interior/lower/old_bunker
	name = "Mara 17 - Unknown Bunker"
	icon_state = "vacant_room"




