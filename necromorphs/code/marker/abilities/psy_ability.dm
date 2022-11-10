/datum/action/cooldown/necro/psy
	name = "Generic psy ability"
	cooldown_time = 0.1 SECONDS
	click_to_activate = TRUE
	var/cost = 0
	var/click_through_static = FALSE
	var/marker_only = FALSE
	var/required_marker_status = SIGNAL_ABILITY_PRE_ACTIVATION|SIGNAL_ABILITY_POST_ACTIVATION

/datum/action/cooldown/necro/psy/New(Target, original, cooldown)
	..()
	name += " | Cost: [cost] psy"

/// Intercepts client owner clicks to activate the ability
/datum/action/cooldown/necro/psy/InterceptClickOn(mob/camera/marker_signal/caller, params, atom/target)
	if(!IsAvailable())
		return FALSE
	if(!target)
		return FALSE
	if(caller.psy_energy < cost)
		to_chat(caller, span_notice("You don't have enough psy to use this ability"))
		return FALSE

	if(istype(target, /atom/movable/screen/cameranet_static))
		if(!click_through_static)
			return FALSE
		var/list/modifiers = params2list(params)
		var/new_target = parse_caught_click_modifiers(modifiers, get_turf(caller), caller.client)
		params = list2params(modifiers)
		if(!new_target)
			return FALSE
		target = new_target

	// The actual action begins here
	if(!PreActivate(target, caller))
		return FALSE

	caller.click_intercept = null
	return TRUE

/// For signal calling
/datum/action/cooldown/necro/psy/PreActivate(atom/target, mob/camera/marker_signal/caller)
	if(SEND_SIGNAL(owner, COMSIG_ABILITY_STARTED, src) & COMPONENT_BLOCK_ABILITY_START)
		return
	// Note, that PreActivate handles no cooldowns at all by default.
	// Be sure to call StartCooldown() in Activate() where necessary.
	. = Activate(target, caller)
	// There is a possibility our action (or owner) is qdeleted in Activate().
	if(!QDELETED(src) && !QDELETED(owner))
		SEND_SIGNAL(owner, COMSIG_ABILITY_FINISHED, src)

/datum/action/cooldown/necro/psy/Activate(atom/target, mob/camera/marker_signal/caller)
	caller.change_psy_energy(-cost)
	..()
