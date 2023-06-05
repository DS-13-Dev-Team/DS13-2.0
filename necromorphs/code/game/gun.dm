/obj/item/gun
	var/wielded_icon_state = null

/obj/item/gun/proc/update_twohanding()
	/*var/obj/item/bodypart/other_hand = user.has_hand_for_held_index(user.get_inactive_hand_index()) //returns non-disabled inactive hands
	if(weapon_weight == WEAPON_HEAVY && (user.get_inactive_held_item() || !other_hand))
		src.inhand_icon_state += "_wielded"
		update_icon(src) // In case item_state is set somewhere else.
		*/
	update_appearance()

/obj/item/gun/dropped(mob/user, silent)
	src.inhand_icon_state = src.icon_state
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
	var/obj/item/bodypart/other_hand = user.has_hand_for_held_index(user.get_inactive_hand_index()) //returns non-disabled inactive hands
	//if((user.get_inactive_held_item() || !other_hand) && src.wielded_icon_state)
	if(weapon_weight == WEAPON_HEAVY)
		src.inhand_icon_state = src.wielded_icon_state
		update_appearance()
		//update_twohanding()
