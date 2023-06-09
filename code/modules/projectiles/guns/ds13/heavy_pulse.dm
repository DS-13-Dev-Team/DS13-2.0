/*
	The heavy pulse rifle has infinite ammo, and is cooldown based instead
*/

/obj/item/gun/energy/pulse_heavy
	name = "Heavy Pulse Rifle"
	desc = "A colossal weapon capable of firing infinitely, but requiring a significant cooldown period. " //It is optimised for continuous fire, and will overheat more quickly if used in bursts."It is optimised for continuous fire, and will overheat more quickly if used in bursts."
	icon = 'icons/obj/guns_ds13/guns48x32.dmi'
	icon_state = "heavypulserifle"
	lefthand_file = 'necromorphs/icons/mob/inhands/guns/guns_left.dmi'
	righthand_file = 'necromorphs/icons/mob/inhands/guns/guns_right.dmi'
	inhand_icon_state = "heavypulserifle-wielded"
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = null
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	weapon_weight = WEAPON_HEAVY
	// one_hand_penalty = 10	//Don't try to fire this with one hand
	// accuracy = 17
	spread = 10
	ammo_type = list(/obj/item/ammo_casing/energy/pulserifle)
	cell_type = /obj/item/stock_parts/cell/high
	item_flags = SLOWS_WHILE_IN_HAND
	can_charge = FALSE
	selfcharge = 1
	charge_delay = 1
	fire_sound = 'sound/ds13/pulse_shot.ogg' //Test sound
	// screen_shake = 0.1 //This needs to be small or people will get seizures.
	// empty_sound = 'sound/weapons/guns/misc/overheat.ogg'
	// empty_alarm_sound  = ^^above
	// aiming_modes = list(/datum/extension/aim_mode/rifle)

/obj/item/gun/energy/pulse_heavy/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.1 SECONDS)

/obj/item/gun/energy/pulse_heavy/test //Temporary
	charge_delay = 0.1
	ammo_type = list(/obj/item/ammo_casing/energy/pulserifle/test)

/**
Ammo casing
*/

/obj/item/ammo_casing/energy/pulserifle
	name = "pulse round"
	desc = "A ultra-small caliber round designed for the SWS Motorized Pulse Rifle."
	icon_state = "ionshell-live"
	projectile_type = /obj/projectile/bullet/pulse //pulse
	// caliber = CALIBER_PULSE
	slot_flags = null
	e_cost = 50 //The amount of energy a cell needs to expend to create this shot.
	fire_sound = 'sound/ds13/pulse_shot.ogg'
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/energy
	heavy_metal = FALSE
	randomspread = 25
	// select_name = "kill"

/obj/item/ammo_casing/energy/pulserifle/test
	select_name = "Amongus"
	randomspread = 40
