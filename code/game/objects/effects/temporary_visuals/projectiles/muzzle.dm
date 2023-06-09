/obj/effect/projectile/muzzle
	name = "muzzle flash"
	icon = 'icons/obj/guns/projectiles_muzzle.dmi'

/obj/effect/projectile/muzzle/laser
	icon_state = "muzzle_laser"

/obj/effect/projectile/muzzle/laser/blue
	icon_state = "muzzle_laser_blue"

/obj/effect/projectile/muzzle/disabler
	icon_state = "muzzle_omni"

/obj/effect/projectile/muzzle/xray
	icon_state = "muzzle_xray"

/obj/effect/projectile/muzzle/pulse
	icon_state = "muzzle_u_laser"

/obj/effect/projectile/muzzle/plasma_cutter
	icon_state = "muzzle_plasmacutter"

/obj/effect/projectile/muzzle/stun
	icon_state = "muzzle_stun"

/obj/effect/projectile/muzzle/heavy_laser
	icon_state = "muzzle_beam_heavy"

/obj/effect/projectile/muzzle/wormhole
	icon_state = "wormhole_g"

/obj/effect/projectile/muzzle/laser/emitter
	name = "emitter flash"
	icon_state = "muzzle_emitter"

/obj/effect/projectile/muzzle/solar
	icon_state = "muzzle_solar"

/obj/effect/projectile/muzzle/sniper
	icon_state = "sniper"

// DS13 //

/obj/effect/projectile/ds_muzzle
	icon = 'icons/obj/guns_ds13/projectiles_effects.dmi'
	light_power = 0.7
	light_color = COLOR_DEEP_SKY_BLUE

/obj/effect/projectile/ds_muzzle/pulse
	icon_state = "muzzle_pulse"
	light_power = 0.7
	light_color = COLOR_DEEP_SKY_BLUE

/obj/effect/projectile/ds_muzzle/pulse/light
	icon_state = "muzzle_pulse_light"
	light_power = 0.6
	light_color = COLOR_DEEP_SKY_BLUE

/obj/effect/projectile/ds_muzzle/pulse/hv
	icon_state = "muzzle_pulse_hv"
	light_power = 0.6
	light_color = COLOR_MARKER_RED

/obj/effect/projectile/ds_muzzle/pulse/df
	icon_state = "muzzle_pulse_light"
	light_power = 0.6
	light_color = COLOR_YELLOW


/obj/effect/projectile/ds_muzzle/trilaser
	icon_state = "muzzle_plasmacutter"

/obj/effect/projectile/ds_muzzle/bullet//I dunno if this is used or unique but keepin it for now
	icon_state = "muzzle_bullet"
	//light_range = 5
	light_color = COLOR_MUZZLE_FLASH


/obj/effect/projectile/ds_muzzle/bio
	//light_range = 0
	light_power = 0
	light_color = COLOR_MUZZLE_FLASH
	icon = 'icons/effects/effects.dmi'
	icon_state = "spray"
	color = "#c3933f"
	alpha = 255
