/datum/emote/living/proc/make_noise(var/mob/living/user, noise_name, pref_toggle)
	if(!ishuman(user))
		return FALSE	

	var/turf/source = get_turf(user)
	var/sound/noise = sound(gs13_get_sfx(noise_name))
	for(var/mob/living/M in get_hearers_in_view(3, source))
		if ((pref_toggle == 0) || (M.client && M.client?.prefs?.cit_toggles & pref_toggle))
			M.playsound_local(source, noise_name, 50, 1, S = noise)

/datum/emote/living/proc/reduce_fullness(var/mob/living/user, fullness_amount) // fullness_amount should be between 5 and 20 for balance and below 80 for functionality
	if(!ishuman(user))
		return FALSE	

	var/mob/living/N = user
	if(N.fullness >= FULLNESS_LEVEL_BLOATED && N.fullness_reducion_timer + FULLNESS_REDUCTION_COOLDOWN < world.time)
		N.fullness -= fullness_amount
		if(fullness_amount <= 5)
			to_chat(N, "You felt that make some space")
		if(fullness_amount > 5)
			to_chat(N, "You felt that make a lot of space")

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
	reduce_fullness(user, rand(6,12))

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
	var/obj/item/storage/book/bible/b = locate(/obj/item/storage/book/bible) in get_turf(user) //Biblefart
	if(b) //Devine Retribution
		user.visible_message("<span class='danger'>\The [user] farts on \the [b], causing a violent, otherworldly ripple to echo outwards before they explode in a gorey mess of divine retribution!</span>",
							"<span class='userdanger'>You feel a deep sense of dread as you release pressure from your rear over \the [b], immediately realizing your mistake as Divine Retribution rends your form into a gorey mess.</span>")
		user.emote("scream")
		message_admins("[ADMIN_LOOKUPFLW(user)] farted on a bible at [ADMIN_VERBOSEJMP(user)] and was gibbed.")
		log_game("[key_name(user)] farted on a bible at [AREACOORD(user)] and was gibbed")
		user.gib()
		return ..() //Gassy is dead, no fullness to reduce

	. = ..()	
	reduce_fullness(user, rand(6,12))

/datum/emote/living/burp
	key = "burp"
	key_third_person = "burps"
	message = "burps"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/burp/run_emote(mob/living/user, params)
	if(!ishuman(user))
		return FALSE
	
	make_noise(user, "burp", BURPING_NOISES)

	. = ..()
	reduce_fullness(user, rand(4,8))

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
	var/obj/item/storage/book/bible/b = locate(/obj/item/storage/book/bible) in get_turf(user) //Biblefart
	if(b) //Devine Retribution
		user.visible_message("<span class='danger'>\The [user] farts on \the [b], causing a violent, otherworldly ripple to echo outwards before they explode in a gorey mess of divine retribution!</span>",
							"<span class='userdanger'>You feel a deep sense of dread as you release pressure from your rear over \the [b], immediately realizing your mistake as Divine Retribution rends your form into a gorey mess.</span>")
		user.emote("scream")
		message_admins("[ADMIN_LOOKUPFLW(user)] farted on a bible at [ADMIN_VERBOSEJMP(user)] and was gibbed.")
		log_game("[key_name(user)] farted on a bible at [AREACOORD(user)] and was gibbed")
		user.gib()
		return ..() //Gassy is dead, no fullness to reduce

	. = ..()	
	reduce_fullness(user, rand(4,8))

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

/datum/emote/living/bellyrub
	key = "bellyrub"
	key_third_person = "bellyrubs"
	message = "rubs their belly"
	emote_type  = EMOTE_VISIBLE

/datum/emote/living/bellyrub/run_emote(mob/living/user, params)
	if(!ishuman(user))
		return FALSE
	. = ..()
	reduce_fullness(user, rand(4,16))
