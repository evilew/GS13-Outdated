/obj/item/clothing/mask/gas/fattening
	name = "drone mask"
	desc = "A mask that can be connected to an air supply. When seen from certain angles, an orange light is reflected by it."
	icon = 'GainStation13/icons/obj/clothing/fat_mask.dmi'
	icon_state = "fat_mask"
	item_state = "fat_mask"
	var/mob/living/carbon/C

/obj/item/clothing/mask/gas/fattening/equipped(mob/M, slot)
	. = ..()
	if (slot == SLOT_WEAR_MASK)
		if(iscarbon(M))
			C = M
			START_PROCESSING(SSobj, src)
	else
		C = null
		return PROCESS_KILL

/obj/item/clothing/mask/gas/fattening/process()
	if(C != null)
		C.adjust_fatness(5, FATTENING_TYPE_ITEM)
	else
		return PROCESS_KILL

/datum/crafting_recipe/fat_mask
	name = "Drone Mask"
	result = /obj/item/clothing/mask/gas/fattening
	reqs = list(/obj/item/stack/sheet/mineral/calorite = 1, /obj/item/clothing/mask/gas = 1)
	category = CAT_CLOTHING
