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

//Divet magazines

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

//SCL shotgun

/datum/design/ds12g/beanbag
	name = "Magazine SCL-shotgun beanbag"
	desc = "A shotgun magazine"
	id = "ds12g_beanbag"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 150)
	build_path = /obj/item/ammo_box/magazine/ds12g/beanbag
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/ds12g/rb
	name = "Magazine SCL-shotgun rubbershot"
	desc = "A shotgun magazine"
	id = "ds12g_rb"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 200)
	build_path = /obj/item/ammo_box/magazine/ds12g/rb
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/ds12g/stunslug //Idk what's their difference so i added both
	name = "Magazine SCL-shotgun stunslug"
	desc = "A shotgun magazine"
	id = "ds12g_stunslug"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 250)
	build_path = /obj/item/ammo_box/magazine/ds12g/stunslug
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/ds12g/slug
	name = "Magazine SCL-shotgun slug"
	desc = "A shotgun magazine"
	id = "ds12g_slug"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 300)
	build_path = /obj/item/ammo_box/magazine/ds12g/slug
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/ds12g/pulseslug
	name = "Magazine SCL-shotgun pulseslug"
	desc = "A shotgun magazine"
	id = "ds12g_pulseslug"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 300)
	build_path = /obj/item/ammo_box/magazine/ds12g/pulseslug
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/ds12g
	name = "Magazine SCL-shotgun buckshot"
	desc = "A shotgun magazine"
	id = "ds12g"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 350)
	build_path = /obj/item/ammo_box/magazine/ds12g
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI



/datum/design/pulse_heavy
	name = "Heavy Pulse Rifle power cell"
	desc = "A heavy power pack designed for use with the Heavy Pulse Rifle."
	id = "pulse_heavy"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 9000, /datum/material/silver = 900)
	build_path = /obj/item/stock_parts/cell/pulse_heavy
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/javelin
	name = "Javelin rack"
	desc = "A set of javelins for the T15 Javelin Gun."
	id = "javelin"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_box/magazine/javelin
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/pulse
	name = "Pulse magazine (standard)"
	desc = "With a distinctive \"bell and stock\" design, pulse magazines can be inserted and removed from the Pulse Rifle with minimal effort and risk."
	id = "pulse"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_box/magazine/pulse
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/a357
	name = "Speed loader (.357)"
	desc = "Designed to quickly reload revolvers."
	id = "a357"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 100)
	build_path = /obj/item/ammo_box/a357
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/seeker
	name = "Seeker shells"
	desc = "High caliber armor piercing shells designed for use in the Seeker Rifle."
	id = "seeker"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 400)
	build_path = /obj/item/ammo_box/magazine/seeker
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

//Rivet

/datum/design/rivet_gun
	name = "711-MarkCL Rivet Gun"
	desc = "The latest refinement from Timson Tools' long line of friendly tools."
	id = "rivet_gun"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 10000)
	build_path = /obj/item/gun/ballistic/automatic/pistol/rivet
	category = list(DCAT_WEAPON)
	mapload_design_flags = DESIGN_FAB_ENGINEERING | DESIGN_FAB_OMNI //Weapon is weapon, even it's an engineers' weapon

/datum/design/rivet
	name = "Rivet magazine"
	desc = "A rivet magazine"
	id = "rivet_gun"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 300)
	build_path = /obj/item/ammo_box/magazine/rivet
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_ENGINEERING | DESIGN_FAB_OMNI

//Underbarrel

/datum/design/shotgun_bola
	name = "Bola"
	desc = "A shotgun bola"
	id = "shotgun_bola"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 300)
	build_path = /obj/projectile/bullet/shotgun_bola
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/pulse_rocket
	name = "Rocket"
	desc = "A pulse rocket"
	id = "pulse_rocket"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 10000)
	build_path = /obj/item/ammo_casing/caseless/rocket/pulse
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

//Other things

/datum/design/stunrevolver
	name = "Tesla Cannon Part Kit"
	desc = "The kit for a high-tech cannon that fires internal, reusable bolt cartridges in a revolving cylinder. The cartridges can be recharged using conventional rechargers."
	id = "stunrevolver"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 10000, /datum/material/silver = 10000)
	build_path = /obj/item/weaponcrafting/gunkit/tesla
	category = list(DCAT_WEAPON)
	mapload_design_flags = DESIGN_FAB_SECURITY | DESIGN_FAB_OMNI

/datum/design/stunshell
	name = "Stun Shell"
	desc = "A stunning shell for a shotgun."
	id = "stunshell"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 50)
	build_path = /obj/item/ammo_casing/shotgun/stunslug
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY

/datum/design/shell
	name = "Shotgun shell"
	desc = "A shell for a shotgun."
	id = "stunshell"
	build_type = FABRICATOR
	materials = list(/datum/material/iron = 100)
	build_path = /obj/item/ammo_casing/shotgun
	category = list(DCAT_AMMO)
	mapload_design_flags = DESIGN_FAB_SECURITY
