/obj/item/storage/belt/holster/ds
	name = "holster belt"
	desc = "A holster able to carry handguns and some ammo."
	icon = 'deadspace/icons/obj/clothing/belts.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/belt.dmi'
	icon_state = "commandbelt"
	w_class = WEIGHT_CLASS_BULKY
	content_overlays = FALSE

/obj/item/storage/belt/holster/ds/Initialize()
	. = ..()
	atom_storage.max_slots = 6
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.set_holdable(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/gun/ballistic/revolver,
		/obj/item/ammo_box,
		/obj/item/ammo_casing/shotgun,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/clothing/gloves,
		/obj/item/flashlight/seclite,
		/obj/item/food/donut,
		/obj/item/grenade,
		/obj/item/holosign_creator/security,
		/obj/item/knife/combat,
		/obj/item/melee/baton,
		/obj/item/grenade,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_box,
		/obj/item/food/donut,
		/obj/item/knife/combat,
		/obj/item/flashlight/seclite,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/restraints/legcuffs/bola,
		/obj/item/holosign_creator/security,
		))

/obj/item/storage/belt/holster/ds/command/full/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/divet(src)

/obj/item/storage/belt/holster/ds/captain/full/PopulateContents()
	new /obj/item/gun/ballistic/revolver/antique(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)

/obj/item/storage/belt/holster/ds/security
	name = "security holster belt"
	icon_state = "securitybelt"

/obj/item/storage/belt/holster/ds/security/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded(src)
