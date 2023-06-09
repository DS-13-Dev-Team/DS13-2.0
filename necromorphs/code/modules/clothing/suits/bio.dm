/obj/item/clothing/suit/hooded/ds
	name = "bio suit"
	desc = "A suit that protects against biological contamination"
	icon = 'necromorphs/icons/obj/clothing/suits.dmi'
	worn_icon = 'necromorphs/icons/mob/onmob/suit.dmi'
	icon_state = "bio_ishi"
	hoodtype = /obj/item/clothing/head/hooded/ishi
	w_class = WEIGHT_CLASS_BULKY
	permeability_coefficient = 0.01
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 0.2
	allowed = list(/obj/item/tank/internals, /obj/item/reagent_containers/dropper, /obj/item/flashlight/pen, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/reagent_containers/glass/beaker, /obj/item/gun/syringe)
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 100, FIRE = 30, ACID = 100)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	strip_delay = 70
	equip_delay_other = 70
	resistance_flags = ACID_PROOF

/obj/item/clothing/suit/hooded/eg
	name = "Earthgov black bio suit"
	desc = "A suit that protects against biological contamination"
	icon = 'necromorphs/icons/obj/clothing/suits.dmi'
	worn_icon = 'necromorphs/icons/mob/onmob/suit.dmi'
	icon_state = "bio_black"
	hoodtype = /obj/item/clothing/head/hooded/eg
	w_class = WEIGHT_CLASS_BULKY
	permeability_coefficient = 0.01
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 0.2
	allowed = list(/obj/item/tank/internals, /obj/item/reagent_containers/dropper, /obj/item/flashlight/pen, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/reagent_containers/glass/beaker, /obj/item/gun/syringe)
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 100, FIRE = 30, ACID = 100)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	strip_delay = 70
	equip_delay_other = 70
	resistance_flags = ACID_PROOF

/obj/item/clothing/suit/hooded/eg/white
	name = "Earthgov bio hood"
	desc = "A suit that protects against biological contamination"
	icon_state = "bio_white"
	hoodtype = /obj/item/clothing/head/hooded/eg/white
