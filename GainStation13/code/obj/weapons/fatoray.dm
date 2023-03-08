///The base fatoray
/obj/item/gun/energy/fatoray
	name = "fatoray"
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
