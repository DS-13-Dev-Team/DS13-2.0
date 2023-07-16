/obj/effect/mob_spawn/ghost_role/drone/scavbot
	name = "Scavenger bot shell"
	desc = "A shell of a maintenance drone, an expendable robot built to perform station repairs."
	icon = 'deadspace/icons/mob/dsbots.dmi'
	icon_state = "spiderbot_off"
	anchored = FALSE
	layer = BELOW_MOB_LAYER
	density = FALSE
	move_resist = 1000
	mob_name = "scavanger bot"
	///Type of drone that will be spawned
	mob_type = /mob/living/simple_animal/drone/classic/scavbot
	role_ban = ROLE_DRONE
	show_flavor = FALSE
	prompt_name = "Scavenger bot"
	you_are_text = "You are a scavenger bot."
	flavour_text = "You are a corporate owned scavenger bot, you've been tasked with the scavanging of the station or ship."
	important_text = "You MUST read and follow your laws carefully."
	spawner_job_path = /datum/job/maintenance_drone

/obj/effect/mob_spawn/ghost_role/drone/scavbot/Initialize(mapload)
	. = ..()
	var/area/A = get_area(src)
	if(A)
		notify_ghosts("A Scavenger Bot has been created in \the [A.name].", source = src, action=NOTIFY_ATTACK, flashwindow = FALSE, ignore_key = POLL_IGNORE_DRONE, notify_suiciders = FALSE)

/obj/effect/mob_spawn/ghost_role/drone/scavbot/allow_spawn(mob/user, silent = FALSE)
	var/client/user_client = user.client
	var/mob/living/simple_animal/drone/drone_type = mob_type
	if(!initial(drone_type.shy) || isnull(user_client) || !CONFIG_GET(flag/use_exp_restrictions_other))
		return ..()
	var/required_role = CONFIG_GET(string/drone_required_role)
	var/required_playtime = CONFIG_GET(number/drone_role_playtime) * 60
	if(CONFIG_GET(flag/use_exp_restrictions_admin_bypass) && check_rights_for(user.client, R_ADMIN))
		return ..()
	if(user?.client?.prefs.db_flags & DB_FLAG_EXEMPT)
		return ..()
	if(required_playtime <= 0)
		return ..()
	var/current_playtime = user_client?.calc_exp_type(required_role)
	if (current_playtime < required_playtime)
		var/minutes_left = required_playtime - current_playtime
		var/playtime_left = DisplayTimeText(minutes_left * (1 MINUTES))
		if(!silent)
			to_chat(user, span_danger("You need to play [playtime_left] more as [required_role] to spawn as a Scavenger Bot!"))
		return FALSE
	return ..()
