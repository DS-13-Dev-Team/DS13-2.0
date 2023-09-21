#define CHARGE_SPEED min((tiles_moved - tiles_before_charge) * speed_per_tile, maximum_speed)
#define CHARGE_STOP -1

/datum/action/cooldown/necro/advanced_charge
	name = "Toggle Charging"
	/// Wether the user is currently charging or not
	var/active = FALSE
	/// The number of tiles the user has moved since the charge started
	var/tiles_moved = 0
	/// The number of tiles the user must move before the charge starts.
	/// Creates negative speed modifier to make users toggle charging when needed
	var/tiles_before_charge = 3
	/// The speed modifier per tile moved
	var/speed_per_tile = 0.15
	/// The maximum speed modifier
	var/maximum_speed = 2.1
	/// Time before which we should make a move to continue charge
	var/next_move_limit = 0
	/// Direction we are charging at
	var/charge_dir = NONE

/datum/action/cooldown/necro/advanced_charge/New(Target, original, cooldown)
	desc = "Toggle charging to move faster and cause damage on crush. You will be slower before you move [tiles_before_charge] tiles."
	..()

/datum/action/cooldown/necro/advanced_charge/Activate(atom/target)
	if(active)
		stop_charge()
		to_chat(owner, span_notice("You stop charging when moving."))
		return TRUE
	start_charge()
	to_chat(owner, span_notice("You start charging when moving."))
	return TRUE

/datum/action/cooldown/necro/advanced_charge/proc/start_charge()
	active = TRUE
	tiles_moved = 0
	RegisterSignal(owner, COMSIG_MOB_CLIENT_PRE_MOVE, PROC_REF(on_client_premove))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
	RegisterSignal(owner, COMSIG_ATOM_DIR_CHANGE, PROC_REF(on_dir_change))
	RegisterSignal(owner, COMSIG_MOVABLE_BUMP, PROC_REF(on_bump))
	relalculate_speed()

/datum/action/cooldown/necro/advanced_charge/proc/stop_charge()
	active = FALSE
	tiles_moved = 0
	UnregisterSignal(owner, list(COMSIG_MOB_CLIENT_PRE_MOVE, COMSIG_MOVABLE_MOVED, COMSIG_ATOM_DIR_CHANGE, COMSIG_MOVABLE_BUMP))
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/necro_charge)

/datum/action/cooldown/necro/advanced_charge/proc/on_client_premove(datum/source, list/move_args)
	SIGNAL_HANDLER
	if(next_move_limit < world.time || move_args[2] != charge_dir)
		tiles_moved = 0
		relalculate_speed()

/datum/action/cooldown/necro/advanced_charge/proc/on_moved(datum/source, atom/oldloc, direction, Forced, old_locs)
	SIGNAL_HANDLER
	if(Forced || owner.throwing)
		return
	if(!tiles_moved)
		charge_dir = direction
	++tiles_moved
	relalculate_speed()
	on_move_action()

/datum/action/cooldown/necro/advanced_charge/proc/on_dir_change(datum/source, old_dir, new_dir)
	SIGNAL_HANDLER
	tiles_moved = 0
	relalculate_speed()

/datum/action/cooldown/necro/advanced_charge/proc/on_bump(datum/source, atom/bumped)
	SIGNAL_HANDLER
	if(tiles_moved <= tiles_before_charge)
		return
	var/crush_result = bumped.crush_act(owner, CHARGE_SPEED)
	if(!crush_result)
		return
	//Might need to add some to_chat/visible_message calls below
	if(crush_result == CHARGE_STOP)
		tiles_moved = 0
	else
		tiles_moved -= tiles_moved * (100 - crush_result)
	relalculate_speed()

/datum/action/cooldown/necro/advanced_charge/proc/relalculate_speed()
	if(active)
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/necro_charge, TRUE, CHARGE_SPEED)

/// To be overridden by child types
/datum/action/cooldown/necro/advanced_charge/proc/on_move_action()
	return

/atom/proc/crush_act(atom/movable/crushing, speed)
	return CHARGE_STOP

#undef CHARGE_STOP
#undef CHARGE_SPEED
