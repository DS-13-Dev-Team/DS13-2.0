/obj/item/disk/holodisk/ds13/ce
	name = "CEC - IMPORTANT MESSAGE FOR CE"
	desc = "A videolog from corporate, you should really put this in the holopad"
	icon = 'deadspace/icons/obj/epad.dmi'
	icon_state = "epad_work"
	preset_image_type = /datum/preset_holoimage/head_of_personnel
	preset_record_text = {"
	SAY Hello Chief Engineer of (INSERT NAME HERE)
	DELAY 20
	SAY This is Joseph Stone, employee #PM-50123-HR, training development specialist for the Concordance Extraction Corporation.
	DELAY 40
	SOUND sparks
	DELAY 14
	SAY I've been asked by corporate to make this Vid-Log to remind you how to properly do your job.
	DELAY 40
	SAY Seeing as you're the Chief Engineer you've been requisition a advanced engineering rig that been placed inside of your shift locker.
	DELAY 45
	SAY As you can see, you've also been requisition two intermediate engineering rig.
	DELAY 35
	SAY these are for you to assign too two COMPETENT senior engineers for the shift who will be able to complete difficult task.
	DELAY 36
	SAY good luck!
	DELAY 20;"}

/obj/item/disk/holodisk/ds13/cryo
	name = "CEC - IMPORTANT CRYOPOD TRAINING"
	desc = "A videolog from corporate, you should really put this in the holopad"
	icon = 'deadspace/icons/obj/epad.dmi'
	icon_state = "epad_work"
	preset_image_type = /datum/preset_holoimage/head_of_personnel
	preset_record_text = {"
	SAY Hello Medical personal of (INSERT NAME HERE)
	DELAY 20
	SAY This is Joseph Stone, employee #PM-50123-HR, training development specialist for the Concordance Extraction Corporation.
	DELAY 40
	SAY I've been asked by corporate to make this Vid-Log to remind you how to properly do your job.
	DELAY 40
	SAY This machine in front of you is a cryopod, a state of art encapsulating machine.
	DELAY 40
	SAY Before you put a patient inside, ensure the tanks are connected.
	DELAY 35
	SAY the valve connecting the tanks to cryopod is open and set to 101kpa.
	DELAY 36
	SAY and throw your chemical of choice in.
	DELAY 36
	SAY good luck!
	DELAY 20;"}

/obj/item/disk/holodisk/ds13/sm
	name = "CEC - IMPORTANT INSTRUCTIONS ON SUPERMATTER SETUP"
	desc = "A super important video log from corporate about basic supermatter safety and operation, it looks a bit singed."
	icon = 'deadspace/icons/obj/epad.dmi'
	icon_state = "epad_work"
	preset_image_type = /datum/preset_holoimage/head_of_personnel
	preset_record_text = {"
	SAY Hello Supermatter Technician of (INSERT NAME HERE)
	DELAY 20
	SAY This is Joseph Stone, employee #PM-50123-HR, training development specialist for the Concordance Extraction Corporation.
	DELAY 40
	SOUND sparks
	DELAY 14
	SAY I've been asked by corporate to make this Vid-Log to remind you how to properly do your job.
	DELAY 40
	SAY The first step to setting up the sm is to turn on the "hot return secondary cooling" digital valve.
	DELAY 35
	SAY Next is to turn on the two pipes called the "unit head" pumps, make sure the pressure is maxed out.
	DELAY 35
	SAY Once this has been done add four hydrogen canisters to the hot loop, which is the green pipes.
	DELAY 35
	SAY Next, add the two carbon dioxide canisters to the cold loop, which is the cyan pipes.
	DELAY 35
	SAY Lastly turn on the emitter, and give the supermatter four to six shots with the emitter.
	DELAY 35
	SAY Make sure to turn off the emitter after giving the supermatter the right amount of shots.
	DELAY 35
	SAY In a emergency you can add more CO2 to the cold loop, or in a dire emergency you can flood the hot loop with N20.
	DELAY 35
	SAY Please refer to your CE or someone of significant qualification if these do not stabilize the supermatter.
	DELAY 35
	SAY Congratulations you have completed your mandatory sm training, and are ready to set up the SM.
	DELAY 35
	SAY good luck! And remember, only you can prevent supermatter detonation!
	DELAY 20;"}

//***Grave mounds.
/// has no items inside unless you use the filled subtype
/obj/structure/closet/crate/grave
	name = "burial mound"
	desc = "A marked patch of soil, showing signs of a burial long ago. You wouldn't disturb a grave... right?"
	icon = 'icons/obj/crates.dmi'
	icon_state = "grave"
	dense_when_open = TRUE
	material_drop = /obj/item/stack/ore/glass/basalt
	material_drop_amount = 5
	anchorable = FALSE
	anchored = TRUE
	locked = TRUE
	divable = FALSE //As funny as it may be, it would make little sense how you got yourself inside it in first place.
	breakout_time = 90 SECONDS
	open_sound = 'sound/effects/shovel_dig.ogg'
	close_sound = 'sound/effects/shovel_dig.ogg'
	cutting_tool = /obj/item/shovel
	var/lead_tomb = FALSE
	var/first_open = FALSE
	can_install_electronics = FALSE

/obj/structure/closet/crate/grave/filled/PopulateContents()  //GRAVEROBBING IS NOW A FEATURE
	..()
	new /obj/effect/decal/remains/human/grave(src)
	switch(rand(1,8))
		if(1)
			new /obj/item/coin/gold(src)
			new /obj/item/storage/wallet(src)
		if(2)
			new /obj/item/clothing/glasses/meson(src)
		if(3)
			new /obj/item/coin/silver(src)
			new /obj/item/shovel/spade(src)
		if(4)
			new /obj/item/storage/book/bible/booze(src)
		if(5)
			new /obj/item/clothing/neck/stethoscope(src)
			new /obj/item/scalpel(src)
			new /obj/item/hemostat(src)

		if(6)
			new /obj/item/reagent_containers/glass/beaker(src)
			new /obj/item/clothing/glasses/science(src)
		if(7)
			new /obj/item/clothing/glasses/sunglasses(src)
			new /obj/item/clothing/mask/cigarette/rollie(src)
		else
			//empty grave
			return

/obj/structure/closet/crate/grave/open(mob/living/user, obj/item/S, force = FALSE)
	if(!opened)
		to_chat(user, span_notice("The ground here is too hard to dig up with your bare hands. You'll need a shovel."))
	else
		to_chat(user, span_notice("The grave has already been dug up."))

/obj/structure/closet/crate/grave/closet_update_overlays(list/new_overlays)
	return

/obj/structure/closet/crate/grave/tool_interact(obj/item/S, mob/living/carbon/user)
	if(!user.combat_mode) //checks to attempt to dig the grave, must be done with combat mode off only.
		if(!opened)
			if(istype(S,cutting_tool) && S.tool_behaviour == TOOL_SHOVEL)
				to_chat(user, span_notice("You start start to dig open \the [src]  with \the [S]..."))
				if (do_after(user, src, 20))
					opened = TRUE
					locked = TRUE
					dump_contents()
					update_appearance()
					if(lead_tomb == TRUE && first_open == TRUE)
						user.gain_trauma(/datum/brain_trauma/magic/stalker)
						to_chat(user, span_boldwarning("Oh no, no no no, THEY'RE EVERYWHERE! EVERY ONE OF THEM IS EVERYWHERE!"))
						first_open = FALSE
					return 1
				return 1
			else
				to_chat(user, span_notice("You can't dig up a grave with \the [S.name]."))
				return 1
		else
			to_chat(user, span_notice("The grave has already been dug up."))
			return 1

	else if((user.combat_mode) && opened) //checks to attempt to remove the grave entirely.
		if(istype(S,cutting_tool) && S.tool_behaviour == TOOL_SHOVEL)
			to_chat(user, span_notice("You start to remove \the [src] with \the [S]."))
			if (do_after(user, src, 15))
				to_chat(user, span_notice("You remove \the [src] completely."))
				deconstruct(TRUE)
				return 1
	return

/obj/structure/closet/crate/grave/bust_open()
	..()
	opened = TRUE
	update_appearance()
	dump_contents()
	return

/obj/structure/closet/crate/grave/filled/lead_researcher
	name = "ominous burial mound"
	desc = "Even in a place filled to the brim with graves, this one shows a level of preperation and planning that fills you with dread."
	icon = 'icons/obj/crates.dmi'
	icon_state = "grave_lead"
	lead_tomb = TRUE
	first_open = TRUE

/obj/structure/closet/crate/grave/filled/lead_researcher/PopulateContents()  //ADVANCED GRAVEROBBING
	..()
	new /obj/effect/decal/cleanable/blood/gibs/old(src)

/obj/effect/decal/remains/human/grave
	turf_loc_check = FALSE
