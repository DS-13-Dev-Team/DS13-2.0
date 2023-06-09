/**
DS SCL Shotgun
*/

/obj/item/gun/ballistic/shotgun/scl_shotgun //Has no bola mode yet
	name = "\improper SCL Shotgun"
	desc = "The SCL Shotgun is a close to medium-ranged weapon developed by the Sovereign Colonies Armed Forces and utilized by SCAF Legionaries. \
	The shotgun has remained in use in private security and police departments as a riot-control tool, given its ability to fire incapacitating shells for capture and arrest, or lethal slugs in life-threatening situations. \
	The SCL Shotgun is magazine loaded and is effective at short range or for fugitive capture."
	icon = 'icons/obj/guns_ds13/guns48x32.dmi'
	icon_state = "scl_shotgun"
	lefthand_file = 'necromorphs/icons/mob/inhands/guns/guns_left.dmi'
	righthand_file = 'necromorphs/icons/mob/inhands/guns/guns_right.dmi'
	inhand_icon_state = "scl_shotgun-wielded"
	// var/icon_loaded = "scl_shotgun_loaded"//check out
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	weapon_weight = WEAPON_MEDIUM
	mag_type = /obj/item/ammo_box/magazine/ds12g
	can_suppress = FALSE
	fire_delay = 10
	//OLD firemodes = list(
	//OLD	list(mode_name = "shotgun", fire_delay = 1 SECONDS),
	//OLD	list(mode_name = "bolas", projectile_type = /obj/item/projectile/bullet/shotgun/bola, fire_sound = 'sound/weapons/bolathrow.ogg', fire_delay = 1 SECONDS))
	fire_sound = 'sound/weapons/gun/shotgun/shot_alt.ogg'
	slot_flags = ITEM_SLOT_BELT
	//mag_display = TRUE    //Does it?
	empty_indicator = TRUE
	empty_alarm = TRUE
	//special_mags = TRUE     Future endeaver if desired
	mag_display_ammo = TRUE //Check for, and which sprite
	semi_auto = TRUE
	internal_magazine = FALSE
	tac_reloads = TRUE

/obj/item/gun/ballistic/shotgun/scl_shotgun/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/shotgun/scl_shotgun/bola

// /obj/item/gun/ballistic/shotgun/scl_shotgun/update_icon()
// 	. = ..()
// 	if(ammo_magazine)
// 		icon_state = icon_loaded
// 	else
// 		icon_state = initial(icon_state)

/**
Magazines
*/

/obj/item/ammo_box/magazine/ds12g //pulse slug?
	name = "magazine SCL-shotgun buckshot"
	desc = "Magazine of 12 gauge shells."
	icon = 'icons/obj/guns_ds13/ammo.dmi'
	icon_state = "shotgun_magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 7
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/ds12g/slug
	name = "magazine SCL-shotgun slug"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/ds12g/executioner //admin only, can dismember limbs
	name = "magazine SCL-shotgun executioner"
	ammo_type = /obj/item/ammo_casing/shotgun/executioner

/obj/item/ammo_box/magazine/ds12g/pulverizer //admin only, can crush bones
	name = "magazine SCL-shotgun pulverizer"
	ammo_type = /obj/item/ammo_casing/shotgun/pulverizer

/obj/item/ammo_box/magazine/ds12g/beanbag
	name = "magazine SCL-shotgun beanbag"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/ammo_box/magazine/ds12g/incendiary
	name = "magazine SCL-shotgun incendiary"
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary

/obj/item/ammo_box/magazine/ds12g/dragonsbreath
	name = "magazine SCL-shotgun dragonsbreath"
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath

/obj/item/ammo_box/magazine/ds12g/stunslug
	name = "magazine SCL-shotgun stunslug"
	ammo_type = /obj/item/ammo_casing/shotgun/stunslug

/obj/item/ammo_box/magazine/ds12g/meteorslug
	name = "magazine SCL-shotgun meteorslug"
	ammo_type = /obj/item/ammo_casing/shotgun/meteorslug

/obj/item/ammo_box/magazine/ds12g/frag12
	name = "magazine SCL-shotgun frag12"
	ammo_type = /obj/item/ammo_casing/shotgun/frag12

/obj/item/ammo_box/magazine/ds12g/rb
	name = "magazine SCL-shotgun rubbershot"
	desc = "Magazine of rubbershot."
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/ammo_box/magazine/ds12g/incapacitate //Use for bola base?
	name = "magazine SCL-shotgun incapacitate"
	ammo_type = /obj/item/ammo_casing/shotgun/incapacitate

/obj/item/ammo_box/magazine/ds12g/improvised
	name = "magazine SCL-shotgun improvised"
	ammo_type = /obj/item/ammo_casing/shotgun/improvised

/obj/item/ammo_box/magazine/ds12g/dart
	name = "magazine SCL-shotgun dart"
	ammo_type = /obj/item/ammo_casing/shotgun/dart

/obj/item/ammo_box/magazine/ds12g/bioterror
	name = "magazine SCL-shotgun bioterror"
	ammo_type = /obj/item/ammo_casing/shotgun/dart/bioterror

//Can add in special ammo types in future is desired. BOLA, NECROTOXINS

/**
Ammo casings for the mags
*/

/**
Projectiles for the ammo casings
*/

///obj/item/gun/projectile/shotgun/scl_shotgun/MouseDrop(over_object)
//	if(ammo_magazine)
//		unload_ammo(usr)
//		return
//	return ..()
