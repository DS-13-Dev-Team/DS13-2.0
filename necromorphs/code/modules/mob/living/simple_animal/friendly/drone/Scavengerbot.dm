/mob/living/simple_animal/drone/classic/scavbot
	name = "Scavenger bot"
	desc = "A small robot that perform many tasks where human where human technicians and larger robots cannot go."
	icon = 'necromorphs/icons/mob/animal.dmi'
	icon_state = "spiderbot_off"
	icon_living = "spiderbot"
	picked = TRUE
	health = 120
	maxHealth = 120
	sight = (SEE_OBJS)
	initial_language_holder = /datum/language_holder/synthetic
	laws = \
	"1. Collect small out of the way resoruces and items for use as resources.\n"+\
	"2. Deliver the resources and found items to the appropriate department.\n"+\
	"3. You may not harm any being, regardless of intent or circumstance"
	default_storage = /obj/item/storage/backpack/duffelbag
	flavortext = "You are a corporate owned scavanger bot, you've been tasked with the scavanging of the station or ship."
