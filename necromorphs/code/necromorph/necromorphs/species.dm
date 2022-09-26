//It exists just for compability. Don't add any vars or special behaviours
/datum/species/necromorph
	name = "Necromorph"
	id = "necromorph"
	//There is no way to become it. Period.
	changesource_flags = MIRROR_BADMIN
	exotic_bloodtype = "X"

/datum/species/necromorph/check_roundstart_eligible()
	return FALSE
