/obj/item/gun/ballistic/cutter
	name = "210-V Mining Cutter"
	desc = "A medium-power mining tool capable of splitting dense material with only a few directed blasts. Unsurprisingly, it is also an extremely deadly tool and should be handled with the utmost care. "
	icon = 'necromorphs/icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "plasmacutter"
	lefthand_file = 'necromorphs/icons/mob/inhands/guns/guns_left.dmi'
	righthand_file = 'necromorphs/icons/mob/inhands/guns/guns_right.dmi'
	inhand_icon_state = "plasmacutter"
	fire_sound = 'necromorphs/sound/weapons/guns/plasma_cutter.ogg'
	slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_LIGHT
	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE
	mag_display = FALSE
	can_suppress = FALSE
	force = 8
	mag_type = /obj/item/ammo_box/magazine/plasmacutter


/obj/item/gun/ballistic/cutter/empty
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/cutter/plasma
	name = "211-V Plasma Cutter"
	desc = "A high power plasma cutter designed to cut through tungsten reinforced bulkheads during engineering works. Also a rather hazardous improvised weapon, capable of severing limbs in a few shots."
	projectile_damage_multiplier = 1.5

/obj/item/gun/ballistic/cutter/rending
	name = "211-S Plasma Cutter"
	desc = "An illegally modified plasma cutter designed to cut through bone. For some reason, flesh seems to absorb part of the impact."
	color = "#e97f83"
	projectile_damage_multiplier = 2

/obj/item/ammo_casing/caseless/cutter
	name = "plasma conductor"
	desc = "Focuses the plasma into three beams"
	projectile_type = /obj/projectile/beam/cutter
	fire_sound = 'necromorphs/sound/weapons/guns/plasma_cutter.ogg'


/obj/projectile/beam/cutter
	name = "plasma arc"
	icon = null
	damage = 12
	hitscan = TRUE
	dismemberment = 20
	damage_type = BRUTE //plasma is a physical object with mass, rather than purely burning. this also means you can decapitate/sever limbs, not just ash them.
	armor_flag = "laser"
	range = 6 //mining tools are not exactly known for their ability to replace firearms, they're good against necros, not so much against anything else.
	pass_flags = PASSTABLE

	var/mine_range = 5

	muzzle_type = /obj/effect/projectile/plasmacutter/muzzle
	tracer_type = null
	impact_type = /obj/effect/projectile/plasmacutter/impact


/obj/projectile/beam/cutter/plasma
	damage = 18.5
	range = 7 //an upgrade over the mining cutter, used for engineering work, but still not a proper firearm
	mine_range = 7

/obj/projectile/beam/cutter/rending
	damage = 22
	range = 6 //more sensitive to friction
	mine_range = 3

/obj/projectile/beam/cutter/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer, FALSE)
		if(mine_range)
			mine_range--
			range++
		if(range > 0)
			return BULLET_ACT_FORCE_PIERCE


//----------------------------
// Plasmacutter Effects
//----------------------------
/obj/effect/projectile/plasmacutter/
	light_color = COLOR_ORANGE

/obj/effect/projectile/plasmacutter/muzzle
	icon = 'necromorphs/icons/obj/projectiles.dmi'
	icon_state = "muzzle_plasmacutter"

/obj/effect/projectile/plasmacutter/impact
	icon = 'necromorphs/icons/obj/projectiles.dmi'
	icon_state = "impact_plasmacutter"


/*--------------------------
	Ammo
---------------------------*/

/obj/item/ammo_box/magazine/plasmacutter
	name = "plasma energy"
	desc = "A light power pack designed for use with high energy cutting tools."
	icon = 'necromorphs/icons/obj/ammo.dmi'
	icon_state = "darts"
	w_class = WEIGHT_CLASS_SMALL
	ammo_type = /obj/item/ammo_casing/caseless/cutter
	max_ammo = 10
	multiload = FALSE
	caliber = ENERGY
	var/chargerate = 100

/obj/item/ammo_box/magazine/plasmacutter/update_icon_state()
	..()
	icon_state = "darts-[round(length(stored_ammo)/2)]"

/obj/item/ammo_box/magazine/plasmacutter/attack_self(mob/user)
	return



