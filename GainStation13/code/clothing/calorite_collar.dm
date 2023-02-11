/obj/item/clothing/neck
	///How much faster does the wearer gain weight? 1 = 100% faster
	var/weight_gain_rate_modifier = 0

/obj/item/clothing/neck/equipped(mob/user, slot)
	. = ..()

	var/mob/living/carbon/wearer = user
	if(!weight_gain_rate_modifier)
		return FALSE

	if(!iscarbon(wearer) || slot != SLOT_NECK || !wearer?.client?.prefs?.weight_gain_items)
		return FALSE
		
	wearer.weight_gain_rate = wearer.weight_gain_rate * weight_gain_rate_modifier	

/obj/item/clothing/neck/dropped(mob/user)
	. = ..()
	var/mob/living/carbon/wearer = user
	if(!weight_gain_rate_modifier)
		return FALSE

	if(!iscarbon(wearer) || !(wearer.get_item_by_slot(SLOT_NECK) == src) || !wearer?.client?.prefs?.weight_gain_items)
		return FALSE
		
	wearer.weight_gain_rate = (wearer.weight_gain_rate / weight_gain_rate_modifier)	


/obj/item/clothing/neck/petcollar/calorite
	name = "calorite collar"
	desc = "A modified pet collar infused with calorite, magnifying the caloric impact of any food the wearer eats"
	weight_gain_rate_modifier = 1.5

/obj/item/clothing/neck/petcollar/locked/calorite
	name = "locked calorite collar"
	desc = "A modified locked collar infused with calorite, magnifying the caloric impact of any food the wearer eats"
	weight_gain_rate_modifier = 1.5
