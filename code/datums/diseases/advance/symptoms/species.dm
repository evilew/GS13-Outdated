/datum/symptom/undead_adaptation
	name = "Necrotic Metabolism"
	desc = "The virus is able to thrive and act even within dead hosts."
	stealth = 2
	resistance = -2
	stage_speed = 1
	transmittable = 0
	level = 5
	severity = 0

/datum/symptom/undead_adaptation/OnAdd(datum/disease/advance/A)
	A.process_dead = TRUE
	A.infectable_biotypes |= MOB_UNDEAD

/datum/symptom/undead_adaptation/OnRemove(datum/disease/advance/A)
	A.process_dead = FALSE
	A.infectable_biotypes &= ~MOB_UNDEAD

/datum/symptom/inorganic_adaptation
	name = "Inorganic Biology"
	desc = "The virus can survive and replicate even in an inorganic environment, increasing its resistance and infection rate."
	stealth = -1
	resistance = 4
	stage_speed = -2
	transmittable = 3
	level = 5
	severity = 0

/datum/symptom/inorganic_adaptation/OnAdd(datum/disease/advance/A)
	A.infectable_biotypes |= MOB_INORGANIC

/datum/symptom/inorganic_adaptation/OnRemove(datum/disease/advance/A)
	A.infectable_biotypes &= ~MOB_INORGANIC

/datum/symptom/robotic_adaptation //GS13
	name = "Electronic propagation"
	desc = "The virus learns to feed off and utilize electric signals to create computer virus copies of itself, allowing it to work inside of robotic hosts. Any reports stating the virus have tiny programmer socks attached to their cell's membranes are not scientifically accurate and false."
	stealth = 1
	resistance = -1
	stage_speed = 3
	transmittable = 0
	level = 5
	severity = 0

/datum/symptom/robotic_adaptation/OnAdd(datum/disease/advance/A)
	A.infectable_biotypes |= MOB_ROBOTIC

/datum/symptom/robotic_adaptation/OnRemove(datum/disease/advance/A)
	A.infectable_biotypes &= ~MOB_ROBOTIC
