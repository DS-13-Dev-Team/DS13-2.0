/mob/living/simple_animal/bot/mulebot/cargobot
	name = "Cargobot"
	desc = "A fourlegged durable, delivery bot."
	icon = 'deadspace/icons/mob/dsbots48x48.dmi'

/mob/living/simple_animal/bot/mulebot/cargobot/explode()
	var/atom/Tsec = drop_location()

	new /obj/item/wallframe/apc(Tsec)
	new /obj/item/bodypart/leg/right/robot(Tsec)
	new /obj/item/restraints/handcuffs/cable(Tsec)
	new /obj/item/electronics/apc(Tsec)
	return ..()
