/obj/projectile/bullet/shotgun_slug
	name = "12g shotgun slug"
	damage = 50
	sharpness = SHARP_POINTY

/obj/projectile/bullet/shotgun_slug/executioner
	name = "executioner slug" // admin only, can dismember limbs
	sharpness = SHARP_EDGED

/obj/projectile/bullet/shotgun_slug/pulverizer
	name = "pulverizer slug" // admin only, can crush bones
	sharpness = NONE

/obj/projectile/bullet/shotgun_beanbag
	name = "beanbag slug"
	damage = 10
	stamina = 55
	sharpness = NONE
	embedding = null

/obj/projectile/bullet/incendiary/shotgun
	name = "incendiary slug"
	damage = 20

/obj/projectile/bullet/incendiary/shotgun/dragonsbreath
	name = "dragonsbreath pellet"
	damage = 5

/obj/projectile/bullet/shotgun_stunslug
	name = "stunslug"
	damage = 5
	paralyze = 100
	stutter = 10 SECONDS
	jitter = 40 SECONDS
	range = 7
	icon_state = "spark"
	color = "#FFFF00"
	embedding = null

/obj/projectile/bullet/shotgun_meteorslug
	name = "meteorslug"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "dust"
	damage = 30
	paralyze = 15
	knockdown = 80
	hitsound = 'sound/effects/meteorimpact.ogg'

/obj/projectile/bullet/shotgun_meteorslug/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismovable(target))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 3, 2, force = MOVE_FORCE_EXTREMELY_STRONG)

/obj/projectile/bullet/shotgun_meteorslug/Initialize(mapload)
	. = ..()
	SpinAnimation()

/obj/projectile/bullet/shotgun_frag12
	name ="frag12 slug"
	damage = 15
	paralyze = 10

/obj/projectile/bullet/shotgun_frag12/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, devastation_range = -1, light_impact_range = 1, explosion_cause = src)
	return BULLET_ACT_HIT

/obj/projectile/bullet/pellet
	var/tile_dropoff = 0.45
	var/tile_dropoff_s = 0.25

/obj/projectile/bullet/pellet/Range()
	..()
	if(damage > 0)
		damage -= tile_dropoff
	if(stamina > 0)
		stamina -= tile_dropoff_s
	if(damage < 0 && stamina < 0)
		qdel(src)

/obj/projectile/bullet/pellet/shotgun_buckshot
	name = "buckshot pellet"
	damage = 7.5

/obj/projectile/bullet/pellet/shotgun_rubbershot
	name = "rubbershot pellet"
	damage = 3
	stamina = 11
	sharpness = NONE
	embedding = null
	speed = 1.2
	ricochets_max = 4
	ricochet_chance = 120
	ricochet_decay_chance = 0.9
	ricochet_decay_damage = 0.8
	ricochet_auto_aim_range = 2
	ricochet_auto_aim_angle = 30
	ricochet_incidence_leeway = 75
	/// Subtracted from the ricochet chance for each tile traveled
	var/tile_dropoff_ricochet = 4

/obj/projectile/bullet/pellet/shotgun_rubbershot/Range()
	if(ricochet_chance > 0)
		ricochet_chance -= tile_dropoff_ricochet
	. = ..()

/obj/projectile/bullet/pellet/shotgun_incapacitate
	name = "incapacitating pellet"
	damage = 1
	stamina = 6
	embedding = null

/obj/projectile/bullet/shotgun_bola
	name = "bola"
	icon = 'icons/obj/guns_ds13/projectiles.dmi'
	icon_state = "bola"
	// fire_sound = 'sound/weapons/bolathrow.ogg'
	damage = 1
	stamina = 60
	embedding = null
	sharpness = NONE
	speed = 0.6
	ricochets_max = 2
	ricochet_chance = 80
	ricochet_auto_aim_range = 1

/obj/projectile/bullet/shotgun_bola/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/obj/item/restraints/legcuffs/bola/L //= new (get_turf(src))
	if(ishuman(target))
		L.ensnare(target)

// /obj/projectile/bullet/a40mm/on_hit(atom/target, blocked = FALSE)
// 	..()
// 	explosion(target, devastation_range = -1, light_impact_range = 2, flame_range = 3, flash_range = 1, adminlog = FALSE, explosion_cause = src)
// 	return BULLET_ACT_HIT

////////From main gun doing bola stuff. Likely don't need bola gun really, but ay be possibility
// /obj/item/gun/ballistic/shotgun/scl_shotgun/bola
// 	name = "bola test shotgun"
// 	var/list/bolas = new/list()
// 	var/max_bolas = 7
// 	throw_speed = 2
// 	throw_range = 7

// /obj/item/gun/ballistic/shotgun/scl_shotgun/bola/attackby(obj/item/I, mob/user, params)
// 	if((istype(I, /obj/item/restraints/legcuffs/bola)))
// 		if(bolas.len < max_bolas)
// 			if(!user.transferItemToLoc(I, src))
// 				return
// 			bolas += I
// 			to_chat(user, span_notice("You put the bola in the bola launcher."))
// 			to_chat(user, span_notice("[bolas.len] / [max_bolas] Bolas."))
// 		else
// 			to_chat(usr, span_warning("The bola launcher cannot hold more bolas!"))

// /obj/item/gun/ballistic/shotgun/scl_shotgun/bola/can_shoot()
// 	return bolas.len

// /obj/item/gun/ballistic/shotgun/scl_shotgun/bola/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
// 	user.visible_message(span_danger("[user] fired a bola!"),
// 						span_danger("You fire the bola launcher!"))
// 	var/obj/item/restraints/legcuffs/bola/F = bolas[1] //Now with less copypasta!
// 	bolas -= F
// 	F.forceMove(user.loc)
// 	F.throw_at(target, 30, 2, user)
// 	message_admins("[ADMIN_LOOKUPFLW(user)] fired a bola ([F.name]) from a bola launcher ([src]) from [AREACOORD(user)] at [target] [AREACOORD(target)].")
// 	log_game("[key_name(user)] fired a bola ([F.name]) with a bola launcher ([src]) from [AREACOORD(user)] at [target] [AREACOORD(target)].")
// 	playsound(user.loc, 'sound/weapons/gun/shotgun/shot_alt.ogg', 75, TRUE, -3)


/obj/projectile/bullet/pellet/shotgun_improvised
	tile_dropoff = 0.35 //Come on it does 6 damage don't be like that.
	damage = 6

/obj/projectile/bullet/pellet/shotgun_improvised/Initialize(mapload)
	. = ..()
	range = rand(1, 8)

/obj/projectile/bullet/pellet/shotgun_improvised/on_range()
	do_sparks(1, TRUE, src)
	..()

// Mech Scattershot

/obj/projectile/bullet/scattershot
	damage = 24
