/datum/component/fattening_door
	var/fatten = FALSE // whether player will be fattened
	var/fat_to_add = 2 // fatness per tick stunned
	var/stuck = FALSE // whether player is stuck
	var/stuck_delay = 0 // set in proc/Fatten
	// var/fatten_delay = 1 // ticks per periodic loop
	// var/blocked = FALSE // whether door is blocked // Unneeded now as FatStun replaces this loop requirement.

/datum/component/fattening_door/Initialize()
	if(!istype(parent, /obj/structure/mineral_door)) // if the attached object isn't a door, return incompatible!
		return COMPONENT_INCOMPATIBLE
	
	RegisterSignal(parent, list(COMSIG_MOVABLE_CROSSED), .proc/Fatten)


/datum/component/fattening_door/proc/Fatten() //GS13
	to_chat(world, "fattenPass1")
	//blocked = FALSE

	var/turf/T = get_turf(parent)
	for(var/mob/living/carbon/M in T)
		//blocked = TRUE
		stuck = M.AmountFatStunned()
		// determine if mob should get stuck and be fattened
		if(M.fatness >= FATNESS_LEVEL_BARELYMOBILE)
			fatten = TRUE
			if(!stuck)
				stuck_delay = 120
				M.visible_message(
					"<span class='boldnotice'>[M] gets stuck in the doorway!</span>",
					"<span class='boldwarning'>You feel yourself get stuck in the doorway!</span>")
		else if(M.fatness >= FATNESS_LEVEL_MORBIDLY_OBESE)
			fatten = TRUE
			if(!stuck)
				stuck_delay = 50
				M.visible_message(
					"<span class='boldnotice'>[M] barely squeezes through the doorway!</span>",
					"<span class='boldwarning'>You feel your sides barely squeeze through the doorway!</span>")
		else if(M.fatness >= FATNESS_LEVEL_FATTER)
			fatten = TRUE
			if(!stuck)
				stuck_delay = 15
				M.visible_message(
					"<span class='boldnotice'>[M]'s sides briefly smush against the doorway.</span>",
					"<span class='boldwarning'>You feel your sides smush against the doorway!.</span>")
		else if(M.fatness >= FATNESS_LEVEL_FAT)
			fatten = TRUE
			if(!stuck)
				stuck_delay = 5
				M.visible_message(
					"<span class='boldnotice'>[M]'s sides briefly brush against the doorway.</span>",
					"<span class='boldwarning'>You feel your sides briefly brush against the doorway!</span>")
		else
			fatten = FALSE
			stuck = FALSE
			stuck_delay = 0
		
		// This requires a rework unfortunately now that its moved into a datum component.
		// I'll just make a custom status effect which stuns the player and while stunned, adds fatness :3
		// if (fatten) // get stuck
		// 	if (!stuck)
		// 		M.Stun(stuck_delay/2) // give player time to escape
		// 		stuck = TRUE
		// 	if (stuck_delay > 0) // wait for stun to end
		// 		stuck_delay = stuck_delay - fatten_delay
		// 		if (stuck_delay <= 0)
		// 			stuck_delay = 0
		// 		// gain weight while stuck
		// 		M.adjust_fatness(fat_to_add, FATTENING_TYPE_ITEM)

		if(fatten)
			M.FatStun(stuck_delay, fatAmount = fat_to_add)

	// if (!blocked)
	// 	stuck = FALSE // ready to go again
