/datum/action/cooldown/necro/psy
	name = "Generic psy abilities"
	click_to_activate = TRUE
	var/cost = 0
	var/click_through_static = FALSE
	var/required_marker_status = SIGNAL_ABILITY_PRE_ACTIVATION|SIGNAL_ABILITY_POST_ACTIVATION

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
		// Find a turf below the location we clicked at
		var/list/list_params = params2list(params)
		var/list/view = getviewsize(caller.client.view)
		var/list/screen_loc = splittext(list_params["screen-loc"], ",")
		var/x = splittext(screen_loc[1], ":")
		x = caller.x-round(view[1]*0.5, 1)+text2num(x[1])
		var/y = splittext(screen_loc[2], ":")
		y = caller.y-round(view[2]*0.5, 1)+text2num(y[1])
		target = locate(x, y, caller.z)

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
