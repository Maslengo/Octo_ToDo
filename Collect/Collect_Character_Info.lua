local GlobalAddonName, E = ...

local GetSpecializationInfo = GetSpecializationInfo or C_SpecializationInfo.GetSpecializationInfo
local GetSpecialization = GetSpecialization or C_SpecializationInfo.GetSpecialization
local unit = "PLAYER"
----------------------------------------------------------------
local function Collect_Character_Info()
	----------------------------------------------------------------
	if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	-- if not E.func_CanCollectData() then return end
	----------------------------------------------------------------
	E.pd.GUID = E.curGUID

	local UnitSex = UnitSex(unit) or C_PlayerInfo and C_PlayerInfo.GetSex(PlayerLocation:CreateFromUnit(unit)) or 2
	E.pd.UnitSex = UnitSex

	local specId, specName, _, specIcon, specRole, specPrimaryStat = GetSpecializationInfo(GetSpecialization())
	E.pd.specId = E.func_Save(specId)
	E.pd.specName = E.func_Save(specName)
	E.pd.specIcon = E.func_Save(specIcon)
	E.pd.specRole = E.func_Save(specRole)
	E.pd.specPrimaryStat = E.func_Save(specPrimaryStat)

	local _, RaceEnglish, RaceID = UnitRace(unit)
	E.pd.RaceEnglish = E.func_Save(RaceEnglish)
	E.pd.RaceID = E.func_Save(RaceID)

	local guildName, guildRankName, guildRankIndex = GetGuildInfo(unit)
	E.pd.guildName = E.func_Save(guildName)
	E.pd.guildRankName = E.func_Save(guildRankName)
	E.pd.guildRankIndex = E.func_Save(guildRankIndex)

	E.pd.Name = UnitFullName(unit) -- E.curCharName
	E.pd.curServer = E.func_GetPlayerRealm() -- GetRealmName()
	E.pd.curServerShort = E.func_GetRealmShortName(GetRealmName()) -- E.curServerShort

	local className, classFilename, classId = UnitClass(unit)
	E.pd.className = className
	E.pd.classFilename = classFilename
	E.pd.classId = classId


	local classColor = RAID_CLASS_COLORS[classFilename] and RAID_CLASS_COLORS[classFilename].colorStr:sub(3) or "ffffff"
	E.pd.classColor = classColor -- E.classColor

	local classColorHexCurrent = E.func_GetClassColor_HEX(E.classFilename)
	E.pd.classColorHex = classColorHexCurrent -- E.classColorHexCurrent

	local CurrentRegion = GetCurrentRegion()
	E.pd.CurrentRegion = E.func_Save(CurrentRegion)

	E.pd.BattleTag = E.func_Save(E.BattleTag)
	E.pd.buildVersion = E.func_Save(E.buildVersion)
	E.pd.buildNumber = E.func_Save(E.buildNumber)
	E.pd.buildDate = E.func_Save(E.buildDate)
	E.pd.interfaceVersion = E.func_Save(E.interfaceVersion)
	E.pd.LuaVersion = E.func_Save(_VERSION)



	E.pd.REGION_NAME = E.func_GetCurrentRegionName() -- E.CURRENT_REGION_NAME -- E.pd.REGION_NAME = E.func_Save(E.func_GetCurrentRegionName())
	E.pd.FACTION = E.FACTION_CURRENT -- E.pd.FACTION = UnitFactionGroup(unit)



	E.pd.IsPublicBuild = E.func_Save(E.IsPublicBuild)
	E.pd.GetRestrictedAccountData_rLevel = E.func_Save(E.GetRestrictedAccountData_rLevel)
	E.pd.GetRestrictedAccountData_rMoney = E.func_Save(E.GetRestrictedAccountData_rMoney)
	E.pd.IsAccountSecured = E.func_Save(E.IsAccountSecured)
	E.pd.IsRestrictedAccount = E.func_Save(E.IsRestrictedAccount)
	E.pd.IsTrialAccount = E.func_Save(E.IsTrialAccount)
	E.pd.IsVeteranTrialAccount = E.func_Save(E.IsVeteranTrialAccount)

	E.pd.MythicPlus_seasonID = E.func_Save(E.MythicPlus_seasonID)


	E.pd.CharDBVersion = tonumber(E.func_GetAddOnMetadata(GlobalAddonName, "Version"):match("v(%d+%.%d+)"))

	E.pd.IsXPUserDisabled = E.func_Save(IsXPUserDisabled())

	-- /dump E.func_SecondsToClock(E.func_GetSecondsUntilDailyReset())
	-- E.func_SecondsToClock(GetServerTime()+E.func_GetSecondsUntilWeeklyReset())



	-- local sec = math.floor(GetPVPTimer()/1000)
	-- local msg = (not UnitIsPVP(unit)) and "Вы не отмечены для участия в PVP-боях." or
	--             (sec==301 and "Вы навсегда отмечены как потенциальный участник PVP-боя." or
	--              "Ваш PVP-флаг исчезает через "..(sec>60 and math.floor(sec/60).." minutes " or "")..(sec%60).." seconds")
	-- DEFAULT_CHAT_FRAME:AddMessage(msg)
	----------------------------------------------------------------
	-- local desired = GetPVPDesired() -- Returns true if the player has enabled their PvP flag.
	-- E.pd.PVP_desired = E.func_Save(desired)
	-- ----------------------------------------------------------------
	-- local statRules = GetPVPGearStatRules() -- true/false
	-- E.pd.PVP_statRules = E.func_Save(statRules)
	-- ----------------------------------------------------------------
	-- local lifetimeHonorableKills, lifetimeMaxPVPRank = GetPVPLifetimeStats() -- Returns the character's lifetime PvP statistics.
	-- E.pd.PVP_lifetimeHonorableKills = E.func_Save(lifetimeHonorableKills)
	-- E.pd.PVP_lifetimeMaxPVPRank = E.func_Save(lifetimeMaxPVPRank)
	-- ----------------------------------------------------------------
	-- local powerDamage = GetPvpPowerDamage() -- Percentage increase in damage dealt to players in their pets due to PvP Power, e.g. 4.2 for 4.2%.
	-- E.pd.PVP_powerDamage = E.func_Save(powerDamage)
	-- ----------------------------------------------------------------
	-- local powerHealing = GetPvpPowerHealing() -- Percentage increase in Healing Power (in outdoor and PvP zones) due to PvP Power, e.g. 4.2 for 4.2%.
	-- E.pd.PVP_powerHealing = E.func_Save(powerHealing)
	-- ----------------------------------------------------------------
	-- local Session_honorableKills, Session_dishonorableKills = GetPVPSessionStats() -- Returns the character's Honor statistics for this session.
	-- E.pd.PVP_Session_honorableKills = E.func_Save(Session_honorableKills)
	-- E.pd.PVP_Session_dishonorableKills = E.func_Save(Session_dishonorableKills)
	-- ----------------------------------------------------------------
	-- local timer = GetPVPTimer() -- Returns the time left in milliseconds until the player is unflagged for PvP.
	-- E.pd.PVP_timer = E.func_Save(timer)
	-- ----------------------------------------------------------------
	-- local Yesterday_honorableKills, Yesterday_dishonorableKills = GetPVPYesterdayStats() -- Returns the character's Honor statistics for yesterday.
	-- E.pd.PVP_Yesterday_honorableKills = E.func_Save(Yesterday_honorableKills)
	-- E.pd.PVP_Yesterday_dishonorableKills = E.func_Save(Yesterday_dishonorableKills)
	----------------------------------------------------------------
end
----------------------------------------------------------------
function E.Collect_Character_Info()
	E.func_SpamBlock(Collect_Character_Info, false)
end
----------------------------------------------------------------