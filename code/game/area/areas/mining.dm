/**********************Mine areas**************************/

/area/mine
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY

/area/mine/explored
	name = "Mine"
	icon_state = "explored"
	music = null
	always_unpowered = TRUE
	requires_power = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	outdoors = TRUE
	flags_1 = NONE
	ambientsounds = MINING

/area/mine/unexplored
	name = "Mine"
	icon_state = "unexplored"
	music = null
	always_unpowered = TRUE
	requires_power = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	outdoors = TRUE
	flags_1 = NONE
	ambientsounds = MINING

/area/mine/lobby
	name = "Mining Station"

/area/mine/storage
	name = "Mining Station Storage"

/area/mine/production
	name = "Mining Station Starboard Wing"
	icon_state = "mining_production"

/area/mine/abandoned
	name = "Abandoned Mining Station"

/area/mine/living_quarters
	name = "Mining Station Port Wing"
	icon_state = "mining_living"

/area/mine/eva
	name = "Mining Station EVA"
	icon_state = "mining_eva"

/area/mine/maintenance
	name = "Mining Station Communications"

/area/mine/cafeteria
	name = "Mining Station Cafeteria"

/area/mine/hydroponics
	name = "Mining Station Hydroponics"

/area/mine/sleeper
	name = "Mining Station Emergency Sleeper"

/area/mine/laborcamp
	name = "Labor Camp"

/area/mine/laborcamp/security
	name = "Labor Camp Security"
	icon_state = "security"
	ambientsounds = HIGHSEC



/**********************Lavaland Areas**************************/

/area/lavaland
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE

/area/lavaland/surface
	name = "Lavaland"
	icon_state = "explored"
	music = null
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = MINING

/area/lavaland/underground
	name = "Lavaland Caves"
	icon_state = "unexplored"
	music = null
	always_unpowered = TRUE
	requires_power = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	ambientsounds = MINING


/area/lavaland/surface/outdoors
	name = "Lavaland Wastes"
	outdoors = TRUE

/area/lavaland/surface/outdoors/unexplored //monsters and ruins spawn here
	icon_state = "unexplored"
	mob_spawn_allowed = TRUE

/area/lavaland/surface/outdoors/unexplored/danger //megafauna will also spawn here
	icon_state = "danger"
	megafauna_spawn_allowed = TRUE

/area/lavaland/surface/outdoors/explored
	name = "Lavaland Labor Camp"

/area/lavaland/demone/tele
	name= "Demone Teleporter Room"
	icon_state= "demonetp"


/area/lavaland/demone/living
	name= "Demone Living Area"
	icon_state= "demoneliving"

/area/lavaland/demone/kitchen
	name= "Demone Mining Kitchen"
	icon_state= "demonekitchen"

/area/lavaland/demone/minestorage
	name= "Demone Mining Storage"
	icon_state= "demonestorage"

/area/lavaland/demone/factoryoffice
	name= "Factory CEO Office"
	icon_state= "demonceo"

/area/lavaland/demone/lobby
	name= "Factory Lobby"
	icon_state= "demonelobby"

/area/lavaland/demone/reception
	name= "Factory Reception"
	icon_state= "demonereception"

/area/lavaland/demone/factorystorage
	name= "Factory Storage"
	icon_state= "factorystorage"

/area/lavaland/demone/factory
	name= "Factory"
	icon_state= "demonefactory"

/area/lavaland/demone/factorygen
	name= "Factory Generator Room"
	icon_state= "demonegen"

/area/lavaland/demone/villagesilo
	name= "Demone Village Silo"
	icon_state= "demonesilo"

/area/lavaland/demone/villagepsu
	name= "Village Generator Room"
	icon_state= "demonevilpsu"

/area/lavaland/demone/demonevillage
	name= "Village "
	icon_state= "demonevillage"

