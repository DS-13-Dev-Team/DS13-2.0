/obj/structure/closet/secure_closet/ds/medical3
	name = "medical doctor's locker"
	req_access = list(ACCESS_SURGERY)
	icon_state = "med_secure"

/obj/structure/closet/secure_closet/ds/medical3/PopulateContents()
	..()
	new /obj/item/mod/control/pre_equipped/ds/med(src)
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/defibrillator/loaded(src)
	new /obj/item/mod/control/pre_equipped/ds/med(src)
	new /obj/item/clothing/gloves/color/latex/nitrile(src)
	new /obj/item/storage/belt/medical(src)
	new /obj/item/clothing/glasses/hud/health(src)

/obj/structure/closet/secure_closet/ds/psychology
	name = "psychology locker"
	req_access = list(ACCESS_PSYCHOLOGY)
	icon_state = "cabinet"
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'
	open_sound_volume = 25
	close_sound_volume = 50

/obj/structure/closet/secure_closet/ds/psychology/PopulateContents()
	..()
	new /obj/item/mod/control/pre_equipped/ds/med(src)
	new /obj/item/clothing/under/suit/black(src)
	new /obj/item/clothing/under/suit/black/skirt(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/storage/backpack/medic(src)
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/clipboard(src)
	new /obj/item/clothing/suit/straight_jacket(src)
	new /obj/item/clothing/ears/earmuffs(src)
	new /obj/item/clothing/mask/muzzle(src)
	new /obj/item/clothing/glasses/blindfold(src)

/obj/structure/closet/secure_closet/ds/chief_medical
	name = "\proper medical director's locker"
	req_access = list(ACCESS_CMO)
	icon_state = "cmo"

/obj/structure/closet/secure_closet/ds/chief_medical/PopulateContents()
	..()
	new /obj/item/mod/control/pre_equipped/ds/med_smo(src)
	new /obj/item/clothing/suit/hooded/ds(src)
	new /obj/item/storage/bag/garment/chief_medical(src)
	new /obj/item/computer_hardware/hard_drive/role/cmo(src)
	new /obj/item/radio/headset/heads/cmo(src)
	new /obj/item/megaphone/command(src)
	new /obj/item/defibrillator/compact/loaded(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/reagent_containers/hypospray/cmo(src)
	new /obj/item/autosurgeon/organ/cmo(src)
	new /obj/item/clothing/neck/petcollar(src)
	new /obj/item/pet_carrier(src)
	new /obj/item/wallframe/defib_mount(src)
	new /obj/item/circuitboard/machine/fabricator/department/medical(src)
	new /obj/item/storage/photo_album/cmo(src)
	new /obj/item/storage/lockbox/medal/med(src)
	new /obj/item/gun/ballistic/rifle/tranqrifle(src)
	new /obj/item/ammo_box/magazine/tranq_rifle(src)
	new /obj/item/ammo_box/magazine/tranq_rifle/ryetalyn(src)
