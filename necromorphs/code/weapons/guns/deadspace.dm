/obj/item/gun/ballistic/deadspace
	actions_types = list(/datum/action/item_action/toggle_firemode)
	var/default_fire = "shoot"
	var/default_ammo = /obj/item/ammo_casing
	var/default_delay = 0
	var/alt_fire = null
	var/alt_fire_ammo = null
	var/alt_fire_delay = 0
	var/alt_fire_sound = null
	var/select = 1 ///fire selector position. 1 = semi, 2 = burst. anything past that can vary between guns.
	var/selector_switch_icon = FALSE ///if it has an icon for a selector switch indicating current firemode.

/obj/item/gun/ballistic/deadspace/twohanded
	var/wielded_icon_state = null
	var/wielded = FALSE
	var/can_fire_one_handed = TRUE
	var/one_handed_penalty = 20

/obj/item/gun/ballistic/deadspace/ui_action_click(mob/user, actiontype)
	if(istype(actiontype, /datum/action/item_action/toggle_firemode))
		alt_select()
	else
		..()

/obj/item/gun/ballistic/deadspace/proc/alt_select()
	var/mob/living/carbon/human/user = usr
	if(!select)
		var/obj/item/ammo_casing/new_ammo_type = default_ammo
		fire_delay = default_delay
		swap_ammo(new_ammo_type, magazine)
		to_chat(user, span_notice("You switch to [default_fire] mode."))
	else
		var/obj/item/ammo_casing/new_ammo_type = alt_fire_ammo
		fire_delay = alt_fire_delay
		swap_ammo(new_ammo_type, magazine)
		to_chat(user, span_notice("You switch to [alt_fire] mode."))

	select = !select
	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_appearance()
	update_action_buttons()

/obj/item/gun/ballistic/deadspace/proc/swap_ammo(var/obj/item/ammo_casing/new_round_type, var/obj/item/ammo_box/magazine/mag)
	chambered = null
	for(var/obj/item/ammo_casing/bullet in magazine.stored_ammo)
		magazine.stored_ammo -= bullet
		magazine.stored_ammo += new new_round_type(src)
	magazine.stored_ammo += new new_round_type(src)	//to compensate for the chambered round that we shadowrealmed
	chamber_round()

/obj/item/gun/ballistic/deadspace/twohanded/attack_self(mob/living/user)
	SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_SELF, user)

/// triggered on wield of two handed item
/obj/item/gun/ballistic/deadspace/twohanded/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/gun/ballistic/deadspace/twohanded/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = FALSE

/obj/item/gun/ballistic/deadspace/twohanded/update_icon_state()
	icon_state = base_icon_state
	return ..()

/obj/item/gun/ballistic/deadspace/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message = TRUE)
	if(!istype(AM, mag_type))
		to_chat(user, span_warning("[AM] doesn't seem to fit into [src]..."))
		return FALSE
	if(user.transferItemToLoc(AM, src))
		magazine = AM
		if (display_message)
			to_chat(user, span_notice("You load a new [magazine_wording] into [src]."))
		playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)
		if (bolt_type == BOLT_TYPE_OPEN && bolt_locked)
			bolt_locked = FALSE
		if (bolt_type == BOLT_TYPE_OPEN && !bolt_locked)
			chamber_round(TRUE)
		update_appearance()
		return TRUE
	else
		to_chat(user, span_warning("You cannot seem to get [src] out of your hands!"))
		return FALSE

/obj/item/gun/ballistic/deadspace/twohanded/on_autofire_start(mob/living/shooter)
	if(semicd || shooter.incapacitated() || !can_trigger_gun(shooter))
		return FALSE
	if(!can_shoot())
		shoot_with_empty_chamber(shooter)
		return FALSE
	if(!can_fire_one_handed && !wielded)
		to_chat(shooter, span_warning("You need two hands to fire \the [src]!"))
		return FALSE
	return TRUE

/obj/item/gun/ballistic/deadspace/twohanded/do_autofire_shot(datum/source, atom/target, mob/living/shooter, params)
	var/bonus_spread = 0
	if(can_fire_one_handed && !wielded)
		bonus_spread = one_handed_penalty
	process_fire(target, shooter, TRUE, params, null, bonus_spread)

/obj/item/gun/ballistic/deadspace/twohanded/fire_gun(atom/target, mob/living/user, flag, params)
	if(QDELETED(target))
		return
	if(firing_burst)
		return
	if(SEND_SIGNAL(src, COMSIG_GUN_TRY_FIRE, user, target, flag, params) & COMPONENT_CANCEL_GUN_FIRE)
		return
	if(flag) //It's adjacent, is the user, or is on the user's person
		if(target in user.contents) //can't shoot stuff inside us.
			return
		if(!ismob(target) || user.combat_mode) //melee attack
			return
		if(target == user && user.zone_selected != BODY_ZONE_PRECISE_MOUTH) //so we can't shoot ourselves (unless mouth selected)
			return

	if(istype(user))//Check if the user can use the gun, if the user isn't alive(turrets) assume it can.
		var/mob/living/L = user
		if(!can_trigger_gun(L))
			return

	if(flag)
		if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
			handle_suicide(user, target, params)
			return

	if(!can_shoot()) //Just because you can pull the trigger doesn't mean it can shoot.
		shoot_with_empty_chamber(user)
		return

	if(check_botched(user, target))
		return

	if(!can_fire_one_handed && !wielded)
		to_chat(user, span_warning("You need two hands to fire \the [src]"))
		return

	var/bonus_spread = 0
	if(can_fire_one_handed && !wielded)
		bonus_spread = one_handed_penalty

	return process_fire(target, user, TRUE, params, null, bonus_spread)


