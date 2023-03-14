/////GS13 - fattening rayguns and ranged weapons

///The base fatoray
/obj/item/gun/energy/fatoray
	name = "Fatoray"
	desc = "An energy gun that fattens up anyone it hits."
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "fatoray"
	pin = null
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
	ricochets_max = 50
	ricochet_chance = 80
	is_reflectable = TRUE
	light_range = 2
	light_color = LIGHT_COLOR_ORANGE
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

////////////////////////////////////////////////////////////////////
////////FATORAYS THAT CAN BE MADE BY LATHES OR RESEARCHED///////////
////////////////////////////////////////////////////////////////////

///Weaker version of fatoray, can be produced by lathes
/obj/item/gun/energy/fatoray/weak
	name = "Basic Fatoray"
	desc = "An energy gun that fattens up anyone it hits. This version is considerably weaker than its original counterpart, the technology behind it seemingly still not  perfected."
	icon = 'GainStation13/icons/obj/fatoray.dmi'               /// REPLACE THESE LATER WITH UNIQUE SPRITES - Sono
	icon_state = "fatoray"
	ammo_type = list(/obj/item/ammo_casing/energy/fattening/weak)

/obj/item/ammo_casing/energy/fattening/weak
	name = "budget fattening weapon lens"
	select_name = "fatten"
	projectile_type = /obj/item/projectile/energy/fattening/weak

///The base projectile used by the fatoray
/obj/item/projectile/energy/fattening/weak
	name = "fat energy"            
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "ray"
	///How much fat is added to the target mob?
	fat_added = 20

///////////////////////////////////////////////////

///Single shot glass cannon fatoray
/obj/item/gun/energy/fatoray/cannon
	name = "One-Shot Fatoray"
	desc = "An energy gun that fattens up anyone it hits. This version functions as a glass cannon of some sorts."
	icon = 'GainStation13/icons/obj/fatoray.dmi'               /// REPLACE THESE LATER WITH UNIQUE SPRITES - Sono
	icon_state = "fatoray_cannon"
	can_charge = 0
	recoil = 3
	slowdown = 1
	charge_sections = 3
	weapon_weight = WEAPON_HEAVY
	ammo_type = list(/obj/item/ammo_casing/energy/fattening/oneshot)


/obj/item/ammo_casing/energy/fattening/oneshot
	name = "one-shot fattening weapon lens"
	select_name = "fatten"
	e_cost = 300
	projectile_type = /obj/item/projectile/energy/fattening/oneshot

/obj/item/projectile/energy/fattening/oneshot
	name = "fat energy"            
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "cannon_ray"
	///How much fat is added to the target mob?
	fat_added = 500

///////////////////////////////////////
