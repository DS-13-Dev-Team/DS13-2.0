/datum/loadout_item/backpack
	category = LOADOUT_CATEGORY_BACKPACK

//MISC
/datum/loadout_item/backpack/matches
	path = /obj/item/storage/box/matches

/datum/loadout_item/backpack/cheaplighter
	path = /obj/item/lighter/greyscale

/datum/loadout_item/backpack/zippolighter
	path = /obj/item/lighter
	cost = 2

/datum/loadout_item/backpack/ttsdevice
	path = /obj/item/ttsdevice
	cost = 5

/*/datum/loadout_item/backpack/paicard
	description = "A device, that let you browse and download various AIs."
	path = /obj/item/paicard
	cost = 2 */

/datum/loadout_item/backpack/cigar
	path = /obj/item/clothing/mask/cigarette/cigar
	cost = 4 //smoking is bad mkay

/datum/loadout_item/backpack/cigarettes
	path = /obj/item/storage/fancy/cigarettes

/datum/loadout_item/backpack/flask
	path = /obj/item/reagent_containers/food/drinks/flask
	cost = 2

/datum/loadout_item/backpack/skub
	path = /obj/item/skub

/datum/loadout_item/backpack/lipstick
	path = /obj/item/lipstick
	customization_flags = CUSTOMIZE_NAME_DESC
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_FRAGRANCE

/datum/loadout_item/backpack/lipstick_purple
	path = /obj/item/lipstick/purple
	customization_flags = CUSTOMIZE_NAME_DESC
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_FRAGRANCE

/datum/loadout_item/backpack/lipstick_jade
	path = /obj/item/lipstick/jade
	customization_flags = CUSTOMIZE_NAME_DESC
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_FRAGRANCE

/datum/loadout_item/backpack/lipstick_black
	path = /obj/item/lipstick/black
	customization_flags = CUSTOMIZE_NAME_DESC
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_FRAGRANCE

/datum/loadout_item/backpack/lipstick_random
	path = /obj/item/lipstick/random
	customization_flags = CUSTOMIZE_NAME_DESC
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_FRAGRANCE

/datum/loadout_item/backpack/lizard_plushie
	path = /obj/item/toy/plush/lizard_plushie
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_TOYS

/datum/loadout_item/backpack/bee_plushie
	path = /obj/item/toy/plush/beeplushie
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_TOYS

/datum/loadout_item/backpack/moth_plushie
	path = /obj/item/toy/plush/moth
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_TOYS

/datum/loadout_item/backpack/snake_plushie
	path = /obj/item/toy/plush/snakeplushie
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_TOYS

/datum/loadout_item/backpack/music_beacon
	path = /obj/item/choice_beacon/music
	cost = 2

/datum/loadout_item/backpack/multipen
	path = /obj/item/pen/fourcolor

/datum/loadout_item/backpack/fountainpen
	path = /obj/item/pen/fountain
	cost = 2

/datum/loadout_item/backpack/skateboard
	path = /obj/item/melee/skateboard
	cost = 2

//survival and combat items
/datum/loadout_item/backpack/rock_saw
	path = /obj/item/pickaxe/rock
	subcategory = LOADOUT_SUBCATEGORY_DANGEROUS
	restricted_roles = list(JOB_PROSPECTOR)//room for more mining roles later
	cost = 2

/datum/loadout_item/backpack/knife_combat
	path = /obj/item/knife/combat
	subcategory = LOADOUT_SUBCATEGORY_DANGEROUS
	cost = 4
	restricted_roles = list(JOB_PROSPECTOR,JOB_SECURITY_OFFICER,JOB_WARDEN,JOB_SECURITY_MARSHAL,JOB_HEAD_OF_PERSONNEL,JOB_CAPTAIN)

/datum/loadout_item/backpack/knife_survival
	path = /obj/item/knife/combat/survival
	subcategory = LOADOUT_SUBCATEGORY_DANGEROUS
	cost = 4
/datum/loadout_item/backpack/glowstick
	path = /obj/item/flashlight/glowstick
	subcategory = LOADOUT_SUBCATEGORY_SURVIVAL
	customization_flags = CUSTOMIZE_DESC //no naming your green glowstick "Pink Glowstick"

/datum/loadout_item/backpack/glowstick_red
	path = /obj/item/flashlight/glowstick/red
	subcategory = LOADOUT_SUBCATEGORY_SURVIVAL
	customization_flags = CUSTOMIZE_DESC

/datum/loadout_item/backpack/glowstick_blue
	path = /obj/item/flashlight/glowstick/blue
	subcategory = LOADOUT_SUBCATEGORY_SURVIVAL
	customization_flags = CUSTOMIZE_DESC

/datum/loadout_item/backpack/glowstick_orange
	path = /obj/item/flashlight/glowstick/orange
	subcategory = LOADOUT_SUBCATEGORY_SURVIVAL
	customization_flags = CUSTOMIZE_DESC

/datum/loadout_item/backpack/glowstick_yellow
	path = /obj/item/flashlight/glowstick/yellow
	subcategory = LOADOUT_SUBCATEGORY_SURVIVAL
	customization_flags = CUSTOMIZE_DESC

/datum/loadout_item/backpack/glowstick_pink
	path = /obj/item/flashlight/glowstick/pink
	subcategory = LOADOUT_SUBCATEGORY_SURVIVAL
	customization_flags = CUSTOMIZE_DESC
