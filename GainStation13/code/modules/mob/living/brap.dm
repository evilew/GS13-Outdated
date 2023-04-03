/datum/emote/living/brap
    key = "brap"
    key_third_person = "braps"
    message = " "
    emote_type = EMOTE_AUDIBLE

/datum/emote/living/brap/select_message_type(mob/user)
    return pick("farts loudly!", "cuts a fat one!", "rips absolute ass!")
   


/datum/emote/living/brap/run_emote(mob/living/user, params)
	if(!ishuman(user))
		return FALSE	

	var/fartSoundChoice = rand(7)
	switch(fartSoundChoice)
		if(0) 
			playsound(user, 'GainStation13/sound/voice/brap3.ogg', 50, 1, -1)
		if(1)
			playsound(user, 'GainStation13/sound/voice/brap4.ogg', 50, 1, -1)
		if(2)
			playsound(user, 'GainStation13/sound/voice/brap2.ogg', 50, 1, -1)
		if(3)
			playsound(user, 'GainStation13/sound/voice/brap1.ogg', 50, 1, -1)
		if(4)
			playsound(user, 'GainStation13/sound/voice/brap5.ogg', 50, 1, -1)
		if(5) 
			playsound(user, 'GainStation13/sound/voice/brap6.ogg', 50, 1, -1)
		if(6)
			playsound(user, 'GainStation13/sound/voice/brap7.ogg', 50, 1, -1)
		if(7) 
			playsound(user, 'GainStation13/sound/voice/brap8.ogg', 50, 1, -1)

	. = ..()	




