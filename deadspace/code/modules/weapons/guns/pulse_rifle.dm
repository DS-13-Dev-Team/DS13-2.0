/**
Pulse Rifles
*/

/obj/item/gun/ballistic/deadspace/twohanded/pulse
	name = "SWS Motorized Pulse Rifle"
	desc = "The SWS Motorized Pulse Rifle is a military-grade, triple-barreled assault rifle, manufactured by Winchester Arms, is capable of a rapid rate of fire. \
			The Pulse Rifle is the standard-issue service rifle of the Earth Defense Force and is also common among corporate security officers. "
	icon = 'deadspace/icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "pulserifle"
	base_icon_state = "pulserifle"
	lefthand_file = 'deadspace/icons/mob/onmob/items/lefthand_guns.dmi'
	righthand_file = 'deadspace/icons/mob/onmob/items/righthand_guns.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/back.dmi'
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	mag_display = FALSE
	mag_type = /obj/item/ammo_box/magazine/pulse
	default_ammo = /obj/item/ammo_casing/caseless/pulse
	weapon_weight = WEAPON_HEAVY
	show_bolt_icon = FALSE
	burst_size = 1
	bolt_type = BOLT_TYPE_OPEN
	can_suppress = FALSE
	one_handed_penalty = 20
	spread = 5
	fire_sound = 'deadspace/sound/weapons/guns/pulse_shot.ogg'
	load_sound = 'deadspace/sound/weapons/guns/pulse_magin.ogg'
	eject_sound = 'deadspace/sound/weapons/guns/pulse_magout.ogg'
	default_fire_sound ='deadspace/sound/weapons/guns/pulse_shot.ogg'
	//alt fire stuff
	alt_fire_ammo = /obj/item/ammo_casing/caseless/rocket/pulse
	alt_fire_cost = 25
	alt_fire = "grenade launcher"
	alt_fire_delay = 20
	alt_fire_sound = 'deadspace/sound/weapons/guns/pulse_grenade.ogg'

/obj/item/gun/ballistic/automatic/pulse/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/deadspace/twohanded/pulse/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))
	AddComponent(/datum/component/automatic_fire, 0.1 SECONDS)

	AddComponent(/datum/component/two_handed, force_unwielded=5, force_wielded=8, icon_wielded="[base_icon_state]-wielded")

/obj/item/gun/ballistic/deadspace/twohanded/pulse/egov //Same situation as rending divet
	name = "Earthgov SWS Motorized Pulse Rifle"
	desc = "The SWS Motorized Pulse Rifle is a military-grade, triple-barreled assault rifle, manufactured by Winchester Arms, is capable of a rapid rate of fire. \
This variant is of standard earthgov issue, featuring the highest grade parts."
	icon_state = "pulserifle_egov"
	base_icon_state = "pulserifle_egov"
	projectile_damage_multiplier = 1.10
	spread = 4
	//tier_1_bonus = 0

/obj/item/gun/ballistic/deadspace/twohanded/pulse/egov/Initialize(mapload)
	magazine = new /obj/item/ammo_box/magazine/pulse/hv(src)
	return ..()

/**
Magazines
*/

/obj/item/ammo_box/magazine/pulse
	name = "pulse magazine (standard)"
	desc = "With a distinctive \"bell and stock\" design, pulse magazines can be inserted and removed from the Pulse Rifle with minimal effort and risk."
	icon = 'deadspace/icons/obj/ammo.dmi'
	icon_state = "pulse_rounds"
	caliber = CALIBER_PULSE
	ammo_type = /obj/item/ammo_casing/caseless/pulse
	max_ammo = 50 //To low? 65 normal on 1.0
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/pulse/hv
	name = "pulse magazine (high velocity)"
	desc = "With a distinctive \"bell and stock\" design, pulse magazines can be inserted and removed from the Pulse Rifle with minimal effort and risk. This one contains hypersonic rounds, unsafe for naval usage."
	icon_state = "pulse_rounds_hv"
	ammo_type = /obj/item/ammo_casing/caseless/pulse/hv
	max_ammo = 80

/obj/item/ammo_box/magazine/pulse/df
	name = "pulse magazine (deflection)"
	desc = "With a distinctive \"bell and stock\" design, pulse magazines can be inserted and removed from the Pulse Rifle with minimal effort and risk. This one contains EXPERIMENTAL deflection rounds. Extremely dangerous, these rounds are with a deflective tip, letting them bounce of surfaces."
	icon_state = "pulse_rounds_df"
	ammo_type = /obj/item/ammo_casing/caseless/pulse/df
	max_ammo = 100 //Slightly more total damage than a regular pulse mag. Double normal mag capacity, but nearly half damage

/obj/item/ammo_box/magazine/pulse/blank
	name = "pulse magazine (blank/practice)"
	desc = "With a distinctive \"bell and stock\" design, pulse magazines can be inserted and removed from the Pulse Rifle with minimal effort and risk. This one contains practice rounds, used in training for its nonlethality."
	ammo_type = /obj/item/ammo_casing/caseless/pulse/blank

/**
Ammo casings for the mags
*/

/obj/item/ammo_casing/caseless/pulse
	name = "pulse round"
	desc = "A ultra-small caliber round designed for the SWS Motorized Pulse Rifle."
	icon_state = "ionshell-live"
	caliber = CALIBER_PULSE
	projectile_type = /obj/projectile/bullet/pulse

/obj/item/ammo_casing/caseless/pulse/hv
	name = "high velocity pulse round"
	desc = "A ultra-small caliber hypersonic round designed for the SWS Motorized Pulse Rifle."
	projectile_type  = /obj/projectile/bullet/pulse/hv

/obj/item/ammo_casing/caseless/pulse/df
	name = "deflection pulse round"
	desc = "A ultra-small caliber deflection round designed for the SWS Motorized Pulse Rifle."
	projectile_type  = /obj/projectile/bullet/pulse/df

/obj/item/ammo_casing/caseless/pulse/blank
	name = "blank pulse round"
	desc = "A ultra-small caliber round designed for the SWS Motorized Pulse Rifle as practice shooting."
	projectile_type = /obj/projectile/bullet/pulse/blank
	harmful = FALSE

//Grenade alt
/obj/item/ammo_casing/caseless/rocket/pulse
	name = "SWS Impact Grenade"
	desc = "An ultra light impact grenade, for when riddling your foe with bullets doesn't quite do the trick"
	icon = 'deadspace/icons/obj/projectiles.dmi'
	icon_state = "bolter"
	caliber = CALIBER_PULSE
	projectile_type = /obj/projectile/bullet/a84mm/pulse

/obj/projectile/bullet/a84mm/pulse
	name = "impact grenade"
	icon = 'deadspace/icons/obj/projectiles.dmi'
	icon_state = "bolter"
	damage = 5
	armor_flag = BOMB

/obj/projectile/bullet/a84mm/pulse/do_boom(atom/target, blocked=0)
	if(!isliving(target)) //if the target isn't alive, so is a wall or something
		explosion(target, heavy_impact_range = 1, light_impact_range = 2, flame_range = 2, flash_range = 3, explosion_cause = src)
	else
		explosion(target, light_impact_range = 2, flame_range = 2, flash_range = 3,  explosion_cause = src)


/**
Projectiles for the casings
*/

/obj/projectile/bullet/pulse
	name = "pulse"
	icon = 'deadspace/icons/obj/projectiles.dmi'
	icon_state = "pulse"
	damage = 14
	//It sonic fast
	speed = 1
	armour_penetration = 4 //Should be quite low I'd think, especially for standard rounds. Bullet made to shred and liquify flesh but not affect materialistic objects much.
	shrapnel_type = null
	embedding = null
	//muzzle_type = /obj/effect/projectile/ds_muzzle/pulse

/obj/projectile/bullet/pulse/hv
	icon_state = "pulse_hv"
	damage = 15.5
	armour_penetration = 12
	//muzzle_type = /obj/effect/projectile/ds_muzzle/pulse/hv

/obj/projectile/bullet/pulse/df //Will change properly later
	icon_state = "pulse_df"
	damage = 12
	stamina = 8
	ricochets_max = 2
	ricochet_incidence_leeway = 0
	ricochet_chance = 120
	ricochet_auto_aim_angle = 40
	ricochet_auto_aim_range = 5
	ricochet_decay_damage = 0.9
	//muzzle_type = /obj/effect/projectile/ds_muzzle/pulse/df

/obj/projectile/bullet/pulse/blank //Use Divet blank when it changes
	damage = 1 //Can maybe do burn damage, reduced range
	armour_penetration = 0
	weak_against_armour = TRUE
	sharpness = NONE

/**
Projectiles effects
*/

/obj/effect/projectile/pulse
	icon = 'deadspace/icons/obj/weapons/projectiles_effects.dmi'
	icon_state = "muzzle_pulse"
	light_power = 0.7
	light_color = COLOR_DEEP_SKY_BLUE

/obj/effect/projectile/pulse/light
	icon_state = "muzzle_pulse_light"
	light_power = 0.6
	light_color = COLOR_DEEP_SKY_BLUE

/obj/effect/projectile/pulse/hv
	icon_state = "muzzle_pulse_hv"
	light_power = 0.6
	light_color = COLOR_MARKER_RED

/obj/effect/projectile/pulse/df
	icon_state = "muzzle_pulse_light"
	light_power = 0.6
	light_color = COLOR_YELLOW

/obj/effect/projectile/pulse
	name = "impact"
	icon = 'deadspace/icons/obj/weapons/projectiles_effects.dmi'
	icon_state = "pulse_hit"
