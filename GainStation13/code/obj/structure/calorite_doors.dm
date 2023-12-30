/obj/structure/mineral_door/calorite //GS13
	name = "calorite door"
	icon = 'GainStation13/icons/obj/structure/calorite_door.dmi'
	icon_state = "calorite"
	sheetType = /obj/item/stack/sheet/mineral/calorite
	max_integrity = 200
	light_range = 1
	state = TRUE

/obj/structure/mineral_door/calorite/Initialize()
	. = ..()
	AddComponent(/datum/component/fattening_door)
	update_icon()

