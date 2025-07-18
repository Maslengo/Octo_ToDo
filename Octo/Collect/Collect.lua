local GlobalAddonName, E = ...
local Octo_EventFrame_Collect = CreateFrame("FRAME")
Octo_EventFrame_Collect:Hide()

----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
	"TIME_PLAYED_MSG",
	"PLAYER_LEAVING_WORLD",
	"ACCOUNT_MONEY",
	"AZERITE_ITEM_EXPERIENCE_CHANGED",
	"BAG_UPDATE",
	"ITEM_CHANGED",
	"COVENANT_CHOSEN",
	"COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED",
	"CURRENCY_DISPLAY_UPDATE",
	"CURRENCY_TRANSFER_LOG_UPDATE",
	"ENCOUNTER_END",
	"HEARTHSTONE_BOUND",
	"MAIL_INBOX_UPDATE",
	"MAIL_SHOW",
	"PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED",
	"PLAYER_DEAD",
	-- "PLAYER_ENTERING_WORLD",
	"PLAYER_EQUIPMENT_CHANGED",
	"PLAYER_LEVEL_UP",
	"PLAYER_MONEY",
	"PLAYER_REGEN_ENABLED",
	"PLAYER_SPECIALIZATION_CHANGED",
	"PLAYER_XP_UPDATE",
	"QUEST_LOG_UPDATE",
	"QUEST_POI_UPDATE",
	"SKILL_LINES_CHANGED",
	"SPELLS_CHANGED",
	"TRADE_SKILL_SHOW",
	"UPDATE_INSTANCE_INFO",
	"UPDATE_INVENTORY_DURABILITY",
	"UPDATE_PENDING_MAIL",
	"ZONE_CHANGED",
	"ZONE_CHANGED_NEW_AREA",
}
function E.Collect_All_Table(event)
	E.Collect_All_PlayerLevel()
	E.Collect_All_ItemLevel()
	E.Collect_All_PlayerDurability()
	E.Collect_All_Holiday()
end
----------------------------------------------------------------
E:func_RegisterMyEventsToFrames(Octo_EventFrame_Collect, MyEventsTable)
function Octo_EventFrame_Collect:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		E:func_ConcatAtStart_UniversalQuest()
		OctpToDo_inspectScantip = CreateFrame("GameTooltip", "OctoScanningTooltipFIRST", nil, "GameTooltipTemplate")
		OctpToDo_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
	end
end
function Octo_EventFrame_Collect:PLAYER_LOGIN()
	RequestTimePlayed()
	RequestRaidInfo()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
	E.Collect_All_MoneyOnLogin()
	-- Персонаж и прогресс
	E.Collect_All_PlayerInfo() -- общая информация о персонаже
	E.Collect_All_PlayerLevel() -- уровень персонажа
	E.Collect_All_ItemLevel() -- уровень предметов
	E.Collect_All_PlayerDurability() -- прочность экипировки
	E.Collect_All_Professions() -- профессии
	E.Collect_All_Reputations() -- репутации
	E.Collect_All_Quests() -- квесты
	E.Collect_All_UNIVERSALQuestUpdate() -- обновления квестов
	-- Предметы и валюта
	E.Collect_All_ItemsInBag() -- предметы в сумках
	-- E.Collect_All_Currency() -- валюта
	E.Collect_All_MoneyOnLogin() -- деньги при входе
	E.Collect_All_MoneyUpdate() -- обновление денег
	E.Collect_All_Mail() -- почта
	-- Локации и активность
	E.Collect_All_Locations() -- местоположение
	E.Collect_All_JournalInstance() -- информация о подземельях/рейдах
	E.Collect_All_WarMode() -- режим войны
	E.Collect_All_Chromie() -- хроми
	E.Collect_All_BfA_Island() -- острова Battle for Azeroth
	-- Системные и служебные данные
	E.Collect_All_LoginTime() -- время входа (УБРАТЬ?)
	E.Collect_All_Holiday() -- праздничные события
	-- Особые системы (BfA, Shadowlands и др.)
	E.Collect_All_BfA_Azerite() -- азерит, Battle for Azeroth
	E.Collect_All_BfA_Cloaklvl() -- уровень плаща, BfA
	E.Collect_All_Covenant() -- ковенанты, Shadowlands
	E.Collect_All_GreatVault() -- Великое Хранилище
	E:func_Update("PLAYER_LOGIN")
end
function Octo_EventFrame_Collect:SKILL_LINES_CHANGED()
	if InCombatLockdown() or self.SKILL_LINES_CHANGED_pause then return end
	self.SKILL_LINES_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Professions()
			E:func_Update("SKILL_LINES_CHANGED")
			self.SKILL_LINES_CHANGED_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:TRADE_SKILL_SHOW()
	if InCombatLockdown() or self.TRADE_SKILL_SHOW_Pause then return end
	self.TRADE_SKILL_SHOW_Pause = true
	C_Timer.After(1, function()
			E.Collect_All_Professions()
			E:func_Update("TRADE_SKILL_SHOW")
			self.SKILL_LINES_CHANGED_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_XP_UPDATE()
	if InCombatLockdown() or UnitLevel("player") == MAX_PLAYER_LEVEL or self.PLAYER_XP_UPDATE_pause then return end
	self.PLAYER_XP_UPDATE_pause = true
	C_Timer.After(1, function()
			E.Collect_All_PlayerLevel()
			E:func_Update("PLAYER_XP_UPDATE")
			self.PLAYER_XP_UPDATE_pause = nil
	end)
end
function Octo_EventFrame_Collect:PLAYER_LEVEL_UP()
	if InCombatLockdown() or self.PLAYER_LEVEL_UP_Pause then return end
	self.PLAYER_LEVEL_UP_Pause = true
	C_Timer.After(1, function()
			RequestTimePlayed()
			E.Collect_All_PlayerLevel()
			E:func_Update("PLAYER_LEVEL_UP")
			self.PLAYER_LEVEL_UP_Pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:QUEST_LOG_UPDATE()
	if InCombatLockdown() or self.QUEST_LOG_UPDATE_Pause then return end
	self.QUEST_LOG_UPDATE_Pause = true
	C_Timer.After(1, function()
			E.Collect_All_Quests()
			E.Collect_All_UNIVERSALQuestUpdate()
			E.Collect_All_BfA_Island()
			E.Collect_All_Chromie()
			E:func_Update("QUEST_LOG_UPDATE")
			self.QUEST_LOG_UPDATE_Pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:BAG_UPDATE()
	if InCombatLockdown() or self.BAG_UPDATE_pause then return end
	self.BAG_UPDATE_pause = true
	C_Timer.After(1, function()
			E.Collect_All_ItemsInBag()
			E:func_Update("BAG_UPDATE")
			self.BAG_UPDATE_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:ITEM_CHANGED(...)
	local arg1, arg2 = ...
	if arg2:find("item:180653") or arg2:find("item:138019") or arg2:find("item:158923") or arg2:find("item:151086") then
		E.Collect_CurrentKey_ITEM_CHANGED(arg2)
		E:func_Update("ITEM_CHANGED")
	end
end
function Octo_EventFrame_Collect:PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED()
	if InCombatLockdown() or self.PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED_pause then return end
	self.PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_ItemsInBag()
			E:func_Update("PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED")
			self.PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_MONEY()
	if InCombatLockdown() or self.PLAYER_MONEY_pause then return end
	self.PLAYER_MONEY_pause = true
	C_Timer.After(1, function()
			E.Collect_All_MoneyUpdate()
			E:func_Update("PLAYER_MONEY")
			self.PLAYER_MONEY_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:ACCOUNT_MONEY()
	if InCombatLockdown() or self.ACCOUNT_MONEY_pause then return end
	self.ACCOUNT_MONEY_pause = true
	C_Timer.After(1, function()
			E.Collect_All_MoneyUpdate()
			E:func_Update("ACCOUNT_MONEY")
			self.ACCOUNT_MONEY_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:CURRENCY_DISPLAY_UPDATE()
	if InCombatLockdown() or self.CURRENCY_DISPLAY_UPDATE_pause then return end
	self.CURRENCY_DISPLAY_UPDATE_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Currency()
			E.Collect_All_Covenant()
			E:func_Update("CURRENCY_DISPLAY_UPDATE")
			self.CURRENCY_DISPLAY_UPDATE_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:CURRENCY_TRANSFER_LOG_UPDATE()
	if InCombatLockdown() or self.CURRENCY_TRANSFER_LOG_UPDATE_pause then return end
	self.CURRENCY_TRANSFER_LOG_UPDATE_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Currency()
			E.Collect_All_Covenant()
			E:func_Update("CURRENCY_TRANSFER_LOG_UPDATE")
			self.CURRENCY_TRANSFER_LOG_UPDATE_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_EQUIPMENT_CHANGED()
	if InCombatLockdown() or self.PLAYER_EQUIPMENT_CHANGED_pause then return end
	self.PLAYER_EQUIPMENT_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_ItemLevel()
			E:func_Update("PLAYER_EQUIPMENT_CHANGED")
			self.PLAYER_EQUIPMENT_CHANGED_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_LEAVING_WORLD()
	if not InCombatLockdown() then return end
	self:UnregisterEvent("PLAYER_LEAVING_WORLD")
	self.PLAYER_LEAVING_WORLD = nil
	E.Collect_All_GreatVault()
	E.Collect_All_LoginTime()
end
function Octo_EventFrame_Collect:AZERITE_ITEM_EXPERIENCE_CHANGED()
	if InCombatLockdown() or self.AZERITE_ITEM_EXPERIENCE_CHANGED_pause then return end
	self.AZERITE_ITEM_EXPERIENCE_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_BfA_Azerite()
			E.Collect_All_BfA_Cloaklvl()
			E:func_Update("AZERITE_ITEM_EXPERIENCE_CHANGED")
			self.AZERITE_ITEM_EXPERIENCE_CHANGED_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:COVENANT_CHOSEN()
	if InCombatLockdown() or self.COVENANT_CHOSEN_pause then return end
	self.COVENANT_CHOSEN_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Covenant()
			E:func_Update("COVENANT_CHOSEN")
			self.COVENANT_CHOSEN_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED()
	if InCombatLockdown() or self.COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED_pause then return end
	self.COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Covenant()
			E:func_Update("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
			self.COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_DEAD()
	if InCombatLockdown() or self.PLAYER_DEAD_pause then return end
	self.PLAYER_DEAD_pause = true
	C_Timer.After(1, function()
			E.Collect_All_PlayerDurability()
			E:func_Update("PLAYER_DEAD")
			self.PLAYER_DEAD_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:UPDATE_INVENTORY_DURABILITY()
	if InCombatLockdown() or self.UPDATE_INVENTORY_DURABILITY_pause then return end
	self.UPDATE_INVENTORY_DURABILITY_pause = true
	C_Timer.After(1, function()
			E.Collect_All_PlayerDurability()
			E:func_Update("UPDATE_INVENTORY_DURABILITY")
			self.UPDATE_INVENTORY_DURABILITY_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_SPECIALIZATION_CHANGED()
	if InCombatLockdown() or self.PLAYER_SPECIALIZATION_CHANGED_pause then return end
	self.PLAYER_SPECIALIZATION_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_PlayerInfo()
			E:func_Update("PLAYER_SPECIALIZATION_CHANGED")
			self.PLAYER_SPECIALIZATION_CHANGED_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:HEARTHSTONE_BOUND()
	if InCombatLockdown() or self.HEARTHSTONE_BOUND_pause then return end
	self.HEARTHSTONE_BOUND_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Locations()
			E:func_Update("HEARTHSTONE_BOUND")
			self.HEARTHSTONE_BOUND_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:ZONE_CHANGED()
	if InCombatLockdown() or self.ZONE_CHANGED_pause then return end
	self.ZONE_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Locations()
			E:func_Update("ZONE_CHANGED")
			self.ZONE_CHANGED_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:ZONE_CHANGED_NEW_AREA()
	if InCombatLockdown() or self.ZONE_CHANGED_NEW_AREA_pause then return end
	self.ZONE_CHANGED_NEW_AREA_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Locations()
			E:func_Update("ZONE_CHANGED_NEW_AREA")
			self.ZONE_CHANGED_NEW_AREA_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:SPELLS_CHANGED()
	if InCombatLockdown() or self.SPELLS_CHANGED_pause then return end
	self.SPELLS_CHANGED_pause = true
	C_Timer.After(1, function()
			E.Collect_All_WarMode()
			E:func_Update("SPELLS_CHANGED")
			self.SPELLS_CHANGED_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:MAIL_INBOX_UPDATE()
	if InCombatLockdown() or self.MAIL_INBOX_UPDATE_pause then return end
	self.MAIL_INBOX_UPDATE_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Mail()
			E:func_Update("MAIL_INBOX_UPDATE")
			self.MAIL_INBOX_UPDATE_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:MAIL_SHOW()
	if InCombatLockdown() or self.MAIL_SHOW_pause then return end
	self.MAIL_SHOW_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Mail()
			E:func_Update("MAIL_SHOW")
			self.MAIL_SHOW_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:UPDATE_PENDING_MAIL()
	if InCombatLockdown() or self.UPDATE_PENDING_MAIL_pause then return end
	self.UPDATE_PENDING_MAIL_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Mail()
			E:func_Update("UPDATE_PENDING_MAIL")
			self.UPDATE_PENDING_MAIL_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:PLAYER_REGEN_ENABLED()
	if InCombatLockdown() or self.PLAYER_REGEN_ENABLED_pause then return end
	self.PLAYER_REGEN_ENABLED_pause = true
	C_Timer.After(5, function()
			E.Collect_All_Quests()
			E.Collect_All_UNIVERSALQuestUpdate()
			E.Collect_All_BfA_Island()
			E.Collect_All_Reputations()
			E.Collect_All_Currency()
			E:func_Update("PLAYER_REGEN_ENABLED")
			self.PLAYER_REGEN_ENABLED_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:ENCOUNTER_END()
	if InCombatLockdown() or self.ENCOUNTER_END_pause then return end
	self.ENCOUNTER_END_pause = true
	C_Timer.After(1, function()
			E.Collect_All_JournalInstance()
			E:func_Update("ENCOUNTER_END")
			self.ENCOUNTER_END_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:UPDATE_INSTANCE_INFO()
	if InCombatLockdown() or self.UPDATE_INSTANCE_INFO_pause then return end
	self.UPDATE_INSTANCE_INFO_pause = true
	C_Timer.After(1, function()
			E.Collect_All_JournalInstance()
			E:func_Update("UPDATE_INSTANCE_INFO")
			self.UPDATE_INSTANCE_INFO_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end
function Octo_EventFrame_Collect:TIME_PLAYED_MSG(...)
	if InCombatLockdown() then return end
	E.Collect_All_Played(...)
	E:func_Update("TIME_PLAYED_MSG")
end
function Octo_EventFrame_Collect:QUEST_POI_UPDATE()
	if InCombatLockdown() or self.QUEST_POI_UPDATE_pause then return end
	self.QUEST_POI_UPDATE_pause = true
	C_Timer.After(1, function()
			E.Collect_All_Chromie()
			E:func_Update("QUEST_POI_UPDATE")
			self.QUEST_POI_UPDATE_pause = nil-- Используем nil вместо false для экономии памяти
	end)
end

