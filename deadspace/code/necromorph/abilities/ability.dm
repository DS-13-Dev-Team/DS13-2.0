/datum/action/cooldown/necro
	background_icon_state = "bg_demon"
	var/activate_keybind = null

/datum/action/cooldown/necro/New(Target, original, cooldown)
	. = ..()
	if(!isnull(cooldown))
		cooldown_time = cooldown

/datum/action/cooldown/necro/Grant(mob/granted_to)
	.=..()
	if(!owner)
		return
	if(!isnull(activate_keybind))
		RegisterSignal(granted_to, activate_keybind, TYPE_PROC_REF(/datum/action/cooldown/necro, TriggerOnKeybindSignal))

/datum/action/cooldown/necro/Remove(mob/removed_from)
	UnregisterSignal(removed_from, activate_keybind)
	return ..()

/datum/action/cooldown/necro/proc/CooldownEnd()
	return

/datum/action/cooldown/necro/process(delta_time)
	.=..()
	if((next_use_time - world.time) <= 0)
		CooldownEnd()

/datum/action/cooldown/necro/proc/TriggerOnKeybindSignal(mob/source)
	SIGNAL_HANDLER
	Trigger()
	return COMSIG_KB_ACTIVATED

/*
	Active abilties that can be activated but can't be deactivated
*/

/datum/action/cooldown/necro/active
	var/duration_time = 2 SECONDS
	var/active = FALSE

/datum/action/cooldown/necro/active/New(Target, cooldown, duration)
	if(!isnull(duration))
		duration_time = duration
	.=..()

/datum/action/cooldown/necro/active/Destroy()
	CooldownEnd()
	STOP_PROCESSING(SSfastprocess, src)
	.=..()

/datum/action/cooldown/necro/active/Activate(atom/target)
	active = TRUE
	StartCooldown(duration_time)

/datum/action/cooldown/necro/active/CooldownEnd()
	if(active)
		active = FALSE
		StartCooldown()
		return TRUE
