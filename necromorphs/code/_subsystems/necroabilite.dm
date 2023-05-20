PROCESSING_SUBSYSTEM_DEF(necroabilite)
	name = "Processing necroabilite"
	wait = 0.2 SECONDS
	stat_tag = "PA"
	process_proc = /datum/proc/process_abilitie

/datum/proc/process_abilitie()
	set waitfor = FALSE
	return PROCESS_KILL
