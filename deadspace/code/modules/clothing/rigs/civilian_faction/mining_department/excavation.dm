/datum/mod_theme/deadspace/excavation
	name = "excavation"
	desc = "A modified, lightweight version of the engineering suit. Perfect for quick operations."
	default_skin = "excavation"
	armor = list(BLUNT = 47.5, PUNCTURE = 30, SLASH = 47.5, LASER = 37.5, ENERGY = 37.5, BOMB = 37.5, BIO = 100, FIRE = 100, ACID = 25)
	resistance_flags = FIRE_PROOF|LAVA_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	complexity_max = 20

	variants = list(
		"excavation" = list(
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

/obj/item/mod/control/pre_equipped/ds/excavation
	theme = /datum/mod_theme/deadspace/excavation
	applied_core = /obj/item/mod/core/plasma
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/gps,
		/obj/item/mod/module/orebag,
		/obj/item/mod/module/clamp,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/anomaly_locked/kinesis/prebuilt,
	)
