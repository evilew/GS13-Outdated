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

/obj/item/clothing/under/rank/chef/modular/jumpsuit_adjust()
	..()
	worn_overlays()

/obj/item/clothing/under/rank/chef/modular/worn_overlays(isinhands = FALSE)
	if(!isinhands)
		. = list()
		var/obj/item/organ/O
		var/obj/item/organ/genital/G
		for(O in U.internal_organs)
			if(istype(O, /obj/item/organ/genital/belly))
				G = O
				if(!adjusted)
					if(G.size <= 9) //These need to be removed later, better to cap organ sizes to begin with
						. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "belly_[G.size]", GENITALS_UNDER_LAYER)
					else
						. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "belly_9", GENITALS_UNDER_LAYER)
				else
					if(G.size <= 9)
						. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "belly_[G.size]_d", GENITALS_UNDER_LAYER)
					else
						. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "belly_9_d", GENITALS_UNDER_LAYER)
			if(istype(O, /obj/item/organ/genital/anus))
				G = O
				if(suit_style == DIGITIGRADE_SUIT_STYLE)
					if(G.size <= 10)
						. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "butt_[G.size]_l", GENITALS_FRONT_LAYER)
						. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "butt_[G.size]_l_NORTH", GENITALS_FRONT_LAYER)
					else
						. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "butt_10_l", GENITALS_FRONT_LAYER)
						. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "butt_10_l_NORTH", GENITALS_FRONT_LAYER)
				else
					if(G.size <= 10)
						. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "butt_[G.size]", GENITALS_FRONT_LAYER)
						. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "butt_[G.size]_NORTH", GENITALS_FRONT_LAYER)
					else
						. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "butt_10", GENITALS_FRONT_LAYER)
						. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "butt_10_NORTH", GENITALS_FRONT_LAYER)
			if(istype(O, /obj/item/organ/genital/breasts))
				G = O
				if(G.size <= "impossible")
					. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "breasts_[G.size]", GENITALS_BEHIND_LAYER)	//nearest
					. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "breasts_[G.size]_NORTH", BODY_FRONT_LAYER)	//farthest
				else
					. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "breasts_impossible", GENITALS_BEHIND_LAYER)	//nearest
					. += mutable_appearance('GainStation13/icons/mob/modclothes/chefmodular.dmi', "breasts_impossible_NORTH", BODY_FRONT_LAYER)	//farthest
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damageduniform")
		if(blood_DNA)
			. += mutable_appearance('icons/effects/blood.dmi', "uniformblood", color = blood_DNA_to_color())
		if(accessory_overlay)
			. += accessory_overlay

/obj/item/clothing/under/color/grey/modular
	name = "grey modular jumpsuit"
	desc = "A tasteful grey jumpsuit that reminds you of the good old days. Now adjusts to the match the wearer's size!"
	
	var/icon_location = 'GainStation13/icons/mob/modclothes/graymodular.dmi'
	var/mob/living/carbon/U

/obj/item/clothing/under/color/grey/modular/equipped(mob/user, slot)
	..()
	U = user

/obj/item/clothing/under/color/grey/modular/dropped()
	..()
	U = null

/obj/item/clothing/under/color/grey/modular/jumpsuit_adjust()
	..()
	worn_overlays()

/obj/item/clothing/under/color/grey/modular/worn_overlays(isinhands = FALSE)
	if(!isinhands)
		. = list()
		var/obj/item/organ/O
		var/obj/item/organ/genital/G
		for(O in U.internal_organs)
			if(istype(O, /obj/item/organ/genital/belly))
				G = O
				if(!adjusted)
					if(G.size <= 9) //These need to be removed later, better to cap organ sizes to begin with
						. += mutable_appearance(icon_location, "belly_[G.size]", GENITALS_UNDER_LAYER)
					else
						. += mutable_appearance(icon_location, "belly_9", GENITALS_UNDER_LAYER)
				else
					if(G.size <= 9)
						. += mutable_appearance(icon_location, "belly_[G.size]_d", GENITALS_UNDER_LAYER)
					else
						. += mutable_appearance(icon_location, "belly_9_d", GENITALS_UNDER_LAYER)
			if(istype(O, /obj/item/organ/genital/anus))
				G = O
				if(suit_style == DIGITIGRADE_SUIT_STYLE)
					if(G.size <= 10)
						. += mutable_appearance(icon_location, "butt_[G.size]_l", GENITALS_FRONT_LAYER)
						. += mutable_appearance(icon_location, "butt_[G.size]_l_NORTH", GENITALS_FRONT_LAYER)
					else
						. += mutable_appearance(icon_location, "butt_10_l", GENITALS_FRONT_LAYER)
						. += mutable_appearance(icon_location, "butt_10_l_NORTH", GENITALS_FRONT_LAYER)
				else
					if(G.size <= 10)
						. += mutable_appearance(icon_location, "butt_[G.size]", GENITALS_FRONT_LAYER)
						. += mutable_appearance(icon_location, "butt_[G.size]_NORTH", GENITALS_FRONT_LAYER)
					else
						. += mutable_appearance(icon_location, "butt_10", GENITALS_FRONT_LAYER)
						. += mutable_appearance(icon_location, "butt_10_NORTH", GENITALS_FRONT_LAYER)
			if(istype(O, /obj/item/organ/genital/breasts))
				G = O
				if(G.size <= "o")
					. += mutable_appearance(icon_location, "breasts_[G.size]", GENITALS_BEHIND_LAYER)	//nearest
					. += mutable_appearance(icon_location, "breasts_[G.size]_NORTH", BODY_FRONT_LAYER)	//farthest
				else
					if(G.size == "huge")
						. += mutable_appearance(icon_location, "breasts_huge", GENITALS_BEHIND_LAYER)	//nearest
						. += mutable_appearance(icon_location, "breasts_huge_NORTH", BODY_FRONT_LAYER)	//farthest
					else
						if(G.size == "massive")
							. += mutable_appearance(icon_location, "breasts_massive", GENITALS_BEHIND_LAYER)	//nearest
							. += mutable_appearance(icon_location, "breasts_massive_NORTH", BODY_FRONT_LAYER)	//farthest
						else
							if(G.size == "giga")
								. += mutable_appearance(icon_location, "breasts_giga", GENITALS_BEHIND_LAYER)	//nearest
								. += mutable_appearance(icon_location, "breasts_giga_NORTH", BODY_FRONT_LAYER)	//farthest
							else
								. += mutable_appearance(icon_location, "breasts_impossible", GENITALS_BEHIND_LAYER)	//nearest
								. += mutable_appearance(icon_location, "breasts_impossible_NORTH", BODY_FRONT_LAYER)	//farthest
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damageduniform")
		if(blood_DNA)
			. += mutable_appearance('icons/effects/blood.dmi', "uniformblood", color = blood_DNA_to_color())
		if(accessory_overlay)
			. += accessory_overlay
