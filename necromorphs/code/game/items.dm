/obj/item
	var/last_wield_update = null

/obj/item/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	var/obj/item/I = user.get_inactive_held_item()
	if(istype(I, /obj/item/gun))
		var/obj/item/gun/W = I
		/*if(W.wielded_icon_state)
			if(W.is_wielded)
				W.inhand_icon_state = W.icon_state
				W.is_wielded = FALSE
			else
				W.inhand_icon_state = W.wielded_icon_state
				W.is_wielded = TRUE*/
		W.update_twohanding(user, world.time, W.last_wield_update)
		W.last_wield_update = world.time
		update_appearance()
		to_chat(user, span_info("Equipped"))

/obj/item/dropped(mob/user, silent = FALSE)
	. = ..()
	var/obj/item/I = user.get_inactive_held_item()
	if(istype(I, /obj/item/gun))
		var/obj/item/gun/W = I
		/*if(W.wielded_icon_state)
			if(W.is_wielded)
				W.inhand_icon_state = W.icon_state
				W.is_wielded = FALSE
			else
				W.inhand_icon_state = W.wielded_icon_state
				W.is_wielded = TRUE*/
		W.update_twohanding(user, world.time, W.last_wield_update)
		W.last_wield_update = world.time
		update_appearance()
		to_chat(user, span_info("Dropped"))
