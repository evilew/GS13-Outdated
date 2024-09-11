/mob/living/carbon
	var/savekey
	var/ckeyslot

/mob/living/carbon/proc/perma_fat_save(mob/living/carbon/character)
	var/key = savekey
	if(!key)
		return FALSE 
	var/filename = "preferences.sav"
	var/path = "data/player_saves/[key[1]]/[key]/[filename]"

	var/savefile/S = new /savefile(path)
	if(!path)
		return FALSE

	if(character.ckeyslot)
		var/slot = character.ckeyslot
		S.cd = "/character[slot]"

		var/persi
		S["weight_gain_persistent"] >> persi
		if(persi)
			WRITE_FILE(S["starting_weight"]			, character.fatness_real)
		var/perma 
		S["weight_gain_permanent"] >> perma
		if(S["weight_gain_permanent"])
			WRITE_FILE(S["permanent_fat"]			, character.fatness_perma)

/*
/datum/preferences/proc/perma_fat_save(character)
	if(iscarbon(character))
		var/mob/living/carbon/C = character
		if(!C.client.prefs.weight_gain_permanent && !C.client.prefs.weight_gain_persistent)
			return FALSE
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
		
		if(C.client.prefs.weight_gain_persistent)
			WRITE_FILE(S["starting_weight"]			, C.fatness_real)
		if(C.client.prefs.weight_gain_permanent)
			WRITE_FILE(S["permanent_fat"]			, C.fatness_perma)
*/
