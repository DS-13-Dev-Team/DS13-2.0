/datum/action/cooldown/necro/active/gallop
	name = "Gallop"
	button_icon_state = "sniper_zoom"
	desc = "Gives a huge burst of speed, but makes you vulnerable."
	cooldown_time = 10 SECONDS
	duration_time = 6 SECONDS

/datum/action/cooldown/necro/active/gallop/Activate(atom/target)
	var/mob/living/carbon/human/necromorph/holder = owner
	if(holder.stat > CONSCIOUS || holder.body_position != STANDING_UP || holder.charging)
		return
	..()
	holder.play_necro_sound(SOUND_SHOUT, VOLUME_HIGH, TRUE, 3)
	RegisterSignal(holder, COMSIG_STARTED_CHARGE, /datum/action/cooldown/necro/proc/CooldownEnd)
	RegisterSignal(holder, COMSIG_MOB_STATCHANGE, .proc/OnStatChange)
	RegisterSignal(holder, COMSIG_LIVING_UPDATED_RESTING, .proc/OnUpdateResting)
	RegisterSignal(holder, COMSIG_MOVABLE_MOVED, .proc/OnMoved)
	holder.add_movespeed_modifier(/datum/movespeed_modifier/gallop)

/datum/action/cooldown/necro/active/gallop/proc/OnStatChange(mob/living/carbon/human/necromorph/leaper/source, new_stat, old_stat)
	SIGNAL_HANDLER
	if(new_stat > old_stat)
		CooldownEnd()

/datum/action/cooldown/necro/active/gallop/proc/OnUpdateResting(mob/living/carbon/human/necromorph/leaper/source, resting)
	SIGNAL_HANDLER
	if(resting)
		CooldownEnd()

/datum/action/cooldown/necro/active/gallop/proc/OnMoved(mob/living/carbon/human/necromorph/leaper/source)
	SIGNAL_HANDLER
	shake_camera(source, 3, 0.5)
	source.play_necro_sound(SOUND_FOOTSTEP, VOLUME_QUIET)

/datum/action/cooldown/necro/active/gallop/CooldownEnd()
	. = ..()
	if(.)
		UnregisterSignal(owner, list(COMSIG_STARTED_CHARGE, COMSIG_MOB_STATCHANGE, COMSIG_LIVING_UPDATED_RESTING, COMSIG_MOVABLE_MOVED))
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/gallop)

/datum/movespeed_modifier/gallop
	multiplicative_slowdown = 0.25
