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
	list_reagents = list(/datum/reagent/blueberry_juice = 0.5)
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
