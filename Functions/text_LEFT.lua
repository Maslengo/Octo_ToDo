local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
function E.func_Otrisovka_LEFT_Dispatcher(categoryKey, CharInfo, dataType, id)
	-- Пробуем разные варианты названий функций
	local funcNames = {
		"func_Otrisovka_LEFT_"..dataType,
	}
	for _, funcName in ipairs(funcNames) do
		if E[funcName] --[[and dataType ~= "UniversalQuests"]] then
			return E[funcName](categoryKey, CharInfo, dataType, id)
		end
	end
	-- Если функция не найдена, возвращаем значения по умолчанию
	-- TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
	return "", nil, nil, nil, nil
end
function E.func_Otrisovka_LEFT_Currencies(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, nil
	----------------------------------------------------------------
	TextLeft = E.func_GetCurrencyName(id)
	-- ColorLeft = E.COLOR_GREEN
	-- IconLeft = E.func_GetCurrencyIcon(id)
	SettingsType = dataType.."#"..id
	-- TooltipKey =
	if id == 824 then
		TooltipKey = "WoD_824"
	end
	if id == 1166 then
		local joinable, timewalkDungeonName = E.func_GetTimewalkingDungeon()
		if joinable then
			TextLeft = TextLeft..timewalkDungeonName
		end
	end
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_LEFT_Items(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, nil
	----------------------------------------------------------------
	TextLeft = E.func_GetItemName(id)
	-- ColorLeft =
	-- IconLeft = E.func_GetItemIcon(id)
	SettingsType = dataType.."#"..id
	-- TooltipKey =
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
	----------------------------------------------------------------
end
function E.func_Otrisovka_LEFT_RaidsOrDungeons(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, nil
	----------------------------------------------------------------
	-- local name, _, _, _, _, buttonImage2, _, _, _, _, _, isRaid = EJ_GetInstanceInfo(id)
	local name = EJ_GetInstanceInfo(id)
	----------------------------------------------------------------
	local JI_ID = tonumber(id)
	local SI_ID = E.func_EJ_to_SI(JI_ID)
	TextLeft = name -- (isRaid and E.COLOR_GREEN or E.COLOR_BLUE) .. name .. "|r"
	-- ColorLeft =
	-- IconLeft = buttonImage2 or E.ICON_QUESTION_MARK -- "Raid"
	SettingsType = dataType.."#"..id
	-- TooltipKey =
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
	----------------------------------------------------------------
end
function E.func_Otrisovka_LEFT_UniversalQuests(categoryKey, CharInfo, dataType, data)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, nil
	----------------------------------------------------------------
	local questKey = E.UNIVERSAL..data.desc.."_"..data.name_save.."_"..data.reset
	local reset = data.reset -- questKey:match("_([^_]+)$")
	----------------------------------------------------------------
	-- TextLeft = tostringall(E.func_FormatResetType(data.reset).." "..data.TextLeft)
	local output
	if type(data.TextLeft) == "function" then
		output = data.TextLeft() -- ← Вызываем функцию!
	else
		output = data.TextLeft
	end
	TextLeft = output
	-- ColorLeft =
	-- if reset == "Daily" then
	-- 	IconLeft = E.ICON_DAILY
	-- elseif reset == "Weekly" then
	-- 	IconLeft = E.ICON_WEEKLY
	-- elseif reset == "Regular" then
	-- 	IconLeft = E.ICON_REGULAR
	-- elseif reset == "Month" then
	-- 	IconLeft = E.ICON_MONTH
	-- end
	SettingsType = dataType.."#"..questKey
	-- TooltipKey =
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
function E.func_Otrisovka_LEFT_Reputations(categoryKey, CharInfo, dataType, id) -- func_Otrisovka_LEFT_Dispatcher
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, nil, nil
	----------------------------------------------------------------
	TextLeft = E.func_GetReputationName(id)
	-- ColorLeft =
	-- IconLeft = E.func_GetReputationIcon(id)
	SettingsType = dataType.."#"..id
	TooltipKey = "Reputation_"..id
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
	----------------------------------------------------------------
end
function E.func_Otrisovka_LEFT_Additionally(categoryKey, CharInfo, dataType, id)
	if not categoryKey then return end
	----------------------------------------------------------------
	local TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey = "", nil, nil, dataType.."#"..id, nil
	----------------------------------------------------------------
	if id == "LegionRemixResearch" then
		TextLeft = L["Infinite Research"]
	elseif id == "ListOfQuests" then
		TextLeft = QUESTS_LABEL
	elseif id == "LFGInstance" then
		TextLeft = DUNGEONS
	elseif id == "AllItems" then
		TextLeft = ITEMS
	elseif id == "Professions" then
		TextLeft = PROFESSIONS_BUTTON
	elseif id == "ItemLevel" then
		TextLeft = STAT_AVERAGE_ITEM_LEVEL
	elseif id == "Money" then
		TextLeft = BONUS_ROLL_REWARD_MONEY
	elseif id == "LastOnline" then
		TextLeft = L["Last online"]
	elseif id == "GreatVault" then
		TextLeft = RATED_PVP_WEEKLY_VAULT
		IconLeft = "greatVault-whole-normal"
	elseif id == "CurrentKey" then
		TextLeft = E.COLOR_WOW_EPIC..L["Mythic Keystone"].."|r"
		IconLeft = 4352494
	elseif id == "HeartofAzeroth" then
		TextLeft = E.func_GetItemName(158075)
		IconLeft = E.func_GetItemIcon(158075)
	elseif id == "Ashjrakamas" then
		TextLeft = E.func_GetItemName(169223)
		IconLeft = E.func_GetItemIcon(169223)
	end
	----------------------------------------------------------------
	return TextLeft, ColorLeft, IconLeft, SettingsType, TooltipKey
	---------------------------------------------------------------- -- func_Otrisovka_LEFT_Dispatcher
end
