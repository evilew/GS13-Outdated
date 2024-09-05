//GS13 - implants and similar

/obj/item/organ/cyberimp/chest/nutriment/turbo
	name = "Nutriment pump implant TURBO"
	desc = "This implant was meant to prevent people from going hungry, but due to a flaw in its designs, it permanently produces a small amount of nutriment overtime."
	icon_state = "chest_implant"
	implant_color = "#006607"
	nutrition_amount = 20 //somewhere around 5 pounds
	hunger_threshold = NUTRITION_LEVEL_FULL
	poison_amount = 10
	message = "" //no message cuz spam is annoying

/obj/item/organ/cyberimp/chest/mobility
	name = "Mobility Nanite Core"
	desc = "This implant contains nanites that reinforce leg muscles, allowing for unimpeded movement at extreme weights."
	icon_state = "chest_implant"
	implant_color = "#9034db"

/obj/item/organ/cyberimp/chest/mobility/Insert(mob/living/carbon/M, special = 0)
	..()
	ADD_TRAIT(M, TRAIT_NO_FAT_SLOWDOWN, src)

/obj/item/organ/cyberimp/chest/mobility/Remove(mob/living/carbon/M, special = 0)
	REMOVE_TRAIT(M, TRAIT_NO_FAT_SLOWDOWN, src)
	..()
