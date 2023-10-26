/**
Seeker Rifles
*/

/obj/item/gun/ballistic/deadspace/twohanded/seeker //Based a bit on /obj/item/gun/ballistic/automatic/sniper_rifle
	name = "Seeker Rifle"
	desc = "The Seeker Rifle is a suppressed riot control device that is meant for accuracy at long-range. Comes with a built-in scope."
	icon = 'deadspace/icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "seeker"
	base_icon_state = "seeker"
	lefthand_file = 'deadspace/icons/mob/onmob/items/lefthand_guns.dmi'
	righthand_file = 'deadspace/icons/mob/onmob/items/righthand_guns.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/back.dmi'
	worn_icon_state = "seeker"
	inhand_icon_state = null
	mag_display = FALSE
	show_bolt_icon = FALSE
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/seeker
	fire_delay = 1.5 SECONDS
	suppressed = TRUE
	can_unsuppress = FALSE
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	block_chance = 10 //The seeker sucks quite a bit at blocking compared to other guns
	one_handed_penalty = 50
	recoil = 2
	burst_size = 1
	bolt_type = BOLT_TYPE_OPEN
	actions_types = list()
	//tier_1_bonus = 1 //Cut slashers some slack
	fire_sound = 'sound/weapons/gun/sniper/shot.ogg'
	fire_sound_volume = 90
	load_sound = 'sound/weapons/gun/sniper/mag_insert.ogg'
	eject_sound = 'sound/machines/eject.ogg'
	suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'

/obj/item/gun/ballistic/deadspace/twohanded/seeker/no_mag
	spawnwithmagazine = FALSE

//Scope is bugged. Wait until upstream gets merged in.
/obj/item/gun/ballistic/deadspace/twohanded/seeker/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))
	AddComponent(/datum/component/scope, range_modifier = 2) //Scope component seems bugged, will need checking on

	AddComponent(/datum/component/two_handed, force_unwielded=5, force_wielded=8, icon_wielded="[base_icon_state]-wielded")

/obj/item/gun/ballistic/deadspace/twohanded/seeker/reset_semicd()
	. = ..()
	if(suppressed)
		playsound(src, 'sound/machines/eject.ogg', 25, TRUE, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	else
		playsound(src, 'sound/machines/eject.ogg', 50, TRUE)

/obj/item/gun/ballistic/deadspace/twohanded/seeker/egov
	name = "Earthgov Seeker Rifle"
	desc = "The Earthgov Seeker Rifle is a riot control device that is meant for accuracy at long-range. Comes with a built-in scope."
	icon_state = "seeker" //Maybe get a new sprite for it in the future
	projectile_damage_multiplier = 1.15

/**
Magazines
*/

/obj/item/ammo_box/magazine/seeker
	name = "seeker shells"
	desc = "High caliber armor piercing shells designed for use in the Seeker Rifle."
	icon = 'deadspace/icons/obj/ammo.dmi'
	icon_state = "seeker"
	base_icon_state = "seeker-6"
	ammo_type = /obj/item/ammo_casing/seeker
	caliber = CALIBER_SEEKER
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET

//Can potentially add alternative ammo, like the .50 cal. Soporific, penetrator, marksman, etc

/**
Ammo casings for the mags
*/

/obj/item/ammo_casing/seeker
	name = "seeker shell"
	desc = "A high caliber round designed for the Seeker Rifle."
	icon_state = ".50"
	caliber = CALIBER_SEEKER
	projectile_type = /obj/projectile/bullet/seeker

/**
Projectiles for the casings
*/

/obj/projectile/bullet/seeker
	name ="seeker shell"
	speed = 0.4
	damage = 60
	paralyze = 10
	dismemberment = 30
	armour_penetration = 50
	embedding = list(embed_chance=50, fall_chance=2, jostle_chance=2, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=7, rip_time=8)
	// var/breakthings = TRUE

//Taken from .50 sniper. Keeping here for now, as something to check on later
// /obj/projectile/bullet/seeker/on_hit(atom/target, blocked = 0)
// 	if(isobj(target) && (blocked != 100) && breakthings)
// 		var/obj/O = target
// 		O.take_damage(80, BRUTE, BULLET, FALSE)
// 	return ..()
