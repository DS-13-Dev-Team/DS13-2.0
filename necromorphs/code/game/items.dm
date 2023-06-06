/obj/item
	var/last_wield_update = null

/obj/item/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	var/obj/item/I = user.get_inactive_held_item()
	if(istype(I, /obj/item/gun))
		var/obj/item/gun/W = I
		W.update_twohanding(user, world.time, W.last_wield_update)
		W.last_wield_update = world.time
		update_appearance()

/obj/item/dropped(mob/user, silent = FALSE)
	var/obj/item/I = user.get_inactive_held_item()
	var/mob/M = user
	if(istype(I, /obj/item/gun))
		var/obj/item/gun/W = I
		W.update_twohanding(user, world.time, W.last_wield_update)
		W.last_wield_update = world.time
	M.update_held_items()
	..()
