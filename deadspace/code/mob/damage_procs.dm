/mob/living
	var/lasting_damage = 0 //Damage which doesn't heal under normal circumstances

/mob/living/proc/adjustLastingDamage(amount)
	lasting_damage += amount
	health = min(health, getAdjustedMaxHealth())
	updatehealth()

/mob/living/proc/getLastingDamage()
	return lasting_damage

/mob/living/proc/getAdjustedMaxHealth()
	return (MAX_LIVING_HEALTH - getLastingDamage())
