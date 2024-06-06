/datum/symptom/berry
	name = "Berrification"
	desc = "The virus causes the host's biology to overflow with a blue substance. Infection ends if the substance is completely removed from their body, besides ordinary cures."
	stealth = -5
	resistance = -4
	stage_speed = 1
	transmittable = 6
	level = 7
	severity = 5
	base_message_chance = 100
	symptom_delay_min = 15
	symptom_delay_max = 45
	threshold_desc = list(
		"Stage Speed" = "Increases the rate of liquid production.",
	)
	var/datum/reagent/infection_reagent = /datum/reagent/berry_juice_infection

/datum/symptom/berry/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.affected_mob?.client?.prefs?.blueberry_inflation)
		A.affected_mob.reagents.add_reagent(infection_reagent, max(1, A.totalStageSpeed()) * 10)
	..()

/datum/symptom/berry/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	if(!(M?.client?.prefs?.blueberry_inflation))
		return
	if(M.reagents.get_reagent_amount(infection_reagent) <= 0)
		A.remove_disease()
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance))
				to_chat(M, "<span class='warning'>[pick("You feel oddly full...", "Your stomach churns...", "You hear a gurgle...", "You taste berries...")]</span>")
		else
			to_chat(M, "<span class='warning'><i>[pick("A deep slosh comes from inside you...", "Your mind feels so light...", "You think blue really suits you...", "Your skin feels so tight...")]</i></span>")
			M.reagents.add_reagent(infection_reagent, max(A.totalStageSpeed(), 1))

/datum/reagent/berry_juice_infection
	name = "Blueberry Juice"
	description = "Totally infectious."
	reagent_state = LIQUID
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	color = "#0004ff"
	var/picked_color
	var/list/random_color_list = list("#0058db","#5d00c7","#0004ff","#0057e7")
	taste_description = "blueberry pie"
	var/no_mob_color = FALSE
	value = 10	//it sells. Make that berry factory

/datum/reagent/berry_juice_infection/on_mob_add(mob/living/L, amount)
	if(iscarbon(L))
		var/mob/living/carbon/affected_mob = L
		if(affected_mob?.client && !(affected_mob?.client?.prefs?.blueberry_inflation))
			affected_mob.reagents.remove_reagent(/datum/reagent/berry_juice_infection, volume)
			return
		picked_color = pick(random_color_list)
		affected_mob.hider_add(src)
	else
		L.reagents.remove_reagent(/datum/reagent/berry_juice_infection, volume)
	..()

/datum/reagent/berry_juice_infection/on_mob_life(mob/living/carbon/M)
	if(M?.client && !(M?.client?.prefs?.blueberry_inflation))
		M.reagents.remove_reagent(/datum/reagent/berry_juice_infection, volume)
		return
	if(!no_mob_color)
		M.add_atom_colour(picked_color, WASHABLE_COLOUR_PRIORITY)
	M.adjust_fatness(1, FATTENING_TYPE_CHEM)
	..()

/datum/reagent/berry_juice_infection/on_mob_delete(mob/living/L)
	if(!iscarbon(L))
		return
	var/mob/living/carbon/C = L
	C.hider_remove(src)

/obj/item/reagent_containers/glass/attack(mob/M, mob/user, obj/target)
	if(M.reagents.get_reagent_amount(/datum/reagent/berry_juice_infection) > 0 && (reagents.total_volume + min(amount_per_transfer_from_this, 10)) <= volume)
		reagents.add_reagent(/datum/reagent/berry_juice_infection, min(10, amount_per_transfer_from_this))
		M.reagents.remove_reagent(/datum/reagent/berry_juice_infection, min(10, amount_per_transfer_from_this))
		if(M != user)
			to_chat(user, "<span class='warning'>You juice [M.name]...</span>")
			to_chat(M, "<span class='warning'>[user.name] juices you...</span>")
		else
			to_chat(user, "<span class='warning'>You get some juice out of you...</span>")
		return
	..()

/datum/reagent/berry_juice_infection/proc/fat_hide()
	return (3 * (volume * volume))/50
