/obj/structure/closet/secure_closet/ds/research_director
	name = "\proper research director's locker"
	req_access = list(ACCESS_RD)
	icon_state = "rd"

/obj/structure/closet/secure_closet/ds/research_director/PopulateContents()
	..()
	new /obj/item/mod/control/pre_equipped/ds/hacker(src)
	new /obj/item/clothing/suit/hooded/ds(src)
	new /obj/item/storage/bag/garment/research_director(src)
	new /obj/item/computer_hardware/hard_drive/role/rd(src)
	new /obj/item/megaphone/command(src)
	new /obj/item/storage/lockbox/medal/sci(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/laser_pointer(src)
	new /obj/item/circuitboard/machine/fabricator/omni(src)
	new /obj/item/storage/photo_album/rd(src)
	new /obj/item/storage/box/skillchips/science(src)
