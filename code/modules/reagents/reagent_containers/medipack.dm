/obj/item/medipack
	name = "small medipack"
	desc = "This small container seems more effective at patching small wounds. A concotion of highly specialized 'miracle drugs', impossible to reproduce without specialized equipment. Knits flesh together in an instant."
	icon_state = "small"
	icon = 'necromorphs/icons/obj/medipack.dmi'
	w_class = WEIGHT_CLASS_SMALL

	var/oxy_loss = 0
	var/tox_loss = 0
	var/fire_loss = 0
	var/brute_loss = 0
	var/stamina_loss = 0
	var/blood_loss = 0
	var/organ_loss = 0
	var/heal_modifier = 0.05 // heals 5% of damage taken.
	var/jelly_amount = 0 // used for a burst of healing after being healed.
	var/bone_loss = FALSE
	var/life_loss = FALSE
	var/heal_delay = 10 // 1 second
	var/flat_heal = 12.5
	var/death_heal = 0.3 // Used for the adrenaline medipack. Big enough as to reduce the chance of immediately dying again.

	var/base_delay = 10
	var/base_modifier = 0.1
	var/base_organ = 2

/obj/item/medipack/afterattack(atom/target,mob/user,prox)
	. = ..()

	if(!prox || !isliving(target))
		return
	var/mob/living/H = target
	if(H.stat == DEAD && life_loss)
		heal_modifier = death_heal
		heal_delay = 200 //Reviving the dead takes a while, 20 seconds to be exact
		organ_loss = 30
		to_chat(user, "<span class='warning'>You begin using the [src] to try and bring [H] back from the dead...</span>")
	if(H.stat == DEAD && !life_loss) // Won't revive the dead, except for specific extracts
		to_chat(user, "<span class='warning'>[src] will not work on the dead!</span>")
		return
	else if(H.stat != DEAD && life_loss) // Syringes healing the dead won't work well on the living.
		heal_modifier = base_modifier
		heal_delay = base_delay
		organ_loss = base_organ

	if(H != user)
		if(!do_mob(user, H, heal_delay)) // 1 second delay. Heal others faster than yourself!
			return FALSE
		user.visible_message("<span class='notice'>[user] crushes the [src] over [H], the glowing goop quickly regenerating some of [H.p_their()] injuries!</span>",
			"<span class='notice'>You squeeze the [src], and it bursts over [H], the glowing goop regenerating some of [H.p_their()] injuries.</span>")
	else
		if(!do_mob(user, H, (heal_delay * 2))) // 2 second delay. Heal yourself slower than others!
			return FALSE
		user.visible_message("<span class='notice'>[user] crushes the [src] over [user.p_them()]self, the glowing goop quickly regenerating some of [user.p_their()] injuries!</span>",
			"<span class='notice'>You squeeze the [src], and it bursts in your hand, splashing you with glowing goop which quickly regenerates some of your injuries!</span>")

	oxy_loss = (flat_heal + (H.getOxyLoss() * heal_modifier))
	tox_loss = (flat_heal + (H.getToxLoss() * heal_modifier))
	fire_loss = (flat_heal + (H.getFireLoss() * heal_modifier))
	brute_loss = (flat_heal + (H.getBruteLoss() * heal_modifier))
	stamina_loss = (flat_heal + (H.getStaminaLoss() * heal_modifier))

	H.reagents.add_reagent(/datum/reagent/medicine/regen_jelly,jelly_amount) // Splits the healing effect across an instant heal, and a smaller heal after.
	H.specific_heal(brute_amt = brute_loss, fire_amt = fire_loss, tox_amt = tox_loss, oxy_amt = oxy_loss, stam_amt = stamina_loss, organ_amt = organ_loss, clone_amt = 0, blood_amt = blood_loss, specific_bones = bone_loss, specific_revive = life_loss)
	playsound(target, 'sound/effects/splat.ogg', 40, TRUE)
	qdel(src)

/obj/item/medipack/medium
	name = "medium medipack"
	desc = "This medium-sized pack of containers seems more effective at patching decently-sized wounds. A concotion of highly specialized 'miracle drugs', impossible to reproduce without specialized equipment. Knits flesh together in an instant."
	icon_state = "medium"
	w_class = WEIGHT_CLASS_NORMAL

	blood_loss = 50
	organ_loss = 0.5 // 2.5 health per organ.
	heal_modifier = 0.2 // heals 20% of damage taken.
	jelly_amount = 1 // used for a burst of healing after being healed.
	heal_delay = 12.5 // 1.25 seconds.
	flat_heal = 9

/obj/item/medipack/large
	name = "large medipack"
	desc = "This large-sized pack of containers seems more effective at patching most wounds. A concotion of highly specialized 'miracle drugs', impossible to reproduce without specialized equipment. Knits flesh together in an instant."
	icon_state = "large"
	w_class = WEIGHT_CLASS_BULKY // requires a specialized container to store it.

	blood_loss = 150
	organ_loss = 2 // 10 health per organ.
	heal_modifier = 0.45 // heals 45% of damage taken.
	jelly_amount = 7.5 // used for a burst of healing after being healed.
	heal_delay = 20 // 2 seconds.
	flat_heal = 5

/obj/item/medipack/large/proc/in_box_sprite()
	return "[icon_state]_inbox"

/obj/item/medipack/adrenaline
	name = "adrenaline medipack"
	desc = "This needle like container can revive the dead in a pinch. It takes time to apply, as incorrect use could kill the patient. A concotion of highly specialized 'miracle drugs', impossible to reproduce without specialized equipment. Knits flesh together in an instant."
	icon_state = "needle"

	blood_loss = 200
	jelly_amount = 5 // used for a burst of healing after being healed.
	flat_heal = 5
	life_loss = TRUE // revives the dead

/obj/item/storage/fancy/medipack
	name = "medipack holder"
	desc = "This specialized container can hold large medipacks and still fit in backpacks."
	icon = 'necromorphs/icons/obj/medipack.dmi'
	icon_state = "holder"
	base_icon_state = "holder"
	spawn_type = /obj/item/medipack/large
	is_open = TRUE
	appearance_flags = KEEP_TOGETHER|LONG_GLIDE
	contents_tag = "large"

	fold_result = /obj/item/stack/sheet/plastic

/obj/item/storage/fancy/medipack/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.set_holdable(list(/obj/item/medipack/large))
	STR.max_w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/fancy/medipack/PopulateContents()
	. = ..()
	update_appearance()

/obj/item/storage/fancy/medipack/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]"

/obj/item/storage/fancy/medipack/update_overlays()
	. = ..()
	if(!is_open)
		return

	var/medipacks = 0
	for(var/obj/item/medipack/large/medipack in contents)

		. += image(icon = initial(icon), icon_state = medipack.in_box_sprite())
		medipacks += 1
