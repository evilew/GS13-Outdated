/obj/item/clothing/under/rank/chef/modular
	name = "cook's modular suit"
	desc = "A suit which is given only to the most <b>hardcore</b> cooks in space. Now adjusts to the match the wearer's size!"

	var/mob/living/carbon/U

/obj/item/clothing/under/rank/chef/modular/equipped(mob/user, slot)
	..()
	U = user

/obj/item/clothing/under/rank/chef/modular/dropped()
	..()
	U = null

/obj/item/clothing/under/rank/chef/modular/worn_overlays(isinhands = FALSE)
	if(!isinhands)
		. = list()
		var/obj/item/organ/O
		var/obj/item/organ/genital/G
		for(O in U.internal_organs)
			if(istype(O, /obj/item/organ/genital/belly))
				G = O
				if(!adjusted)
					. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "belly_[G.size]", GENITALS_UNDER_LAYER)
				else
					. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "belly_[G.size]_d", GENITALS_UNDER_LAYER)
			if(istype(O, /obj/item/organ/genital/anus))
				G = O
				if(suit_style == DIGITIGRADE_SUIT_STYLE)
					. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "butt_[G.size]_l", GENITALS_FRONT_LAYER)
					. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "butt_[G.size]_l_NORTH", GENITALS_FRONT_LAYER)
				else
					. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "butt_[G.size]", GENITALS_FRONT_LAYER)
					. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "butt_[G.size]_NORTH", GENITALS_FRONT_LAYER)
			if(istype(O, /obj/item/organ/genital/breasts))
				G = O
				. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "breasts_[G.size]", GENITALS_BEHIND_LAYER)	//nearest
				. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "breasts_[G.size]_NORTH", BODY_FRONT_LAYER)	//farthest
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damageduniform")
		if(blood_DNA)
			. += mutable_appearance('icons/effects/blood.dmi', "uniformblood", color = blood_DNA_to_color())
		if(accessory_overlay)
			. += accessory_overlay
