local GlobalAddonName, E = ...

local GetSpecializationInfo = GetSpecializationInfo or C_SpecializationInfo.GetSpecializationInfo
local GetSpecialization = GetSpecialization or C_SpecializationInfo.GetSpecialization
local unit = "PLAYER"
----------------------------------------------------------------
local function Collect_Character_Info()
	----------------------------------------------------------------
	-- if not E:func_CanCollectData() then return end
	----------------------------------------------------------------
	local GUID = UnitGUID(unit) -- E.curGUID
	if not GUID then return end
	Octo_ToDo_DB_Levels[GUID] = Octo_ToDo_DB_Levels[GUID] or {}
	Octo_ToDo_DB_Levels[GUID].MASLENGO = Octo_ToDo_DB_Levels[GUID].MASLENGO or {}
	Octo_ToDo_DB_Levels[GUID].PlayerData = Octo_ToDo_DB_Levels[GUID].PlayerData or {}
	local collectMASLENGO = Octo_ToDo_DB_Levels[GUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[GUID].PlayerData
	----------------------------------------------------------------
	collectPlayerData.GUID = GUID

	local gender = UnitSex(unit) or 2
	collectPlayerData.UnitSex = gender

	local specId, specName, _, specIcon, specRole, specPrimaryStat = GetSpecializationInfo(GetSpecialization())
	collectPlayerData.specId = E.func_Save(specId)
	collectPlayerData.specName = E.func_Save(specName)
	collectPlayerData.specIcon = E.func_Save(specIcon)
	collectPlayerData.specRole = E.func_Save(specRole)
	collectPlayerData.specPrimaryStat = E.func_Save(specPrimaryStat)

	local RaceLocal, RaceEnglish, RaceID = UnitRace(unit)
	collectPlayerData.RaceLocal = E.func_Save(RaceLocal)
	collectPlayerData.RaceEnglish = E.func_Save(RaceEnglish)
	collectPlayerData.RaceID = E.func_Save(RaceID)

	local guildName, guildRankName, guildRankIndex = GetGuildInfo(unit)
	collectPlayerData.guildName = E.func_Save(guildName)
	collectPlayerData.guildRankName = E.func_Save(guildRankName)
	collectPlayerData.guildRankIndex = E.func_Save(guildRankIndex)

	collectPlayerData.Name = UnitFullName(unit) -- E.curCharName
	collectPlayerData.curServer = E.func_GetPlayerRealm() -- GetRealmName()
	collectPlayerData.curServerShort = E.func_GetRealmShortName(GetRealmName()) -- E.curServerShort

	local className, classFilename, classId = UnitClass(unit)
	collectPlayerData.className = className
	collectPlayerData.classFilename = classFilename
	collectPlayerData.classId = classId

	local FACTION_CURRENT = UnitFactionGroup(unit)
	collectPlayerData.Faction = FACTION_CURRENT -- E.FACTION_CURRENT

	local classColor = RAID_CLASS_COLORS[classFilename] and RAID_CLASS_COLORS[classFilename].colorStr:sub(3) or "ffffff"
	collectPlayerData.classColor = classColor -- E.classColor

	local classColorHexCurrent = C_ClassColor.GetClassColor(E.classFilename):GenerateHexColorMarkup()
	collectPlayerData.classColorHex = classColorHexCurrent -- E.classColorHexCurrent

	local CurrentRegion = GetCurrentRegion()
	collectPlayerData.CurrentRegion = E.func_Save(CurrentRegion)

	collectPlayerData.CurrentRegionName = E.func_Save(E.func_GetCurrentRegionName())
	collectPlayerData.BattleTag = E.func_Save(E.BattleTag)
	collectPlayerData.BattleTagLocal = E.func_Save(E.BattleTagLocal)
	collectPlayerData.buildVersion = E.func_Save(E.buildVersion)
	collectPlayerData.buildNumber = E.func_Save(E.buildNumber)
	collectPlayerData.buildDate = E.func_Save(E.buildDate)
	collectPlayerData.interfaceVersion = E.func_Save(E.interfaceVersion)
	collectPlayerData.currentTier = E.func_Save(E.currentTier)
	collectPlayerData.LuaVersion = E.func_Save(_VERSION)

	collectPlayerData.IsPublicBuild = E.func_Save(E.IsPublicBuild)
	collectPlayerData.GetRestrictedAccountData_rLevel = E.func_Save(E.GetRestrictedAccountData_rLevel)
	collectPlayerData.GetRestrictedAccountData_rMoney = E.func_Save(E.GetRestrictedAccountData_rMoney)
	collectPlayerData.IsAccountSecured = E.func_Save(E.IsAccountSecured)
	collectPlayerData.IsRestrictedAccount = E.func_Save(E.IsRestrictedAccount)
	collectPlayerData.IsTrialAccount = E.func_Save(E.IsTrialAccount)
	collectPlayerData.IsVeteranTrialAccount = E.func_Save(E.IsVeteranTrialAccount)

	collectPlayerData.MythicPlus_seasonID = E.func_Save(C_MythicPlus.GetCurrentSeason()) -- E.MythicPlus_seasonID


	collectPlayerData.CharDBVersion = tonumber(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"):match("v(%d+%.%d+)"))



	-- local sec = math.floor(GetPVPTimer()/1000)
	-- local msg = (not UnitIsPVP(unit)) and "Вы не отмечены для участия в PVP-боях." or
	--             (sec==301 and "Вы навсегда отмечены как потенциальный участник PVP-боя." or
	--              "Ваш PVP-флаг исчезает через "..(sec>60 and math.floor(sec/60).." minutes " or "")..(sec%60).." seconds")
	-- DEFAULT_CHAT_FRAME:AddMessage(msg)
	----------------------------------------------------------------
	local desired = GetPVPDesired() -- Returns true if the player has enabled their PvP flag.
	collectPlayerData.PVP_desired = E.func_Save(desired)
	----------------------------------------------------------------
	local statRules = GetPVPGearStatRules() -- true/false
	collectPlayerData.PVP_statRules = E.func_Save(statRules)
	----------------------------------------------------------------
	local lifetimeHonorableKills, lifetimeMaxPVPRank = GetPVPLifetimeStats() -- Returns the character's lifetime PvP statistics.
	collectPlayerData.PVP_lifetimeHonorableKills = E.func_Save(lifetimeHonorableKills)
	collectPlayerData.PVP_lifetimeMaxPVPRank = E.func_Save(lifetimeMaxPVPRank)
	----------------------------------------------------------------
	local powerDamage = GetPvpPowerDamage() -- Percentage increase in damage dealt to players in their pets due to PvP Power, e.g. 4.2 for 4.2%.
	collectPlayerData.PVP_powerDamage = E.func_Save(powerDamage)
	----------------------------------------------------------------
	local powerHealing = GetPvpPowerHealing() -- Percentage increase in Healing Power (in outdoor and PvP zones) due to PvP Power, e.g. 4.2 for 4.2%.
	collectPlayerData.PVP_powerHealing = E.func_Save(powerHealing)
	----------------------------------------------------------------
	local Session_honorableKills, Session_dishonorableKills = GetPVPSessionStats() -- Returns the character's Honor statistics for this session.
	collectPlayerData.PVP_Session_honorableKills = E.func_Save(Session_honorableKills)
	collectPlayerData.PVP_Session_dishonorableKills = E.func_Save(Session_dishonorableKills)
	----------------------------------------------------------------
	local timer = GetPVPTimer() -- Returns the time left in milliseconds until the player is unflagged for PvP.
	collectPlayerData.PVP_timer = E.func_Save(timer)
	----------------------------------------------------------------
	local Yesterday_honorableKills, Yesterday_dishonorableKills = GetPVPYesterdayStats() -- Returns the character's Honor statistics for yesterday.
	collectPlayerData.PVP_Yesterday_honorableKills = E.func_Save(Yesterday_honorableKills)
	collectPlayerData.PVP_Yesterday_dishonorableKills = E.func_Save(Yesterday_dishonorableKills)
	----------------------------------------------------------------
end
----------------------------------------------------------------
function E.Collect_Character_Info()
	E.func_SpamBlock(Collect_Character_Info, false)
end