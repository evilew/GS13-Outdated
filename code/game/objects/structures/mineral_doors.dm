//NOT using the existing /obj/machinery/door type, since that has some complications on its own, mainly based on its
//machineryness

/obj/structure/mineral_door
	name = "metal door"
	density = TRUE
	anchored = TRUE
	opacity = TRUE

	icon = 'icons/obj/doors/mineral_doors.dmi'
	icon_state = "metal"

	var/initial_state
	var/state = 0 //closed, 1 == open
	var/isSwitchingStates = 0
	var/close_delay = -1 //-1 if does not auto close.
	max_integrity = 200
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 100, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 50, "acid" = 50)
	var/sheetType = /obj/item/stack/sheet/metal
	var/sheetAmount = 7
	var/openSound = 'sound/effects/stonedoor_openclose.ogg'
	var/closeSound = 'sound/effects/stonedoor_openclose.ogg'
	CanAtmosPass = ATMOS_PASS_DENSITY
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	rad_insulation = RAD_MEDIUM_INSULATION

/obj/structure/mineral_door/Initialize()
	. = ..()
	initial_state = icon_state
	air_update_turf(TRUE)

/obj/structure/mineral_door/Move()
	var/turf/T = loc
	. = ..()
	move_update_air(T)

/obj/structure/mineral_door/Bumped(atom/movable/AM)
	..()
	if(!state)
		return TryToSwitchState(AM)

/obj/structure/mineral_door/attack_ai(mob/user) //those aren't machinery, they're just big fucking slabs of a mineral
	if(isAI(user)) //so the AI can't open it
		return
	else if(iscyborg(user)) //but cyborgs can
		if(get_dist(user,src) <= 1) //not remotely though
			return TryToSwitchState(user)

/obj/structure/mineral_door/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/mineral_door/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	return TryToSwitchState(user)

/obj/structure/mineral_door/CanPass(atom/movable/mover, turf/target)
	if(istype(mover, /obj/effect/beam))
		return !opacity
	return !density

/obj/structure/mineral_door/proc/TryToSwitchState(atom/user)
	if(isSwitchingStates)
		return
	if(isliving(user))
		var/mob/living/M = user
		if(world.time - M.last_bumped <= 60)
			return //NOTE do we really need that?
		if(M.client)
			if(iscarbon(M))
				var/mob/living/carbon/C = M
				if(!C.handcuffed)
					SwitchState()
			else
				SwitchState()
	else if(ismecha(user))
		SwitchState()

/obj/structure/mineral_door/proc/SwitchState()
	if(state)
		Close()
	else
		Open()

/obj/structure/mineral_door/proc/Open()
	isSwitchingStates = 1
	playsound(src, openSound, 100, 1)
	set_opacity(FALSE)
	flick("[initial_state]opening",src)
	sleep(10)
	density = FALSE
	state = 1
	air_update_turf(1)
	update_icon()
	isSwitchingStates = 0

	if(close_delay != -1)
		addtimer(CALLBACK(src, .proc/Close), close_delay)

/obj/structure/mineral_door/proc/Close()
	if(isSwitchingStates || state != 1)
		return
	var/turf/T = get_turf(src)
	for(var/mob/living/L in T)
		return
	isSwitchingStates = 1
	playsound(loc, closeSound, 100, 1)
	flick("[initial_state]closing",src)
	sleep(10)
	density = TRUE
	set_opacity(TRUE)
	state = 0
	air_update_turf(1)
	update_icon()
	isSwitchingStates = 0

/obj/structure/mineral_door/update_icon()
	if(state)
		icon_state = "[initial_state]open"
	else
		icon_state = initial_state

/obj/structure/mineral_door/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_MINING)
		to_chat(user, "<span class='notice'>You start digging the [name]...</span>")
		if(I.use_tool(src, user, 40, volume=50))
			to_chat(user, "<span class='notice'>You finish digging.</span>")
			deconstruct(TRUE)
	else if(user.a_intent != INTENT_HARM)
		return attack_hand(user)
	else
		return ..()

/obj/structure/mineral_door/deconstruct(disassembled = TRUE)
	var/turf/T = get_turf(src)
	if(disassembled)
		new sheetType(T, sheetAmount)
	else
		new sheetType(T, max(sheetAmount - 2, 1))
	qdel(src)

/obj/structure/mineral_door/iron
	name = "iron door"
	max_integrity = 300

/obj/structure/mineral_door/silver
	name = "silver door"
	icon_state = "silver"
	sheetType = /obj/item/stack/sheet/mineral/silver
	max_integrity = 300
	rad_insulation = RAD_HEAVY_INSULATION

/obj/structure/mineral_door/gold
	name = "gold door"
	icon_state = "gold"
	sheetType = /obj/item/stack/sheet/mineral/gold
	rad_insulation = RAD_HEAVY_INSULATION

/obj/structure/mineral_door/uranium
	name = "uranium door"
	icon_state = "uranium"
	sheetType = /obj/item/stack/sheet/mineral/uranium
	max_integrity = 300
	light_range = 2

/obj/structure/mineral_door/uranium/ComponentInitialize()
	return


/obj/structure/mineral_door/calorite //GS13
	name = "calorite door"
	icon_state = "paperframe"
	sheetType = /obj/item/stack/sheet/mineral/calorite
	max_integrity = 200
	light_range = 1
	var/fatten = FALSE // whether player will be fattened
	var/fatten_delay = 1 // ticks per periodic loop
	var/fat_to_add = 2 // fatness per tick stunned
	var/stuck = FALSE // whether player is stuck
	var/stuck_delay = 0 // set in proc/Fatten
	var/blocked = FALSE // whether door is blocked

// override /obj/structure/mineral_door/proc/Open()
/obj/structure/mineral_door/calorite/Open() //GS13
	isSwitchingStates = 1
	playsound(src, openSound, 100, 1)
	set_opacity(FALSE)
	flick("[initial_state]opening",src)
	sleep(10)
	density = FALSE
	state = 1
	air_update_turf(1)
	update_icon()
	isSwitchingStates = 0

	if(close_delay != -1)
		addtimer(CALLBACK(src, .proc/Close), close_delay)

	// start periodic loop
	stuck = FALSE
	addtimer(CALLBACK(src, .proc/Fatten), fatten_delay)

/obj/structure/mineral_door/calorite/proc/Fatten() //GS13
	if(state == 1) // door must be open
		// check periodically
		addtimer(CALLBACK(src, .proc/Fatten), fatten_delay)
		// check for mobs in open door
		var/turf/T = get_turf(src)
		blocked = FALSE
		for(var/mob/living/carbon/M in T)
			blocked = TRUE
			// determine if mob should get stuck and be fattened
			if(M.fatness >= FATNESS_LEVEL_BARELYMOBILE)
				fatten = TRUE
				if (!stuck)
					stuck_delay = 120
					M.visible_message(
						"<span class='boldnotice'>[M] gets stuck in the doorway!</span>",
						"<span class='boldwarning'>You feel yourself get stuck in the doorway!</span>")
			else if(M.fatness >= FATNESS_LEVEL_MORBIDLY_OBESE)
				fatten = TRUE
				if (!stuck)
					stuck_delay = 50
					M.visible_message(
						"<span class='boldnotice'>[M] barely squeezes through the doorway!</span>",
						"<span class='boldwarning'>You feel your sides barely squeeze through the doorway!</span>")
			else if(M.fatness >= FATNESS_LEVEL_FATTER)
				fatten = TRUE
				if (!stuck)
					stuck_delay = 15
					M.visible_message(
						"<span class='boldnotice'>[M]'s sides briefly brush against the doorway.</span>",
						"<span class='boldwarning'>You feel your sides smush against the doorway!.</span>")
			else if(M.fatness >= FATNESS_LEVEL_FAT)
				fatten = TRUE
				if (!stuck)
					stuck_delay = 5
					M.visible_message(
						"<span class='boldnotice'>[M]'s sides briefly brush against the doorway.</span>",
						"<span class='boldwarning'>You feel your sides briefly brush against the doorway!</span>")
			else
				fatten = FALSE
				stuck = FALSE
				stuck_delay = 0

			if (fatten) // get stuck
				if (!stuck)
					M.Stun(stuck_delay/2) // give player time to escape
					stuck = TRUE
				if (stuck_delay > 0) // wait for stun to end
					stuck_delay = stuck_delay - fatten_delay
					if (stuck_delay <= 0)
						stuck_delay = 0
					// gain weight while stuck
					M.adjust_fatness(fat_to_add, FATTENING_TYPE_ITEM)

	if (!blocked)
		stuck = FALSE // ready to go again

/obj/structure/mineral_door/sandstone
	name = "sandstone door"
	icon_state = "sandstone"
	sheetType = /obj/item/stack/sheet/mineral/sandstone
	max_integrity = 100

/obj/structure/mineral_door/transparent
	opacity = FALSE
	rad_insulation = RAD_VERY_LIGHT_INSULATION

/obj/structure/mineral_door/transparent/Close()
	..()
	set_opacity(FALSE)

/obj/structure/mineral_door/transparent/plasma
	name = "plasma door"
	icon_state = "plasma"
	sheetType = /obj/item/stack/sheet/mineral/plasma

/obj/structure/mineral_door/transparent/plasma/ComponentInitialize()
	return

/obj/structure/mineral_door/transparent/plasma/attackby(obj/item/W, mob/user, params)
	if(W.is_hot())
		var/turf/T = get_turf(src)
		message_admins("Plasma mineral door ignited by [ADMIN_LOOKUPFLW(user)] in [ADMIN_VERBOSEJMP(T)]")
		log_game("Plasma mineral door ignited by [key_name(user)] in [AREACOORD(T)]")
		TemperatureAct()
	else
		return ..()

/obj/structure/mineral_door/transparent/plasma/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		TemperatureAct()

/obj/structure/mineral_door/transparent/plasma/proc/TemperatureAct()
	atmos_spawn_air("plasma=500;TEMP=1000")
	deconstruct(FALSE)

/obj/structure/mineral_door/transparent/diamond
	name = "diamond door"
	icon_state = "diamond"
	sheetType = /obj/item/stack/sheet/mineral/diamond
	max_integrity = 1000
	rad_insulation = RAD_EXTREME_INSULATION

/obj/structure/mineral_door/wood
	name = "wood door"
	icon_state = "wood"
	openSound = 'sound/effects/doorcreaky.ogg'
	closeSound = 'sound/effects/doorcreaky.ogg'
	sheetType = /obj/item/stack/sheet/mineral/wood
	resistance_flags = FLAMMABLE
	max_integrity = 200
	rad_insulation = RAD_VERY_LIGHT_INSULATION

/obj/structure/mineral_door/woodrustic
	name = "rustic wood door"
	icon_state = "woodrustic"
	openSound = 'sound/effects/doorcreaky.ogg'
	closeSound = 'sound/effects/doorcreaky.ogg'
	sheetType = /obj/item/stack/sheet/mineral/wood
	sheetAmount = 10
	max_integrity = 200
	rad_insulation = RAD_VERY_LIGHT_INSULATION

/obj/structure/mineral_door/paperframe
	name = "paper frame door"
	icon_state = "paperframe"
	openSound = 'sound/effects/doorcreaky.ogg'
	closeSound = 'sound/effects/doorcreaky.ogg'
	sheetType = /obj/item/stack/sheet/paperframes
	sheetAmount = 3
	resistance_flags = FLAMMABLE
	max_integrity = 20

/obj/structure/mineral_door/paperframe/Initialize()
	. = ..()
	queue_smooth_neighbors(src)

/obj/structure/mineral_door/paperframe/ComponentInitialize()
	return

/obj/structure/mineral_door/paperframe/Destroy()
	queue_smooth_neighbors(src)
	return ..()
