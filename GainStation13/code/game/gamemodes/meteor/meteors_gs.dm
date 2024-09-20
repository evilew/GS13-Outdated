
///////////////////////
//Meteor types
///////////////////////

//Starbit reference
/obj/effect/meteor/stellar_cluster
	name = "glittery comet"
	desc = "A sparkling mass of crystalized spacedust. ...It looks oddly tasty?"
	icon = 'GainStation13/icons/obj/starbit.dmi'
	icon_state = "cluster"
	hits = 1
	hitpwr = 1
	dropamt = 5
	threat = 1
	meteorsound = 'GainStation13/sound/effects/star.wav'
	meteordrop = list(/obj/item/reagent_containers/food/snacks/stellar_piece)

/obj/effect/meteor/stellar_cluster/Initialize(mapload, target)
	. = ..()
	dropamt = rand(3,7) //Random amount of bits...
	
/obj/effect/meteor/stellar_cluster/Move()
	. = ..()
	if(.)
		new /obj/effect/temp_visual/telekinesis(get_turf(src))

/obj/effect/meteor/stellar_cluster/Bump(atom/A)
	if(!A)
		return
	
	ram_turf(get_turf(A))
	playsound(src.loc, meteorsound, 40, 1)
	get_hit()
	

/obj/effect/meteor/stellar_cluster/ram_turf(turf/T) //Sometimes it'll leave behind bits as it goes
	if(isspaceturf(T))
		return
	if(dropamt <= 2)
		return
	if(prob(5))
		dropamt--
		var/thing_to_spawn = pick(meteordrop)
		new thing_to_spawn(T)
				
/obj/effect/meteor/stellar_cluster/get_hit()
	hits--
	if(hits <= 0)
		make_debris()
		meteor_effect()
		qdel(src)
	
