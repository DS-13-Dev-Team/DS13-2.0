/obj/item/gun/ballistic/deadspace/twohanded/javelin
	name = "T15 Javelin Gun"
	desc = "a telemetric survey tool manufactured by Timson Tools, designed to fire titanium spikes or 'javelins' at high speeds with extreme accuracy and piercing power."
	icon = 'deadspace/icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "javelin"
	inhand_icon_state = null
	base_icon_state = "javelin"
	lefthand_file = 'deadspace/icons/mob/onmob/items/lefthand_guns.dmi'
	righthand_file = 'deadspace/icons/mob/onmob/items/righthand_guns.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/back.dmi'
	empty_alarm = TRUE
	mag_display = TRUE
	show_bolt_icon = FALSE
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/javelin
	fire_delay = 1.5 SECONDS
	can_suppress = FALSE
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	one_handed_penalty = 50
	recoil = 2
	burst_size = 1
	bolt_type = BOLT_TYPE_OPEN
	actions_types = list()
	fire_sound = 'deadspace/sound/weapons/guns/fire/jav_fire.ogg'
	fire_sound_volume = 90
	load_sound = 'deadspace/sound/weapons/guns/interaction/jav_magin.ogg'
	eject_sound = 'deadspace/sound/weapons/guns/interaction/jav_magout.ogg'

/obj/item/gun/ballistic/deadspace/twohanded/javelin/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/deadspace/twohanded/javelin/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))
	AddElement(/datum/element/update_icon_updates_onmob)

	AddComponent(/datum/component/two_handed, force_unwielded=5, force_wielded=8, icon_wielded="[base_icon_state]-wielded")

/**
Magazines
*/

/obj/item/ammo_box/magazine/javelin
	name = "javelin rack"
	desc = "A set of javelins for the T15 Javelin Gun."
	icon = 'deadspace/icons/obj/ammo.dmi'
	icon_state = "javelin"
	base_icon_state = "javelin-6"
	caliber = CALIBER_JAVELIN
	ammo_type = /obj/item/ammo_casing/caseless/javelin
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET


/**
Ammo casings for the mags
*/

/obj/item/ammo_casing/caseless/javelin
	name = "javelin spear"
	desc = "a titanium spike."
	icon = 'deadspace/icons/obj/ammo.dmi'
	icon_state = "javelin_bolt"
	base_icon_state = "javelin_bolt"
	caliber = CALIBER_JAVELIN
	projectile_type = /obj/projectile/bullet/javelin

/**
Projectiles for the casings
*/

/obj/projectile/bullet/javelin
	name = "javelin"
	icon = 'deadspace/icons/obj/projectiles.dmi'
	icon_state = "javelin"
	damage = 60
	armour_penetration = 50
	embedding = list(embed_chance=100, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
