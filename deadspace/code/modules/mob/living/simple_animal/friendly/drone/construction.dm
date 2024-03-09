/obj/item/bot_assembly/scavbot
	icon = 'deadspace/icons/mob/dsbots.dmi'
	name = "incomplete scavenger bot assembly"
	desc = "A frame with an arm attached to it."
	icon_state = "spiderbot_construction1"
	created_name = "Scavenger bot"

/obj/item/bot_assembly/scavbot/assembly_first_step(obj/item/W, mob/user)
    if(!istype(W, /obj/item/restraints/handcuffs/cable))
        return
    if(!user.temporarilyRemoveItemFromInventory(W))
        return
    to_chat(user,span_notice("You add the [W] to [src]!"))
    qdel(W)
    icon_state = "spiderbot_construction2"
    desc = "An incomplete scavenger bot assembly with wires."
    build_step++

/obj/item/bot_assembly/scavbot/assembly_second_step(obj/item/W, mob/user)
    if(!istype(W, /obj/item/electronics/apc))
        return
    if(!user.temporarilyRemoveItemFromInventory(W))
        return
    to_chat(user, span_notice("You add [W] to [src]."))
    qdel(W)
    name = "incomplete scavenger bot assembly"
    icon_state = "spiderbot_construction3"
    build_step++

/obj/item/bot_assembly/scavbot/assembly_third_step(obj/item/W, mob/user)
    if(W.tool_behaviour != TOOL_SCREWDRIVER)
        return
    to_chat(user, span_notice("You start screwing the pieces together..."))
    if(!W.use_tool(src, user, 40, volume=100))
        return
    var/obj/effect/mob_spawn/ghost_role/drone/scavbot/B = new(drop_location())
    B.name = created_name
    to_chat(user, span_notice("You completed the scavenger bot."))
    qdel(src)

/datum/crafting_recipe/scavbot
	name = "scavenger bot"
	result = /obj/effect/mob_spawn/ghost_role/drone/scavbot
	reqs = list(/obj/item/wallframe/apc = 1,
				/obj/item/bodypart/arm/right/robot = 1,
				/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/electronics/apc = 1)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 40
	category = CAT_ROBOT

/obj/item/wallframe/apc/attackby(obj/O, mob/user, params)
	if(istype(O, /obj/item/bodypart/arm/left/robot) || istype(O, /obj/item/bodypart/arm/right/robot))
		to_chat(user, span_notice("You add [O] to [src]."))
		qdel(O)
		qdel(src)
		user.put_in_hands(new /obj/item/bot_assembly/scavbot)
