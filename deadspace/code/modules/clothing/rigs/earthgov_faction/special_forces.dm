/datum/mod_theme/deadspace/special_forces
	name = "Special Forces"
	desc = "A heavily armoured rig suit, designed for military use, this one is highly advance, and typically used in Undisclosed Operations."
	extended_desc = "Resource Integration Gear, or RIG for short is an integrated health management and strength augmentation system that assists users in previously impossible and dangerous environments, \
		this suit is a staple across the galaxy for civilian applications. These suits are oxygenated, \
		spaceworthy, resistant to fire and chemical threats."
	default_skin = "special_forces"
	armor = list(MELEE = 72.5, BULLET = 75, LASER = 72.5, ENERGY = 40, BOMB = 75, BIO = 100, FIRE = 25, ACID = 25, WOUND = 5)
	resistance_flags = NONE
	atom_flags = NONE
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	permeability_coefficient = 0.01
	siemens_coefficient = 0.5
	complexity_max = 20
	charge_drain = 1
	slowdown_inactive = 1.25
	slowdown_active = 0.25
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
	)

	skins = list(
		"special_forces" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/obj/item/mod/control/pre_equipped/special_forces
	theme = /datum/mod_theme/deadspace/special_forces
	initial_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/dna_lock,
	)
