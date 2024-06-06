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
	var/breath_gases = breath.gases
	if(breath_gases[/datum/gas/water_vapor])
		if(HAS_TRAIT(src, TRAIT_WATER_SPONGE))
			var/H2O_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/water_vapor])
			reagents.add_reagent(/datum/reagent/water, H2O_pp/10)
			breath_gases[/datum/gas/water_vapor] -= H2O_pp

