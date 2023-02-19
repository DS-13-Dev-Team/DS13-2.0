/**
Divet pistols
*/

/obj/item/gun/ballistic/automatic/pistol/divet
	name = "divet pistol"
	desc = "A Winchester Arms NK-series pistol capable of fully automatic fire."
	icon = 'icons/obj/guns_ds13/guns.dmi'
	icon_state = "divet"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/divet
	can_suppress = TRUE
	burst_size = 3
	fire_delay = 1.5
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC, SELECT_BURST_SHOT)
	fire_sound= 'sound/ds13/divet_fire.ogg'
	suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	//mag_insert_sound = 'sound/weapons/guns/interaction/divet_magin.ogg'  //Old noises from 1.0, but weren't actually working and used.
	//mag_remove_sound = 'sound/weapons/guns/interaction/divet_magout.ogg' //They just sound like clockwork cult sounds.

/obj/item/gun/ballistic/automatic/pistol/divet/suppressed/Initialize(mapload)//Off chance you want a normal suppressed divet. Might not work.
	. = ..()
	var/obj/item/suppressor/S = new(src)
	install_suppressor(S)

/obj/item/gun/ballistic/automatic/pistol/divet/silenced
	name = "special ops divet pistol"
	desc = "A modified version of the Winchester Arms NK-series pistol. An integrated suppressor lowers the audio profile fairly well."
	icon_state = "divet_spec"
	suppressed_volume = 40
	suppressed = TRUE
	can_unsuppress = FALSE

/obj/item/gun/ballistic/automatic/pistol/divet/rending//For Ketrai to do
	name = "jury-rigged divet pistol"
	desc = "An illegaly modified version of the Winchester Arms NK-series pistol. Shoots bullets at brutal speed, but at an odd angle. Fractures bones easily"
	//color = "#6e6ec1"
	//tier_2_bonus = 1
	//tier_1_bonus = 1

/obj/item/gun/ballistic/automatic/pistol/divet/no_mag
	spawnwithmagazine = FALSE

/**
Magazines
*/

/obj/item/ammo_box/magazine/divet
	name = "divet magazine (pistol slug)"
	icon = 'icons/obj/guns_ds13/ammo.dmi'
	icon_state = "45ds"
	ammo_type = /obj/item/ammo_casing/divet
	caliber = CALIBER_45 //Should probably make it into its own, like "CALIBER_45_SLUG" or so, but it seems cooler this way as this was something some people wanted
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/divet/hp
	name = "divet magazine (hollow point)"
	icon_state = "hpds"
	ammo_type = /obj/item/ammo_casing/divet/hp

/obj/item/ammo_box/magazine/divet/ap
	name = "divet magazine (AP)"
	icon_state = "apds"
	ammo_type = /obj/item/ammo_casing/divet/ap

/obj/item/ammo_box/magazine/divet/rb
	name = "divet magazine (rubber)"
	icon_state = "rbds"
	ammo_type = /obj/item/ammo_casing/divet/rb
	max_ammo = 15

/obj/item/ammo_box/magazine/divet/fire
	name = "divet magazine (incendiary)"
	icon_state = "icds"
	ammo_type = /obj/item/ammo_casing/divet/inc

/obj/item/ammo_box/magazine/divet/extended
	name = "divet magazine (extended)"
	icon_state = "extds"
	max_ammo = 21
	ammo_type = /obj/item/ammo_casing/divet/extended

/obj/item/ammo_box/magazine/divet/extended/expanded
	name = "divet magazine (expanded)"
	icon_state = "exterds"
	max_ammo = 60

/obj/item/ammo_box/magazine/divet/blank
	name = "divet magazine (blank/practice)"
	icon_state = "rbds"
	ammo_type = /obj/item/ammo_casing/divet/blank
	max_ammo = 15

/**
Ammo casings for the mags
*/

/obj/item/ammo_casing/divet
	name = ".45 bullet casing"
	desc = "A .45 bullet casing."
	caliber = CALIBER_45
	projectile_type = /obj/projectile/bullet/divet

/obj/item/ammo_casing/divet/hp
	name = ".45 hollow-point bullet casing"
	projectile_type = /obj/projectile/bullet/divet/hp

/obj/item/ammo_casing/divet/ap
	name = ".45 armor-piercing bullet casing"
	projectile_type = /obj/projectile/bullet/divet/ap

/obj/item/ammo_casing/divet/rb
	name = ".45 rubber bullet casing"
	projectile_type = /obj/projectile/bullet/divet/rb

/obj/item/ammo_casing/divet/inc
	name = ".45 incendiary bullet casing"
	projectile_type = /obj/projectile/bullet/incendiary/divet

/obj/item/ammo_casing/divet/extended
	name = ".45 steel bullet casing"
	projectile_type = /obj/projectile/bullet/divet/extended

/obj/item/ammo_casing/divet/blank
	name = ".45 blank bullet casing"
	projectile_type = /obj/projectile/bullet/divet/blank

/**
Projectiles for the casings
*/

/obj/projectile/bullet/divet
	name = ".45 bullet"
	icon = 'icons/obj/guns_ds13/projectiles.dmi'
	icon_state = "divet"
	damage = 17.5
	armour_penetration = 7.5
	wound_bonus = -10
	wound_falloff_tile = -10
	embedding = list(embed_chance=25, fall_chance=2, jostle_chance=2, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=3, jostle_pain_mult=5, rip_time=1 SECONDS)
	muzzle_type = /obj/effect/projectile/ds_muzzle/pulse //+/light   dunno where the 'light' part is from. Maybe a calculation on normal pulse muzzle?
	impact_type = /obj/effect/projectile/ds_impact/divet

//More damage and shrapnel, less AP, structure damage and penetration
/obj/projectile/bullet/divet/hp
	name = ".45 hollow-point bullet"
	icon_state = "divet_hp"
	damage = 22.5
	armour_penetration = 0
	weak_against_armour = TRUE

//Opposite of hollowpoint
/obj/projectile/bullet/divet/ap
	name = ".45 armor-piercing bullet"
	icon_state = "divet_ap"
	damage = 15
	armour_penetration = 15

//Less lethal ammo. Rubber bullets, now with bounce!
/obj/projectile/bullet/divet/rb
	name = ".45 rubber bullet"
	icon_state = "divet"
	damage = 6
	stamina = 30
	armour_penetration = 10
	ricochets_max = 5
	ricochet_incidence_leeway = 0
	ricochet_chance = 120
	ricochet_auto_aim_angle = 40
	ricochet_auto_aim_range = 5
	ricochet_decay_damage = 0.8
	wound_bonus = -20
	bare_wound_bonus = 10
	weak_against_armour = TRUE
	shrapnel_type = null
	sharpness = NONE
	embedding = null

//Bullets that set people AND THE ENVIRONMENT on fire, have reduced armor penetration
//They also have reduced flat damage, likely due to much of the casing space being taken for incindiary use instead (and balance)
/obj/projectile/bullet/incendiary/divet
	name = ".45 incendiary bullet"
	icon = 'icons/obj/guns_ds13/projectiles.dmi'
	icon_state = "divet_incend"
	damage = 12.5
	armour_penetration = 5
	fire_stacks = 1

//Leaving here if someone wanted to try to use old incendiary stuff (slightly modified, not enougb to work though)
// /obj/projectile/bullet/incendiary/divet/on_impact(var/mob/living/L)    //Change on_impact to something of '/obj/projectile/proc/Impact'
// 	if (istype(L))
// 		L.fire_stacks += 5
// 		L.IgniteMob()    //Would likely change it to 'ignite_mob' or so, for 'mob/living/proc/ignite_mob()'

//Cheaper bullets that put inside the extended mags by default, to cut some costs of the more trigger happy prone who use the mags
/obj/projectile/bullet/divet/extended
	name = ".45 steel bullet"
	damage = 15.5

/obj/projectile/bullet/divet/blank
	name = ".45 blank bullet"
	icon_state = "divet"
	damage = 1
	wound_bonus = -20
	bare_wound_bonus = 30
	wound_falloff_tile = -50
	weak_against_armour = TRUE
	shrapnel_type = null
	sharpness = NONE
	embedding = null
