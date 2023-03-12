/////GS13 - fattening raygun

///The base fatoray
/obj/item/gun/energy/fatoray
	name = "Fatoray"
	desc = "An energy gun that fattens up anyone it hits."
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "fatoray"
	ammo_type = list(/obj/item/ammo_casing/energy/fattening)

/obj/item/ammo_casing/energy/fattening
	name = "fattening weapon lens"
	select_name = "fatten"
	projectile_type = /obj/item/projectile/energy/fattening

///The base projectile used by the fatoray
/obj/item/projectile/energy/fattening
	name = "fat energy"
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "ray"
	///How much fat is added to the target mob?
	var/fat_added = 50 //Around 12.5 pounds per hit.

/obj/item/projectile/energy/fattening/on_hit(atom/target, blocked)
	. = ..()
	
	var/mob/living/carbon/gainer = target
	if(!iscarbon(gainer))
		return FALSE
	
	if(!gainer.adjust_fatness(fat_added, FATTENING_TYPE_WEAPON))
		return FALSE

	return TRUE



///Weaker version of fatoray, can be produced by lathes
/obj/item/gun/energy/fatoray_weak
	name = "Budget Fatoray"
	desc = "An energy gun that fattens up anyone it hits. This version is considerably weaker than its original counterpart."
	icon = 'GainStation13/icons/obj/fatoray.dmi'               /// REPLACE THESE LATER WITH UNIQUE SPRITES - Sono
	icon_state = "fatoray"
	ammo_type = list(/obj/item/ammo_casing/energy/fattening/weak)

/obj/item/ammo_casing/energy/fattening_weak
	name = "weak fattening weapon lens"
	select_name = "fatten"
	projectile_type = /obj/item/projectile/energy/fattening/weak

///The base projectile used by the fatoray
/obj/item/projectile/energy/fattening_weak
	name = "fat energy"            
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "ray"	
	///How much fat is added to the target mob?
	var/fat_added = 20
