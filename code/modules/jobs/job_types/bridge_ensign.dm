/datum/job/bridge_ensign
	title = JOB_BRIDGE_ENSIGN
	description = "Assist the captain and Head of Personnel." //PARIAH EDIT
	department_head = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL)
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = "the captain & head of personnel"
	selection_color = "#1d1d4f"
	minimal_player_age = 10
	exp_requirements = 60
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SERVICE
	exp_granted_type = EXP_TYPE_CREW

	employers = list(
		/datum/employer/cec,
		/datum/employer/eg,
		/datum/employer/uni,
		/datum/employer/none
	)

	outfits = list(
		"Default" = list(
			SPECIES_HUMAN = /datum/outfit/job/ensign,
		),
	)

	departments_list = list(
		/datum/job_department/command,
		)

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_STATION_MASTER

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	mail_goodies = list(
		/obj/item/card/id/advanced/silver = 10,
		/obj/item/stack/sheet/bone = 5
	)

	family_heirlooms = list(/obj/item/reagent_containers/cup/glass/trophy/silver_cup)
	rpg_title = "Glorified Assistant"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN



/datum/outfit/job/ensign
	name = "Bridge Ensign"
	jobtype = /datum/job/bridge_ensign

	id = /obj/item/card/id/advanced
	id_template = /datum/access_template/job/bridge_ensign
	uniform = /obj/item/clothing/under/rank/civilian/ds_bridgeensign
	belt = /obj/item/storage/belt/holster/ds/command/full
	ears = /obj/item/radio/headset/heads/hop
	shoes = /obj/item/clothing/shoes/laceup
