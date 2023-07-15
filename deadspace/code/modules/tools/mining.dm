/obj/item/pickaxe/plasma
	name = "SH-B1 Plasma Saw"
	desc = "The SH-B1 Plasma Saw is designed for dissection of heavy duty materials in both on and off-site locations. Users are advised to always wear protective clothing when the saw is in use."
	icon = 'deadspace/icons/obj/tools/mining.dmi'
	icon_state = "plasma_saw_off"
	lefthand_file = 'deadspace/icons/mob/onmob/items/lefthand.dmi'
	righthand_file = 'deadspace/icons/mob/onmob/items/righthand.dmi'
	worn_icon = 'deadspace/icons/obj/clothing/belt_overlays.dmi'
	hitsound = 'sound/weapons/blade1.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	force = 2

	tool_behaviour = null
	toolspeed = null

/obj/item/pickaxe/plasma/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/transforming, \
		force_on = 15, \
		throwforce_on = 8, \
		hitsound_on = hitsound, \
		w_class_on = WEIGHT_CLASS_NORMAL, \
		clumsy_check = FALSE)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, .proc/on_transform)

/obj/item/pickaxe/plasma/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		tool_behaviour = TOOL_MINING
		sharpness = SHARP_EDGED
		toolspeed = 0.5
		icon_state = "plasma_saw_on"
	else
		icon_state = "plasma_saw_off"
		tool_behaviour = initial(tool_behaviour)
		toolspeed = initial(toolspeed)

	playsound(user ? user : src, active ? 'sound/weapons/saberon.ogg' : 'sound/weapons/saberoff.ogg', 5, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/plasma_modified
	name = "Modified Plasma Saw"
	desc = "This modified Plasma Saw is designed to cut through the strongest materials. Flesh and bone stands no chance."
	icon = 'deadspace/icons/obj/tools/mining.dmi'
	icon_state = "plasmasaw_off"
	lefthand_file = 'deadspace/icons/mob/onmob/items/lefthand.dmi'
	righthand_file = 'deadspace/icons/mob/onmob/items/righthand.dmi'
	flags_1 = CONDUCT_1
	force = 1
	var/force_on = 24
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 13
	throw_speed = 2
	throw_range = 4
	custom_materials = list(/datum/material/iron=13000)
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	sharpness = SHARP_EDGED
	actions_types = list(/datum/action/item_action/startplasma_modified)
	tool_behaviour = TOOL_SAW
	toolspeed = 0.5
	var/on = FALSE
	var/wielded = FALSE // track wielded status on item

/obj/item/plasma_modified/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))

	AddComponent(/datum/component/butchering, 30, 100, 0, 'sound/weapons/blade1.ogg', TRUE)
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)

/// triggered on wield of two handed item
/obj/item/plasma_modified/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/plasma_modified/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = FALSE

/obj/item/plasma_modified/suicide_act(mob/living/carbon/user)
	if(on)
		user.visible_message(span_suicide("[user] begins to tear [user.p_their()] head off with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
		playsound(src, 'sound/weapons/blade1.ogg', 100, TRUE)
		var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)
		if(myhead)
			myhead.dismember()
	else
		user.visible_message(span_suicide("[user] smashes [src] into [user.p_their()] neck, destroying [user.p_their()] esophagus! It looks like [user.p_theyre()] trying to commit suicide!"))
		playsound(src, 'sound/weapons/genhit1.ogg', 100, TRUE)
	return(BRUTELOSS)

/obj/item/plasma_modified/attack_self(mob/user)
	on = !on
	to_chat(user, "As you press the power button from [src], [on ? "it begins to whirr." : "the energy retracts."]")
	force = on ? force_on : initial(force)
	throwforce = on ? force_on : initial(force)
	icon_state = "plasmasaw_[on ? "on" : "off"]"
	var/datum/component/butchering/butchering = src.GetComponent(/datum/component/butchering)
	butchering.butchering_enabled = on

	if(on)
		hitsound = 'sound/weapons/blade1.ogg'
	else
		hitsound = SFX_SWING_HIT

	if(src == user.get_active_held_item()) //update inhands
		user.update_held_items()
	update_action_buttons()

/datum/action/item_action/startplasma_modified
	name = "Press the power button"

/obj/item/pickaxe/rock
	name = "Rock saw"
	desc = "An energised mining tool for surveying and retrieval of objects embedded in otherwise dense material. Very dangerous, will cut through flesh and bone with ease."
	icon = 'deadspace/icons/obj/tools/mining.dmi'
	icon_state = "rocksaw_off"
	lefthand_file = 'deadspace/icons/mob/onmob/items/lefthand.dmi'
	righthand_file = 'deadspace/icons/mob/onmob/items/righthand.dmi'
	worn_icon = 'deadspace/icons/obj/clothing/belt_overlays.dmi'
	hitsound = 'sound/weapons/blade1.ogg'
	slot_flags = ITEM_SLOT_POCKETS | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	force = 2
	custom_materials = list(/datum/material/iron=1000)
	attack_verb_continuous = list("hits", "pierces", "slices", "attacks")
	attack_verb_simple = list("hit", "pierce", "slice", "attack")

	tool_behaviour = null
	toolspeed = null

/obj/item/pickaxe/rock/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/transforming, \
		force_on = 15, \
		throwforce_on = 8, \
		hitsound_on = hitsound, \
		w_class_on = WEIGHT_CLASS_NORMAL, \
		clumsy_check = FALSE)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, .proc/on_transform)

/obj/item/pickaxe/rock/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		tool_behaviour = TOOL_MINING
		sharpness = SHARP_EDGED
		toolspeed = 0.5
		icon_state = "rocksaw_on"
	else
		icon_state = "rocksaw_off"
		tool_behaviour = initial(tool_behaviour)
		toolspeed = initial(toolspeed)

	playsound(user ? user : src, active ? 'sound/weapons/saberon.ogg' : 'sound/weapons/saberoff.ogg', 5, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE
