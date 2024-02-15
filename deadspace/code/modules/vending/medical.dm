/obj/machinery/vending/DSchemical
	name = "\improper Chemical Bazaar"
	desc = "A machine for selling hard to get or high in demand chemicals to chemists. CEC must make a killing with this thing."
	icon_state = "custom"
	icon_deny = "custom-deny"
	panel_type = "panel20"
	product_ads = "Running out of oil? Don't make it, buy it!;Hydrochloric acid too hard to make? We have it!;Angry at alkysine ingredients? Save the hassle and buy them instead!;Chemist keeps making epi instead of inap? Buy the ingredients!"
	req_access = list(ACCESS_CHEMISTRY)
	products = list(
		/obj/item/reagent_containers/glass/bottle/ammonia = 2,
		/obj/item/reagent_containers/glass/bottle/hydacid = 2,
		/obj/item/reagent_containers/glass/bottle/oil = 2,
		/obj/item/reagent_containers/glass/bottle/phenol = 2




	)
	contraband = list(
		/obj/item/reagent_containers/glass/bottle/facid = 2,
		/obj/item/reagent_containers/glass/bottle/leadacetate = 1,
		/obj/item/reagent_containers/glass/bottle/nitracid = 1,
		/obj/item/reagent_containers/glass/bottle/polonium = 1,

	)
	premium = list(
		/obj/item/reagent_containers/glass/bottle/acetone = 3,
		/obj/item/reagent_containers/glass/bottle/cornoil = 2,
		/obj/item/reagent_containers/glass/bottle/plasma = 2,

	)
	refill_canister = /obj/item/vending_refill/chemicals
	default_price = PAYCHECK_MEDIUM
	extra_price = PAYCHECK_HARD
	payment_department = ACCOUNT_MED
	light_mask = "custom-light-mask"

/obj/item/vending_refill/chemicals
	machine_name = "Chemical Bazaar"
	icon_state = "refill_donksoft"
