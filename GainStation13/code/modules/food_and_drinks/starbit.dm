// Starbits from Super Mario Galaxy! Had this idea while watching someone do a playthrough in a discord stream.
// ~~Starbits~~ Stellar Pieces:tm: drop from meteor-like comets which leave a handful behind when they impact, while
// also not actually dealing any damage to whatever they impact.

/obj/item/reagent_containers/food/snacks/starbit
	name = "stellar piece" //PlzDontSueMeNintendo
	desc = "A small bit of crystalized stellar sugar. They're a rare delicacy that sometimes form under particular conditions inside of comets"
	// I had help creating these sprites because Im worthless at doing sprites from scratch.
	// Special thanks to @foxtsra on discord!
	// -Reo
	icon = "GainStation13/icons/obj/starbit.dmi" 
	icon_state = "bit"
	bitesize = 4
	list_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/stellarsugar = 5)

/obj/item/reagent_containers/food/snacks/starbit/initialize(mapload, var/bit_color)
	. = ..()
	
	if(!bit_color)				// Color wasnt specified, lets become a random color.
		bit_color = pick(list(	// These are the colors starbits can be naturally in SMG. 
			"red",				// so they're also the colors we can naturally be in spess.
			"blue",
			"purple",
			"yellow",
			"green",
			"white",
		))
	switch(bit_color)
		if("red")
			color = "#f22604" // Red / Orange. I think it's red, but it seems to be offically labled as orange..
		if("blue")
			color = "#097bf6" // Blue.
		if("purple")
			color = "#a210e0" // Purple.
		if("yellow")
			color = "#e0bf10" // Yellow.
		if("green")
			color = "#10e026" // Green.
		if("white")
			color = "#e0e0e0" // White... I was considering leaving it unmodified, but this makes it contrast a bit better.
		else
			color = bit_color // Some other color.
			add_overlay(bit_glimmer)
			return

	desc += "\nThis one seems to be [bit_color]."
	add_overlay("bit_glimmer")
	
