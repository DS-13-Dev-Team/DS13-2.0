/datum/action/cooldown/necro/charge/leaper
	name = "Leap"
	desc = "Allows you to leap at a chosen position."
	cooldown_time = 6 SECONDS
	charge_delay = 1.2 SECONDS
	charge_time = 8 SECONDS
	charge_speed = 2
	charge_damage = 30
	var/cached_pass_flags

/datum/action/cooldown/necro/charge/leaper/do_charge_indicator(atom/charge_target)
	var/mob/living/carbon/human/necromorph/source = owner
	cached_pass_flags = source.pass_flags

	var/real_dist = max(1, get_dist_euclidian(source, charge_target))
	animate(source, pixel_x = ((charge_target.x - source.x)/real_dist), pixel_y = ((charge_target.y - source.y)/real_dist), time = 1.5 SECONDS, easing = BACK_EASING, flags = ANIMATION_PARALLEL|ANIMATION_RELATIVE)
	animate(pixel_x = source.base_pixel_x, pixel_y = source.base_pixel_y, time = 0.3 SECONDS)
	if(ismob(charge_target))
		source.play_necro_sound(SOUND_SHOUT_LONG, VOLUME_MAX, TRUE, 3)
	else
		source.play_necro_sound(SOUND_SHOUT, VOLUME_MAX, TRUE, 3)

	//The sprite moves up into the air and a bit closer to the camera
	animate(source, transform = source.transform.Scale(1.18), pixel_y = source.pixel_y + 24, time = charge_time, flags = ANIMATION_PARALLEL)
	source.pass_flags |= PASSTABLE

/datum/action/cooldown/necro/charge/leaper/charge_end(datum/move_loop/source)
	var/matrix/new_matrix = matrix(owner.transform)
	//Scale it back to normal
	new_matrix.a = 1
	new_matrix.e = 1
	animate(owner, transform = new_matrix, pixel_y = owner.pixel_y - 24, time = 0.5 SECONDS)
	owner.pass_flags = cached_pass_flags
	cached_pass_flags = null
	return ..()

/datum/action/cooldown/necro/charge/leaper/on_bump(mob/living/source, atom/target)
	SSmove_manager.stop_looping(source)
	if(GLOB.wallrun_types_typecache[target.type])
		SEND_SIGNAL(source, COMSIG_LEAPER_MOUNT, target)
	else if(ismob(target) || target.uses_integrity)
		hit_target(source, target)
