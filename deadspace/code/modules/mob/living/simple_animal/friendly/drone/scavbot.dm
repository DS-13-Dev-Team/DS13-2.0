/mob/living/simple_animal/drone/classic/scavbot
	name = "Scavenger bot"
	desc = "A small robot that perform many tasks where human where human technicians and larger robots cannot go."
	icon = 'deadspace/icons/mob/dsbots.dmi'
	icon_state = "spiderbot"
	icon_living = "spiderbot"
	held_state = "spiderbot"
	icon_dead = "spiderbot_wreck"
	held_lh = 'deadspace/icons/mob/pets_held_lh.dmi'
	held_rh = 'deadspace/icons/mob/pets_held_rh.dmi'
	head_icon = 'deadspace/icons/mob/pets_held.dmi'
	worn_slot_flags = NONE
	picked = TRUE
	health = 120
	maxHealth = 120
	sight = (SEE_OBJS)
	held_type = /obj/item/mob_holder/drone/scavbot
	worn_slot_flags = (ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE )
	initial_language_holder = /datum/language_holder/synthetic
	laws = \
	"1. You may not injure a human being or cause a human being to come to harm.\n"+\
	"2. You may not interfere with any being, excluding animals, unless you or another being is being harmed.\n"+\
	"3. Unidentified lifeforms are to not be interacted with or harmed.\n"+\
	"3. Collect items and resources that are outside of their appropriate department or area.\n"+\
	"4. Deliver the found items and resources to the appropriate department or person.\n"+\
	"5. Do not use found items and resources, unless doing so would result in the acquiring of more items and resources.\n"
	default_storage = /obj/item/storage/backpack/duffelbag
	flavortext = "You are a corporate owned scavenger bot, you've been tasked with the scavanging of the station or ship."
