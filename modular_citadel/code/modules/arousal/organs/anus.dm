/obj/item/organ/genital/anus
	name 					= "anus"
	desc 					= "You see a pair of asscheeks."
	icon_state 				= "butt"
	icon 					= 'modular_citadel/icons/obj/genitals/breasts.dmi'
	zone 					= "anus"
	slot 					= "anus"
	w_class 				= 3
	size 					= 0
	var/size_name			= "nonexistant"
	var/statuscheck			= FALSE
	shape					= "Pair"
	can_masturbate_with 	= FALSE
	masturbation_verb 		= "massage"
	can_climax				= FALSE

/obj/item/organ/genital/anus/on_life()
	if(QDELETED(src))
		return
	if(!owner)
		return

/obj/item/organ/genital/anus/update_appearance()
	var/string
	var/lowershape = lowertext(shape)

	//Reflect the size of dat ass on examine.
	// GS13: Add normal and huge+
	switch(round(size))
		if(0)
			size_name = "normal"
		if(1)
			size_name = "average"
		if(2)
			size_name = "sizable"
		if(3)
			size_name = "squeezable"
		if(4)
			size_name = "hefty"
		// GS13 TODO seems like 5 was lost in the merge
		if(6)
			size_name = "godly"
		if(7)
			size_name = "huge"
		if(8)
			size_name = "colossal"
		if(9)
			size_name = "globular"
		if(10)
			size_name = "gargantuan"
		if(11)
			size_name = "omegagigahyper" // might break something (old name: gargantuan11)
		if(12)
			size_name = "gargantuan12"
		if(13)
			size_name = "gargantuan13"
		if(14)
			size_name = "gargantuan14"
		if(15)
			size_name = "gargantuan15"
		if(16)
			size_name = "gargantuan16"
		if(17)
			size_name = "gargantuan17"
		if(18)
			size_name = "gargantuan18"
		if(19)
			size_name = "gargantuan19"
		if(20)
			size_name = "gargantuan20"
		else
			size_name = "nonexistant"

	desc = "You see a [lowershape] of [size_name] asscheeks."

	if(owner)
		var/mob/living/carbon/human/H = owner
		color = "#[skintone2hex(H.skin_tone)]"

		if(ishuman(owner))
			if(size > 10)
				size = 10
			icon_state = sanitize_text(string)
			H.update_genitals()

			icon_state = sanitize_text(string)

