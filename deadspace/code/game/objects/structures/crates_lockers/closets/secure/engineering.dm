/obj/structure/closet/secure_closet/ds/engineering_chief
	name = "\proper chief engineer's locker"
	req_access = list(ACCESS_CE)
	icon_state = "ce"

/obj/structure/closet/secure_closet/ds/engineering_chief/PopulateContents()
	..()
	new /obj/item/mod/control/pre_equipped/ds/advanced_engineer(src)
	new /obj/item/storage/bag/garment/engineering_chief(src)
	new /obj/item/computer_hardware/hard_drive/role/ce(src)
	new /obj/item/radio/headset/heads/ce(src)
	new /obj/item/megaphone/command(src)
	new /obj/item/areaeditor/blueprints(src)
	new /obj/item/storage/briefcase/inflatable(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/pipe_dispenser(src)
	new /obj/item/circuitboard/machine/fabricator/department/engineering(src)
	new /obj/item/extinguisher/advanced(src)
	new /obj/item/storage/photo_album/ce(src)
	new /obj/item/storage/box/skillchips/engineering(src)

/obj/structure/closet/secure_closet/ds/engineering_personal
	name = "engineer's locker"
	req_access = list(ACCESS_ENGINE_EQUIP)
	icon_state = "eng_secure"

/obj/structure/closet/secure_closet/ds/engineering_personal/PopulateContents()
	..()
	new /obj/item/mod/control/pre_equipped/ds/standard_engineer(src)
	new /obj/item/radio/headset/headset_eng(src)
	new /obj/item/storage/toolbox/mechanical(src)
	new /obj/item/tank/internals/emergency_oxygen/engi(src)
	new /obj/item/holosign_creator/engineering(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/glasses/meson/engine(src)
	new /obj/item/stack/sticky_tape(src)
	new /obj/item/paint_sprayer(src)
	new /obj/item/storage/box/emptysandbags(src)
	new /obj/item/storage/bag/construction(src)

/obj/structure/closet/secure_closet/ds/atmospherics
	name = "\proper atmospheric technician's locker"
	req_access = list(ACCESS_ATMOSPHERICS)
	icon_state = "atmos"

/obj/structure/closet/secure_closet/ds/atmospherics/PopulateContents()
	..()
	new /obj/item/mod/control/pre_equipped/ds/standard_engineer
	new /obj/item/radio/headset/headset_eng(src)
	new /obj/item/pipe_dispenser(src)
	new /obj/item/storage/toolbox/mechanical(src)
	new /obj/item/tank/internals/emergency_oxygen/engi(src)
	new /obj/item/storage/briefcase/inflatable(src)
	new /obj/item/watertank/atmos(src)
	new /obj/item/clothing/suit/fire/atmos(src)
	new /obj/item/clothing/mask/gas/atmos(src)
	new /obj/item/clothing/head/hardhat/atmos(src)
	new /obj/item/clothing/glasses/meson/engine/tray(src)
	new /obj/item/extinguisher/advanced(src)
