/obj/item/mob_holder/drone/scavbot
	examine_mob = FALSE

/obj/item/mob_holder/drone/scavbot/deposit(mob/living/target_mob)
	. = ..()
	name = "scavenger bot"
	desc = "The drone has folded into a holdable mode"
	icon = 'deadspace/icons/mob/dsbots.dmi'
	icon_state = "spiderbot_console"

/obj/item/mob_holder/janibot
	examine_mob = FALSE

/obj/item/mob_holder/janibot/Initialize(mapload, mob/living/target_mob, worn_state, head_icon, lh_icon, rh_icon, worn_slot_flags)
	if(!isbot(target_mob))
		return INITIALIZE_HINT_QDEL
	return ..()

/obj/item/mob_holder/janibot/deposit(mob/living/target_mob)
	. = ..()
	name = "Janibot"
	desc = "The bot has folded into a holdable mode"
	icon = 'deadspace/icons/mob/dsbots.dmi'
	icon_state = "cleanbot_console"
