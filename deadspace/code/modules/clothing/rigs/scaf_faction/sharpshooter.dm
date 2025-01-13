/datum/mod_theme/deadspace/scaf_sharpshooter
	name = "sharpshooter"
	desc = "Designed for S.C.A.F.'s UN14 Special Ops Division; features high-impact armor for maximum protection and the 'No Retreat' motto of the UN14 troops."
	default_skin = "scaf_sharpshooter"
	armor = list(BLUNT = 45, PUNCTURE = 55, SLASH = 40, LASER = 20, ENERGY = 15, BOMB = 35, BIO = 100, FIRE = 75, ACID = 30)
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	siemens_coefficient = 0

	variants = list(
		"scaf_sharpshooter" = list(
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

/obj/item/mod/control/pre_equipped/ds/scaf_sharpshooter
	theme = /datum/mod_theme/deadspace/scaf_sharpshooter
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/welding,
	)
