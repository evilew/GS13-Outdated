/datum/emote/living/brap
    key = "brap"
    key_third_person = "braps"
    message = " "
    emote_type = EMOTE_AUDIBLE

/datum/emote/living/brap/select_message_type(var/mob/user)
    return pick("farts loudly!", "cuts a fat one!", "rips absolute ass!")

/datum/emote/living/brap/run_emote(var/mob/living/user, params)
	if(!ishuman(user))
		return FALSE	

	var/turf/source = get_turf(user)
	var/sound/farting = sound(get_sfx("fart"))
	for(var/mob/living/M in get_hearers_in_view(3, source))
		if(M.client && M.client.prefs.cit_toggles & FARTING_NOISES)
			SEND_SOUND(M, farting)

	. = ..()	
