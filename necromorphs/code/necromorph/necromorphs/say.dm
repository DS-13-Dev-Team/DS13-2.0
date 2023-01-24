/datum/saymode/necromorph
	key = ";"
	mode = MODE_NECROMORPH

/datum/saymode/necromorph/handle_message(mob/living/carbon/human/necromorph/user, message, datum/language/language)
	if(istype(user))
		if(user.hivemind_talk(message))
			return FALSE
	return TRUE
