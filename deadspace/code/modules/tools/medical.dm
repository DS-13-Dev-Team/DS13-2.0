/obj/item/circular_saw/bonecutter
	name = "Bone Cutter"
	desc = "The Bone Cutter is designed for cutting bone or precisely cutting limbs for inspection. Users are advised caution when the cutter is in use."
	icon = 'deadspace/icons/obj/tools/medical.dmi'
	icon_state = "bonecutter_off"
	lefthand_file = 'deadspace/icons/mob/onmob/items/lefthand.dmi'
	righthand_file = 'deadspace/icons/mob/onmob/items/righthand.dmi'
	worn_icon = 'deadspace/icons/obj/clothing/belt_overlays.dmi'
	hitsound = 'sound/weapons/blade1.ogg'
	slot_flags = ITEM_SLOT_POCKETS | ITEM_SLOT_BELT
	force = 2
	block_chance = 0 //handled in on_transform
	tool_behaviour = null
	toolspeed = null

/obj/item/circular_saw/bonecutter/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/transforming, \
		force_on = 18, \
		throwforce_on = 8, \
		hitsound_on = hitsound, \
		w_class_on = WEIGHT_CLASS_NORMAL, \
		clumsy_check = FALSE)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/circular_saw/bonecutter/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		tool_behaviour = TOOL_SAW
		sharpness = SHARP_EDGED
		block_chance = 20
		toolspeed = 1
		icon_state = "bonecutter_on"
	else
		icon_state = "bonecutter_off"
		tool_behaviour = initial(tool_behaviour)
		toolspeed = initial(toolspeed)
		block_chance = initial(block_chance)

	playsound(user ? user : src, active ? 'sound/weapons/saberon.ogg' : 'sound/weapons/saberoff.ogg', 5, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE
