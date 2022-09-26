/datum/action/cooldown/necro/psy/psychic_tracer
	name = "Psychic Tracer"
	desc = "Plants a psychic tracer on a target mob, causing them to act as a visual relay for necrovision."
	cost = 110

/datum/action/cooldown/necro/psy/psychic_tracer/PreActivate(mob/living/target, mob/camera/marker_signal/caller)
	if(!istype(target))
		return FALSE
	if(istype(target, /mob/living/carbon/necromorph))
		to_chat(caller, span_notice("You can't plant a psychic tracer onto a necromorph!"))
		return FALSE
	return ..()

/datum/action/cooldown/necro/psy/psychic_tracer/Activate(mob/living/target, mob/camera/marker_signal/caller)
	..()
	var/datum/markernet/visualnet = caller.marker.markernet
	visualnet.addVisionSource(target, VISION_SOURCE_VIEW, TRUE)
	addtimer(CALLBACK(visualnet, /datum/markernet/proc/removeVisionSource, target), 5 MINUTES, TIMER_UNIQUE|TIMER_OVERRIDE)
	return TRUE
