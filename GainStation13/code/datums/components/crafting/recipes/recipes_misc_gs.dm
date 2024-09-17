// GS miscellaneous recipes

/datum/crafting_recipe/industrial_feeding_tube
	name = "Industrial Feeding Tube"
	reqs = list(
		/obj/machinery/iv_drip/feeding_tube = 1,
		/obj/item/stack/sheet/metal = 2,
		/obj/item/pipe = 2
	)
	parts = list(
		/obj/machinery/iv_drip/feeding_tube = 1
	)
	results = /obj/structure/disposaloutlet/industrial_feeding_tube
	tools = list(TOOL_WELDER, TOOL_WRENCH, TOOL_SCREWDRIVER)
	category = CAT_MISC
