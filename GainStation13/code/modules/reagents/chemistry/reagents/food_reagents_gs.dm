// This file contains anything that'd go in food_reagents.dm but is unique to GainStation. For modularity's sake.

/datum/reagent/consumable/stellarsugar //Starbit Essence.
	name = "Stellar Sugar"
	description = "An edible substance formed by rare peculiar and celestial events, ground into a powder. Delicious!"
	reagent_state = SOLID
	color = "#722be3"
	taste_mult = 5 // It's rare... and has a pretty powerful (albeit positive) presence!
	nutriment_factor = 10 * REAGENTS_METABOLISM
	metabolization_rate = 2 * REAGENTS_METABOLISM
	taste_description = "distant cosmos"
	value = 7 // It's not easy to get a lot of this stuff... so it sells for about as much as meth.
