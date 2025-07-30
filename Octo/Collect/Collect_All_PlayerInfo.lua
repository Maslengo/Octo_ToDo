local GlobalAddonName, E = ...

function E.Collect_All_PlayerInfo()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local curServerShort = E:func_CurServerShort(E.curServer)
		local specId, specName, _, specIcon = GetSpecializationInfo(GetSpecialization())
		local RaceLocal, RaceEnglish, raceID = UnitRace("PLAYER")
		local guildName, guildRankName, guildRankIndex = GetGuildInfo("PLAYER")
		----
		collectPlayerData.curServerShort = curServerShort
		collectPlayerData.Name = E.curCharName
		collectPlayerData.curServer = E.curServer
		collectPlayerData.className = E.className
		collectPlayerData.classFilename = E.classFilename
		collectPlayerData.classId = E.classId
		collectPlayerData.GUID = E.curGUID
		collectPlayerData.Faction = E.curFaction
		collectPlayerData.specId = specId
		collectPlayerData.specName = specName
		collectPlayerData.specIcon = specIcon
		collectPlayerData.classColor = E.classColor
		collectPlayerData.RaceLocal = RaceLocal
		collectPlayerData.RaceEnglish = RaceEnglish
		collectPlayerData.raceID = raceID
		collectPlayerData.classColorHex = E.classColorHexCurrent
		collectPlayerData.CurrentRegion = E:func_GetCurrentRegion()
		collectPlayerData.CurrentRegionName = E:func_GetCurrentRegionName()
		collectPlayerData.guildName = guildName
		collectPlayerData.guildRankName = guildRankName
		if guildRankIndex and guildRankIndex ~= 0 then
			collectPlayerData.guildRankIndex = guildRankIndex
		end
		collectPlayerData.BattleTag = E.BattleTag
		collectPlayerData.BattleTagLocal = E.BattleTagLocal
		collectPlayerData.buildVersion = E.buildVersion
		collectPlayerData.buildNumber = E.buildNumber
		collectPlayerData.buildDate = E.buildDate
		collectPlayerData.interfaceVersion = E.interfaceVersion
		collectPlayerData.currentTier = E.currentTier
		collectPlayerData.LuaVersion =  _VERSION
		if E.IsPublicBuild then
			collectPlayerData.IsPublicBuild = E.IsPublicBuild
		else
			collectPlayerData.IsPublicBuild = nil
		end
		if E.GetRestrictedAccountData_rLevel and E.GetRestrictedAccountData_rLevel ~= 0 then
			collectPlayerData.GetRestrictedAccountData_rLevel = E.GetRestrictedAccountData_rLevel
		else
			collectPlayerData.GetRestrictedAccountData_rLevel = nil
		end
		if E.GetRestrictedAccountData_rMoney and E.GetRestrictedAccountData_rMoney ~= 0 then
			collectPlayerData.GetRestrictedAccountData_rMoney = E.GetRestrictedAccountData_rMoney
		else
			collectPlayerData.GetRestrictedAccountData_rMoney = nil
		end
		if E.IsAccountSecured then
			collectPlayerData.IsAccountSecured = E.IsAccountSecured
		else
			collectPlayerData.IsAccountSecured = nil
		end
		if E.IsRestrictedAccount then
			collectPlayerData.IsRestrictedAccount = E.IsRestrictedAccount
		else
			collectPlayerData.IsRestrictedAccount = nil
		end
		if E.IsTrialAccount then
			collectPlayerData.IsTrialAccount = E.IsTrialAccount
		else
			collectPlayerData.IsTrialAccount = nil
		end
		if E.IsVeteranTrialAccount then
			collectPlayerData.IsVeteranTrialAccount = E.IsVeteranTrialAccount
		else
			collectPlayerData.IsVeteranTrialAccount = nil
		end
		collectPlayerData.DBVersion = tonumber(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"):match("v(%d+%.%d+)")) -- lastAddonVersion
	end
end