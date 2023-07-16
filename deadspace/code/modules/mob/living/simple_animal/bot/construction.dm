/obj/item/bot_assembly/attackby(obj/item/W, mob/user, params)
    ..()
    switch(build_step)
        if(ASSEMBLY_FIRST_STEP)
            assembly_first_step(W, user)

        if(ASSEMBLY_SECOND_STEP)
            assembly_second_step(W, user)

        if(ASSEMBLY_THIRD_STEP)
            assembly_third_step(W, user)

/obj/item/bot_assembly/proc/assembly_first_step(obj/item/W, mob/user)
    return

/obj/item/bot_assembly/proc/assembly_second_step(obj/item/W, mob/user)
    return

/obj/item/bot_assembly/proc/assembly_third_step(obj/item/W, mob/user)
    return

//janibot
/obj/item/bot_assembly/janibot
	icon = 'deadspace/icons/mob/dsbots.dmi'
	name = "incomplete janibot assembly"
	desc = "It's a frame with a sensor attached."
	icon_state = "cleanbot_construction1"
	created_name = "Janibot"

/obj/item/bot_assembly/janibot/assembly_first_step(obj/item/W, mob/user)
    if(!istype(W, /obj/item/restraints/handcuffs/cable))
        return
    if(!user.temporarilyRemoveItemFromInventory(W))
        return
    to_chat(user,span_notice("You add the [W] to [src]!"))
    qdel(W)
    icon_state = "cleanbot_construction2"
    desc = "An incomplete janibot assembly with wires."
    build_step++

/obj/item/bot_assembly/janibot/assembly_second_step(obj/item/W, mob/user)
    if(!istype(W, /obj/item/electronics/apc))
        return
    if(!user.temporarilyRemoveItemFromInventory(W))
        return
    to_chat(user, span_notice("You add [W] to [src]."))
    qdel(W)
    name = "incomplete janibot assembly"
    icon_state = "cleanbot_construction3"
    build_step++

/obj/item/bot_assembly/janibot/assembly_third_step(obj/item/W, mob/user)
    if(W.tool_behaviour != TOOL_SCREWDRIVER)
        return
    to_chat(user, span_notice("You start screwing the pieces together..."))
    if(!W.use_tool(src, user, 40, volume=100))
        return
    var/mob/living/simple_animal/bot/cleanbot/janibot/B = new(drop_location())
    B.name = created_name
    to_chat(user, span_notice("You completed the janibot."))
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

/obj/item/bot_assembly/cargobot/assembly_first_step(obj/item/W, mob/user)
    if(!istype(W, /obj/item/restraints/handcuffs/cable))
        return
    if(!user.temporarilyRemoveItemFromInventory(W))
        return
    to_chat(user,span_notice("You add the [W] to [src]!"))
    qdel(W)
    icon_state = "cargobot_construction2"
    desc = "An incomplete cargobot assembly with wires."
    build_step++

/obj/item/bot_assembly/scavbot/assembly_second_step(obj/item/W, mob/user)
    if(!istype(W, /obj/item/electronics/apc))
        return
    if(!user.temporarilyRemoveItemFromInventory(W))
        return
    to_chat(user, span_notice("You add [W] to [src]."))
    qdel(W)
    name = "incomplete cargobot assembly"
    icon_state = "cargobot_construction3"
    build_step++

/obj/item/bot_assembly/cargobot/assembly_third_step(obj/item/W, mob/user)
    if(W.tool_behaviour != TOOL_SCREWDRIVER)
        return
    to_chat(user, span_notice("You start screwing the pieces together..."))
    if(!W.use_tool(src, user, 40, volume=100))
        return
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
