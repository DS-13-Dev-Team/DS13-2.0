/datum/objective/find_evidences
	name = "find evidences"
	objective_name = "Find Evidences"
	target_amount = 1
	//What trait does a picture need to have to be considered an evidence
	var/evidences_trait = null

/datum/objective/find_evidences/New(text)
	..()
	target_amount = rand(2, 4)
	update_explanation_text()

/datum/objective/find_evidences/mining
	evidences_trait = TRAIT_MINING_EVIDENCES

/datum/objective/find_evidences/mining/update_explanation_text()
	..()
	explanation_text = "Find [target_amount] evidence\s of illegal planet cracking operation in the Cygnus system."

/datum/objective/find_evidences/mining/check_completion()
	if(!team)
		return FALSE
	var/datum/team/earthgov_agents_team/our_team = team
	return our_team.gathered_mining_evidences >= target_amount

/datum/objective/find_evidences/unitology
	evidences_trait = TRAIT_UNTIOLOGY_EVIDENCES

/datum/objective/find_evidences/unitology/update_explanation_text()
	..()
	explanation_text = "Find [target_amount] evidence\s of Church of Unitology infiltrating the crew."

/datum/objective/find_evidences/unitology/check_completion()
	if(!team)
		return FALSE
	var/datum/team/earthgov_agents_team/our_team = team
	return our_team.gathered_untiology_evidences >= target_amount
