/obj/item/seeds/berry/blueberry
	name = "pack of blueberry seeds"
	desc = "These seeds grow into blueberry bushes."
	icon_state = "seed-blueberry"
	species = "blueberry"
	plantname = "Blueberry Bush"
	product = /obj/item/reagent_containers/food/snacks/grown/berries/blueberry
	mutatelist = list()
	reagents_add = list(/datum/reagent/blueberry_juice = 0.1)
	potency = 1
	yield = 1
	production = 10
	rarity = 30

/obj/item/reagent_containers/food/snacks/grown/berries/blueberry
	seed = /obj/item/seeds/berry/blueberry
	name = "bunch of blueberries"
	desc = "Taste so good, you might turn blue!"
	icon_state = "blueberrypile"
	filling_color = "#5d00c7"
	foodtype = FRUIT
	juice_results = list(/datum/reagent/blueberry_juice = 20)
	tastes = list("blueberry" = 1)
	distill_reagent = null
	wine_power = 50
