/**
 * Contains:
 * Industrial Feeding Tube 
 */

/obj/structure/disposaloutlet/industrial_feeding_tube
	name = "\improper industrial feeding tube"
	desc = "An imposing machine designed to pump an absurd amount of food down something's throat. It seems to connect to disposal pipes."
	icon = 'GainStation13/icons/obj/feeding_tube.dmi'
	icon_state = "feeding_tube"
	anchored = FALSE
	/// Is it welded down?
	var/welded = FALSE
	///	Who the tube is attached to
	var/mob/living/attached 
	/// Where the tube tries to dump it's stuff into
	var/output_dest
	/// It's Glogged !
	var/clogged = FALSE
	/// This is made using a feeding tube
	var/obj/machinery/iv_drip/feeding_tube/storedFeeder //Really wish I could redefine stored.

/obj/structure/disposaloutlet/industrial_feeding_tube/Initialize(mapload, obj/machinery/iv_drip/feeding_tube/make_from)
	. = ..()
	if(make_from)
		make_from.forceMove(src)
		storedFeeder = make_from
	else
		storedFeeder = new /obj/machinery/iv_drip/feeding_tube(src)

	trunk = locate() in loc
	if(trunk)
		trunk.linked = src	// link the pipe trunk to self
		anchored = TRUE
		welded = TRUE //Make it functional

/obj/structure/disposaloutlet/industrial_feeding_tube/CheckParts(list/parts_list)
	..()
	storedFeeder = locate(/obj/machinery/iv_drip/feeding_tube) in contents

/obj/structure/disposaloutlet/industrial_feeding_tube/Destroy()
	if(attached)
		attached = null
	if(output_dest)
		output_dest = null
	QDEL_NULL(storedFeeder)
	return ..()

/obj/structure/disposaloutlet/industrial_feeding_tube/MouseDrop(mob/living/target)
	. = ..()
	if(!usr.canUseTopic(src, BE_CLOSE) || !isliving(target))
		return

	if(!anchored || !welded)
		to_chat(usr, "<span class='warning'>You need to anchor down \the [src] before you can use it.</span>")
		return

	if(attached)
		attached.visible_message("<span class='warning'>[attached] is detached from [src].</span>")
		attached = null
		update_icon()
		return		
	
	if(iscarbon(target))
		var/mob/living/carbon/feedee

		if(HAS_TRAIT(feedee, TRAIT_TRASHCAN) || feedee)
			var/food_dump = input("Where do you shove the tube? (cancel for it to just feed normally)", "Select belly") as null|anything in feedee.vore_organs
			if(!food_dump || !isbelly(food_dump))
				output_dest = feedee //Attach normally
			else
				output_dest = food_dump //Attach to vorebelly

		attached = feedee
		update_icon()
		START_PROCESSING(SSmachines, src)
		return

/obj/structure/disposaloutlet/industrial_feeding_tube/process()
	if(!attached)
		return PROCESS_KILL

	if(!(get_dist(src, attached) <= 1 && isturf(attached.loc)))
		to_chat(attached, "<span class='userdanger'>The feeding hose is yanked out of you!</span>")
		attached = null
		output_dest = null
		update_icon()
		return PROCESS_KILL

	//face_atom(attached)

/obj/structure/disposaloutlet/industrial_feeding_tube/update_icon()
	// A lot of this is temp. More likely than not you shouldnt see this comment as it'll be properly updated when reo PRs this.
	// Or it wont because epic fail :333
	if(attached)
		icon_state = "injecting" //Temp. Change it when proper icons are made
	else
		icon_state = "injectidle" //Temp.

	cut_overlays()


	
	

// expel the contents of the holder object, then delete it
// called when the holder exits the outlet
/obj/structure/disposaloutlet/industrial_feeding_tube/expel(obj/structure/disposalholder/H)
	var/clunkVol = LAZYLEN(H.contents)
	if(H.hasmob) //Uh oh- 
		clunkVol += 25
	playsound(src, H.hasmob ? "clang" : "clangsmall", clamp(clunkVol, 5, H.hasmob ? 50 : 25))
	H.active = FALSE
	if(clogged)
		clog(H.contents)
	if(!attached)
		//flick("ind-tube-spew", src)
		
		addtimer(CALLBACK(src,PROC_REF(expel_holder), H, TRUE), 5)
		return

	
	if(isliving(output_dest))
		var/list/not_food = list()
		var/turf/T = get_turf(src)

		for(var/atom/movable/AM in H)
			if(istype(AM, /obj/item/reagent_containers/food/snacks))
				var/obj/item/reagent_containers/food/snacks/food = AM

				var/datum/reagents/food_reagents = food.reagents
				if(food_reagents.total_volume)
					var/food_size = food_reagents.total_volume //We're cramming the Whole Thing down your throat~

					SEND_SIGNAL(food, COMSIG_FOOD_EATEN, attached)

					food_reagents.reaction(attached, INGEST, food_size)
					food_reagents.trans_to(attached, food_size)

					food.checkLiked(food_size, attached) //...Hopefully you like the taste.

				if(food.trash) //Lets make the trash the food's supposed to make, if it has any
					var/obj/item/trash = food.generate_trash(src)
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
	if(user.a_intent == INTENT_HARM)
		return ..()
	switch(I.tool_behaviour)
		if(TOOL_WRENCH)
			if(welded)
				to_chat(user, "<span class='warning'>\The [src] is firmly welded to the floor. Cut the floorwelds before trying to unwrench it!</span>")
			var/turf/T = get_turf(src)
			if(!T.intact || !isfloorturf(T))
				to_chat(user, "<span class='warning'>You need to remove the floor tiles before detaching \the [src]!</span>")
				return
			if(anchored)
				I.play_tool_sound(src, 100)
				anchored = !anchored
				trunk.linked = null
				trunk = null
				attached = null
				output_dest = null
				user.visible_message("<span class='notice'>[user] detaches \the [src] from the floor!</span>")
				return
			else
				var/found_trunk = FALSE
				for(var/obj/structure/disposalpipe/P in T)
					if(istype(P, /obj/structure/disposalpipe/trunk))
						found_trunk = TRUE
						break
				if(!found_trunk)
					to_chat(user, "<span class='warning'>\The [src] requires a trunk underneath it in order to work!</span>")
					return

				to_chat(user, "<span class='notice'>You attach \the [src] to the trunk.</span>")
				return

			I.play_tool_sound(src, 100)
			update_icon()
			return

		if(TOOL_CROWBAR)
			if(!clogged)
				to_chat(user, "<span class='notice'>\The [src] doesnt seem to be clogged at the moment...")
				return
			
			user.visible_message("<span class='italics'>[user] inserts [user.p_their()] [I] into the maintenance hatch of \the [src], attempting to unclog it...</span>")
			if(do_after(user, 30, TRUE, src))
				user.visible_message("<span class='notice'>[user] unclogs \the [src]!</span>")
				unclog()
	
	. = ..()

/obj/structure/disposaloutlet/industrial_feeding_tube/proc/clog(list/clog_junk)
	for(var/atom/movable/AM in clog_junk)
		AM.forceMove(src)
	clogged = TRUE
	playsound(src, 'sound/machines/warning-buzzer.ogg', 50, 1)

/obj/structure/disposaloutlet/industrial_feeding_tube/proc/unclog()
	
	var/turf/T = get_turf(src)
	for(var/atom/movable/AM in src)
		if(AM == storedFeeder)	// We need to keep this...
			continue

		target = get_offset_target_turf(loc, rand(2)-rand(2), rand(2)-rand(2))

		AM.forceMove(T)
		AM.pipe_eject(dir)
		AM.throw_at(target, eject_range, 1)

/obj/structure/disposaloutlet/industrial_feeding_tube/welder_act(mob/living/user, obj/item/I)
	if(!I.tool_start_check(user, amount=0))
		return
	if(anchored)
		var/turf/T = get_turf(src)
		if(!welded) // If we're attaching it, we need to check for the pipe we're attaching to
			var/found_trunk = FALSE
			for(var/obj/structure/disposalpipe/P in T)
				if(istype(P, /obj/structure/disposalpipe/trunk))
					found_trunk = TRUE
					break
			if(!found_trunk) // No pipe, no attach.
				to_chat(user, "<span class='notice'>\The [src] needs to be welded to a trunk!</span>")
				return
		
		to_chat(user, welded ? "<span class='notice'>You start slicing the floorweld off \the [src]...</span>" : "<span class='notice'>You start welding \the [src] in place...</span>")
		playsound(src, 'sound/items/welder2.ogg', 100, 1)
		if(I.use_tool(src, user, 20))
			if(welded)
				to_chat(user, "<span class='notice'>You slice the floorweld off [src].</span>")
				welded = FALSE
				return
			else
				to_chat(user, "<span class='notice'>You weld \the [src] to the floor.</span>")
				welded = TRUE
				trunk = locate(/obj/structure/disposalpipe/trunk) in T
				trunk.linked = src
				return
			
		
	else
		to_chat(user, "<span class='notice'>You begin deconstructing \the [src]</span>")
		if(I.use_tool(src, user, 30))
			deconstruct(TRUE)
	return

/obj/structure/disposaloutlet/industrial_feeding_tube/deconstruct(disassembled)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(storedFeeder)
			storedFeeder.forceMove(loc) //Lets get our Feeder back
			transfer_fingerprints_to(storedFeeder)
			storedFeeder = null
		else
			var/feeder = new /obj/machinery/iv_drip/feeding_tube(loc)
			transfer_fingerprints_to(feeder)
		new /obj/item/stack/sheet/metal(loc, 2)
		new /obj/item/pipe(loc)
		new /obj/item/pipe(loc)
	if(contents) //Anything still glogged inside...
		for(var/atom/movable/AM in src)
			AM.forceMove(loc)
	qdel(src)
	