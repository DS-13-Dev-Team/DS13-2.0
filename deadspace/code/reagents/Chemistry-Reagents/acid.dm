
/datum/reagent/acid
	name = "Sulphuric acid"
	description = "A very corrosive mineral acid with the molecular formula H2SO4."
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#db5008"
	inverse_chem_val = REM * 2
	var/power = 0.9
	var/meltdose = 23 // How much is needed to melt

/datum/reagent/acid/necromorph
	name = "Biological acid"
	description = "A corrosive chemical of organic origin"
	taste_description = "acid"
	reagent_state = LIQUID
	color = NECROMORPH_ACID_COLOR
	inverse_chem_val = 0.65
	burning_volume =  0.65	//Slow burn
	power = NECROMORPH_ACID_POWER
