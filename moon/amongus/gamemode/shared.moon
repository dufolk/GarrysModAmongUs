--- Shared things.
-- Defines the game mode metadata fields, enums and exports some useful things.
-- @module shared

export GAMEMODE = GAMEMODE or GM

AddCSLuaFile()

GM.Name 		= "Among Us"
GM.Author 		= "NotMyWing and contributors, with assets by InnerSloth"
GM.Email 		= "winwyv@gmail.com"
GM.Website 		= "https://github.com/NotMyWing/GarrysModAmongUs"

flags = bit.bor FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_GAMEDLL

--- Table of all ConVars the game mode is using.
-- These are tracked and cannot be changed during the round.
-- @table GM.ConVars
-- @field ImposterCount (Integer) Max. imposters.
-- @field ImposterCount (Integer) Min. players.
-- @field KillCooldown (Integer) Kill cooldown.
-- @field KillDistanceMod (Number) Kill distance multiplier.
-- @field ConfirmEjects (Bool) Should the ejects be confirmed?
-- @field DeadChat (Bool) Should dead players be able to talk?
-- @field GameChat (Bool) Should players be able to talk during the game?
-- @field MeetingCooldown (Integer) Meeting cooldown.
-- @field MeetingsPerPlayer (Integer) How many meetings a crewmate can call.
-- @field VoteTime (Integer) How long the voting lasts.
-- @field VotePreTime (Integer) How long the pre-voting state lasts.
-- @field VotePostTime (Integer) How long the post-voting state lasts.
-- @field TasksShort (Integer) Max short tasks crewmates can get.
-- @field TasksLong (Integer) Max long tasks crewmates can get.
-- @field TasksCommon (Integer) Max common tasks crewmates can get.
-- @field TasksVisual (Bool) Should the visual parts of tasks be enabled?
-- @field DistributeTasksToBots (Bool) Should bot get any tasks?
-- @field TimeLimit (Integer) Round time limit.
-- @field Countdown (Integer) How long the pre-round countdown lasts.
-- @field WarmupTime (Integer) How long should the warmup phase last?
-- @field ForceAutoWarmup (Bool) Should the automated round management be forced?
GM.ConVars =
	ImposterCount:   CreateConVar "au_max_imposters"   , 1 , flags, "", 1, 10
	MinPlayers:      CreateConVar "au_min_players"     , 3 , flags, "", 3, 128
	KillCooldown:    CreateConVar "au_kill_cooldown"   , 20, flags, "", 1, 60
	KillDistanceMod: CreateConVar "au_killdistance_mod", 1 , flags, "", 1, 3
	ConfirmEjects:   CreateConVar "au_confirm_ejects"  , 1 , flags, "", 0, 1
	DeadChat:        CreateConVar "au_dead_chat"       , 0 , flags, "", 0, 1
	GameChat:        CreateConVar "au_game_chat"       , 0 , flags, "", 0, 1

	MeetingCooldown:   CreateConVar "au_meeting_cooldown"      , 20, flags, "", 1, 60
	MeetingsPerPlayer: CreateConVar "au_meeting_available"     , 2 , flags, "", 1, 5
	VoteTime:          CreateConVar "au_meeting_vote_time"     , 30, flags, "", 1, 90
	VotePreTime:       CreateConVar "au_meeting_vote_pre_time" , 15, flags, "", 1, 60
	VotePostTime:      CreateConVar "au_meeting_vote_post_time", 5 , flags, "", 1, 20

	TasksShort:  CreateConVar "au_tasks_short"        , 2, flags, "", 0, 5
	TasksLong:   CreateConVar "au_tasks_long"         , 1, flags, "", 0, 5
	TasksCommon: CreateConVar "au_tasks_common"       , 1, flags, "", 0, 5
	TasksVisual: CreateConVar "au_tasks_enable_visual", 0, flags, "", 0, 1

	DistributeTasksToBots: CreateConVar "au_debug_bot_tasks" , 0, flags, "", 0, 1
	MeetingBotVote:        CreateConVar "au_debug_bot_vote"  , 0, flags, "", 0, 1

	TimeLimit: CreateConVar "au_time_limit", 600, flags, "", 0, 1200
	Countdown: CreateConVar "au_countdown" , 5  , flags, "", 1, 10

	WarmupTime:      CreateConVar "au_warmup_time"      , 60, flags, "", 0, 120
	ForceAutoWarmup: CreateConVar "au_warmup_force_auto", 0 , flags, "", 0, 1

--- Enum of all colors players can get.
-- @warning This isn't the best approach. Needs fixing.
-- @table GM.Colors
GM.Colors = {
	Color 0, 0, 0
	Color 0, 0, 255
	Color 0, 21, 68
	Color 0, 71, 84
	Color 0, 95, 57
	Color 0, 100, 1
	Color 0, 118, 255
	Color 0, 125, 181
	Color 0, 143, 156
	Color 0, 155, 255
	Color 0, 174, 126
	Color 0, 185, 23
	Color 0, 255, 0
	Color 0, 255, 120
	Color 0, 255, 198
	Color 1, 0, 103
	Color 1, 208, 255
	Color 1, 255, 254
	Color 14, 76, 161
	Color 38, 52, 0
	Color 67, 0, 44
	Color 95, 173, 78
	Color 98, 14, 0
	Color 104, 61, 59
	Color 106, 130, 108
	Color 107, 104, 130
	Color 117, 68, 177
	Color 119, 77, 0
	Color 120, 130, 49
	Color 122, 71, 130
	Color 126, 45, 210
	Color 133, 169, 0
	Color 144, 251, 146
	Color 145, 208, 203
	Color 149, 0, 58
	Color 150, 138, 232
	Color 152, 255, 82
	Color 158, 0, 142
	Color 164, 36, 0
	Color 165, 255, 210
	Color 167, 87, 64
	Color 181, 0, 255
	Color 187, 136, 0
	Color 189, 198, 255
	Color 189, 211, 147
	Color 190, 153, 112
	Color 194, 140, 159
	Color 213, 255, 0
	Color 222, 255, 116
	Color 229, 111, 254
	Color 232, 94, 190
	Color 254, 137, 0
	Color 255, 0, 0
	Color 255, 0, 86
	Color 255, 0, 246
	Color 255, 2, 157
	Color 255, 110, 65
	Color 255, 116, 163
	Color 255, 147, 126
	Color 255, 166, 254
	Color 255, 177, 103
	Color 255, 219, 102
	Color 255, 229, 2
	Color 255, 238, 232
}

--- Enum of all flow types.
--
-- "Flow" is a reliable channel used for pretty much everything
-- related to networking data between the server and clients.
--
-- Using one channel guarantees the lack of race conditions.
-- Besides, polluting the game with tens of random network strings is just bad.
GM.FlowTypes = {
	GameStart: 1
	Countdown: 2
	KillRequest: 3
	BroadcastDead: 4
	KillCooldown: 5
	GameState: 6
	GameOver: 7
	Meeting: 8
	OpenDiscuss: 9
	Eject: 10
	MeetingVote: 11
	MeetingEnd: 12
	NotifyVent: 13
	VentAnim: 14
	VentRequest: 15
	RequestUpdate: 16
	TasksUpdateData: 17
	TasksSubmit: 18
	GameChatNotification: 19
	CloseVGUI: 20
	TasksUpdateCount: 21
	NotifyKilled: 22
	KillCooldownPause: 23
	OpenVGUI: 24
	SabotageData: 25
	SabotageRequest: 26
	SabotageSubmit: 27
	UNUSED2: 28
	ConVarSnapshots: 29
	ConnectDisconnect: 30
}

GM.FlowSize = math.ceil math.log table.Count(GM.FlowTypes) + 1, 2

--- Enum of all task types available in the game mode.
-- @field Short 1
-- @field Long 2
-- @field Common 3
GM.TaskType = {
	Short: 1
	Long: 2
	Common: 3
}

--- Enum of game states.
-- @warning This is probably redundant?
-- @field Preparing 1
-- @field Playing 2
GM.GameState = {
	Preparing: 1
	Playing: 2
}

--- Enum of all reasons why a round can end.
-- @table GM.GameOverReason
-- @field Imposter 1
-- @field Crewmate 2
GM.GameOverReason = {
	Imposter: 1
	Crewmate: 2
}

--- Enum of all reasons why a crewmate can be ejected.
-- @table GM.EjectReason
-- @field Vote 1
-- @field Tie 2
-- @field Skipped 3
GM.EjectReason = {
	Vote: 1
	Tie: 2
	Skipped: 3
}

--- Enum of all actions related to vents.
-- @table GM.VentNotifyReason
-- @field Vent 1
-- @field UnVent 2
-- @field Move 3
GM.VentNotifyReason = {
	Vent: 1
	UnVent: 2
	Move: 3
}

GM.SplashScreenTime = 8
GM.BaseUseRadius = 96

--- Fetches all valid and alive players.
-- This is only ever used once, and not for the gameplay reasons.
-- If you want to iterate through alive players, consider looking at
-- GAMEMODE.GameData.PlayerTables and using the
-- GAMEMODE.GameData.DeadPlayers lookup table instead.
GM.GetAlivePlayers = =>
	players = {}

	if @GameData.PlayerTables and @GameData.DeadPlayers
		for _, v in ipairs @GameData.PlayerTables
			disconnected = not IsValid v.entity
			if not disconnected and not @GameData.DeadPlayers[v]
				table.insert players, v

	return players

GM.Util = {}

--- Sorts the table of entities based on how close an entity is to the specified one.
-- While this function returns a table, it mutates
-- the input table as well. It only returns it back
-- for the sake of your convenience.
-- @param tbl Table of entities.
-- @param entity Entity we're sorting agaist.
-- @return The sorted table.
GM.Util.SortByDistance = (tbl, destination) ->
	memo = {}
	table.sort tbl, (a, b) ->
		memo[a] or= (a\GetPos! - destination)\Length!
		memo[b] or= (b\GetPos! - destination)\Length!

		return memo[a] > memo[b]

	return tbl

--- Shuffles the table.
-- While this function returns a table, it mutates
-- the input table as well. It only returns it back
-- for the sake of your convenience.
-- @param t The table you need to shuffle.
-- @return The shuffled table.
GM.Util.Shuffle = (t) ->
	for i = #t, 2, -1
		j = math.random i
		t[i], t[j] = t[j], t[i]

	return t

--- Finds all entities with the matching task name field.
-- @string taskname You guessed it.
-- @bool first Should this function only return the first found entity?
GM.Util.FindEntsByTaskName = (taskname, first = false) ->
	with t = {}
		for _, ent in ipairs ents.GetAll!
			if ent.GetTaskName and ent\GetTaskName! == taskname
				table.insert t, ent
				if first
					return t

--- Finds a pair of the closest interactable and killable entities
-- within the reach of the player in question.
-- @param ply The player ENTITY.
-- @return The closest killable entity. Nullable.
-- @return The closest usable entity. Nullable.
GM.TracePlayer = (ply) =>
	return unless @IsGameInProgress!

	startPos = ply\EyePos!
	entities = ents.FindInSphere startPos, @BaseUseRadius * @ConVarSnapshots.KillDistanceMod\GetFloat!

	usable = {}
	highlightable = {}
	killable = {}

	playerTable = ply\GetAUPlayerTable!
	return if not playerTable or (SERVER and @GameData.Vented[playerTable]) or (CLIENT and @GameData.Vented)

	for _, ent in ipairs entities
		continue if ent == ply
		continue if SERVER and not ply\TestPVS ent

		otherPlayerTable = @GameData.Lookup_PlayerByEntity[ent]

		isKillable = otherPlayerTable and ent\IsPlayer! and not ent\IsDormant! and @GameData.Imposters[playerTable] and
			not @GameData.Imposters[otherPlayerTable] and not @GameData.DeadPlayers[otherPlayerTable]

		isUsable = not isKillable and not ent\IsPlayer!
		isHightlightable = isUsable and @ShouldHighlightEntity ent
		-- Skip checking if we found at least one highlightable entity.
		continue if #highlightable > 0 and not isHightlightable

		-- No point entities. No view models.
		continue if not ent\GetModel! or ent\GetModelRadius! == 0

		-- Don't match triggers.
		continue if string.match ent\GetClass!, "^trigger_"

		-- Task buttons.
		if ent\GetClass! == "func_task_button" or ent\GetClass! == "prop_task_button"
			name = ent\GetTaskName!

			-- Quite simply just bail out if the player is an imposter.
			continue if @GameData.Imposters[playerTable]

			if SERVER
				-- Bail out if the player doesn't have this task, or if it's not the current button,
				-- or if the button doesn't consent.
				continue if not (@GameData.Tasks[playerTable] and @GameData.Tasks[playerTable][name]) or
					ent ~= @GameData.Tasks[playerTable][name]\GetActivationButton! or
					not @GameData.Tasks[playerTable][name]\CanUse!

			if CLIENT
				-- Bail out if the local player doesn't have this task, or if he's completed it already, or
				-- if the button doesn't consent.
				continue if not @GameData.MyTasks[name] or
					@GameData.MyTasks[name]\GetCompleted! or ent ~= @GameData.MyTasks[name]\GetActivationButton! or
					not @GameData.MyTasks[name]\CanUse!

		-- Prevent dead players from being able to target corpses.
		continue if ent\GetClass! == "prop_ragdoll" and @GameData.DeadPlayers[playerTable]

		-- Prevent regular players from using vents.
		continue if (ent\GetClass! == "func_vent" or ent\GetClass! == "prop_vent") and not @GameData.Imposters[playerTable]

		-- Only highlight sabotage buttons when they're active, and the player isn't dead.
		if (ent\GetClass! == "func_sabotage_button" or ent\GetClass! == "prop_sabotage_button")
			continue if @GameData.DeadPlayers[ply] or not @GameData.SabotageButtons[ent]

		-- Only highlight doors when requested by sabotages.
		if (ent\GetClass! == "func_door" or ent\GetClass! == "func_door_rotating")
			continue if @GameData.DeadPlayers[ply] or not @GameData.SabotageButtons[ent]

		-- Only hightlight meeting buttons when the cooldown has passed.
		if (ent\GetClass! == "func_meeting_button" or ent\GetClass! == "prop_meeting_button")
			continue if @IsMeetingDisabled!
			continue if 0 >= ply\GetNW2Int "NMW AU Meetings"

			time = GetGlobalFloat("NMW AU NextMeeting") - CurTime!

			continue if time > 0

		if isKillable
			table.insert killable, ent

		elseif isUsable
			nearestPoint = ent\NearestPoint startPos
			if nearestPoint\Distance(ply\GetPos!) <= @BaseUseRadius
				table.insert isHightlightable and highlightable or usable, ent

	lookPos = ply\EyePos! + ply\GetAimVector! * 32

	-- Prioritize highlightable entities.
	usable = #highlightable > 0 and highlightable or usable

	GAMEMODE.Util.SortByDistance usable, lookPos
	GAMEMODE.Util.SortByDistance killable, lookPos

	return killable[#killable], usable[#usable]

--- Returns whether the game is progress.
-- @return You guessed it.
GM.IsGameInProgress = => GetGlobalBool "NMW AU GameInProgress"

--- Returns the time limit.
-- If there's no time limit, this will return -1.
-- @return You guessed it.
GM.GetTimeLimit = => GetGlobalInt "NMW AU TimeLimit"

--- Returns whether the communications are disabled (sabotaged).
-- @return You guessed it.
GM.GetCommunicationsDisabled = => GetGlobalInt "NMW AU CommsDisabled"

--- Returns whether calling the meeting button is impossible (sabotaged).
-- @return You guessed it.
GM.IsMeetingDisabled = => GetGlobalBool "NMW AU MeetingDisabled"

--- Returns whether calling the meeting is in progress.
-- @return You guessed it.
GM.IsMeetingInProgress = => GetGlobalBool "NMW AU MeetingInProgress"

--- Returns whether the game is commencing.
-- @return You guessed it.
GM.IsGameCommencing = => GetGlobalBool "NMW AU GameCommencing"

--- Returns whether the game flow is controlled by the server.
-- @return You guessed it.
GM.IsOnAutoPilot = => GetGlobalBool "NMW AU AutoPilot"

--- Returns a table of fully initialized players.
GM.GetFullyInitializedPlayers = => return for ply in *player.GetAll!
	if ply\IsBot! or ply\GetNW2Bool "NMW AU Initialized"
		ply
	else
		continue

--- Gets the imposter count based on the provided number.
GM.GetImposterCount = (_, count) -> math.floor(((count or _) - 1)/6) + 1

--- Tells the game mode that the entity should be highlighted as usable.
-- @param entity Entity to be highlighted.
-- @param highlight Should the entity be highlighted?
-- @param color Optional color. Defaults to white.
GM.SetUseHighlight = (entity, highlight = false, color = Color(255, 255, 255)) =>
	entity\SetNW2Bool "NMW AU UseHighlight", highlight
	if highlight
		entity\SetNW2Vector "NMW AU HighlightColor", color\ToVector!

--- Gets whether the entity should be highlighted.
-- @param entity Entity.
GM.ShouldHighlightEntity = (entity) =>
	return false unless IsValid entity
	return true if entity\GetNW2Bool "NMW AU UseHighlight"

	return true if switch string.match entity\GetClass!, "[^_]*_(.+)"
		when "task_button", "meeting_button", "vent", "sabotage_button"
			true

	return true if hook.Call "GMAU ShouldHighlight", nil, entity
	return true if @IsPlayerBody entity

	return false

--- Returns whether the entity is a player body.
-- @param entity Entity.
GM.IsPlayerBody = (entity) => 0 < entity\GetNW2Int "NMW AU PlayerID"

local logger
logger = {
	__log: (...) ->
		MsgC Color( 255, 69, 0 ), "[Among Us] ",
			CLIENT and Color(227, 220, 110) or Color(151, 218, 229),
			CLIENT and "[Client] " or "[Server] ",
			...
		MsgN!

	Info: (...) ->
		logger.__log Color(220, 220, 220), "[Info] ", Color(255, 255, 255), ...

	Warn: (...) ->
		logger.__log Color(255, 255, 0), "[Warn] ", Color(255, 255, 160), ...

	Error: (...) ->
		logger.__log Color(255, 0, 0), "[Err!] ", Color(255, 80, 80), ...
}

GM.Logger = logger
