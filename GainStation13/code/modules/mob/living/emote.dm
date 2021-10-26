
/datum/emote/living/gurgle
	key = "gurgle"
	key_third_person = "gurgles"
	message = "'s belly gurgles"
	emote_type = EMOTE_AUDIBLE


/datum/emote/living/gurgle/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(prob(50))
			playsound(user, 'GainStation13/sound/voice/gurgle1.ogg', 50, 1, -1)
		else
			playsound(user, 'GainStation13/sound/voice/gurgle2.ogg', 50, 1, -1)
	. = ..()

/datum/emote/living/burp/run_emote(mob/living/user, params)
	if(ishuman(user))
		playsound(user, 'GainStation13/sound/voice/burp1.ogg', 50, 1, -1)
	. = ..()

/datum/emote/living/fart
	key = "fart"
	key_third_person = "farts"
	message = " farts"
	emote_type = EMOTE_AUDIBLE

//Shhh... It's a secret! Don't tell or I'll steal your legs
/datum/emote/living/burunyu
	key = "burunyu"
	key_third_person = "burunyues"
	message = " emits a strange feline sound"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/burunyu/run_emote(mob/living/user, params)
	playsound(user, 'GainStation13/sound/voice/funnycat.ogg', 50, 1, -1)
	. = ..()
