#define MINIMUM_FATNESS_LEVEL = 0

/mob/living/carbon
	///What level of fatness is the parent mob at?
	var/fatness = 0
	///How full is the parent mob?
	var/fullness = FULLNESS_LEVEL_HALF_FULL

///Adjusts the fatness level of the parent mob. Positive numbers increase fatness, negative numbers remove fatness.
/mob/living/carbon/proc/adjust_fatness(adjustment_amount)
	if(!adjustment_amount)
		return FALSE
	
	fatness += adjustment_amount
	fatness = max(adjustment_amount, MINIMUM_FATNESS_LEVEL) //It would be a little silly if someone got negative fat.
	return TRUE

