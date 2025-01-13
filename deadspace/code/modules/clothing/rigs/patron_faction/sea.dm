// {Blackwolf602}
/datum/mod_theme/deadspace/heavy_diving
	name = "advanced hazard diving"
	desc = "The heavy-duty diving RIG is the standard among CEC deep sea mining operations. \
	It's plating has been reinforced to withstand extreme undersea pressures and concussive forces."
	default_skin = "heavy_diving"
	armor = list(BLUNT = 65, PUNCTURE = 45, SLASH = 60, LASER = 50, ENERGY = 50, BOMB = 55, BIO = 100, FIRE = 100, ACID = 60)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = 25

	variants = list(
		"heavy_diving" = list(
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

/obj/item/mod/control/pre_equipped/ds/heavy_diving
	theme = /datum/mod_theme/deadspace/heavy_diving
	initial_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/anomaly_locked/kinesis/prebuilt,
		/obj/item/mod/module/t_ray,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/drill,
	)

/datum/mod_theme/deadspace/elite_diving
	name = "elite diving"
	desc = "The elite diving RIG is the next generation of diving RIGs used among CEC deep sea mining operations. \
It's flexible reinforcements allow it to withstand extreme undersea pressures while retaining mobility."
	default_skin = "elite_diving"
	armor = list(BLUNT = 55, PUNCTURE = 45, SLASH = 50, LASER = 50, ENERGY = 50, BOMB = 55, BIO = 100, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = 25


	variants = list(
		"elite_diving" = list(
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

/obj/item/mod/control/pre_equipped/ds/elite_diving
	theme = /datum/mod_theme/deadspace/elite_diving
	initial_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/anomaly_locked/kinesis/prebuilt,
		/obj/item/mod/module/t_ray,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/drill,
	)

/datum/mod_theme/deadspace/sister
	name = "modified diving"
	desc = "a modified diving RIG with a cage on the shoulder and symbols drawn upon the suit. \
	It's flexible reinforcements allow it to withstand extreme undersea pressures while retaining mobility."
	default_skin = "strange"
	armor = list(BLUNT = 55, PUNCTURE = 45, SLASH = 50, LASER = 50, ENERGY = 50, BOMB = 55, BIO = 100, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = 25

	variants = list(
		"strange" = list(
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

/obj/item/mod/control/pre_equipped/ds/sister
	theme = /datum/mod_theme/deadspace/sister
	initial_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/anomaly_locked/kinesis/prebuilt,
		/obj/item/mod/module/t_ray,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/drill,
	)
