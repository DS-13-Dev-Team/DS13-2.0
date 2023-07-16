// janitbot

/obj/item/bot_assembly/janibot
	icon = 'deadspace/icons/mob/animal.dmi'
	name = "incomplete janibot assembly"
	desc = "It's a frame with a sensor attached."
	icon_state = "cleanbot_construction1"
	created_name = "Janibot"

/obj/item/bot_assembly/janibot/attackby(obj/item/W, mob/user, params)
	..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(istype(W, /obj/item/restraints/handcuffs/cable))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				to_chat(user,span_notice("You add the [W] to [src]!"))
				qdel(W)
				icon_state = "cleanbot_construction2"
				desc = "An incomplete janibot assembly with wires."
				build_step++

		if(ASSEMBLY_SECOND_STEP)
			if(istype(W, /obj/item/electronics/apc))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				to_chat(user, span_notice("You add [W] to [src]."))
				qdel(W)
				name = "incomplete janibot assembly"
				icon_state = "cleanbot_construction3"
				build_step++

		if(ASSEMBLY_THIRD_STEP)
			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, span_notice("You start screwing the pieces together..."))
				if(W.use_tool(src, user, 40, volume=100))
					var/mob/living/simple_animal/bot/cleanbot/janibot/B = new(drop_location())
					B.name = created_name
					to_chat(user, span_notice("You completed the Janibot."))
					qdel(src)

/datum/crafting_recipe/janibot
	name = "Janibot"
	result = /mob/living/simple_animal/bot/cleanbot/janibot
	reqs = list(/obj/item/wallframe/apc = 1,
				/obj/item/assembly/prox_sensor = 1,
				/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/electronics/apc = 1)
	time = 40
	category = CAT_ROBOT

// cargobot

/obj/item/bot_assembly/cargobot
	icon = 'deadspace/icons/mob/dsbots48x48.dmi'
	name = "incomplete cargobot assembly"
	desc = "A frame with an leg attached to it."
	icon_state = "cargobot_construction1"
	created_name = "Cargobot"

/obj/item/bot_assembly/cargobot/attackby(obj/item/W, mob/user, params)
	..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(istype(W, /obj/item/restraints/handcuffs/cable))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				to_chat(user,span_notice("You add the [W] to [src]!"))
				qdel(W)
				icon_state = "cargobot_construction2"
				desc = "An incomplete cargobot assembly with wires."
				build_step++

		if(ASSEMBLY_SECOND_STEP)
			if(istype(W, /obj/item/electronics/apc))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				to_chat(user, span_notice("You add [W] to [src]."))
				qdel(W)
				name = "incomplete cargobot assembly"
				icon_state = "cargobot_construction3"
				build_step++

		if(ASSEMBLY_THIRD_STEP)
			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, span_notice("You start screwing the pieces together..."))
				if(W.use_tool(src, user, 40, volume=100))
					var/mob/living/simple_animal/bot/mulebot/cargobot/B = new(drop_location())
					B.name = created_name
					to_chat(user, span_notice("You completed the cargobot."))
					qdel(src)


/datum/crafting_recipe/cargobot
	name = "Cargobot"
	result = /mob/living/simple_animal/bot/mulebot/cargobot
	reqs = list(/obj/item/wallframe/apc = 1,
				/obj/item/bodypart/leg/right/robot = 1,
				/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/electronics/apc = 1)
	time = 40
	category = CAT_ROBOT
