/obj/item/fireaxe/hugewrench
	name = "huge wrench"
	icon = 'deadspace/icons/obj/weapons/ds13handheld.dmi'
	icon_state = "big_wrench0"
	base_icon_state = "big_wrench"
	lefthand_file = 'deadspace/icons/mob/onmob/items/lefthand.dmi'
	righthand_file = 'deadspace/icons/mob/onmob/items/righthand.dmi'
	worn_icon = 'deadspace/icons/mob/onmob/back.dmi'
	desc = "If everything else failed - bring a bigger wrench."
	attack_verb_continuous = list("bashes", "batters", "bludgeons", "whacks")
	attack_verb_simple = list("bash", "batter", "bludgeon", "whack")
	hitsound = 'sound/weapons/smash.ogg'

/obj/item/fireaxe/hugewrench/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] wrench [user.p_them()]self from head to toe! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (BRUTELOSS)
