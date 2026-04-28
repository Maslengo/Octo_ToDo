local GlobalAddonName, E = ...
local addonNAME = E.func_AddonNameForOptions(GlobalAddonName)
----------------------------------------------------------------
local function compareVersion(v1, v2)
	if v2 == 1 or v2 == 0 then return false end
	return v1 > (v2 or 0)
end
----------------------------------------------------------------
local function updateChars(pd, cm, DBVersion)
	----------------------------------------------------------------
	if compareVersion(96.7, DBVersion) then
		cm.currencyID = nil
		cm.CurrencyID_Total = nil
		cm.CurrencyID_totalEarned = nil
	end
	----------------------------------------------------------------
	if compareVersion(108.0, DBVersion) then
		if cm.GreatVault then
			wipe(cm.GreatVault)
		end
		cm.GreatVault = {}
		if Enum and Enum.WeeklyRewardChestThresholdType then
			for name, i in next, Enum.WeeklyRewardChestThresholdType do
				cm.GreatVault[i] = cm.GreatVault[i] or {}
			end
		end
	end
	----------------------------------------------------------------
	if compareVersion(108.5, DBVersion) then
		cm.Items = cm.Items or {}
		cm.Items.Bags = cm.Items.Bags or {}
		if cm.ItemsInBag then
			for itemID, count in next, (cm.ItemsInBag) do
				cm.Items.Bags[itemID] = count
			end
			cm.ItemsInBag = nil
		end
		if pd.usedSlots then
			pd.usedSlots_BAGS = pd.usedSlots
			pd.usedSlots = nil
		end
		if pd.totalSlots then
			pd.totalSlots_BAGS = pd.totalSlots
			pd.totalSlots = nil
		end
	end
	----------------------------------------------------------------
	-- /run opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.Reputation)
	if compareVersion(108.8, DBVersion) then
		if cm.Reputation then
			for reputationID, v in next, (cm.Reputation) do
				if type(v) == "table" then
					cm.Reputation[reputationID] = nil
				else
					local fir, sec, result, col, standingTEXT = ("#"):split(v)
					local FIRST = tonumber(fir or 0)
					local SECOND = tonumber(sec or 0)
					local color = col or E.COLOR_GRAY
					if SECOND ~= 0 then
						cm.Reputation[reputationID] = FIRST.."#"..SECOND.."##"..color.."#Login required#0"
					else
						cm.Reputation[reputationID] = nil
					end
				end
			end
		end
	end
	----------------------------------------------------------------
	-- /run opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.Reputation)
	if compareVersion(109.3, DBVersion) then
		if cm.Items then
			pd.usedSlots_BANK = nil
			pd.totalSlots_BANK = nil
			if cm.Items.Bank then
				wipe(cm.Items.Bank)
			end
			if cm.Items.AccountBank then
				cm.Items.AccountBank = nil
			end
		end
	end
	----------------------------------------------------------------
	if compareVersion(110.4, DBVersion) then
		if cm.journalInstance then
			wipe(cm.journalInstance)
		end
		if cm.SavedWorldBoss then
			wipe(cm.SavedWorldBoss)
		end
		if cm.LFGInstance then
			wipe(cm.LFGInstance)
		end
	end
	----------------------------------------------------------------
	if compareVersion(110.6, DBVersion) then
		if pd.InventoryType then
			cm.InventoryType = E.func_CopyTableDeep(pd.InventoryType)
			for k in next,(pd.InventoryType) do
				pd.InventoryType[k] = nil
			end
			pd.InventoryType = nil
		end
		if cm.CovenantAndAnima then
			local curCov = cm.CovenantAndAnima.curCovID
			pd.SL_covenantID = E.func_Save(curCov)
			-- https://warcraft.wiki.gg/wiki/API_C_Covenants.GetActiveCovenantID
			for covenantID = 1, 4 do
				local data = cm.CovenantAndAnima[covenantID]
				if data then
					local prefix = E.OctoTable_Covenant[covenantID].prefix
					pd[prefix .. "_Anima"]  = E.func_Save(data[2])
					pd[prefix .. "_Renown"] = E.func_Save(data[1])
				end
			end
			cm.CovenantAndAnima = nil
		end
		if pd.Possible_Anima then
			pd.SL_Possible_Anima = pd.Possible_Anima
			pd.Possible_Anima = nil
		end
		if pd.Possible_CatalogedResearch then
			pd.SL_Possible_CatalogedResearch = pd.Possible_CatalogedResearch
			pd.Possible_CatalogedResearch = nil
		end
		if pd.RIO_Score then
			pd.MythicPlus = pd.MythicPlus or {}
			pd.MythicPlus[E.MythicPlus_seasonID] = pd.MythicPlus[E.MythicPlus_seasonID] or {}
			pd.MythicPlus[E.MythicPlus_seasonID].RIO_Score = pd.RIO_Score
			pd.RIO_Score = nil
		end
		if pd.RIO_weeklyBest then
			pd.MythicPlus = pd.MythicPlus or {}
			pd.MythicPlus[E.MythicPlus_seasonID] = pd.MythicPlus[E.MythicPlus_seasonID] or {}
			pd.MythicPlus[E.MythicPlus_seasonID].RIO_weeklyBest = pd.RIO_weeklyBest
			pd.RIO_weeklyBest = nil
		end
		if pd.CurrentKeyLevel then
			pd.OwnedKeystoneLevel = pd.CurrentKeyLevel
			pd.CurrentKeyLevel = nil
		end
		if cm.Reputation then
			for reputationID, v in next, (cm.Reputation) do
				if type(v) == "string" then
					local FIRST, SECOND, ParagonCount, color, standingTEXT, repType = ("#"):split(v)
					cm.Reputation[reputationID] = {
						FIRST = tonumber(FIRST),
						SECOND = tonumber(SECOND),
						ParagonCount = tonumber(ParagonCount),
						color = color,
						standingTEXT = standingTEXT,
						repType = tonumber(repType)
					}
				end
			end
		end
	end
	----------------------------------------------------------------
	if compareVersion(111.6, DBVersion) then
		if cm.LegionRemixData then
			wipe(cm.LegionRemixData)
		end
	end
	----------------------------------------------------------------
	if compareVersion(112.2, DBVersion) then
		if cm.GreatVault then
			wipe(cm.GreatVault)
		end
		if pd.MythicPlus then
			wipe(pd.MythicPlus)
		end
		pd.HasAvailableRewards = nil
	end
	----------------------------------------------------------------
	if compareVersion(114.1, DBVersion) then
		pd.professions = pd.professions or {}
		if cm.professions then
			for i = 1, 5 do
				local skillLine = cm.professions[i] and cm.professions[i].skillLine
				if skillLine then
					pd.professions[skillLine] = true
				end
			end
		end
	end
	----------------------------------------------------------------
	if compareVersion(114.3, DBVersion) then
		if pd.isShownPlayer ~= nil then
			pd.CONFIG_SHOW_PLAYER = pd.isShownPlayer
			pd.isShownPlayer = nil
		end
	end
	----------------------------------------------------------------
	if compareVersion(114.9, DBVersion) then
		if cm.bossDifficulties then
			cm.GreatVaultbossDifficulties = cm.bossDifficulties
		end
		cm.bossDifficulties = nil
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
local function updateGlobal(DBVersion)
	----------------------------------------------------------------
	if compareVersion(108.0, DBVersion) then
		Octo_profileKeys = {}
		E.func_CreateNew_profileKeys("Default")
	end
	----------------------------------------------------------------
	if compareVersion(108.5, DBVersion) then
		Octo_ToDo_DB_Vars.CONFIG_SPAM_TIME = 2
	end
	----------------------------------------------------------------
	if compareVersion(112.2, DBVersion) then
		if Octo_profileKeys and Octo_profileKeys.profiles and Octo_profileKeys.profiles.Default then
			wipe(Octo_profileKeys.profiles.Default)
			E.func_CreateNew_profileKeys(E.TEXT_DEFAULT)
			E.func_PrintMessage(addonNAME, "reset profile:", L["DEFAULT"])
		end
	end
	----------------------------------------------------------------
	if compareVersion(114.2, DBVersion) then
		if Octo_ToDo_DB_Vars.SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER ~= nil then
			Octo_ToDo_DB_Vars.CONFIG_SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER = Octo_ToDo_DB_Vars.SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER
		end
	end
	----------------------------------------------------------------
	if compareVersion(114.3, DBVersion) then
		if Octo_ToDo_DB_Vars.Config_LevelToShow ~= nil then
			Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MIN = Octo_ToDo_DB_Vars.Config_LevelToShow
			Octo_ToDo_DB_Vars.Config_LevelToShow = nil
		end

		if Octo_ToDo_DB_Vars.Config_LevelToShowMAX ~= nil then
			Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MAX = Octo_ToDo_DB_Vars.Config_LevelToShowMAX
			Octo_ToDo_DB_Vars.Config_LevelToShowMAX = nil
		end
		if Octo_ToDo_DB_Vars.isOnlyCurrentBtag ~= nil then
			Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = Octo_ToDo_DB_Vars.isOnlyCurrentBtag
			Octo_ToDo_DB_Vars.isOnlyCurrentBtag = nil
		end
		if Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion ~= nil then
			Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_REGION = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
			Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion = nil
		end
		if Octo_ToDo_DB_Vars.isOnlyCurrentServer ~= nil then
			Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_SERVER = Octo_ToDo_DB_Vars.isOnlyCurrentServer
			Octo_ToDo_DB_Vars.isOnlyCurrentServer = nil
		end
		if Octo_ToDo_DB_Vars.isOnlyCurrentFaction ~= nil then
			Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_FACTION = Octo_ToDo_DB_Vars.isOnlyCurrentFaction
			Octo_ToDo_DB_Vars.isOnlyCurrentFaction = nil
		end

	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
function E.func_setOldChanges()
	local currentVersion = tonumber(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"):match("v(%d+%.%d+)")) -- lastAddonVersion
	-- E.DEBUG_START()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels or {}) do
		local pd = CharInfo and CharInfo.PlayerData
		local cm = CharInfo and CharInfo.MASLENGO
		if pd and cm then
			local DBVersion = pd.CharDBVersion
			updateChars(pd, cm, DBVersion)
			pd.CharDBVersion = currentVersion
		end
	end
	-- E.DEBUG_STOP("E.func_setOldChanges")
	Octo_ToDo_DB_Vars = Octo_ToDo_DB_Vars or {}
	local oldGlobalVersion = Octo_ToDo_DB_Vars.GlobalDBVersion or 1
	local interfaceVersionForReset = Octo_Cache_DB and Octo_Cache_DB.interfaceVersionForReset or 1
	updateGlobal(oldGlobalVersion)
	if currentVersion ~= oldGlobalVersion or interfaceVersionForReset ~= E.interfaceVersion then
	-- if currentVersion ~= oldGlobalVersion then
		Octo_Cache_DB = nil
		E.Init_Octo_Cache_DB()
		E.func_BUILD_DUNG_DB()
		Octo_Cache_DB.interfaceVersionForReset = E.interfaceVersion
	end
	Octo_ToDo_DB_Vars.GlobalDBVersion = currentVersion
end
----------------------------------------------------------------