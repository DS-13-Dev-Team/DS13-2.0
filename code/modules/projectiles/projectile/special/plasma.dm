/obj/projectile/beam/cutter
	name = "plasma arc"
	icon = null
	damage = 12
	hitscan = TRUE
	dismemberment = 20
	damage_type = BRUTE //plasma is a physical object with mass, rather than purely burning. this also means you can decapitate/sever limbs, not just ash them.
	armor_flag = LASER
	range = 5 //mining tools are not exactly known for their ability to replace firearms, they're good against necros, not so much against anything else.
	pass_flags = PASSTABLE
	var/mine_range = 5
	muzzle_type = /obj/effect/projectile/plasmacutter/muzzle
	tracer_type = null
	impact_type = /obj/effect/projectile/plasmacutter/impact

/obj/projectile/beam/cutter/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer, FALSE)
		if(mine_range)
			mine_range--
			range++
		if(range > 0)
			return BULLET_ACT_FORCE_PIERCE

/obj/projectile/beam/cutter/adv
	damage = 18.5
	range = 7
	mine_range = 7

/obj/projectile/beam/cutter/adv/mech
	damage = 10
	range = 9
	mine_range = 3

/obj/projectile/beam/cutter/turret
	//Between normal and advanced for damage, made a beam so not the turret does not destroy glass
	name = "plasma beam"
	damage = 24
	range = 7
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
