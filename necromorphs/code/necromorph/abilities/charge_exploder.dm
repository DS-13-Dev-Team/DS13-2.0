/datum/action/cooldown/necro/charge/exploder
	charge_delay = 0.3 SECONDS
	charge_time = 10 SECONDS
	charge_speed = 4

/datum/action/cooldown/necro/charge/exploder/hit_target(mob/living/carbon/human/necromorph/source, mob/living/target)
	if(isliving(target))
		var/obj/item/bodypart/leg/left/necromorph/exploder/pustule = src.target
		pustule.explode()
		source.gib_animation()
		new /obj/effect/temp_visual/scry(get_turf(source), source.marker.markernet)
		SSmove_manager.stop_looping(source)
		qdel(source)
	else
		source.visible_message(span_danger("[source] smashes into [target]!"))
		shake_camera(source, 4, 3)
		source.Stun(6)
