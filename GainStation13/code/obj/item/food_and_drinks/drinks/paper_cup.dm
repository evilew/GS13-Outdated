/obj/item/reagent_containers/food/drinks/drinkingglass/paper_cup
	name = "paper cup"
	icon = "GainStation13/icons/obj/paper_cups.dmi"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50)
	volume = 50
	reagent_flags = OPENCONTAINER
	spillable = TRUE
	container_HP = 5
	beaker_weakness_bitflag = PH_WEAK

/obj/item/reagent_containers/food/drinks/drinkingglass/paper_cup/small
	name = "Small Gulp Cup"
	desc = "A paper cup. It can hold up to 50 units. It's not very strong."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "small"
	materials = list(MAT_PLASTIC=200)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/drinks/drinkingglass/paper_cup/medium
	name = "Medium Gulp Cup"
	desc = "It's a paper cup, but you wouldn't call it 'medium' though. It can hold up to 70 units. It's not very strong."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "medium"
	volume = 75
	materials = list(MAT_PLASTIC=300)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/drinks/drinkingglass/paper_cup/big
	name = "Big Gulp Cup"
	desc = "A huge paper cup, a normal person would struggle to drink it all in one sitting. It can hold up to 120 units. It's not very strong."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "big"
	volume = 120
	materials = list(MAT_PLASTIC=500)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/reagent_containers/food/drinks/drinkingglass/paper_cup/extra_big
	name = "Extra Big Gulp Cup"
	desc = "A comically large paper cup. It can hold up to 160 units. It's not very strong."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "extra_big"
	volume = 160
	materials = list(MAT_PLASTIC=600)
	w_class = WEIGHT_CLASS_BULKY

/obj/item/reagent_containers/food/drinks/drinkingglass/paper_cup/super_extra_big
	name = "Super Extra Big Gulp Cup"
	desc = "Its called a paper 'cup', but it looks more like an oversized bucket to you. It can hold up to 250 units. It's not very strong."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "super_extra_big"
	volume = 250
	materials = list(MAT_PLASTIC=1000)
	w_class = WEIGHT_CLASS_HUGE
