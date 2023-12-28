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
		to_chat(user, "<span class='notice'>You put the belt around your waist and your mass begins to shrink...</span>")
		U.fat_hide(0)
	else
		to_chat(user, "<span class='notice'>The belt is opened, letting your mass flow out!</span>")
		U.fat_show()

/obj/item/bluespace_belt/dropped(mob/user)
	..()
	to_chat(user, "<span class='warning'>The belt is opened, letting your mass flow out!</span>")
	var/mob/living/carbon/U = user
	U.fat_show()
