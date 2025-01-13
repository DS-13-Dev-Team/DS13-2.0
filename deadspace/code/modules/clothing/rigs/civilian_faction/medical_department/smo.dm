// Doesn't have a speific sprite for it, Using the basic medical one.
/datum/mod_theme/deadspace/med_smo
	name = "SMO"
	desc = "A durable RIG designed for medical rescue in high risk areas, and protecting the wearer against acids. This one was made for the SMO and is well taken care of."
	default_skin = "med"
	armor = list(BLUNT = 40, PUNCTURE = 10, SLASH = 25, LASER = 25, ENERGY = 10, BOMB = 30, BIO = 100, FIRE = 40, ACID = 80)
	complexity_max = 20

	variants = list(
		"med" = list(
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

/obj/item/mod/control/pre_equipped/ds/med_smo
	theme = /datum/mod_theme/deadspace/med_smo
	initial_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot/advanced,
		/obj/item/mod/module/health_analyzer,
		/obj/item/mod/module/quick_carry,
		/obj/item/mod/module/injector,
		/obj/item/mod/module/organ_thrower,
	)
