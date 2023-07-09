/*
	Brute curl up.
	Not really an attack.
		It can be triggered manually at any time
		It is also triggered automatically, with a longer force time, when
	While curled up, the brute has 75% more front and side armor, and that armor no longer exposes weak spots in the front.
	However, the brute can't move or turn while curled, vision range is reduced,  and its back is still as exposed as ever
*/


//Status flags for the curl extension
#define CURLING	1	//We are currently in the animation to enter/leave curled state
#define CURLED	2	//We are currently curled up
#define FORCE_COOLDOWN	3	//We are not currently curled up, but We were recently forced into a curl and can't be forced again for a while
								//However, we can still curl up willingly
/*
	Extension
*/
/datum/action/cooldown/necro/curl
	name = "Curl"

	cooldown_time = 1.5 MINUTE		//After an automatic curl, how long before we can be forced to do it again?
	var/status = 0
	var/force_time	=	0				//How long are we forced to stay curled up? There should always be a minimum on this to prevent spam. It shouldn't be
	var/automatic = FALSE				//Did we curl up manually or automatically
	var/animtime = 1 SECOND //How long the animation to curl/uncurl actually takes

	//Extra runtime vars
	var/started_at	=	0				//When did we curl up
	var/stopped_at	=	0				//When did we uncurl
	var/cached_pixels_x
	var/cached_pixels_y
	var/matrix/cached_transform
	var/force_cooldown_timer
	var/force_notify_timer

/datum/action/cooldown/necro/curl/Activate(atom/target)
	//First of all, uncurling
	if (can_uncurl())
		finish()
		return TRUE

	//If we're not already curled, we're doing a curl
	if (!can_curl())
		return TRUE

	started_at = world.time
	if (status != CURLED && status != CURLING)
		curl()
	return TRUE

/datum/action/cooldown/necro/curl/proc/curl()
	var/mob/living/carbon/human/necromorph/N = owner
	status = CURLING
	//The owner is stunned until they uncurl
	ADD_TRAIT(N, TRAIT_INCAPACITATED, src)
	ADD_TRAIT(N, TRAIT_IMMOBILIZED, src)
	ADD_TRAIT(N, TRAIT_HANDS_BLOCKED, src)
	var/offset_dir_x
	var/offset_dir_y
	switch(REVERSE_DIR(N.dir))
		if(NORTH)
			offset_dir_x = 0
			offset_dir_y = 1
		if(SOUTH)
			offset_dir_x = 0
			offset_dir_y = -1
		if(EAST)
			offset_dir_x = 1
			offset_dir_y = 0
		if(WEST)
			offset_dir_x = -1
			offset_dir_y = 0
		if(NORTHEAST)
			offset_dir_x = sqrt(1/2)
			offset_dir_y = sqrt(1/2)
		if(SOUTHEAST)
			offset_dir_x = -sqrt(1/2)
			offset_dir_y = sqrt(1/2)
		if(NORTHWEST)
			offset_dir_x = sqrt(1/2)
			offset_dir_y = -sqrt(1/2)
		if(SOUTHWEST)
			offset_dir_x = -sqrt(1/2)
			offset_dir_y = -sqrt(1/2)

	var/rotation = 35 * offset_dir_x * -1
	offset_dir_x *= 8 //Sprite will slide back a bit
	offset_dir_y *= 8

	N.play_necro_sound(N, SOUND_PAIN, 60, 1)

	//Lets cache some data too
	cached_pixels_x = N.pixel_x
	cached_pixels_y = N.pixel_y
	cached_transform = N.transform
	var/matrix/M = matrix()
	M.Scale(0.9)
	M.Turn(rotation)

	//AAAnd do the animation
	animate(N, transform = M, pixel_x = N.pixel_x + offset_dir_x, pixel_y = N.pixel_y + offset_dir_y, time = animtime)

	N.visible_message("[N] curls up, protecting their front")

	//If the brute was forced into this curl, setup a timer to tell them when they can leave it
	if (automatic)
		force_notify_timer = addtimer(CALLBACK(src, PROC_REF(notify_forced)), force_time)



	//Set the status after the animation finishes
	addtimer(CALLBACK(src, PROC_REF(play_sound)), animtime)

/datum/action/cooldown/necro/curl/proc/play_sound()
	var/mob/living/carbon/human/necromorph/N = owner
	status = CURLED
	//Some extra little impact sounds for the brute's arms hitting the ground as it curls up
	N.play_necro_sound(SOUND_FOOTSTEP, 40, 1)

	addtimer(CALLBACK(N, TYPE_PROC_REF(/mob/living/carbon/human/necromorph, play_necro_sound), SOUND_FOOTSTEP, 40, 1), 6) //One then the other


//In the finish proc, we uncurl. Lets assume safety checks are already done and we're clear to proceed
/datum/action/cooldown/necro/curl/proc/finish()
	uncurl()
	//If this was a forced curl, we'll start a cooldown timer
	if (automatic)
		StartCooldown()



/datum/action/cooldown/necro/curl/proc/uncurl()
	var/mob/living/carbon/human/necromorph/N = owner
	status = CURLING //We're in an animation, so set this again
	var/matrix/M = matrix()
	M.Scale(1)
	M.Turn(0)
	animate(N, transform = M, pixel_x = cached_pixels_x, pixel_y = cached_pixels_y, time = animtime)
	addtimer(CALLBACK(src, PROC_REF(uncurl_end)), animtime)

	cached_pixels_x = null
	cached_pixels_y = null

/datum/action/cooldown/necro/curl/proc/uncurl_end()
	REMOVE_TRAIT(owner, TRAIT_INCAPACITATED, src)
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, src)
	REMOVE_TRAIT(owner, TRAIT_HANDS_BLOCKED, src)
	status = FORCE_COOLDOWN

/datum/action/cooldown/necro/curl/proc/notify_forced()
	uncurl()

//Assuming we're standing up, are we able to curl?
/datum/action/cooldown/necro/curl/proc/can_curl(automatic = FALSE)
	if (status == CURLING || status == CURLED)
		return FALSE
	if (automatic && status == FORCE_COOLDOWN)
		return FALSE
	if (owner.incapacitated())
		return FALSE

	return TRUE


/datum/action/cooldown/necro/curl/proc/can_uncurl()
	if (status == CURLED)
		if ((started_at + force_time) < world.time)
			return TRUE

	return FALSE
