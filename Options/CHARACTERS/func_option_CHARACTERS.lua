local GlobalAddonName, E = ...
local L = E.L
function E.func_option_CHARACTERS(category, layout)
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.Config_LevelToShow ------------------------
	----------------------------------------------------------------
	do
		local variableKey = "Config_LevelToShow"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Min. Level"]
		local minValue = 1
		local maxValue = 90
		local step = 1
		local tooltip
		E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
	end
	----------------------------------------------------------------
	-- Octo_ToDo_DB_Vars.Config_LevelToShowMAX ---------------------
	----------------------------------------------------------------
	do
		local variableKey = "Config_LevelToShowMAX"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Max. Level"]
		local minValue = 1
		local maxValue = 90
		local step = 1
		local tooltip
		E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
	end
	----------------------------------------------------------------
	-- isOnlyCurrentBtag -------------------------------------------
	----------------------------------------------------------------
	do
		local variableKey = "isOnlyCurrentBtag"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Only Current BattleTag"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- ShowOnlyCurrentRegion ---------------------------------------
	----------------------------------------------------------------
	do
		local variableKey = "ShowOnlyCurrentRegion"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Only Current Region"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- isOnlyCurrentServer -----------------------------------------
	----------------------------------------------------------------
	do
		local variableKey = "isOnlyCurrentServer"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local name = L["Only Current Server"]
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	----------------------------------------------------------------
	-- isOnlyCurrentFaction ----------------------------------------
	----------------------------------------------------------------
	do
		local variableKey = "isOnlyCurrentFaction"
		local variableTbl = Octo_ToDo_DB_Vars
		local defaultValue = E.Octo_ToDo_DB_Vars_DEFAULTS[variableKey]
		local function funcName()
			local result = ""
			if E.FACTION_CURRENT == "Horde" then
				result = E.func_texturefromIcon(E.ICON_HORDE)..L["Only Horde"]
			else
				result = E.func_texturefromIcon(E.ICON_ALLIANCE)..L["Only Alliance"]
			end
			return result
		end
		local name = funcName()
		E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue)
	end
	if E.DEBUG then
		----------------------------------------------------------------
		-- HEADER ------------------------------------------------------
		----------------------------------------------------------------
		E.func_Header(layout, L["Characters"])
		----------------------------------------------------------------
		do
			local function getTableSize(t)
				local count = 0
				for _ in pairs(t) do
					count = count + 1
				end
				return count
			end
			local sortedCharacters = E.func_SortCharacters()
			-- local visiblePlayers = {}
			-- local hiddenPlayer = {}
			-- for CharIndex, CharInfo in ipairs(sortedCharacters) do
			-- local pd = CharInfo.PlayerData
			-- visiblePlayers[pd.GUID] = true
			-- hiddenPlayer[pd.GUID] = false
			-- end
			local function func_COUNT_PLAYERS()
				local count = 0
				return count
			end
			local variableKey = "isShownPlayer"
			----------------------------------------------------------------
			local tbl = {}
			local seenServers = {}
			local seenRegions = {}
			local seenBtags = {}
			for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
				local pd = CharInfo.PlayerData
				local server = pd.curServer
				local btag = pd.BattleTag
				local region = pd.CurrentRegionName
				-- вложенная структура
				local t_btag = tbl[btag]
				if not t_btag then
					t_btag = {}
					tbl[btag] = t_btag
				end
				local t_region = t_btag[region]
				if not t_region then
					t_region = {}
					t_btag[region] = t_region
				end
				local t_server = t_region[server]
				if not t_server then
					t_server = {}
					t_region[server] = t_server
				end
				t_server[GUID] = true
			end
			----------------------------------------------------------------
			local function HasValidPlayers(t)
				for GUID in pairs(t) do
					local ci = Octo_ToDo_DB_Levels[GUID]
					if ci and ci.PlayerData then
						return true
					end
				end
			end
			----------------------------------------------------------------
			local numServers, numRegions, numBtags, numPlayers = E.func_GetCounts()
			-- print("Servers: " .. numServers)
			-- print("Regions: " .. numRegions)
			-- print("Btags: " .. numBtags)
			-- print("Players: " .. numPlayers)
			----------------------------------------------------------------
			for BattleTag, v1 in next, tbl do
				local printedBtag = false
				for CurrentRegionName, v2 in next, v1 do
					local hasRegion = false
					for server, v3 in next, v2 do
						if HasValidPlayers(v3) then
							hasRegion = true
							break
						end
					end
					if hasRegion then
						if not printedBtag then
							E.func_Header(layout, BattleTag)
							printedBtag = true
						end
						E.func_Header(layout, CurrentRegionName)
						for server, v3 in next, v2 do
							if HasValidPlayers(v3) then
								E.func_Header(layout, server)
								for GUID in pairs(v3) do
									local CharInfo = Octo_ToDo_DB_Levels[GUID]
									if CharInfo and CharInfo.PlayerData then
										local pd = CharInfo.PlayerData
										local PlayerName = E.func_CharInfo_NickName(CharInfo, true, false, nil, true)
										local variableKey = "isShownPlayer_" .. GUID
										E.func_Options_CreateCheckbox(category, variableKey, pd, PlayerName, true)
									end
								end
							end
						end
					end
				end
			end
			----------------------------------------------------------------
		end
	end
	----------------------------------------------------------------
end