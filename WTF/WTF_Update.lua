local GlobalAddonName, E = ...
local L = E.L
local addonNAME = E.func_AddonNameForOptions(GlobalAddonName)
----------------------------------------------------------------
local function compareVersion(v1, v2)
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
	-- /run opde(E.cm.Reputation)
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
	-- /run opde(E.cm.Reputation)
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
	if compareVersion(115.3, DBVersion) then
		pd.HasAvailableRewards = nil
	end
	----------------------------------------------------------------
	if compareVersion(115.4, DBVersion) then
		if pd.azeriteLVL ~= nil then
			pd.azerite_lvl = pd.azeriteLVL
			pd.azeriteLVL = nil
		end
		if pd.azeriteEXP then
			pd.azeriteEXP = nil
		end
		if cm.ListOfParagonQuests then
			for questID, v in next, (cm.ListOfParagonQuests) do
				if v ~= nil and type(v) == "string" then
					cm.ListOfParagonQuests[questID] = true
				end
			end
		end
		-- ПОФИКСИТь
		if pd.CurrentRegionName then
			pd.REGION_NAME = pd.CurrentRegionName
			pd.CurrentRegionName = nil
		elseif not pd.REGION_NAME then
			pd.REGION_NAME = "US" -- E.CURRENT_REGION_NAME
		end
		if pd.Faction then
			pd.FACTION = pd.Faction
			pd.Faction = nil
		elseif not pd.FACTION then
			pd.FACTION = "Horde" -- E.FACTION_CURRENT
		end
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
local function updateGlobal(DBVersion)
	----------------------------------------------------------------
	if compareVersion(114.2, DBVersion) then
		if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER ~= nil then
			Octo_ToDo_DB_Vars.CONFIG_SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER = Octo_ToDo_DB_Vars.SHOW_FRAME_ON_MINIMAP_BUTTON_HOVER
		end
	end
	----------------------------------------------------------------
	if compareVersion(114.3, DBVersion) then
		if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.Config_LevelToShow ~= nil then
			Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MIN = Octo_ToDo_DB_Vars.Config_LevelToShow
			Octo_ToDo_DB_Vars.Config_LevelToShow = nil
		end
		if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.Config_LevelToShowMAX ~= nil then
			Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MAX = Octo_ToDo_DB_Vars.Config_LevelToShowMAX
			Octo_ToDo_DB_Vars.Config_LevelToShowMAX = nil
		end
		if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.isOnlyCurrentBtag ~= nil then
			Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = Octo_ToDo_DB_Vars.isOnlyCurrentBtag
			Octo_ToDo_DB_Vars.isOnlyCurrentBtag = nil
		end
		if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion ~= nil then
			Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_REGION = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
			Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion = nil
		end
		if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.isOnlyCurrentServer ~= nil then
			Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_SERVER = Octo_ToDo_DB_Vars.isOnlyCurrentServer
			Octo_ToDo_DB_Vars.isOnlyCurrentServer = nil
		end
		if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.isOnlyCurrentFaction ~= nil then
			Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_FACTION = Octo_ToDo_DB_Vars.isOnlyCurrentFaction
			Octo_ToDo_DB_Vars.isOnlyCurrentFaction = nil
		end
	end
	----------------------------------------------------------------
	if compareVersion(115.4, DBVersion) then
		if Octo_ToDo_DB_Options and Octo_ToDo_DB_Options.sort_reverse then
			if Octo_ToDo_DB_Options.sort_reverse.UnitLevel == false then
				Octo_ToDo_DB_Options.sort_reverse.UnitLevel = true
			end
			if Octo_ToDo_DB_Options.sort_reverse.avgItemLevelEquipped == false then
				Octo_ToDo_DB_Options.sort_reverse.avgItemLevelEquipped = true
			end
		end
		-- 1. Инициализация структуры профилей
		if not Octo_Todo_DB_Profiles then
			E.init_Octo_Todo_DB_Profiles()
		else
			-- перенос старых профилей цветов и ключей (если были)
			if Octo_profileColors then
				if Octo_profileColors.Current_profile then
					Octo_Todo_DB_Profiles.SETTINGS.CURRENT = Octo_profileColors.Current_profile
					-- Octo_profileColors.Current_profile = nil
				end
				if Octo_profileColors.profiles then
					for profile_name, profile_data in next, (Octo_profileColors.profiles) do
						Octo_Todo_DB_Profiles.SETTINGS.profiles[profile_name] = profile_data
						if Octo_profileColors.profiles[profile_name].ConfigColor_CharLinesUseFaction_CONFIG == true then
							Octo_Todo_DB_Profiles.SETTINGS.profiles[profile_name].ConfigColor_CharLines_TYPE = 1
						end
						if Octo_profileColors.profiles[profile_name].ConfigColor_CharHeaderUseFaction_CONFIG == true then
							Octo_Todo_DB_Profiles.SETTINGS.profiles[profile_name].ConfigColor_CharHeader_TYPE = 1
						end
						if Octo_profileColors.profiles[profile_name].ConfigColor_HighlightUseFaction_CONFIG == true then
							Octo_Todo_DB_Profiles.SETTINGS.profiles[profile_name].ConfigColor_Highlight_TYPE = 1
						end
						if Octo_profileColors.profiles[profile_name].ConfigColor_CharLines_UseClass_CONFIG == true then
							Octo_Todo_DB_Profiles.SETTINGS.profiles[profile_name].ConfigColor_CharLines_TYPE = 2
						end
						if Octo_profileColors.profiles[profile_name].ConfigColor_CharHeader_UseClass_CONFIG == true then
							Octo_Todo_DB_Profiles.SETTINGS.profiles[profile_name].ConfigColor_CharHeader_TYPE = 2
						end
						if Octo_profileColors.profiles[profile_name].ConfigColor_Highlight_UseClass_CONFIG == true then
							Octo_Todo_DB_Profiles.SETTINGS.profiles[profile_name].ConfigColor_Highlight_TYPE = 2
						end
					end
					-- Octo_profileColors.profiles = nil
				end
			end
			if Octo_profileKeys then
				if Octo_profileKeys.Current_profile then
					Octo_Todo_DB_Profiles.KEYS.CURRENT = Octo_profileKeys.Current_profile
					Octo_profileKeys.Current_profile = nil
				end
				if Octo_profileKeys.profiles then
					for profile_name, profile_data in next, (Octo_profileKeys.profiles) do
						Octo_Todo_DB_Profiles.KEYS.profiles[profile_name] = profile_data
					end
					Octo_profileKeys.profiles = nil
				end
			end
			-- обновляем структуру (добавляем новые поля, если версия изменилась)
			E.init_Octo_Todo_DB_Profiles()
		end
		-- 2. Активируем глобальные переменные текущих профилей (E.CHARACTERS_CURRENT и т.д.)
		if E.func_UpdateGlobalNSforProfiles then
			E.func_UpdateGlobalNSforProfiles()
		end
		-- 3. Перенос CONFIG_SHOW_PLAYER → GUIDS в профиль Default
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			local pd = CharInfo.PlayerData
			if pd and pd.CONFIG_SHOW_PLAYER ~= nil then
				-- все старые настройки видимости переносим в профиль по умолчанию
				Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.TEXT_ENG_DEFAULT].GUIDS[GUID] = pd.CONFIG_SHOW_PLAYER
				pd.CONFIG_SHOW_PLAYER = nil
			end
		end
		-- 4. Перенос Octo_ToDo_DB_Options → OTHER активного профиля CHARACTERS
		if Octo_ToDo_DB_Options then
			local other = Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER
			if Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MIN ~= nil then
				Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_LEVEL_MIN = Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MIN
				Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MIN = nil
			end
			if Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MAX ~= nil then
				Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_LEVEL_MAX = Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MAX
				Octo_ToDo_DB_Options.CONFIG_SHOW_LEVEL_MAX = nil
			end
			if Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG ~= nil then
				Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG
				Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_BATTLETAG = nil
			end
			if Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_REGION ~= nil then
				Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_ONLY_CURRENT_REGION = Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_REGION
				Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_REGION = nil
			end
			if Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_SERVER ~= nil then
				Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_ONLY_CURRENT_SERVER = Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_SERVER
				Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_SERVER = nil
			end
			if Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_FACTION ~= nil then
				Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_ONLY_CURRENT_FACTION = Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_FACTION
				Octo_ToDo_DB_Options.CONFIG_SHOW_ONLY_CURRENT_FACTION = nil
			end
			if Octo_ToDo_DB_Options.CONFIG_SHOW_ALWAYS_AS_FIRST ~= nil then
				Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SHOW_ALWAYS_AS_FIRST = Octo_ToDo_DB_Options.CONFIG_SHOW_ALWAYS_AS_FIRST
				Octo_ToDo_DB_Options.CONFIG_SHOW_ALWAYS_AS_FIRST = nil
			end
			if Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM ~= nil then
				Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].OTHER.CONFIG_SORTING_CUSTOM = Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM
				Octo_ToDo_DB_Options.CONFIG_SORTING_CUSTOM = nil
			end
		end
		-- 5. Перенос старых данных сортировки из Octo_ToDo_DB_Options в SORTING профиля Default
		if Octo_ToDo_DB_Options then
			local defaultProfile = Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.TEXT_ENG_DEFAULT]
			if defaultProfile then
				defaultProfile.SORTING = defaultProfile.SORTING or {}
				local sorting = defaultProfile.SORTING
				if Octo_ToDo_DB_Options.sort_order then
					sorting.sort_order = Octo_ToDo_DB_Options.sort_order
					Octo_ToDo_DB_Options.sort_order = nil
				end
				if Octo_ToDo_DB_Options.sort_reverse then
					sorting.sort_reverse = Octo_ToDo_DB_Options.sort_reverse
					Octo_ToDo_DB_Options.sort_reverse = nil
				end
				if Octo_ToDo_DB_Options.sort_order_ACTIVED then
					sorting.sort_order_ACTIVED = Octo_ToDo_DB_Options.sort_order_ACTIVED
					Octo_ToDo_DB_Options.sort_order_ACTIVED = nil
				end
				if Octo_ToDo_DB_Options.GUID_order then
					sorting.GUID_order = Octo_ToDo_DB_Options.GUID_order
					Octo_ToDo_DB_Options.GUID_order = nil
				end
			end
		end
		if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.FontOption then
			for region, v in next, (Octo_ToDo_DB_Vars.FontOption) do
				if v and v.Config_FontStyle == "|cffd177ffE|r|cffcb7afdx|r|cffc47cfbp|r|cffbe7ffar|r|cffb782f8e|r|cffb184f6s|r|cffaa87f4s|r|cffa48af2w|r|cff9d8cf0a|r|cff978fefy|r|cff9091ed |r|cff8a94ebR|r|cff8397e9g|r|cff7d99e7 |r|cff769ce5B|r|cff709fe4o|r|cff69a1e2l|r|cff63A4E0d|r" then
					v.Config_FontStyle = E.DefaultFont
				end
			end
			local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
			for k, v in next, (Octo_ToDo_DB_Vars) do
				settingsProfile[k] = v
			end
			E.func_CreateProfile("SETTINGS", E.TEXT_ENG_DEFAULT)
		end
	end
	-- opde(Octo_Todo_DB_Profiles.CHARACTERS)
	if compareVersion(115.7, DBVersion) then
		local allProfiles = Octo_Todo_DB_Profiles and Octo_Todo_DB_Profiles.SETTINGS and Octo_Todo_DB_Profiles.SETTINGS.profiles
		if allProfiles then
			for profileName, profileData in next, (allProfiles) do
				if profileData and profileData.FontOption then
					for lang, langData in next, profileData.FontOption do
						if type(langData) == "table" then
							for configKey, configValue in next, (langData) do
								profileData[configKey] = configValue
							end
						end
					end
					profileData.FontOption = nil
				end
			end
		end
		if Octo_ToDo_DBVersion and Octo_ToDo_DBVersion.FramePosition then
			Octo_ToDo_DB_Variables.FramePosition = Octo_ToDo_DBVersion.FramePosition
		end

	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
function E.func_setOldChanges()
	-- E.DEBUG_START()
	Octo_ToDo_DB_Options = Octo_ToDo_DB_Options or {}
	Octo_Cache_DB = Octo_Cache_DB or {}
	local interfaceVersionForReset = Octo_Cache_DB and Octo_Cache_DB.interfaceVersionForReset or 1
	Octo_ToDo_DB_Variables = Octo_ToDo_DB_Variables or {}
	Octo_ToDo_DB_Variables.dbv = Octo_ToDo_DB_Variables.dbv or 1
	local oldGlobalVersion = Octo_ToDo_DB_Variables.dbv
	local currentVersion = tonumber(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"):match("v(%d+%.%d+)")) -- lastAddonVersion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		if pd and cm then
			local DBVersion = pd.CharDBVersion
			updateChars(pd, cm, DBVersion)
			pd.CharDBVersion = currentVersion
		end
	end
	-- E.DEBUG_STOP("E.func_setOldChanges")
	updateGlobal(oldGlobalVersion)
	if E.REFRESH_CACHE and (currentVersion ~= oldGlobalVersion or interfaceVersionForReset ~= E.interfaceVersion) then
		-- if currentVersion ~= oldGlobalVersion then
		Octo_Cache_DB = nil
		E.Init_Octo_Cache_DB()
		E.func_BUILD_DUNG_DB()
		Octo_Cache_DB.interfaceVersionForReset = E.interfaceVersion
	end
	Octo_ToDo_DB_Variables.dbv = currentVersion
end
----------------------------------------------------------------