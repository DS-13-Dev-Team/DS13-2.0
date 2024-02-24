/obj/structure/chair/pod
	name = "escape pod seat"
	desc = "A comfortable, secure seat. It has a sturdy-looking buckling system for protecting passengers from sudden changes in acceleration."
	icon = 'deadspace/icons/obj/chairs.dmi'
	icon_state = "pod_chair"
	color = "#FFFFFF"

/obj/structure/chair/pod/yellow/New(newloc, newmaterial)
	..(newloc,"steel","yellow")
