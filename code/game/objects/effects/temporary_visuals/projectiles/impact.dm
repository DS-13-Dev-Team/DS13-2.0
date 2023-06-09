/obj/effect/projectile/impact
	name = "beam impact"
	icon = 'icons/obj/guns/projectiles_impact.dmi'

/obj/effect/projectile/impact/laser
	name = "laser impact"
	icon_state = "impact_laser"

/obj/effect/projectile/impact/laser/blue
	name = "laser impact"
	icon_state = "impact_blue"

/obj/effect/projectile/impact/disabler
	name = "disabler impact"
	icon_state = "impact_omni"

/obj/effect/projectile/impact/xray
	name = "\improper X-ray impact"
	icon_state = "impact_xray"

/obj/effect/projectile/impact/pulse
	name = "pulse impact"
	icon_state = "impact_u_laser"

/obj/effect/projectile/impact/plasma_cutter
	name = "plasma impact"
	icon_state = "impact_plasmacutter"

/obj/effect/projectile/impact/stun
	name = "stun impact"
	icon_state = "impact_stun"

/obj/effect/projectile/impact/heavy_laser
	name = "heavy laser impact"
	icon_state = "impact_beam_heavy"

/obj/effect/projectile/impact/wormhole
	icon_state = "wormhole_g"

/obj/effect/projectile/impact/laser/emitter
	name = "emitter impact"
	icon_state = "impact_emitter"

/obj/effect/projectile/impact/solar
	name = "solar impact"
	icon_state = "impact_solar"

/obj/effect/projectile/impact/sniper
	icon_state = "sniper"

// DS13 //

/obj/effect/projectile/ds_impact
	name = "impact"
	icon = 'icons/obj/guns_ds13/projectiles_effects.dmi'

/obj/effect/projectile/ds_impact/pulse
	icon_state = "pulse_hit"

/obj/effect/projectile/ds_impact/shotgun
	icon_state = "shotgun_hit"

/obj/effect/projectile/ds_impact/divet
	icon_state = "divet_hit"

//----------------------------
// Treye beam
//----------------------------
/obj/effect/projectile/trilaser
	light_color = COLOR_LUMINOL

/obj/effect/projectile/ds_impact/trilaser
	icon_state = "impact_plasmacutter"

//----------------------------
// Acid Bolts
//----------------------------
// /obj/effect/projectile/acid/impact
// 	icon_state = "impact_acid_1"
// 	light_color = "#ff00dc"
// 	light_power = 0
// 	light_range = 0
// 	lifespan = 12
// 	random_iconstate = list("impact_acid_1","impact_acid_2","impact_acid_3","impact_acid_4")

// /obj/effect/projectile/acid/impact/set_transform(var/matrix/M)
// 	M *= default_scale
// 	.=..()

// /obj/effect/projectile/acid/impact/small
// 	default_scale = 0.75
