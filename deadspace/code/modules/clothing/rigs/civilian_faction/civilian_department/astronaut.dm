/datum/mod_theme/deadspace/astronaut
	name = "astronaut"
	desc = "A very light, emergency rig for use by non-qualified personnel in the case of emergency decompression. Soft materials barely impede movement."
	default_skin = "astro"
	armor = list(BLUNT = 20, PUNCTURE = 5, SLASH = 15, LASER = 20, ENERGY = 20, BOMB = 10, BIO = 100, FIRE = 60, ACID = 30)

	variants = list(
		"astro" = list(
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

/obj/item/mod/control/pre_equipped/ds/astronaut
	theme = /datum/mod_theme/deadspace/astronaut
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/tether,
	)
