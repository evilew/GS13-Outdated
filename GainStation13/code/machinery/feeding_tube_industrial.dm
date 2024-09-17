/**
 * Contains:
 * Industrial Feeding Tube 
 */

/obj/structure/disposaloutlet/industrial_feeding_tube
	name = "industrial feeding tube"
	desc = "An imposing machine designed to pump an absurd amount of food down something's throat. It seems to connect to disposal pipes."
	icon = 'icons/obj/atmospherics/pipes/disposal.dmi'
	icon_state = "outlet"
	anchored = FALSE
	var/turf/target	// this will be where the output objects are 'thrown' to.
	///	Who the tube is attached to
	var/mob/living/attached 
	/// Where the tube tries to dump it's stuff into
	var/output_dest
	/// It's Glogged !
	var/clogged = FALSE
	/// This is made using a feeding tube
	var/obj/machinery/iv_drip/feeding_tube/stored  
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
	if(!usr.canUseTopic(src, BE_CLOSE) || !isliving(target))
		return

	if(attached)
		attached.visible_message("<span class='warning'>[attached] is detached from [src].</span>")
		attached = null
		update_icon()
		return		

	if(Adjacent(target) && usr.Adjacent(target))
		if(beaker)
			usr.visible_message("<span class='warning'>[usr] attaches [src] to [target].</span>", "<span class='notice'>You attach [src] to [target].</span>")
			log_combat(usr, target, "attached", src, "containing: [beaker.name] - ([beaker.reagents.log_list()])")
			add_fingerprint(usr)
			attached = target
			update_icon()
		else
			to_chat(usr, "<span class='warning'>There's nothing attached to [src]!</span>") //gs13 edit
	
	if(iscarbon(target))
		var/mob/living/carbon/feedee

		if(HAS_TRAIT(feedee, TRAIT_TRASHCAN) || feedee)
			var/food_dump = input("Where do you shove the tube? (cancel for it to just feed normally)", "Select belly") as null|anything in feedee.vore_organs
			if(!food_dump || !isbelly(food_dump))
				output_dest = feedee //Attach normally
			else
				output_dest = food_dump //Attach to vorebelly

		attached = feedee
		START_PROCESSING(SSmachines, src)
		return

// expel the contents of the holder object, then delete it
// called when the holder exits the outlet
/obj/structure/disposaloutlet/industrial_feeding_tube/expel(obj/structure/disposalholder/H)
	var/clunkVol = LAZYLEN(H.contents)
	if(H.hasmob) //Uh oh- 
		clunkVol += 25
	playsound(src, H.hasmob ? "clang" : "clangsmall", clamp(clunkVol, 5, H.hasmob ? 50, 25))
	H.active = FALSE
	if(clogged)
		clog(H.contents)
	if(!attached)
		flick("ind-tube-spew", src)
		
		addtimer(CALLBACK(src,PROC_REF(expel_holder), H, TRUE), 5)
		return

	
	if(isliving(output_dest))
		var/list/not_food = list()
		var/turf/T = get_turf(src)

		for(var/atom/movable/AM in H)
			if(istype(AM, /obj/item/reagent_containers/food/snacks))
				var/obj/item/reagent_containers/food/snacks/food = AM

				var/food_reagents = food.reagents
				if(food_reagents.total_volume)
					var/food_size = food_reagents.total_volume //We're cramming the Whole Thing down your throat~

					SEND_SIGNAL(food, COMSIG_FOOD_EATEN, attached)

					food_reagents.reaction(attached, INGEST, food_size)
					food_reagents.trans_to(attached, food_size)

					food.checkLiked(food_size, attached) //...Hopefully you like the taste.

				if(food.trash) //Lets make the trash the food's supposed to make, if it has any
					var/trash = food.generate_trash(src)
					if(not_food)
						not_food += trash // If it's already going to get clogged, clog it more with the trash
					else
						trash.forceMove(T) // Otherwise move it to the tile. For convinience

				qdel(food) //Gulp...
				continue

			else
				not_food += AM // That's not (traditionally) edible!

		if(not_food)
			clog(not_food) // Now you've gone and clogged us...
		H.vent_gas(T)
		qdel(H)
		return

	if(isbelly(output_dest))
		var/list/inedible //Some things shouldnt be eaten...
		var/turf/T = get_turf(src)

		for(var/atom/movable/AM in H)
			if(isliving(AM))
				var/mob/living/cutie = AM
				if(cutie.devourable != TRUE) //Do not eat this QT...
					inedible += cutie
					continue

			AM.forceMove(attached)
		if(inedible)
			clog(inedible)
		
		H.vent_gas(T)
		qdel(H)

/obj/structure/disposaloutlet/industrial_feeding_tube/expel_holder(obj/structure/disposalholder/H, playsound=FALSE)
	if(playsound)
		playsound(src, 'sound/machines/hiss.ogg', 50, 0, 0)

	if(!H)
		return

	var/turf/T = get_turf(src)

	for(var/A in H)
		var/atom/movable/AM = A

		target = get_offset_target_turf(loc, rand(5)-rand(5), rand(5)-rand(5))

		AM.forceMove(T)
		AM.pipe_eject(dir)
		AM.throw_at(target, eject_range, 1)

	H.vent_gas(T)
	qdel(H)

/obj/structure/disposaloutlet/industrial_feeding_tube/attack_hand(mob/user)
	. = ..()
	if(attached)
		attached.visible_message("<span class='warning'>[attached] is detached from [src].</span>")
		attached = null
		update_icon()
		return		

/obj/structure/disposaloutlet/industrial_feeding_tube/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_CROWBAR)
		user.visible_message("")
		if(do_after(user, 30, TRUE, src))
			unclog()

/obj/structure/disposaloutlet/industrial_feeding_tube/proc/clog(list/clog_junk)
	for(var/atom/movable/AM in clog_junk)
		AM.forceMove(src)
	clogged = TRUE
	playsound(src, 'sound/machines/warning-buzzer.ogg', 50, 1)

/obj/structure/disposaloutlet/industrial_feeding_tube/proc/unclog()

	for(var/atom/movable/AM in src)

		target = get_offset_target_turf(loc, rand(5)-rand(5), rand(5)-rand(5))

		AM.forceMove(T)
		AM.pipe_eject(dir)
		AM.throw_at(target, eject_range, 1)


/obj/structure/disposaloutlet/industrial_feeding_tube/welder_act(mob/living/user, obj/item/I)
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
