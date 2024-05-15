/datum/species/human
	name = "Human"
	id = "human"
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,MUTCOLORS_PARTSONLY,WINGCOLOR)
	mutant_bodyparts = list("ears", "tail_human", "wings", "taur", "deco_wings") // CITADEL EDIT gives humans snowflake parts
	default_features = list("mcolor" = "FFF", "mcolor2" = "FFF","mcolor3" = "FFF","tail_human" = "None", "ears" = "None", "wings" = "None", "taur" = "None", "deco_wings" = "None")
	use_skintones = 1
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW
	liked_food = JUNKFOOD | FRIED

	var/list/female_screams = list('sound/voice/human/femalescream_1.ogg', 'sound/voice/human/femalescream_2.ogg', \
								'sound/voice/human/femalescream_3.ogg', 'sound/voice/human/femalescream_4.ogg', \
								'sound/voice/human/femalescream_5.ogg')
	var/list/male_screams = list('sound/voice/human/malescream_1.ogg', 'sound/voice/human/malescream_2.ogg', \
								'sound/voice/human/malescream_3.ogg', 'sound/voice/human/malescream_4.ogg', \
								'sound/voice/human/malescream_5.ogg')

/datum/species/human/get_scream_sound(mob/living/carbon/human/H)
	if(H.gender == FEMALE)
		return pick(female_screams)
	else
		if(prob(1))
			return pick('modular_citadel/sound/voice/scream_m1.ogg', 'modular_citadel/sound/voice/scream_m2.ogg', \
						'sound/voice/human/wilhelm_scream.ogg')
		return pick(male_screams)

/datum/species/human/qualifies_for_rank(rank, list/features)
	return TRUE	//Pure humans are always allowed in all roles.

/datum/species/human/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/human/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/datum/species/human/can_wag_tail(mob/living/carbon/human/H)
	return ("tail_human" in mutant_bodyparts) || ("waggingtail_human" in mutant_bodyparts)

/datum/species/human/is_wagging_tail(mob/living/carbon/human/H)
	return ("waggingtail_human" in mutant_bodyparts)

/datum/species/human/start_wagging_tail(mob/living/carbon/human/H)
	if("tail_human" in mutant_bodyparts)
		mutant_bodyparts -= "tail_human"
		mutant_bodyparts |= "waggingtail_human"
	H.update_body()

/datum/species/human/stop_wagging_tail(mob/living/carbon/human/H)
	if("waggingtail_human" in mutant_bodyparts)
		mutant_bodyparts -= "waggingtail_human"
		mutant_bodyparts |= "tail_human"
	H.update_body()
