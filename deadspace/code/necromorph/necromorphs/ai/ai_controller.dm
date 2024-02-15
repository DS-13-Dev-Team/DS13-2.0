//The brains of the ai controlled necromorphs
/datum/ai_controller/necromorph
	//List of sub actions a AI can do, mutates actions based on planning to do different stuff
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_FOLLOW_TARGET = null,
		BB_ATTACK_TARGET = null,
		BB_VISION_RANGE = 9,
	)

	//I would give them more complex pathfinding, but im worried too many of them will bog down the server
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	movement_delay = 0.25 SECONDS

	//The planning part of the AI. Works from top to bottom in priority, works downward as it runs out of stuff to do
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/necro,
	)

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
