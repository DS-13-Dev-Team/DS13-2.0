GLOBAL_LIST_INIT(statmods, list(
								STATMOD_MOVESPEED_ADDITIVE = list(/datum/proc/update_movespeed_factor),
								STATMOD_MOVESPEED_MULTIPLICATIVE = list(/datum/proc/update_movespeed_factor),
								STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE = list(/datum/proc/update_incoming_damage_factor),
								STATMOD_ATTACK_SPEED = list(/datum/proc/update_attack_speed),
								STATMOD_HEALTH = list(/datum/proc/update_max_health),
								STATMOD_HEALTH_MULTIPLICATIVE =	list(/datum/proc/update_max_health)
))

/datum/component/statmod
	var/auto_register_statmods = TRUE
	var/list/statmods = null

/datum/component/statmod/Initialize(...)
	. = ..()
	//This extension wants to apply statmods to its holder!
	if (statmods && auto_register_statmods)
		register_statmods()

/datum/component/statmod/Destroy(force, silent)
	if (statmods)
		for (var/modtype in statmods)
			unregister_statmod(modtype)
	. = ..()

/datum/component/statmod/proc/register_statmods(update = TRUE)
	for (var/modtype in statmods)
		register_statmod(modtype, update)

/datum/component/statmod/proc/unregister_statmods()
	for (var/modtype in statmods)
		unregister_statmod(modtype)

//Trigger all relevant update procs without changing registration
/datum/component/statmod/proc/update_statmods()
	var/mob/M = parent
	if (!istype(M))
		return
	for (var/modtype in statmods)
		var/list/data = GLOB.statmods[modtype]
		var/update_proc = data[1]
		call(M, update_proc)()

/datum/component/statmod/proc/register_statmod(modtype, update = TRUE)
	//Currently only supported for mobs
	var/mob/M = parent
	if (!istype(M))
		return


	//Initialize the list
	if (!LAZYACCESS(M.statmods, modtype))
		//This will create the statmods list AND insert a key/value pair for modtype/list()
		LAZYSET(M.statmods, modtype, list())

	LAZYOR(M.statmods[modtype], src)

	//Now lets make them update
	if (update)
		var/list/data = GLOB.statmods[modtype]
		var/update_proc = data[1]
		call(M, update_proc)()//And call it

/datum/component/statmod/proc/unregister_statmod(modtype)
	//Currently only supported for mobs
	var/mob/M = parent
	if (!istype(M))
		return

	//If it doesn't exist we dont need to do anything
	if (!LAZYACCESS(M.statmods, modtype))
		return



	LAZYREMOVEASSOC(M.statmods, modtype, src)
	//Now lets make them update
	var/list/data = GLOB.statmods[modtype]
	var/update_proc = data[1]
	call(M, update_proc)()//And call it


/datum/component/statmod/proc/get_statmod(modtype)
	return LAZYACCESS(statmods, modtype)

/*
	Movespeed
*/
/datum/proc/update_movespeed_factor()

/mob/update_movespeed_factor()
	var/movespeed = 0

	remove_movespeed_modifier(/datum/movespeed_modifier/statmods)
	//We add the result of each additive modifier
	for (var/datum/component/statmod/E as anything in LAZYACCESS(statmods, STATMOD_MOVESPEED_ADDITIVE))
		movespeed += E.get_statmod(STATMOD_MOVESPEED_ADDITIVE)

	if(movespeed == 0)
		movespeed = 1
	//We multiply by the result of each multiplicative modifier
	for (var/datum/component/statmod/E as anything in LAZYACCESS(statmods, STATMOD_MOVESPEED_MULTIPLICATIVE))
		movespeed *= E.get_statmod(STATMOD_MOVESPEED_MULTIPLICATIVE)

	if(!(movespeed == 1))
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/statmods, TRUE, movespeed)

/*
	Incoming Damage
*/
//Additive modifiers first, then multiplicative
/datum/proc/update_incoming_damage_factor()

/mob/living/update_incoming_damage_factor()
	incoming_damage_mult = 1

	//We multiply by the result of each multiplicative modifier
	for (var/datum/component/statmod/E as anything in LAZYACCESS(statmods, STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE))
		incoming_damage_mult *= E.get_statmod(STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE)

/*
	attackspeed
*/
/datum/proc/update_attack_speed()

/mob/living/update_attack_speed()
	next_move_adjust = 0

	//We multiply by the result of each multiplicative modifier
	for (var/datum/component/statmod/E as anything in LAZYACCESS(statmods, STATMOD_ATTACK_SPEED))
		next_move_adjust -= E.get_statmod(STATMOD_ATTACK_SPEED)

/*
	Health:
	The max health of this mob, how much damage it can take before dying

	Currently only meaningful for necromorphs and animals. Won't do much for non-necro humans because brainmed
*/

/datum/proc/update_max_health()
	return

/mob/living/carbon/human/necromorph/update_max_health()
	maxHealth = get_base_health()

	for (var/datum/component/statmod/comp as anything in LAZYACCESS(statmods, STATMOD_HEALTH_MULTIPLICATIVE))
		var/health_increase = (maxHealth * comp.get_statmod(STATMOD_HEALTH_MULTIPLICATIVE))
		maxHealth += health_increase

	for (var/datum/component/statmod/comp as anything in LAZYACCESS(statmods, STATMOD_HEALTH))
		class.max_health += comp.get_statmod(STATMOD_HEALTH)

	updatehealth()

/datum/proc/get_base_health()

/mob/living/get_base_health()
	return max(initial(health), MAX_LIVING_HEALTH)

/mob/living/carbon/human/necromorph/get_base_health()
	return class.max_health

