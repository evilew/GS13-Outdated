/obj/item/implant/docile
	name = "docility implant"
	activated = FALSE

/obj/item/implant/docile/implant(mob/living/target, mob/user, silent = FALSE)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/human/target_human = target
	if(!istype(target_human))
		return

	// If you have this implant, you aren't going to be doing any fighting.
	ADD_TRAIT(target, TRAIT_WEIGHT_LOSS_IMMUNE, src)
	ADD_TRAIT(target, TRAIT_PACIFISM, src)
	ADD_TRAIT(target, TRAIT_CLUMSY, src)
	ADD_TRAIT(target, TRAIT_FAT_GOOD, src)
	ADD_TRAIT(target, TRAIT_HEAVY_SLEEPER, src)

	target_human.nutri_mult += 1

/obj/item/implant/docile/removed(mob/living/source, silent = FALSE, special = 0)
	. = ..()
	if(!.)
		return

	REMOVE_TRAIT(target, TRAIT_WEIGHT_LOSS_IMMUNE, src)
	REMOVE_TRAIT(target, TRAIT_PACIFISM, src)
	REMOVE_TRAIT(target, TRAIT_CLUMSY, src)
	REMOVE_TRAIT(target, TRAIT_FAT_GOOD, src)
	REMOVE_TRAIT(target, TRAIT_HEAVY_SLEEPER, src)

	target_human.nutri_mult -= 1

