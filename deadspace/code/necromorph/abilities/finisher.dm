/* This is a finisher, it's supposed to be used against vulnurable survivors that are incapable of resisting the onslaught of necromorphs*/

/datum/action/cooldown/necro/finisher
	name = "finisher"
	desc = "Allows you to deal extraordinary amounts of damage to weakened humans, guarantees death of its victims upon completion."
	cooldown_time = 2 SECONDS
	click_to_activate = TRUE
	/// Delay before the finisher actually occurs
	var/finisher_delay = 1 SECOND
	/// The time when we started finishing the target for a finisher
	var/finisher_start
	/// The maximum amount of time we're finishing the target for a finisher
	var/finisher_end
	/// Every second the target hasn't broken out of the finisher grapple, this amount of damage is dealt to the cranium
	var/finisher_damage = 30
	/// If the victim breaks out of the finisher clutches
	var/finisher_stagger = 3 SECONDS
	/// If the current move is being triggered by us or not
	var/actively_moving = FALSE
	var/valid_steps_taken = 0
	var/speed_per_step = 0.50
	var/max_steps_buildup = 2
	var/atom/target_atom

	var/exegrab_anim = 0.5 SECOND 		//How long the animation to initiate an execution grapple
	var/started_at	=	0				//When did we start the execution grapple
	var/stopped_at	=	0				//When did we stop execution grapple
	var/cached_pixels_x
	var/cached_pixels_y
	var/matrix/cached_transform
	var/force_cooldown_timer
	var/force_notify_timer

	var/exe_animtime = 1 SECOND //How long the animation to execute actually takes

/datum/action/cooldown/necro/finisher/PreActivate(atom/target)
var/turf/T = get_turf(target)
	if(!T)
		to_chat(owner, span_notice("You must target a human to execute them!"))
		return FALSE
	if(!ishuman(target))
		for(var/mob/living/carbon/human/hummie in view(1, T))
			if(!isnecromorph(hummie))
				target = hummie
				break
	if(target == owner || isnecromorph(target))
		to_chat(owner, span_notice("You can't peform an execution on a necromorph!"))
		return FALSE

	target_atom = target

	if(isturf(target))
		RegisterSignal(target, COMSIG_ATOM_ENTERED, PROC_REF(on_target_loc_entered))
		else
			var/static/list/loc_connections = list(
				COMSIG_ATOM_ENTERED = PROC_REF(on_target_loc_entered),
		)
		AddComponent(/datum/component/connect_loc_behalf, target, loc_connections)

	return ..()

/datum/action/cooldown/necro/finisher/Activate(atom/target)
	. = TRUE
	// Start pre-cooldown so that the ability can't come up while the finisher is happening
	StartCooldown(finisher_time+finisher_delay+1)
	addtimer(CALLBACK(src, PROC_REF(do_finisher)), finisher_delay)

/datum/action/cooldown/necro/finisher/proc/do_finisher()
	var/mob/living/carbon/human/necromorph/finisher = owner

	actively_moving = FALSE
	finisher.moving = TRUE
	RegisterSignal(finisher, COMSIG_MOVABLE_BUMP, PROC_REF(on_bump))
	RegisterSignal(finisher, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_move))
	RegisterSignal(finisher, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
	finisher.setDir(get_dir(finisher, target_atom))
	do_finisher_indicator(target_atom)

	var/datum/finisher/finishing = SSmove_manager.move_towards(finisher, target_atom, priority = MOVEMENT_ABOVE_SPACE_PRIORITY)
	if(!new_loop)
		UnregisterSignal(finisher, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOVABLE_MOVED))
		return
	RegisterSignal(new_loop, COMSIG_MOVELOOP_PREPROCESS_CHECK, PROC_REF(pre_move))
	RegisterSignal(new_loop, COMSIG_MOVELOOP_POSTPROCESS, PROC_REF(post_move))
	RegisterSignal(new_loop, COMSIG_MOVELOOP_STOP, PROC_REF(move_end))
	RegisterSignal(finisher, COMSIG_MOB_STATCHANGE, PROC_REF(stat_changed))
	RegisterSignal(finisher, COMSIG_LIVING_UPDATED_RESTING, PROC_REF(update_resting))

	SEND_SIGNAL(finisher, COMSIG_STARTED_FINISH)

/datum/action/cooldown/necro/finisher/proc/on_target_loc_entered(atom/loc, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER
	if(arrived != owner)
		return
	on_bump(owner, target_atom)

/datum/action/cooldown/necro/finisher/proc/pre_move(datum)
	SIGNAL_HANDLER
	actively_moving = TRUE

/datum/action/cooldown/necro/finisher/proc/post_move(datum)
	SIGNAL_HANDLER
	actively_moving = FALSE

/datum/action/cooldown/necro/finisher/proc/move_end(datum/move_loop/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/necromorph/finisher = source.moving
	UnregisterSignal(finisher, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOVABLE_MOVED, COMSIG_MOB_STATCHANGE, COMSIG_LIVING_UPDATED_RESTING))
	finisher.moving = FALSE
	finisher.remove_movespeed_modifier(/datum/movespeed_modifier/necro_finisher)
	StartCooldown()
	SEND_SIGNAL(owner, COMSIG_FINISHED_FINISH)

	qdel(GetComponent(/datum/component/connect_loc_behalf))
	target_atom = null

/datum/action/cooldown/necro/finisher/proc/stat_changed(mob/source, new_stat, old_stat)
	SIGNAL_HANDLER
	if(new_stat > CONSCIOUS)
		SSmove_manager.stop_looping(owner)

/datum/action/cooldown/necro/finisher/proc/do_finish_indicator(atom/finisher_target)
	return

/datum/action/cooldown/necro/finisher/proc/on_move(atom/source, atom/new_loc)
	SIGNAL_HANDLER
	if(!actively_moving)
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/action/cooldown/necro/finisher/proc/on_moved(atom/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/necromorph/finisher = source
	if(++valid_steps_taken <= max_steps_buildup)
		finisher.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/necro_finisher, TRUE, -FINISH_SPEED(src))

	//Light shake with each step
	shake_camera(source, 1.5, 0.5)

	return

/datum/action/cooldown/necro/finisher/proc/on_bump(atom/movable/source, atom/target)
	SIGNAL_HANDLER
	if(ismob(target) || target.uses_integrity)
		hit_target(source, target)
	SSmove_manager.stop_looping(owner)

/datum/action/cooldown/necro/finisher/proc/hit_target(mob/living/carbon/human/necromorph/source, mob/living/target)
	target.attack_necromorph(source, dealt_damage = finisher_damage)
	if(isliving(target))
		if(ishuman(target))
			var/mob/living/carbon/human/human_target = target
			if(human_target.check_shields(source, 0, "the [source.name]", attack_type = LEAP_ATTACK))
				source.Stun(6)
				shake_camera(source, 4, 3)
				shake_camera(target, 2, 1)
				return
		shake_camera(target, 4, 3)
		shake_camera(source, 2, 3)
		target.visible_message("<span class='danger'>[source] clasps [target] in its grasp! Teeth digging into the neck!</span>", "<span class='userdanger'>[source] clasps you in its arms!</br>You feel a sharp pain coming from your neck!</span>")

		finister_start = world.time
		finisher_end = world.time + 4

		if(finisher_start >= finisher_end)



	else
		source.visible_message(span_danger("[source] smashes into [target]!"))
		shake_camera(source, 4, 3)
		source.Stun(6)




/datum/action/cooldown/necro/finisher/proc/finishing()

	.=..()
	if (.)
		//We must face sideways to perform this move.
		if (source.x > source.x)
			source.facedir(EAST)
		else
			source.facedir(WEST)

/datum/action/cooldown/necro/finisher/proc/update_resting(atom/movable/source, resting)
	SIGNAL_HANDLER
	if(resting)
		SSmove_manager.stop_looping(source)

/*<-------------------------------------------------------------------------------------------------------------------->


E X A M P L E O F F I N I S H E R


<-------------------------------------------------------------------------------------------------------------------->

/*--------------------------------
	The Kiss of Death
--------------------------------*/


/*
	The tripod's execution move.
		-Pins the target down with an impaling claw
		-Screams
		-Forces its huge tongue down the victim's throat (muting them at this point)
		-Pulls the tongue out rapidly, tearing the victim's head off (finisher stage)
		-Tear the victim in half at the waist (post finisher)

	Requires the target to be lying down in order to start
	Requires us to have the tongue and at least one arm intact
*/
/mob/living/carbon/human/proc/tripod_kiss(var/mob/living/carbon/human/target)
	set name = "Finisher"
	set desc = "A finisher against the weakened"
	set category = "Abilities"

	if (!istype(target) || target.stat == DEAD || !target.lying)
		target = null
		var/list/possible_targets = get_valid_target(origin = src,
		radius = 1,
		valid_types = list(/mob/living/carbon/human),
		allied = list(src, FALSE),
		visualnet = null,
		require_corruption = FALSE,
		view_limit = TRUE,
		LOS_block = FALSE,
		num_required = 0,
		special_check = null)

		for (var/mob/living/carbon/human/H in possible_targets)
			if (H.stat == DEAD && H.lying)
				target = H
				break

		if (!target)
			return

	if (target.is_necromorph())
		return

	perform_execution(/datum/extension/execution/tripod_kiss, target)






/datum/extension/execution/tripod_kiss
	name = "Kiss of Death"
	base_type = /datum/extension/execution/tripod_kiss
	cooldown = 1 MINUTE

	reward_biomass = 50
	reward_energy = 150
	reward_heal = 40

	all_stages = list(/datum/execution_stage/tripod_claw_pin,
	/datum/execution_stage/tripod_scream,
	/datum/execution_stage/tripod_tongue_force,
	/datum/execution_stage/finisher/tripod_tongue_pull,
	/datum/execution_stage/tripod_bisect)


	statmods = 	list(STATMOD_EVASION = -100, STATMOD_VIEW_RANGE = -6, STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE	=	EXECUTION_DAMAGE_VULNERABILITY)


/datum/extension/execution/tripod_kiss/interrupt()
	.=..()
	user.play_species_audio(src, SOUND_PAIN, VOLUME_MID, 1, 2)

/datum/extension/execution/tripod_kiss/can_start()
	//Lets check that we have what we need

	//The victim must be lying on the floor
	if (!victim.lying)
		return FALSE

	//We need our tongue still attached
	var/obj/item/organ/external/tongue = user.get_organ(BP_HEAD)
	if (!LAZYLIMB(tongue))
		return FALSE

	//We require at least one arm intact
	var/obj/item/organ/external/arm/left = user.get_organ(BP_L_ARM)
	var/obj/item/organ/external/arm/right = user.get_organ(BP_R_ARM)
	if (!LAZYLIMB(left) && !LAZYLIMB(right))
		return FALSE

	.=..()

/datum/extension/execution/tripod_kiss/acquire_target()

	.=..()
	if (.)
		//We must face sideways to perform this move.
		if (victim.x > user.x)
			user.facedir(EAST)
		else
			user.facedir(WEST)

		//We extend our tongue indefinitely
		var/obj/item/organ/external/arm/tentacle/tripod_tongue/E = user.get_organ(BP_HEAD)
		if (!istype(E) || E.is_stump())
			return
		E.extend()


/datum/extension/execution/tripod_kiss/stop()
	.=..()
	//Once we're done, we'll retract the tongue after some time
	var/obj/item/organ/external/arm/tentacle/tripod_tongue/E = user.get_organ(BP_HEAD)
	if (!istype(E) || E.is_stump())
		return
	//We call extend_for even though its already extended, this will set a timer to retract it
	E.extend_for(TONGUE_EXTEND_TIME)





//Claw pin: Deals some heavy damage and stuns the victim
//----------------------------------------------------
/datum/execution_stage/tripod_claw_pin
	duration = 3 SECOND

//Rises up into the air then comes down upon the victim fast
/datum/execution_stage/tripod_claw_pin/enter()
	.=..()
	animate(host.user, pixel_y = host.user.pixel_y + 16, time = duration * 0.7)
	animate(pixel_y = host.user.pixel_y - 18, time = duration * 0.3, easing = BACK_EASING)
	spawn(duration*0.9)

		//After a delay we must redo safety checks
		if (host.safety_check() == EXECUTION_CONTINUE)
			//Okay lets hit 'em
			host.victim.apply_damage(25, BRUTE, BP_GROIN, 0, DAM_SHARP, host.user)
			host.victim.Stun(8)
			host.victim.Weaken(8)	//Lets make sure they stay down
			host.user.visible_message(SPAN_EXECUTION("[host.user] impales [host.victim] through the groin with a vast claw, pinning them to the floor!"))
			playsound(host.victim, 'sound/weapons/slice.ogg', VOLUME_MID, 1)


/datum/execution_stage/tripod_claw_pin/interrupt()

	host.victim.stunned = 0
	host.victim.weakened = 0





//Scream: Just calls shout_long, no stun to self
//----------------------------------------------------
/datum/execution_stage/tripod_scream
	duration = 2 SECOND

/datum/execution_stage/tripod_scream/enter()
	.=..()
	host.user.do_shout(SOUND_SHOUT_LONG, FALSE)





//Tongue Force: Slowly forces the tongue into the victim's mouth
//Animation makes the user go down and tilt forward
//----------------------------------------------------
/datum/execution_stage/tripod_tongue_force
	duration = 5 SECOND

/datum/execution_stage/tripod_tongue_force/enter()
	.=..()
	//We will gradually tilt forward
	var/angle = 30
	if (host.user.dir & WEST)
		angle *= -1
	animate(host.user, pixel_y = host.user.pixel_y - 16, transform = turn(host.user.get_default_transform(), angle), time = duration)

	//You can't speak with a massive sword-like tongue down your throat
	host.victim.silent += 10

	host.user.visible_message(SPAN_EXECUTION("[host.user] starts forcing its tongue down [host.victim]'s throat!"))
	spawn(8)
		var/tonguesound = pick(list('sound/effects/creatures/necromorph/tripod/tripod_tongueforce_1.ogg',
		'sound/effects/creatures/necromorph/tripod/tripod_tongueforce_2.ogg',
		'sound/effects/creatures/necromorph/tripod/tripod_tongueforce_3.ogg'))
		playsound(host.victim, tonguesound, VOLUME_LOUD, TRUE)


/datum/execution_stage/tripod_tongue_force/interrupt()

	host.victim.silent =0

// https://bigmemes.funnyjunk.com/pictures/Long+boi_073bf6_7722185.jpg


//Tongue Pull: Rips the tongue out sharply, victim's head is torn off
//Animation makes the user go down and tilt forward
//----------------------------------------------------
/datum/execution_stage/finisher/tripod_tongue_pull
	duration = 2 SECOND

/datum/execution_stage/finisher/tripod_tongue_pull/enter()
	.=..()
	var/angle = -55
	if (host.user.dir & WEST)
		angle *= -1

	//Swing back and up like a shampoo advert
	animate(host.user, pixel_y = host.user.pixel_y + 12, transform = turn(host.user.get_default_transform(), angle*0.3), time = 6, easing = BACK_EASING)
	animate(pixel_y = host.user.pixel_y + 12, transform = turn(host.user.get_default_transform(), angle*0.6), time = 6,)

	spawn(4)
		var/obj/item/organ/external/head = host.victim.get_organ(BP_HEAD)
		if (istype(head))
			head.droplimb(cutter = host.user)
			host.user.visible_message(SPAN_EXECUTION("[host.user] whips back, violently tearing [host.victim]'s head off!"))

			var/sound_effect = pick(list('sound/effects/organic/flesh_tear_1.ogg',
			'sound/effects/organic/flesh_tear_2.ogg',
			'sound/effects/organic/flesh_tear_3.ogg',))
			playsound(host.victim, sound_effect, VOLUME_MID, TRUE)



	.=..()




//Tongue Pull: Rips the tongue out sharply, victim's head is torn off
//Animation makes the user go down and tilt forward
//----------------------------------------------------
/datum/execution_stage/tripod_bisect
	duration = 5 SECOND

/datum/execution_stage/tripod_bisect/enter()
	.=..()
	var/x_offset = -48
	var/angle = 30
	if (host.user.dir & WEST)
		angle *= -1
		x_offset *= -1

	var/slamtime = 8
	//Slam down one last time
	animate(host.user, pixel_y = host.user.default_pixel_y - 8, transform = turn(host.user.get_default_transform(), angle*-0.2), time = slamtime, easing = BACK_EASING)
	animate(host.user, pixel_y = host.user.default_pixel_y - 8, transform = turn(host.user.get_default_transform(), angle*1.2), time = slamtime)

	//Pause briefly
	animate(time = 6)
	//And then pull back to tear off the lower body
	animate(pixel_x = host.user.pixel_x + x_offset, time = 10, easing = CIRCULAR_EASING)

	spawn(slamtime+6)
		if (host.safety_check() == EXECUTION_CONTINUE)
			var/obj/item/organ/external/groin = host.victim.get_organ(BP_GROIN)
			if (istype(groin))
				groin.droplimb(cutter = host.user)
				host.user.visible_message(SPAN_EXECUTION("[host.user] drags its massive claw backwards, brutally tearing [host.victim] in half!"))
				var/sound_effect = pick(list('sound/effects/organic/flesh_tear_1.ogg',
				'sound/effects/organic/flesh_tear_2.ogg',
				'sound/effects/organic/flesh_tear_3.ogg',))
				playsound(host.victim, sound_effect, VOLUME_HIGH, TRUE)

/datum/species/necromorph/tripod/make_scary(mob/living/carbon/human/H)
	//H.set_traumatic_sight(TRUE, 5) //All necrmorphs are scary. Some are more scary than others though
*/
