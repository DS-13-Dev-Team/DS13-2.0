/mob/living/simple_animal/bot/cleanbot/janibot
	name = "Janibot"
	desc = "A little cleaning robot, he looks so excited!"
	icon = 'deadspace/icons/mob/animal.dmi'
	held_lh = 'deadspace/icons/mob/pets_held_lh.dmi'
	held_rh = 'deadspace/icons/mob/pets_held_rh.dmi'
	held_state = "cleanbot"
	held_type = /obj/item/mob_holder/janibot
	mob_size = MOB_SIZE_SMALL

/mob/living/simple_animal/bot/cleanbot/janibot/explode()
	var/atom/Tsec = drop_location()
	new /obj/item/wallframe/apc(Tsec)
	new /obj/item/restraints/handcuffs/cable(Tsec)
	new /obj/item/electronics/apc(Tsec)
	return ..()
