/*
	Helpers
*/
/mob/proc/get_active_or_available_arm(messages = TRUE)
	var/num_arms = 0
	var/selected_arm
	//Alright lets check our arm status first
	var/obj/item/bodypart/arm/left = src:get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/arm/right = src:get_bodypart(BODY_ZONE_R_ARM)

	if (QDELETED(left))
		left = null
	else
		num_arms++

	if (QDELETED(right))
		right = null
	else
		num_arms++

	if (num_arms <= 0)
		if (messages)
			to_chat(src, span_danger("You have no arms to swing!"))
		return

	else if (num_arms == 1)
		if (left)
			selected_arm = BODY_ZONE_L_ARM
		else
			selected_arm = BODY_ZONE_R_ARM
	else
		//If we have both arms, then the user gets to choose which to swing based on their selected hand
		var/obj/item/bodypart/arm = get_active_hand()
		selected_arm = arm.body_zone


	return selected_arm


/mob/proc/get_swing_dir()
	var/selected_arm = get_active_or_available_arm()
	if (selected_arm == BODY_ZONE_L_ARM)
		return CLOCKWISE
	else
		return ANTICLOCKWISE
