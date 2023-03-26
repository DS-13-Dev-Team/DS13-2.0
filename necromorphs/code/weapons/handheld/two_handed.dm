/obj/item/fireaxe/hugewrench
	name = "huge wrench"
	icon = 'necromorphs/icons/obj/weapons/ds13handheld.dmi'
	icon_state = "big_wrench0"
	base_icon_state = "big_wrench"
	lefthand_file = 'necromorphs/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'necromorphs/icons/mob/inhands/equipment/tools_righthand.dmi'
	desc = "If everything else failed - bring a bigger wrench."
	attack_verb_continuous = list("bashes", "batters", "bludgeons", "whacks")
	attack_verb_simple = list("bash", "batter", "bludgeon", "whack")
	hitsound = 'sound/weapons/smash.ogg'

/obj/item/fireaxe/hugewrench/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=5, force_wielded=24, icon_wielded="[base_icon_state]1")

/obj/item/fireaxe/hugewrench/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/item/fireaxe/hugewrench/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] wrench [user.p_them()]self from head to toe! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (BRUTELOSS)

/obj/item/fireaxe/hugewrench/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(wielded) //destroys windows and grilles in one hit
		if(istype(A, /obj/structure/window) || istype(A, /obj/structure/grille))
			var/obj/structure/W = A
			W.atom_destruction("fireaxe")
