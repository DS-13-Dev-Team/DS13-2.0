/atom/movable/screen/plane_master/marker_signal
	name = "marker signal plane master"
	plane = MARKER_SIGNAL_PLANE
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/obscuruity
	name = "obscurity plane master"
	plane = OBSCURITY_PLANE
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/obscuruity/Initialize(mapload)
	. = ..()
	add_filter("masking", 1, alpha_mask_filter(render_source = OBSCURITY_MASKING_RENDER_TARGET, flags = MASK_INVERSE))

/atom/movable/screen/plane_master/obscurity_masking
	name = "obscurity masking plane master"
	plane = OBSCURITY_MASKING_PLANE
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY
	render_target = OBSCURITY_MASKING_RENDER_TARGET
	render_relay_plane = null
