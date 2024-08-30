/datum/quirk/fatrousal
	name = "Adiposexual Response"
	desc = "Your adipose tissue develops and shrinks depending on your arousal."
	value = 0 //ERP quirk
	gain_text = "<span class='notice'>Your body feels like it could grow at any moment.</span>"
	lose_text = "<span class='notice'>The feeling of impending growth is gone...</span>"
	category = CATEGORY_SEXUAL
	mob_trait = TRAIT_FATROUSAL

/datum/quirk/fatrousal/add()
	if(iscarbon(quirk_holder))
		var/mob/living/carbon/C = quirk_holder
		C.hider_add(src)

/datum/quirk/fatrousal/remove()
	if(iscarbon(quirk_holder))
		var/mob/living/carbon/C = quirk_holder
		C.hider_remove(src)

/datum/quirk/fatrousal/proc/fat_hide(var/mob/living/carbon/user)
	if(iscarbon(quirk_holder))
		var/mob/living/carbon/C = quirk_holder
		return C.getArousalLoss()*35
	return 0

///mob/living/adjustArousalLoss(amount, updating_arousal=1)
//	if(HAS_TRAIT(src, TRAIT_FATROUSAL))
//		amount = amount * 0.2
//	..()
//
