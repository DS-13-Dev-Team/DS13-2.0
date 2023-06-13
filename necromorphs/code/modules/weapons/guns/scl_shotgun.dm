/**
DS SCL Shotgun
*/

/obj/item/gun/ballistic/shotgun/scl_shotgun //Has no bola mode yet
	name = "\improper SCL Shotgun"
	desc = "The SCL Shotgun is a close to medium-ranged weapon developed by the Sovereign Colonies Armed Forces and utilized by SCAF Legionaries. \
	The shotgun has remained in use in private security and police departments as a riot-control tool, given its ability to fire incapacitating shells for capture and arrest, or lethal slugs in life-threatening situations. \
	The SCL Shotgun is magazine loaded and is effective at short range or for fugitive capture."
	icon = 'necromorphs/icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "scl_shotgun"
	lefthand_file = 'necromorphs/icons/mob/onmob/items/lefthand_guns.dmi'
	righthand_file = 'necromorphs/icons/mob/onmob/items/righthand_guns.dmi'
	inhand_icon_state = "scl_shotgun-wielded"
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
	empty_indicator = TRUE
	empty_alarm = TRUE
	mag_display_ammo = TRUE
	semi_auto = TRUE
	internal_magazine = FALSE 
	tac_reloads = TRUE

/obj/item/gun/ballistic/shotgun/scl_shotgun/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/shotgun/scl_shotgun/bola/Initialize(mapload)
	magazine = new /obj/item/ammo_box/magazine/ds12g/bola(src)
	return ..()

/**
Magazines
*/

/obj/item/ammo_box/magazine/ds12g //pulse slug?
	name = "magazine SCL-shotgun buckshot"
	desc = "Magazine of 12 gauge shells."
	icon = 'necromorphs/icons/obj/ammo.dmi'
	icon_state = "shotgun_magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 7
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/ds12g/bola
	name = "magazine SCL-shotgun bola"
	ammo_type = /obj/item/ammo_casing/shotgun/bola

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

/obj/item/ammo_box/magazine/ds12g/pulseslug
	name = "magazine SCL-shotgun pulseslug"
	ammo_type = /obj/item/ammo_casing/shotgun/pulseslug

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

/obj/item/ammo_casing/shotgun/bola
	name = "bola shell"
	desc = "A shotgun casing that is somehow filled with a tightly packed bola, that expands once it leaves the barrel."
	icon_state = "stunshell"
	fire_sound = 'sound/weapons/bolathrow.ogg'
	projectile_type = /obj/projectile/bullet/shotgun_bola

/**
Projectiles for the ammo casings
*/

/obj/projectile/bullet/shotgun_bola //WIP
	name = "bola"
	icon = 'necromorphs/icons/obj/projectiles.dmi'
	icon_state = "bola"
	damage = 1
	stamina = 60
	embedding = null
	sharpness = NONE
	speed = 0.6
	ricochets_max = 2
	ricochet_chance = 80
	ricochet_auto_aim_range = 1

//Will do later
// /obj/projectile/bullet/shotgun_bola/on_hit(atom/target, blocked = FALSE)
// 	. = ..()
// 	var/obj/item/restraints/legcuffs/bola/L = new (get_turf(src))
// 	if(ishuman(target))
// 		L.ensnare(target)

/**
Projectiles effects
*/

/obj/effect/projectile/shotgun
	name = "impact"
	icon = 'necromorphs/icons/obj/weapons/projectiles_effects.dmi'
	icon_state = "shotgun_hit"
