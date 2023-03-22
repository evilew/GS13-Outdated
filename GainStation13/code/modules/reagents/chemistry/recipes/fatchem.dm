//GS13 - fat chems


//WG chem
/datum/chemical_reaction/lipoifier
	name = "lipoifier"
	id = /datum/reagent/consumable/lipoifier
	results = list(/datum/reagent/consumable/lipoifier = 3)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/cornoil = 1, /datum/reagent/medicine/synthflesh = 1)


//BURP CHEM

/datum/chemical_reaction/fizulphite
	name = "fizulphite"
	id = /datum/reagent/consumable/fizulphite
	results = list(/datum/reagent/consumable/fizulphite = 3)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/nitrogen = 1, /datum/reagent/oxygen = 3)

//ANTI-BURP / ANTI-FULLNESS CHEM

/datum/chemical_reaction/extilphite
	name = "extilphite"
	id = /datum/reagent/consumable/extilphite
	results = list(/datum/reagent/consumable/extilphite = 3)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/sodium = 2, /datum/reagent/carbon = 2)
