
/datum/mod_theme/deadspace/hacker
	name = "hacker"
	desc = "A lightweight suit cobbled together from civilian parts, with some high end tech hidden within, suprisngly not illegal."
	default_skin = "hacker"
	armor = list(BLUNT = 20, PUNCTURE = 5, SLASH = 15, LASER = 20, ENERGY = 20, BOMB = 10, BIO = 100, FIRE = 15, ACID = 15)
	max_heat_protection_temperature = 0
	min_cold_protection_temperature = 0

	variants = list(
		"hacker" = list(
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = WOUND_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/obj/item/mod/control/pre_equipped/ds/hacker
	theme = /datum/mod_theme/deadspace/hacker
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/tether,
	)
