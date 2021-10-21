/obj/machinery/vending/mealdor
	name = "Meal Vendor"
	desc = "The vending machine used for starving folks"
	icon = 'icons/obj/vending.dmi'
	icon_state = "mealdor"
	product_slogans = "Are you hungry?;Hope you are ready to eat!;Consume food, please"
	vend_reply = "Enjoy your meal."
	products = list(

				/obj/item/reagent_containers/food/snacks/store/cake/cheese = 10,
				/obj/item/reagent_containers/food/snacks/store/cake/birthday = 10,
				/obj/item/reagent_containers/food/snacks/store/cake/pumpkinspice = 10,
				/obj/item/reagent_containers/food/snacks/store/cake/pound_cake = 5,
//				/obj/item/reagent_containers/food/snacks/donut/purefat = 10,
				/obj/item/reagent_containers/food/snacks/fries = 8,
				/obj/item/reagent_containers/food/snacks/donut = 5,
				/obj/item/reagent_containers/food/snacks/candiedapple = 2,
				/obj/item/reagent_containers/food/snacks/burrito = 4,
				/obj/item/reagent_containers/food/snacks/enchiladas = 5,
				/obj/item/reagent_containers/food/snacks/spaghetti = 3,
				/obj/item/reagent_containers/food/snacks/kebab/rat = 5,
				/obj/item/reagent_containers/food/snacks/kebab/rat/double = 5,
				/obj/item/reagent_containers/food/snacks/meatballspaghetti = 1,
	            /obj/item/reagent_containers/food/drinks/bottle/orangejuice = 2,
	            /obj/item/reagent_containers/food/drinks/bottle/pineapplejuice = 5,
	            /obj/item/reagent_containers/food/drinks/bottle/strawberryjuice = 3,
	            /obj/item/reagent_containers/food/drinks/beer = 8,
	            /obj/item/reagent_containers/food/drinks/soda_cans/cola = 10
				)
	contraband = list(
				/obj/item/clothing/mask/fakemoustache = 2,
				/obj/item/clothing/head/chefhat = 2,
				/obj/item/reagent_containers/food/snacks/cookie = 10,


				)
	premium = list(
				/obj/item/reagent_containers/food/drinks/soda_cans/air = 1,
				/obj/item/reagent_containers/food/snacks/donut/chaos = 2
				)

	refill_canister = /obj/item/vending_refill/mealdor

obj/item/vending_refill/mealdor
	machine_name = "Meal Vendor Refill"
	icon_state = "refill_mealdor"

#define STANDARD_CHARGE 1
#define CONTRABAND_CHARGE 2
#define COIN_CHARGE 3
