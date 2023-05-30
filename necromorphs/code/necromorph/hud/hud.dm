//An actual HUD
/datum/hud/necromorph
	ui_style = 'icons/hud/screen_midnight.dmi'
	var/atom/movable/screen/meter/background/background
	var/atom/movable/screen/meter/health/health
	var/atom/movable/screen/meter/health/shield/shield
	var/atom/movable/screen/meter/foreground/foreground

/datum/hud/necromorph/New(mob/living/carbon/human/necromorph/owner)
	..()

//healthbar
	background = new

	health = new
	health.add_filter("alpha_mask", 1, alpha_mask_filter(icon = icon('necromorphs/icons/hud/healthbar.dmi', "alpha_mask"), x = clamp(HUD_METER_PIXEL_WIDTH*(owner.health/owner.maxHealth), 0, HUD_METER_PIXEL_WIDTH), flags = MASK_INVERSE))

	foreground = new
	if(owner.dodge_shield > 0)
		foreground.maptext = MAPTEXT("[max(0, owner.health)]+[owner.dodge_shield]/[owner.maxHealth]")
	else
		foreground.maptext = MAPTEXT("[max(0, owner.health)]/[owner.maxHealth]")

	shield = new
	shield.add_filter("alpha_mask", 1, alpha_mask_filter(icon = icon('necromorphs/icons/hud/healthbar.dmi', "alpha_mask"), x = clamp(HUD_METER_PIXEL_WIDTH*(owner.dodge_shield/owner.maxHealth), 0, HUD_METER_PIXEL_WIDTH), flags = MASK_INVERSE))

	infodisplay += background
	infodisplay += health
	infodisplay += shield
	infodisplay += foreground
//begin buttons
	var/atom/movable/screen/using

	using = new /atom/movable/screen/mov_intent
	using.icon = ui_style
	using.icon_state = (mymob.m_intent == MOVE_INTENT_RUN ? "running" : "walking")
	using.screen_loc = ui_movi
	using.hud = src
	static_inventory += using

	using = new/atom/movable/screen/language_menu
	using.icon = ui_style
	using.screen_loc = ui_alien_language_menu
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/navigate
	using.icon = ui_style
	using.screen_loc = ui_alien_navigate_menu
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/drop()
	using.icon = ui_style
	using.screen_loc = ui_drop_throw
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/resist()
	using.icon = ui_style
	using.screen_loc = ui_above_movement
	using.hud = src
	hotkeybuttons += using

	throw_icon = new /atom/movable/screen/throw_catch()
	throw_icon.icon = ui_style
	throw_icon.screen_loc = ui_drop_throw
	throw_icon.hud = src
	hotkeybuttons += throw_icon

	pull_icon = new /atom/movable/screen/pull()
	pull_icon.icon = ui_style
	pull_icon.update_appearance()
	pull_icon.screen_loc = ui_above_movement
	pull_icon.hud = src
	static_inventory += pull_icon

	zone_select = new /atom/movable/screen/zone_sel()
	zone_select.icon = ui_style
	zone_select.hud = src
	zone_select.update_appearance()
	static_inventory += zone_select

	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			inv.hud = src
			inv_slots[TOBITSHIFT(inv.slot_id) + 1] = inv
			inv.update_appearance()

/datum/hud/necromorph/Destroy()
	//They are actually deleted in QDEL_LIST(infodisplay)
	background = null
	health = null
	foreground = null
	return ..()

/datum/hud/necromorph/persistent_inventory_update()
	if(!mymob)
		return
	var/mob/living/carbon/human/necromorph/H = mymob
	if(hud_version != HUD_STYLE_NOHUD)
		for(var/obj/item/I in H.held_items)
			I.screen_loc = ui_hand_position(H.get_held_index_of_item(I))
			H.client.screen += I
	else
		for(var/obj/item/I in H.held_items)
			I.screen_loc = null
			H.client.screen -= I

/datum/hud/necromorph/proc/update_healthbar(mob/living/carbon/human/necromorph/necro)
	animate(health.get_filter("alpha_mask"), x = clamp(HUD_METER_PIXEL_WIDTH*(necro.health/necro.maxHealth), 0, HUD_METER_PIXEL_WIDTH), time = 0.5 SECONDS)
	if(necro.dodge_shield > 0)
		foreground.maptext = MAPTEXT("[max(0, necro.health)]+[necro.dodge_shield]/[necro.maxHealth]")
	else
		foreground.maptext = MAPTEXT("[max(0, necro.health)]/[necro.maxHealth]")

/datum/hud/necromorph/proc/update_shieldbar(mob/living/carbon/human/necromorph/necro)
	animate(shield.get_filter("alpha_mask"), x = clamp(HUD_METER_PIXEL_WIDTH*(necro.dodge_shield/necro.maxHealth), 0, HUD_METER_PIXEL_WIDTH), time = 0.5 SECONDS)
	if(necro.dodge_shield > 0)
		foreground.maptext = MAPTEXT("[max(0, necro.health)]+[necro.dodge_shield]/[necro.maxHealth]")
	else
		foreground.maptext = MAPTEXT("[max(0, necro.health)]/[necro.maxHealth]")
