/obj/effect/spawner/random/deadspace/ammo
	name = "Random Ammunition"
	desc = "This is random ammunition."
	icon_state = "clusterbang"
	loot = list(
		/obj/effect/spawner/random/deadspace/ammo/security = 50,
		/obj/effect/spawner/random/deadspace/ammo/mining = 50,
	)

/obj/effect/spawner/random/deadspace/ammo/security
	name = "Random Security Ammunition"
	desc = "This is random ammunition."
	icon_state = "clusterbang"
	loot = list(
		/obj/item/ammo_box/magazine/pulse = 2,
		/obj/item/ammo_box/magazine/pulse/hv = 0.3,
		/obj/item/ammo_box/magazine/pulse/df = 0.3,
		/obj/item/ammo_box/magazine/pulse/blank = 0.1,
		/obj/item/ammo_box/magazine/divet = 2,
		/obj/item/ammo_box/magazine/divet/extended = 1,
		/obj/item/ammo_box/magazine/divet/extended/expanded = 0.5,
		/obj/item/ammo_box/magazine/divet/hp = 0.3,
		/obj/item/ammo_box/magazine/divet/ap = 0.3,
		/obj/item/ammo_box/magazine/divet/blank = 0.1,
		/obj/item/ammo_box/magazine/ds12g = 2,
		/obj/item/ammo_box/magazine/ds12g/frag12 = 0.1,
		/obj/item/ammo_box/magazine/ds12g/improvised = 0.7,
		/obj/item/ammo_box/magazine/seeker = 2,
	)

/obj/effect/spawner/random/deadspace/ammo/mining
	name = "Random mining Ammunition"
	desc = "This is random ammunition."
	icon_state = "clusterbang"
	loot = list(
		/obj/item/ammo_casing/energy/plasma = 2,
		/obj/item/ammo_box/magazine/rivet = 2,
		/obj/item/ammo_box/magazine/javelin = 2,
	)
