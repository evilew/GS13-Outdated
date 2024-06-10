/////GS13 - miscellanous items. If it's a small item, a container or something
/////then it should land here, instead of making a seperate .dm file

//fatoray research scraps (maintloot)

/obj/item/trash/fatoray_scrap1
	name = "raygun scraps"
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "fatoray_scrap1"
	desc = "Small parts that seemingly once belonged to some sort of a raygun."

/obj/item/trash/fatoray_scrap2
	name = "raygun scraps"
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "fatoray_scrap2"
	desc = "Small parts that seemingly once belonged to some sort of a raygun."

// GS13 fatty liquid beakers defs, for admin stuff and mapping junk

/obj/item/reagent_containers/glass/beaker/lipoifier
	list_reagents = list(/datum/reagent/consumable/lipoifier = 50)

/obj/item/reagent_containers/glass/beaker/cornoil
	list_reagents = list(/datum/reagent/consumable/cornoil = 50)

/obj/item/reagent_containers/glass/beaker/blueberry_juice
	list_reagents = list(/datum/reagent/blueberry_juice = 50)

/obj/item/reagent_containers/glass/beaker/fizulphite
	list_reagents = list(/datum/reagent/consumable/fizulphite = 50)

/obj/item/reagent_containers/glass/beaker/extilphite
	list_reagents = list(/datum/reagent/consumable/extilphite = 50)

/obj/item/reagent_containers/glass/beaker/calorite_blessing
	list_reagents = list(/datum/reagent/consumable/caloriteblessing = 50)

/obj/item/reagent_containers/glass/beaker/flatulose
	list_reagents = list(/datum/reagent/consumable/flatulose = 50)

//blueberry gum snack

/obj/item/reagent_containers/food/snacks/blueberry_gum
	name = "blueberry gum"
	icon = 'GainStation13/icons/obj/gum.dmi'
	icon_state = "gum_wrapped"
	desc = "Doesn't cause anything more than some discoloration... probably."
	trash = /obj/item/trash/blueberry_gum
	list_reagents = list(/datum/reagent/blueberry_juice = 50)
	bitesize = 5
	filling_color = "#001aff"
	tastes = list("blueberry gum" = 1)
	foodtype = FRUIT
	price = 5

//blueberry gum trash

/obj/item/trash/blueberry_gum
	name = "chewed gum"
	icon = 'GainStation13/icons/obj/gum.dmi'
	icon_state = "gum_chewed"

// nutriment pump turbo

/obj/item/autosurgeon/nutripump_turbo
	desc = "A single use autosurgeon that contains a turbo version of the nutriment pump. A screwdriver can be used to remove it, but implants can't be placed back in."
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/chest/nutriment/turbo

//fast food restaurant - closed / open signs
/obj/item/holosign_creator/restaurant
	name = "Holosign Projector - Restaurant Adverts"
	desc = "A holo-sign maker, used for placing signs that advertises the local fast food restaurant."
	icon = 'GainStation13/icons/obj/holosign.dmi'
	icon_state = "holo_fastfood"
	holosign_type = /obj/structure/holosign/restaurant
	creation_time = 0
	max_signs = 6

/obj/item/holosign_creator/closed
	name = "Holosign Projector - Closing Sign"
	desc = "A holo-sign maker, used for placing signs that inform people of a location being closed off."
	icon = 'GainStation13/icons/obj/holosign.dmi'
	icon_state = "holo_closed"
	holosign_type = /obj/structure/holosign/barrier/closed
	creation_time = 0
	max_signs = 6

//holosigns used by the holosign creators
/obj/structure/holosign/restaurant
	name = "The Restaurant is OPEN! Come visit!"
	desc = "A holographic projector that displays a sign advertising the nearby Fast Food Restaurant."
	icon = 'GainStation13/icons/obj/holosign.dmi'
	icon_state = "holosign_ad"

/obj/structure/holosign/barrier/closed
	name = "This Location is Closed!"
	desc = "A short holographic barrier used to close off areas. Can be passed by walking."
	icon = 'GainStation13/icons/obj/holosign.dmi'
	icon_state = "holosign_closed"

//ID for fastfood wagies so they can use the tele
/obj/item/card/id/silver/restaurant
	name = "silver identification card"
	desc = "A silver ID, given to the GATO's fast food restaurant workers. Doesn't grant much besides teleporter access."
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_TELEPORTER)

//gato decal, should be moved elsewhere tbh
/obj/effect/decal/big_gato //96x96 px sprite
	name = "GATO"
	desc = "Your employer! Probably."
	icon = 'GainStation13/icons/turf/96x96.dmi'
	icon_state = "gato"
	layer = ABOVE_OPEN_TURF_LAYER
	pixel_x = -32
	pixel_y = -32

/obj/effect/decal/medium_gato //64x64 px sprite
	name = "GATO"
	desc = "Your employer! Probably."
	icon = 'GainStation13/icons/turf/64x64.dmi'
	icon_state = "gato"
	layer = ABOVE_OPEN_TURF_LAYER
	pixel_y = -16
	pixel_x = -16


//collar voice modulators, based on cow/pig masks

/obj/item/clothing/mask/pig/gag //this one only lets you say "oink" and similar
	name = "Voice modulator - pig"
	desc = "A small gag, used to silence people in a rather 'original' way."
	icon_state = "ballgag"
	item_state = "ballgag"
	flags_inv = HIDEFACE
	clothing_flags = VOICEBOX_TOGGLABLE
	w_class = WEIGHT_CLASS_SMALL
	modifies_speech = TRUE

/obj/item/clothing/mask/cowmask/gag //this one only lets you say "moo" and similar
	name = "Voice modulator - cow"
	desc = "A small gag, used to silence people in a rather 'original' way."
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "ballgag"
	item_state = "ballgag"
	flags_inv = HIDEFACE

/obj/item/service_sign
	name = "service sign"
	desc = "A sign that reads 'closed'"
	icon = 'GainStation13/icons/obj/service_sign.dmi'
	icon_state = "sign_closed"

/obj/item/service_sign/attack_self()
	if(icon_state == "sign_closed")
		icon_state = "sign_open"
		desc = "A sign that reads 'open'"
	else
		icon_state = "sign_closed"
		desc = "A sign that reads 'closed'"

/obj/item/trash/odd_disk
	name = "odd disk"
	icon = 'icons/obj/module.dmi'
	icon_state = "datadisk0"
	desc = "A dusty disk, desconstruction will be needed to recover data."
