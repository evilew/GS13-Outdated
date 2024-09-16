/**
 * Contains:
 * Industrial Feeding Tube 
 */

/obj/structure/disposaloutlet/industrial_feeding_tube
	name = "industrial feeding tube"
	desc = ""
	icon = 'icons/obj/atmospherics/pipes/disposal.dmi'
	icon_state = "outlet"
	anchored = FALSE
	var/turf/target	// this will be where the output objects are 'thrown' to.
	var/attached //Where the tube tries to splort out into
	var/obj/machinery/iv_drip/feeding_tube/stored //This is made using a feeding tube 
	var/start_eject = 0
	var/eject_range = 2

/obj/structure/disposaloutlet/industrial_feeding_tube/Initialize(mapload, obj/machinery/iv_drip/feeding_tube/make_from)
	. = ..()
	if(make_from)
		make_from.forceMove(src)
		stored = make_from
	else
		stored = new /obj/machinery/iv_drip/feeding_tube

	trunk = locate() in loc
	if(trunk)
		trunk.linked = src	// link the pipe trunk to self
		anchored = TRUE

/obj/machinery/disposaloutlet/industrial_feeding_tube/MouseDrop(mob/living/target)
	. = ..()
	if(!isliving(usr) || !usr.canUseTopic(src, BE_CLOSE) || !isliving(target))
		return

	if(attached)
		visible_message("<span class='warning'>[attached] is detached from [src].</span>")
		attached = null
		update_icon()
		return
	
	if(!Adjacent(target) || !usr.Adjacent(target))
		return
			

	if(!target.has_dna())
		to_chat(usr, "<span class='danger'>[src] beeps: Warning, incompatible creature!</span>")
		return

	if(Adjacent(target) && usr.Adjacent(target))
		if(beaker)
			usr.visible_message("<span class='warning'>[usr] attaches [src] to [target].</span>", "<span class='notice'>You attach [src] to [target].</span>")
			log_combat(usr, target, "attached", src, "containing: [beaker.name] - ([beaker.reagents.log_list()])")
			add_fingerprint(usr)
			attached = target
			START_PROCESSING(SSmachines, src)
			update_icon()
		else
			to_chat(usr, "<span class='warning'>There's nothing attached to [src]!</span>") //gs13 edit
	
	if(iscarbon(target))
		var/mob/living/carbon/feedee
		if(HAS_TRAIT(feedee, TRAIT_TRASHCAN))
			var/food_dump = input("Where do you shove the tube?", "Select belly") as null|anything in feedee.vore_organs
			if(!food_dump || !istype(food_dump, /obj/belly))
				attached = target //Attach normally
				return
			else
				attached = food_dump
			

// expel the contents of the holder object, then delete it
// called when the holder exits the outlet
/obj/structure/disposaloutlet/industrial_feeding_tube/expel(obj/structure/disposalholder/H)
	H.active = FALSE
	flick("outlet-open", src)
	if((start_eject + 30) < world.time)
		start_eject = world.time
		playsound(src, 'sound/machines/warning-buzzer.ogg', 50, 0, 0)
		addtimer(CALLBACK(src,PROC_REF(expel_holder), H, TRUE), 20)
	else
		addtimer(CALLBACK(src,PROC_REF(expel_holder), H), 20)

/obj/structure/disposaloutlet/proc/expel_holder(obj/structure/disposalholder/H, playsound=FALSE)
	if(playsound)
		playsound(src, 'sound/machines/hiss.ogg', 50, 0, 0)

	if(!H)
		return

	var/turf/T = get_turf(src)

	for(var/A in H)
		var/atom/movable/AM = A
		AM.forceMove(T)
		AM.pipe_eject(dir)
		AM.throw_at(target, eject_range, 1)

	H.vent_gas(T)
	qdel(H)

/obj/structure/disposaloutlet/welder_act(mob/living/user, obj/item/I)
	if(!I.tool_start_check(user, amount=0))
		return TRUE

	playsound(src, 'sound/items/welder2.ogg', 100, 1)
	to_chat(user, "<span class='notice'>You start slicing the floorweld off [src]...</span>")
	if(I.use_tool(src, user, 20))
		to_chat(user, "<span class='notice'>You slice the floorweld off [src].</span>")
		stored.forceMove(loc)
		transfer_fingerprints_to(stored)
		stored = null
		qdel(src)
	return TRUE
