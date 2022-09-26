/mob/living/update_resting()
	.=..()
	SEND_SIGNAL(src, COMSIG_LIVING_UPDATED_RESTING, resting)
