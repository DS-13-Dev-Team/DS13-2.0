/**
Seeker Rifles
*/

/obj/item/gun/ballistic/automatic/seeker //Based a bit on /obj/item/gun/ballistic/automatic/sniper_rifle
	name = "Seeker Rifle"
	desc = "The Seeker Rifle is a riot control device that is meant for accuracy at long-range. Comes with a built-in scope."
	icon = 'icons/obj/guns_ds13/guns48x32.dmi'
	icon_state = "seeker"
	lefthand_file = 'necromorphs/icons/mob/inhands/guns/guns_left.dmi'
	righthand_file = 'necromorphs/icons/mob/inhands/guns/guns_right.dmi'
	inhand_icon_state = "seeker"
	worn_icon_state = null
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/seeker
	fire_delay = 12
	can_suppress = FALSE
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	recoil = 2
	burst_size = 1
	bolt_type = BOLT_TYPE_OPEN
	actions_types = list()
	//accuracy = -30	//Don't try to hipfire
	//one_hand_penalty = -30	//Don't try to fire this with one hand
	//tier_1_bonus = 1 //Cut slashers some slack
	fire_sound = 'sound/ds13/seeker_fire.ogg'
	load_sound = 'sound/ds13/seeker_load.ogg'
	eject_sound = 'sound/ds13/pulse_magout.ogg'

/obj/item/gun/ballistic/automatic/seeker/no_mag
	spawnwithmagazine = FALSE

//Scope is bugged. Wait until upstream gets merged in.
// /obj/item/gun/ballistic/automatic/seeker/Initialize(mapload)
// 	. = ..()
// 	AddComponent(/datum/component/scope, range_modifier = 2)

/obj/item/gun/ballistic/automatic/seeker/egov
	name = "Earthgov Seeker Rifle"
	desc = "The Earthgov Seeker Rifle is a riot control device that is meant for accuracy at long-range. Comes with a built-in scope."
	icon_state = "seeker" //Maybe get a new sprite for it in the future
	mag_type = /obj/item/ammo_box/magazine/seeker/egov
	fire_delay = 6
	recoil = 0.4
	burst_size = 3
	actions_types = list(/datum/action/item_action/toggle_firemode)
	projectile_damage_multiplier = 1.15 

/obj/item/gun/ballistic/automatic/seeker/egov/no_mag
	spawnwithmagazine = FALSE

/**
Magazines
*/

/obj/item/ammo_box/magazine/seeker
	name = "seeker shells"
	desc = "High caliber armor piercing shells designed for use in the Seeker Rifle."
	icon = 'icons/obj/guns_ds13/ammo.dmi'
	icon_state = "seeker"
	base_icon_state = "seeker"
	caliber = CALIBER_SEEKER
	ammo_type = /obj/item/ammo_casing/caseless/seeker
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/seeker/egov
	name = "assault seeker shells"
	desc = "Medium caliber armor piercing shells designed for use in the Seeker Rifle, designed for use with Earthgov models, to be used more akin to an assault rifle."
	icon = 'icons/obj/guns_ds13/ammo.dmi'
	icon_state = "seeker-6"
	base_icon_state = "seeker"
	ammo_type = /obj/item/ammo_casing/caseless/seeker/egov
	max_ammo = 24
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/seeker/egov/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 4) / 4]"

//Can potentially add alternative ammo, like the .50 cal. Soporific, penetrator, marksman, etc

// /obj/item/ammo_box/magazine/sniper_rounds/soporific
// 	name = "sniper rounds (Zzzzz)"
// 	desc = "Soporific sniper rounds, designed for happy days and dead quiet nights..."
// 	icon_state = "soporific"
// 	ammo_type = /obj/item/ammo_casing/p50/soporific
// 	max_ammo = 3
// 	caliber = CALIBER_50

// /obj/item/ammo_box/magazine/sniper_rounds/penetrator
// 	name = "sniper rounds (penetrator)"
// 	desc = "An extremely powerful round capable of passing straight through cover and anyone unfortunate enough to be behind it."
// 	ammo_type = /obj/item/ammo_casing/p50/penetrator
// 	max_ammo = 5

// /obj/item/ammo_box/magazine/sniper_rounds/marksman
// 	name = "sniper rounds (marksman)"
// 	desc = "An extremely fast sniper round able to pretty much instantly shoot through something."
// 	ammo_type = /obj/item/ammo_casing/p50/marksman
// 	max_ammo = 5


/**
Ammo casings for the mags
*/

/obj/item/ammo_casing/caseless/seeker
	name = "seeker shell"
	desc = "A high caliber round designed for the Seeker Rifle."
	icon_state = "ionshell-live"
	caliber = CALIBER_SEEKER
	projectile_type = /obj/projectile/bullet/seeker

/obj/item/ammo_casing/caseless/seeker/egov
	projectile_type = /obj/projectile/bullet/seeker/egov

/**
Projectiles for the casings
*/

/obj/projectile/bullet/seeker
	name ="seeker shell"
	speed = 0.4
	damage = 50
	paralyze = 100
	dismemberment = 30
	armour_penetration = 50
	embedding = list(embed_chance=50, fall_chance=2, jostle_chance=2, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=7, rip_time=8)
	// var/breakthings = TRUE

/obj/projectile/bullet/seeker/egov
	name ="seeker shell"
	damage = 20
	paralyze = 30
	dismemberment = 10
	armour_penetration = 20
	embedding = list(embed_chance=40, fall_chance=2, jostle_chance=2, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=7, rip_time=8)

//code\modules\projectiles\projectile\bullets\sniper.dm

//Taken from .50 sniper. Keeping here for now, as something to check on later
// /obj/projectile/bullet/seeker/on_hit(atom/target, blocked = 0)
// 	if(isobj(target) && (blocked != 100) && breakthings)
// 		var/obj/O = target
// 		O.take_damage(80, BRUTE, BULLET, FALSE)
// 	return ..()
