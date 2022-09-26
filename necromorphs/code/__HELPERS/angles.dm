GLOBAL_LIST_INIT(dir_angles, list(
		"[NORTH]" = 0,
		"[NORTHEAST]" = 45,
		"[EAST]" = 90,
		"[SOUTHEAST]" = 135,
		"[SOUTH]" = 180,
		"[SOUTHWEST]" = 225,
		"[WEST]" = 270,
		"[NORTHWEST]" = 315))

#define DIR2ANGLE(dir) GLOB.dir_angles[#dir]
