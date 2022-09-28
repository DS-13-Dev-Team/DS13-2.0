/datum/hud/marker
	var/atom/movable/screen/meter/background/background
	var/atom/movable/screen/meter/health/psy_energy
	var/atom/movable/screen/meter/foreground/foreground

/datum/hud/marker/New(mob/camera/marker_signal/owner)
	background = new
	psy_energy = new
	foreground = new
	psy_energy.color = COLOR_PURPLE
	psy_energy.add_filter("alpha_filter", 1, alpha_mask_filter(clamp(PSYBAR_PIXEL_WIDTH*(owner.psy_energy/owner.psy_energy_maximum), 0, owner.psy_energy_maximum), 0, icon('necromorphs/icons/hud/healthbar.dmi', "alpha_mask"), flags = MASK_INVERSE))
	foreground.maptext_x = 53
	var/psy_string = max(0, owner.psy_energy)
	if(round(psy_string, 1) == psy_string)
		psy_string = "[psy_string].0"
	foreground.maptext = MAPTEXT("[psy_string]/[owner.psy_energy_maximum] | +[owner.psy_energy_generation] psy/sec")
	..()

/datum/hud/marker/show_hud(version, mob/viewmob)
	if(!..())
		return FALSE
	var/mob/screenmob = viewmob || mymob

	screenmob.client.screen += background
	screenmob.client.screen += psy_energy
	screenmob.client.screen += foreground
