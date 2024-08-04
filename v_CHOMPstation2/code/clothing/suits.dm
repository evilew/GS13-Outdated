//clothing ported from chompstation2

/obj/item/clothing/suit/hooded/hoodie
	name = "hoodie"
	desc = "A comfy hoodie."
	icon = 'v_CHOMPstation2/icons/mob/item_vr.dmi'
	alternate_worn_icon = 'v_CHOMPstation2/icons/mob/mob_vr.dmi'
	icon_state = "hoodie_plain"
	item_state = "hoodie_plain"
	body_parts_covered = CHEST|GROIN|ARMS
	mutantrace_variation = NO_MUTANTRACE_VARIATION
	hoodtype = /obj/item/clothing/head/hooded/hoodie
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 5, "acid" = 0)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)

/obj/item/clothing/suit/hooded/hoodie/purple
	name = "purple hoodie"
	color = "#7a287a"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/purple

/obj/item/clothing/suit/hooded/hoodie/red
	name = "red hoodie"
	color = "#7d1e1e"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/red

/obj/item/clothing/suit/hooded/hoodie/blue
	name = "blue hoodie"
	color = "#1f3499"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/blue

/obj/item/clothing/suit/hooded/hoodie/green
	name = "green hoodie"
	color = "#1a7910"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/green

/obj/item/clothing/suit/hooded/hoodie/black
	name = "black hoodie"
	color = "#1f1f1f"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/black
