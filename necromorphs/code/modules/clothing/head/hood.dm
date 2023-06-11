/obj/item/clothing/head/hooded/clergyhood
	name = "clergy hood"
	desc = "It's hood that covers the head. It is made whole with the clergy robe and outfit."
	icon = 'necromorphs/icons/obj/clothing/hats.dmi'
	worn_icon = 'necromorphs/icons/mob/onmob/head.dmi'
	icon_state = "clergy"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/head/hooded/ishi
	name = "bio hood"
	desc = "a standard issued CEC biological protection hood"
	icon = 'necromorphs/icons/obj/clothing/hats.dmi'
	worn_icon = 'necromorphs/icons/mob/onmob/head.dmi'
	icon_state = "bio_ishi"
	permeability_coefficient = 0.01
	clothing_flags = THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT | SNUG_FIT | PLASMAMAN_HELMET_EXEMPT
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 100, FIRE = 30, ACID = 100)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE|HIDESNOUT
	resistance_flags = ACID_PROOF
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF

/obj/item/clothing/head/hooded/eg
	name = "Earthgov bio hood"
	desc = "a standard issued Earth gov biological protection hood, mind the face"
	icon = 'necromorphs/icons/obj/clothing/hats.dmi'
	worn_icon = 'necromorphs/icons/mob/onmob/head.dmi'
	icon_state = "bio_black"
	clothing_flags = THICKMATERIAL | SNUG_FIT
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 100, FIRE = 30, ACID = 100)
	flags_inv = HIDEEARS|HIDEHAIR
	resistance_flags = ACID_PROOF
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF

/obj/item/clothing/head/hooded/eg/white
	name = "Earthgov bio hood"
	icon = 'necromorphs/icons/obj/clothing/hats.dmi'
	worn_icon = 'necromorphs/icons/mob/onmob/head.dmi'
	icon_state = "bio_white"



