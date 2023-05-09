/obj/machinery/vending/mealdor
	name = "Meal Vendor"
	desc = "The vending machine used by starving people. Looks like they've changed the shell, it looks cuter."
	icon = 'icons/obj/vending.dmi'
	icon_state = "mealdor"
	product_slogans = "Are you hungry? Eat some of my food!;Be sure to eat one of our tasty treats!;Was that your stomach? Go ahead, get some food!"
	vend_reply = "Enjoy your meal."
	products = list(

				/obj/item/reagent_containers/food/snacks/store/cake/cheese = 10,
				/obj/item/reagent_containers/food/snacks/store/cake/pumpkinspice = 10,
				/obj/item/reagent_containers/food/snacks/store/cake/pound_cake = 8,
				/obj/item/reagent_containers/food/snacks/cakeslice/bsvc = 5,
				/obj/item/reagent_containers/food/snacks/cakeslice/bscc = 5,
//				/obj/item/reagent_containers/food/snacks/donut/purefat = 10,
				/obj/item/reagent_containers/food/snacks/fries = 10,
				/obj/item/reagent_containers/food/snacks/donut = 20,
				/obj/item/reagent_containers/food/snacks/candiedapple = 7,
				/obj/item/reagent_containers/food/snacks/burrito = 8,
				/obj/item/reagent_containers/food/snacks/enchiladas = 10,
				/obj/item/reagent_containers/food/snacks/spaghetti = 20,
				/obj/item/reagent_containers/food/snacks/kebab/rat = 7,
				/obj/item/reagent_containers/food/snacks/kebab/rat/double = 6,
				/obj/item/reagent_containers/food/snacks/meatballspaghetti = 10,
	            /obj/item/reagent_containers/food/drinks/bottle/orangejuice = 10,
	            /obj/item/reagent_containers/food/drinks/bottle/pineapplejuice = 10,
	            /obj/item/reagent_containers/food/drinks/bottle/strawberryjuice = 10,
	            /obj/item/reagent_containers/food/drinks/beer = 10,
	            /obj/item/reagent_containers/food/drinks/soda_cans/cola = 10,
	            /obj/item/reagent_containers/food/snacks/pizza/margherita = 10,
	            /obj/item/reagent_containers/food/snacks/butterdog = 12,
	            /obj/item/reagent_containers/food/snacks/burger/plain = 20,
	            /obj/item/reagent_containers/food/snacks/burger/bearger = 10,
	            /obj/item/reagent_containers/food/snacks/pie/plump_pie = 8,
	            /obj/item/reagent_containers/food/snacks/dough = 20
				)
	contraband = list(
				/obj/item/clothing/mask/fakemoustache = 5,
				/obj/item/clothing/head/chefhat = 5,
				/obj/item/reagent_containers/food/snacks/cookie = 10,
				/obj/item/reagent_containers/food/snacks/salad/fruit = 15,
				/obj/item/reagent_containers/food/snacks/salad = 20,
				/obj/item/reagent_containers/food/snacks/salad/hellcobb = 10,
				/obj/item/clothing/under/cowkini = 5,
				/obj/item/reagent_containers/food/snacks/blueberry_gum = 5
				)
	premium = list(
				/obj/item/reagent_containers/food/drinks/soda_cans/air = 3,
				/obj/item/reagent_containers/food/snacks/donut/chaos = 3
				)

	refill_canister = /obj/item/vending_refill/mealdor
