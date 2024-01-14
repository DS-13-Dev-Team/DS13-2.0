/obj/item/clothing/suit/hooded/chaplainsuit/clergy
	name = "clergy robe"
	desc = "Worship the marker in style."
	icon = 'deadspace/icons/obj/clothing/suits.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/suit.dmi'
	icon_state = "clergy"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	hoodtype = /obj/item/clothing/head/hooded/clergyhood

/obj/item/clothing/suit/toggle/cseco
	name = "armored security jacket"
	desc = "An armored jacket often worn by the Chief Security Officer that combines style and protection."
	icon = 'deadspace/icons/obj/clothing/suits.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/suit.dmi'
	icon_state = "csecojacket"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = list(BLUNT = 25, PUNCTURE = 30, SLASH = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, FIRE = 70, ACID = 30)
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	strip_delay = 80

/obj/item/clothing/suit/toggle/kellion
	name = "C.E.C. armored vest"
	desc = "A set of armor issued to security teams assigned to guarding C.E.C. maintenance teams."
	icon = 'deadspace/icons/obj/clothing/suits.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/suit.dmi'
	icon_state = "kellion_grunt"

/obj/item/clothing/suit/toggle/kellion_jacket
	name = "light jacket"
	desc = "A thin, white and green jacket."
	icon = 'deadspace/icons/obj/clothing/suits.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/suit.dmi'
	icon_state = "kelliontech_jacket"

/obj/item/clothing/suit/toggle/ds_cargo_jacket
	name = "fur-lined coat"
	desc = "A snazzy coat with a nice fur lining on the inside and near the neck. The zipper looks like gold."
	icon = 'deadspace/icons/obj/clothing/suits.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/suit.dmi'
	icon_state = "cargojacket"
