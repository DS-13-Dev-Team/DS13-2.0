/datum/necro_class
	var/display_name = ""
	var/desc = ""
	var/ui_icon = 'necromorphs/icons/necromorphs/base_necromorph.dmi'

	var/tier = 0

	var/necromorph_type_path = null

	///If nests can spawn this necromorph
	var/nest_allowed = FALSE

	///Biomass required to spawn this necromorph
	var/biomass_cost = INFINITY

	///Biomass required to unlock this necromorph
	var/biomass_spent_required = INFINITY

	// *** Melee Attacks *** //
	///The amount of damage a necromorph will do with a 'slash' attack.
	var/melee_damage_lower = 10
	var/melee_damage_upper = 10
	var/armour_penetration = 0

	var/list/necro_armor

	// *** Health *** //
	///Maximum health a necromorph has.
	var/max_health = 100

	///see_in_dark value while consicious
	var/conscious_see_in_dark = 8
	///see_in_dark value while unconscious
	var/unconscious_see_in_dark = 5

	// *** Flags *** //
	///bitwise flags denoting things a necromorph can and cannot do, or things a necromorph is or is not. uses defines.
	var/necro_flags = NONE

	// *** Defense *** //
	var/list/armor = list()

	///How effective fire is against this necromorph. From 0 to 1 as it is a multiplier.
	var/fire_resist = 1

	///the 'abilities' available to a necromorph.
	var/list/datum/action/actions = list()

	///List of traits we add in Initialize()
	var/list/traits = list(
		TRAIT_DEFIB_BLACKLISTED,
		TRAIT_BADDNA,
		TRAIT_GENELESS,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOMETABOLISM,
		TRAIT_TOXIMMUNE,
		TRAIT_EASYDISMEMBER,
		TRAIT_NOBREATH,
		TRAIT_NOCRITDAMAGE,
		TRAIT_FEARLESS,
		TRAIT_NO_SOUL,
		TRAIT_CANT_RIDE,
		TRAIT_CAN_STRIP,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RESISTCOLD,
		TRAIT_DISCOORDINATED_TOOL_USER,
		//TRAIT_VENTCRAWLER_ALWAYS,
		TRAIT_PIERCEIMMUNE,
		TRAIT_IGNOREDAMAGESLOWDOWN,
	)

	///The iconstate for the necromorph on the minimap
	var/minimap_icon = "xenominion"

	///How quickly the necromorph enters vents
	var/vent_enter_speed = NECRO_DEFAULT_VENT_ENTER_TIME
	///How quickly the necromorph enters vents
	var/vent_exit_speed = NECRO_DEFAULT_VENT_EXIT_TIME
	///Whether the necromorph enters and crawls through vents silently
	var/silent_vent_crawl = FALSE

	//TODO: Get rid of this
	var/implemented = FALSE

/datum/necro_class/proc/load_data(mob/living/carbon/human/necromorph/necro)
	for(var/trait in traits)
		ADD_TRAIT(necro, trait, NECROMORPH_TRAIT)

	for(var/datum/action/action_datum as anything in actions)
		action_datum = new action_datum(necro)
		action_datum.Grant(necro)

	necro.armor = getArmor(arglist(armor))

	necro.necro_armors = getNecroArmor(arglist(necro_armor))
	necro.dodge_shield = necro.necro_armors.getRating(ARMOR_PROTECTION)
	if(necro.hud_used)
		var/datum/hud/necromorph/hud = necro.hud_used
		hud.update_shieldbar()

	necro.melee_damage_upper = melee_damage_upper

	necro.melee_damage_lower = melee_damage_lower

	necro.armour_penetration = armour_penetration

	necro.setMaxHealth(max_health)

	necro.conscious_see_in_dark = conscious_see_in_dark

	necro.unconscious_see_in_dark = unconscious_see_in_dark

	necro.necro_flags = necro_flags

	necro.fire_resist =  fire_resist

	necro.vent_enter_speed = vent_enter_speed

	necro.vent_exit_speed = vent_exit_speed

	necro.silent_vent_crawl = silent_vent_crawl
