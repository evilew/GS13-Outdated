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

/datum/design/calorite_collar
	name = "Calorite Collar"
	desc = "A collar that amplifies caloric intake of the wearer."
	id = "calorite_collar"
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 1000, MAT_CALORITE = 4000)
	construction_time = 75
	build_path = /obj/item/clothing/neck/petcollar/calorite
	category = list("Equipment", "Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/cyberimp_nutriment_turbo
	name = "Nutriment Pump Implant TURBO"
	desc = "This implant was meant to prevent people from going hungry, but due to a flaw in its designs, it permanently produces a small amount of nutriment overtime."
	id = "ci-nutrimentturbo"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 100
	materials = list(MAT_METAL = 800, MAT_GLASS = 800, MAT_GOLD = 750, MAT_URANIUM = 1000)
	build_path = /obj/item/organ/cyberimp/chest/nutriment/turbo
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/bluespace_belt
	name = "Bluespace Belt"
	desc = "A belt made using bluespace technology. The power of space and time, used to hide the fact you are fat."
	id = "bluespace_belt"
	build_type = PROTOLATHE
	construction_time = 100
	materials = list(MAT_SILVER = 4000, MAT_GOLD = 4000, MAT_BLUESPACE = 2000)
	build_path = /obj/item/bluespace_belt
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE
