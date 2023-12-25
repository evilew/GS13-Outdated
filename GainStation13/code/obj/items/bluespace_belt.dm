/obj/item/bluespace_belt
	name = "bluespace belt"
	desc = "A belt made using bluespace technology. The power of space and time, used to hide the fact you are fat."
	icon = 'GainStation13/icons/obj/clothing/bluespace_belt.dmi'
	icon_state = "bluespace_belt"
	item_state = "bluespace_belt"
	slot_flags = ITEM_SLOT_BELT
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound =  'sound/items/handling/toolbelt_pickup.ogg'

/obj/item/bluespace_belt/equipped(mob/user, slot)
	..()
	var/mob/living/carbon/U = user
	if(slot == SLOT_BELT)
		U.fat_hide(0)
	else
		U.fat_show()
