local GlobalAddonName, E = ...
local EventFrame = CreateFrame("FRAME")
local ENABLE_DEBUG_TIMER = false
local function func_Collect_All()
	local allFunctions = {
		{func = E.Collect_BFA_HeartOfAzeroth, name = "Collect_BFA_HeartOfAzeroth",},
		{func = E.Collect_BFA_LegendaryCloak, name = "Collect_BFA_LegendaryCloak",},
		{func = E.Collect_ChromieTime, name = "Collect_ChromieTime",},
		{func = E.Collect_Covenants, name = "Collect_Covenants",},
		{func = E.Collect_Currencies, name = "Collect_Currencies",},
		{func = E.Collect_Delves, name = "Collect_Delves",},
		{func = E.Collect_Garrison, name = "Collect_Garrison",},
		{func = E.Collect_GreatVault, name = "Collect_GreatVault",},
		{func = E.Collect_Holidays, name = "Collect_Holidays",},
		{func = E.Collect_Character_ItemLevels, name = "Collect_Character_ItemLevels",},
		{func = E.Collect_Items_BAGS, name = "Collect_Items_BAGS",},
		{func = E.Collect_JournalInstance, name = "Collect_JournalInstance",},
		{func = E.Collect_Legion_Remix, name = "Collect_Legion_Remix",},
		{func = E.Collect_Locations, name = "Collect_Locations",},
		{func = E.Collect_LoginTime, name = "Collect_LoginTime",},
		{func = E.Collect_Mail, name = "Collect_Mail",},
		{func = E.Collect_Money_AYE, name = "Collect_Money_AYE",},
		{func = E.Collect_Equipment_Durability, name = "Collect_Equipment_Durability",},
		{func = E.Collect_Character_Info, name = "Collect_Character_Info",},
		{func = E.Collect_Character_Level, name = "Collect_Character_Level",},
		{func = E.Collect_Professions, name = "Collect_Professions",},
		{func = E.Collect_Reputations, name = "Collect_Reputations",},
		{func = E.Collect_WarMode, name = "Collect_WarMode",},
		{func = E.Collect_Quests, name = "Collect_Quests",},
	}
	local total = #allFunctions
	if total == 0 then return end
	local index = 1
	local function ExecuteNext()
		local funcInfo = allFunctions[index]
		if funcInfo then
			-- E.func_StartDebugTimer()
				pcall(funcInfo.func)
			-- E.func_StopDebugTimer("["..index.."/"..total.."] "..funcInfo.name)
		end
		index = index + 1
		if index <= total then
			C_Timer.After(0.02, ExecuteNext)
		end
	end
	ExecuteNext()
end
----------------------------------------------------------------
function E.func_Collect_All()
	E.func_SpamBlock(func_Collect_All, false)
end
----------------------------------------------------------------
local MyEventsTable = {
	"ACCOUNT_MONEY",
	"AZERITE_ITEM_EXPERIENCE_CHANGED",
	"BARBER_SHOP_APPEARANCE_APPLIED",
	"BAG_UPDATE",
	"BAG_UPDATE_DELAYED",
	"COVENANT_CHOSEN",
	"COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED",
	"CURRENCY_DISPLAY_UPDATE",
	"CURRENCY_TRANSFER_LOG_UPDATE",
	"ENCOUNTER_END",
	"WEEKLY_REWARDS_UPDATE",
	"CHALLENGE_MODE_COMPLETED",
	"CHALLENGE_MODE_MAPS_UPDATE",
	"BANKFRAME_OPENED",
	"ITEM_COUNT_CHANGED",
	"BANK_TAB_SETTINGS_UPDATED",
	"BANK_TABS_CHANGED",
	-- "GARRISON_BUILDING_ACTIVATED",
	-- "GARRISON_BUILDING_ERROR",
	-- "GARRISON_BUILDING_LIST_UPDATE",
	-- "GARRISON_BUILDING_PLACED",
	-- "GARRISON_BUILDING_REMOVED",
	-- "GARRISON_BUILDING_UPDATE",
	-- "GARRISON_FOLLOWER_ADDED",
	-- "GARRISON_FOLLOWER_CATEGORIES_UPDATED",
	-- "GARRISON_FOLLOWER_LIST_UPDATE",
	-- "GARRISON_FOLLOWER_REMOVED",
	-- "GARRISON_FOLLOWER_XP_CHANGED",
	-- "GARRISON_MISSION_BONUS_ROLL_COMPLETE",
	-- "GARRISON_MISSION_BONUS_ROLL_LOOT",
	-- "GARRISON_MISSION_COMPLETE_RESPONSE",
	-- "GARRISON_MISSION_LIST_UPDATE",
	-- "GARRISON_MISSION_NPC_OPENED",
	-- "GARRISON_MISSION_STARTED",
	-- "GARRISON_SHIPYARD_NPC_OPENED",
	-- "GARRISON_UPDATE",
	-- "GARRISON_UPGRADEABLE_RESULT",
	"HEARTHSTONE_BOUND",
	"ITEM_CHANGED",
	"MAIL_INBOX_UPDATE",
	"MAIL_SHOW",
	"PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED",
	"PLAYER_DEAD",
	"PLAYER_EQUIPMENT_CHANGED",
	"PLAYER_FLAGS_CHANGED",
	"PLAYER_LEVEL_UP",
	"PLAYER_LEAVING_WORLD",
	"PLAYER_LOGIN",
	"PLAYER_MONEY",
	"PLAYER_REGEN_ENABLED",
	"PLAYER_SPECIALIZATION_CHANGED",
	"PLAYER_UPDATE_RESTING",
	"PLAYER_XP_UPDATE",
	"QUEST_LOG_UPDATE",
	"QUEST_POI_UPDATE",
	"SHOW_LOOT_TOAST",
	"SKILL_LINES_CHANGED",
	"SPELLS_CHANGED",
	"TIME_PLAYED_MSG",
	"TRADE_SKILL_SHOW",
	"UPDATE_FACTION",
	"UPDATE_INSTANCE_INFO",
	"UPDATE_INVENTORY_DURABILITY",
	"UPDATE_PENDING_MAIL",
	"ZONE_CHANGED",
	"ZONE_CHANGED_NEW_AREA",
	-- "QUEST_DATA_LOAD_RESULT",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	C_Timer.After(1, function()
			E.Collect_Money_PLAYER_LOGIN()
			RequestTimePlayed()
			RequestRaidInfo()
			E.func_Collect_All()
			E.func_RequestUIUpdate("PLAYER_LOGIN")
	end)
	E.Collect_Mounts()
end
function EventFrame:SKILL_LINES_CHANGED()
	E.Collect_Professions()
	E.func_RequestUIUpdate("SKILL_LINES_CHANGED")
end
function EventFrame:TRADE_SKILL_SHOW()
	E.Collect_Professions()
	E.func_RequestUIUpdate("TRADE_SKILL_SHOW")
end
function EventFrame:PLAYER_XP_UPDATE()
	E.Collect_Character_Level()
	E.func_RequestUIUpdate("PLAYER_XP_UPDATE")
end
function EventFrame:PLAYER_LEVEL_UP()
	RequestTimePlayed()
	E.Collect_Character_Level()
	E.func_RequestUIUpdate("PLAYER_LEVEL_UP")
end
function EventFrame:QUEST_LOG_UPDATE()
	E.Collect_Garrison()
	E.Collect_ChromieTime()
	-- E.Collect_GreatVault()
	E.Collect_Legion_Remix()
	E.Collect_Quests()
	E.func_RequestUIUpdate("QUEST_LOG_UPDATE")
end
function EventFrame:BAG_UPDATE()
	-- E.Collect_Items_BAGS()
	-- if BankFrame and BankFrame:IsShown() then
	-- 	E.Collect_Items_BANK()
	-- end
	-- E.Collect_BFA_HeartOfAzeroth()
	-- E.Collect_BFA_LegendaryCloak()
	-- E.Collect_GreatVault()
	-- E.func_RequestUIUpdate("BAG_UPDATE")
end
function EventFrame:BAG_UPDATE_DELAYED()
	E.Collect_Items_BAGS()
	if BankFrame and BankFrame:IsShown() then
		E.Collect_Items_BANK()
	end
	E.Collect_BFA_HeartOfAzeroth()
	E.Collect_BFA_LegendaryCloak()
	-- E.Collect_GreatVault()
	E.func_RequestUIUpdate("BAG_UPDATE_DELAYED")
end
function EventFrame:ITEM_CHANGED(...)
	local arg1, arg2 = ...
	if arg2:find("item:180653") or arg2:find("item:138019") or arg2:find("item:158923") or arg2:find("item:151086") then
		E.Collect_CurrentKey_ITEM_CHANGED(arg2)
		E.func_RequestUIUpdate("ITEM_CHANGED")
	end
end
function EventFrame:PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED()
	E.Collect_Items_BAGS()
	if BankFrame and BankFrame:IsShown() then
		E.Collect_Items_BANK()
	end
	E.func_RequestUIUpdate("PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED")
end
function EventFrame:PLAYER_MONEY()
	E.Collect_Money_AYE()
	E.func_RequestUIUpdate("PLAYER_MONEY")
end
function EventFrame:ACCOUNT_MONEY()
	E.Collect_Money_AYE()
	E.func_RequestUIUpdate("ACCOUNT_MONEY")
end
function EventFrame:CURRENCY_DISPLAY_UPDATE(...)
	local currencyID = ...
	E.Collect_Currencies()
	E.Collect_Covenants()
	if currencyID then
		E.Collect_TARGET_Currency(currencyID)
	end
	E.func_RequestUIUpdate("CURRENCY_DISPLAY_UPDATE")
end
function EventFrame:CURRENCY_TRANSFER_LOG_UPDATE()
	E.Collect_Currencies()
	E.Collect_Covenants()
	E.Collect_Currencies_Account()
	C_Timer.After(1, function()
			E.Collect_Currencies_Account()
	end)
	E.func_RequestUIUpdate("CURRENCY_TRANSFER_LOG_UPDATE")
end
function EventFrame:PLAYER_EQUIPMENT_CHANGED()
	E.Collect_Character_ItemLevels()
	E.Collect_BFA_HeartOfAzeroth()
	E.Collect_BFA_LegendaryCloak()
	E.func_RequestUIUpdate("PLAYER_EQUIPMENT_CHANGED")
end
function EventFrame:PLAYER_LEAVING_WORLD()
	-- E.func_Collect_All()
	self:UnregisterEvent("PLAYER_LEAVING_WORLD")
	self.PLAYER_LEAVING_WORLD = nil
	-- E.Collect_GreatVault()
	E.Collect_LoginTime()
end
function EventFrame:AZERITE_ITEM_EXPERIENCE_CHANGED()
	E.Collect_BFA_HeartOfAzeroth()
	E.Collect_BFA_LegendaryCloak()
	E.func_RequestUIUpdate("AZERITE_ITEM_EXPERIENCE_CHANGED")
	E.OBROBOTCHIT(Collect_BFA_LegendaryCloak)
end
function EventFrame:COVENANT_CHOSEN(...)
	local id = ...
	E.Collect_Covenants()
	E.func_RequestUIUpdate("COVENANT_CHOSEN")
end
function EventFrame:COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED()
	E.Collect_Covenants()
	E.func_RequestUIUpdate("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
end
function EventFrame:PLAYER_DEAD()
	E.Collect_Equipment_Durability()
	E.func_RequestUIUpdate("PLAYER_DEAD")
end
function EventFrame:UPDATE_INVENTORY_DURABILITY()
	E.Collect_Equipment_Durability()
	E.func_RequestUIUpdate("UPDATE_INVENTORY_DURABILITY")
end
function EventFrame:PLAYER_SPECIALIZATION_CHANGED()
	E.Collect_Character_Info()
	E.func_RequestUIUpdate("PLAYER_SPECIALIZATION_CHANGED")
end
function EventFrame:HEARTHSTONE_BOUND()
	E.Collect_Locations()
	E.func_RequestUIUpdate("HEARTHSTONE_BOUND")
end
function EventFrame:ZONE_CHANGED()
	E.Collect_Locations()
	E.func_RequestUIUpdate("ZONE_CHANGED")
end
function EventFrame:ZONE_CHANGED_NEW_AREA()
	E.Collect_Locations()
	E.func_RequestUIUpdate("ZONE_CHANGED_NEW_AREA")
end
function EventFrame:SPELLS_CHANGED()
	E.Collect_WarMode()
	E.func_RequestUIUpdate("SPELLS_CHANGED")
end
function EventFrame:MAIL_INBOX_UPDATE()
	E.Collect_Mail()
	E.func_RequestUIUpdate("MAIL_INBOX_UPDATE")
end
function EventFrame:MAIL_SHOW()
	E.Collect_Mail()
	E.func_RequestUIUpdate("MAIL_SHOW")
end
function EventFrame:UPDATE_PENDING_MAIL()
	E.Collect_Mail()
	E.func_RequestUIUpdate("UPDATE_PENDING_MAIL")
end
function EventFrame:PLAYER_REGEN_ENABLED()
	E.Collect_Garrison()
	E.Collect_Reputations()
	E.Collect_Currencies()
	E.Collect_Legion_Remix()
	E.Collect_Quests()
	E.func_RequestUIUpdate("PLAYER_REGEN_ENABLED")
end
function EventFrame:ENCOUNTER_END()
	RequestRaidInfo()
	E.func_RequestUIUpdate("ENCOUNTER_END")
end
function EventFrame:UPDATE_INSTANCE_INFO()
	E.Collect_JournalInstance()
	E.func_RequestUIUpdate("UPDATE_INSTANCE_INFO")
end
function EventFrame:TIME_PLAYED_MSG(...)
	local totalTime, currentLevelTime = ...
	E.Collect_Character_TimePlayed(totalTime, currentLevelTime)
	E.Collect_Character_Level()
	E.func_RequestUIUpdate("TIME_PLAYED_MSG")
end
function EventFrame:QUEST_POI_UPDATE()
	E.Collect_ChromieTime()
	E.func_RequestUIUpdate("QUEST_POI_UPDATE")
end
function EventFrame:QUEST_REMOVED()
	E.Collect_Legion_Remix()
	E.Collect_Quests()
	E.func_RequestUIUpdate("QUEST_REMOVED")
end
function EventFrame:SHOW_LOOT_TOAST(...)
	E.Collect_lastCacheTime(...)
	E.func_RequestUIUpdate("SHOW_LOOT_TOAST")
end
function EventFrame:BARBER_SHOP_APPEARANCE_APPLIED()
	E.Collect_Character_Info()
	E.func_RequestUIUpdate("BARBER_SHOP_APPEARANCE_APPLIED")
end
function EventFrame:UPDATE_FACTION()
	E.Collect_Reputations()
	E.func_RequestUIUpdate("UPDATE_FACTION")
end
function EventFrame:PLAYER_FLAGS_CHANGED()
	E.Collect_Character_Info()
	E.func_RequestUIUpdate("PLAYER_FLAGS_CHANGED")
end
function EventFrame:PLAYER_UPDATE_RESTING()
	E.Collect_Character_Info()
	E.func_RequestUIUpdate("PLAYER_UPDATE_RESTING")
end
function EventFrame:WEEKLY_REWARDS_UPDATE()
	E.Collect_GreatVault()
	E.func_RequestUIUpdate("WEEKLY_REWARDS_UPDATE")
end
function EventFrame:CHALLENGE_MODE_COMPLETED()
	E.Collect_GreatVault()
	E.func_RequestUIUpdate("CHALLENGE_MODE_COMPLETED")
end
function EventFrame:CHALLENGE_MODE_MAPS_UPDATE()
	E.Collect_GreatVault()
	E.func_RequestUIUpdate("CHALLENGE_MODE_MAPS_UPDATE")
end
-- function EventFrame:QUEST_DATA_LOAD_RESULT(...)
-- local questID = ...
-- E.func_GetQuestName(questID)
-- end
function EventFrame:BANKFRAME_OPENED()
	E.Collect_Items_BAGS()
	C_Timer.After(0, function()
		if BankFrame and BankFrame:IsShown() then
			E.Collect_Items_BANK()
		end
	end)
	E.func_RequestUIUpdate("BANKFRAME_OPENED")
end
function EventFrame:BANK_TAB_SETTINGS_UPDATED()
	E.Collect_Items_BAGS()
	C_Timer.After(0, function()
		if BankFrame and BankFrame:IsShown() then
			E.Collect_Items_BANK()
		end
	end)
	E.func_RequestUIUpdate("BANK_TAB_SETTINGS_UPDATED")
end
function EventFrame:BANK_TABS_CHANGED()
	E.Collect_Items_BAGS()
	C_Timer.After(0, function()
		if BankFrame and BankFrame:IsShown() then
			E.Collect_Items_BANK()
		end
	end)
	E.func_RequestUIUpdate("BANK_TABS_CHANGED")
end
function EventFrame:ITEM_COUNT_CHANGED()
	E.Collect_Items_BAGS()
	if BankFrame and BankFrame:IsShown() then
		E.Collect_Items_BANK()
	end
	E.func_RequestUIUpdate("ITEM_COUNT_CHANGED")
end