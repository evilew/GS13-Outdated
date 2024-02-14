/obj/machinery/abductor/feeder_console
	name = "feeder console"
	desc = "You were into feeding enough that you managed to reverse-engineer alien technology to suit your goals, Amazing."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "console"
	density = TRUE
	team_number = 27 // 6(F) + 1(A) + 20(T) :3
	/// What pad is linked with the console?
	var/obj/machinery/abductor/pad/pad
	/// What camera console is linked with the console?
	var/obj/machinery/computer/camera_advanced/abductor/camera
	/// What abductor gizmo is linked with the console?
	var/obj/item/abductor/gizmo/gizmo
	/// The current scale linked with the console
	var/obj/structure/scale/credits/linked_scale

/obj/machinery/abductor/feeder_console/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	user.set_machine(src)
	var/dat = ""
	dat += "<H3> FeederSoft 3000 </H3>"

	var/credits = linked_scale?.credits
	dat += "Gear Credits: [credits] <br>"
	dat += "<b>Transfer credits in exchange for supplies:</b><br>"
	dat += "<a href='?src=[REF(src)];dispense=nutripump_turbo'>Nutri-Pump TURBO Autosurgeon</A><br>"
	dat += "<a href='?src=[REF(src)];dispense=vendor_refill'>Meal Vendor Refill</A><br>"
	dat += "<a href='?src=[REF(src)];dispense=baton'>Advanced Baton</A><br>"
	dat += "<a href='?src=[REF(src)];dispense=tool'>Science Tool</A><br>"
	dat += "<a href='?src=[REF(src)];dispense=chameleon'>Chameleon Kit</A><br>"
	dat += "<a href='?src=[REF(src)];dispense=pie_cannon'>Banana Cream Pie Cannon</A><br>"	
	dat += "<a href='?src=[REF(src)];dispense=thermals'>Thermal Imaging Glasses</A><br>"
	dat += "<a href='?src=[REF(src)];dispense=reagent_gun'>Reagent Gun</A><br>"
	dat += "<a href='?src=[REF(src)];dispense=protolathe_kit'>Protolathe Kit</A><br>"

	if(pad)
		dat += "<span class='bad'>Emergency Teleporter System.</span>"
		dat += "<span class='bad'>Consider using primary observation console first.</span>"
		dat += "<a href='?src=[REF(src)];teleporter_send=1'>Activate Teleporter</A><br>"
		if(gizmo && gizmo.marked)
			dat += "<a href='?src=[REF(src)];teleporter_retrieve=1'>Retrieve Mark</A><br>"
		else
			dat += "<span class='linkOff'>Retrieve Mark</span><br>"
	else
		dat += "<span class='bad'>NO TELEPAD DETECTED</span></br>"

	var/datum/browser/popup = new(user, "computer", "Abductor Console", 400, 500)
	popup.set_content(dat)
	popup.open()

/obj/machinery/abductor/feeder_console/Topic(href, href_list)
	if(..())
		return

	usr.set_machine(src)
	if(href_list["teleporter_send"])
		TeleporterSend()
	if(href_list["dispense"])
		switch(href_list["dispense"])
			if("baton")
				Dispense(/obj/item/abductor_baton, cost=300)
			if("tool")
				Dispense(/obj/item/abductor/gizmo, cost=120)
			if("nutripump_turbo")
				Dispense(/obj/item/autosurgeon/nutripump_turbo, cost=150)
			if("vendor_refill")
				Dispense(/obj/item/vending_refill/mealdor, cost=100)
			if("chameleon")
				Dispense(/obj/item/storage/box/syndie_kit/chameleon, cost=300)
			if("pie_cannon")
				Dispense(/obj/item/pneumatic_cannon/pie/selfcharge, cost=500)
			if("thermals")
				Dispense(/obj/item/clothing/glasses/thermal/syndi, cost=400)
			if("reagent_gun")
				Dispense(/obj/item/gun/chem, cost=500)
			if("protolathe_kit")
				Dispense(/obj/item/storage/box/rndboards, cost=1500)

	updateUsrDialog()

/obj/machinery/abductor/feeder_console/proc/TeleporterRetrieve()
	if(pad && gizmo && gizmo.marked)
		pad.Retrieve(gizmo.marked)

/obj/machinery/abductor/feeder_console/proc/TeleporterSend()
	if(pad)
		pad.Send()

/obj/machinery/abductor/feeder_console/proc/SetDroppoint(turf/open/location,user)
	if(!istype(location))
		to_chat(user, "<span class='warning'>That place is not safe for the specimen.</span>")
		return

	if(pad)
		pad.teleport_target = location
		to_chat(user, "<span class='notice'>Location marked as test subject release point.</span>")

/obj/machinery/abductor/feeder_console/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/abductor/feeder_console/LateInitialize()
	if(!team_number)
		return

	for(var/obj/machinery/abductor/pad/found_pad in GLOB.machines)
		if(found_pad.team_number == team_number)
			pad = found_pad
			break

	for(var/obj/machinery/computer/camera_advanced/abductor/found_console in GLOB.machines)
		if(found_console.team_number == team_number)
			camera = found_console
			found_console.console = src

/obj/machinery/abductor/feeder_console/proc/AddGizmo(obj/item/abductor/gizmo/G)
	if(G == gizmo && G.console == src)
		return FALSE

	if(G.console)
		G.console.gizmo = null

	gizmo = G
	G.console = src
	return TRUE

/obj/machinery/abductor/feeder_console/proc/Dispense(obj/item/new_item, cost = 1)
	if(!linked_scale?.credits || linked_scale.credits < cost)
		say("Insufficent credits!")
		return TRUE

	linked_scale.credits -= cost
	say("Incoming supply!")
	var/drop_location = loc

	if(pad)
		flick("alien-pad", pad)
		drop_location = pad.loc

	new new_item(drop_location)
	return TRUE

/obj/machinery/abductor/feeder_console/attackby(obj/item/used_tool, mob/user, params)
	if(istype(used_tool, /obj/item/abductor/gizmo) && AddGizmo(used_tool))
		to_chat(user, "<span class='notice'>You link the tool to the console.</span>")
		return TRUE

	return ..()
	
/obj/structure/scale/credits
	name = "tracking scale"
	desc = "A upgraded scale that tracks to weight of all of those that have stepped on it. Using this will add credits to the feeder console"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	flags_1 = NODECONSTRUCT_1
	/// How much credits do we currently have?
	var/credits = 0
	/// How many credits are we going to reward per pound gained?
	var/credits_per_pound = 1 
	/// A list containing all of the people we've scanned and their maximum weight.
	var/list/scanned_people = list()
	/// What is the current team number?
	var/team_number = 27


/obj/structure/scale/credits/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/scale/credits/attackby(obj/item/used_tool, mob/user, params)
	if(!istype(used_tool, /obj/item/wrench))
		return ..()

	anchored = !anchored
	to_chat(user, "<span class='notice'>You [anchored ? "secure" : "unsecure"] \the [src].</span>")
	used_tool.play_tool_sound(src)
	return TRUE

/obj/structure/scale/credits/LateInitialize()
	for(var/obj/machinery/abductor/feeder_console/found_console in GLOB.machines)
		if(found_console.team_number != team_number)
			continue

		found_console.linked_scale = src

/obj/structure/scale/credits/weighperson(mob/living/carbon/human/fatty)
	. = ..()
	if(!istype(fatty))
		return FALSE

	var/credits_to_add = ((fatty.fatness * credits_per_pound) * fatnessToWeight)
	var/credits_to_remove = 0
	if(scanned_people[fatty])
		credits_to_remove = scanned_people[fatty]

	if(credits_to_add > 0)
		say("[credits_to_add] credits have been deposited into the console.")
	
	credits += max((credits_to_add - credits_to_remove), 0)

	scanned_people[fatty] = max(credits_to_add, credits_to_remove)
	return TRUE

/obj/machinery/abductor/pad/feeder
	team_number = 27

/obj/machinery/computer/camera_advanced/abductor/feeder
	team_number = 27
	vest_mode_action = null
	vest_disguise_action = null

/obj/machinery/computer/camera_advanced/abductor/feeder/IsScientist(mob/living/carbon/human/H)
	return TRUE

/obj/item/abductor/gizmo/feeder
	mode = GIZMO_MARK

/obj/item/abductor/gizmo/feeder/ScientistCheck(mob/user)
	return TRUE

/obj/item/abductor/gizmo/attack_self(mob/user)
	return

/obj/item/abductor/gizmo/feeder/mark(atom/target, mob/living/user)
	if(!ishuman(target))
		return FALSE

	if(target == marked)
		to_chat(user, "<span class='notice'>You begin to teleport [target]...</span>")
		if(!do_after(user, 45 SECONDS, target = target)) // You have to be standing still for a while
			return FALSE

		console?.pad.Retrieve(marked)
		return TRUE

	if(target == user)
		marked = user
		return TRUE

	prepare(target,user)
	return TRUE
	
