/obj/item/storage/belt/holster/ds
	name = "holster"
	desc = "A holster able to carry handguns and some ammo."
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/holster/detective/Initialize()
	. = ..()
	atom_storage.max_slots = 3
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.set_holdable(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/ammo_box/magazine/m9mm, // Pistol magazines.
		/obj/item/ammo_box/magazine/m9mm_aps,
		/obj/item/ammo_box/magazine/m45,
		/obj/item/ammo_box/magazine/m50,
		/obj/item/gun/ballistic/revolver,
		/obj/item/ammo_box/c38, // Revolver speedloaders.
		/obj/item/ammo_box/a357,
		/obj/item/ammo_box/a762,
		/obj/item/ammo_box/magazine/toy/pistol,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/dueling,
		/obj/item/gun/energy/laser/thermal
		))
