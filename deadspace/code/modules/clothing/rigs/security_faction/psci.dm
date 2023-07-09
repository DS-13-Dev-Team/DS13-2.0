/datum/mod_theme/deadspace/pcsi
	name = "PSCI"
	desc = "A lightweight and flexible armoured rig suit used by CEC shipboard security during crackdowns and for use in hazardous environments."
	extended_desc = "Resource Integration Gear, or RIG for short is an integrated health management and strength augmentation system that assists users in previously impossible and dangerous environments, \
		this suit is a staple across the galaxy for civilian applications. These suits are oxygenated, \
		spaceworthy, resistant to fire and chemical threats."
	default_skin = "pcsi"
	armor = list(MELEE = 60, BULLET = 64, LASER = 60, ENERGY = 5, BOMB = 60, BIO = 100, FIRE = 25, ACID = 25, WOUND = 5, RAD = 60)
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
	)

	skins = list(
		"pcsi" = list(
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

/obj/item/mod/control/pre_equipped/pcsi
	theme = /datum/mod_theme/deadspace/pcsi
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/flashlight,
	)
