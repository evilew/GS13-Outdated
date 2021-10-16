//This mob is now shitass
//code probably made by quotefox, idk.

/mob/living/simple_animal/hostile/shitass
	name = "Shitass"
	desc = "The ultimate lifeform, Shitass can destroy his enemies by simply punching them."
	icon = 'gainstation/icons/mobs/shitass.dmi'
	icon_state = "shitass"
	icon_living = "shitass"
	icon_dead = "idle"
	gender = MALE
	speak_chance = 0
	turns_per_move = 2
	turns_per_move = 3
	maxHealth = 999
	health = 999
	see_in_dark = 2
	response_help  = "pets"
	response_disarm = "pushes aside"
	response_harm   = "attacks"
	melee_damage_lower = 10
	melee_damage_upper = 40
	attacktext = "attacks"
	attack_sound = 'sound/weapons/punch4.ogg'
	faction = list("hostile")
	ranged = 1
	harm_intent_damage = 56
	obj_damage = 60
	a_intent = INTENT_HARM
	ventcrawler = 1
	death_sound = 'sound/voice/ed209_20sec.ogg'
	deathmessage = "W-What, how did you? What the fuck."
	move_to_delay = 8


	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 150
	maxbodytemp = 500
	do_footstep = TRUE

/mob/living/simple_animal/hostile/carrion/OpenFire(atom/the_target)
	var/dist = get_dist(src,the_target)
	Beam(the_target, "tentacle", time=dist*2, maxdistance=dist, beam_sleep_time = 5)
	the_target.attack_animal(src)

/mob/living/simple_animal/hostile/carrion/Initialize()
//Move the sprite into position, cant use Pixel_X and Y, causes issues with the tenticle sprite!
	..()
	var/matrix/M = src.transform
	src.transform = M.Translate(-32,-32)