//If someone can do this in a neater way, be my guest-Kor

//To do: Allow corpses to appear mangled, bloody, etc. Allow customizing the bodies appearance (they're all bald and white right now).

/obj/effect/mob_spawn
	name = "Unknown"
	density = TRUE
	anchored = TRUE
	var/job_description = null
	var/mob_type = null
	var/mob_name = ""
	var/mob_gender = null
	var/death = TRUE //Kill the mob
	var/roundstart = TRUE //fires on initialize
	var/instant = FALSE	//fires on New
	var/short_desc = "The mapper forgot to set this!"
	var/flavour_text = ""
	var/important_info = ""
	var/faction = null
	var/permanent = FALSE	//If true, the spawner will not disappear upon running out of uses.
	var/random = FALSE		//Don't set a name or gender, just go random
	var/objectives = null
	var/uses = 1			//how many times can we spawn from it. set to -1 for infinite.
	var/brute_damage = 0
	var/oxy_damage = 0
	var/burn_damage = 0
	var/datum/disease/disease = null //Do they start with a pre-spawned disease?
	var/mob_color //Change the mob's color
	var/assignedrole
	var/show_flavour = TRUE
	var/banType = "lavaland"
	var/ghost_usable = TRUE

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/effect/mob_spawn/attack_ghost(mob/user, latejoinercalling)
	if(!SSticker.HasRoundStarted() || !loc || !ghost_usable)
		return
	if(!uses)
		to_chat(user, "<span class='warning'>This spawner is out of charges!</span>")
		return
	if(jobban_isbanned(user, banType))
		to_chat(user, "<span class='warning'>You are jobanned!</span>")
		return
	if(QDELETED(src) || QDELETED(user))
		return
	if(isobserver(user))
		var/mob/dead/observer/O = user
		if(!O.can_reenter_round)
			to_chat(user, "<span class='warning'>You are unable to reenter the round.</span>")
			return
	var/ghost_role = alert(latejoinercalling ? "Latejoin as [mob_name]? (This is a ghost role, and as such, it's very likely to be off-station.)" : "Become [mob_name]? (Warning, You can no longer be cloned!)",,"Yes","No")
	if(ghost_role == "No" || !loc)
		return
	if(QDELETED(src) || QDELETED(user))
		return
	if(latejoinercalling)
		var/mob/dead/new_player/NP = user
		if(istype(NP))
			NP.close_spawn_windows()
			NP.stop_sound_channel(CHANNEL_LOBBYMUSIC)
	log_game("[key_name(user)] became [mob_name]")
	create(ckey = user.ckey)
	return TRUE

/obj/effect/mob_spawn/Initialize(mapload)
	. = ..()
	if(instant || (roundstart && (mapload || (SSticker && SSticker.current_state > GAME_STATE_SETTING_UP))))
		create()
	else if(ghost_usable)
		GLOB.poi_list |= src
		LAZYADD(GLOB.mob_spawners[job_description ? job_description : name], src)


/obj/effect/mob_spawn/Destroy()
	GLOB.poi_list -= src
	var/job_name = job_description ? job_description : name
	LAZYREMOVE(GLOB.mob_spawners[job_name], src)
	if(!LAZYLEN(GLOB.mob_spawners[job_name]))
		GLOB.mob_spawners -= job_name
	return ..()

/obj/effect/mob_spawn/proc/can_latejoin() //If it can be taken from the lobby.
	return ghost_usable

/obj/effect/mob_spawn/proc/special(mob/M)
	return

/obj/effect/mob_spawn/proc/equip(mob/M)
	return

/obj/effect/mob_spawn/proc/delayusability(deciseconds, showOnMenu) //How many deciseconds until it is enabled, + should it show up on the menu?
	addtimer(CALLBACK(src,PROC_REF(enableghostrole), showOnMenu), deciseconds)
	
/obj/effect/mob_spawn/proc/enableghostrole(show)
	ghost_usable = TRUE
	if (show == TRUE)
		GLOB.poi_list |= src
		LAZYADD(GLOB.mob_spawners[job_description ? job_description : name], src)

/obj/effect/mob_spawn/proc/create(ckey, name)
	var/mob/living/M = new mob_type(get_turf(src)) //living mobs only
	if(!random)
		M.real_name = mob_name ? mob_name : M.name
		if(!mob_gender)
			mob_gender = pick(MALE, FEMALE)
		M.gender = mob_gender
	if(faction)
		M.faction = list(faction)
	if(disease)
		M.ForceContractDisease(new disease)
	if(death)
		M.death(1) //Kills the new mob

	M.adjustOxyLoss(oxy_damage)
	M.adjustBruteLoss(brute_damage)
	M.adjustFireLoss(burn_damage)
	M.color = mob_color
	equip(M)

	if(ckey)
		M.ckey = ckey
		if(show_flavour)
			var/output_message = "<span class='big bold'>[short_desc]</span>"
			if(flavour_text != "")
				output_message += "\n<span class='bold'>[flavour_text]</span>"
			if(important_info != "")
				output_message += "\n<span class='userdanger'>[important_info]</span>"
			to_chat(M, output_message)
		var/datum/mind/MM = M.mind
		if(objectives)
			for(var/objective in objectives)
				MM.objectives += new/datum/objective(objective)
		if(assignedrole)
			M.mind.assigned_role = assignedrole
		special(M, name)
		MM.name = M.real_name
		M.checkloadappearance()
	if(uses > 0)
		uses--
	if(!permanent && !uses)
		qdel(src)

// Base version - place these on maps/templates.
/obj/effect/mob_spawn/human
	mob_type = /mob/living/carbon/human
	//Human specific stuff.
	var/mob_species = null		//Set to make them a mutant race such as lizard or skeleton. Uses the datum typepath instead of the ID.
	var/datum/outfit/outfit = /datum/outfit	//If this is a path, it will be instanced in Initialize()
	var/disable_pda = TRUE
	var/disable_sensors = TRUE
	//All of these only affect the ID that the outfit has placed in the ID slot
	var/id_job = null			//Such as "Clown" or "Chef." This just determines what the ID reads as, not their access
	var/id_access = null		//This is for access. See access.dm for which jobs give what access. Use "Captain" if you want it to be all access.
	var/id_access_list = null	//Allows you to manually add access to an ID card.
	assignedrole = "Ghost Role"

	var/husk = null
	//these vars are for lazy mappers to override parts of the outfit
	//these cannot be null by default, or mappers cannot set them to null if they want nothing in that slot
	var/uniform = -1
	var/r_hand = -1
	var/l_hand = -1
	var/suit = -1
	var/shoes = -1
	var/gloves = -1
	var/ears = -1
	var/glasses = -1
	var/mask = -1
	var/head = -1
	var/belt = -1
	var/r_pocket = -1
	var/l_pocket = -1
	var/back = -1
	var/id = -1
	var/neck = -1
	var/backpack_contents = -1
	var/suit_store = -1

	var/hair_style
	var/facial_hair_style
	var/skin_tone
	var/mirrorcanloadappearance = FALSE

/obj/effect/mob_spawn/human/Initialize()
	if(ispath(outfit))
		outfit = new outfit()
	if(!outfit)
		outfit = new /datum/outfit
	return ..()

/obj/effect/mob_spawn/human/equip(mob/living/carbon/human/H)
	if(mob_species)
		H.set_species(mob_species)
	if(husk)
		H.Drain()
	else //Because for some reason I can't track down, things are getting turned into husks even if husk = false. It's in some damage proc somewhere.
		H.cure_husk()
	H.underwear = "Nude"
	H.undershirt = "Nude"
	H.socks = "Nude"
	if(hair_style)
		H.hair_style = hair_style
	else
		H.hair_style = random_hair_style(gender)
	if(facial_hair_style)
		H.facial_hair_style = facial_hair_style
	else
		H.facial_hair_style = random_facial_hair_style(gender)
	if(skin_tone)
		H.skin_tone = skin_tone
	else
		H.skin_tone = random_skin_tone()
	H.update_hair()
	H.update_body()
	if(outfit)
		var/static/list/slots = list("uniform", "r_hand", "l_hand", "suit", "shoes", "gloves", "ears", "glasses", "mask", "head", "belt", "r_pocket", "l_pocket", "back", "id", "neck", "backpack_contents", "suit_store")
		for(var/slot in slots)
			var/T = vars[slot]
			if(!isnum(T))
				outfit.vars[slot] = T
		H.equipOutfit(outfit)
		if(disable_pda)
			// We don't want corpse PDAs to show up in the messenger list.
			var/obj/item/pda/PDA = locate(/obj/item/pda) in H
			if(PDA)
				PDA.toff = TRUE
		if(disable_sensors)
			// Using crew monitors to find corpses while creative makes finding certain ruins too easy.
			var/obj/item/clothing/under/C = H.w_uniform
			if(istype(C))
				C.sensor_mode = NO_SENSORS

	var/obj/item/card/id/W = H.wear_id
	if(W)
		if(id_access)
			for(var/jobtype in typesof(/datum/job))
				var/datum/job/J = new jobtype
				if(J.title == id_access)
					W.access = J.get_access()
					break
		if(id_access_list)
			if(!islist(W.access))
				W.access = list()
			W.access |= id_access_list
		if(id_job)
			W.assignment = id_job
		W.registered_name = H.real_name
		W.update_label()
	if (mirrorcanloadappearance)
		H.mirrorcanloadappearance = TRUE

//Instant version - use when spawning corpses during runtime
/obj/effect/mob_spawn/human/corpse
	roundstart = FALSE
	instant = TRUE

/obj/effect/mob_spawn/human/corpse/damaged
	brute_damage = 1000

/obj/effect/mob_spawn/human/alive
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	death = FALSE
	roundstart = FALSE //you could use these for alive fake humans on roundstart but this is more common scenario

/obj/effect/mob_spawn/human/corpse/delayed
	ghost_usable = FALSE //These are just not-yet-set corpses.
	instant = FALSE

//Non-human spawners

/obj/effect/mob_spawn/AICorpse/create() //Creates a corrupted AI
	var/A = locate(/mob/living/silicon/ai) in loc
	if(A)
		return
	var/mob/living/silicon/ai/spawned/M = new(loc) //spawn new AI at landmark as var M
	M.name = src.name
	M.real_name = src.name
	M.aiPDA.toff = TRUE //turns the AI's PDA messenger off, stopping it showing up on player PDAs
	M.death() //call the AI's death proc
	qdel(src)

/obj/effect/mob_spawn/slime
	mob_type = 	/mob/living/simple_animal/slime
	var/mobcolour = "grey"
	icon = 'icons/mob/slimes.dmi'
	icon_state = "grey baby slime" //sets the icon in the map editor

/obj/effect/mob_spawn/slime/equip(mob/living/simple_animal/slime/S)
	S.colour = mobcolour

/obj/effect/mob_spawn/human/facehugger/create() //Creates a squashed facehugger
	var/obj/item/clothing/mask/facehugger/O = new(src.loc) //variable O is a new facehugger at the location of the landmark
	O.name = src.name
	O.Die() //call the facehugger's death proc
	qdel(src)

/obj/effect/mob_spawn/mouse
	name = "sleeper"
	mob_type = 	/mob/living/simple_animal/mouse
	death = FALSE
	roundstart = FALSE
	job_description = "Mouse"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/cow
	name = "sleeper"
	mob_type = 	/mob/living/simple_animal/cow
	death = FALSE
	roundstart = FALSE
	job_description = "Cow"
	mob_gender = FEMALE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

// I'll work on making a list of corpses people request for maps, or that I think will be commonly used. Syndicate operatives for example.

///////////Civilians//////////////////////

/obj/effect/mob_spawn/human/corpse/assistant
	name = "Assistant"
	outfit = /datum/outfit/job/assistant

/obj/effect/mob_spawn/human/corpse/assistant/beesease_infection
	disease = /datum/disease/beesease

/obj/effect/mob_spawn/human/corpse/assistant/brainrot_infection
	disease = /datum/disease/brainrot

/obj/effect/mob_spawn/human/corpse/assistant/spanishflu_infection
	disease = /datum/disease/fluspanish

/obj/effect/mob_spawn/human/corpse/cargo_tech
	name = "Cargo Tech"
	outfit = /datum/outfit/job/cargo_tech

/obj/effect/mob_spawn/human/cook
	name = "Cook"
	outfit = /datum/outfit/job/cook


/obj/effect/mob_spawn/human/doctor
	name = "Doctor"
	outfit = /datum/outfit/job/doctor


/obj/effect/mob_spawn/human/doctor/alive
	death = FALSE
	roundstart = FALSE
	random = TRUE
	name = "sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	short_desc = "You are a space doctor!"
	assignedrole = "Space Doctor"
	job_description = "Off-station Doctor"

/obj/effect/mob_spawn/human/doctor/alive/equip(mob/living/carbon/human/H)
	..()
	// Remove radio and PDA so they wouldn't annoy station crew.
	var/list/del_types = list(/obj/item/pda, /obj/item/radio/headset)
	for(var/del_type in del_types)
		var/obj/item/I = locate(del_type) in H
		qdel(I)

/obj/effect/mob_spawn/human/engineer
	name = "Engineer"
	outfit = /datum/outfit/job/engineer/gloved

/obj/effect/mob_spawn/human/engineer/rig
	outfit = /datum/outfit/job/engineer/gloved/rig

/obj/effect/mob_spawn/human/clown
	name = "Clown"
	outfit = /datum/outfit/job/clown

/obj/effect/mob_spawn/human/scientist
	name = "Scientist"
	outfit = /datum/outfit/job/scientist

/obj/effect/mob_spawn/human/miner
	name = "Shaft Miner"
	outfit = /datum/outfit/job/miner

/obj/effect/mob_spawn/human/miner/rig
	outfit = /datum/outfit/job/miner/equipped/hardsuit

/obj/effect/mob_spawn/human/miner/explorer
	outfit = /datum/outfit/job/miner/equipped


/obj/effect/mob_spawn/human/plasmaman
	mob_species = /datum/species/plasmaman
	outfit = /datum/outfit/plasmaman


/obj/effect/mob_spawn/human/bartender
	name = "Space Bartender"
	id_job = "Bartender"
	id_access_list = list(ACCESS_BAR)
	outfit = /datum/outfit/spacebartender

/obj/effect/mob_spawn/human/bartender/alive
	death = FALSE
	roundstart = FALSE
	random = TRUE
	job_description = "Off-station Bartender"
	name = "bartender sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	short_desc = "You are a space bartender!"
	flavour_text = "Time to mix drinks and change lives. Smoking space drugs makes it easier to understand your patrons' odd dialect."
	assignedrole = "Space Bartender"
	id_job = "Bartender"
	mirrorcanloadappearance = TRUE

/datum/outfit/spacebartender
	name = "Space Bartender"
	uniform = /obj/item/clothing/under/rank/bartender
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/sneakers/black
	suit = /obj/item/clothing/suit/armor/vest
	glasses = /obj/item/clothing/glasses/sunglasses/reagent
	id = /obj/item/card/id

/obj/effect/mob_spawn/human/beach
	outfit = /datum/outfit/beachbum
	mirrorcanloadappearance = TRUE

/obj/effect/mob_spawn/human/beach/alive
	death = FALSE
	roundstart = FALSE
	random = TRUE
	job_description = "Beach Biodome Bum"
	mob_name = "Beach Bum"
	name = "beach bum sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	short_desc = "You're a spunky lifeguard!"
	flavour_text = "It's up to you to make sure nobody drowns or gets eaten by sharks and stuff."
	assignedrole = "Beach Bum"

/obj/effect/mob_spawn/human/beach/alive/lifeguard
	flavour_text = "<span class='big bold'>You're a spunky lifeguard!</span><b> It's up to you to make sure nobody drowns or gets eaten by sharks and stuff.</b>"
	mob_gender = "female"
	name = "lifeguard sleeper"
	id_job = "Lifeguard"
	job_description = "Beach Biodome Lifeguard"
	uniform = /obj/item/clothing/under/shorts/red

/datum/outfit/beachbum
	name = "Beach Bum"
	glasses = /obj/item/clothing/glasses/sunglasses
	r_pocket = /obj/item/storage/wallet/random
	l_pocket = /obj/item/reagent_containers/food/snacks/pizzaslice/dank;
	uniform = /obj/item/clothing/under/pants/youngfolksjeans
	id = /obj/item/card/id

/datum/outfit/beachbum/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.dna.add_mutation(STONER)

/////////////////Officers+Nanotrasen Security//////////////////////

/obj/effect/mob_spawn/human/bridgeofficer
	name = "Bridge Officer"
	id_job = "Bridge Officer"
	id_access_list = list(ACCESS_CENT_CAPTAIN)
	outfit = /datum/outfit/nanotrasenbridgeofficercorpse

/datum/outfit/nanotrasenbridgeofficercorpse
	name = "Bridge Officer Corpse"
	ears = /obj/item/radio/headset/heads/hop
	uniform = /obj/item/clothing/under/rank/centcom_officer
	suit = /obj/item/clothing/suit/armor/bulletproof
	shoes = /obj/item/clothing/shoes/sneakers/black
	glasses = /obj/item/clothing/glasses/sunglasses
	id = /obj/item/card/id


/obj/effect/mob_spawn/human/commander
	name = "Commander"
	id_job = "Commander"
	id_access_list = list(ACCESS_CENT_CAPTAIN, ACCESS_CENT_GENERAL, ACCESS_CENT_SPECOPS, ACCESS_CENT_MEDICAL, ACCESS_CENT_STORAGE)
	outfit = /datum/outfit/nanotrasencommandercorpse

/datum/outfit/nanotrasencommandercorpse
	name = "GATO Private Security Commander"
	uniform = /obj/item/clothing/under/rank/centcom_commander
	suit = /obj/item/clothing/suit/armor/bulletproof
	ears = /obj/item/radio/headset/heads/captain
	glasses = /obj/item/clothing/glasses/eyepatch
	mask = /obj/item/clothing/mask/cigarette/cigar/cohiba
	head = /obj/item/clothing/head/centhat
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/combat/swat
	r_pocket = /obj/item/lighter
	id = /obj/item/card/id


/obj/effect/mob_spawn/human/nanotrasensoldier
	name = "GATO Private Security Officer"
	id_job = "Private Security Force"
	id_access_list = list(ACCESS_CENT_CAPTAIN, ACCESS_CENT_GENERAL, ACCESS_CENT_SPECOPS, ACCESS_CENT_MEDICAL, ACCESS_CENT_STORAGE, ACCESS_SECURITY)
	outfit = /datum/outfit/nanotrasensoldiercorpse

/datum/outfit/nanotrasensoldiercorpse
	name = "GATO Private Security Officer Corpse"
	uniform = /obj/item/clothing/under/rank/security
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	head = /obj/item/clothing/head/helmet/swat/nanotrasen
	back = /obj/item/storage/backpack/security
	id = /obj/item/card/id


/obj/effect/mob_spawn/human/commander/alive
	death = FALSE
	roundstart = FALSE
	job_description = "GATO Commander"
	mob_name = "GATO Commander"
	name = "sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	short_desc = "You are a GATO Commander!"

/obj/effect/mob_spawn/human/nanotrasensoldier/alive
	death = FALSE
	roundstart = FALSE
	mob_name = "Private Security Officer"
	job_description = "GATO Security"
	name = "sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	faction = "nanotrasenprivate"
	short_desc = "You are a GATO Private Security Officer!"


/////////////////Spooky Undead//////////////////////

/obj/effect/mob_spawn/human/skeleton
	name = "skeletal remains"
	mob_name = "skeleton"
	mob_species = /datum/species/skeleton
	mob_gender = NEUTER

/obj/effect/mob_spawn/human/skeleton/alive
	death = FALSE
	roundstart = FALSE
	job_description = "Skeleton"
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	short_desc = "By unknown powers, your skeletal remains have been reanimated!"
	flavour_text = "Walk this mortal plain and terrorize all living adventurers who dare cross your path."
	assignedrole = "Skeleton"

/obj/effect/mob_spawn/human/zombie
	name = "rotting corpse"
	mob_name = "zombie"
	mob_species = /datum/species/zombie
	assignedrole = "Zombie"

/obj/effect/mob_spawn/human/zombie/alive
	death = FALSE
	roundstart = FALSE
	job_description = "Zombie"
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	short_desc = "By unknown powers, your rotting remains have been resurrected!"
	flavour_text = "Walk this mortal plain and terrorize all living adventurers who dare cross your path."



/obj/effect/mob_spawn/human/abductor
	name = "abductor"
	mob_name = "alien"
	mob_species = /datum/species/abductor
	outfit = /datum/outfit/abductorcorpse

/datum/outfit/abductorcorpse
	name = "Abductor Corpse"
	uniform = /obj/item/clothing/under/color/grey
	shoes = /obj/item/clothing/shoes/combat


//For ghost bar.
/obj/effect/mob_spawn/human/alive/space_bar_patron
	name = "Bar cryogenics"
	mob_name = "Bar patron"
	random = TRUE
	permanent = TRUE
	uses = -1
	outfit = /datum/outfit/spacebartender
	assignedrole = "Space Bar Patron"
	job_description = "Space Bar Patron"

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/effect/mob_spawn/human/alive/space_bar_patron/attack_hand(mob/user)
	var/despawn = alert("Return to cryosleep? (Warning, Your mob will be deleted!)",,"Yes","No")
	if(despawn == "No" || !loc || !Adjacent(user))
		return
	user.visible_message("<span class='notice'>[user.name] climbs back into cryosleep...</span>")
	qdel(user)

/datum/outfit/cryobartender
	name = "Cryogenic Bartender"
	uniform = /obj/item/clothing/under/rank/bartender
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/sneakers/black
	suit = /obj/item/clothing/suit/armor/vest
	glasses = /obj/item/clothing/glasses/sunglasses/reagent



// GS13 stuff!

// Restaurant Worker: Basically just a bunch of wagies who are supposed to lure people into their restaurant


/obj/effect/mob_spawn/human/fastfood
	name = "Corporate cryostasis pod"
	desc = "Through the grease-stained cryopod glass, you can see someone sleeping inside..."
	mob_name = "fastfood worker"
	job_description = "Restaurant Worker"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	death = FALSE
	roundstart = FALSE
	mob_species = /datum/species/human
	short_desc = "It's the grand opening day!"
	flavour_text = "After you've sold your soul to corporate overlords, your contract obliged you to enter cryostasis. \
	Finally, after God knows how long, the cryopod system have awakened you with only a single sentence of information - welcome and lure in new guests into the freshly opened GATO restaurant!"
	assignedrole = "Restaurant worker"
	mirrorcanloadappearance = TRUE

/obj/effect/mob_spawn/human/fastfoodmanager
	name = "Corporate cryostasis pod"
	desc = "Through the grease-stained cryopod glass, you can see someone sleeping inside..."
	mob_name = "fastfood worker"
	job_description = "Restaurant Manager"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	death = FALSE
	roundstart = FALSE
	mob_species = /datum/species/human
	short_desc = "It's the grand opening day!"
	flavour_text = "After you've sold your soul to corporate overlords, your contract obliged you to enter cryostasis. \
	Finally, after God knows how long, the cryopod system have awakened you with only a single sentence of information - make sure to keep the best care of GATO's restaurant, currently under your management! You have a higher say over your workers, but do not abuse this power."
	assignedrole = "Restaurant manager"
	mirrorcanloadappearance = TRUE

/obj/effect/mob_spawn/human/fastfood/Initialize(mapload)
	. = ..()
	var/arrpee = rand(1,2)
	switch(arrpee)
		if(1)
			flavour_text += "You are this restaurant's cook, using up the plethora of ingredients to cook up deliciously greasy and caloric foods. \
			The kitchen and the bar is your turf! Make sure the guests stay fed."
			outfit.glasses = /obj/item/clothing/glasses/sunglasses/reagent
			outfit.head = /obj/item/clothing/head/soft/black
			outfit.uniform = /obj/item/clothing/under/bb_sweater/purple 
			outfit.suit = /obj/item/clothing/suit/apron/chef
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack
			outfit.ears = /obj/item/radio/headset
			outfit.id = /obj/item/card/id/silver/restaurant
		if(2)
			flavour_text += "You are this restaurant's waiter, responsible not only for tending to the guests, but also fixing and taking care of station's shape, power and looks. \
			Make sure everything looks squeaky clean and that the restaurant remains powered!"
			outfit.head = /obj/item/clothing/head/soft/black
			outfit.uniform = /obj/item/clothing/under/waiter
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack
			outfit.ears = /obj/item/radio/headset
			outfit.id = /obj/item/card/id/silver/restaurant

/obj/effect/mob_spawn/human/fastfoodmanager/Initialize(mapload)
	. = ..()
	var/arrpee = rand(1,2)
	switch(arrpee)
		if(1)
			flavour_text += "You are this restaurant's manager, taking care of all the necessary paperwork, overseeing all the workers... \
			But most importantly, you always have to make sure that the restaurant prospers and remains in good shape! "
			outfit.glasses = /obj/item/clothing/glasses/sunglasses/reagent
			outfit.uniform = /obj/item/clothing/under/suit_jacket/burgundy 
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack/satchel/leather
			outfit.ears = /obj/item/radio/headset
			outfit.id = /obj/item/card/id/silver/restaurant
			outfit.l_pocket = /obj/item/modular_computer/tablet

		if(2)
			flavour_text += "You are this restaurant's manager, taking care of all the necessary paperwork, overseeing all the workers... \
			But most importantly, you always have to make sure that the restaurant prospers and remains in good shape! "
			outfit.glasses = /obj/item/clothing/glasses/sunglasses/reagent
			outfit.uniform = /obj/item/clothing/under/suit_jacket/navy
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack/satchel/leather
			outfit.ears = /obj/item/radio/headset
			outfit.id = /obj/item/card/id/silver/restaurant
			outfit.l_pocket = /obj/item/modular_computer/tablet

/obj/effect/mob_spawn/human/fastfood/special(mob/living/carbon/human/new_spawn)
	ADD_TRAIT(new_spawn,TRAIT_EXEMPT_HEALTH_EVENTS,GHOSTROLE_TRAIT)

/obj/effect/mob_spawn/human/fastfood/Destroy()
	new/obj/structure/fluff/empty_sleeper(get_turf(src))
	return ..()


/obj/effect/mob_spawn/human/fastfoodmanager/Destroy()
	return ..()

// Feeder's Den - fanatic (GS13)

/obj/effect/mob_spawn/human/feeders_den/fanatic
	name = "Sleeper pod"
	desc = "Through the red glass, you can see someone sleeping inside..."
	mob_name = "Feeder Fanatic"
	job_description = "Feeder Fanatic"
	short_desc = "You are a member of a niche branch of Syndicate with... strange goals."
	flavour_text = "After months of construction and gathering equipment, your den is finished - a monument to gluttony, equipped with every tool to turn any sharp body into a quivering mound of lard..."
	important_info = "Keep your den in one piece and away from curious eyes! YOU AREN'T ALLOWED TO CAPTURE / FATTEN UP PEOPLE WHO DON'T DO NON-CON OR DIDN'T AGREE TO IT! Despite being able to leave the outpost, you do NOT have a permission to antag or grief. You're supposed to stay covert, not show yourself to the whole station!"
	outfit = /datum/outfit/feeders_den/fanatic
	faction = ROLE_SYNDICATE
	mirrorcanloadappearance = TRUE
	assignedrole = "Space Agent"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	death = FALSE
	roundstart = FALSE
	mob_species = /datum/species/human

/datum/outfit/feeders_den/fanatic
	name = "Feeder Fanatic"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/syndicate/alt
	back = /obj/item/storage/backpack
	r_hand = /obj/item/storage/box/syndie_kit/soporific_bundle
	l_hand = /obj/item/gun/ballistic/automatic/pistol
	l_pocket = /obj/item/crowbar
	r_pocket = /obj/item/gun/energy/fatoray
	id = /obj/item/card/id/syndicate/anyone
	implants = list(/obj/item/implant/weapons_auth)

/datum/outfit/feeders_den/fanatic/post_equip(mob/living/carbon/human/H)
	H.faction |= ROLE_SYNDICATE

/datum/outfit/feeders_den/fanatic/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	..()

/obj/effect/mob_spawn/human/feeders_den/fanatic/special(mob/living/carbon/human/new_spawn)
	ADD_TRAIT(new_spawn,TRAIT_EXEMPT_HEALTH_EVENTS,GHOSTROLE_TRAIT)


// Feeder's Den - victim (GS13)


/obj/effect/mob_spawn/human/feeders_den/victim
	name = "Grease stained cryopod"
	mob_name = "Syndicate Prisoner"
	desc = "Through the grease-stained cryopod glass, you can see someone obese sleeping inside..."
	job_description = "Den Victim"
	short_desc = "You don't remember how you even got here."
	flavour_text = "It's been a while since you've been stuck here. Each day passes by with non-stop feeding, lazing around and the pain of a stretched, creaking stomach... Is there any hope for you to get out of here before things get truly hopeless?"
	important_info = "Keep your behaviour appropriate and fitting for your role, at least loosely."
	outfit = /datum/outfit/feeders_den/victim
	mirrorcanloadappearance = TRUE
	assignedrole = "Imprisoned victim"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	death = FALSE
	roundstart = FALSE
	mob_species = /datum/species/human

/datum/outfit/feeders_den/victim
	name = "Den Victim"
	uniform = /obj/item/clothing/under/gear_harness
	neck = /obj/item/electropack/shockcollar

/datum/outfit/feeders_den/victim/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	..()

/obj/effect/mob_spawn/human/feeders_den/victim/special(mob/living/carbon/human/new_spawn)
	ADD_TRAIT(new_spawn,TRAIT_EXEMPT_HEALTH_EVENTS,GHOSTROLE_TRAIT)

/obj/effect/mob_spawn/proc/startfat(mob/M) //move this somewhere else later when we're cleaning up our content - GLDW
	return
