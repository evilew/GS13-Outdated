// This is a file for emotes that have been rewritten to be more modular. Such as varying based on species or whathave you. May move this later or something.


//Taken from modular_citadel/code/modules/mob/cit_emotes.dm 
/datum/emote/living/scream/run_emote(mob/living/user, params) //I can't not port this shit, come on.
	if(user.nextsoundemote >= world.time || user.stat != CONSCIOUS)
		return
	var/sound
	var/miming = user.mind ? user.mind.miming : 0
	if(!user.is_muzzled() && !miming)
		user.nextsoundemote = world.time + 7
		if(issilicon(user))
			sound = 'modular_citadel/sound/voice/scream_silicon.ogg'
			if(iscyborg(user))
				var/mob/living/silicon/robot/S = user
				if(S.cell.charge < 20)
					to_chat(S, "<span class='warning'>Scream module deactivated. Please recharge.</span>")
					return
				S.cell.use(200)
		if(ismonkey(user))
			sound = 'modular_citadel/sound/voice/scream_monkey.ogg'
		if(istype(user, /mob/living/simple_animal/hostile/gorilla))
			sound = 'sound/creatures/gorilla.ogg'
		if(ishuman(user))
			user.adjustOxyLoss(5)
			switch(H.dna.species)
				if(/datum/species/human)
					sound = pick()
					if(prob(1))
						sound = pick('modular_citadel/sound/voice/scream_m1.ogg', 'modular_citadel/sound/voice/scream_m2.ogg')
					if(user.gender == FEMALE)
						sound = pick('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
			
			
			if(is_species(user, /datum/species/android) || is_species(user, /datum/species/synth) || is_species(user, /datum/species/ipc) || is_species(user, /datum/species/synthliz))
				sound = 'modular_citadel/sound/voice/scream_silicon.ogg'
			if(is_species(user, /datum/species/lizard))
				sound = 'modular_citadel/sound/voice/scream_lizard.ogg'
			if(is_species(user, /datum/species/skeleton))
				sound = 'modular_citadel/sound/voice/scream_skeleton.ogg'
			if (is_species(user, /datum/species/fly) || is_species(user, /datum/species/insect))
				sound = 'modular_citadel/sound/voice/scream_moth.ogg'
		if(isalien(user))
			sound = 'sound/voice/hiss6.ogg'
		LAZYINITLIST(user.alternate_screams)
		if(LAZYLEN(user.alternate_screams))
			sound = pick(user.alternate_screams)
		playsound(user.loc, sound, 50, 1, 4, 1.2)
		message = "screams!"
	else if(miming)
		message = "acts out a scream."
	else
		message = "makes a very loud noise."
	. = ..()
