/datum/preferences/proc/perma_fat_save(character)
	if(iscarbon(character))
		var/mob/living/carbon/C = character
		if(!path)
			return 0
			if(world.time < savecharcooldown)
				if(istype(parent))
					to_chat(parent, "<span class='warning'>You're attempting to save your character a little too fast. Wait half a second, then try again.</span>")

				return 0

		savecharcooldown = world.time + PREF_SAVELOAD_COOLDOWN
		var/savefile/S = new /savefile(path)
		if(!S)
			return 0
		S.cd = "/character[default_slot]"
		
		WRITE_FILE(S["permanent_fat"]			, C.fatness_perma)
