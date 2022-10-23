/datum/action/cooldown/necro/psy/false_sound
	name = "False Sound"
	desc = "A context sensitive spell which does different things depending on the target. Interfaces with machines, moves items, messes with computers and office appliances."
	cost = 100
	cooldown_time = 2 MINUTES
	required_marker_status = SIGNAL_ABILITY_PRE_ACTIVATION

/datum/action/cooldown/necro/psy/false_sound/Activate(turf/target, mob/camera/marker_signal/caller)
	target = get_turf(target)
	if(!target)
		return
	//Add more necromorphs here, perhaps we should make it a define to make sure it's updated
	var/static/list/possible_sounds = list(
		"Slasher" = GLOB.slasher_sounds,
		"Puker" = GLOB.puker_sounds,
		"Spitter" = GLOB.spitter_sounds,
	)
	var/list/category = possible_sounds[tgui_input_list(caller, "Pick a necromorph type", "False Sound", possible_sounds)]
	if(!category)
		return
	var/list/picked_sound = tgui_input_list(caller, "Pick sound type to play", "False Sound", category)
	if(!picked_sound)
		return
	var/volume = VOLUME_MID
	if (picked_sound == SOUND_SHOUT || picked_sound == SOUND_SHOUT_LONG || picked_sound == SOUND_DEATH)
		volume = VOLUME_LOUD
	playsound(target, pick(category[picked_sound]), volume, 1, 2)
	..()
	return TRUE

/datum/action/cooldown/necro/psy/false_sound/after_activation
	cost = 25
	cooldown_time = 15 SECONDS
	required_marker_status = SIGNAL_ABILITY_POST_ACTIVATION
