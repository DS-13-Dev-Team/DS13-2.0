// just a filler for naming conventions
/datum/mod_theme/deadspace
	name = "RIG"
	desc = "A RIG"
	extended_desc = "Resource Integration Gear, or RIG for short, \
		is an integrated health management and strength augmentation system that assists users in previously impossible and dangerous environments, \
		this suit is a staple across the galaxy for civilian applications. These suits are oxygenated, \
		spaceworthy, resistant to fire and chemical threats."
	resistance_flags = NONE
	atom_flags = NONE
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	permeability_coefficient = 0.01
	siemens_coefficient = 0.5
	complexity_max = DEFAULT_MAX_COMPLEXITY
	charge_drain = 1
	slowdown_inactive = 1.25
	slowdown_active = 0.25
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/construction/rcd,
		/obj/item/storage/bag/construction,
		/obj/item/analyzer,
		/obj/item/t_scanner,
		/obj/item/pipe_dispenser,
		/obj/item/melee/baton/telescopic,
		/obj/item/resonator,
		/obj/item/mining_scanner,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/pickaxe,
		/obj/item/kinetic_crusher,
		/obj/item/stack/ore,
		/obj/item/storage/bag/ore,
		/obj/item/mail,
		/obj/item/delivery/small,
		/obj/item/paper,
		/obj/item/storage/bag/mail,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/stack/medical,
		/obj/item/sensor_device,
		/obj/item/storage/pill_bottle,
		/obj/item/storage/bag/chemistry,
		/obj/item/storage/bag/bio,
		/obj/item/dnainjector,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/bikehorn,
		/obj/item/food/grown/banana,
		/obj/item/grown/bananapeel,
		/obj/item/reagent_containers/spray/waterflower,
		/obj/item/instrument,
		/obj/item/shield,
		/obj/item/gun/ballistic,
		/obj/item/circular_saw,
		/obj/item/crowbar,
		/obj/item/screwdriver,
		/obj/item/weldingtool,
		/obj/item/wirebrush,
		/obj/item/wirecutters,
		/obj/item/wrench,
		/obj/item/multitool,
		/obj/item/stack/cable_coil,
		/mob/living/simple_animal/drone/classic/scavbot,
	)
