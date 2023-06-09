/obj/item/gun/ballistic/automatic/pulse
	name = "SWS Motorized Pulse Rifle"
	desc = "The SWS Motorized Pulse Rifle is a military-grade, triple-barreled assault rifle, manufactured by Winchester Arms, is capable of a rapid rate of fire. \
			The Pulse Rifle is the standard-issue service rifle of the Earth Defense Force and is also common among corporate security officers. "
	icon = 'necromorphs/icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "pulserifle"
	lefthand_file = 'necromorphs/icons/mob/onmob/items/lefthand_guns.dmi'
	righthand_file = 'necromorphs/icons/mob/onmob/items/righthand_guns.dmi'
	inhand_icon_state = "pulserifle"
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = 0
	mag_display = FALSE
	mag_type = /obj/item/ammo_box/magazine/pulse
	weapon_weight = WEAPON_HEAVY
	show_bolt_icon = FALSE
	burst_size = 3
	bolt_type = BOLT_TYPE_OPEN
	can_suppress = FALSE
	spread = 5
	fire_sound = 'necromorphs/sound/weapons/guns/pulse_shot.ogg'

/obj/item/gun/ballistic/automatic/pulse/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.1 SECONDS)

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
