//Stuff for the quantum hub
/area/ruin/space/has_grav/powered/quantum_hub
	name = "Quantum Pad Hub"
	icon_state = "purple"

/obj/item/storage/box/quantum_pad_parts
	name = "box of quantum pad parts"
	desc = "Contains a all the parts you'd need to make a quantum pad."
	icon_state = "syndiebox"

/obj/item/storage/box/quantum_pad_parts/PopulateContents()
	new /obj/item/circuitboard/machine/quantumpad(src)
	new /obj/item/stack/ore/bluespace_crystal(src)
	new /obj/item/stock_parts/capacitor/quadratic(src)
	new /obj/item/stock_parts/manipulator/femto(src)
	new /obj/item/stack/cable_coil(src, 15)
	new /obj/item/stack/sheet/metal/twenty(src)
