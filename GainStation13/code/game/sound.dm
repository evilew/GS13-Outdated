/proc/gs13_get_sfx(soundin)
	if(istext(soundin))
		switch(soundin)
			if("belch")
				soundin = pick(	'GainStation13/sound/voice/belch1.ogg',
								'GainStation13/sound/voice/belch2.ogg',
								'GainStation13/sound/voice/belch3.ogg',
								'GainStation13/sound/voice/belch4.ogg',
								'GainStation13/sound/voice/belch5.ogg',
								'GainStation13/sound/voice/belch6.ogg',
								'GainStation13/sound/voice/belch7.ogg',
								'GainStation13/sound/voice/belch8.ogg',
								'GainStation13/sound/voice/belch9.ogg',
								'GainStation13/sound/voice/belch10.ogg',
								'GainStation13/sound/voice/belch11.ogg')
			if("brap")
				soundin = pick(	'GainStation13/sound/voice/brap1.ogg',
								'GainStation13/sound/voice/brap2.ogg',
								'GainStation13/sound/voice/brap3.ogg',
								'GainStation13/sound/voice/brap4.ogg',
								'GainStation13/sound/voice/brap5.ogg',
								'GainStation13/sound/voice/brap6.ogg',
								'GainStation13/sound/voice/brap7.ogg',
								'GainStation13/sound/voice/brap8.ogg')
			if("burp")
				soundin = pick(	'GainStation13/sound/voice/burp1.ogg')
			if("burunyu")
				soundin = pick(	'GainStation13/sound/voice/funnycat.ogg')
			if("fart")
				soundin = pick(	'GainStation13/sound/voice/fart1.ogg',
								'GainStation13/sound/voice/fart2.ogg',
								'GainStation13/sound/voice/fart3.ogg',
								'GainStation13/sound/voice/fart4.ogg')
			if("gurgle")
				soundin = pick(	'GainStation13/sound/voice/gurgle1.ogg',
								'GainStation13/sound/voice/gurgle2.ogg',
								'GainStation13/sound/voice/gurgle3.ogg')
	return soundin
