/obj/effect/spinning_light
	var/spin_rate = 1 SECONDS
	var/_size = 48
	var/_factor = 0.5
	var/_density = 4
	var/_offset = 30
	var/_color = COLOR_ORANGE
	plane = ABOVE_LIGHTING_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT


/obj/effect/spinning_light/Initialize()
	. = ..()
	filters = filter(type="rays", size = _size, color = _color, factor = _factor, density = _density, flags = FILTER_OVERLAY, offset = _offset)

	alpha = 200

	//Rays start rotated which made synchronizing the scaling a bit difficult, so let's move it 45 degrees
	var matrix/m = new
	var/matrix/test = new
	test.Turn(-45)
	var/matrix/squished = new
	squished.Scale(1, 0.5)
	animate(src, transform = test * m.Turn(90), spin_rate / 4, loop = -1)
	animate(transform = test * m.Turn(90), spin_rate / 4, loop = -1)
	animate(transform = test * m.Turn(90), spin_rate / 4, loop = -1)
	animate(transform = test * matrix(),   spin_rate / 4, loop = -1)


/obj/effect/spinning_light/proc/set_color(_color)
	filters = filter(type="rays", size = _size, color = _color, factor = _factor, density = _density, flags = FILTER_OVERLAY, offset = _offset)


/obj/machinery/rotating_alarm
	name = "Industrial alarm"
	desc = "An industrial rotating alarm light."
	icon = 'icons/obj/rotating_alarm.dmi'
	icon_state = "alarm"
	idle_power_usage = 0
	active_power_usage = 0
	anchored = TRUE

	var/on = FALSE
	var/low_alarm = FALSE

	var/obj/effect/spinning_light/spin_effect = null

	var/alarm_light_color = COLOR_ORANGE
	/// This is an angle to rotate the colour of alarm and its light. Default is orange, so, a 45 degree angle clockwise will make it green
	var/angle = 0

	var/static/list/spinning_lights_cache = list()


/obj/machinery/rotating_alarm/Initialize()
	. = ..()

	//Setup colour
	var/list/color_matrix = color_rotation(angle)

	color = color_matrix

	set_color(alarm_light_color)

	setDir(dir) //Set dir again so offsets update correctly


/obj/machinery/rotating_alarm/setDir(ndir) //Due to effect, offsets cannot be part of sprite, so need to set it for each dir
	. = ..()
	if(dir == NORTH)
		pixel_y = -13
	if(dir == SOUTH)
		pixel_y = 28
	if(dir == WEST)
		pixel_x = 20
	if(dir == EAST)
		pixel_x = -20


/obj/machinery/rotating_alarm/proc/set_color(color)
	if (on)
		remove_viscontents(spin_effect)
	if (isnull(spinning_lights_cache["[color]"]))
		spinning_lights_cache["[color]"] = new /obj/effect/spinning_light()
	spin_effect = spinning_lights_cache["[color]"]
	alarm_light_color = color

	var/RGB = RotateHue(alarm_light_color, angle)

	alarm_light_color = RGB
	spin_effect.set_color(color)
	if (on)
		add_viscontents(spin_effect)


/obj/machinery/rotating_alarm/proc/set_on()
	add_viscontents(spin_effect)
	set_light(1, 0.5, 2, 0.3, l_color = alarm_light_color)
	on = TRUE
	low_alarm = FALSE


/obj/machinery/rotating_alarm/proc/set_off()
	remove_viscontents(spin_effect)
	set_light(0)
	on = FALSE
	low_alarm = FALSE
