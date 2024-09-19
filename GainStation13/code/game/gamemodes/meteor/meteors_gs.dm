
///////////////////////
//Meteor types
///////////////////////

//Starbit reference
/obj/effect/meteor/starbit
	name = "glittery comet"
	desc = "A sparkling mass of crystalized spacedust. ...It looks oddly tasty?"
	hits = 1
	hitpwr = 1
	dropamt = 5
	threat = 1
	meteorsound = 'GainStation13/sound/effects/star.wav'
	meteordrop = list(/obj/item/stack/ore/glass)
	var/starbits = 3

/obj/effect/meteor/starbit/Initialize(mapload, target)
	. = ..()
	dropamt = rand(3,7) //Random amount of bits...
	
/obj/effect/meteor/starbit/Move()
	. = ..()
	if(.)
		new /obj/effect/temp_visual/telekinesis(get_turf(src))

/obj/effect/meteor/starbit/ram_turf(turf/T) //Sometimes it'll leave behind bits as it goes
	if(isspaceturf(T))
		return
	if(starbits <= 4)
		return
	if(prob(5))
		starbits--
		var/thing_to_spawn = pick(meteordrop)
		new thing_to_spawn(T)
				
/obj/effect/meteor/proc/get_hit()
	hits--
	if(hits <= 0)
		make_debris()
		meteor_effect()
		qdel(src)
	else
		if(starbits <= 4) //If it doesnt break, it could still drop bits...
			if(!prob(5))
				return
			starbits--
			var/thing_to_spawn = pick(meteordrop)
			new thing_to_spawn(T)
	
