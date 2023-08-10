/mob/living/simple_animal/hostile/feed
	var/food_per_feeding = 5
	var/food_fed = /datum/reagent/consumable/nutriment

/mob/living/simple_animal/hostile/feed/AttackingTarget()
	. = ..()
	var/mob/living/carbon/L = target
	if(L.client?.prefs?.weight_gain_weapons)
		if(L.reagents)
			if(!L.is_mouth_covered(head_only = 1))
				L.reagents.add_reagent(food_fed, food_per_feeding)

/mob/living/simple_animal/hostile/feed/chocolate_slime
	name = "Chocolate slime"
	desc = "It's a living blob of tasty chocolate!"
	icon = 'GainStation13/icons/mob/candymonster.dmi'
	icon_state = "a_c_slime"
	icon_living = "a_c_slime"
	icon_dead = "a_c_slime_dead"
	speak_emote = list("blorbles")
	emote_hear = list("blorbles")
	speak_chance = 5
	turns_per_move = 5
	see_in_dark = 10
	butcher_results = list(/obj/item/reagent_containers/food/snacks/chocolatebar = 4)
	response_help  = "pets"
	response_disarm = "shoos"
	response_harm   = "hits"
	maxHealth = 20
	health = 20
	obj_damage = 0
	melee_damage_lower = 0.001
	melee_damage_upper = 0.001
	faction = list("slime")
	pass_flags = PASSTABLE
	move_to_delay = 7
	ventcrawler = VENTCRAWLER_ALWAYS
	attacktext = "feeds itself to"
	attack_sound = 'sound/items/eatfood.ogg'
	unique_name = 1
	gold_core_spawnable = HOSTILE_SPAWN
	see_in_dark = 3
	blood_volume = 0
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	initial_language_holder = /datum/language_holder/slime



