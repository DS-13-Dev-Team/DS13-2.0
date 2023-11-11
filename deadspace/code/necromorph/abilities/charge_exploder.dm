/datum/action/cooldown/necro/charge/exploder
	charge_delay = 1 SECONDS
	charge_time = 10 SECONDS
	charge_speed = 4

//Totally not ripped from exploder explode
/datum/action/cooldown/necro/charge/exploder/Activate(atom/target)
	var/mob/living/carbon/human/necromorph/exploder/user = owner
	var/initial_transform = matrix(user.transform)
	var/initial_x = user.pixel_x
	var/initial_y = user.pixel_y
	var/shake_dir
	user.play_necro_sound(SOUND_SHOUT, VOLUME_HIGH, TRUE, 3)
	//Lots of shaking with increasing frequency and violence

	shake_dir = pick(-1, 1)
	animate(user, transform = turn(user.transform, 4*shake_dir), pixel_x = 5 * pick(-1, 1), pixel_y = (5 * pick(-1, 1)) + 5*shake_dir, time=1)
	animate(transform = initial_transform, pixel_x = initial_x, pixel_y = initial_y, time=2, easing=ELASTIC_EASING)
	PLAY_SHAKING_ANIMATION(user, 7, 5, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 10, 6, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 12, 7, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 14, 8, shake_dir, initial_x, initial_y, initial_transform)
	. = ..()


/datum/action/cooldown/necro/charge/exploder/hit_target(mob/living/carbon/human/necromorph/source, mob/living/target)
	if(isliving(target))
		new /obj/effect/temp_visual/scry(get_turf(source), source.marker.markernet)
		SSmove_manager.stop_looping(source)
		explosion(get_turf(source), 0, 0, 3, 2, 4, TRUE, FALSE, FALSE, FALSE, explosion_cause = src)
		explosion(get_turf(source), 0, 0, 2, 0, 0, FALSE, FALSE, FALSE, FALSE) //Second smaller explosion for more damage
		source.gib(TRUE, TRUE, TRUE)
	else
		source.visible_message(span_danger("[source] smashes into [target]!"))
		shake_camera(source, 4, 3)
		source.Stun(20)
