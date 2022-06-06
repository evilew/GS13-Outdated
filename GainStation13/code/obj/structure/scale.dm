/obj/structure/scale
	name = "weighing scale"
	desc = "You can weigh yourself with this. Its last reading was: [src.lastreading]Lbs"
	icon = 'GainStation13/icons/obj/scale.dmi'
	icon_state = "scale"
	anchored = TRUE
	resistance_flags = NONE
	max_integrity = 250
	integrity_failure = 25
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 3
	layer = OBJ_LAYER
	var/lastreading = 0

/obj/structure/scale/deconstruct()
	// If we have materials, and don't have the NOCONSTRUCT flag
	if(buildstacktype && (!(flags_1 & NODECONSTRUCT_1)))
		new buildstacktype(loc,buildstackamount)
	..()

/obj/structure/scale/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/wrench) && !(flags_1&NODECONSTRUCT_1))
		W.play_tool_sound(src)
		deconstruct()
	else if(istype(W, /obj/item/assembly/shock_kit))
		if(!user.temporarilyRemoveItemFromInventory(W))
			return
		var/obj/item/assembly/shock_kit/SK = W
		var/obj/structure/chair/e_chair/E = new /obj/structure/chair/e_chair(src.loc)
		playsound(src.loc, 'sound/items/deconstruct.ogg', 50, 1)
		E.setDir(dir)
		E.part = SK
		SK.forceMove(E)
		SK.master = E
		qdel(src)
	else
		return ..()

/obj/structure/chair/examine(mob/user)
	. = ..()
	. += "<span class='notice'>It's held together by a couple of <b>bolts</b>.</span>"

/obj/structure/scale/Crossed(AM)

	if(AM.ishuman())
		var/mob/living/fatty = AM 

		if(isturf(loc))

			if(!(fatty.movement_type & FLYING))

				
				src.lastreading = (150 + fatty.fatness)*(fatty.size_multiplier**2)
				usr.visible_message("[usr] weighs themselves on the scales.", "You weigh yourself on the scales")
				usr.visible_message("<span class='notice'> The scales read [src.lastreading]Lbs </span>")
			
			
