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

///// ENGINIEERING /////

/area/mara17/interior/upper/enginieering
	name = "Iris Outpost - Enginieering"
	icon_state = "engie"

/area/mara17/interior/upper/enginieering/interior
	name = "Iris Outpost - Enginieering Bay"
	icon_state = "engi_lobby"

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

/area/mara17/interior/upper/mining/hallway
	name = "Iris Outpost - Mining Facility - South Hallway"
	icon_state = "mining_lobby"

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

///// CANTEEN /////

/area/mara17/interior/medium/canteen
	name = "Mara 17 Interior - Canteen"
	icon_state = "cafeteria"

/area/mara17/interior/medium/canteen/kitchen
	name = "Mara 17 Interior - Canteen Kitchen"
	icon_state = "kitchen"

/area/mara17/interior/medium/canteen/cold_room
	name = "Mara 17 Interior - Canteen Freezer Storage"
	icon_state = "kitchen_cold"

///// BAR /////

/area/mara17/interior/medium/bar
	name = "Mara 17 Interior - Bar"
	icon_state = "bar"

///// SMES ROOM /////

/area/mara17/interior/medium/smes
	name = "Mara 17 Interior - SMES Room"
	icon_state = "maint_electrical"

///// LOWER MINING /////

/area/mara17/interior/medium/mining/
	name = "Iris Outpost - Lower Mining Facility"
	icon_state = "mining_labor"

/area/mara17/interior/medium/mining/ore_storage
	name = "Iris Outpost - Lower Mining Facility - Ore Storage"
	icon_state = "mining_production"

///// COMMAND /////

/area/mara17/interior/medium/capt_office
	name = "Mara 17 Interior - Overseer Office"
	icon_state = "captain"

/area/mara17/interior/medium/capt_quarters
	name = "Mara 17 Interior - Overseer's Quarters"
	icon_state = "captain_private"

/area/mara17/interior/medium/capt_bathroom
	name = "Mara 17 Interior - Overseer's Bathroom"
	icon_state = "restrooms"

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

