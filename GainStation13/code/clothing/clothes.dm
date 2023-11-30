//GS13 business - these clothes don't dynamically adjust to user's weight yet, got to change them manually via alt click

/obj/item/clothing/under/dynamic_jumpsuit
	icon = 'GainStation13/icons/mob/uniforms/dynamic_clothes_icons.dmi'
	alternate_worn_icon = 'GainStation13/icons/mob/uniforms/dynamic_clothes.dmi'
	name = "dynamic wg jumpsuti"
	desc = "click alt to adjust"
	icon_state = "default"
	item_state = "default"
	flags_inv = 11 //this is a flag for hiding taur tails
	strip_delay = 80
	always_reskinnable = TRUE //we need this so that the player can always swap between sizes
	mutantrace_variation = NO_MUTANTRACE_VARIATION //this is important so it works on taur sprites
	unique_reskin = list("Default" = "default", "Chubby" = "chubby", "Fatty" = "fatty")


/obj/item/clothing/under/dynamic_jumpsuit/chubby
	icon = 'GainStation13/icons/mob/uniforms/dynamic_clothes_icons.dmi'
	alternate_worn_icon = 'GainStation13/icons/mob/uniforms/dynamic_clothes.dmi'
	name = "dynamic wg jumpsuit chubby"
	desc = "click alt to adjust"
	icon_state = "chubby"
	item_state = "chubby"
	flags_inv = 0
	strip_delay = 80
	always_reskinnable = TRUE
	mutantrace_variation = NO_MUTANTRACE_VARIATION
	unique_reskin = list("Default" = "default", "Chubby" = "chubby", "Fatty" = "fatty")

/obj/item/clothing/under/dynamic_jumpsuit/fatty
	icon = 'GainStation13/icons/mob/uniforms/dynamic_clothes_icons.dmi'
	alternate_worn_icon = 'GainStation13/icons/mob/uniforms/dynamic_clothes.dmi'
	name = "dynamic wg jumpsuit fatty"
	desc = "click alt to adjust"
	icon_state = "fatty"
	item_state = "fatty	"
	flags_inv = 0
	strip_delay = 80
	always_reskinnable = TRUE
	mutantrace_variation = NO_MUTANTRACE_VARIATION
	unique_reskin = list("Default" = "default", "Chubby" = "chubby", "Fatty" = "fatty")
