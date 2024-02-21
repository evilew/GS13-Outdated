//Skyrat port start
/datum/quirk/alcohol_lightweight
	name = "Alcoholic Lightweight"
	desc = "Alcohol really goes straight to your head, gotta be careful with what you drink."
	value = 0
	category = CATEGORY_ALCOHOL
	mob_trait = TRAIT_ALCOHOL_LIGHTWEIGHT
	gain_text = "<span class='notice'>You feel woozy thinking of alcohol.</span>"
	lose_text = "<span class='notice'>You regain your stomach for drinks.</span>"
//Skyrat port stop

/datum/quirk/cursed_blood
	name = "Cursed Blood"
	desc = "Your lineage is cursed with the paleblood curse. Best to stay away from holy water... Hell water, on the other hand..."
	value = 0
	category = CATEGORY_GAMEPLAY
	mob_trait = TRAIT_CURSED_BLOOD
	gain_text = "<span class='notice'>A curse from a land where men return as beasts runs deep in your blood. Best to stay away from holy water... Hell water, on the other hand...</span>"
	lose_text = "<span class='notice'>You feel the weight of the curse in your blood finally gone.</span>"
	medical_record_text = "Patient suffers from an unknown type of aversion to holy reagents. Keep them away from a chaplain."

/datum/quirk/inheat
	name = "In Heat"
	desc = "Your system burns with the desire to be bred, your body will betray you and alert others' to your desire when examining you. Satisfying your lust will make you happy, but ignoring it may cause you to become sad and needy."
	value = 0
	category = CATEGORY_SEXUAL
	mob_trait = TRAIT_HEAT
	gain_text = "<span class='notice'>You body burns with the desire to be bred.</span>"
	lose_text = "<span class='notice'>You feel more in control of your body and thoughts.</span>"

/datum/quirk/macrophile
	name = "Macrophile"
	desc = "You are attracted to larger people, and being stepped on by them."
	value = 0
	category = CATEGORY_SEXUAL
	mob_trait = TRAIT_MACROPHILE
	gain_text = "<span class='notice'>You feel attracted to people larger than you."
	lose_text = "<span class='notice'>You feel less attracted to people larger than you."

/datum/quirk/microphile
	name = "Microphile"
	desc = "You are attracted to smaller people, and stepping on them."
	value = 0
	category = CATEGORY_SEXUAL
	mob_trait = TRAIT_MICROPHILE
	gain_text = "<span class='notice'>You feel attracted to people smaller than you."
	lose_text = "<span class='notice'>You feel less attracted to people smaller than you."
