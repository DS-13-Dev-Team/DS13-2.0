/datum/action/cooldown/necro/explode
	name = "Explode"
	desc = "Makes you explode after a few seconds."
	cooldown_time = 12 SECONDS
	click_to_activate = FALSE

///If the exploder doesn't have the pustule they can't explode.
///This is nested into normal combat abilities so we don't have to define this proc in every single exploder variant ability
/datum/action/cooldown/necro/proc/can_explode(/mob/living/carbon/human/necromorph/exploder/user)
	var/mob/living/carbon/human/necromorph/exploder/user = owner
	.=FALSE
	var/obj/item/bodypart/arm/left/PU = user.get_bodypart(BODY_ZONE_L_ARM)
	if(!PU || PU.is_stump)
		return

	return TRUE

/datum/action/cooldown/necro/explode/Activate(atom/target)
	var/mob/living/carbon/human/necromorph/exploder/user = owner
	if(!can_explode())
		to_chat(user, span_warning("You have no pustule, you cannot explode!"))
		return
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

///Make sure to not use heavy or devastation explosive range, or you'll break floor tiles
/datum/action/cooldown/necro/explode/proc/explode(mob/living/carbon/human/necromorph/exploder/user)
	if(!can_explode()) //Done twice for sanity's sake
		to_chat(user, span_warning("You have no pustule, you cannot explode!"))
		return
	if(owner == user)
		new /obj/effect/temp_visual/scry(get_turf(user), user.marker.markernet)
		explosion(get_turf(user), 0, 0, 3, 2, 4, TRUE, FALSE, FALSE, FALSE, explosion_cause = src)
		explosion(get_turf(user), 0, 0, 2, 0, 0, FALSE, FALSE, FALSE, FALSE) //Second smaller explosion for more damage
		user.gib(TRUE, TRUE, TRUE)

