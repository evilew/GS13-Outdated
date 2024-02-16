
// see code/module/crafting/table.dm

////////////////////////////////////////////////PIZZA!!!////////////////////////////////////////////////

//GS13 - this has been ported from CHOMP/Virgo, but I've decided to adjust the recipe a bit
// there's both the recipe and the defines for the pizza itself here

/obj/item/reagent_containers/food/snacks/pizza/framewrecker
	name = "Framewrecker Pizza"
	desc = "You feel your arteries clogging just by merely looking at this monster. Is this even real, or a mere hallucination?"
	icon = 'icons/obj/food/food64x64.dmi'
	icon_state = "theonepizza"
	pixel_x = -16
	pixel_y = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/donkpocket
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 200, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/medicine/omnizine = 10, /datum/reagent/consumable/nutriment/vitamin = 20)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1, "overwhelming surge of calories" = 10)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT | JUNKFOOD | ANTITOXIC

	var/slicelist = list(/obj/item/reagent_containers/food/snacks/pizzaslice/framewrecker/mushroom,
						 /obj/item/reagent_containers/food/snacks/pizzaslice/framewrecker/veggie)


/obj/item/reagent_containers/food/snacks/pizzaslice/framewrecker
	name = "Framewrecker Pizza Slice"
	desc = "This mere slice is the size of pizza on its own!"
	icon = 'icons/obj/food/ported_meals.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 50)
	icon_state = "big_mushroom_slice"
	filling_color = "#FFA500"

/obj/item/reagent_containers/food/snacks/pizzaslice/framewrecker/mushroom
	name = "Giant mushroom pizza slice"
	icon_state = "big_mushroom_slice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushrooms" = 1, "delight" = 5)
	foodtype = GRAIN | VEGETABLES | DAIRY | JUNKFOOD

/obj/item/reagent_containers/food/snacks/pizzaslice/framewrecker/veggie
	name = "Giant veggie pizza slice"
	icon_state = "big_veggie_slice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushrooms" = 1, "delight" = 5)
	foodtype = GRAIN | VEGETABLES | DAIRY | JUNKFOOD

/obj/item/reagent_containers/food/snacks/pizza/framewrecker/attackby(var/obj/item/weapon/W, var/mob/living/user)
	if(istype(W,/obj/item/kitchen/knife))
		user.visible_message("<b>\The [user]</b> starts to slowly cut through The One Pizza.", "<span class='notice'>You start to slowly cut through The One Pizza.</span>")
		if(!src)
			return		// We got disappeared already
		user.visible_message("<b>\The [user]</b> successfully cuts The One Pizza.", "<span class='notice'>You successfully cut The One Pizza.</span>")
		for(var/slicetype in slicelist)
			new slicetype(src.loc)
		qdel(src)
