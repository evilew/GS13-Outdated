GLOBAL_LIST_INIT(uncapped_resize_areas, list(/area/bridge, /area/crew_quarters, /area/maintenance, /area/security/prison, /area/holodeck, /area/security/vacantoffice, /area/space, /area/ruin, /area/lavaland, /area/awaymission, /area/centcom, /area/fatlab))

/mob/living/carbon
	//Due to the changes needed to create the system to hide fatness, here's some notes:
	// -If you are making a mob simply gain or lose weight, use adjust_fatness. Try to not touch the variables directly unless you know 'em well
	// -fatness is the value a mob is being displayed and calculated as by most things. Changes to fatness are not permanent
	// -fatness_real is the value a mob is actually at, even if it's being hidden. For permanent changes, use this one
	//What level of fatness is the parent mob currently at?
	var/fatness = 0
	//The list of items/effects that are being added/subtracted from our real fatness
	var/fat_hiders = list()
	//The actual value a mob is at. Is equal to fatness if fat_hider is FALSE.
	var/fatness_real = 0
	///At what rate does the parent mob gain weight? 1 = 100%
	var/weight_gain_rate = 1
	//At what rate does the parent mob lose weight? 1 = 100%
	var/weight_loss_rate = 1
	//Variable related to door stuckage code
	var/doorstuck = 0

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

	fatness_real += amount_to_change 
	fatness_real = max(fatness_real, MINIMUM_FATNESS_LEVEL) //It would be a little silly if someone got negative fat.

	if(client?.prefs?.max_weight) // GS13
		fatness_real = min(fatness_real, (client?.prefs?.max_weight - 1))

	fatness = fatness_real //Make their current fatness their real fatness

	hiders_apply()	//Check and apply hiders, XWG is there too

	return TRUE


/mob/living/carbon/fully_heal(admin_revive)
	fatness = 0
	fatness_real = 0
	. = ..()

///Checks the parent mob's prefs to see if they can be fattened by the fattening_type
/mob/living/carbon/proc/check_weight_prefs(type_of_fattening = FATTENING_TYPE_ITEM)
	if(HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER) && !client.prefs) //Comment this second part out
		return TRUE
	
	if(!client?.prefs || !type_of_fattening)
		return FALSE

	switch(type_of_fattening)
		if(FATTENING_TYPE_ITEM)
			if(!client?.prefs?.weight_gain_items)
				return FALSE

		if(FATTENING_TYPE_FOOD)
			if(!client?.prefs?.weight_gain_food)
				return FALSE

		if(FATTENING_TYPE_CHEM) 
			if(!client?.prefs?.weight_gain_chems)
				return FALSE

		if(FATTENING_TYPE_WEAPON)
			if(!client?.prefs?.weight_gain_weapons)
				return FALSE

		if(FATTENING_TYPE_MAGIC)
			if(!client?.prefs?.weight_gain_magic)
				return FALSE

		if(FATTENING_TYPE_VIRUS)
			if(!client?.prefs?.weight_gain_viruses)
				return FALSE

		if(FATTENING_TYPE_NANITES)
			if(!client?.prefs?.weight_gain_nanites)
				return FALSE

		if(FATTENING_TYPE_WEIGHT_LOSS)
			if(HAS_TRAIT(src, TRAIT_WEIGHT_LOSS_IMMUNE))
				return FALSE
		
	return TRUE

	// THE FATNESS HIDING GUIDE!!!
	// HOW 2 FATNESS HIDE
	//Step 1) Grab a thing that will add or reduce fatness!
	//Step 2) Give it a character.hider_add(src) and a character.hider_remove(src) depending on the conditions you want it to meet for which it will add or remove itself from messing with a character's fatness!
	//Step 3) Give it a proc/fat_hide([character argument]), with a return that will give the amount to shift that character's fatness by!
	//Step 4) There is no step 4, you did it bucko!
	//Wanna see an example? Search for /obj/item/bluespace_belt !!!

/mob/living/carbon/proc/hider_add(hide_source)
	if(!(hide_source in fat_hiders))
		fat_hiders += hide_source

	return TRUE

/mob/living/carbon/proc/hider_remove(hide_source)
	if(hide_source in fat_hiders)
		fat_hiders -= hide_source
	return TRUE

/mob/living/carbon/proc/hiders_calc()
	var/hiders_value = 0
	for(var/hider in fat_hiders)	
		var/hide_values = hider:fat_hide(src)
		if(!islist(hide_values))
			hiders_value += hide_values
		else
			for(var/hide_value in hide_values)
				hiders_value += hide_value
	return hiders_value

/mob/living/carbon/proc/hiders_apply()
	if(fat_hiders) //do we have any hiders active?
		var/fatness_over = hiders_calc() //calculate the sum of all hiders
		if(client?.prefs?.max_weight) //Check their prefs
			fatness_over = min(fatness_over, (client?.prefs?.max_weight - 1)) //And make sure it's not above their preferred max
		fatness = fatness_real + fatness_over //Then, make their current fatness the sum of their real plus/minus the calculated amount
	if(client?.prefs?.weight_gain_extreme && !normalized)
		xwg_resize()

/mob/living/carbon/human/handle_breathing(times_fired)
	. = ..()
	hiders_apply()

/mob/living/carbon/proc/xwg_resize()
	var/xwg_size = sqrt(fatness/FATNESS_LEVEL_BLOB)
	xwg_size = min(xwg_size, RESIZE_MACRO)
	xwg_size = max(xwg_size, custom_body_size*0.01)
	if(xwg_size > RESIZE_BIG) //check if the size needs capping otherwise don't bother searching the list
		if(!is_type_in_list(get_area(src), GLOB.uncapped_resize_areas)) //if the area is not int the uncapped whitelist and new size is over the cap
			xwg_size = RESIZE_BIG
	resize(xwg_size)

/proc/get_fatness_level_name(fatness_amount)
	if(fatness_amount < FATNESS_LEVEL_FAT)
		return "Normal"
	if(fatness_amount < FATNESS_LEVEL_FATTER)
		return "Fat"
	if(fatness_amount < FATNESS_LEVEL_VERYFAT)
		return "Fatter"
	if(fatness_amount < FATNESS_LEVEL_OBESE)
		return "Very Fat"
	if(fatness_amount < FATNESS_LEVEL_MORBIDLY_OBESE)
		return "Obese"
	if(fatness_amount < FATNESS_LEVEL_EXTREMELY_OBESE)
		return "Morbidly Obese"
	if(fatness_amount < FATNESS_LEVEL_BARELYMOBILE)
		return "Extremely Obese"
	if(fatness_amount < FATNESS_LEVEL_IMMOBILE)
		return "Barely Mobile"
	if(fatness_amount < FATNESS_LEVEL_BLOB)
		return "Immobile"

	return "Blob"
