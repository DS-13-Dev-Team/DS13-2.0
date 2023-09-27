/obj/machinery/vending/armory
	name = "\improper Ammotech"
	desc = "An overwhelming amount of <b>ancient patriotism</b> washes over you just by looking at the machine."
	icon_state = "liberationstation"
	product_slogans = "Liberation Station: Your one-stop shop for all things second amendment!;Be a patriot today, pick up a gun!;Quality weapons for cheap prices!;Better dead than red!"
	product_ads = "Float like an astronaut, sting like a bullet!;Express your second amendment today!;Guns don't kill people, but you can!;Who needs responsibilities when you have guns?"
	vend_reply = "Remember the name: Ammotech!"
	panel_type = "panel17"
	products = list(
		/obj/item/gun/ballistic/automatic/pistol/divet = 10,
		/obj/item/ammo_box/magazine/divet = 20,
		/obj/item/ammo_box/magazine/divet/hp = 10,
		/obj/item/ammo_box/magazine/divet/ap = 10,
		/obj/item/ammo_box/magazine/divet/extended = 10,
		/obj/item/gun/ballistic/shotgun/scl_shotgun = 2,
		/obj/item/ammo_box/magazine/ds12g = 6,
		/obj/item/ammo_box/magazine/ds12g/slug = 6,
		/obj/item/ammo_box/magazine/seeker = 12,
	)
	premium = list(
		/obj/item/gun/ballistic/deadspace/twohanded/seeker = 1,
		)
	contraband = list(
		/obj/item/clothing/under/misc/patriotsuit = 3,
		/obj/item/bedsheet/patriot = 5,
		/obj/item/food/burger/superbite = 3
	) //U S A
	default_price = PAYCHECK_HARD * 2
	extra_price = PAYCHECK_COMMAND * 3
	payment_department = ACCOUNT_SEC
	light_mask = "liberation-light-mask"
