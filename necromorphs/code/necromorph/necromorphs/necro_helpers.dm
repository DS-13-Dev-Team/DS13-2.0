/mob/living/carbon/necromorph/proc/hivemind_talk(message)
	if(!message || stat)
		return
	if(!marker)
		to_chat(src, span_warning("There is no connection between you and the Marker!"))
		return

	message = "<span class='necromorph'>[name] roars, '[message]'</span>"

	log_talk(message, LOG_SAY)

	marker.hive_mind_message(src, message)

	return TRUE

/mob/living/carbon/necromorph/proc/generate_name()
	//We don't have a nicknumber yet, assign one to stick with us
	if(!nicknumber)
		nicknumber = rand(1, 999)

	name = "[initial(class.display_name)] ([nicknumber])"
	real_name = name
	update_name()

/mob/living/carbon/necromorph/proc/play_necro_sound(audio_type, volume, extra_range)
	CRASH("play_necro_sound() wasn't overriden | Name: [name] | Type: [type]")

/mob/living/carbon/necromorph/proc/start_charge()
	SIGNAL_HANDLER
	charging = TRUE

/mob/living/carbon/necromorph/proc/end_charge()
	SIGNAL_HANDLER
	charging = FALSE

/mob/living/carbon/necromorph/verb/evacuate()
	set name = "Evacuate"
	set category = "Necromorph"

	if(controlling)
		controlling.abstract_move(get_turf(src))
		mind.transfer_to(controlling, TRUE)
		controlling = null
