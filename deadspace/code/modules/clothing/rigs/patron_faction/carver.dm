// {SASoperative}
/datum/mod_theme/deadspace/carver
	name = "Spec Ops"
	desc = "A heavily armoured rig suit, designed for military use. Especially effective against bullets."
	default_skin = "carver"
	armor = list(BLUNT = 50, PUNCTURE = 65, SLASH = 40, LASER = 20, ENERGY = 15, BOMB = 40, BIO = 100, FIRE = 35, ACID = 45)
	siemens_coefficient = 0

	variants = list(
		"carver" = list(
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

/obj/item/mod/control/pre_equipped/ds/carver
	theme = /datum/mod_theme/deadspace/carver
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/welding,
	)
