#define MINIMUM_FATNESS_LEVEL = 0

#define FATTENING_TYPE_ITEM 0
#define FATTENING_TYPE_FOOD 1
#define FATTENING_TYPE_CHEM 2 
#define FATTENING_TYPE_WEAPON 3
#define FATTENING_TYPE_MAGIC 4
#define FATTENING_TYPE_VIRUS 5
#define FATTENING_TYPE_WEIGHT_LOSS 6 

/mob/living/carbon
	///What level of fatness is the parent mob at?
	var/fatness = 0
	///How full is the parent mob?
	var/fullness = FULLNESS_LEVEL_HALF_FULL
	///At what rate does the parent mob gain weight? 1 = 100%
	var/weight_gain_rate = 1
	//At what rate does the parent mob lose weight? 1 = 100%
	var/weight_loss_rate = 1

/** 
* Adjusts the fatness level of the parent mob.
*
* * adjustment_amount - adjusts how much weight is gained or loss. Positive numbers add weight. 
* * type_of_fattening - what type of fattening is being used. Look at the traits in fatness.dm for valid options.
*/
/mob/living/carbon/proc/adjust_fatness(adjustment_amount, type_of_fattening = FATTENING_TYPE_ITEM)
	if(!adjustment_amount || !type_of_fattening)
		return FALSE

	if(!HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER))
		switch(type_of_fattening)
			if(FATTENING_TYPE_ITEM && HAS_TRAIT(src, TRAIT_GAIN_ITEM_IMMUNE))
				return FALSE
			if(FATTENING_TYPE_FOOD && HAS_TRAIT(src, TRAIT_GAIN_FOOD_IMMUNE))
				return FALSE
			if(FATTENING_TYPE_CHEM && HAS_TRAIT(src, TRAIT_GAIN_CHEM_IMMUNE)) 
				return FALSE	
			if(FATTENING_TYPE_WEAPON && HAS_TRAIT(src, TRAIT_GAIN_WEAPON_IMMUNE))
				return FALSE
			if(FATTENING_TYPE_MAGIC && HAS_TRAIT(src, TRAIT_GAIN_MAGIC_IMMUNE))
				return FALSE
			if(FATTENING_TYPE_WEIGHT_LOSS && HAS_TRAIT(src, TRAIT_WEIGHT_LOSS_IMMUNE))
				return FALSE

	var/amount_to_change = adjustment_amount
	if(adjustment_amount > 0)
		amount_to_change * weight_gain_rate	
	else
		amount_to_change * weight_loss_rate

	fatness += amount_to_change 
	fatness = max(fatness, MINIMUM_FATNESS_LEVEL) //It would be a little silly if someone got negative fat.
	return TRUE

