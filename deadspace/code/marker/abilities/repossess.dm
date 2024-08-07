/datum/action/cooldown/necro/psy/repossess
	name = "Repossess"
	desc = "Ejects a signal from a necromorph."
	button_icon_state = "default" //TODO : Add a repossess sprite
	cost = 1
	cooldown_time = 5 SECONDS
	marker_flags = SIGNAL_ABILITY_PRE_ACTIVATION|SIGNAL_ABILITY_POST_ACTIVATION|SIGNAL_ABILITY_MARKER_ONLY

/datum/action/cooldown/necro/psy/repossess/PreActivate(mob/living/target)
	if(!isnecromorph(target)) //Don't try to repossess non-necros, ya silly.
		to_chat(owner, span_notice("[target] is not a necromorph!"))
		return FALSE
	if(isnecromorph(target) && !target.ckey)
		to_chat(owner, span_notice("[target] has no controlling signal!"))
		return FALSE
	return ..()

/datum/action/cooldown/necro/psy/repossess/Activate(mob/living/target)
	var/mob/living/carbon/human/necromorph/ammo = target //Yeet the child
	..()
	to_chat(ammo, span_notice("[owner] has forcibly evacuated you."))
	ammo.evacuate()
