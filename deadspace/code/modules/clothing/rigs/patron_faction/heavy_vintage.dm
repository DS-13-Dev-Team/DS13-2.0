
/datum/mod_theme/deadspace/heavy_vintage
	name = "Antique Heavy-Duty CEC"
	desc = "A heavy-duty vintage CEC RIG that is used in the most hazardous engineering operations aboard CEC vessels. \
	Its heavier armor plating can withstand more blunt damage than most CEC suits, and can withstand radiation just as well. \
	As working conditions on CEC ships have improved, this RIG has been discontinued, but some heavy variants can still be found on old planet crackers."
	default_skin = "heavy_vintage"
	armor = list(MELEE = 66.5, BULLET = 70, LASER = 57.5, ENERGY = 25, BOMB = 90, BIO = 100, FIRE = 25, ACID = 25, WOUND = 5)
	complexity_max = 20

	skins = list(
		"heavy_vintage" = list(
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

/obj/item/mod/control/pre_equipped/ds/heavy_vintage
	theme = /datum/mod_theme/deadspace/heavy_vintage
	initial_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/anomaly_locked/kinesis/prebuilt,
		/obj/item/mod/module/t_ray,
	)
