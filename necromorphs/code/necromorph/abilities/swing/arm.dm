/*
	Arm Swing
	A subtype designed for humanoid creatures which have two arms, and use one of them to swing
*/
/datum/component/swing/arm
	var/left = /obj/effect/temp_visual/swing
	var/right = /obj/effect/temp_visual/swing
	var/limb_used
	var/list/offsets_left = list(S_NORTH = new /datum/position(-4, 12), S_SOUTH = new /datum/position(8, 8), S_EAST = new /datum/position(14, 2), S_WEST = new /datum/position(8, 6))
	var/list/offsets_right = list(S_NORTH = new /datum/position(12, 12), S_SOUTH = new /datum/position(-8, 6), S_EAST = new /datum/position(-2, 4), S_WEST = new /datum/position(-6, 6))



/datum/component/swing/arm/Initialize(atom/target)
	if (ismob(parent))
		var/mob/M = parent
		swing_direction = M.get_swing_dir()

		switch(swing_direction)
			if (CLOCKWISE)
				visual_type = left
			if (ANTICLOCKWISE)
				visual_type = right

	. = ..()


/datum/component/swing/arm/windup_animation()
	. = ..()
	switch (swing_direction)
		//Cache the limb used
		if (CLOCKWISE)
			limb_used = BODY_ZONE_L_ARM
		else
			limb_used = BODY_ZONE_R_ARM

	var/mob/living/carbon/human/H = parent
	//We will temporarily retract the arm from the sprite
	var/obj/item/bodypart/E = H.get_bodypart(limb_used)
	if (E)
		H.update_body(TRUE)




/datum/component/swing/arm/setup_effect(turf/our_loc)
	. = ..()

	//The parent code will move the effect object to the centre of our sprite, now we will offset it farther to the appropriate shoulder joint
	var/datum/position/offset
	if (limb_used == BODY_ZONE_L_ARM)
		offset = offsets_left["[parent:dir]"]
	else
		offset = offsets_right["[parent:dir]"]

	visual_effect.pixel_x += offset.x
	visual_effect.pixel_y += offset.y


/datum/component/swing/arm/cleanup_effect()
	.=..()
	var/mob/living/carbon/human/H = parent

	//Put the arm back now
	var/obj/item/bodypart/E = H.get_bodypart(limb_used)
	if (E)
		H.update_body(TRUE)
