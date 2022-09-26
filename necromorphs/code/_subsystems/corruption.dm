#define SS_GROWING		1
#define SS_DECAYING		2
#define SS_SPREADING	3
SUBSYSTEM_DEF(corruption)
	name = "Corruption"
	init_order = INIT_ORDER_CORRUPTION
	priority = FIRE_PRIORITY_CORRUPTION
	wait = 1 SECONDS
	flags = SS_NO_INIT
	/// A list of corruption that is still growing and not ready to spread
	var/list/growing = list()
	/// A list of decaying corruption
	var/list/decaying = list()
	/// A list of nodes that can spread
	var/list/spreading = list()

	var/list/currentrun
	var/curernt_part = SS_GROWING

/datum/controller/subsystem/corruption/stat_entry(msg)
	msg = "|G:[length(growing)]|D:[length(decaying)]|S:[length(spreading)]"
	return ..()

/datum/controller/subsystem/corruption/fire(resumed)
	var/list/currentrun = src.currentrun
	if(curernt_part == SS_GROWING || !resumed)
		if(!resumed)
			currentrun = growing.Copy()
		while(length(currentrun))
			var/obj/structure/corruption/corruption = currentrun[length(currentrun)]
			corruption.repair_damage(3)
			currentrun.len--
			if(MC_TICK_CHECK)
				return
		curernt_part = SS_DECAYING

	if(curernt_part == SS_DECAYING)
		if(!resumed)
			currentrun = decaying.Copy()
		while(length(currentrun))
			var/obj/structure/corruption/corruption = currentrun[length(currentrun)]
			corruption.take_damage(3)
			currentrun.len--
			if(MC_TICK_CHECK)
				return
		curernt_part = SS_SPREADING

	if(curernt_part == SS_SPREADING)
		if(!resumed)
			currentrun = spreading.Copy()
		while(length(currentrun))
			var/datum/corruption_node/corruption = currentrun[length(currentrun)]
			corruption.spread()
			currentrun.len--
			if(MC_TICK_CHECK)
				return

	curernt_part = SS_GROWING

/datum/controller/subsystem/corruption/Recover()
	growing = SScorruption.growing
	spreading = SScorruption.spreading
	decaying = SScorruption.decaying
	currentrun = SScorruption.currentrun
	curernt_part = SScorruption.curernt_part

#undef SS_GROWING
#undef SS_DECAYING
#undef SS_SPREADING
