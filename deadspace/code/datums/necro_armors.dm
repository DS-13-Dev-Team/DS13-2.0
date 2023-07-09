#define ARMORID "necro_armor-[armor_front]-[armor_flank]-[armor_back]-[curl_armor_mult]-[armor_protection]"
/proc/getNecroArmor(armor_front = 0, armor_flank = 0, armor_back = 0, curl_armor_mult = 1, armor_protection = 0)
	. = locate(ARMORID)
	if (!.)
		. = new /datum/necro_armor(armor_front, armor_flank, armor_back, curl_armor_mult, armor_protection)

/datum/necro_armor
	datum_flags = DF_USE_TAG
	var/armor_front = 0			//Flat reduction applied to incoming damage within a x degree cone infront
	var/armor_flank = 0			//Flat reduction applied to incoming damage within a x degree cone infront. Doesnt stack with front
	var/armor_back = 0			//Flat reduction appliet to incoming damage within a x degree cone back. Doesnt stack with other sides
	var/curl_armor_mult = 1		//Multiplier applied to armor when we are curled up
	var/armor_protection = 0    //How much you can take damage with full armor

/datum/necro_armor/New(armor_front = 0, armor_flank = 0, armor_back = 0, curl_armor_mult = 1, armor_protection = 0)
	src.armor_front = armor_front
	src.armor_flank = armor_flank
	src.armor_back = armor_back
	src.curl_armor_mult = curl_armor_mult
	src.armor_protection = armor_protection
	tag = ARMORID

/datum/necro_armor/proc/get_dir_armor(attack_direction, mob_direction)
	switch(attack_direction)
		if(NORTH)
			switch(mob_direction)
				if(NORTH)
					return armor_back
				if(SOUTH)
					return armor_front
				if(WEST)
					return armor_flank
				if(EAST)
					return armor_flank
		if(NORTHWEST)
			switch(mob_direction)
				if(NORTH)
					return round((armor_back+armor_flank)/2)
				if(SOUTH)
					return round((armor_front+armor_flank)/2)
				if(WEST)
					return round((armor_back+armor_flank)/2)
				if(EAST)
					return round((armor_front+armor_flank)/2)
		if(NORTHEAST)
			switch(mob_direction)
				if(NORTH)
					return round((armor_back+armor_flank)/2)
				if(SOUTH)
					return round((armor_front+armor_flank)/2)
				if(WEST)
					return round((armor_front+armor_flank)/2)
				if(EAST)
					return round((armor_back+armor_flank)/2)
		if(SOUTH)
			switch(mob_direction)
				if(NORTH)
					return armor_front
				if(SOUTH)
					return armor_back
				if(WEST)
					return armor_flank
				if(EAST)
					return armor_flank
		if(SOUTHEAST)
			switch(mob_direction)
				if(NORTH)
					return round((armor_front+armor_flank)/2)
				if(SOUTH)
					return round((armor_back+armor_flank)/2)
				if(WEST)
					return round((armor_front+armor_flank)/2)
				if(EAST)
					return round((armor_back+armor_flank)/2)
		if(SOUTHWEST)
			switch(mob_direction)
				if(NORTH)
					return round((armor_front+armor_flank)/2)
				if(SOUTH)
					return round((armor_back+armor_flank)/2)
				if(WEST)
					return round((armor_back+armor_flank)/2)
				if(EAST)
					return round((armor_front+armor_flank)/2)
		if(WEST)
			switch(mob_direction)
				if(NORTH)
					return armor_flank
				if(SOUTH)
					return armor_flank
				if(WEST)
					return armor_back
				if(EAST)
					return armor_front
		if(EAST)
			switch(mob_direction)
				if(NORTH)
					return armor_flank
				if(SOUTH)
					return armor_flank
				if(WEST)
					return armor_front
				if(EAST)
					return armor_back

/datum/necro_armor/proc/getRating(rating)
	return vars[rating]

/datum/necro_armor/vv_edit_var(var_name, var_value)
	if (var_name == NAMEOF(src, tag))
		return FALSE
	. = ..()
	tag = ARMORID

#undef ARMORID
