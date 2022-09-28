/obj/structure/necromorph
	name = "necromorph sturcture"
	desc = "There is something scary in it."
	icon = 'necromorphs/icons/effects/corruption.dmi'
	anchored = TRUE
	max_integrity = 1
	resistance_flags = UNACIDABLE
	obj_flags = CAN_BE_HIT
	/// Weed below this structure, if it's dying then we are dying as well
	var/obj/structure/corruption/master

/obj/structure/necromorph/Initialize(mapload)
	.=..()
	master = locate(/obj/structure/corruption) in loc

/obj/structure/necromorph/play_attack_sound(damage_amount, damage_type, damage_flag)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/necromorph/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(damage_flag == MELEE)
		switch(damage_type)
			if(BRUTE)
				damage_amount *= 0.25
			if(BURN)
				damage_amount *= 2
	. = ..()
