/datum/quirk/water_sponge
	name = "Water Sponge"
	desc = "You can hold lots of water in you! Careful with showers!"
	value = 0 //ERP quirk
	gain_text = "<span class='notice'>You feel absorbant.</span>"
	lose_text = "<span class='notice'>You don't feel absorbant anymore.</span>"
	category = CATEGORY_FOOD
	mob_trait = TRAIT_WATER_SPONGE

/datum/reagent/water/on_mob_add(mob/living/L, amount)
	if(HAS_TRAIT(L, TRAIT_WATER_SPONGE))
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			C.hider_add(src)
	. = ..()

/datum/reagent/water/on_mob_delete(mob/living/L)
	if(HAS_TRAIT(L, TRAIT_WATER_SPONGE))
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			C.hider_remove(src)
	. = ..()

/datum/reagent/water/reaction_mob(mob/living/M, method, reac_volume)
	. = ..()
	if(HAS_TRAIT(M, TRAIT_WATER_SPONGE))
		if(method == TOUCH)
			M.reagents.add_reagent(/datum/reagent/water, reac_volume/2)
		if(method == VAPOR)
			M.reagents.add_reagent(/datum/reagent/water, reac_volume/3)
	

/datum/reagent/water/proc/fat_hide(mob/living/carbon/user)
	return volume * 3.5

/obj/machinery/shower/process()
	..()
	for(var/atom/movable/AM in loc)
		if(iscarbon(AM))
			if(HAS_TRAIT(AM, TRAIT_WATER_SPONGE))
				var/mob/living/carbon/L = AM
				L.reagents.add_reagent(/datum/reagent/water, 3)

/mob/living/carbon/proc/water_check(datum/gas_mixture/breath)
	if(HAS_TRAIT(src, TRAIT_WATER_SPONGE))
		if(breath)
			if(breath.gases)
				var/breath_gases = breath.gases
				if(breath_gases[/datum/gas/water_vapor])
					var/H2O_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/water_vapor])
					reagents.add_reagent(/datum/reagent/water, H2O_pp/10)
					breath_gases[/datum/gas/water_vapor] -= H2O_pp

/obj/structure/sink
	var/mob/living/attached

/obj/structure/sink/MouseDrop(mob/living/target)
	. = ..()
	if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE) || !isliving(target))
		return
	if(attached)
		visible_message("<span class='warning'>[attached] is detached from [src].</span>")
		attached = null
		return
	if(Adjacent(target) && usr.Adjacent(target))
		usr.visible_message("<span class='warning'>[usr] attaches [target] to [src].</span>", "<span class='notice'>You attach [target] to [src].</span>")
		add_fingerprint(usr)
		attached = target
		START_PROCESSING(SSobj, src)
	
/obj/structure/sink/process()
	if(!(get_dist(src, attached) <= 1 && isturf(attached.loc)))
		to_chat(attached, "<span class='userdanger'>[attached] is ripped from the sink!</span>") // GS13
		attached = null
		return PROCESS_KILL
	if(attached)
		playsound(attached, 'sound/vore/pred/swallow_02.ogg', rand(10,50), 1)
		attached.reagents.add_reagent(/datum/reagent/water, 5)
	else
		return PROCESS_KILL
	
/obj/structure/sink/attack_hand(mob/living/user)
	if(attached)
		visible_message("[attached] is detached from [src]")
		attached = null
		return

/obj/machinery/pool/controller/process_reagents()
	for(var/turf/open/pool/W in linked_turfs)
		for(var/mob/living/carbon/human/swimee in W)
			if(HAS_TRAIT(swimee, TRAIT_WATER_SPONGE))
				swimee.reagents.add_reagent(/datum/reagent/water, 5)
	..()
