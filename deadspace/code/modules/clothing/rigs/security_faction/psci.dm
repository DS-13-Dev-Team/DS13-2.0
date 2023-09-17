/datum/mod_theme/deadspace/pcsi
	name = "PSCI"
	desc = "A lightweight and flexible armoured rig suit used by CEC shipboard security during crackdowns and for use in hazardous environments."
	default_skin = "pcsi"
	armor = list(MELEE = 30, BULLET = 30, LASER = 20, ENERGY = 15, BOMB = 45, BIO = 100, FIRE = 100, ACID = 75)
	siemens_coefficient = 0

	skins = list(
		"pcsi" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = WOUND_LAYER,
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

/obj/item/mod/control/pre_equipped/ds/pcsi
	theme = /datum/mod_theme/deadspace/pcsi
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/welding,
	)
