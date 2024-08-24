/obj/item/implant/docile
	name = "docility implant"
	activated = FALSE
	/// What fatness level does the target need to be for the implant to work?
	var/required_fatness = FATNESS_LEVEL_BLOB
	/// What traits do we want to give the implanted mob?
	var/list/traits_list = list(
		TRAIT_WEIGHT_LOSS_IMMUNE,
		TRAIT_PACIFISM,
		TRAIT_CLUMSY,
		TRAIT_FAT_GOOD,
		TRAIT_HEAVY_SLEEPER,
		TRAIT_DOCILE,
	)

/obj/item/implant/docile/can_be_implanted_in(mob/living/target)
	var/mob/living/carbon/human/target_human = target
	if(!istype(target_human) || (target_human.fatness_real < required_fatness))
		return FALSE

	return target?.client?.prefs?.fatness_vulnerable

/obj/item/implant/docile/implant(mob/living/target, mob/user, silent = FALSE)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/human/target_human = target
	if(!istype(target_human))
		return

	for(var/trait in trait_list)
		ADD_TRAIT(target, trait, src)

	target_human.nutri_mult += 1
	return TRUE

/obj/item/implant/docile/removed(mob/living/source, silent = FALSE, special = 0)
	. = ..()
	if(!.)
		return

	for(var/trait in trait_list)
		REMOVE_TRAIT(target, trait, src)

	target_human.nutri_mult -= 1
	return TRUE

