//GS13!

#define FEEDTUBE_TAKING 0
#define FEEDTUBE_INJECTING 1

/obj/machinery/feeding_tube
	name = "\improper Feeding Tube"
	desc = "something something test."
	icon = 'icons/obj/feeding_tube.dmi'
	icon_state = "feeding_tube"
	anchored = FALSE
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	var/mob/living/carbon/attached
	var/mode = FEEDTUBE_INJECTING
	var/obj/item/reagent_containers/beaker
	var/static/list/drip_containers = typecacheof(list(/obj/item/reagent_containers/food,
									/obj/item/reagent_containers/glass,))
/obj/machinery/feeding_tube/Initialize(mapload)
	. = ..()
	update_icon()
	
/obj/machinery/feeding_tube/Destroy()
	attached = null
	QDEL_NULL(beaker)
	return ..()

/obj/machinery/feeding_tube/update_icon()
	if(attached)
		if(mode)
			icon_state = "injecting"
	else
		if(mode)
			icon_state = "injectidle"

	cut_overlays()

	if(beaker)
		if(attached)
			add_overlay("beakeractive")
		else
			add_overlay("beakeridle")
		if(beaker.reagents.total_volume)
			var/mutable_appearance/filling_overlay = mutable_appearance('icons/obj/feeding_tube.dmi', "reagent")

			var/percent = round((beaker.reagents.total_volume / beaker.volume) * 100)
			switch(percent)
				if(0 to 9)
					filling_overlay.icon_state = "reagent0"
				if(10 to 24)
					filling_overlay.icon_state = "reagent10"
				if(25 to 49)
					filling_overlay.icon_state = "reagent25"
				if(50 to 74)
					filling_overlay.icon_state = "reagent50"
				if(75 to 79)
					filling_overlay.icon_state = "reagent75"
				if(80 to 90)
					filling_overlay.icon_state = "reagent80"
				if(91 to INFINITY)
					filling_overlay.icon_state = "reagent100"

			filling_overlay.color = mix_color_from_reagents(beaker.reagents.reagent_list)
			add_overlay(filling_overlay)

/obj/machinery/feeding_tube/MouseDrop(mob/living/target)
	. = ..()
	if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE) || !isliving(target))
		return

	if(attached)
		visible_message("<span class='warning'>[attached] is detached from [src]'s mouth.</span>")
		attached = null
		update_icon()
		return

	if(!target.has_dna())
		to_chat(usr, "<span class='danger'>The hose beeps: Warning, incompatible creature!</span>")
		return

	if(Adjacent(target) && usr.Adjacent(target))
		if(beaker)
			usr.visible_message("<span class='warning'>[usr] attaches [src] to [target].</span>", "<span class='notice'>You attach [src] to [target]'s mouth.</span>")
			log_combat(usr, target, "attached", src, "containing: [beaker.name] - ([beaker.reagents.log_list()])")
			add_fingerprint(usr)
			attached = target
			START_PROCESSING(SSmachines, src)
			update_icon()
		else
			to_chat(usr, "<span class='warning'>There's nothing attached to the feeding hose!</span>")


/obj/machinery/feeding_tube/attackby(obj/item/W, mob/user, params)
	if(is_type_in_typecache(W, drip_containers))
		if(beaker)
			to_chat(user, "<span class='warning'>There is already a reagent container loaded!</span>")
			return
		if(!user.transferItemToLoc(W, src))
			return
		beaker = W
		to_chat(user, "<span class='notice'>You attach [W] to [src]'s mouth.</span>")
		user.log_message("attached a [W] to [src] at [AREACOORD(src)] containing ([beaker.reagents.log_list()])", LOG_ATTACK)
		add_fingerprint(user)
		update_icon()
		return
	else
		return ..()

/obj/machinery/feeding_tube/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/sheet/metal(loc)
	qdel(src)

/obj/machinery/feeding_tube/process()
	if(!attached)
		return PROCESS_KILL

	if(!(get_dist(src, attached) <= 1 && isturf(attached.loc)))
		to_chat(attached, "<span class='userdanger'>The feeding hose is yanked out of you!</span>")
		update_icon()
		return PROCESS_KILL

	if(beaker)
		// Give blood
		if(mode)
			if(beaker.reagents.total_volume)
				var/transfer_amount = 5
				if(istype(beaker, /obj/item/reagent_containers/blood))
					// speed up transfer on blood packs
					transfer_amount = 10
				var/fraction = min(transfer_amount/beaker.reagents.total_volume, 1) //the fraction that is transfered of the total volume
				beaker.reagents.reaction(attached, INJECT, fraction, FALSE) //make reagents reacts, but don't spam messages
				beaker.reagents.trans_to(attached, transfer_amount)
				update_icon()

		// // Take blood
		// else
		// 	var/amount = beaker.reagents.maximum_volume - beaker.reagents.total_volume
		// 	amount = min(amount, 4)
		// 	// If the beaker is full, ping
		// 	if(!amount)
		// 		if(prob(5))
		// 			visible_message("[src] pings.")
		// 			playsound(loc, 'sound/machines/beep.ogg', 50, 1)
		// 		return

		// 	// If the human is losing too much blood, beep.
		// 	if(attached.blood_volume < ((BLOOD_VOLUME_SAFE*attached.blood_ratio) && prob(5) && ishuman(attached))) //really couldn't care less about monkeys
		// 		visible_message("[src] beeps loudly.")
		// 		playsound(loc, 'sound/machines/twobeep.ogg', 50, 1)
		// 	attached.transfer_blood_to(beaker, amount)
		// 	update_icon()

/obj/machinery/feeding_tube/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return
	if(attached)
		visible_message("[attached] is detached from [src]'s mouth")
		attached = null
		update_icon()
		return
	else if(beaker)
		eject_beaker(user)
	// else
	// 	toggle_mode()

/obj/machinery/feeding_tube/verb/eject_beaker()
	set category = "Object"
	set name = "Remove Feeding Container"
	set src in view(1)

	if(!isliving(usr))
		to_chat(usr, "<span class='warning'>You can't do that!</span>")
		return

	if(usr.incapacitated())
		return
	if(beaker)
		if(usr && Adjacent(usr) && !issiliconoradminghost(usr))
			if(!usr.put_in_hands(beaker))
				beaker.forceMove(drop_location())
		beaker = null
		update_icon()

// /obj/machinery/feeding_tube/verb/toggle_mode()
// 	set category = "Object"
// 	set name = "Toggle Mode"
// 	set src in view(1)

// 	if(!isliving(usr))
// 		to_chat(usr, "<span class='warning'>You can't do that!</span>")
// 		return

// 	if(usr.incapacitated())
// 		return
// 	mode = !mode
// 	to_chat(usr, "The feeding hose is now [mode ? "injecting" : "taking blood"].")
// 	update_icon()

/obj/machinery/feeding_tube/examine(mob/user)
	. = ..()
	if(get_dist(user, src) > 2)
		return

	. += "[src] is pumping liquid.\n"

	if(beaker)
		if(beaker.reagents && beaker.reagents.reagent_list.len)
			. += "\t<span class='notice'>Attached is \a [beaker] with [beaker.reagents.total_volume] units of liquid.</span>\n"
		else
			. += "\t<span class='notice'>Attached is an empty [beaker.name].</span>\n"
	else
		. += "\t<span class='notice'>No chemicals are attached.</span>\n"

	. += "\t<span class='notice'>[attached ? attached : "No one"] is attached.</span>"

#undef FEEDTUBE_TAKING
#undef FEEDTUBE_INJECTING
