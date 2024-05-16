///////////////////// Mob Living /////////////////////
/mob/living
	var/digestable = FALSE					// Can the mob be digested inside a belly?
	var/showvoreprefs = TRUE				// Determines if the mechanical vore preferences button will be displayed on the mob or not.
	var/obj/belly/vore_selected				// Default to no vore capability.
	var/list/vore_organs = list()			// List of vore containers inside a mob
	var/devourable = FALSE					// Can the mob be vored at all?
	var/feeding = FALSE						// Are we going to feed someone else?
	var/vore_taste = null					// What the character tastes like
	var/no_vore = FALSE 					// If the character/mob can vore.
	var/openpanel = 0						// Is the vore panel open?
	var/absorbed = FALSE					//are we absorbed?
	var/next_preyloop
	var/adminbus_trash = FALSE				// For abusing trash eater for event shenanigans.
	var/vore_init = FALSE					//Has this mob's vore been initialized yet?
	var/vorepref_init = FALSE				//Has this mob's voreprefs been initialized?

//
// Hook for generic creation of stuff on new creatures
//
/hook/living_new/proc/vore_setup(mob/living/M)
	M.verbs += /mob/living/proc/preyloop_refresh
	M.verbs += /mob/living/proc/lick
	M.verbs += /mob/living/proc/escapeOOC

	if(M.no_vore) //If the mob isn't supposed to have a stomach, let's not give it an insidepanel so it can make one for itself, or a stomach.
		return 1
	M.verbs += /mob/living/proc/insidePanel

	//Tries to load prefs if a client is present otherwise gives freebie stomach
	spawn(10 SECONDS) // long delay because the server delays in its startup. just on the safe side.
		if(M)
			M.init_vore()

	//Return 1 to hook-caller
	return 1

/mob/living/proc/init_vore()
	vore_init = TRUE
	//Something else made organs, meanwhile.
	if(LAZYLEN(vore_organs))
		return TRUE

	//We'll load our client's organs if we have one
	if(client && client.prefs_vr)
		if(!copy_from_prefs_vr())
			to_chat(src,"<span class='warning'>ERROR: You seem to have saved vore prefs, but they couldn't be loaded.</span>")
			return FALSE
		if(LAZYLEN(vore_organs))
			vore_selected = vore_organs[1]
			return TRUE

	//Or, we can create a basic one for them
	if(!LAZYLEN(vore_organs))
		LAZYINITLIST(vore_organs)
		var/obj/belly/B = new /obj/belly(src)
		vore_selected = B
		B.immutable = 1
		B.name = "Stomach"
		B.desc = "It appears to be rather warm and wet. Makes sense, considering it's inside [name]."
		B.can_taste = 1
		return TRUE

// Handle being clicked, perhaps with something to devour
//

			// Refactored to use centralized vore code system - Leshana

			// Critical adjustments due to TG grab changes - Poojawa

/mob/living/proc/vore_attack(var/mob/living/user, var/mob/living/prey, var/mob/living/pred)
	if(!user || !prey || !pred)
		return

	if(!isliving(pred)) //no badmin, you can't feed people to ghosts or objects.
		return

	if(pred == prey) //you click your target
		if(!pred.feeding)
			to_chat(user, "<span class='notice'>They aren't able to be fed.</span>")
			to_chat(pred, "<span class='notice'>[user] tried to feed you themselves, but you aren't voracious enough to be fed.</span>")
			return
		if(!is_vore_predator(pred))
			to_chat(user, "<span class='notice'>They aren't voracious enough.</span>")
			return
		feed_self_to_grabbed(user, pred)

	if(pred == user) //you click yourself
		if(!is_vore_predator(src))
			to_chat(user, "<span class='notice'>You aren't voracious enough.</span>")
			return
		feed_grabbed_to_self(user, prey)

	else // click someone other than you/prey
		if(!pred.feeding)
			to_chat(user, "<span class='notice'>They aren't voracious enough to be fed.</span>")
			to_chat(pred, "<span class='notice'>[user] tried to feed you [prey], but you aren't voracious enough to be fed.</span>")
			return
		if(!prey.feeding)
			to_chat(user, "<span class='notice'>They aren't able to be fed to someone.</span>")
			to_chat(prey, "<span class='notice'>[user] tried to feed you to [pred], but you aren't able to be fed to them.</span>")
			return
		if(!is_vore_predator(pred))
			to_chat(user, "<span class='notice'>They aren't voracious enough.</span>")
			return
		feed_grabbed_to_other(user, prey, pred)
//
// Eating procs depending on who clicked what
//
/mob/living/proc/feed_grabbed_to_self(var/mob/living/user, var/mob/living/prey)
	var/belly = user.vore_selected
	return perform_the_nom(user, prey, user, belly)

/mob/living/proc/feed_self_to_grabbed(var/mob/living/user, var/mob/living/pred)
	var/belly = input("Choose Belly") in pred.vore_organs
	return perform_the_nom(user, user, pred, belly)

/mob/living/proc/feed_grabbed_to_other(var/mob/living/user, var/mob/living/prey, var/mob/living/pred)
	var/belly = input("Choose Belly") in pred.vore_organs
	return perform_the_nom(user, prey, pred, belly)

//
// Master vore proc that actually does vore procedures
//

/mob/living/proc/perform_the_nom(var/mob/living/user, var/mob/living/prey, var/mob/living/pred, var/obj/belly/belly, var/delay)
	//Sanity
	if(!user || !prey || !pred || !istype(belly) || !(belly in pred.vore_organs))
		testing("[user] attempted to feed [prey] to [pred], via [lowertext(belly.name)] but it went wrong.")
		return FALSE

	if (!prey.devourable)
		to_chat(user, "This can't be eaten!")
		return FALSE

	// The belly selected at the time of noms
	var/attempt_msg = "ERROR: Vore message couldn't be created. Notify a dev. (at)"
	var/success_msg = "ERROR: Vore message couldn't be created. Notify a dev. (sc)"

	// Prepare messages
	if(user == pred) //Feeding someone to yourself
		attempt_msg = text("<span class='warning'>[] is attemping to [] [] into their []!</span>",pred,lowertext(belly.vore_verb),prey,lowertext(belly.name))
		success_msg = text("<span class='warning'>[] manages to [] [] into their []!</span>",pred,lowertext(belly.vore_verb),prey,lowertext(belly.name))
	else //Feeding someone to another person
		attempt_msg = text("<span class='warning'>[] is attempting to make [] [] [] into their []!</span>",user,pred,lowertext(belly.vore_verb),prey,lowertext(belly.name))
		success_msg = text("<span class='warning'>[] manages to make [] [] [] into their []!</span>",user,pred,lowertext(belly.vore_verb),prey,lowertext(belly.name))

	if(!prey.Adjacent(user)) // let's not even bother attempting it yet if they aren't next to us.
		return FALSE

	// Announce that we start the attempt!
	user.visible_message(attempt_msg)

	// Now give the prey time to escape... return if they did
	var/swallow_time = delay || ishuman(prey) ? belly.human_prey_swallow_time : belly.nonhuman_prey_swallow_time

	if(!do_mob(src, user, swallow_time))
		return FALSE // Prey escaped (or user disabled) before timer expired.

	if(!prey.Adjacent(user)) //double check'd just in case they moved during the timer and the do_mob didn't fail for whatever reason
		return FALSE

	// If we got this far, nom successful! Announce it!
	user.visible_message(success_msg)

	// Actually shove prey into the belly.
	belly.nom_mob(prey, user)
	stop_pulling()

	// Flavor handling
	if(belly.can_taste && prey.get_taste_message(FALSE))
		to_chat(belly.owner, "<span class='notice'>[prey] tastes of [prey.get_taste_message(FALSE)].</span>")

	// Inform Admins
	var/prey_braindead
	var/prey_stat
	if(prey.ckey)
		prey_stat = prey.stat//only return this if they're not an unmonkey or whatever
		if(!prey.client)//if they disconnected, tell us
			prey_braindead = 1
	if (pred == user)
		message_admins("[ADMIN_LOOKUPFLW(pred)] ate [ADMIN_LOOKUPFLW(prey)][!prey_braindead ? "" : " (BRAINDEAD)"][prey_stat ? " (DEAD/UNCONSCIOUS)" : ""].")
		pred.log_message("[key_name(pred)] ate [key_name(prey)].", LOG_ATTACK)
		prey.log_message("[key_name(prey)] was eaten by [key_name(pred)].", LOG_ATTACK)
	else
		message_admins("[ADMIN_LOOKUPFLW(user)] forced [ADMIN_LOOKUPFLW(pred)] to eat [ADMIN_LOOKUPFLW(prey)].")
		user.log_message("[key_name(user)] forced [key_name(pred)] to eat [key_name(prey)].", LOG_ATTACK)
		pred.log_message("[key_name(user)] forced [key_name(pred)] to eat [key_name(prey)].", LOG_ATTACK)
		prey.log_message("[key_name(user)] forced [key_name(pred)] to eat [key_name(prey)].", LOG_ATTACK)
	return TRUE

//
//End vore code.


//
// Our custom resist catches for /mob/living
//
/mob/living/proc/vore_process_resist()

	//Are we resisting from inside a belly?
	if(isbelly(loc))
		var/obj/belly/B = loc
		B.relay_resist(src)
		return TRUE //resist() on living does this TRUE thing.

	//Other overridden resists go here

	return 0

// internal slimy button in case the loop stops playing but the player wants to hear it
/mob/living/proc/preyloop_refresh()
	set name = "Internal loop refresh"
	set category = "Vore"
	if(isbelly(loc))
		src.stop_sound_channel(CHANNEL_PREYLOOP) // sanity just in case
		var/sound/preyloop = sound('sound/vore/prey/loop.ogg', repeat = TRUE)
		SEND_SOUND(src, preyloop)
	else
		to_chat(src, "<span class='alert'>You aren't inside anything, you clod.</span>")

// OOC Escape code for pref-breaking or AFK preds
//
/mob/living/proc/escapeOOC()
	set name = "OOC Escape"
	set category = "Vore"

	//You're in a belly!
	if(isbelly(loc))
		var/obj/belly/B = loc
		var/confirm = alert(src, "You're in a mob. If you're otherwise unable to escape from a pred AFK for a long time, use this.", "Confirmation", "Okay", "Cancel")
		if(!confirm == "Okay" || loc != B)
			return
		//Actual escaping
		B.release_specific_contents(src,TRUE) //we might as well take advantage of that specific belly's handling. Else we stay blinded forever.
		src.stop_sound_channel(CHANNEL_PREYLOOP)
		SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "fedprey", /datum/mood_event/fedprey)
		for(var/mob/living/simple_animal/SA in range(10))
			SA.prey_excludes[src] = world.time

		if(isanimal(B.owner))
			var/mob/living/simple_animal/SA = B.owner
			SA.update_icons()

	//You're in a dogborg!
	else if(istype(loc, /obj/item/dogborg/sleeper))
		var/obj/item/dogborg/sleeper/belly = loc //The belly!

		var/confirm = alert(src, "You're in a dogborg sleeper. This is for escaping from preference-breaking or if your predator disconnects/AFKs. You can also resist out naturally too.", "Confirmation", "Okay", "Cancel")
		if(!confirm == "Okay" || loc != belly)
			return
		//Actual escaping
		belly.go_out(src) //Just force-ejects from the borg as if they'd clicked the eject button.
	else
		to_chat(src,"<span class='alert'>You aren't inside anyone, though, is the thing.</span>")

//
//	Verb for saving vore preferences to save file
//
/mob/living/proc/save_vore_prefs()
	if(!client || !client.prefs_vr)
		return 0
	if(!copy_to_prefs_vr())
		return 0
	if(!client.prefs_vr.save_vore())
		return 0

	return 1

/mob/living/proc/apply_vore_prefs()
	if(!client || !client.prefs_vr)
		return 0
	if(!client.prefs_vr.load_vore())
		return 0
	if(!copy_from_prefs_vr())
		return 0

	return 1

/mob/living/proc/copy_to_prefs_vr()
	if(!client || !client.prefs_vr)
		to_chat(src,"<span class='warning'>You attempted to save your vore prefs but somehow you're in this character without a client.prefs_vr variable. Tell a dev.</span>")
		return 0

	var/datum/vore_preferences/P = client.prefs_vr

	P.digestable = src.digestable
	P.devourable = src.devourable
	P.feeding = src.feeding
	P.vore_taste = src.vore_taste

	var/list/serialized = list()
	for(var/belly in src.vore_organs)
		var/obj/belly/B = belly
		serialized += list(B.serialize()) //Can't add a list as an object to another list in Byond. Thanks.

	P.belly_prefs = serialized

	return 1

//
//	Proc for applying vore preferences, given bellies
//
/mob/living/proc/copy_from_prefs_vr()
	if(!client || !client.prefs_vr)
		to_chat(src,"<span class='warning'>You attempted to apply your vore prefs but somehow you're in this character without a client.prefs_vr variable. Tell a dev.</span>")
		return 0
	vorepref_init = TRUE

	var/datum/vore_preferences/P = client.prefs_vr

	digestable = P.digestable
	devourable = P.devourable
	feeding = P.feeding
	vore_taste = P.vore_taste

	release_vore_contents(silent = TRUE)
	vore_organs.Cut()
	for(var/entry in P.belly_prefs)
		list_to_object(entry,src)

	return 1

//
// Release everything in every vore organ
//
/mob/living/proc/release_vore_contents(var/include_absorbed = TRUE, var/silent = FALSE)
	for(var/belly in vore_organs)
		var/obj/belly/B = belly
		B.release_all_contents(include_absorbed, silent)

//
// Returns examine messages for bellies
//
/mob/living/proc/examine_bellies()
	if(!show_pudge()) //Some clothing or equipment can hide this.
		return ""

	var/message = ""
	for (var/belly in vore_organs)
		var/obj/belly/B = belly
		message += B.get_examine_msg()

	return message

//
// Whether or not people can see our belly messages
//
/mob/living/proc/show_pudge()
	return TRUE //Can override if you want.

/mob/living/carbon/human/show_pudge()
	//A uniform could hide it.
	if(istype(w_uniform,/obj/item/clothing))
		var/obj/item/clothing/under = w_uniform
		if(under.hides_bulges)
			return FALSE

	//We return as soon as we find one, no need for 'else' really.
	if(istype(wear_suit,/obj/item/clothing))
		var/obj/item/clothing/suit = wear_suit
		if(suit.hides_bulges)
			return FALSE


	return ..()

//
// Clearly super important. Obviously.
//
/mob/living/proc/lick(var/mob/living/tasted in oview(1))
	set name = "Lick Someone"
	set category = "Vore"
	set desc = "Lick someone nearby!"

	if(!istype(tasted))
		return

	if(src == stat)
		return

	src.setClickCooldown(100)

	src.visible_message("<span class='warning'>[src] licks [tasted]!</span>","<span class='notice'>You lick [tasted]. They taste rather like [tasted.get_taste_message()].</span>","<b>Slurp!</b>")


/mob/living/proc/get_taste_message(allow_generic = TRUE, datum/species/mrace)
	if(!vore_taste && !allow_generic)
		return FALSE

	var/taste_message = ""
	if(vore_taste && (vore_taste != ""))
		taste_message += "[vore_taste]"
	else
		if(ishuman(src))
			taste_message += "they haven't bothered to set their flavor text"
		else
			taste_message += "a plain old normal [src]"

/*	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.touching.reagent_list.len) //Just the first one otherwise I'll go insane.
			var/datum/reagent/R = H.touching.reagent_list[1]
			taste_message += " You also get the flavor of [R.taste_description] from something on them"*/
	return taste_message

/obj/item
	var/trash_eatable = TRUE

/mob/living/proc/eat_trash()
	set name = "Eat Trash"
	set category = "Vore"	//No Abilities?
	set desc = "Consume held garbage."
	
	if(!vore_selected)
		to_chat(src,"<span class='warning'>You either don't have a belly selected, or don't have a belly!</span>")
		return

	var/obj/item/I = get_active_held_item()
	if(!I)
		to_chat(src, "<span class='notice'>You are not holding anything.</span>")
		return

	if(is_type_in_list(I,item_vore_blacklist) && !adminbus_trash) //If someone has adminbus, they can eat whatever they want.
		to_chat(src, "<span class='warning'>You are not allowed to eat this.</span>")
		return

	if(!I.trash_eatable) //OOC pref. This /IS/ respected, even if adminbus_trash is enabled
		to_chat(src, "<span class='warning'>You can't eat that so casually!</span>")
		return

	if(istype(I, /obj/item/paicard))
		var/obj/item/paicard/palcard = I
		var/mob/living/silicon/pai/pocketpal = palcard.pai
		if(pocketpal && (!pocketpal.devourable))
			to_chat(src, "<span class='warning'>\The [pocketpal] doesn't allow you to eat it.</span>")
			return

	if(is_type_in_list(I,edible_trash) | adminbus_trash /*|| is_type_in_list(I,edible_tech) && isSynthetic()*/)
		/*
		if(I.hidden_uplink)
			to_chat(src, "<span class='warning'>You really should not be eating this.</span>")
			message_admins("[key_name(src)] has attempted to ingest an uplink item. ([src ? ADMIN_JMP(src) : "null"])")
			return
		*/
		if(istype(I,/obj/item/pda))
			var/obj/item/pda/P = I
			if(P.owner)
				var/watching = FALSE
				for(var/mob/living/carbon/human/H in view(src))
					if(H.real_name == P.owner && H.client)
						watching = TRUE
						break
				if(!watching)
					return
				else
					visible_message("<span class='warning'>[src] is threatening to make [P] disappear!</span>")
					if(P.id)
						var/confirm = alert(src, "The PDA you're holding contains a vulnerable ID card. Will you risk it?", "Confirmation", "Definitely", "Cancel") //No tgui input?
						if(confirm != "Definitely")
							return
					if(!do_after(src, 100, P))
						return
					visible_message("<span class='warning'>[src] successfully makes [P] disappear!</span>")
			to_chat(src, "<span class='notice'>You can taste the sweet flavor of delicious technology.</span>")
			dropItemToGround(I)
			I.forceMove(vore_selected)
			updateVRPanel()
			return
		/*
		if(istype(I,/obj/item/clothing/shoes))
			var/obj/item/clothing/shoes/S = I
			if(S.holding)
				to_chat(src, "<span class='warning'>There's something inside!</span>")
				return
		*/
		/*
		if(iscapturecrystal(I))
			var/obj/item/capture_crystal/C = I
			if(!C.bound_mob.devourable)
				to_chat(src, "<span class='warning'>That doesn't seem like a good idea. (\The [C.bound_mob]'s prefs don't allow it.)</span>")
				return
		*/
		dropItemToGround(I)
		I.forceMove(vore_selected)
		updateVRPanel()

		log_admin("VORE: [src] used Eat Trash to swallow [I].")

		if(istype(I,/obj/item/flashlight/flare) || istype(I,/obj/item/match) || istype(I,/obj/item/storage/box/matches))
			to_chat(src, "<span class='notice'>You can taste the flavor of spicy cardboard.</span>")
		else if(istype(I,/obj/item/flashlight/glowstick)) //Repath from /obj/item/device/flashlight/glowstick
			to_chat(src, "<span class='notice'>You found out the glowy juice only tastes like regret.</span>")
		else if(istype(I,/obj/item/cigbutt)) //Repath from /obj/item/trash/cigbutt
			to_chat(src, "<span class='notice'>You can taste the flavor of bitter ash. Classy.</span>")
		else if(istype(I,/obj/item/clothing/mask/cigarette)) //Repath from /obj/item/clothing/mask/smokable
			var/obj/item/clothing/mask/cigarette/C = I
			if(C.lit)
				to_chat(src, "<span class='notice'>You can taste the flavor of burning ash. Spicy!</span>")
			else
				to_chat(src, "<span class='notice'>You can taste the flavor of aromatic rolling paper and funny looks.</span>")
		else if(istype(I,/obj/item/paper)) //Repath from /obj/item/weapon/paper
			to_chat(src, "<span class='notice'>You can taste the dry flavor of bureaucracy.</span>")
		else if(istype(I,/obj/item/dice)) //Repath from /obj/item/weapon/dice
			to_chat(src, "<span class='notice'>You can taste the bitter flavor of cheating.</span>")
		else if(istype(I,/obj/item/lipstick)) //Repath from /obj/item/weapon/lipstick
			to_chat(src, "<span class='notice'>You can taste the flavor of couture and style. Toddler at the make-up bag style.</span>")
		else if(istype(I,/obj/item/soap)) //Repath from /obj/item/weapon/soap
			to_chat(src, "<span class='notice'>You can taste the bitter flavor of verbal purification.</span>")
		else if(istype(I,/obj/item/stack/spacecash) || istype(I,/obj/item/storage/wallet)) //Repath from /obj/item/weapon/spacecash and /obj/item/weapon/storage/wallet
			to_chat(src, "<span class='notice'>You can taste the flavor of wealth and reckless waste.</span>")
		else if(istype(I,/obj/item/broken_bottle) || istype(I,/obj/item/shard)) //Repath from /obj/item/weapon/broken_bottle
			to_chat(src, "<span class='notice'>You can taste the flavor of pain. This can't possibly be healthy for your guts.</span>")
		else if(istype(I,/obj/item/light)) //Repath from /obj/item/weapon/light
			var/obj/item/light/L = I
			if(L.status == LIGHT_BROKEN)
				to_chat(src, "<span class='notice'>You can taste the flavor of pain. This can't possibly be healthy for your guts.</span>")
			else
				to_chat(src, "<span class='notice'>You can taste the flavor of really bad ideas.</span>")
		/*
		else if(istype(I,/obj/item/weapon/bikehorn/tinytether)) //Doenst exist
			to_chat(src, "<span class='notice'>You feel a rush of power swallowing such a large, err, tiny structure.</span>")
		*/
		else if(istype(I,/obj/item/mmi/posibrain) || istype(I,/obj/item/aicard)) //Repath from /obj/item/device/mmi/digital/posibrain and //Repath from /obj/item/device/aicard
			to_chat(src, "<span class='notice'>You can taste the sweet flavor of digital friendship. Or maybe it is something else.</span>")
		else if(istype(I,/obj/item/paicard)) //Repath from /obj/item/device/paicard
			to_chat(src, "<span class='notice'>You can taste the sweet flavor of digital friendship.</span>")
			var/obj/item/paicard/ourcard = I
			if(ourcard.pai && ourcard.pai.client && isbelly(ourcard.loc))
				var/obj/belly/B = ourcard.loc
				to_chat(ourcard.pai, "<span class= 'notice'><B>[B.desc]</B></span>")
		else if(istype(I,/obj/item/reagent_containers/food)) //Repath from /obj/item/weapon/reagent_containers/food
			var/obj/item/reagent_containers/food/F = I
			if(!F.reagents.total_volume)
				to_chat(src, "<span class='notice'>You can taste the flavor of garbage and leftovers. Delicious?</span>")
			else
				to_chat(src, "<span class='notice'>You can taste the flavor of gluttonous waste of food.</span>")
		else if (istype(I,/obj/item/clothing/neck/petcollar))
			to_chat(src, "<span class='notice'>You can taste the submissiveness in the wearer of [I]!</span>")
		/*
		else if(iscapturecrystal(I))
			var/obj/item/capture_crystal/C = I
			if(C.bound_mob && (C.bound_mob in C.contents))
				if(isbelly(C.loc))
					//var/obj/belly/B = C.loc //CHOMPedit
					//to_chat(C.bound_mob, "<span class= 'notice'>Outside of your crystal, you can see; <B>[B.desc]</B></span>") //CHOMPedit: moved to modular_chomp capture_crystal.dm
					to_chat(src, "<span class='notice'>You can taste the the power of command.</span>")
		*/
		// CHOMPedit begin
		/*
		else if(istype(I,/obj/item/starcaster_news))
			to_chat(src, "<span class='notice'>You can taste the dry flavor of digital garbage, oh wait its just the news.</span>")
		*/
		else if(istype(I,/obj/item/newspaper))
			to_chat(src, "<span class='notice'>You can taste the dry flavor of garbage, oh wait its just the news.</span>")
		else if (istype(I,/obj/item/stock_parts/cell))
			visible_message("<span class='warning'>[src] sates their electric appetite with a [I]!</span>")
			to_chat(src, "<span class='notice'>You can taste the spicy flavor of electrolytes, yum.</span>")
		/*
		else if (istype(I,/obj/item/walkpod))
			visible_message("<span class='warning'>[src] sates their musical appetite with a [I]!</span>")
			to_chat(src, "<span class='notice'>You can taste the jazzy flavor of music.</span>")
		*/
		/*
		else if (istype(I,/obj/item/mail/junkmail))
			visible_message("<span class='warning'>[src] devours the [I]!</span>")
			to_chat(src, "<span class='notice'>You can taste the flavor of the galactic postal service.</span>")
		*/
		/*
		else if (istype(I,/obj/item/weapon/gun/energy/sizegun))
			visible_message("<span class='warning'>[src] devours the [I]!</span>")
			to_chat(src, "<span class='notice'>You didn't read the warning label, did you?</span>")
		*/
		/*
		else if (istype(I,/obj/item/device/slow_sizegun))
			visible_message("<span class='warning'>[src] devours the [I]!</span>")
			to_chat(src, "<span class='notice'>You taste the flavor of sunday driver bluespace.</span>")
		*/
		else if (istype(I,/obj/item/laser_pointer))
			visible_message("<span class='warning'>[src] devours the [I]!</span>")
			to_chat(src, "<span class='notice'>You taste the flavor of a laser.</span>")
		else if (istype(I,/obj/item/canvas))
			visible_message("<span class='warning'>[src] devours the [I]!</span>")
			to_chat(src, "<span class='notice'>You taste the flavor of priceless artwork.</span>")
		//CHOMPedit end

		else
			to_chat(src, "<span class='notice'>You can taste the flavor of garbage. Delicious.</span>")
		visible_message("<span class='warning'>[src] demonstrates their voracious capabilities by swallowing [I] whole!</span>")
		return
	to_chat(src, "<span class='notice'>This snack is too powerful to go down that easily.</span>") //CHOMPEdit
	return
