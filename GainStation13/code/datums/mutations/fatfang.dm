/datum/mutation/human/fatfang
	name = "The Nibble"
	desc = "A rare mutation that grows a pair of fangs in the user's mouth that inject a chemical that develops the target's adipose tissue."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>You feel something growing in your mouth!</span>"
	text_lose_indication = "<span class='notice'>You feel your fangs shrink away.</span>"
	difficulty = 8
	power = /obj/effect/proc_holder/spell/targeted/touch/fatfang
	instability = 10
	energy_coeff = 1
	power_coeff = 1

/obj/effect/proc_holder/spell/targeted/touch/fatfang
	name = "The Nibble"
	desc = "Draw out fangs that inject fattening venom"
	drawmessage = "You draw out your fangs."
	dropmessage = "You retract your fangs."
	hand_path = /obj/item/melee/touch_attack/fatfang
	action_icon = 'icons/mob/actions/bloodsucker.dmi'
	action_icon_state = "power_feed"
	charge_max = 50
	clothes_req = FALSE

/obj/item/melee/touch_attack/fatfang
	name = "\improper fattening fangs"
	desc = "Fangs armed with a venom most ample."
	catchphrase = null
	icon = 'icons/mob/actions/bloodsucker.dmi'
	icon_state = "power_feed"
	///How much weight is added?
	var/chem_to_add = 5
	
	var/starttime = 0

/obj/item/melee/touch_attack/fatfang/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity || !iscarbon(target) || target == user)
		return FALSE
	
	if(!target || !chem_to_add)
		return FALSE
	target.visible_message("<span class='danger'>[user] nibbles [target]!</span>","<span class='userdanger'>[user] nibbles you!</span>")
	if(target == user.pulling && ishuman(user.pulling))
		starttime = world.time
		user.dna.get_mutation(FATFANG).power.charge_max = 600 * GET_MUTATION_ENERGY(user.dna.get_mutation(FATFANG))
		while(starttime + 300 > world.time && in_range(user, target))
			if(do_mob(user, target, 10, 0, 1))
				target.reagents.add_reagent(/datum/reagent/consumable/lipoifier, (chem_to_add * GET_MUTATION_POWER(user.dna.get_mutation(FATFANG))/2))
				target.visible_message("<span class='danger'>[user] pumps some venom in [target]!</span>","<span class='userdanger'>[user] pumps some venom in you!</span>")
	else
		user.dna.get_mutation(FATFANG).power.charge_max = 50 * GET_MUTATION_ENERGY(user.dna.get_mutation(FATFANG))
		target.reagents.add_reagent(/datum/reagent/consumable/lipoifier, chem_to_add * GET_MUTATION_POWER(user.dna.get_mutation(FATFANG)))

	return ..()

/obj/item/dnainjector/antifang
	name = "\improper DNA injector (Anti-The Nibble)"
	desc = "By the power of sugar, their fangs shall fall."
	remove_mutations = list(FATFANG)

/obj/item/dnainjector/fatfang
	name = "\improper DNA injector (The Nibble)"
	desc = "Give 'em just a teeny tiny bite."
	add_mutations = list(FATFANG)
