//Special necro interactions for objects should go here

//Ladders
/obj/structure/ladder/attack_necromorph(mob/living/carbon/alien/humanoid/user, list/modifiers)
	return use(user)

//Closets
/obj/structure/closet/attack_necromorph(mob/living/carbon/alien/humanoid/user, list/modifiers)
	if(!user.combat_mode)
		return attack_hand(user, modifiers) //Try to open a locker
	else
		return ..() //If we're in combat mode, just start attacking the locker

//Basic items
/obj/item/attack_necromorph(mob/living/carbon/alien/humanoid/user, list/modifiers)
	return //Necros aren't be allowed to interact with items, with some exceptions

//Airlocks
/obj/machinery/door/airlock/attack_necromorph(mob/living/carbon/alien/humanoid/user, list/modifiers)
	if(isElectrified() && shock(user, 100))
		add_fingerprint(user)
		return
	if(!density)
		return try_to_activate_door(user) //Try to close the door
	if(!locked || !welded || !seal || hasPower())
		if(!user.combat_mode)
			return try_to_activate_door(user) //Try to open the door
	if(locked || welded || seal)
		if(user.combat_mode)
			return ..() //Angry necro smash locked door
		to_chat(user, span_warning("[src] refuses to budge!"))
		return
	add_fingerprint(user)
	user.visible_message(span_warning("[user] begins prying open [src]."),\
						span_warning("You begin prying open [src] with all your might!"),\
						span_warning("You hear groaning metal..."))
	var/time_to_open = 0.5 SECONDS
	if(hasPower())
		//Powered airlocks take longer to open, and are loud.
		time_to_open = 5 SECONDS
		playsound(src, 'sound/machines/airlock_alien_prying.ogg', 100, TRUE)

	if(do_after(user, src, time_to_open))
		//The airlock is still closed, but something prevented it opening. (Another player noticed and bolted/welded the airlock in time!)
		if(density && !open(2))
			to_chat(user, span_warning("Despite your efforts, [src] managed to resist your attempts to open it!"))
		else
			atom_break()
			playsound(src, 'sound/machines/airlock_tear_open.ogg', 50, TRUE)
