GLOBAL_LIST_INIT(mining_evidences, typecacheof(list(
	/obj/item/gun/energy/recharge/kinetic_accelerator,
	/obj/item/mining_scanner,
	/obj/item/t_scanner/adv_mining_scanner,
	/obj/item/gun/energy/plasmacutter,
)))
GLOBAL_LIST_INIT(unitology_evidences, typecacheof(list(
	/obj/structure/marker,
	/obj/item/knife/unitology,
//	/obj/item/storage/bible/unitology,
)))

/datum/antagonist/egov_agent
	name = "\improper EarthGov Agent"
	roundend_category = "earthgov agents"
	typecache_datum_blacklist = list(/datum/antagonist/unitoligst)
	job_rank = ROLE_EARTHGOV_AGENT
	antag_memory = "You are a well-trained agent of the government of Earth, sent to spy on the illegal planet cracking operation in the Cygnus system. In addition, you are investigating a lead that the Church of Unitology has infiltrated the crew. It is your assignment to report back to your superiors, investigate the situation surrounding the Church, and protect the interests of Earth. You have been provided a direct comm-link to <b>EarthGov Command</b>. Remember, EarthGov directives come before your own.."
	antag_moodlet = /datum/mood_event/focused
	hud_icon = 'necromorphs/icons/mob/huds/antag_hud.dmi'
	antag_hud_name = "earthgov"
	suicide_cry = "FOR THE EARTH!!!"
	antagpanel_category = "Dead Space"
	show_name_in_check_antagonists = TRUE
	var/datum/team/earthgov_agents_team/team

/datum/antagonist/egov_agent/on_gain()
	. = ..()
	give_equipment()

/datum/antagonist/egov_agent/greet()
	. = ..()
	to_chat(owner, span_boldannounce("Your objective is to spy on the illegal planet cracking operation in the Cygnus system."))
	to_chat(owner, span_boldannounce("In addition, you are investigating a lead that the Church of Unitology has infiltrated the crew."))
	to_chat(owner, span_boldannounce("You must gather evidences of both and send them to the Earth Government over fax."))

/datum/antagonist/egov_agent/proc/give_equipment()
	var/mob/living/carbon/human/H = owner.current

/datum/antagonist/egov_agent/create_team(datum/team/earthgov_agents_team/new_team)
	if(!new_team)
		for(var/datum/antagonist/egov_agent/agent in GLOB.antagonists)
			if(!agent.owner)
				stack_trace("Antagonist datum without owner in GLOB.antagonists: [agent]")
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

/datum/team/earthgov_agents_team
	name = "earthgov agents"
	member_name = "earthgov agent"
	var/gathered_mining_evidences = 0
	var/gathered_untiology_evidences = 0

/datum/team/earthgov_agents_team/New()
	..()
	create_objectives()

/datum/team/earthgov_agents_team/proc/create_objectives()
	var/datum/objective/find_evidences/evidences_objective = new
	evidences_objective.team = src
	objectives += evidences_objective

	evidences_objective = new
	evidences_objective.team = src
	objectives += evidences_objective
