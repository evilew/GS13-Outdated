/////////////////////////////////////////
///GS13 designs / nutri designs
/////////////////////////////////////////

/datum/design/fatoray_weak
	name = "Basic Fatoray"
	id = "fatoray_weak"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 2000, MAT_CALORITE = 10000)
	construction_time = 75
	build_path = /obj/item/gun/energy/fatoray
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/fatoray_oneshot
	name = "Cannonshot Fatoray"
	id = "fatoray_cannon"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 2000, MAT_CALORITE = 10000)
	construction_time = 200
	build_path = /obj/item/gun/energy/fatoray/cannon
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE


// FIX THOSE VALUES LATER!!


/datum/design/calorite_collar
	name = "Calorite Collar"
	desc = "A collar that amplifies caloric intake of the wearer."
	id = "calorite_collar"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 500, MAT_GLASS = 2000, MAT_CALORITE = 3000)
	construction_time = 75
	build_path = /obj/item/clothing/neck/petcollar/calorite
	category = list("Weapons") // FIX THIS CATEGORY LATER, FORGOT THEIR NAMES LUL
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

