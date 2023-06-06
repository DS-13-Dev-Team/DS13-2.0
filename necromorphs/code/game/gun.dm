/obj/item/gun
	var/wielded_icon_state = null
	var/is_wielded = FALSE

/obj/item/gun/proc/update_twohanding(mob/user, var/current_time, var/last_call)
	var/update_cooldown = 1 //picking up an item from your pocket calls both dropped() and equipped() for some reason so we a cooldown to mitigate it
	if(current_time - last_call <= update_cooldown)
		to_chat(user, span_info("Update fail"))
		return
	if(wielded_icon_state)
		if(is_wielded)
			inhand_icon_state = icon_state
			is_wielded = FALSE
		else
			inhand_icon_state = wielded_icon_state
			is_wielded = TRUE
	to_chat(user, span_info("Update"))

/obj/item/gun/dropped(mob/user, silent)
	src.inhand_icon_state = src.icon_state
	src.is_wielded = FALSE
	update_appearance()
	//update_twohanding()
	/*if(user)
		if(user.l_hand)
			user.l_hand.update_twohanding()
		if(user.r_hand)
			user.r_hand.update_twohanding()*/

	..()

/obj/item/gun/equipped(mob/user, slot)
	. = ..()
	var/mob/M = loc
	if(!istype(M))
		return
	//var/obj/item/bodypart/other_hand = user.has_hand_for_held_index(user.get_inactive_hand_index()) //returns non-disabled inactive hands
	//if((user.get_inactive_held_item() || !other_hand) && src.wielded_icon_state)
	if(!user.get_inactive_held_item() && src.wielded_icon_state)
		src.inhand_icon_state = src.wielded_icon_state
		src.is_wielded = TRUE
		update_appearance()
		//update_twohanding()
