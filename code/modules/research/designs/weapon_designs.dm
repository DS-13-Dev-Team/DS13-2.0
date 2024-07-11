/////////////////////////////////////////
/////////////////Weapons/////////////////
/////////////////////////////////////////

/datum/design/flora_gun
	name = "Floral Somatoray"
	desc = "A tool that discharges controlled radiation which induces mutation in plant cells. Harmless to other organic life."
	id = "flora_gun"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 2000, /datum/material/glass = 500, /datum/material/uranium = 2000)
	build_path = /obj/item/gun/energy/floragun
	category = list(DCAT_BOTANICAL)
	mapload_design_flags = DESIGN_FAB_SERVICE

/datum/design/large_grenade
	name = "Large Chemical Grenade"
	desc = "A grenade that affects a larger area and use larger containers."
	id = "large_Grenade"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 3000)
	build_path = /obj/item/grenade/chem_grenade/large
	category = list(DCAT_WEAPON)
	mapload_design_flags = DESIGN_FAB_MEDICAL | DESIGN_FAB_OMNI

/datum/design/pyro_grenade
	name = "Pyro Grenade"
	desc = "An advanced grenade that is able to self ignite its mixture."
	id = "pyro_Grenade"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 2000, /datum/material/plasma = 500)
	build_path = /obj/item/grenade/chem_grenade/pyro
	category = list(DCAT_WEAPON)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_MEDICAL | DESIGN_FAB_OMNI

/datum/design/cryo_grenade
	name = "Cryo Grenade"
	desc = "An advanced grenade that rapidly cools its contents upon detonation."
	id = "cryo_Grenade"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 2000, /datum/material/silver = 500)
	build_path = /obj/item/grenade/chem_grenade/cryo
	category = list(DCAT_WEAPON)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_MEDICAL | DESIGN_FAB_OMNI

/datum/design/adv_grenade
	name = "Advanced Release Grenade"
	desc = "An advanced grenade that can be detonated several times, best used with a repeating igniter."
	id = "adv_Grenade"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 3000, /datum/material/glass = 500)
	build_path = /obj/item/grenade/chem_grenade/adv_release
	category = list(DCAT_WEAPON)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_MEDICAL | DESIGN_FAB_OMNI

/datum/design/suppressor // Do not add to sec fab
	name = "Suppressor"
	desc = "A reverse-engineered suppressor that fits on most small arms with threaded barrels."
	id = "suppressor"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 2000, /datum/material/silver = 500)
	build_path = /obj/item/suppressor
	category = list(DCAT_WEAPON)

/datum/design/cleric_mace
	name = "Cleric Mace"
	desc = "A mace fit for a cleric. Useful for bypassing plate armor, but too bulky for much else."
	id = "cleric_mace"
	build_type = AUTOLATHE
	materials = list(MAT_CATEGORY_ITEM_MATERIAL = 12000)
	build_path = /obj/item/melee/cleric_mace
	category = list("Imported")

//Pistol magazines

/datum/design/m10mm
	name = "8-round pistol magazine (10mm Auto)"
	desc = "A gun magazine."
	id = "m10mm"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 300)
	build_path = /obj/item/ammo_box/magazine/m10mm
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/m45
	name = "8-round pistol magazine (.45 ACP)"
	desc = "A gun magazine"
	id = "m45"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 300)
	build_path = /obj/item/ammo_box/magazine/m45
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/m9mm
	name = "8-round pistol magazine (9x19mm)"
	desc = "A gun magazine"
	id = "m9mm"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 300)
	build_path = /obj/item/ammo_box/magazine/m9mm
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/m9mm_aps
	name = "15-round pistol magazine (9x19mm)"
	desc = "A gun magazine"
	id = "m9mm_aps"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 350)
	build_path = /obj/item/ammo_box/magazine/m9mm_aps
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/m50
	name = "7-round pistol magazine (.50 AE)"
	desc = "A gun magazine"
	id = "m50"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 300)
	build_path = /obj/item/ammo_box/magazine/m50
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/divet
	name = "Divet magazine (pistol slug)"
	desc = "A gun magazine"
	id = "divet"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 250)
	build_path = /obj/item/ammo_box/magazine/divet
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/divet/extended
	name = "Divet magazine (extended)"
	desc = "A gun magazine"
	id = "divet_extended"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 300)
	build_path = /obj/item/ammo_box/magazine/divet/extended
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/divet/extended/expanded
	name = "Divet magazine (expanded)"
	desc = "A gun magazine"
	id = "divet_expanded"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 350)
	build_path = /obj/item/ammo_box/magazine/divet/extended/expanded
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/divet_rubber
	name = "Divet magazine (rubber)"
	desc = "A gun magazine"
	id = "divet_rubber"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 200)
	build_path = /obj/item/ammo_box/magazine/divet/rb
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/divet_blank
	name = "Divet magazine (blank/practice)"
	desc = "A gun magazine"
	id = "divet_blank"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 150)
	build_path = /obj/item/ammo_box/magazine/divet/blank
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

//lmg
	
/datum/design/mm712x82
	name = "Box magazine (7.12x82mm)"
	desc = "A light machinegun magazine"
	id = "mm712x82"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 400)
	build_path = /obj/item/ammo_box/magazine/mm712x82
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/mm712x82_rub
	name = "Box magazine (Rubber 7.12x82mm)"
	desc = "A light machinegun magazine"
	id = "mm712x82_rub"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 350)
	build_path = /obj/item/ammo_box/magazine/mm712x82/bouncy
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

//Rifle

/datum/design/m10mm_rifle
	name = "10-round magazine (10mm Auto)"
	desc = "A well-worn magazine fitted for the surplus rifle."
	id = "m10mm_rifle"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 350)
	build_path = /obj/item/ammo_box/magazine/m10mm/rifle
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/m556
	name = "30-round magazine (5.56x45mm)"
	desc = "A well-worn magazine fitted for the surplus rifle."
	id = "m556"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 350)
	build_path = /obj/item/ammo_box/magazine/m556
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

//SMG

/datum/design/wt550m9
	name = "20-round magazine (4.6x30mm)"
	desc = "A WT magazine."
	id = "wt550m9"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 350)
	build_path = /obj/item/ammo_box/magazine/wt550m9
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/plastikov9mm
	name = "50-round magazine (9x19mm)"
	desc = "A plastikov magazine."
	id = "plastikov9mm"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 450)
	build_path = /obj/item/ammo_box/magazine/plastikov9mm
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/uzim9mm
	name = "32-round magazine (9x19mm)"
	desc = "A UZI magazine."
	id = "uzim9mm"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 350)
	build_path = /obj/item/ammo_box/magazine/uzim9mm
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/smgm9mm
	name = "21-round magazine (9x19mm)"
	desc = "A SMG magazine."
	id = "smgm9mm"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 350)
	build_path = /obj/item/ammo_box/magazine/smgm9mm
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/smgm45
	name = "24-round magazine (.45 ACP)"
	desc = "A SMG magazine."
	id = "smgm45"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 350)
	build_path = /obj/item/ammo_box/magazine/smgm45
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/tommygunm45
	name = "50-round drum magazine (.45 ACP)"
	desc = "A tommygun magazine."
	id = "tommygunm45"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 400)
	build_path = /obj/item/ammo_box/magazine/tommygunm45
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

// Misc guns

/datum/design/m12g
	name = "Shotgun magazine (12g buckshot slugs)"
	desc = "A shotgun magazine."
	id = "m12g"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 300)
	build_path = /obj/item/ammo_box/magazine/m12g
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/sniper_rounds
	name = "6-round magazine (.50 BMG)"
	desc = "A sniper magazine."
	id = "sniper_rounds"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 300)
	build_path = /obj/item/ammo_box/magazine/sniper_rounds
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/recharge
	name = "Power pack"
	desc = "A rechargeable, detachable battery that serves as a magazine for laser rifles."
	id = "recharge"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 1000, /datum/material/silver = 10)
	build_path = /obj/item/ammo_box/magazine/recharge
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/* These ones don't have build_path and materials so you were unable to craft them but recipe was showed
/datum/design/rubbershot/sec
	name = "Rubber Slug"
	id = "sec_rshot"
	build_type = FABRICATOR
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/beanbag_slug/sec
	name = "Beanbag Slug"
	id = "sec_beanbag_slug"
	build_type = FABRICATOR
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI
*/

/datum/design/stunrevolver
	name = "Tesla Cannon Part Kit"
	desc = "The kit for a high-tech cannon that fires internal, reusable bolt cartridges in a revolving cylinder. The cartridges can be recharged using conventional rechargers."
	id = "stunrevolver"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 10000, /datum/material/silver = 10000)
	build_path = /obj/item/weaponcrafting/gunkit/tesla
	category = list(DCAT_WEAPON)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/nuclear_gun
	name = "Advanced Energy Gun Part Kit"
	desc = "The kit for an energy gun with an experimental miniaturized reactor."
	id = "nuclear_gun"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 2000, /datum/material/uranium = 3000, /datum/material/titanium = 1000)
	build_path = /obj/item/weaponcrafting/gunkit/nuclear
	category = list(DCAT_WEAPON)
	mapload_design_flags = DESIGN_FAB_SECURITY	| DESIGN_FAB_OMNI

/datum/design/stunshell
	name = "Stun Shell"
	desc = "A stunning shell for a shotgun."
	id = "stunshell"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 200)
	build_path = /obj/item/ammo_casing/shotgun/stunslug
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY
