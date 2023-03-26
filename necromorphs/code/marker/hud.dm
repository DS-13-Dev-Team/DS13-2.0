/datum/hud/marker
	var/atom/movable/screen/meter/background/background
	var/atom/movable/screen/meter/health/psy_energy
	var/atom/movable/screen/meter/foreground/foreground
	var/atom/movable/screen/cameranet_static/cameranet_static

/datum/hud/marker/New(mob/camera/marker_signal/owner)
	cameranet_static = new(null, owner)
	background = new
	psy_energy = new
	foreground = new
	psy_energy.color = COLOR_PURPLE
	psy_energy.add_filter("alpha_filter", 1, alpha_mask_filter(clamp(PSYBAR_PIXEL_WIDTH*(owner.psy_energy/owner.psy_energy_maximum), 0, owner.psy_energy_maximum), 0, icon('necromorphs/icons/hud/healthbar.dmi', "alpha_mask"), flags = MASK_INVERSE))
	foreground.maptext_x = 53
	foreground.maptext = MAPTEXT("[round(owner.psy_energy, 1)]/[owner.psy_energy_maximum] | +[owner.psy_energy_generation] psy/sec")
	infodisplay += background
	infodisplay += psy_energy
	infodisplay += foreground
	..()

/datum/hud/marker/show_hud(version, mob/viewmob)
	if(!..())
		return FALSE
	var/mob/screenmob = viewmob || mymob
	var/view = screenmob.client.view || world.view
	cameranet_static.update_o(view)
	screenmob.client.screen += cameranet_static
