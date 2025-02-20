//#define CONTAINMENT_WEIGHT_UNITOLOGIST 100 //Uncomment when we have psuedo antag unitologists

//What percentage of our population can become antags
#define CONTAINMENT_ANTAG_COEFF 0.15

/datum/game_mode/containment
	name = "Containment"
	weight = GAMEMODE_WEIGHT_COMMON
	votable = TRUE
	min_pop = 0
	required_enemies = 0
	force_pre_setup_check = TRUE

	var/list/antag_weight_map = list(
		/datum/antagonist_selector/zealot = 75
	)

	var/list/antag_selectors = list()
	var/list/antag_pool = list()

	var/obj/structure/marker/main_marker
	var/minimum_round_crew = 2
	var/minimum_alive_percentage = 0.1 //0.1 = 10%

/datum/game_mode/containment/New()
	. = ..()
	var/list/for_reference = antag_weight_map.Copy()
	antag_weight_map.Cut()

	for(var/selector_path in for_reference)
		antag_weight_map[new selector_path] = for_reference[selector_path]

/datum/game_mode/containment/Destroy(force, ...)
	QDEL_LIST(antag_weight_map)
	QDEL_LIST(antag_pool)
	return ..()

///Attempts to select players for special roles the mode might have.
/datum/game_mode/containment/pre_setup()
	. = ..()
	setup_marker()

	if(length(SSticker.ready_players) < 5) //If we have less then 5 players it won't pick antags
		return TRUE

	var/number_of_antags = max(1, floor(length(SSticker.ready_players) * CONTAINMENT_ANTAG_COEFF))
	var/number_of_egov = max(1, floor(length(SSticker.ready_players) * 0.05)) //Should only have more then 1 Egov at 50 players

	var/list/player_pool = SSticker.ready_players.Copy()

	//Setup a list of antags to try to spawn
	while(number_of_antags)
		antag_pool[pick_weight(antag_weight_map)] += 1
		number_of_antags--

	//Most gamemodes don't have other antags spawning in tandem, so we have to add our own little magic
	while(number_of_egov)
		antag_pool[/datum/antagonist_selector/earthgov] += 1
		number_of_egov--

	for(var/datum/antagonist_selector/selector in antag_pool)
		selector.setup(antag_weight_map[selector], player_pool)
		player_pool -= selector.selected_mobs

/datum/game_mode/containment/proc/setup_marker()
	if(!length(GLOB.possible_marker_locations))
		log_mapping("No /obj/effect/marker_location was placed on the map!")
		return
	//Just it for now
	var/turf/location = pick(GLOB.possible_marker_locations)
	main_marker = new /obj/structure/marker(location)
	addtimer(CALLBACK(src, PROC_REF(activate_marker)), rand(25 MINUTES, 40 MINUTES))

//Add a win message here perhaps?
/datum/game_mode/containment/proc/marker_destroyed(obj/structure/marker/destroyed)
	if(destroyed == main_marker)
		main_marker = null

/datum/game_mode/containment/proc/activate_marker()
	main_marker?.activate()

/datum/game_mode/containment/post_setup(report)
	if(!CONFIG_GET(flag/no_intercept_report))
		addtimer(CALLBACK(src, PROC_REF(announce_marker)), rand(1 MINUTES, 3 MINUTES))

	return ..()

/datum/game_mode/containment/process(delta_time)
	return //A bandaid fix to prevent runtimes. Replace this if we want to do certain stuff midround

/datum/game_mode/containment/proc/announce_marker()
	. += "<center><b><h2>CEC Corporation Report</h2></b></center><hr><br />"
	. += "Your ship is currently in Cygnus System not far from Aegis VII planet. It is resricted area of space and you shold avoid outside contancts. Your task is to extract alien artifact on the planet surface and deliver it to the rendezvous point. Make sure Earth Government or crew without priority access will not find out about your location, task or cargo. "

	print_command_report(., "CEC Corporation Report", announce=FALSE)
	priority_announce("Thanks to the tireless efforts of our security and intelligence divisions, there are currently no credible threats to [station_name()]. All station construction projects have been authorized. Have a secure shift!", "Security Report", "", SSstation.announcer.get_rand_report_sound())

/datum/game_mode/containment/check_finished(force_ending)
	. = ..()
	if(force_ending)
		return TRUE

	if(main_marker?.active)
		if(length(GLOB.joined_player_list) >= minimum_round_crew)
			var/minimum_living_crew = ROUND_UP(length(GLOB.joined_player_list) * minimum_alive_percentage)
			if (get_living_active_crew_on_station() < minimum_living_crew)
				return TRUE

/proc/get_living_active_crew_on_station()
	. = 0
	for(var/mob/living/alive as anything in GLOB.alive_player_list)
		if(!(alive.ckey in GLOB.joined_player_list))
			continue
		if(alive.client.is_afk())
			continue
		if(isnecromorph(alive)) //So we don't count necromorphs
			continue
		var/turf/location = get_turf(alive)
		if(!location || !SSmapping.level_trait(location.z, ZTRAIT_STATION))
			continue
		. += 1

/datum/game_mode/containment/setup_antags()
	for(var/datum/antagonist_selector/selector in antag_pool)
		selector.give_antag_datums()
	return ..()

/datum/game_mode/containment/post_setup(report)
	. = ..()
	for(var/datum/antagonist_selector/selector in antag_pool)
		selector.post_setup()

/// Mode specific admin panel.
/datum/game_mode/containment/admin_panel()
	return

GLOBAL_LIST_EMPTY(possible_marker_locations)

/obj/effect/marker_location
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = ""

/obj/effect/marker_location/Initialize()
	..()
	GLOB.possible_marker_locations += get_turf(src)
	return INITIALIZE_HINT_QDEL
