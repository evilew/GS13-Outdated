/datum/emote/living/proc/make_noise(var/mob/living/user, noise_name, pref_toggle)
	if(!ishuman(user))
		return FALSE	

	var/turf/source = get_turf(user)
	var/sound/noise = sound(gs13_get_sfx(noise_name))
	for(var/mob/living/M in get_hearers_in_view(3, source))
		if ((pref_toggle == 0) || (M.client && M.client.prefs.cit_toggles & pref_toggle))
			SEND_SOUND(M, noise)

/datum/emote/living/belch
	key = "belch"
	key_third_person = "belches loudly"
	message = "belches"
	emote_type = EMOTE_AUDIBLE
	//god hates me for this -Metha

/datum/emote/living/belch/run_emote(mob/living/user, params)
	if(!ishuman(user))
		return FALSE 
	
	make_noise(user, "belch", BURPING_NOISES)

	. = ..()	

/datum/emote/living/brap
    key = "brap"
    key_third_person = "braps"
    message = " "
    emote_type = EMOTE_AUDIBLE

/datum/emote/living/brap/select_message_type(var/mob/living/user)
    return pick("farts loudly!", "cuts a fat one!", "rips absolute ass!")

/datum/emote/living/brap/run_emote(var/mob/living/user, params)
	if(!ishuman(user))
		return FALSE	

	make_noise(user, "brap", FARTING_NOISES)

	. = ..()	

/datum/emote/living/burp
	key = "burp"
	key_third_person = "burps"
	message = "burps."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/burp/run_emote(mob/living/user, params)
	if(!ishuman(user))
		return FALSE
	
	make_noise(user, "burp", BURPING_NOISES)

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

	make_noise(user, "fart", FARTING_NOISES)
		
	. = ..()	

/datum/emote/living/gurgle
	key = "gurgle"
	key_third_person = "gurgles"
	message = "'s belly gurgles"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/gurgle/run_emote(mob/living/user, params)
	if(!ishuman(user))
		return FALSE

	make_noise(user, "gurgle", 0)

	. = ..()

//Shhh... It's a secret! Don't tell or I'll steal your legs
/datum/emote/living/burunyu
	key = "burunyu"
	key_third_person = "burunyues"
	message = "emits a strange feline sound"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/burunyu/run_emote(mob/living/user, params)
	if(!ishuman(user))
		return FALSE

	make_noise(user, "burunyu", 0)

	. = ..()
