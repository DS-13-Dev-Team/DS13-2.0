// All Content here is meant for the map, mainly lockers and WIP holodisks - Asi

// Lockers designed for this map (Having mining gear of DS13 & less vanilla, plus map weather protection.

// Mining Closet

/obj/structure/closet/secure_closet/miner/mara
	name = "miner's equipment"
	icon_state = "mining"
	req_access = list(ACCESS_MINING)

/obj/structure/closet/secure_closet/miner/mara/PopulateContents()
	..()
	new /obj/item/shovel(src)
	new /obj/item/pickaxe/laser(src)
	new /obj/item/radio/headset/headset_cargo/mining(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/t_scanner/adv_mining_scanner/lesser(src)
	new /obj/item/gun/energy/plasmacutter(src)
	new /obj/item/clothing/glasses/meson(src)
	new /obj/item/survivalcapsule(src)
	new /obj/item/gun/energy/plasmacutter(src)
	new /obj/item/clothing/under/rank/cargo/miner/ds_miner(src)
	new /obj/item/clothing/suit/hooded/wintercoat/miner(src)
	new /obj/item/clothing/mask/balaclava(src)
	new /obj/item/clothing/shoes/winterboots(src)

 // Med Closet

/obj/structure/closet/secure_closet/medical_mara
	name = "medical doctor's locker"
	req_access = list(ACCESS_SURGERY)
	icon_state = "med_secure"

/obj/structure/closet/secure_closet/medical_mara/PopulateContents()
	..()
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/defibrillator/loaded(src)
	new /obj/item/clothing/gloves/color/latex/nitrile(src)
	new /obj/item/storage/belt/medical(src)
	new /obj/item/clothing/glasses/hud/health(src)
	new /obj/item/clothing/under/rank/medical/ds_med(src)
	new /obj/item/clothing/suit/hooded/wintercoat/medical(src)
	new /obj/item/clothing/mask/balaclava(src)
	new /obj/item/clothing/shoes/winterboots(src)

 // Sec Closet

/obj/structure/closet/secure_closet/security/mara
	name = "security officer's locker"
	req_access = list(ACCESS_SECURITY)
	icon_state = "sec"

/obj/structure/closet/secure_closet/security/mara/PopulateContents()
	..()
	new /obj/item/clothing/under/rank/security/pcsi(src)
	new /obj/item/clothing/suit/armor/pcsi(src)
	new /obj/item/clothing/head/helmet/pcsi(src)
	new /obj/item/radio/headset/headset_sec(src)
	new /obj/item/radio/headset/headset_sec/alt(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/gun/ballistic/automatic/pistol/divet(src)
	new /obj/item/clothing/suit/hooded/wintercoat/security(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/shoes/winterboots(src)
	new /obj/item/clothing/mask/balaclava(src)

// Capitan (Overseer on this map since it sounds fitting) Closet

/obj/structure/closet/secure_closet/captains/mara
	name = "\proper overseer's locker"
	req_access = list(ACCESS_CAPTAIN)
	icon_state = "cap"

/obj/structure/closet/secure_closet/captains/mara/PopulateContents()
	..()

	new /obj/item/storage/backpack/captain(src)
	new /obj/item/storage/backpack/satchel/cap(src)
	new /obj/item/storage/backpack/duffelbag/captain(src)
	new /obj/item/storage/bag/garment/captain(src)
	new /obj/item/computer_hardware/hard_drive/role/captain(src)
	new /obj/item/storage/box/silver_ids(src)
	new /obj/item/radio/headset/heads/captain/alt(src)
	new /obj/item/radio/headset/heads/captain(src)
	new /obj/item/storage/belt/sabre(src)
	new /obj/item/gun/energy/e_gun(src)
	new /obj/item/clothing/under/rank/captain/ds_captain/ds_director(src)
	new /obj/item/clothing/suit/hooded/wintercoat/captain(src)
	new /obj/item/clothing/shoes/winterboots(src)
	new /obj/item/clothing/mask/balaclava(src)
	new /obj/item/gun/ballistic/automatic/pistol/divet(src)


// Holodisk for Mara 17, there were meant to be more, but until i can get more datums for lore & etc, it's gonna be this WIP for now - Asi

/obj/item/disk/holodisk/ds13/mara_intro_cpt
	name = "Mara 17 - Overseer Orders"
	desc = "A videolog containing the orders to the outpost overseer."
	color = "red"
	icon = 'deadspace/icons/obj/epad.dmi'
	icon_state = "epad_work"
	preset_image_type = /datum/preset_holoimage/captain
	preset_record_text = {"
	NAME CEC Executive
	DELAY 10
	SAY Welcome to Mara 17!
	DELAY 35
	SAY If you're seeing this,congratulations! You have been assigned by the Concordance Extraction Corporation to continue mining operations here on the icy planet of Mara 17.
	DELAY 30
	SAY I will address a few things for you before you get started.
	DELAY 30
	SAY First of all, you're currently going to be using the newly established mining facility on the planet, this place called 'Outpost Iris', built by the Sovereign Colonies Armed Forces, around 200 years ago.
	DELAY 30
	SAY But it's been reformed, and now is going to be home of you and the personnel of the CEC which are down here with you.
	DELAY 30
	SAY The USG Renault will be on the planet's orbit to ensure that the resources from the planet will be delivered to Titan Station after mining operations are concluded in 32 months.
	DELAY 30
	SAY Once mining operations are concluded, your personnel will be relieved and brought onboard to the Renault and back to Titan Station.
	DELAY 30
	SAY Before you complain, the USG Renault's arrays appear to have been damaged last week, leaving no communications from the outpost to the ship, our brave CEC technicians are dealing with the issue so dont worry.
	DELAY 30
	SAY One thing i must tell you about is the weather of the planet.
	DELAY 30
	SAY Storms are frequent and we've gotten many personnel with frostbites and hypothermia due them not following safety procedures, make sure your personnel wear winter protective equipment if they go outside.
	DELAY 30
	SAY The Sovereign Colonies knew about it and built this outpost like this, so make sure to stay inside when they hit.
	DELAY 30
	SAY Ah right i forgot!
	DELAY 30
	SAY The last group of personnel that were stationed here reported hearing voices and having nightmares once the mining team opened the lower section of the mines. But dont let that discourage you from continuing working here.
	DELAY 30
	SAY We have limited equipment and the CEC cannot afford to waste much on this operations, if you ask me, they probably just wanted to leave sooner and came up with this excuse of 'Dementia' and such.
	DELAY 30
	SAY The lower level of the outpost has been closed & sealed aswell due for safety concerns, it's for the best that nobody goes until the next specialized team arrives.
	DELAY 30
	SAY The facilities here are not fully supplied, so you will have to use what you were given by the CEC and what the other team left here.
	DELAY 30
	SAY We've also made sure to give you an small armory with some of the surplus equipment we found, i dont think you will use it or that personnel will riot, but keep it in mind.
	DELAY 30
	SAY Lastly, should any catastrophic event occur on the planet, your only evacuation will be the disposal shuttle left here.
	DELAY 30
	SAY I know it's not an evacuation shuttle, but thank the USG Renault for not leaving you stranded.
	DELAY 30
	SAY With this said, good luck! And remember! Safety begins with teamwork!
	DELAY 20;"}


/obj/item/disk/holodisk/ds13/mara_cpt_confidential
	name = "Mara 17 - Overseer Orders"
	desc = "WARNING: COMMANDING STAFF EYES ONLY"
	color = "blue"
	icon = 'deadspace/icons/obj/epad.dmi'
	icon_state = "epad_work"
	preset_image_type = /datum/preset_holoimage/captain
	preset_record_text = {"
	NAME CEC Executive
	DELAY 10
	SAY During the excavation of the 3rd team stationed on the outpost, they discovered what appears to be a genuine marker, the red marker to be precise.
	DELAY 15
	SAY After talk with other executives of the CEC, your team will be taking the task of waiting until officials from the church of unitology and specialists of the CEC arrive to Mara 17.
	DELAY 15
	SAY Under NO CIRCUMSTANCES the marker must be touched or modified by anyone who is not authorized by the church of Unitology.
	DELAY 15
	SAY The team with said specialists will arrive in 4 months, any damage or scratch found in the marker will be personally deducted from your pay and having your men and yourself fired from the CEC.
	DELAY 15
	SAY You are to stay there until they arrive, this is all. The CEC is watching this with great interest, do not dissapoint us.
	DELAY 20;"}

/obj/item/disk/holodisk/ds13/mara_sec
	name = "Mara 17 - Security Report #17"
	desc = "A videolog containing a detailed report on the 3rd team stationed on the Outpost Iris."
	icon = 'deadspace/icons/obj/epad.dmi'
	icon_state = "epad_work"
	preset_image_type = /datum/preset_holoimage/nanotrasenprivatesecurity
	preset_record_text = {"
	NAME SGT Alexis Garret
	DELAY 15
	SAY This is Sergeant Alexis Garret, 3rd team, Detective.
	DELAY 10
	SAY Currently after the excavation done in the lower level of these so called mines, the mining team found a cave with lots of remains.. Human remains.
	DELAY 25
	SAY IT appears that those plasma cutting fuckheads found what appears to be a GENUINE marker aswell, we've got pictures and videologs of it, and it's no fucking joke, Altman be fucking praised.
	DELAY 25
	SAY However, two weeks have passed since that discovery, and the outpost crew stationed here have grown..Akward ever since we discovered the marker.
	DELAY 25
	SAY Most of the miners suffer from hallucinations and headaches and the 55% have been brought back to the USG Renault for further psychological evaluation.
	DELAY 25
	SAY And what's worse, other people are reporting odd occurrences happening around, someone has reported that they hear whispers behind the walls, and even scratching noises too.
	DELAY 25
	SAY It does not help that we found what appears to be one of the enginieers of our team fucking mauled to death by something in the snow, 3 hours after they went missing during a routine inspection.
	DELAY 25
	SAY The personnel have become quite stressed aswell, we had to detain an enginieer and a miner after they tried to rig the marker with explosives, shouting that some fucking ghost warned them that it 'would kill us all!'.
	DELAY 25
	SAY EVEN worse too, the USG Renault's arrays have gone fried or something cause we've tried to hail them for the 8th time and they aint picking the phone. The chief enginieer reports grunts and some static though.
	DELAY 25
	SAY We have over 7 missing personnel, including Corporal Dumitru Anastasie, i never liked that Romanian fucker, but never thought i'd miss his shenanigans on security.
	DELAY 25
	SAY I'll be going on the USG Renault shortly when the 4rth crew arrive on the transport ship they told us about..
	DELAY 25
	SAY As a warning for the 4th crew, id suggest not telling anyone about this, stress will not go well and it's better not to worry about it.
	DELAY 40;"}

/obj/item/disk/holodisk/ds13/mara_exterior
	name = "Mara 17 - Repairs"
	desc = "A videolog from a disgruntled CEC employee. Old dried bloodstains seem to cover it."
	icon = 'deadspace/icons/obj/epad.dmi'
	icon_state = "epad_work"
	preset_image_type = /datum/preset_holoimage/engineer/mod
	preset_record_text = {"
	NAME Zack Weller
	DELAY 20
	SAY This is Zack Weller, employee #PM-76826-EH, Outpost Iris technician.
	DELAY 30
	SOUND sparks
	DELAY 14
	SAY Finally..I've fixed the faulty lights and wires on the lower section of this shithole, so it should be 'safe' on the overseer words.
	DELAY 30
	SAY Most repairs have been done, the next team should not have a problem and a need for enginieers i belive after this.
	DELAY 30
	SAY One thing i want to complain thought is that the cold is a fucking bitch in here..and that the fuckin' overseer is sending us to do this repairs alone.
	DELAY 35
	SAY Staying alone while doing repairs is sure a creepy, specially when Wayne and the other enginieer went missing two days ago.
	DELAY 36
	SAY Who's there ? Is that you Sam ? What the fuck you're doing outside at this hour ?! Last Shift i-
	SOUND slasher_shout_1
	DELAY 40;"}


/obj/item/disk/holodisk/ds13/mara_talk
	name = "Mara 17 - Gossip"
	desc = "A videolog from a few CEC employees talking about the outpost, seems from the first team sent here judging by how old it is."
	icon = 'deadspace/icons/obj/epad.dmi'
	icon_state = "epad_work"
	preset_image_type = /datum/preset_holoimage/researcher
	preset_record_text = {"
	NAME Marissa Galvan
	DELAY 10
	SAY So, has anyone found anything interesting here ?
	DELAY 10
	PRESET /datum/preset_holoimage/engineer
	NAME Wayne Clayton
	SAY I did find that the old SCAF folks stationed here had a fuck load of beer here at least, watch.
	DELAY 20
	PRESET /datum/preset_holoimage/researcher
	NAME Marissa Galvan
	SAY You were not kidding, i did find at the very least that this outpost was established 200 years ago or so.
	DELAY 23
	SAY Back when the SCAF was in a fight with i cant remember who... I cant imagine how awful it must have been to travel without shockpoint drives.
	DELAY 20
	SAY Being left alone in a planet like this to survive on your own..whew..
	DELAY 20
	PRESET /datum/preset_holoimage/engineer
	NAME Wayne Clayton
	SAY Yeah it must have been a bitch, but i heard that the expedition party found some old ruins on the north east.
	DELAY 25
	SAY Covered with hundreds of human remains.. I wonder what happened, did they start eating eachother or a mutiny happened ?
	DELAY 25
	PRESET /datum/preset_holoimage/researcher
	NAME Marissa Galvan
	SAY Who knows, im just paid for studying the planet's atmosphere, and you're paid to fix this-
	DELAY 25
	PRESET /datum/preset_holoimage/nanotrasenprivatesecurity
	NAME James Reed
	SAY What the fuck you're two doing ? No slacking off! Overseer's orders, get back to work!
	DELAY 30;"}


/obj/item/disk/holodisk/ds13/mara_shitsec
	name = "Mara 17 - Angry"
	desc = "A videolog from a drunk security officer it seems."
	icon = 'deadspace/icons/obj/epad.dmi'
	icon_state = "epad_work"
	preset_image_type = /datum/preset_holoimage/nanotrasenprivatesecurity
	preset_record_text = {"
    NAME Dumitru Anastasie
   	DELAY 10
	SAY Man this shithole is awful.. *HIC*
	DELAY 20
    SAY Fuckin' sent here because i beat that ST a bit too hard on the Ishimura 3 years ago.
    DELAY 10
    SAY *HIC*
    DELAY 10
    SAY What a bunch of idiots, i bet he was a fucking unitologist or even worse..one of those dogshit terrorists.
	DELAY 20
    SAY At least they're being replaced by robots heheh..
	DELAY 20
    SAY *HIC*
    DELAY 10
    SAY Just gotta keep my beating quota high..and just drink myself till i forget this shit.
    DELAY 30;"}


// SIGNS & Floor decals, these are from Rook, for now they work and im more happy with some map content than with nothing - Asi

/obj/effect/turf_decal/scaf_sign
	icon = 'deadspace/icons/turf/floor_decals.dmi'
	icon_state = "scaf_1"

/obj/effect/turf_decal/scaf_sign/one
	icon_state = "scaf_1"

/obj/effect/turf_decal/scaf_sign/two
	icon_state = "scaf_2"

/obj/effect/turf_decal/scaf_sign/three
	icon_state = "scaf_3"

/obj/effect/turf_decal/scaf_sign/four
	icon_state = "scaf_4"

/obj/effect/turf_decal/scaf_sign/eagle_one
	icon_state = "eagle_1"

/obj/effect/turf_decal/scaf_sign/eagle_two
	icon_state = "eagle_2"

// This is just a rename of the nagant revolver, easter egg, you can guess from which game this is - Asi

/obj/item/gun/ballistic/revolver/nagant/model_1892
	name = "\improper Modèle 1892 revolver"
	desc = "An old model of a revolver that was once used in WW1, what it's doing here is beyond your knowledge, it could stop a beast if you were amnesiac in a bunker."
	icon_state = "nagant"
	can_suppress = TRUE

	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev762
