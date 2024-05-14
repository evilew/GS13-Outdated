//Hyperstation Arousal hud
//This needs alot of attention, im a bad coder. a shitty attempt at making a more user friendly/modern hud
//if you wanna use this on your own server go ahead, but alittle credit would always be nice! -quotefox
//This still uses alot of cits arousal system!

/obj/screen/arousal/ui_interact(mob/user)
	. = ..()
	var/dat	=	{"<B>Genitals</B><BR><HR>"}

	var/mob/living/carbon/U = user
	for(var/obj/item/organ/genital/G in U.internal_organs)
		if(!G.nochange)
			if(!G.dontlist)
				// GS13: Fix spelling
				dat	+= "<a href='byond://?src=[REF(src)];hide[G.name]=1'>[G.mode == "hidden" ? "[G.name] <font color='red'>(Hidden)</font>" : (G.mode == "clothes" ? "[G.name] <font color='yellow'>(Hidden by Clothes)</font>" : (G.mode == "visible" ? "[G.name] <font color='green'>(Visible)</font>" : "[G.name] <font color='green'>(Visible)</font>"))]</a><BR>"

	dat	+=	{"<BR><B>Contexual Options</B><BR><HR>"}
	var/obj/item/organ/genital/penis/P = user.getorganslot("penis")
	//Options
	dat	+= "<a href='byond://?src=[REF(src)];masturbate=1'>Masturbate</A>"
	dat	+=	"(Stimulate a sexual organ with your hands.)<BR>"

	dat	+= "<a href='byond://?src=[REF(src)];climax=1'>Climax</A>"
	dat	+=	"(Orgasm from a sexual organ.)<BR>"

	dat	+= "<a href='byond://?src=[REF(src)];container=1'>Fill container</A>"
	dat	+=	"(Use a container in your hand to collect your seminal fluid.)<BR>"

	var/mob/living/carbon/human/C = usr
	if(C && C.w_uniform || C.wear_suit) //if they are wearing cloths
		dat += "<a href='byond://?src=[REF(src)];clothesplosion=1'>Explode out of clothes</A>"
		dat	+=	"(Flex your body to cause your clothes to burst apart.)<BR>"

	if(user.pulling)
		dat	+= "<a href='byond://?src=[REF(src)];kiss=1'>Kiss [user.pulling]</A>"
		dat	+=	"(Kiss a partner, or object.)<BR>"
		dat	+= "<a href='byond://?src=[REF(src)];feed=1'>Feed [user.pulling]</A>"
		dat	+=	"(Feed a partner.)<BR>"
		dat	+= "<a href='byond://?src=[REF(src)];feedfrom=1'>Feed from [user.pulling]</A>"
		dat	+=	"(Feed a partner.)<BR>"
	else
		dat	+= "<span class='linkOff'>Kiss</span></A>"
		dat	+=	"(Requires a partner)<BR>"
		dat	+= "<span class='linkOff'>Feed others</span></A>"
		dat	+=	"(Requires a partner)<BR>"
		dat	+= "<span class='linkOff'>Feed from others</span></A>"
		dat	+=	"(Requires a partner)<BR>"
	dat	+= "<a href='byond://?src=[REF(src)];feedyourself=1'>Feed yourself</A>"
	dat	+=	"(Feed yourself with your own genitals)<BR>"

	var/obj/item/organ/genital/belly/Belly = user.getorganslot("belly")
	if(Belly)
		if(Belly.inflatable)
			// GS13: Fix description
			dat	+= "<a href='byond://?src=[REF(src)];shrink_belly=1'>Decrease belly size</A>"
			dat	+=	"(Shrink your belly down a size)<BR>"
			dat	+= "<a href='byond://?src=[REF(src)];inflate_belly=1'>Increase belly size</A>"
			dat	+=	"(Bloat your belly up a size)<BR>"

	if(user.pulling)
		dat	+= "<a href='byond://?src=[REF(src)];climaxover=1'>Climax over [user.pulling]</A>" //you can cum on objects if you really want...
		dat	+=	"(Orgasm over a person or object.)<BR>"
		if(isliving(user.pulling))
			if(iscarbon(user.pulling))
				dat	+= "<a href='byond://?src=[REF(src)];climaxwith=1'>Climax with [user.pulling]</A>"
				dat	+=	{"(Orgasm with another person.)<BR>"}

				var/mob/living/carbon/human/H = user.pulling
				if(H.breedable && P && H)
					dat	+= "<a href='byond://?src=[REF(src)];impreg=1'>Impregnate [U.pulling] ([clamp(U.impregchance,0,100)]%)</A>"
					dat	+=	"(Climax inside another person, and attempt to knock them up.)<BR>"
	else
		dat	+= "<span class='linkOff'>Climax over</span></A>"
		dat	+=	"(Requires a partner)<BR>"
		dat	+= "<span class='linkOff'>Climax with</span></A>"
		dat	+=	"(Requires a partner)<BR>"

	//old code needs to be cleaned
	if(P)
		if(P.condom == 1)
			dat	+= "<a href='byond://?src=[REF(src)];removecondom=1'>Remove condom (penis)</A><BR>"
		if(P.sounding == 1)
			dat	+= "<a href='byond://?src=[REF(src)];removesound=1'>Remove sounding rod (penis)</A><BR>"
	for(var/obj/item/organ/genital/G in U.internal_organs)
		if(G.equipment) //they have equipment
			dat	+= "<a href='byond://?src=[REF(src)];removeequipment[G.name]=1;'>Remove [G.equipment.name] ([G.name])</A><BR>"

	dat	+=	{"<HR>"}//Newline for the objects
	//bottom options
	dat	+= "<a href='byond://?src=[REF(src)];refresh=1'>Refresh</A>"
	dat	+= "<a href='byond://?src=[REF(src)];omenu=1'>Old Menu</A>"
	dat	+= "<a href='byond://?src=[REF(src)];underwear=1'>Toggle Undergarments </A>"
	dat	+= "<BR>"

	var/datum/browser/popup = new(user, "arousal", "Arousal Panel")
	popup.set_content(dat)
	popup.set_title_image(user.browse_rsc_icon(icon, icon_state), 500,600)

	popup.open()





/obj/screen/arousal/Topic(href, href_list)
	. = ..() //Sanity checks.
	if(..())
		return

	var/mob/living/carbon/human/H = usr
	if (!H)
		return
	if(usr.stat==1) //No sleep-masturbation, you're unconscious.
		to_chat(usr, "<span class='warning'>You must be conscious to do that!</span>")
		usr << browse(null, "window=arousal") //closes the window
		return
	if(usr.stat==3)
		to_chat(usr, "<span class='warning'>You must be alive to do that!</span>")
		usr << browse(null, "window=arousal") //closes the window
		return

	if(href_list["hidepenis"])
		var/obj/item/organ/genital/penis/P = usr.getorganslot("penis")
		var/picked_visibility = input(usr, "Choose visibility", "Expose/Hide genitals", "Hidden by clothes") in list("Always visible", "Hidden by clothes", "Always hidden")
		P.toggle_visibility(picked_visibility)

	if(href_list["hidevagina"])
		var/obj/item/organ/genital/vagina/V = usr.getorganslot("vagina")
		var/picked_visibility = input(usr, "Choose visibility", "Expose/Hide genitals", "Hidden by clothes") in list("Always visible", "Hidden by clothes", "Always hidden")
		V.toggle_visibility(picked_visibility)

	if(href_list["hidebreasts"])
		var/obj/item/organ/genital/breasts/B = usr.getorganslot("breasts")
		var/picked_visibility = input(usr, "Choose visibility", "Expose/Hide genitals", "Hidden by clothes") in list("Always visible", "Hidden by clothes", "Always hidden")
		B.toggle_visibility(picked_visibility)

	if(href_list["hidebelly"])
		var/obj/item/organ/genital/belly/E = usr.getorganslot("belly")
		var/picked_visibility = input(usr, "Choose visibility", "Expose/Hide genitals", "Hidden by clothes") in list("Always visible", "Hidden by clothes", "Always hidden")
		E.toggle_visibility(picked_visibility)

	if(href_list["hideanus"])
		var/obj/item/organ/genital/anus/A = usr.getorganslot("anus")
		var/picked_visibility = input(usr, "Choose visibility", "Expose/Hide genitals", "Hidden by clothes") in list("Always visible", "Hidden by clothes", "Always hidden")
		A.toggle_visibility(picked_visibility)

	if(href_list["hidetesticles"])
		var/obj/item/organ/genital/testicles/T = usr.getorganslot("testicles")
		var/picked_visibility = input(usr, "Choose visibility", "Expose/Hide genitals", "Hidden by clothes") in list("Always visible", "Hidden by clothes", "Always hidden")
		T.toggle_visibility(picked_visibility)

	if(href_list["masturbate"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //requires 33% arousal.
			H.solomasturbate()
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["container"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //requires 33% arousal.
			H.cumcontainer()
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["clothesplosion"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //Requires 33% arousal.
			H.clothesplosion()
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["climax"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //requires 33% arousal.
			H.climaxalone(FALSE)
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["climaxover"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //requires 33% arousal.
			H.climaxover(usr.pulling)
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["climaxwith"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //requires 33% arousal.
			H.climaxwith(usr.pulling)
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["impreg"])
		if (H.arousalloss >= (H.max_arousal / 100) * 33) //requires 33% arousal.
			H.impregwith(usr.pulling)
			return
		else
			to_chat(usr, "<span class='warning'>You aren't aroused enough for that! </span>")
		return

	if(href_list["kiss"])
		if(usr.pulling)
			kiss()
		else
			to_chat(usr, "<span class='warning'>You cannot do this alone!</span>")
		return

	if(href_list["feed"])
		if(usr.pulling)
			feed()
		else
			to_chat(usr, "<span class='warning'>You cannot do this alone!</span>")
		return

	if(href_list["feedfrom"])
		if(usr.pulling)
			feedfrom()
		else
			to_chat(usr, "<span class='warning'>You cannot do this alone!</span>")
		return

	if(href_list["feedyourself"])
		feedyourself()
		return

	if(href_list["shrink_belly"])
		var/obj/item/organ/genital/belly/E = usr.getorganslot("belly")
		if(E.size > 0)
			to_chat(usr, "<span class='userlove'>You feel your belly diminish.</span>")
			E.size -= 1
			H.update_genitals()
		else
			to_chat(usr, "<span class='warning'>Your belly is already at the minimum size! </span>")

	if(href_list["inflate_belly"])
		var/obj/item/organ/genital/belly/E = usr.getorganslot("belly")
		if(E.size < 11)
			to_chat(usr, "<span class='userlove'>You feel your belly bloat out..</span>")
			E.size += 1
			H.update_genitals()
		else
			to_chat(usr, "<span class='warning'>Your belly is already at the maximum size! </span>")


	if(href_list["removecondom"])
		H.menuremovecondom()

	if(href_list["removesound"])
		H.menuremovesounding()

	if(href_list["removeequipmentpenis"])
		var/obj/item/organ/genital/penis/O = usr.getorganslot("penis")
		var/obj/item/I = O.equipment
		usr.put_in_hands(I)
		O.equipment = null

	if(href_list["removeequipmentbreasts"])
		var/obj/item/organ/genital/breasts/O = usr.getorganslot("breasts")
		var/obj/item/I = O.equipment
		usr.put_in_hands(I)
		O.equipment = null


	if(href_list["removeequipmentvagina"])
		var/obj/item/organ/genital/vagina/O = usr.getorganslot("vagina")
		var/obj/item/I = O.equipment
		usr.put_in_hands(I)
		if(istype(I, /obj/item/portalpanties))
			var/obj/item/portalpanties/P = I
			P.remove()
		O.equipment = null

	if(href_list["removeequipmentbelly"])
		var/obj/item/organ/genital/belly/O = usr.getorganslot("belly")
		var/obj/item/I = O.equipment
		usr.put_in_hands(I)
		O.equipment = null

	if(href_list["removeequipmentanus"])
		var/obj/item/organ/genital/anus/O = usr.getorganslot("anus")
		var/obj/item/I = O.equipment
		usr.put_in_hands(I)
		O.equipment = null


	if(href_list["omenu"])
		usr << browse(null, "window=arousal") //closes the window
		H.mob_climax()
		return

	if(href_list["underwear"])
		H.underwear_toggle()
		return

	src.ui_interact(usr)


obj/screen/arousal/proc/kiss()
	if(usr.restrained(TRUE))
		to_chat(usr, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/mob/living/carbon/human/H = usr
	if (H)
		H.kisstarget(H.pulling)

obj/screen/arousal/proc/feed()
	if(usr.restrained(TRUE))
		to_chat(usr, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/mob/living/carbon/human/H = usr
	if (H)
		H.genitalfeed(H.pulling)

obj/screen/arousal/proc/feedfrom()
	if(usr.restrained(TRUE))
		to_chat(usr, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/mob/living/carbon/human/H = usr
	if (H)
		H.genitalfeedfrom(H.pulling)

obj/screen/arousal/proc/feedyourself()
	if(usr.restrained(TRUE))
		to_chat(usr, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/mob/living/carbon/human/H = usr
	if (H)
		H.genitalfeedyourself()


/mob/living/carbon/human/proc/menuremovecondom()

	if(restrained(TRUE))
		to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/free_hands = get_num_arms()
	if(!free_hands)
		to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
		return
	var/obj/item/organ/genital/penis/P = getorganslot("penis")
	if(!P.condom)
		to_chat(src, "<span class='warning'>You don't have a condom on!</span>")
		return
	if(P.condom)
		to_chat(src, "<span class='warning'>You tug the condom off the end of your penis!</span>")
		removecondom()
		src.ui_interact(usr) //reopen dialog
		return
	return

/mob/living/carbon/human/proc/menuremovesounding()

	if(restrained(TRUE))
		to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/free_hands = get_num_arms()
	if(!free_hands)
		to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
		return
	var/obj/item/organ/genital/penis/P = getorganslot("penis")
	if(!P.sounding)
		to_chat(src, "<span class='warning'>You don't have a rod inside!</span>")
		return
	if(P.sounding)
		to_chat(src, "<span class='warning'>You pull the rod off from the tip of your penis!</span>")
		removesounding()
		src.ui_interact(usr) //reopen dialog
		return
	return

/mob/living/carbon/human/proc/solomasturbate()
	if(restrained(TRUE))
		to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/free_hands = get_num_arms()
	if(!free_hands)
		to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
		return
	for(var/helditem in held_items)
		if(isobj(helditem))
			free_hands--
	if(free_hands <= 0)
		to_chat(src, "<span class='warning'>You're holding too many things.</span>")
		return
	//We got hands, let's pick an organ
	var/obj/item/organ/genital/picked_organ
	picked_organ = pick_masturbate_genitals()
	if(picked_organ)
		src << browse(null, "window=arousal") //closes the window
		mob_masturbate(picked_organ)
		return
	else //They either lack organs that can masturbate, or they didn't pick one.
		to_chat(src, "<span class='warning'>You cannot climax without choosing genitals.</span>")
		return


//Kissing target proc
/mob/living/carbon/human/proc/kisstarget(mob/living/L)

	src << browse(null, "window=arousal") //closes the arousal window, if its open, mainly to stop spam
	if(isliving(L)) //is your target living? Living people can resist your advances if they want to via moving.
		if(iscarbon(L))
			src.visible_message("<span class='notice'>[src] is about to kiss [L]!</span>", \
								"<span class='notice'>You're attempting to kiss [L]!</span>", \
								"<span class='notice'>You're attempting to kiss with something!</span>")
			SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "kissed", /datum/mood_event/kiss) //how cute, affection is nice.
	//Well done you kissed it/them!
	src.visible_message("<span class='notice'>[src] kisses [L]!</span>", \
						"<span class='notice'>You kiss [L]!</span>", \
						"<span class='notice'>You kiss something!</span>")

/mob/living/carbon/human/proc/climaxalone()
	//we dont need hands to climax alone, its hands free!
	var/obj/item/organ/genital/picked_organ
	picked_organ = pick_climax_genitals()
	if(picked_organ)
		src << browse(null, "window=arousal") //closes the window
		mob_climax_outside(picked_organ)
		return
	else //They either lack organs that can masturbate, or they didn't pick one.
		to_chat(src, "<span class='warning'>You cannot climax without choosing genitals.</span>")
		return

/mob/living/carbon/human/proc/climaxwith(mob/living/T)

	var/mob/living/carbon/human/L = pick_partner()
	var/obj/item/organ/genital/picked_organ
	picked_organ = pick_climax_genitals()
	if(picked_organ)
		var/mob/living/partner = L
		if(partner)
			src << browse(null, "window=arousal") //alls fine, we can close the window now.
			var/obj/item/organ/genital/penis/P = picked_organ
			var/spillage = "No" //default to no, just incase player has items on to prevent climax
			if(!P.condom == 1&&!P.sounding == 1) //you cant climax with a condom on or sounding in.
				spillage = input(src, "Would your fluids spill outside?", "Choose overflowing option", "Yes") as anything in list("Yes", "No")
			if(spillage == "Yes")
				mob_climax_partner(picked_organ, partner, TRUE, FALSE, FALSE)
			else
				mob_climax_partner(picked_organ, partner, FALSE, FALSE, FALSE)
		else
			to_chat(src, "<span class='warning'>You cannot do this alone.</span>")
			return
	else //They either lack organs that can masturbate, or they didn't pick one.
		to_chat(src, "<span class='warning'>You cannot climax without choosing genitals.</span>")
		return



/mob/living/carbon/human/proc/climaxover(mob/living/T)

	var/mob/living/carbon/human/L = T
	var/obj/item/organ/genital/picked_organ
	picked_organ = pick_climax_genitals()
	if(picked_organ)
		src << browse(null, "window=arousal") //alls fine, we can close the window now.
		var/mob/living/partner = L
		if(partner)
			var/obj/item/organ/genital/penis/P = picked_organ
			if(P.condom == 1)
				to_chat(src, "<span class='warning'>You cannot do this action with a condom on.</span>")
				return
			if(P.sounding == 1)
				to_chat(src, "<span class='warning'>You cannot do this action with a sounding in.</span>")
				return
			mob_climax_partner(picked_organ, partner, FALSE, FALSE, TRUE)
		else
			to_chat(src, "<span class='warning'>You cannot do this alone.</span>")
			return
	else //They either lack organs that can masturbate, or they didn't pick one.
		to_chat(src, "<span class='warning'>You cannot climax without choosing genitals.</span>")
		return

/mob/living/carbon/human/proc/clothesplosion()
	if(usr.restrained(TRUE))
		to_chat(usr, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/mob/living/carbon/human/H = src
	var/items = H.get_contents()
	for(var/obj/item/W in items)
		if(W == H.w_uniform || W == H.wear_suit)
			H.dropItemToGround(W, TRUE)
			playsound(H.loc, 'sound/items/poster_ripped.ogg', 50, 1)
	H.visible_message("<span class='boldnotice'>[H] explodes out of their clothes!'</span>")



/mob/living/carbon/human/proc/impregwith(mob/living/T)

	var/mob/living/carbon/human/L = pick_partner()
	var/obj/item/organ/genital/picked_organ
	picked_organ = src.getorganslot("penis") //Impregnation must be done with a penis.
	if(picked_organ)
		var/mob/living/partner = L
		if(partner)
			if(!partner.breedable)//check if impregable.
				to_chat(src, "<span class='warning'>Your partner cannot be impregnated.</span>")//some fuckary happening, you shouldnt even get to this point tbh.
				return
			var/obj/item/organ/genital/penis/P = picked_organ
			 //you cant impreg with a condom on or sounding in.
			if(P.condom == 1)
				to_chat(src, "<span class='warning'>You cannot do this action with a condom on.</span>")
				return
			if(P.sounding == 1)
				to_chat(src, "<span class='warning'>You cannot do this action with a sounding in.</span>")
				return
			src << browse(null, "window=arousal") //alls fine, we can close the window now.
			//Keeping this for messy fun
			var/spillage = input(src, "Would your fluids spill outside?", "Choose overflowing option", "Yes") as anything in list("Yes", "No")
			if(spillage == "Yes")
				mob_climax_partner(picked_organ, partner, TRUE, TRUE, FALSE)
			else
				mob_climax_partner(picked_organ, partner, FALSE, TRUE, FALSE)
		else
			to_chat(src, "<span class='warning'>You cannot do this alone.</span>")
			return
	else //no penis :(
		to_chat(src, "<span class='warning'>You cannot impregnate without a penis.</span>")
		return

/mob/living/carbon/human/proc/cumcontainer(mob/living/T)
	//We'll need hands and no restraints.
	if(restrained(TRUE)) //TRUE ignores grabs
		to_chat(src, "<span class='warning'>You can't do that while restrained!</span>")
		return
	var/free_hands = get_num_arms()
	if(!free_hands)
		to_chat(src, "<span class='warning'>You need at least one free arm.</span>")
		return
	for(var/helditem in held_items)//how many hands are free
		if(isobj(helditem))
			free_hands--
	if(free_hands <= 0)
		to_chat(src, "<span class='warning'>You're holding too many things.</span>")
		return
	//We got hands, let's pick an organ
	var/obj/item/organ/genital/picked_organ
	src << browse(null, "window=arousal")
	picked_organ = pick_climax_genitals() //Gotta be climaxable, not just masturbation, to fill with fluids.
	if(picked_organ)
		//Good, got an organ, time to pick a container
		var/obj/item/reagent_containers/fluid_container = pick_climax_container()
		if(fluid_container)
			mob_fill_container(picked_organ, fluid_container)
			return
		else
			to_chat(src, "<span class='warning'>You cannot do this without anything to fill.</span>")
			return
	else //They either lack organs that can climax, or they didn't pick one.
		to_chat(src, "<span class='warning'>You cannot fill anything without choosing genitals.</span>")
		return

/atom/proc/add_cum_overlay() //This can go in a better spot, for now its here.
	cum_splatter_icon = icon(initial(icon), initial(icon_state), , 1)
	cum_splatter_icon.Blend("#fff", ICON_ADD)
	cum_splatter_icon.Blend(icon('hyperstation/icons/effects/cumoverlay.dmi', "cum_obj"), ICON_MULTIPLY)
	add_overlay(cum_splatter_icon)

/atom/proc/wash_cum()
	cut_overlay(mutable_appearance('hyperstation/icons/effects/cumoverlay.dmi', "cum_normal"))
	cut_overlay(mutable_appearance('hyperstation/icons/effects/cumoverlay.dmi', "cum_large"))
	if(cum_splatter_icon)
		cut_overlay(cum_splatter_icon)
	return TRUE

/mob/living/carbon/human/proc/genitalfeed(mob/living/L, mb_time = 30)
	if(isliving(L)) //is your target living? Living people can resist your advances if they want to via moving.
		if(iscarbon(L))
			var/obj/item/organ/genital/picked_organ
			var/total_fluids = 0
			var/datum/reagents/fluid_source = null
			src << browse(null, "window=arousal")
			picked_organ = pick_climax_genitals() //Gotta be climaxable, not just masturbation, to fill with fluids.
			if(picked_organ)
				//Good, got an organ, time to pick a container
				if(picked_organ.name == "penis")//if the select organ is a penis
					var/obj/item/organ/genital/penis/P = src.getorganslot("penis")
					if(P.condom) //if the penis is condomed
						to_chat(src, "<span class='warning'>You cannot feed someone when there is a condom over your [picked_organ.name].</span>")
						return
					if(P.sounding) //if the penis is sounded
						to_chat(src, "<span class='warning'>You cannot feed someone when there is a rod inside your [picked_organ.name].</span>")
						return
				if(picked_organ.producing) //Can it produce its own fluids, such as breasts?
					fluid_source = picked_organ.reagents
				else
					if(!picked_organ.linked_organ)
						to_chat(src, "<span class='warning'>Your [picked_organ.name] is unable to produce it's own fluids, it's missing the organs for it.</span>")
						return
					fluid_source = picked_organ.linked_organ.reagents
				total_fluids = fluid_source.total_volume

				src.visible_message("<span class='love'>[src] starts to feed [L.name] with their [picked_organ.name].</span>", \
									"<span class='userlove'>You feed [L.name] with your [picked_organ.name].</span>")
				if(do_after(src, mb_time, target = src) && in_range(src, L))
					fluid_source.trans_to(L, total_fluids)
					src.visible_message("<span class='love'>[src] uses [p_their()] [picked_organ.name] to feed [L.name]!</span>", \
										"<span class='userlove'>You used your [picked_organ.name] to feed [L.name] a total of [total_fluids]u's.</span>")
					SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
					if(picked_organ.can_climax)
						setArousalLoss(min_arousal)

			else //They either lack organs that can climax, or they didn't pick one.
				to_chat(src, "<span class='warning'>You cannot fill anything without choosing exposed genitals.</span>")
				return

/mob/living/carbon/human/proc/genitalfeedfrom(mob/living/target, mb_time = 30)
	var/mob/living/carbon/human/L = target
	var/obj/item/organ/genital/picked_organ
	var/total_fluids = 0
	var/datum/reagents/fluid_source = null
	src << browse(null, "window=arousal")

	var/list/genitals_list = list()
	var/list/worn_stuff = L.get_equipped_items()

	for(var/obj/item/organ/genital/G in L.internal_organs)
		if(G.can_climax) //filter out what you can't masturbate with
			if(G.is_exposed(worn_stuff)) //Nude or through_clothing
				if(!G.dontlist)
					genitals_list += G
	if(genitals_list.len)
		picked_organ = input(src, "with what?", "Climax", null)  as null|obj in genitals_list
	else
		return
	
	if(picked_organ)
		//Good, got an organ, time to pick a container
		if(picked_organ.name == "penis")//if the select organ is a penis
			var/obj/item/organ/genital/penis/P = L.getorganslot("penis")
			if(P.condom) //if the penis is condomed
				to_chat(src, "<span class='warning'>You cannot feed from [picked_organ.name] when there is a condom over it.</span>")
				return
			if(P.sounding) //if the penis is sounded
				to_chat(src, "<span class='warning'>You cannot feed from [picked_organ.name] when there is a rod inside it.</span>")
				return
		if(picked_organ.producing) //Can it produce its own fluids, such as breasts?
			fluid_source = picked_organ.reagents
		else
			if(!picked_organ.linked_organ)
				to_chat(src, "<span class='warning'>The [picked_organ.name] is unable to produce it's own fluids, it's missing the organs for it.</span>")
				return
			fluid_source = picked_organ.linked_organ.reagents
		total_fluids = fluid_source.total_volume

		src.visible_message("<span class='love'>[src] starts to feed from [L.name]'s [picked_organ.name].</span>", \
							"<span class='userlove'>You feed from [L.name]'s '[picked_organ.name].</span>")
		if(do_after(src, mb_time, target = src) && in_range(src, L))
			fluid_source.trans_to(src, total_fluids)
			src.visible_message("<span class='love'>[src] feeds from [L.name]'s [picked_organ.name]!</span>", \
								"<span class='userlove'>You used [L.name]'s [picked_organ.name] to feed with a total of [total_fluids]u's.</span>")
			SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
			if(picked_organ.can_climax)
				L.setArousalLoss(min_arousal)

	else //They either lack organs that can climax, or they didn't pick one.
		to_chat(src, "<span class='warning'>You cannot fill anything without choosing exposed genitals.</span>")
		return

/mob/living/carbon/human/proc/genitalfeedyourself(mb_time = 30)
	var/obj/item/organ/genital/picked_organ
	var/total_fluids = 0
	var/datum/reagents/fluid_source = null
	src << browse(null, "window=arousal")
	picked_organ = pick_climax_genitals() //Gotta be climaxable, not just masturbation, to fill with fluids.
	if(picked_organ)
		//Good, got an organ, time to pick a container
		if(picked_organ.name == "penis")//if the select organ is a penis
			var/obj/item/organ/genital/penis/P = src.getorganslot("penis")
			if(P.condom) //if the penis is condomed
				to_chat(src, "<span class='warning'>You cannot feed yourself when there is a condom over your [picked_organ.name].</span>")
				return
			if(P.sounding) //if the penis is sounded
				to_chat(src, "<span class='warning'>You cannot feed yourself when there is a rod inside your [picked_organ.name].</span>")
				return
		if(picked_organ.producing) //Can it produce its own fluids, such as breasts?
			fluid_source = picked_organ.reagents
		else
			if(!picked_organ.linked_organ)
				to_chat(src, "<span class='warning'>Your [picked_organ.name] is unable to produce it's own fluids, it's missing the organs for it.</span>")
				return
			fluid_source = picked_organ.linked_organ.reagents
		total_fluids = fluid_source.total_volume

		src.visible_message("<span class='love'>[src] starts to feed themselves with their [picked_organ.name].</span>", \
							"<span class='userlove'>You feed yourself with your [picked_organ.name].</span>")
		if(do_after(src, mb_time))
			fluid_source.trans_to(src, total_fluids)
			src.visible_message("<span class='love'>[src] uses [p_their()] [picked_organ.name] to feed themselves!</span>", \
								"<span class='userlove'>You used your [picked_organ.name] to feed yourself a total of [total_fluids]u's.</span>")
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
			if(picked_organ.can_climax)
				setArousalLoss(min_arousal)

	else //They either lack organs that can climax, or they didn't pick one.
		to_chat(src, "<span class='warning'>You cannot fill anything without choosing exposed genitals.</span>")
		return
