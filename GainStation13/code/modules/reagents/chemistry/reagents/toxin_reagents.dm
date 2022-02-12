//we'll put funky toxins here

//fattening toxin
/datum/reagent/toxin/lipoifier
	name = "Lipoifier"
	description = "A very potent toxin that causes those that ingest it to build up fat cells quickly."
	taste_description = "lard"
	reagent_state = LIQUID
	color = "#e2e1b1"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	toxpwr = 0

/datum/reagent/toxin/lipoifier/on_mob_life(mob/living/carbon/M)
	M.fatness = M.fatness + 3
	return ..()
