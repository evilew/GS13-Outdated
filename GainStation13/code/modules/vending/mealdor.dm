/obj/machinery/vending/mealdor
	name = "Meal Vendor"
	desc = "The vending machine used by starving people. Looks like they've changed the shell, it looks cuter."
	icon = 'icons/obj/vending.dmi'
	icon_state = "mealdor"
	product_slogans = "Are you hungry? Eat some of my food!;Be sure to eat one of our tasty treats!;Was that your stomach? Go ahead, get some food!"
	vend_reply = "Enjoy your meal."
	products = list(

				/obj/item/reagent_containers/food/snacks/fries = 3,
				/obj/item/reagent_containers/food/snacks/donut = 8,
				/obj/item/reagent_containers/food/snacks/burrito = 4,
				/obj/item/reagent_containers/food/snacks/spaghetti = 5,
				/obj/item/reagent_containers/food/snacks/meatballspaghetti = 4,
	            /obj/item/reagent_containers/food/snacks/pizza/margherita = 3,
	            /obj/item/reagent_containers/food/snacks/butterdog = 6,
	            /obj/item/reagent_containers/food/snacks/burger/plain = 6,
	            /obj/item/reagent_containers/food/snacks/pie/plump_pie = 4,
				/obj/item/reagent_containers/food/snacks/store/cake/cheese = 3,
				/obj/item/reagent_containers/food/snacks/store/cake/pound_cake = 2,
				/obj/item/reagent_containers/food/snacks/cakeslice/bsvc = 3,
				/obj/item/reagent_containers/food/snacks/cakeslice/bscc = 3,
	            /obj/item/reagent_containers/food/snacks/dough = 5,
				/obj/item/reagent_containers/food/drinks/bottle/orangejuice = 8,
	            /obj/item/reagent_containers/food/drinks/bottle/pineapplejuice = 8,
	            /obj/item/reagent_containers/food/drinks/bottle/strawberryjuice = 8
				)
	contraband = list(
				/obj/item/clothing/mask/fakemoustache = 5,
				/obj/item/clothing/head/chefhat = 5,
				/obj/item/reagent_containers/food/snacks/cookie = 5,
				/obj/item/reagent_containers/food/snacks/salad/fruit = 5,
				/obj/item/reagent_containers/food/snacks/salad = 5,
				/obj/item/reagent_containers/food/snacks/salad/hellcobb = 5,
				/obj/item/clothing/under/cowkini = 5,
				/obj/item/reagent_containers/food/snacks/blueberry_gum = 5
				)
	premium = list(
				/obj/item/reagent_containers/food/drinks/soda_cans/air = 3,
				/obj/item/reagent_containers/food/snacks/donut/chaos = 3,
				/obj/item/clothing/mask/cowmask/gag = 2,
				/obj/item/clothing/mask/pig/gag = 2
				)

	refill_canister = /obj/item/vending_refill/mealdor
