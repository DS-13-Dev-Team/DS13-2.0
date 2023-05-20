/datum/antagonist/egov_agent
	name = "\improper EarthGov Agent"
	roundend_category = "earthgov agents"
	typecache_datum_blacklist = list(/datum/antagonist/unitologist)
	job_rank = ROLE_EARTHGOV_AGENT
	antag_memory = "You are a well-trained agent of the government of Earth, sent to spy on the illegal planet cracking operation in the Cygnus system. In addition, you are investigating a lead that the Church of Unitology has infiltrated the crew. It is your assignment to report back to your superiors, investigate the situation surrounding the Church, and protect the interests of Earth at all cost."
	antag_moodlet = /datum/mood_event/focused
	hud_icon = 'necromorphs/icons/mob/huds/antag_hud.dmi'
	antag_hud_name = "earthgov"
	suicide_cry = "FOR THE EARTH!!!"
	antagpanel_category = "Dead Space"
	show_name_in_check_antagonists = TRUE
	//TEMP. TODO: Replace with something earthgov related
	preview_outfit = /datum/outfit/job/assistant
	var/datum/team/earthgov_agents_team/team

/datum/antagonist/egov_agent/greet()
	. = ..()
	to_chat(owner, span_boldannounce("Your objective is to spy on the illegal planet cracking operation in the Cygnus system."))
	to_chat(owner, span_boldannounce("You must report illegal CEC activity and unitology activity to the Earth Government over fax."))
	owner.announce_objectives()

/datum/antagonist/egov_agent/on_gain()
	make_objectives()
	. = ..()

/datum/antagonist/egov_agent/proc/make_objectives()
	if(team)
		objectives |= team.objectives

/datum/antagonist/egov_agent/create_team(datum/team/earthgov_agents_team/new_team)
	if(!new_team)
		for(var/datum/antagonist/egov_agent/agent in GLOB.antagonists)
			if(!agent.owner)
				continue
			if(agent.team)
				team = agent.team
				return
		team = new /datum/team/earthgov_agents_team
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	team = new_team

/datum/antagonist/egov_agent/get_team()
	return team

/datum/antagonist/egov_agent/apply_innate_effects(mob/living/mob_override)
	add_team_hud(mob_override || owner.current, /datum/antagonist/egov_agent)

/datum/team/earthgov_agents_team
	name = "earthgov agents"
	member_name = "earthgov agent"

/datum/team/earthgov_agents_team/New()
	..()
	create_objectives()

/datum/team/earthgov_agents_team/proc/create_objectives()
	var/datum/objective/egov_agent_fluff/objective = new
	objective.team = src
	objectives += objective

/datum/objective/egov_agent_fluff

/datum/objective/egov_agent_fluff/New(text)
	explanation_text = pick(
		"Report supsicous unitology activity and illegal CEC activity to Earth Government over fax.",
		"Inform the Earth Government by fax of any suspicious unitology activity and illegal CEC activity.",
	)
	..()

/datum/objective/egov_agent_fluff/check_completion()
	return TRUE
