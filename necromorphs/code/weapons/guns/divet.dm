/obj/item/gun/ballistic/automatic/pistol/divet
	name = "divet pistol"
	desc = "A Winchester Arms NK-series pistol capable of fully automatic fire."
	icon = 'necromorphs/icons/obj/weapons/gun.dmi'
	icon_state = "divet"
	lefthand_file = 'necromorphs/icons/mob/inhands/guns/guns_left.dmi'
	righthand_file = 'necromorphs/icons/mob/inhands/guns/guns_right.dmi'
	inhand_icon_state = "divet"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/divet
	can_suppress = FALSE
	actions_types = list(/datum/action/item_action/toggle_firemode)
	slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_POCKETS
	burst_size = 3
	fire_delay = 3
	show_bolt_icon = FALSE
	fire_sound = 'necromorphs/sound/weapons/guns/divet_fire.ogg'
	load_sound = 'necromorphs/sound/weapons/guns/divet_magin.ogg'
	eject_sound = 'necromorphs/sound/weapons/guns/divet_magout.ogg'

/obj/item/gun/ballistic/automatic/pistol/divet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/ammo_box/magazine/divet
	name = "magazine (pistol slug)"
	icon = 'necromorphs/icons/obj/ammo.dmi'
	icon_state = "divet_slugs"
	ammo_type = /obj/item/ammo_casing/caseless/divet
	caliber = CALIBER_DIVET
	max_ammo = 12

/obj/item/ammo_box/magazine/divet/update_icon_state()
	..()
	if (length(stored_ammo))
		icon_state = "divet_slugs"
	else
		icon_state = "divet_slugs_empty"

/obj/item/ammo_casing/caseless/divet
	name = "divet bullet casing"
	caliber = CALIBER_DIVET
	projectile_type = /obj/projectile/bullet/divet

/obj/projectile/bullet/divet
	name = "divet slug"
	icon = 'necromorphs/icons/obj/projectiles.dmi'
	icon_state = "divet"
	damage = 20
	armour_penetration = 10
