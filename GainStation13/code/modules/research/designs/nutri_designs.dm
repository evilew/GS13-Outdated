/////////////////////////////////////////
///GS13 designs / nutri designs
/////////////////////////////////////////

/datum/design/fatoray_weak
	name = "Basic Fatoray"
	desc = "A weaker version of the original fatoray."
	id = "fatoray_weak"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 1000, MAT_GLASS = 500, MAT_CALORITE = 3000)
	construction_time = 75
	build_path = /obj/item/gun/energy/fatoray
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE
