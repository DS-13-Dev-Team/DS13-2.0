/obj/item/clothing/under/rank/security/ds_kellion_jumpsuit
	name = "C.E.C. security contractor jumpsuit"
	desc = "A dark green uniform issued to C.E.C. security contractors."
	icon = 'deadspace/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/uniform.dmi'
	icon_state = "kellion_jumpsuit"

/obj/item/clothing/under/rank/security/head_of_security/ds_kellion_lead
	name = "C.E.C. security leader jumpsuit"
	desc = "A drab, yellow-gray uniform issued to C.E.C. security team leaders. It provides more protection due to the armored plates sown into it."
	icon = 'deadspace/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/uniform.dmi'
	icon_state = "kellion_lead"
	can_adjust = FALSE

/obj/item/clothing/under/rank/engineering/ds_kellion_tech
	name = "sweatshirt"
	desc = "A tight-fitting sweatshirt with no sleeves."
	icon = 'deadspace/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/uniform.dmi'
	icon_state = "kellion_tech"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/ds_rigsuit
	name = "Combat bodysuit"
	desc = "A tight bodysuit designed to be worn under a RIG suit."
	icon = 'deadspace/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/uniform.dmi'
	icon_state = "ds_rigundershirt"
	armor = list(MELEE = 10, BULLET = 10, LASER = 10,ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 50, ACID = 40)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	can_adjust = FALSE
