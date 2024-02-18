/obj/item/reagent_containers/food/snacks/gbburrito
	name = "\improper GATO Gas Giant Burrito"
	icon_state = "gbburrito"
	desc = "More than three pounds of beans, meat, and cheese wrapped in a greasy tortilla. It's piping hot."
	trash = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/flatulose = 4, /datum/reagent/consumable/sodiumchloride = 0.5)
	filling_color = "#74291b"
	tastes = list("refried beans","grease" = 1)
	foodtype = MEAT 
	price = 3

//these have been ported from CHOMPstation / Virgo
/obj/item/reagent_containers/food/snacks/doner_kebab
	name = "doner kebab"
	icon = 'icons/obj/food/ported_meals.dmi'
	desc = "A delicious sandwich-like food from ancient Earth. The meat is typically cooked on a vertical rotisserie."
	icon_state = "doner_kebab"
	trash = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	filling_color = "#93684d"
	tastes = list("thinly sliced meat","meat" = 1)
	foodtype = GRAIN | VEGETABLES | MEAT | JUNKFOOD

/obj/item/reagent_containers/food/snacks/lasagna
	name = "lasagna"
	desc = "Meaty, tomato-y, and ready to eat-y. Favorite of cats."
	icon = 'icons/obj/food/ported_meals.dmi'
	icon_state = "lasagna"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	filling_color = "#872020"
	tastes = list("italian cuisine" = 1)
	foodtype = GRAIN | VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/corndog
	name = "corn dog"
	desc = "A cornbread covered sausage deepfried in oil."
	icon = 'icons/obj/food/ported_meals.dmi'
	icon_state = "corndog"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#df9745"
	tastes = list("corn batter", "sausage" = 1)
	foodtype = GRAIN | MEAT | JUNKFOOD

/obj/item/reagent_containers/food/snacks/turkey
	name = "turkey"
	desc = "Tastes like chicken. It can be sliced!"
	icon = 'icons/obj/food/ported_meals.dmi'
	icon_state = "turkey"
	slice_path = /obj/item/reagent_containers/food/snacks/turkey_leg
	slices_num = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	filling_color = "#d4864b"
	tastes = list("turkey" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/turkey_leg
	name = "turkey leg"
	desc = "Tastes like chicken."
	icon = 'icons/obj/food/ported_meals.dmi'
	icon_state = "turkey_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#ae6941"
	tastes = list("turkey" = 1)
	foodtype = MEAT 

/obj/item/reagent_containers/food/snacks/brownies
	name = "brownies"
	desc = "Halfway to fudge, or halfway to cake? Who cares!"
	icon = 'icons/obj/food/ported_meals.dmi'
	icon_state = "brownies"
	slice_path = /obj/item/reagent_containers/food/snacks/brownies_slice
	slices_num = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	filling_color = "#392f27"
	tastes = list("chocolate" = 1)
	foodtype = GRAIN | SUGAR | DAIRY 

/obj/item/reagent_containers/food/snacks/brownies_slice
	name = "brownie"
	desc = "a dense, decadent chocolate brownie."
	icon = 'icons/obj/food/ported_meals.dmi'
	icon_state = "browniesslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#392f27"
	tastes = list("chocolate" = 1)
	foodtype = GRAIN | SUGAR | DAIRY 

/obj/item/reagent_containers/food/snacks/brownies_cosmic
	name = "cosmic brownies"
	desc = "The power of cosmos likes within your hand."
	icon = 'icons/obj/food/ported_meals.dmi'
	icon_state = "cosmicbrownies"
	slice_path = /obj/item/reagent_containers/food/snacks/brownies_slice_cosmic
	slices_num = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = 25, /datum/reagent/medicine/omnizine = 5)
	filling_color = "#392f27"
	tastes = list("chocolate" = 1)
	foodtype = GRAIN | SUGAR | DAIRY 

/obj/item/reagent_containers/food/snacks/brownies_slice_cosmic
	name = "cosmic brownie"
	desc = "a dense, decadent and fun-looking chocolate brownie."
	icon = 'icons/obj/food/ported_meals.dmi'
	icon_state = "cosmicbrownieslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/medicine/omnizine = 1)
	filling_color = "#392f27"
	tastes = list("chocolate" = 1)
	foodtype = GRAIN | SUGAR | DAIRY 

/obj/item/reagent_containers/food/snacks/bacon_and_eggs
	name = "bacon and eggs"
	desc = "A staple of every breakfast."
	icon = 'icons/obj/food/ported_meals.dmi'
	icon_state = "bacon_and_eggs"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	filling_color = "#e9e6e3"
	tastes = list("eggs", "bacon" = 1)
	foodtype = BREAKFAST | MEAT

/obj/item/reagent_containers/food/snacks/eggmuffin
	name = "egg muffin"
	desc = "A staple of every breakfast."
	icon = 'icons/obj/food/ported_meals.dmi'
	icon_state = "eggmuffin"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	filling_color = "#e9e6e3"
	tastes = list("eggs", "breakfast" = 1)
	foodtype = BREAKFAST | MEAT

/obj/item/reagent_containers/food/snacks/cinammonbun
	name = "cinammon bun"
	desc = "Careful not to have it stolen."
	icon = 'icons/obj/food/ported_meals.dmi'
	icon_state = "cinammonbun"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#e9e6e3"
	tastes = list("eggs", "breakfast" = 1)
	foodtype = GRAIN | SUGAR
