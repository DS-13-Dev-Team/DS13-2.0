#define GALLOP_CRASH_LIMIT 2

/datum/action/cooldown/necro/active/gallop
	name = "Gallop"
	desc = "Gives a huge burst of speed, but makes you vulnerable."
	cooldown_time = 10 SECONDS
	duration_time = 6 SECONDS
	var/crash_count = 0

/datum/action/cooldown/necro/active/gallop/Activate(atom/target)
	var/mob/living/carbon/human/necromorph/holder = owner
	if(holder.stat > CONSCIOUS || holder.body_position != STANDING_UP || holder.charging)
		return
	..()
	crash_count = 0
	holder.play_necro_sound(SOUND_SHOUT, VOLUME_HIGH, TRUE, 3)
	RegisterSignal(holder, COMSIG_STARTED_CHARGE, /datum/action/cooldown/necro/proc/CooldownEnd)
	RegisterSignal(holder, COMSIG_MOB_STATCHANGE, .proc/OnStatChange)
	RegisterSignal(holder, COMSIG_LIVING_UPDATED_RESTING, .proc/OnUpdateResting)
	RegisterSignal(holder, COMSIG_MOB_APPLY_DAMAGE, .proc/OnHit)
	RegisterSignal(holder, COMSIG_MOVABLE_BUMP, .proc/OnBump)
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

/datum/action/cooldown/necro/active/gallop/proc/OnHit(mob/living/carbon/human/necromorph/leaper/source, damage, damagetype, def_zone)
	SIGNAL_HANDLER
	if (crash_count < GALLOP_CRASH_LIMIT)
		crash_count++
		return
	source.visible_message(span_danger("[source] crumples on impact!"), span_danger("You crumple on impact"))
	shake_camera(source, 20, 1)
	StopCrash()

/datum/action/cooldown/necro/active/gallop/proc/OnBump(mob/living/carbon/human/necromorph/leaper/source, atom/bumped)
	SIGNAL_HANDLER
	source.visible_message(span_danger("[source] crashes into [bumped]!"), span_danger("You crashed into [bumped]!"))
	StopCrash()

/datum/action/cooldown/necro/active/gallop/proc/OnMoved(mob/living/carbon/human/necromorph/leaper/source)
	SIGNAL_HANDLER
	shake_camera(source, 3, 0.5)
	source.play_necro_sound(SOUND_FOOTSTEP, VOLUME_QUIET)

/datum/action/cooldown/necro/active/gallop/proc/StopCrash()
	var/mob/living/carbon/human/necromorph/holder = owner
	shake_camera(holder, 20, 1)
	holder.Knockdown(10)
	holder.take_overall_damage(5)
	//Stops the gallop
	CooldownEnd()

/datum/action/cooldown/necro/active/gallop/CooldownEnd()
	. = ..()
	if(.)
		UnregisterSignal(owner, list(
			COMSIG_STARTED_CHARGE,
			COMSIG_MOB_STATCHANGE,
			COMSIG_LIVING_UPDATED_RESTING,
			COMSIG_MOB_APPLY_DAMAGE,
			COMSIG_MOVABLE_BUMP,
			COMSIG_MOVABLE_MOVED,
		))
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/gallop)

/datum/movespeed_modifier/gallop
	multiplicative_slowdown = 0.25

#undef GALLOP_CRASH_LIMIT
