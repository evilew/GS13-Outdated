//GS13 business - these clothes don't dynamically adjust to user's weight yet, got to change them manually via alt click

/obj/item/clothing/suit/dynamic_jumpsuit
	icon = 'GainStation13/icons/mob/uniforms/dynamic_clothes_icons.dmi'
	alternate_worn_icon = 'GainStation13/icons/mob/uniforms/dynamic_clothes.dmi'
	name = "dynamic wg bra"
	desc = "click alt to adjust"
	icon_state = "size_a"
	item_state = "size_a"
	flags_inv = 11 //this is a flag for hiding taur tails
	strip_delay = 80
	always_reskinnable = TRUE //we need this so that the player can always swap between sizes
	mutantrace_variation = NO_MUTANTRACE_VARIATION //this is important so it works on taur sprites
	layer = 12
	// body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	unique_reskin = list("Size A" = "size_a", "Size B" = "size_b", "Size C" = "size_c", "Size D" = "size_d", "Size E" = "size_e", "Size F" = "size_f")

/obj/item/clothing/suit/dynamic_jumpsuit/size_a
	name = "dynamic wg bra"
	desc = "click alt to adjust"
	icon_state = "size_a"
	item_state = "size_a"

/obj/item/clothing/suit/dynamic_jumpsuit/size_b
	name = "dynamic wg bra"
	desc = "click alt to adjust"
	icon_state = "size_b"
	item_state = "size_b"

/obj/item/clothing/suit/dynamic_jumpsuit/size_c
	name = "dynamic wg bra"
	desc = "click alt to adjust"
	icon_state = "size_c"
	item_state = "size_c"

/obj/item/clothing/suit/dynamic_jumpsuit/size_d
	name = "dynamic wg bra"
	desc = "click alt to adjust"
	icon_state = "size_d"
	item_state = "size_d"

/obj/item/clothing/suit/dynamic_jumpsuit/size_e
	name = "dynamic wg bra"
	desc = "click alt to adjust"
	icon_state = "size_e"
	item_state = "size_e"

/obj/item/clothing/suit/dynamic_jumpsuit/size_f
	name = "dynamic wg bra"
	desc = "click alt to adjust"
	icon_state = "size_f"
	item_state = "size_f"
