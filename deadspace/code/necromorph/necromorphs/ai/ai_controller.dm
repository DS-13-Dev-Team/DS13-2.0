///The brains of the ai controlled necromorphs, meant for human based necromorphs.
/datum/ai_controller/necromorph
	//List of sub actions a AI can do, mutates actions based on planning to do different stuff
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_FOLLOW_TARGET = null,
		BB_ATTACK_TARGET = null,
		BB_VISION_RANGE = 9,
	)

	//Hopefully giving them jps doesn't backfire
	ai_movement = /datum/ai_movement/jps

	//The planning part of the AI. Works from top to bottom in priority, works downward as it runs out of stuff to do
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_confinement,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/necro,
	) //TODO : Make a subtree for necros attacking objects to get to the target

/datum/ai_controller/necromorph/TryPossessPawn(atom/new_pawn)
	if(!isliving(new_pawn))
		return AI_CONTROLLER_INCOMPATIBLE

	return ..() //Run parent at end

/datum/ai_controller/necromorph/able_to_run()
	var/mob/living/living_pawn = pawn
	if(IS_DEAD_OR_INCAP(living_pawn))
		return FALSE
	return ..()

/datum/ai_planning_subtree/basic_melee_attack_subtree/necro
	melee_attack_behavior = /datum/ai_behavior/necro_attack

//We have to make our own attack behavior due to other attack behaviors using simplemob stuff
/datum/ai_behavior/necro_attack
	action_cooldown = 2 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/necro_attack/setup(datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	controller.current_movement_target = controller.blackboard[hiding_location_key] || controller.blackboard[target_key]

/datum/ai_behavior/necro_attack/perform(delta_time, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	var/mob/living/carbon/human/necro = controller.pawn
	var/atom/target = controller.blackboard[target_key]
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]

	if(!targetting_datum.can_attack(necro, target))
		finish_action(controller, FALSE, target_key)
		return

	var/hiding_target = targetting_datum.find_hidden_mobs(necro, target) //If this is valid, theyre hidden in something!

	controller.blackboard[hiding_location_key] = hiding_target

	if(hiding_target) //Slap it!
		necro.UnarmedAttack(target)
	else
		necro.UnarmedAttack(target)


/datum/ai_behavior/necro_attack/finish_action(datum/ai_controller/controller, succeeded, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	if(!succeeded)
		controller.blackboard -= target_key

//Planner for if the necro gets stuck and needs to go crazy to get out
/datum/ai_planning_subtree/escape_confinement/SelectBehaviors(datum/ai_controller/controller, delta_time)
	var/mob/living/carbon/human/necro = controller.pawn
	if(necro.buckled || (!isturf(necro.loc) && necro.loc != null)) //Buckled or in something? Panic
		controller.queue_behavior(/datum/ai_behavior/escape_confinement)
		return SUBTREE_RETURN_FINISH_PLANNING //Don't do anything else until you get unstuck

/datum/ai_behavior/escape_confinement
	action_cooldown = 1.5 SECONDS
	behavior_flags = NONE

/datum/ai_behavior/escape_confinement/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/carbon/human/necro = controller.pawn
	var/atom/A = necro.loc
	if(necro.buckled)
		necro.UnarmedAttack(necro.buckled)
	if(!isturf(A) && A != null) //Am I in something?
		necro.UnarmedAttack(A) //MICHAEL, DON'T LEAVE ME HERE!
