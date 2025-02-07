/datum/action/cooldown/necro/psy/psychic_tracer
	name = "Psychic Tracer"
	desc = "Plants a psychic tracer on a target mob, causing them to act as a visual relay for necrovision."
	button_icon_state = "tracer"
	cost = 110

/datum/action/cooldown/necro/psy/psychic_tracer/PreActivate(mob/living/target)
	if(!istype(target))
		return FALSE
	if(istype(target, /mob/living/carbon/human/necromorph))
		to_chat(owner, span_notice("You can't plant a psychic tracer onto a necromorph!"))
		return FALSE
	return ..()

/datum/action/cooldown/necro/psy/psychic_tracer/Activate(mob/living/target)
	var/mob/camera/marker_signal/called = owner
	..()
	var/datum/markernet/visualnet = called.marker.markernet
	visualnet.addVisionSource(target, VISION_SOURCE_VIEW, TRUE)
	addtimer(CALLBACK(visualnet, /datum/markernet/proc/removeVisionSource, target), 5 MINUTES, TIMER_UNIQUE|TIMER_OVERRIDE)
	return TRUE
