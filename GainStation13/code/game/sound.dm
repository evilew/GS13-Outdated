/proc/playsound_prefed(atom/source, soundin, pref, vol as num, vary, extrarange as num, falloff, frequency = null, channel = 0, pressure_affected = TRUE, ignore_walls = TRUE, soundenvwet = -10000, soundenvdry = 0)
	if(isarea(source))
		throw EXCEPTION("playsound(): source is an area")
		return

	var/turf/turf_source = get_turf(source)

	if (!turf_source)
		return

	//allocate a channel if necessary now so its the same for everyone
	channel = channel || open_sound_channel()

 	// Looping through the player list has the added bonus of working for mobs inside containers
	var/sound/S = sound(get_sfx(soundin))
	var/maxdistance = (world.view + extrarange)
	var/z = turf_source.z
	var/list/listeners = SSmobs.clients_by_zlevel[z]
	if(!ignore_walls) //these sounds don't carry through walls
		listeners = listeners & hearers(maxdistance,turf_source)
	
	for(var/P in listeners)
		var/mob/M = P
		if(!M.client)
			continue
		if((!M.client?.prefs.cit_toggles & pref))
			continue
		if(get_dist(M, turf_source) <= maxdistance)
			M.playsound_local(turf_source, soundin, vol, vary, frequency, falloff, channel, pressure_affected, S, soundenvwet, soundenvdry)
	for(var/P in SSmobs.dead_players_by_zlevel[z])
		var/mob/M = P
		if(!M.client)
			continue
		if((!M.client?.prefs.cit_toggles & pref))
			continue
		if(get_dist(M, turf_source) <= maxdistance)
			M.playsound_local(turf_source, soundin, vol, vary, frequency, falloff, channel, pressure_affected, S, soundenvwet, soundenvdry)
