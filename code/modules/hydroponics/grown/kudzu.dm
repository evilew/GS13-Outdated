// A very special plant, deserving its own file.

/obj/item/seeds/kudzu
	name = "pack of kudzu seeds"
	desc = "These seeds grow into a weed that grows incredibly fast."
	icon_state = "seed-kudzu"
	species = "kudzu"
	plantname = "Kudzu"
	product = /obj/item/reagent_containers/food/snacks/grown/kudzupod
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/plant_type/weed_hardy)
	lifespan = 20
	endurance = 10
	yield = 4
	growthstages = 4
	rarity = 30
	var/list/mutations = list()
	reagents_add = list(/datum/reagent/medicine/charcoal = 0.04, /datum/reagent/consumable/nutriment = 0.02)

	var/list/muts_list = list()
	var/prickle_reagent

/obj/item/seeds/kudzu/Initialize(mapload, nogenes)
	. = ..()
	for(var/A in subtypesof(/datum/spacevine_mutation))
		muts_list += new A()

/obj/item/seeds/kudzu/Copy()
	var/obj/item/seeds/kudzu/S = ..()
	S.mutations = mutations.Copy()
	S.prickle_reagent = prickle_reagent
	return S

/obj/item/seeds/kudzu/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] swallows the pack of kudzu seeds! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	plant(user)
	return (BRUTELOSS)

/obj/item/seeds/kudzu/proc/plant(mob/user)
	if(isspaceturf(user.loc))
		return
	if(!isturf(user.loc))
		to_chat(user, "<span class='warning'>You need more space to plant [src].</span>")
		return FALSE
	if(locate(/obj/structure/spacevine) in user.loc)
		to_chat(user, "<span class='warning'>There is too much kudzu here to plant [src].</span>")
		return FALSE
	to_chat(user, "<span class='notice'>You plant [src].</span>")
	message_admins("Kudzu planted by [ADMIN_LOOKUPFLW(user)] at [ADMIN_VERBOSEJMP(user)]")
	investigate_log("was planted by [key_name(user)] at [AREACOORD(user)]", INVESTIGATE_BOTANY)
	new /datum/spacevine_controller(get_turf(user), mutations, potency, production, prickle_reagent)
	qdel(src)

/obj/item/seeds/kudzu/attack_self(mob/user)
	user.visible_message("<span class='danger'>[user] begins throwing seeds on the ground...</span>")
	if(do_after(user, 50, needhand = TRUE, target = user.drop_location(), progress = TRUE))
		plant(user)
		to_chat(user, "<span class='notice'>You plant the kudzu. You monster.</span>")

/obj/item/seeds/kudzu/get_analyzer_text()
	var/text = ..()
	var/text_string = ""
	for(var/A in mutations)
		var/datum/spacevine_mutation/SM = A
		text_string += "[(text_string == "") ? "" : ", "][SM.name]"
	text += "\n- Plant Mutations: [(text_string == "") ? "None" : text_string]"
	if(prickle_reagent)
		text += "\n- Plant Chemical: [prickle_reagent]"
	return text

/obj/item/seeds/kudzu/on_chem_reaction(datum/reagents/S)
	var/list/temp_mut_list = list()

	if(S.has_reagent(/datum/reagent/space_cleaner/sterilizine, 5))
		for(var/A in mutations)
			var/datum/spacevine_mutation/SM = A
			if(SM.quality == NEGATIVE)
				temp_mut_list += SM
		if(prob(20) && temp_mut_list.len)
			mutations.Remove(pick(temp_mut_list))
		temp_mut_list.Cut()
	else if(S.has_reagent(/datum/reagent/fuel, 5))
		for(var/A in mutations)
			var/datum/spacevine_mutation/SM = A
			if(SM.quality == POSITIVE)
				temp_mut_list += SM
		if(prob(20) && temp_mut_list.len)
			mutations.Remove(pick(temp_mut_list))
		temp_mut_list.Cut()
	else if(S.has_reagent(/datum/reagent/phenol, 5))
		for(var/A in mutations)
			var/datum/spacevine_mutation/SM = A
			if(SM.quality == MINOR_NEGATIVE)
				temp_mut_list += SM
		if(prob(20) && temp_mut_list.len)
			mutations.Remove(pick(temp_mut_list))
		temp_mut_list.Cut()
	else if(S.has_reagent(/datum/reagent/blood, 15))
		adjust_production(rand(15, -5))
	else if(S.has_reagent(/datum/reagent/toxin/amatoxin, 5))
		adjust_production(rand(5, -15))
	else if(S.has_reagent(/datum/reagent/toxin/plasma, 5))
		adjust_potency(rand(5, -15))
	else if(S.has_reagent(/datum/reagent/water/holywater, 10))
		adjust_potency(rand(15, -5))
	else
		if(S.has_reagent(/datum/reagent/drug/space_drugs, 5))
			if(prob(20) && (muts_list - mutations).len > 0)
				var/datum/spacevine_mutation/mut = pick(muts_list - mutations)
				if(!(mut in mutations))
					mutations |= mut 
					src.visible_message("<span class='alert'>[src.plantname] seems to react with the chemical...</span>")
			return
	if(S.reagent_list.len > 0)
		prickle_reagent = S.get_master_reagent().type
		prickle_reagent = new prickle_reagent()
		src.visible_message("<span class='alert'>[src.plantname] seems to absorb the chemical...</span>")

/obj/item/reagent_containers/food/snacks/grown/kudzupod
	seed = /obj/item/seeds/kudzu
	name = "kudzu pod"
	desc = "<I>Pueraria Virallis</I>: An invasive species with vines that rapidly creep and wrap around whatever they contact."
	icon_state = "kudzupod"
	filling_color = "#6B8E23"
	bitesize_mod = 2
	foodtype = VEGETABLES | GROSS
	tastes = list("kudzu" = 1)
	wine_power = 20

/*/obj/item/seeds/kudzu/test
	potency = 100
	yield = 10
	maturation = 1
	production = 1
	mutations = list(new /datum/spacevine_mutation/prickle(), new /datum/spacevine_mutation/stable())*/
