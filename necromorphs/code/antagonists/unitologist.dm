/datum/antagonist/unitologist
	name = "\improper Unitologist Zealot"
	roundend_category = "untiologists zealots"
	typecache_datum_blacklist = list(/datum/antagonist/egov_agent)
	job_rank = ROLE_UNITOLOGIST_ZEALOT
	antag_memory = "You are a zealot of Unitology, one of firm belief in convergence and be made whole, willing to do anything in pursuit of your beliefs. It is your assignment to make the Crew see the light, and submit to convergence, one way or the other. You have been blessed with a psychic connection created by the <b>marker</b>, and must serve the marker's will at all costs."
	antag_moodlet = /datum/mood_event/focused
	hud_icon = 'necromorphs/icons/mob/huds/antag_hud.dmi'
	antag_hud_name = "untiologist"
	suicide_cry = "FOR THE CHURCH!!!"
	antagpanel_category = "Dead Space"
	show_name_in_check_antagonists = TRUE
	//TEMP. TODO: Replace with something untiology related
	preview_outfit = /datum/outfit/job/assistant
	var/datum/team/unitologists_team/team

/datum/antagonist/unitologist/greet()
	. = ..()
	to_chat(owner, span_boldannounce("You feel a psychic link between you and the Marker."))
	to_chat(owner, span_boldannounce("You feel like you will server it at all costs."))
	owner.announce_objectives()

/datum/antagonist/unitologist/on_gain()
	make_objectives()
	. = ..()

/datum/antagonist/unitologist/proc/make_objectives()
	if(team)
		objectives |= team.objectives

/datum/antagonist/unitologist/create_team(datum/team/unitologists_team/new_team)
	if(!new_team)
		for(var/datum/antagonist/unitologist/agent in GLOB.antagonists)
			if(!agent.owner)
				continue
			if(agent.team)
				team = agent.team
				return
		team = new /datum/team/unitologists_team
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	team = new_team

/datum/antagonist/unitologist/get_team()
	return team

/datum/antagonist/unitologist/apply_innate_effects(mob/living/mob_override)
	add_team_hud(mob_override || owner.current, /datum/antagonist/unitologist)

/datum/team/unitologists_team
	name = "unitologists zealots"
	member_name = "unitologist zealot"

/datum/team/unitologists_team/New()
	..()
	create_objectives()

/datum/team/unitologists_team/proc/create_objectives()
	var/datum/objective/unitologist_fluff/objective = new
	objective.team = src
	objectives += objective

/datum/objective/unitologist_fluff

/datum/objective/unitologist_fluff/New(text)
	explanation_text = "Serve the marker at all costs."
	..()

/datum/objective/unitologist_fluff/check_completion()
	return TRUE
