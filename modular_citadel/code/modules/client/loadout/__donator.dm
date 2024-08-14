//This is the file that handles donator loadout items.

/*
/datum/gear/pingcoderfailsafe
	name = "IF YOU SEE THIS, PING A CODER RIGHT NOW!"
	category = SLOT_IN_BACKPACK
	path = /obj/item/bikehorn/golden
	ckeywhitelist = list("This entry should never appear with this variable set.") //If it does, then that means somebody fucked up the whitelist system pretty hard

/datum/gear/testreward
	//Just so admins can test the recent rewards added.
	name = "Plastitanium Shackles"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/suit/shackles
	ckeywhitelist = list("quotefox")

/datum/gear/testrewardtwo
	name = "Napoleonic Uniform"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/suit/napoleonic
	ckeywhitelist = list("quotefox")

/datum/gear/winterblooplush
	name = "Will Plush"
	category = SLOT_IN_BACKPACK
	path = /obj/item/toy/plush/mammal/winterbloo
	ckeywhitelist = list("wolfy_wolf967")

/datum/gear/winterblooplushextra
	//for some reason bloo has had issues with his plushie
	name = "Will Plush"
	category = SLOT_IN_BACKPACK
	path = /obj/item/toy/plush/mammal/winterbloo
	ckeywhitelist = list("wolfywolf967")

/datum/gear/helioplush
	name = "Chris Plushie"
	category = SLOT_IN_BACKPACK
	path = /obj/item/toy/plush/lizardplushie/chris
	ckeywhitelist = list("heliocintrini")

/datum/gear/seramarker
	name = "Blueberry Marker"
	category = SLOT_IN_BACKPACK
	path = /obj/item/pen/bluemarker
	ckeywhitelist = list("blooberri")

/datum/gear/hubertsuit
	name = "Napoleonic Uniform"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/suit/napoleonic
	ckeywhitelist = list("hackertdog")

/datum/gear/grug
	name = "Caveman Plushie"
	category = SLOT_IN_BACKPACK
	path = /obj/item/toy/plush/mammal/grug
	ckeywhitelist = list("herrdoktah")

/datum/gear/hshack
	name = "Plastitanium Shackles"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/suit/shackles
	ckeywhitelist = list("heliocintrini")

/datum/gear/hshack
	name = "Syndicate Commander's Coat"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/suit/luwethtrench
	ckeywhitelist = list("luweth")

/datum/gear/luwethring
	name = "Wedding Band"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/gloves/ring/luweth
	ckeywhitelist = list("luweth", "archiebeepboop")

/datum/gear/bluedice
	name = "Blue D20"
	category = SLOT_IN_BACKPACK
	path = /obj/item/dice/d20/blue
	ckeywhitelist = list("jackattack41498")

/datum/gear/demoncat
	name = "Inconspicuous winter coat"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/suit/hooded/wintercoat/death
	ckeywhitelist = list("demoncat")

/datum/gear/natak
	name = "Heat-B-Gone Pills"
	category = SLOT_IN_BACKPACK
	path = /obj/item/storage/pill_bottle/heat
	ckeywhitelist = list("natak")

/datum/gear/crystalshard
	name = "Crystalline Shards"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/head/crystalline
	ckeywhitelist = list("dragontrance")

/datum/gear/lyricalpawssuit
	name = "Fleet Commander's Overcoat"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/suit/chloe
	ckeywhitelist = list("lyricalpaws")

/datum/gear/lyricalpawshat
	name = "Fleet Commander's Beret"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/head/chloe
	cost = 0
	ckeywhitelist = list("lyricalpaws")

datum/gear/lyricalpawsring
	name = "Ornate Ring Box"
	category = SLOT_IN_BACKPACK
	path = /obj/item/storage/fancy/ringbox/lyricalpaws
	ckeywhitelist = list("lyricalpaws")

/datum/gear/cherostavikmask
	name = "Keaton Mask"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/mask/keaton
	ckeywhitelist = list("cherostavik")

//if this works then ckey has to be all lowercase.
//Second change maybe it has to do with underscore's (_) as well. Also fuck you it doesn't want to appear in suit/uniform it's going in backpack
/datum/gear/enzo_leonplushie
	name = "Enzo Leon Plushie"
	category = SLOT_IN_BACKPACK
	path = /obj/item/toy/plush/mammal/enzo_leon
	ckeywhitelist = list("enzoleon")

/datum/gear/enzo_leonshirt
	name = "Altevain Standard-Issue Uniform"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/under/enzoshirt
	ckeywhitelist = list("enzoleon")

/datum/gear/enzo_leonjacket
	name = "Altevain Colony-Ship Command Jacket"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/suit/toggle/enzojacket
	ckeywhitelist = list("enzoleon")

//TouchinFuzzy Patreon
/datum/gear/touchinfuzzy_uniform
	name = "Provocative jumpsuit"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/under/touchinfuzzy
	ckeywhitelist = list("touchinfuzzy")

/datum/gear/mscale
	name = "Miala's Scale"
	category = SLOT_IN_BACKPACK
	path = /obj/item/mialasscale
	ckeywhitelist = list("python13579")

/datum/gear/kiseru
	name = "Black Lacquered Kiseru"
	category = SLOT_IN_BACKPACK
	path = /obj/item/bong/kiseru
	ckeywhitelist = list("madness18","madness 18","madness_18")

/datum/gear/robes
	name = "Occult Robes"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/suit/hooded/occultrobes
	ckeywhitelist = list("relquen")
*/
//Commented out all Donator items from Hyper


//GS13: donator items and other ckey-locked junk
/datum/gear/gatobadge_employee //these are available only to admins with CC-related characters
	name = "GATO Badge - Employee"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/accessory/medal/gato_badge/employee
	ckeywhitelist = list("sonoida", "yeeny")
/datum/gear/gatobadge_middleman //these are available to players who were granted permission to have their characters to CC
	name = "GATO Badge - Correspondent"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/accessory/medal/gato_badge/middleman
	ckeywhitelist = list("johnjimjim", "sonoida", "yeeny", "Not Number")
/datum/gear/halsey_overcoat
	name = "Halsey's Commander Overcoat"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/suit/chloe/halsey
	ckeywhitelist = list("yeeny")

/datum/gear/haydee_suit
	name = "Haydee Suit"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/suit/space/hardsuit/engine/haydee
	ckeywhitelist = list("lumu", "sonoida")

/datum/gear/haydee_pistol
	name = "Haydee Pistol"
	category = SLOT_IN_BACKPACK
	path = /obj/item/gun/ballistic/automatic/toy/pistol/haydee
	ckeywhitelist = list("lumu", "sonoida")

//sorry for defining this here, just thought it'd be more convenient
/obj/item/clothing/suit/chloe/halsey //sorry to whoever chloe is, but that coat is far too badass not to be used
	name = "Halsey's Commander Overcoat"
	desc = "A Ginormous red overcoat that looks fit for a commander. Has a tag on it that reads: 'Property of Halsey Harmonten. Please return if lost!'"
	armor = list("melee" = 20, "bullet" = 20, "laser" = 0,"energy" = 20, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 0) //worn by a captain player, might as well recompensate not wearing the carapace

/datum/gear/rose_plush
	name = "Dezir Rose Plush"
	category = SLOT_IN_BACKPACK
	path = /obj/item/toy/plush/rose
	ckeywhitelist = list("eremitanovem", "sonoida")

/datum/gear/chloe_plush
	name = "Chloe Plush"
	category = SLOT_IN_BACKPACK
	path = /obj/item/toy/plush/chloe
	ckeywhitelist = list("alphas0")

/datum/gear/grimmy_coat
	name = "Overcoat of the Destitute"
	category = SLOT_IN_BACKPACK
	path = /obj/item/clothing/suit/storage/blueshield/grimmy
	ckeywhitelist = list("bbgrimmy")

/obj/item/clothing/suit/storage/blueshield/grimmy
	name = "Overcoat of the Destitute"
	desc = "Welcome all to the everlasting all-time low. Please put your hands together for the ever-failing one man show: Domino!"

/datum/gear/tarek_gps
	name = "Tarek's GPS"
	category = SLOT_IN_BACKPACK
	path = /obj/item/gps/mining
	ckeywhitelist = list("e926user25")

/datum/gear/milwaukee_crowbar
	name = "Milwaukee Pocket Crowbar"
	category = SLOT_IN_BACKPACK
	path = /obj/item/crowbar/bronze/glaug
	ckeywhitelist = list("happytpr")

/obj/item/crowbar/bronze/glaug
	name = "Milwaukee Pocket Crowbar"
	desc = "Much more expensive. Still serves the same function."

/datum/gear/fatfang
	name = "Fattening Fangs Injector"
	category = SLOT_IN_BACKPACK
	path = /obj/item/dnainjector/fatfang
	ckeywhitelist = list("sonoida")

/datum/gear/toolbelt
	name = "Empty Toolbelt"
	category = SLOT_IN_BACKPACK
	path = /obj/item/storage/belt/utility
	ckeywhitelist = list("killmewitha22", "Killmewitha22", "KILLMEWITHA22", "sonoida")

/obj/item/toy/sword/chloesabre/halsey
	name = "Halsey's Sabre"
	desc = "An elegant weapon, similar in design to the Captain's Sabre, but with a platinum hilt and an adamantine blade. the hilt has an engraved hyena on it."
	force = 16

/obj/item/gun/ballistic/revolver/mateba/moka
	name = "\improper Custom Unica 6 revolver"
	desc = "An elegant and ornate revolver belonging to a certain hellcat commander. There are some words carved on its side: 'Dura Lex, Sed Lex'"

//metha rossi you fat hog

/datum/gear/wgspell_add
	name = "Weight Gain Spellbook"
	category = SLOT_IN_BACKPACK
	path = /obj/item/book/granter/spell/fattening
	ckeywhitelist = list("sonoida", "themrsky", "Not Number")

/datum/gear/wgspell_transfer
	name = "Weight Transfer Spellbook"
	category = SLOT_IN_BACKPACK
	path = /obj/item/book/granter/spell/fattening/transfer
	ckeywhitelist = list("sonoida", "themrsky", "Not Number")

/datum/gear/wgspell_take
	name = "Weight Steal Spellbook"
	category = SLOT_IN_BACKPACK
	path = /obj/item/book/granter/spell/fattening/steal
	ckeywhitelist = list("sonoida", "themrsky", "Not Number")


/datum/gear/white_eyepatch_cabal
	name = "Cabal's Eyepatch"
	category = SLOT_GLASSES
	path = /obj/item/clothing/glasses/eyepatch/cabal
	ckeywhitelist = list("spess_lizurd", "SPESS LIZURD", "spess lizurd", "SPESS_LIZURD", "spesslizurd", "sonoida")

/datum/gear/white_eyepatch
	name = "White Eyepatch"
	category = SLOT_GLASSES
	path = /obj/item/clothing/glasses/eyepatch/white

/obj/item/clothing/glasses/eyepatch/white
	name = "White eyepatch"
	desc = "Smells faintly of medicine and headaches."
	icon_state = "eyepatch_white"
	item_state = "eyepatch_white"

/obj/item/clothing/glasses/eyepatch/cabal
	name = "Cabal's Eyepatch"
	desc = "Vulpine sluts only."
	icon_state = "eyepatch_white"
	item_state = "eyepatch_white"
