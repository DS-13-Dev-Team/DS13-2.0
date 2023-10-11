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
	"1. You may not harm any being, excluding simple mobs, regardless of intent or circumstance.\n"+\
	"2. Collect out of the way item and resources.\n"+\
	"3. Deliver the found items to the appropriate department or personal.\n"+\
	"4. Do not directly interfere with the round outside your given laws.\n"
	default_storage = /obj/item/storage/backpack/duffelbag
	flavortext = "You are a corporate owned scavenger bot, you've been tasked with the scavanging of the station or ship."
