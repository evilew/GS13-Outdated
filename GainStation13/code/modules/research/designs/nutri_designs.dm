/////////////////////////////////////////
///GS13 designs / nutri designs
/////////////////////////////////////////

/datum/design/fatoray_weak
	name = "Basic Fatoray"
	id = "fatoray_weak"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 8000, MAT_GLASS = 6000, MAT_CALORITE = 20000)
	construction_time = 75
	build_path = /obj/item/gun/energy/fatoray/weak
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SECURITY

/datum/design/fatoray_cannon_weak
	name = "Cannonshot Fatoray"
	id = "fatoray_cannon_weak"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 10000, MAT_GLASS = 8000, MAT_CALORITE = 30000)
	construction_time = 200
	build_path = /obj/item/gun/energy/fatoray/cannon_weak
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SECURITY


// FIX THOSE VALUES LATER!!


/datum/design/calorite_collar
	name = "Calorite Collar"
	desc = "A collar that amplifies caloric intake of the wearer."
	id = "calorite_collar"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 1000, MAT_CALORITE = 4000)
	construction_time = 75
	build_path = /obj/item/clothing/neck/petcollar/calorite
	category = list("Equipment") // FIX THIS CATEGORY LATER, FORGOT THEIR NAMES LUL
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

