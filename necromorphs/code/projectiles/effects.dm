
//----------------------------
// Biological projectiles
//----------------------------
/obj/effect/projectile/muzzle/bio
	light_inner_range = 0
	light_power = 0
	light_color = COLOR_MUZZLE_FLASH
	icon = 'icons/effects/effects.dmi'
	icon_state = "spray"
	color = "#c3933f"
	alpha = 255

//----------------------------
// Acid Bolts
//----------------------------
/obj/effect/projectile/impact/acid
	icon_state = "impact_acid_1"
	light_color = "#ff00dc"
	light_power = 0
	light_inner_range = 0
	var/list/random_iconstate = list("impact_acid_1","impact_acid_2","impact_acid_3","impact_acid_4")

/obj/effect/projectile/impact/acid/Initialize(mapload)
	icon_state = pick(random_iconstate)
	. = ..()

/obj/effect/projectile/impact/acid/small/New(angle_override, p_x, p_y, color_override, scaling = 0.75)
	. = ..()
