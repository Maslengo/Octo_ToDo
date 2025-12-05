local GlobalAddonName, E = ...
local EventFrame = CreateFrame("FRAME")
local ENABLE_DEBUG_TIMER = false
function E.func_Collect_All()
	local start = debugprofilestop()
	local color = E.Green_Color
	if E.func_SpamBlock("func_Collect_All") then
		color = E.Red_Color
	else
		E.Collect_All_BfA_Azerite()
		E.Collect_All_BfA_Cloaklvl()
		E.Collect_All_Chromie()
		E.Collect_All_Covenant()
		E.Collect_All_Currency()
		E.Collect_All_Delves()
		E.Collect_All_Garrison()
		E.Collect_All_GreatVault()
		E.Collect_All_Holiday()
		E.Collect_All_ItemLevel()
		E.Collect_All_ItemsInBag()
		E.Collect_All_JournalInstance()
		E.Collect_All_LegionRemixData()
		E.Collect_All_Locations()
		E.Collect_All_LoginTime()
		E.Collect_All_Mail()
		E.Collect_All_MoneyOnLogin()
		E.Collect_All_MoneyUpdate()
		E.Collect_All_PlayerDurability()
		E.Collect_All_PlayerInfo()
		E.Collect_All_PlayerLevel()
		E.Collect_All_Professions()
		E.Collect_All_Quests()
		E.Collect_All_Reputations()
		E.Collect_All_UNIVERSALQuestUpdate()
		E.Collect_All_WarMode()
	end
	local elapsed = debugprofilestop() - start
	if ENABLE_DEBUG_TIMER then
		print(string.format("Время выполнения: %s%.3f|r сек", color, elapsed / 1000))
	end
end
local MyEventsTable = {
	"ACCOUNT_MONEY",
	"AZERITE_ITEM_EXPERIENCE_CHANGED",
	"BARBER_SHOP_APPEARANCE_APPLIED",
	"BAG_UPDATE",
	"COVENANT_CHOSEN",
	"COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED",
	"CURRENCY_DISPLAY_UPDATE",
	"CURRENCY_TRANSFER_LOG_UPDATE",
	"ENCOUNTER_END",
	"COVENANT_CALLINGS_UPDATED",
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
	-- "QUEST_REMOVED",
	-- "PLAYER_INSIDE_QUEST_BLOB_STATE_CHANGED",
	-- "QUEST_WATCH_UPDATE",
	-- "QUEST_ACCEPTED",
	-- "QUEST_DATA_LOAD_RESULT",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	C_Timer.After(1, function()
		RequestTimePlayed()
		RequestRaidInfo()
		E.func_Collect_All()
		E.func_Update("PLAYER_LOGIN")
	end)
end
function EventFrame:SKILL_LINES_CHANGED()
	E.Collect_All_Professions()
	E.func_Update("SKILL_LINES_CHANGED")
end
function EventFrame:TRADE_SKILL_SHOW()
	E.Collect_All_Professions()
	E.func_Update("TRADE_SKILL_SHOW")
end
function EventFrame:PLAYER_XP_UPDATE()
	E.Collect_All_PlayerLevel()
	E.func_Update("PLAYER_XP_UPDATE")
end
function EventFrame:PLAYER_LEVEL_UP()
	RequestTimePlayed()
	E.Collect_All_PlayerLevel()
	E.func_Update("PLAYER_LEVEL_UP")
end
function EventFrame:QUEST_LOG_UPDATE()
	E.Collect_All_Quests()
	E.Collect_All_Garrison()
	E.Collect_All_UNIVERSALQuestUpdate()
	E.Collect_All_Chromie()
	E.Collect_All_GreatVault()
	E.Collect_All_LegionRemixData()
	E.func_Update("QUEST_LOG_UPDATE")
end
function EventFrame:BAG_UPDATE()
	-- E.Collect_All_ItemsInBag()
	-- E.Collect_All_BfA_Azerite()
	-- E.Collect_All_BfA_Cloaklvl()
	-- E.Collect_All_GreatVault()
	-- E.func_Update("BAG_UPDATE")
end
function EventFrame:ITEM_CHANGED(...)
	local arg1, arg2 = ...
	if arg2:find("item:180653") or arg2:find("item:138019") or arg2:find("item:158923") or arg2:find("item:151086") then
		E.Collect_CurrentKey_ITEM_CHANGED(arg2)
		E.func_Update("ITEM_CHANGED")
	end
end
function EventFrame:PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED()
	E.Collect_All_ItemsInBag()
	E.func_Update("PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED")
end
function EventFrame:PLAYER_MONEY()
	E.Collect_All_MoneyUpdate()
	E.func_Update("PLAYER_MONEY")
end
function EventFrame:ACCOUNT_MONEY()
	E.Collect_All_MoneyUpdate()
	E.func_Update("ACCOUNT_MONEY")
end
function EventFrame:CURRENCY_DISPLAY_UPDATE()
	E.Collect_All_Currency()
	E.Collect_All_Covenant()
	E.func_Update("CURRENCY_DISPLAY_UPDATE")
end
function EventFrame:CURRENCY_TRANSFER_LOG_UPDATE()
	E.Collect_All_Currency()
	E.Collect_All_Covenant()
	E.func_Update("CURRENCY_TRANSFER_LOG_UPDATE")
end
function EventFrame:PLAYER_EQUIPMENT_CHANGED()
	E.Collect_All_ItemLevel()
	E.Collect_All_BfA_Azerite()
	E.Collect_All_BfA_Cloaklvl()
	E.func_Update("PLAYER_EQUIPMENT_CHANGED")
end
function EventFrame:PLAYER_LEAVING_WORLD()
	self:UnregisterEvent("PLAYER_LEAVING_WORLD")
	self.PLAYER_LEAVING_WORLD = nil
	E.Collect_All_GreatVault()
	E.Collect_All_LoginTime()
end
function EventFrame:AZERITE_ITEM_EXPERIENCE_CHANGED()
	E.Collect_All_BfA_Azerite()
	E.Collect_All_BfA_Cloaklvl()
	E.func_Update("AZERITE_ITEM_EXPERIENCE_CHANGED")
end
function EventFrame:COVENANT_CHOSEN()
	E.Collect_All_Covenant()
	E.func_Update("COVENANT_CHOSEN")
end
function EventFrame:COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED()
	E.Collect_All_Covenant()
	E.func_Update("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
end
function EventFrame:PLAYER_DEAD()
	E.Collect_All_PlayerDurability()
	E.func_Update("PLAYER_DEAD")
end
function EventFrame:UPDATE_INVENTORY_DURABILITY()
	E.Collect_All_PlayerDurability()
	E.func_Update("UPDATE_INVENTORY_DURABILITY")
end
function EventFrame:PLAYER_SPECIALIZATION_CHANGED()
	E.Collect_All_PlayerInfo()
	E.func_Update("PLAYER_SPECIALIZATION_CHANGED")
end
function EventFrame:HEARTHSTONE_BOUND()
	E.Collect_All_Locations()
	E.func_Update("HEARTHSTONE_BOUND")
end
function EventFrame:ZONE_CHANGED()
	E.Collect_All_Locations()
	E.func_Update("ZONE_CHANGED")
end
function EventFrame:ZONE_CHANGED_NEW_AREA()
	E.Collect_All_Locations()
	E.func_Update("ZONE_CHANGED_NEW_AREA")
end
function EventFrame:SPELLS_CHANGED()
	E.Collect_All_WarMode()
	E.func_Update("SPELLS_CHANGED")
end
function EventFrame:MAIL_INBOX_UPDATE()
	E.Collect_All_Mail()
	E.func_Update("MAIL_INBOX_UPDATE")
end
function EventFrame:MAIL_SHOW()
	E.Collect_All_Mail()
	E.func_Update("MAIL_SHOW")
end
function EventFrame:UPDATE_PENDING_MAIL()
	E.Collect_All_Mail()
	E.func_Update("UPDATE_PENDING_MAIL")
end
function EventFrame:PLAYER_REGEN_ENABLED()
	E.Collect_All_Quests()
	E.Collect_All_Garrison()
	E.Collect_All_UNIVERSALQuestUpdate()
	E.Collect_All_Reputations()
	E.Collect_All_Currency()
	E.Collect_All_LegionRemixData()
	E.func_Update("PLAYER_REGEN_ENABLED")
end
function EventFrame:ENCOUNTER_END()
	RequestRaidInfo()
	E.func_Update("ENCOUNTER_END")
end
function EventFrame:UPDATE_INSTANCE_INFO()
	E.Collect_All_JournalInstance()
	E.func_Update("UPDATE_INSTANCE_INFO")
end
function EventFrame:TIME_PLAYED_MSG(...)
	E.Collect_All_Played(...)
	E.Collect_All_PlayerLevel()
	E.func_Update("TIME_PLAYED_MSG")
end
function EventFrame:QUEST_POI_UPDATE()
	E.Collect_All_Chromie()
	E.func_Update("QUEST_POI_UPDATE")
end
function EventFrame:QUEST_REMOVED()
	E.Collect_All_Quests()
	E.Collect_All_LegionRemixData()
	E.func_Update("QUEST_REMOVED")
end
function EventFrame:SHOW_LOOT_TOAST(rt, rl, q, _4, _5, _6, source)
	E.Collect_All_lastCacheTime(rt, rl, q, _4, _5, _6, source)
	E.func_Update("SHOW_LOOT_TOAST")
end
function EventFrame:BARBER_SHOP_APPEARANCE_APPLIED()
	E.Collect_All_PlayerInfo()
	E.func_Update("BARBER_SHOP_APPEARANCE_APPLIED")
end
function EventFrame:UPDATE_FACTION()
	E.Collect_All_Reputations()
	E.func_Update("UPDATE_FACTION")
end
function EventFrame:PLAYER_FLAGS_CHANGED()
	E.Collect_All_PlayerInfo()
	E.func_Update("PLAYER_FLAGS_CHANGED")
end
function EventFrame:PLAYER_UPDATE_RESTING()
	E.Collect_All_PlayerInfo()
	E.func_Update("PLAYER_UPDATE_RESTING")
end
-- function EventFrame:QUEST_REMOVED(...)
-- 	local questID = ...
-- 	local questName = E.func_questName(questID) -- ПОФИКСИТЬ (БЫЛ СПАМ)
-- 	-- print ("QUEST_REMOVED", questID, E.func_questName(questID))
-- 	E.func_Update("QUEST_REMOVED")
-- end
-- function EventFrame:PLAYER_INSIDE_QUEST_BLOB_STATE_CHANGED(...)
-- 	local questID = ...
-- 	local questName = E.func_questName(questID) -- ПОФИКСИТЬ (БЫЛ СПАМ)
-- 	-- print ("PLAYER_INSIDE_QUEST_BLOB_STATE_CHANGED", questID, E.func_questName(questID))
-- 	E.func_Update("PLAYER_INSIDE_QUEST_BLOB_STATE_CHANGED")
-- end
-- function EventFrame:QUEST_WATCH_UPDATE(...)
-- 	local questID = ...
-- 	local questName = E.func_questName(questID) -- ПОФИКСИТЬ (БЫЛ СПАМ)
-- 	-- print ("QUEST_WATCH_UPDATE", questID, E.func_questName(questID))
-- 	E.func_Update("QUEST_WATCH_UPDATE")
-- end
-- function EventFrame:QUEST_ACCEPTED(...)
-- 	local questID = ...
-- 	local questName = E.func_questName(questID) -- ПОФИКСИТЬ (БЫЛ СПАМ)
-- 	-- print ("QUEST_ACCEPTED", questID, E.func_questName(questID))
-- 	E.func_Update("QUEST_ACCEPTED")
-- end
-- function EventFrame:QUEST_DATA_LOAD_RESULT(...)
-- 	local questID = ...
-- 	local questName = E.func_questName(questID) -- ПОФИКСИТЬ (БЫЛ СПАМ)
-- 	E.func_Update("QUEST_DATA_LOAD_RESULT")
-- end