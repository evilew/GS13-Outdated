/*
//////////////////////////////////////

Weight Loss

	Very Very Noticable.
	Decreases resistance.
	Decreases stage speed.
	Reduced Transmittable.
	High level.

Bonus
	Decreases the weight of the mob,
	forcing it to be skinny.

//////////////////////////////////////
*/

/datum/symptom/weight_loss // GS13

	name = "Weight Loss"
	desc = "The virus mutates the host's metabolism, making it almost unable to gain nutrition from food."
	stealth = -2
	resistance = 2
	stage_speed = -2
	transmittable = -2
	level = 3
	severity = 3
	base_message_chance = 100
	symptom_delay_min = 15
	symptom_delay_max = 45
	threshold_desc = list(
		"Stealth 4" = "The symptom is less noticeable."
	)

/datum/symptom/weight_loss/Start(datum/disease/advance/A) // GS13
	if(!..())
		return
	if(A.properties["stealth"] >= 4) //warn less often
		base_message_chance = 25

/datum/symptom/weight_loss/Activate(datum/disease/advance/A) // GS13
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance))
				to_chat(M, "<span class='warning'>[pick("You feel hungry.", "You crave for food.")]</span>")
		else
			to_chat(M, "<span class='warning'><i>[pick("So hungry...", "You'd kill someone for a bite of food...", "Hunger cramps seize you...")]</i></span>")
			M.overeatduration = max(M.overeatduration - 100, 0)
			M.nutrition = max(M.nutrition - 100, 0)
			M.adjust_fatness(-30, FATTENING_TYPE_WEIGHT_LOSS)	

/datum/symptom/weight_gain // GS13
	name = "Weight Gain"
	desc = "The virus mutates and merges itself with the host's adipocytes, allowing them to perform a form of mitosis and replicate on their own."
	stealth = -3
	resistance = -2
	stage_speed = 3
	transmittable = -2
	level = 8    //better hope someone went mining kiddo
	severity = 5
	base_message_chance = 100
	symptom_delay_min = 15
	symptom_delay_max = 45
	threshold_desc = list(
		"Stage Speed 7" = "Increases the rate of cell replication.",
		"Stage Speed 12" = "Increases the rate of cell replication further"
	)


/datum/symptom/weight_gain/Activate(datum/disease/advance/A) // GS13
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	if(!(M?.client?.prefs?.weight_gain_viruses))
		return FALSE
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance))
				to_chat(M, "<span class='warning'>[pick("You feel oddly full...", "You feel more plush...", "You feel more huggable...", "You hear an odd gurgle from your stomach")]</span>")
		else
			to_chat(M, "<span class='warning'><i>[pick("You feel your body churn...", "You feel heavier...", "You hear an ominous gurgle from your belly...", "You feel bulkier...")]</i></span>")
			if(A.properties["stage_rate"] >= 12) //get chunkier quicker
				M.adjust_fatness(70, FATTENING_TYPE_VIRUS)	
			else if(A.properties["stage_rate"] >= 7)
				M.adjust_fatness(40, FATTENING_TYPE_VIRUS)	
			else
				M.adjust_fatness(15, FATTENING_TYPE_VIRUS)
