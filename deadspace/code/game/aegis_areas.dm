/area/aegis/surface
	name = "Aegis Surface"
	icon = 'icons/area/areas_ruins.dmi'
	icon_state = "os_beta_mining"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = TRUE
	requires_power = TRUE
	ambience_index = AMBIENCE_MINING
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED | NO_ALERTS
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS
	outdoors = TRUE

/area/aegis/mining
	name = "\improper Mining Outpost"
	icon = 'icons/area/areas_ruins.dmi'
	icon_state = "ruins"
	has_gravity = STANDARD_GRAVITY
	area_flags = HIDDEN_AREA | BLOBS_ALLOWED | UNIQUE_AREA | NO_ALERTS
	static_lighting = TRUE
	ambience_index = AMBIENCE_RUINS
	flags_1 = CAN_BE_DIRTY_1
	sound_environment = SOUND_ENVIRONMENT_STONEROOM
	requires_power = FALSE

/area/aegis/telecomms
	name = "\improper Unexplored Location"
	icon = 'icons/area/areas_ruins.dmi'
	icon_state = "ruins"
	has_gravity = STANDARD_GRAVITY
	area_flags = HIDDEN_AREA | BLOBS_ALLOWED | UNIQUE_AREA | NO_ALERTS
	static_lighting = TRUE
	ambience_index = AMBIENCE_RUINS
	flags_1 = CAN_BE_DIRTY_1
	sound_environment = SOUND_ENVIRONMENT_STONEROOM
	requires_power = FALSE

/area/aegis/telecomms/high
	name = "\improper Unexplored Location"

/area/aegis/hanger
	name = "\improper Hanger Outpost"
	icon = 'icons/area/areas_ruins.dmi'
	icon_state = "ruins"
	has_gravity = STANDARD_GRAVITY
	area_flags = HIDDEN_AREA | BLOBS_ALLOWED | UNIQUE_AREA | NO_ALERTS
	static_lighting = TRUE
	ambience_index = AMBIENCE_RUINS
	flags_1 = CAN_BE_DIRTY_1
	sound_environment = SOUND_ENVIRONMENT_STONEROOM
	requires_power = FALSE
