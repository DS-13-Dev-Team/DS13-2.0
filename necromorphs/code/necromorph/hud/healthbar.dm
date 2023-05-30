/atom/movable/screen/meter
	icon = 'necromorphs/icons/hud/healthbar.dmi'
	icon_state = "backdrop"
	screen_loc = "TOP,CENTER-2:-8"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/meter/background
	icon_state = "backdrop"

/atom/movable/screen/meter/health
	icon_state  = "health_grayscale"
	color = COLOR_CULT_RED

/atom/movable/screen/meter/health/shield
	color = COLOR_SILVER

/atom/movable/screen/meter/foreground
	icon_state = "graphic"
	maptext_x = 73
	maptext_y = 8
	maptext_width = HUD_METER_PIXEL_WIDTH
