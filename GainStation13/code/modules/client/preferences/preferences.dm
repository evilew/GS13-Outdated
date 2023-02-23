//GS13 Preferences
/datum/preferences
	//Weight Gain Sources
	///Weight gain from food
	var/weight_gain_food = FALSE
	///Weight gain from chems
	var/weight_gain_chems = FALSE
	///Weight gain from items
	var/weight_gain_items = FALSE
	///Weight gain from weapons
	var/weight_gain_weapons = FALSE
	///Weight gain from magic
	var/weight_gain_magic = FALSE
	///Weight gain from viruses
	var/weight_gain_viruses = FALSE

	///Does the person wish to be involved with non-con weight gain events?
	var/noncon_weight_gain = FALSE

	///What is the max weight that the person wishes to be? If set to FALSE, there will be no max weight
	var/max_weight = FALSE
