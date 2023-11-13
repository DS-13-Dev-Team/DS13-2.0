/datum/action/cooldown/necro/explode
	name = "Explode"
	desc = "Makes you explode after a few seconds."
	cooldown_time = 12 SECONDS
	click_to_activate = FALSE

/datum/action/cooldown/necro/explode/Activate(atom/target)
	var/mob/living/carbon/human/necromorph/exploder/user = owner
	var/initial_transform = matrix(user.transform)
	var/initial_x = user.pixel_x
	var/initial_y = user.pixel_y
	var/shake_dir
	user.play_necro_sound(SOUND_SHOUT_LONG, VOLUME_HIGH, TRUE, 3)
	//Lots of shaking with increasing frequency and violence

	shake_dir = pick(-1, 1)
	animate(user, transform = turn(user.transform, 4*shake_dir), pixel_x = 5 * shake_dir, pixel_y = (5 * pick(-1, 1)) + 5*shake_dir, time=1)
	animate(transform = initial_transform, pixel_x = initial_x, pixel_y = initial_y, time=2, easing=ELASTIC_EASING)
	PLAY_SHAKING_ANIMATION(user, 7, 5, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 10, 6, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 12, 7, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 14, 8, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 16, 9, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 18, 10, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 20, 11, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 22, 12, shake_dir, initial_x, initial_y, initial_transform)
	PLAY_SHAKING_ANIMATION(user, 25, 14, shake_dir, initial_x, initial_y, initial_transform)

	addtimer(CALLBACK(src, PROC_REF(explode), user), 3 SECONDS)

/datum/action/cooldown/necro/explode/proc/explode(mob/living/carbon/human/necromorph/exploder/user, target)
	if(owner == user)
		new /obj/effect/temp_visual/scry(get_turf(user), user.marker.markernet)
		explosion(get_turf(user), 0, 0, 3, 2, 4, TRUE, FALSE, FALSE, FALSE, explosion_cause = src)
		explosion(get_turf(user), 0, 0, 2, 0, 0, FALSE, FALSE, FALSE, FALSE) //Second smaller explosion for more damage
		user.gib(TRUE, TRUE, TRUE)

