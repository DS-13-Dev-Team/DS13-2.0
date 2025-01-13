/datum/mod_theme/deadspace/advanced_miner
	name = "advanced mining"
	desc = "Exclusive only to upper class miners who have passed rigorous training and performed multiple planet cracks."
	default_skin = "advanced_miner"
	armor = list(BLUNT = 60, PUNCTURE = 40, SLASH = 60, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 100, ACID = 45)
	resistance_flags = FIRE_PROOF|ACID_PROOF|LAVA_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = 25

	variants = list(
		"advanced_miner" = list(
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

/obj/item/mod/control/pre_equipped/ds/advanced_miner
	theme = /datum/mod_theme/deadspace/advanced_miner
	applied_core = /obj/item/mod/core/plasma
	initial_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/gps,
		/obj/item/mod/module/orebag,
		/obj/item/mod/module/clamp,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/anomaly_locked/kinesis/prebuilt,
	)
