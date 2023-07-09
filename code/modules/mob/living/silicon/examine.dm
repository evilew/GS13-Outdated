/mob/living/silicon/examine(mob/user)
	// GS13: Silicon Examine Text
	// COMSIG_PARENT_EXAMINE is called in /mob/living/silicon/robot/examine instead of /atom/proc/examine
	// to display flavour_text in the examine text span similar to /mob/living/carbon/human/examine

	//Display a silicon's laws to ghosts
	if(laws && isobserver(user))
		. += "<b>[src] has the following laws:</b>"
		for(var/law in laws.get_law_list(include_zeroth = TRUE))
			. += law
