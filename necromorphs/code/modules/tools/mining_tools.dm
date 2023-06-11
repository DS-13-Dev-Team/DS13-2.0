/obj/item/circular_saw/plasma
	name = "SH-B1 Plasma Saw"
	desc = "The SH-B1 Plasma Saw is designed for dissection of heavy duty materials in both on and off-site locations. Users are advised to always wear protective clothing when the saw is in use."
	icon = 'necromorphs/icons/obj/tools/mining.dmi'
	icon_state = "plasma_saw_off"
	lefthand_file = 'necromorphs/icons/mob/onmob/items/lefthand.dmi'
	righthand_file = 'necromorphs/icons/mob/onmob/items/righthand.dmi'
	worn_icon = 'necromorphs/icons/obj/clothing/belt_overlays.dmi'
	hitsound = 'sound/weapons/circsawhit.ogg'
	slot_flags = ITEM_SLOT_BELT
	force = 2

	tool_behaviour = null
	toolspeed = null

/obj/item/circular_saw/plasma/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/transforming, \
		force_on = 15, \
		throwforce_on = 8, \
		hitsound_on = hitsound, \
		w_class_on = WEIGHT_CLASS_NORMAL, \
		clumsy_check = FALSE)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, .proc/on_transform)

/obj/item/circular_saw/plasma/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		tool_behaviour = TOOL_MINING
		sharpness = SHARP_EDGED
		toolspeed = 1
		icon_state = "plasma_saw_on"
	else
		icon_state = "plasma_saw_off"
		tool_behaviour = initial(tool_behaviour)
		toolspeed = initial(toolspeed)

	playsound(user ? user : src, active ? 'sound/weapons/saberon.ogg' : 'sound/weapons/saberoff.ogg', 5, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/pickaxe/laser
	name = "rock saw"
	desc = "An energised mining tool for surveying and retrieval of objects embedded in otherwise dense material. Very dangerous, will cut through flesh and bone with ease."
	icon = 'necromorphs/icons/obj/tools/mining.dmi'
	icon_state = "ds_rocksaw0"
	lefthand_file = 'necromorphs/icons/mob/onmob/items/lefthand.dmi'
	righthand_file = 'necromorphs/icons/mob/onmob/items/righthand.dmi'
	worn_icon = 'necromorphs/icons/obj/clothing/belt_overlays.dmi'
	mob_throw_hit_sound = 'sound/weapons/pierce.ogg'
	force = 2
	custom_materials = list(/datum/material/iron=1000)
	attack_verb_continuous = list("hits", "pierces", "slices", "attacks")
	attack_verb_simple = list("hit", "pierce", "slice", "attack")

	tool_behaviour = null
	toolspeed = null

/obj/item/pickaxe/laser/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/transforming, \
		force_on = 15, \
		throwforce_on = 8, \
		hitsound_on = hitsound, \
		w_class_on = WEIGHT_CLASS_NORMAL, \
		clumsy_check = FALSE)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, .proc/on_transform)

/obj/item/pickaxe/laser/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		tool_behaviour = TOOL_MINING
		sharpness = SHARP_EDGED
		toolspeed = 0.3
		icon_state = "ds_rocksaw1"
	else
		icon_state = "ds_rocksaw0"
		tool_behaviour = initial(tool_behaviour)
		toolspeed = initial(toolspeed)

	playsound(user ? user : src, active ? 'sound/weapons/saberon.ogg' : 'sound/weapons/saberoff.ogg', 5, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE
