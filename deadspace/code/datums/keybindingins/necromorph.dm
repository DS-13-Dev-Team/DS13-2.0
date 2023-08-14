/datum/keybinding/necromorph
	category = CATEGORY_MISC
	weight = WEIGHT_MOB

/datum/keybinding/necromorph/can_use(client/user)
	return isnecromorph(user.mob)

/datum/keybinding/necromorph/ability_One
	hotkey_keys = list("1")
	name = "use_ability_one"
	full_name = "Use Necromorph Primary Ability"
	description = "Activates primary necromorph ability."
	keybind_signal = COMSIG_KB_NECROMORPH_ABILITY_ONE_DOWN

/datum/keybinding/necromorph/ability_two
	hotkey_keys = list("2")
	name = "use_ability_two"
	full_name = "Use Necromorph Secondary Ability"
	description = "Activates secondary necromorph ability."
	keybind_signal = COMSIG_KB_NECROMORPH_ABILITY_TWO_DOWN

/datum/keybinding/necromorph/ability_three
	hotkey_keys = list("3")
	name = "use_ability_three"
	full_name = "Use Necromorph First Additional Ability"
	description = "Activates first additional necromorph ability."
	keybind_signal = COMSIG_KB_NECROMORPH_ABILITY_THREE_DOWN

/datum/keybinding/necromorph/ability_four
	hotkey_keys = list("4")
	name = "use_ability_four"
	full_name = "Use Necromorph Second Additional Ability"
	description = "Activates second additional necromorph ability."
	keybind_signal = COMSIG_KB_NECROMORPH_ABILITY_FOUR_DOWN
