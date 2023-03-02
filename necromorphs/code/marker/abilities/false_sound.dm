/datum/action/cooldown/necro/psy/false_sound
	name = "False Sound"
	desc = "A context sensitive spell which does different things depending on the target. Interfaces with machines, moves items, messes with computers and office appliances."
	button_icon_state = "false_sound"
	cost = 100
	cooldown_time = 2 MINUTES
	marker_flags = SIGNAL_ABILITY_PRE_ACTIVATION

/datum/action/cooldown/necro/psy/false_sound/Activate(turf/target)
	target = get_turf(target)
	if(!target)
		return
	//Add more necromorphs here, perhaps we should make it a define to make sure it's updated
	var/list/category = GLOB.necromorph_sounds[tgui_input_list(owner, "Pick a necromorph type", "False Sound", GLOB.necromorph_sounds)]
	if(!category)
		return TRUE
	var/list/picked_sound = tgui_input_list(owner, "Pick sound type to play", "False Sound", category)
	if(!picked_sound)
		return TRUE
	var/volume = VOLUME_MID
	if (picked_sound == SOUND_SHOUT || picked_sound == SOUND_SHOUT_LONG || picked_sound == SOUND_DEATH)
		volume = VOLUME_LOUD
	playsound(target, pick(category[picked_sound]), volume, 1, 2)
	..()
	return TRUE

/datum/action/cooldown/necro/psy/false_sound/after_activation
	cost = 25
	cooldown_time = 15 SECONDS
	marker_flags = SIGNAL_ABILITY_POST_ACTIVATION
