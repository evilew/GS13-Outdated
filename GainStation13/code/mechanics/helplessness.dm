/mob/living/carbon/can_buckle()
	if(HAS_TRAIT(src, TRAIT_NO_BUCKLE))
		return FALSE

	return ..()

/datum/species/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self)
	if(HAS_TRAIT(H, TRAIT_NO_BACKPACK) && slot == SLOT_BACK)
		to_chat(H, "<span class='warning'>You are too fat to wear anything on your back.</span>")
		return FALSE

	if(!istype(I, /obj/item/clothing/under/color/grey/modular) && HAS_TRAIT(H, TRAIT_NO_JUMPSUIT) && slot == SLOT_W_UNIFORM)
		to_chat(H, "<span class='warning'>You are too fat to wear [I].</span>")
		return FALSE

	if(HAS_TRAIT(H, TRAIT_NO_MISC) && (slot == SLOT_SHOES || slot == SLOT_GLOVES || slot == SLOT_WEAR_SUIT))
		to_chat(H, "<span class='warning'>You are too fat to wear [I].</span>")
		return FALSE

	return ..()
