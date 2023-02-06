/datum/emote/living/gurgle
	key = "gurgle"
	key_third_person = "gurgles"
	message = "'s belly gurgles"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/gurgle/run_emote(mob/living/user, params)
	if(!ishuman(user))
		return FALSE

	if(prob(50))
		playsound(user, 'GainStation13/sound/voice/gurgle1.ogg', 50, 1, -1)
	else
		playsound(user, 'GainStation13/sound/voice/gurgle2.ogg', 50, 1, -1)

	. = ..()

/datum/emote/living/burp/run_emote(mob/living/user, params)
	if(!ishuman(user))
		return FALSE
	
	playsound(user, 'GainStation13/sound/voice/burp1.ogg', 50, 1, -1)
	. = ..()

/datum/emote/living/fart
	key = "fart"
	key_third_person = "farts"
	message = "farts"
	emote_type = EMOTE_AUDIBLE


	//god hates me for this -Metha

/datum/emote/living/fart/run_emote(mob/living/user, params)
	if(!ishuman(user))
		return FALSE	

	var/fartSoundChoice = rand(3)
	switch(fartSoundChoice)
		if (0)
			playsound(user, 'GainStation13/sound/voice/fart3.ogg', 50, 1, -1)
		if (1)
			playsound(user, 'GainStation13/sound/voice/fart4.ogg', 50, 1, -1)
		if (2)
			playsound(user, 'GainStation13/sound/voice/fart2.ogg', 50, 1, -1)
		if (3)
			playsound(user, 'GainStation13/sound/voice/fart1.ogg', 50, 1, -1)
		
	. = ..()	

//Shhh... It's a secret! Don't tell or I'll steal your legs
/datum/emote/living/burunyu
	key = "burunyu"
	key_third_person = "burunyues"
	message = "emits a strange feline sound"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/burunyu/run_emote(mob/living/user, params)
	playsound(user, 'GainStation13/sound/voice/funnycat.ogg', 50, 1, -1)
	. = ..()


/datum/emote/living/belch
	key = "belch"
	key_third_person = "belches loudly"
	message = "belches"
	emote_type = EMOTE_AUDIBLE

	//god hates me for this -Metha

/datum/emote/living/belch/run_emote(mob/living/user, params)
	if(!ishuman(user))
		return FALSE 
	
	var/fartSoundChoice = rand(5)
	switch(fartSoundChoice)
		if(0) 
			playsound(user, 'GainStation13/sound/voice/belch3.ogg', 50, 1, -1)
		if(1)
			playsound(user, 'GainStation13/sound/voice/belch4.ogg', 50, 1, -1)
		if(2)
			playsound(user, 'GainStation13/sound/voice/belch2.ogg', 50, 1, -1)
		if(3)
			playsound(user, 'GainStation13/sound/voice/belch1.ogg', 50, 1, -1)
		if(4)
			playsound(user, 'GainStation13/sound/voice/belch5.ogg', 50, 1, -1)
		if(5) 
			playsound(user, 'GainStation13/sound/voice/belch6.ogg', 50, 1, -1)

	. = ..()	
