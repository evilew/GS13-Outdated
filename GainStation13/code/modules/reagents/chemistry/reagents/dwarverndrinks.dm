///GS13 drinks!

/datum/reagent/consumable/ethanol/oily_oafs
	name = "Oily oafs"
	description = "The oily oaf. while it isn't as strong as some of the other drinks on station, Its buttery aftertaste and affordability make it a staple of any good miner's diet."
	color = "#ffc75f"
	boozepwr = 30
	taste_description = "rich butter and red sugar"
	//quality = DRINK_NICE we need to get drink quality implemented in our drink files -Eye
	glass_icon_state = "oily_oafs"
	glass_name = "oily oafs"
	glass_desc = "The oily oaf. A dwarvern classic beloved by miners around the cosmos."
	shot_glass_icon_state = "shotglassbrown"
	pH = 4.5
	value = 0.1

/datum/reagent/consumable/ethanol/glyphid_slammer
	name = "Glyphid slammer"
	description = "A mixture of strong beer and energy drink. How it manages to be as strong as it is baffles scientists to this day"
	color = "#FF8A33"
	boozepwr = 60
	taste_description = "Cheap booze and adventure"
	glass_icon_state = "glyphid_slammer"
	glass_name = "Glyphid slammer"
	glass_desc = "A bold mixture of cheap energy drink, and even cheaper ale. Beloved by partygoers and daredevils across the galaxy. Beloathed by bugpeople"
	shot_glass_icon_state = "shotglassbrown"
	pH = 4.5
	value = 0.1

/datum/reagent/consumable/ethanol/belly_bloats
	name = "Belly bloats"
	description = "A classic of this sector that bloats the waistline. Hard to stop chugging once you start."
	color = "#000000"
	boozepwr = 25
	taste_description = "a heavy mix of cherry and beer"
	quality = DRINK_GOOD
	glass_icon_state = "belly_bloats"
	glass_name = "belly bloats"
	glass_desc = "The perfect mix to be big and merry with."
	shot_glass_icon_state = "shotglassbrown"
	hydration = 3

/datum/reagent/consumable/ethanol/belly_bloats/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs.weight_gain_chems) // GS13
		M.nutrition += 15 * REAGENTS_METABOLISM
	else
		M.nutrition += 1
	..()

/datum/reagent/consumable/ethanol/blobby_mary
	name = "Blobby mary"
	description = "A bloody mary that may make you immobile. Still wondering if it's blood or tomato juice?"
	color = "#000000"
	boozepwr = 55
	taste_description = "tomateos and an anvil on your stomach"
	quality = DRINK_FANTASTIC
	glass_icon_state = "blobby_mary"
	glass_name = "blobby mary"
	glass_desc = "For the morbidly obese ladies and gentlemen."
	shot_glass_icon_state = "shotglassred"
	hydration = 4

/datum/reagent/consumable/ethanol/blobby_mary/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs.weight_gain_chems) // GS13
		M.nutrition += 25 * REAGENTS_METABOLISM
	else
		M.nutrition += 1
	..()

/datum/reagent/consumable/heavy_cafe
	name = "Heavy cafe"
	description = "Coffee, milk, sugar and cream. For the days when you really don't want to work."
	color = "#000000"
	taste_description = "coffee, milk and sugar"
	quality = DRINK_GOOD
	glass_icon_state = "heavy_cafe"
	glass_name = "heavy cafe"
	glass_desc = "To enjoy slow mornings with."
	shot_glass_icon_state = "shotglassbrown"
	hydration = 3

/datum/reagent/consumable/heavy_cafe/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	M.SetSleeping(0, FALSE)
	M.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	M.Jitter(5)
	if(M.getBruteLoss() && prob(20))
		M.heal_bodypart_damage(1,0, 0)
	if(M && M?.client?.prefs.weight_gain_chems) // GS13
		M.nutrition += 15 * REAGENTS_METABOLISM
	else
		M.nutrition += 1
	..()

/datum/reagent/consumable/fruits_tea
	name = "Fruits tea"
	description = "Somehow this mix of fruits and tea can cause considerable bulking."
	color = "#000000"
	taste_description = "a sweet and sour mix"
	quality = DRINK_NICE
	glass_icon_state = "fruits_tea"
	glass_name = "fruits tea"
	glass_desc = "Goes down really easy and stays there for a long time."
	shot_glass_icon_state = "shotglassgold"
	hydration = 4

/datum/reagent/consumable/fruits_tea/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs.weight_gain_chems) // GS13
		M.nutrition += 15 * REAGENTS_METABOLISM
	else
		M.nutrition += 1
	..()

/datum/reagent/consumable/snakebite
	name = "Snakebite"
	description = "Guaranteed to stop 100% of all moving."
	color = "#000000"
	taste_description = "bitter immobility"
	quality = DRINK_VERYGOOD
	glass_icon_state = "snakebite"
	glass_name = "snakebite"
	glass_desc = "Won't hurt like a real bite, but you'll still regert drinking this."
	shot_glass_icon_state = "shotglassgreen"
	hydration = 4

/datum/reagent/consumable/snakebite/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs.weight_gain_chems) // GS13
		M.nutrition += 25 * REAGENTS_METABOLISM
	else
		M.nutrition += 1
	..()