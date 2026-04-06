local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_LEFT_Dispatcher(categoryKey, CharInfo, dataType, id)
	local funcNames = {
		"func_Otrisovka_LEFT_"..dataType,
	}
	for _, funcName in ipairs(funcNames) do
		if E[funcName] then
			return E[funcName](categoryKey, CharInfo, dataType, id)
		end
	end
	return "", nil, nil, nil, nil
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_LEFT_Currencies(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, nil
	TextLeft = E.func_GetName("currency", id)
	SettingsType = dataType.."#"..id
	if id == 824 then
		TooltipKey = "WoD_824"
	end
	if id == 1166 then
		local joinable, timewalkDungeonName = E.func_GetTimewalkingDungeon()
		if joinable then
			TextLeft = TextLeft.." "..timewalkDungeonName
		end
	end
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_LEFT_Items(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, nil
	TextLeft = E.func_GetName("item", id)
	SettingsType = dataType.."#"..id
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_LEFT_RaidsOrDungeons(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, nil
	local name = E.func_GetName("dungeon", id) -- EJ_GetInstanceInfo(id)
	-- local JI_ID = tonumber(id)
	-- local SI_ID = E.func_EJ_to_SI(JI_ID)
	TextLeft = name
	SettingsType = dataType.."#"..id
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_LEFT_UniversalQuests(categoryKey, CharInfo, dataType, data)
	if not categoryKey then return end
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, nil
	-- local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
	local questKey = data.questKey
	local reset = data.reset
	local isAccount = data.isAccount
	local output
	if type(data.TextLeft) == "function" then
		output = data.TextLeft()
	else
		output = data.TextLeft
	end
	TextLeft = output
	SettingsType = dataType.."#"..questKey
	if isAccount then
		-- TextLeft = E.COLOR_IVORY..TextLeft.."|r"
		TextLeft = TextLeft
	end
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_LEFT_Reputations(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, nil
	TextLeft = E.func_GetName("reputation", id)
	SettingsType = dataType.."#"..id
	TooltipKey = "Reputation_"..id
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_LEFT_AdditionallyTOP(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, dataType.."#"..id, nil
	if id == "GreatVault" then
		TextLeft = L["RATED_PVP_WEEKLY_VAULT"]
		IconLeft = E.ATLAS_GREATVAULT
	end
	if id == "CurrentKey" then
		if Octo_ToDo_DB_Vars and Octo_ToDo_DB_Vars.CONFIG_ITEMS_COLOREDNAME then
			TextLeft = E.COLOR_WOW_EPIC..L["WEEKLY_REWARDS_MYTHIC_KEYSTONE"].."|r"
		else
			TextLeft = L["WEEKLY_REWARDS_MYTHIC_KEYSTONE"]
		end
		-- TextLeft = E.COLOR_WOW_EPIC..L["Mythic Keystone"].."|r"
		IconLeft = 4352494
	end
	if id == "PlayerInventory" then
		TextLeft = "INVENTORY"
	end
	if id == "PlayerBANK" then
		TextLeft = "BANK"
	end
	if id == "HeartofAzeroth" then
		TextLeft = E.func_GetName("item", 158075)
		IconLeft = E.func_GetIcon("item", 158075)
	end
	if id == "Ashjrakamas" then
		TextLeft = E.func_GetName("item", 169223)
		IconLeft = E.func_GetIcon("item", 169223)
	end
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Otrisovka_LEFT_AdditionallyBOTTOM(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, dataType.."#"..id, nil
	if id == "ListOfQuests" then
		TextLeft = L["QUESTS_LABEL"]
	end
	if id == "LFGInstance" then
		TextLeft = L["DUNGEONS"] .. " ("..ALL..")"
	end
	if id == "AllItems" then
		TextLeft = L["ITEMS"]
	end
	if id == "Professions" then
		TextLeft = L["TRADE_SKILLS"]
	end
	if id == "ItemLevel" then
		TextLeft = L["STAT_AVERAGE_ITEM_LEVEL"]
	end
	if id == "Money" then
		TextLeft = L["BONUS_ROLL_REWARD_MONEY"]
	end
	if id == "LastOnline" then
		TextLeft = L["Last online"]
	end
	if id == "MythicZero" then
		-- TextLeft = L["DUNGEONS"] .. " (M+0)"
		TextLeft = L["DUNGEONS"] .." (".. E.func_GetName("difficulty", 23).."+0)"
	end
 	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------