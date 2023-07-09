/datum/mod_theme/deadspace/scaf_legionary
	name = "SCAF Legionary"
	desc = "an armored exosuit that was last fielded by S.C.A.F. forces in the 24th Century."
	extended_desc = "Resource Integration Gear, or RIG for short is an integrated health management and strength augmentation system that assists users in previously impossible and dangerous environments, \
		this suit is a staple across the galaxy for civilian applications. These suits are oxygenated, \
		spaceworthy, resistant to fire and chemical threats."
	default_skin = "scaf_legionnaire"
	armor = list(MELEE = 65, BULLET = 55, LASER = 55, ENERGY = 30, BOMB = 65, BIO = 100, FIRE = 25, ACID = 25, WOUND = 5, RAD = 60)
	resistance_flags = NONE
	atom_flags = NONE
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	permeability_coefficient = 0.01
	siemens_coefficient = 0.5
	complexity_max = DEFAULT_MAX_COMPLEXITY
	charge_drain = 1
	slowdown_inactive = 1.25
	slowdown_active = 0.25
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
	)

	skins = list(
		"scaf_legionnaire" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
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

/obj/item/mod/control/pre_equipped/scaf_legionnaire
	theme = /datum/mod_theme/deadspace/scaf_legionary
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/flashlight,
	)
