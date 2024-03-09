/obj/item/mob_holder/drone/scavbot
	examine_mob = FALSE

/obj/item/mob_holder/drone/scavbot/deposit(mob/living/target_mob)
	. = ..()
	name = "Scavenger bot"
	desc = "The drone has folded into a holdable mode"
	icon = 'deadspace/icons/mob/dsbots.dmi'
	icon_state = "spiderbot_console"

/obj/item/mob_holder/janibot
	examine_mob = FALSE

/obj/item/mob_holder/janibot/deposit(mob/living/target_mob)
	. = ..()
	name = "Cleanbot"
	desc = "The bot has folded into a holdable mode"
	icon = 'deadspace/icons/mob/dsbots.dmi'
	icon_state = "cleanbot_console"
