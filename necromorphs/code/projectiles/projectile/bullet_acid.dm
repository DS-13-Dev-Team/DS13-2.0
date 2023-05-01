/*
	Acid projectiles deal total damage equal to 100-200% of the damage value written here. So write in a value for half of what it should actually do
	On impact, the damage is applied immediately as burn, and the victim is doused in enough acid to deal that same amount of damage again over time.
	The effectiveness of the acid component is heavily dependant on worn equipment
*/
//This probably shouldn't be defined here, all acid projectiles are a child of this one, and it's not a logical place to look to find the parent. Perhaps a necro_projectiles.dm?
/obj/projectile/bullet/acid
	name = "acid bolt"
	icon = 'necromorphs/icons/obj/projectiles.dmi'
	icon_state = "acid_small"
	damage = 15
	damage_type = BURN
	nodamage = 0

	muzzle_type = /obj/effect/projectile/muzzle/bio
	impact_type = /obj/effect/projectile/impact/acid



/obj/projectile/bullet/acid/on_hit(mob/living/target_mob, blocked, pierce_hit)
	if (firer.is_allied(target_mob))	//The bullet passes through our own allies harmlessly
		return TRUE

	. = ..()
	//The parent call will return false if we stop on this victim, but it will return true if we miss them or bounce off
	//We only want to deposit acid on the victim in the former case, not the latter. So check for false
	if (!.)
		var/acid_volume = damage / NECROMORPH_ACID_POWER	//Figure out how many units of acid we need
		var/datum/reagents/R = new(acid_volume, GLOB.bioblast_acid_holder)
		R.add_reagent(/datum/reagent/acid/necromorph, acid_volume)
		R.trans_to(target_mob, R.total_volume)
		qdel(R)
