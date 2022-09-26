/datum/saymode/necromorph
	key = ";"
	mode = MODE_NECROMORPH

/datum/saymode/necromorph/handle_message(mob/living/user, message, datum/language/language)
	if(HAS_TRAIT(user, TRAIT_IS_NECROMORPH))
		var/mob/living/carbon/necromorph/necro = user
		if(necro.hivemind_talk(message))
			return FALSE
	return TRUE
