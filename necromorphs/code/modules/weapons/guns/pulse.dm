/obj/item/gun/ballistic/deadspace/twohanded/pulse
	name = "SWS Motorized Pulse Rifle"
	desc = "The SWS Motorized Pulse Rifle is a military-grade, triple-barreled assault rifle, manufactured by Winchester Arms, is capable of a rapid rate of fire. \
			The Pulse Rifle is the standard-issue service rifle of the Earth Defense Force and is also common among corporate security officers. "
	icon = 'necromorphs/icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "pulserifle"
	base_icon_state = "pulserifle"
	lefthand_file = 'necromorphs/icons/mob/inhands/guns/guns_left.dmi'
	righthand_file = 'necromorphs/icons/mob/inhands/guns/guns_right.dmi'
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = 0
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
	fire_sound = 'necromorphs/sound/weapons/guns/pulse_shot.ogg'
	default_fire_sound ='necromorphs/sound/weapons/guns/pulse_shot.ogg'
	//alt fire stuff
	alt_fire_ammo = /obj/item/ammo_casing/caseless/rocket/pulse
	alt_fire_cost = 25
	alt_fire = "grenade launcher"
	alt_fire_delay = 20
	alt_fire_sound = 'necromorphs/sound/weapons/guns/pulse_grenade.ogg'

/obj/item/gun/ballistic/deadspace/twohanded/pulse/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))
	AddComponent(/datum/component/automatic_fire, 0.1 SECONDS)

/obj/item/gun/ballistic/deadspace/twohanded/pulse/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=5, force_wielded=8, icon_wielded="[base_icon_state]-wielded")

/obj/item/ammo_box/magazine/pulse
	name = "magazine (pulse rounds)"
	desc = "With a distinctive \"bell and stock\" design, pulse magazines can be inserted and removed from the Pulse Rifle with minimal effort and risk."
	icon = 'necromorphs/icons/obj/ammo.dmi'
	icon_state = "pulse_rounds"
	caliber = CALIBER_PULSE
	ammo_type = /obj/item/ammo_casing/caseless/pulse
	max_ammo = 50

/obj/item/ammo_box/magazine/pulse/update_icon_state()
	..()
	if (length(stored_ammo))
		icon_state = "pulse_rounds"
	else
		icon_state = "pulse_rounds_empty"

/obj/item/ammo_casing/caseless/pulse
	name = "pulse round"
	desc = "A ultra-small caliber round designed for the SWS Motorized Pulse Rifle."
	icon_state = "ionshell-live"
	caliber = CALIBER_PULSE
	projectile_type = /obj/projectile/bullet/pulse

/obj/item/ammo_casing/caseless/rocket/pulse
	name = "SWS Impact Grenade"
	desc = "An ultra light impact grenade, for when riddling your foe with bullets doesn't quite do the trick"
	icon = 'necromorphs/icons/obj/projectiles.dmi'
	icon_state = "bolter"
	caliber = CALIBER_PULSE
	projectile_type = /obj/projectile/bullet/a84mm/pulse

/obj/projectile/bullet/a84mm/pulse
	name = "impact grenade"
	icon = 'necromorphs/icons/obj/projectiles.dmi'
	icon_state = "bolter"
	damage = 5
	armor_flag = BOMB

/obj/projectile/bullet/a84mm/pulse/do_boom(atom/target, blocked=0)
	if(!isliving(target)) //if the target isn't alive, so is a wall or something
		explosion(target, heavy_impact_range = 1, light_impact_range = 2, flame_range = 2, flash_range = 3, explosion_cause = src)
	else
		explosion(target, light_impact_range = 2, flame_range = 2, flash_range = 3,  explosion_cause = src)

/obj/projectile/bullet/pulse
	name = "pulse"
	icon = 'necromorphs/icons/obj/projectiles.dmi'
	icon_state = "pulse"
	damage = 8
	//It sonic fast
	speed = 1
	armour_penetration = 45
	shrapnel_type = null
	embedding = null
