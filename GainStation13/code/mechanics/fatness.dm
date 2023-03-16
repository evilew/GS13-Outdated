/mob/living/carbon
	///What level of fatness is the parent mob at?
	var/fatness = 0
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

	if(!HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER) && client?.prefs)
		if(!check_weight_prefs(type_of_fattening))
			return FALSE

	var/amount_to_change = adjustment_amount
	if(adjustment_amount > 0)
		amount_to_change = amount_to_change * weight_gain_rate	
	else
		amount_to_change = amount_to_change * weight_loss_rate

	fatness += amount_to_change 
	fatness = max(fatness, MINIMUM_FATNESS_LEVEL) //It would be a little silly if someone got negative fat.
	if(client.prefs.max_weight)
		fatness = min(fatness, (client.prefs.max_weight - 1))

	return TRUE


/mob/living/carbon/fully_heal(admin_revive)
	fatness = 0
	. = ..()

///Checks the parent mob's prefs to see if they can be fattened by the fattening_type
/mob/living/carbon/proc/check_weight_prefs(type_of_fattening = FATTENING_TYPE_ITEM)
	if(HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER) && !client.prefs) //Comment this second part out
		return TRUE
	
	if(!client?.prefs || !type_of_fattening)
		return FALSE

	switch(type_of_fattening)
		if(FATTENING_TYPE_ITEM)
			if(!client.prefs.weight_gain_items)
				return FALSE

		if(FATTENING_TYPE_FOOD)
			if(!client.prefs.weight_gain_food)
				return FALSE

		if(FATTENING_TYPE_CHEM) 
			if(!client.prefs.weight_gain_chems)
				return FALSE

		if(FATTENING_TYPE_WEAPON)
			if(!client.prefs.weight_gain_weapons)
				return FALSE

		if(FATTENING_TYPE_MAGIC)
			if(!client.prefs.weight_gain_magic)
				return FALSE

		if(FATTENING_TYPE_VIRUS)
			if(!client.prefs.weight_gain_viruses)
				return FALSE

		if(FATTENING_TYPE_WEIGHT_LOSS)
			if(HAS_TRAIT(src, TRAIT_WEIGHT_LOSS_IMMUNE))
				return FALSE
		
	return TRUE
