//Still need some tweaks. Kinda useless in it's current state
/datum/action/cooldown/necro/dodge
	name = "Dodge"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"
	desc = "Allows you to dodge bullets."
	cooldown_time = 6 SECONDS
	click_to_activate = FALSE

/datum/action/cooldown/necro/dodge/Activate(atom/target)
	if(!isturf(owner.loc))
		to_chat(owner, span_notice("You need more space to dodge."))
		return
	//To ensure people won't spam
	StartCooldown(1 SECONDS)
	var/mob/living/carbon/necromorph/holder = owner

	var/list/potential_turfs = RANGE_TURFS(1, holder)
	potential_turfs -= get_turf(holder)
	potential_turfs -= get_step(holder, holder.dir)
	potential_turfs -= get_step(holder, REVERSE_DIR(holder.dir))

	holder.set_dir_on_move = FALSE
	while(potential_turfs.len)
		var/turf/moving_towards = pick(potential_turfs)
		var/atom/old_loc = holder.loc
		holder.Move(moving_towards, get_dir(holder, moving_towards))
		if(old_loc != holder?.loc)  //If it worked, we're done
			. = TRUE
			break
		potential_turfs -= moving_towards
	holder.set_dir_on_move = initial(holder.set_dir_on_move)

	if(.)
		StartCooldown()
		holder.visible_message(span_danger("[holder] nimbly dodges to the side!"))
		//Randomly selected sound
		var/sound_type = pick_weight(list(SOUND_SPEECH = 6, SOUND_ATTACK = 2, SOUND_PAIN = 1.5, SOUND_SHOUT = 1))
		holder.play_necro_sound(sound_type, VOLUME_QUIET)
	else
		to_chat(owner, span_notice("You need more space to dodge."))
