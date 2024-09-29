// GS miscellaneous recipes

/datum/crafting_recipe/industrial_feeding_tube
	name = "Industrial Feeding Tube"
	reqs = list(
		// /obj/machinery/iv_drip/feeding_tube = 1, //Removing this. Seems to be buggy with not-items used to craft
		/obj/item/stack/sheet/metal = 5,
		/obj/item/stack/sheet/plastic = 5,
		/obj/item/pipe = 2,
		/obj/item/stock_parts/matter_bin = 2
	)
	parts = list(
		/obj/item/stock_parts/matter_bin = 2
	)
	result = /obj/structure/disposaloutlet/industrial_feeding_tube
	tools = list(TOOL_WELDER, TOOL_WRENCH, TOOL_SCREWDRIVER)
	category = CAT_MISC
