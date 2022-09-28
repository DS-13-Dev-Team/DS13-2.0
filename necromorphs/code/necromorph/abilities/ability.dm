/datum/action/cooldown/necro
	background_icon_state = "bg_demon"

/datum/action/cooldown/necro/New(Target, original, cooldown)
	. = ..()
	if(!isnull(cooldown))
		cooldown_time = cooldown

/datum/action/cooldown/necro/proc/CooldownEnd()
	return

/datum/action/cooldown/necro/process(delta_time)
	.=..()
	var/time_left = max(next_use_time - world.time, 0)
	if(!time_left)
		CooldownEnd()

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
