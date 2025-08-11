local GlobalAddonName, ns = ...
E = _G.OctoEngine

local EventFrame = CreateFrame("EventFrame") -- FRAME
EventFrame:SetUndefinedEventsAllowed(true)
-- ты разрешаешь этому фрейму регистрировать любые имена событий — даже те, которые клиент не знает на момент загрузки.
EventFrame:Hide()

local LibDBIcon = LibStub("LibDBIcon-1.0", true)
local quests = {}
local new_quests = {}
local new_quests_byid = {}
local session_quests = {}
E.quests_completed = {}
local SPAM_QUESTS = {
	[32468] = true, -- Crystal Clarity
	[32469] = true, -- Crystal Clarity
}
EventFrame:SetScript("OnEvent", function(self, event, ...)
		self:TriggerEvent(event, event, ...)
end)
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:Hide()
E.EventFrame = EventFrame
EventFrame:GenerateCallbackEvents{
	"OnQuestAdded",
	"OnQuestRemoved",
	"OnAllQuestsRemoved",
	"OnVignetteAdded",
	"OnVignetteRemoved",
	"OnAllVignettesRemoved",
}
E.Event = EventFrame.Event
-- help out with callback boilerplate:
function EventFrame:func_RegisterCallback(event, func)
	if not func and E[event] then func = E[event] end
	-- if not EventFrame:DoesFrameHaveEvent(event) then
	-- 	EventFrame:RegisterEvent(event)
	-- end
	-- return EventFrame:func_RegisterCallback(event, func, self)
end
function E:func_TriggerEvent(...)
	return EventFrame:TriggerEvent(...)
end
EventFrame:func_RegisterCallback("ADDON_LOADED", function(self, event, name)
		if name ~= GlobalAddonName then return end
		Octo_QuestsChanged_DB = setmetatable(Octo_QuestsChanged_DB or {}, {
				__index = {
					minimap = false,
					announce = false,
					removed = true,
					showInCompartment=true,
				},
		})
		if not Octo_QuestsChanged_DB.QC_Quests then
			Octo_QuestsChanged_DB.QC_Quests = {}
		end
		if IsLoggedIn() then self:PLAYER_LOGIN() else EventFrame:func_RegisterCallback("PLAYER_LOGIN") end
end)
function E:PLAYER_LOGIN()
	-- Quests
	EventFrame:func_RegisterCallback("QUEST_LOG_UPDATE")
	if C_EventUtils.IsEventValid("ENCOUNTER_LOOT_RECEIVED") then
		EventFrame:func_RegisterCallback("ENCOUNTER_LOOT_RECEIVED")
	end
	if C_QuestLog.GetAllCompletedQuestIDs then
		new_quests = C_QuestLog.GetAllCompletedQuestIDs(new_quests)
		for _, questid in pairs(new_quests) do
			quests[questid] = true
		end
	else
		quests = GetQuestsCompleted()
	end
end
function E:QUEST_LOG_UPDATE()
	EventFrame:Show()
end
E.ENCOUNTER_LOOT_RECEIVED = E.QUEST_LOG_UPDATE
do
	local time_since = 0
	EventFrame:SetScript("OnUpdate", function(self, elapsed)
			time_since = time_since + elapsed
			if time_since < 0.3 then
				return
			end
			E.func_CheckQuests()
			time_since = 0
			self:Hide()
	end)
end
-- E.quest_names = {}
-- setmetatable(E.quest_names, {__index = function(self, key)
-- 			local name = (C_QuestLog.GetTitleForQuestID or C_QuestLog.GetQuestInfo)(key)
-- 			if name then
-- 				self[key] = name
-- 				return name
-- 			end
-- 			return false
-- end,})
function QuestsChangedGetQuestTitle(id)
	-- return E.quest_names[id]
	E.func_questName(id)
end
function E.func_CheckQuests()
	if not quests then
		return
	end
	local mapdata, x, y
	wipe(new_quests_byid)
	if C_QuestLog.GetAllCompletedQuestIDs then
		new_quests = C_QuestLog.GetAllCompletedQuestIDs(new_quests)
		for _, questid in pairs(new_quests) do
			new_quests_byid[questid] = true
		end
	else
		new_quests_byid = GetQuestsCompleted(new_quests_byid)
	end
	for questid in pairs(new_quests_byid) do
		if not quests[questid] and not session_quests[questid] and not SPAM_QUESTS[questid] then
			if not mapdata then
				local mapID = C_Map.GetBestMapForUnit('player')
				if mapID then
					mapdata = C_Map.GetMapInfo(mapID)
					local position = C_Map.GetPlayerMapPosition(mapdata.mapID, 'player')
					if position then
						x, y = position:GetXY()
					end
				end
			end
			local questName = E.func_questName(questid) -- self.quest_names[questid] -- prime it
			local quest = {
				id = questid,
				time = time(),
				mapID = mapdata and mapdata.mapID or 0,
				x = x or 0,
				y = y or 0,
				playerName = E.curCharName,
				curServer = GetRealmName(),
				classColorHex = E.classColorHexCurrent,
				curLocation = E.func_GetCurrentLocation(),
				specIcon = select(4, GetSpecializationInfo(GetSpecialization())),
			}
			table.insert(self.quests_completed, quest)
			table.insert(self.Octo_QuestsChanged_DB.QC_Quests, quest)
			session_quests[questid] = true
			self:TriggerEvent(self.Event.OnQuestAdded, quest, #self.Octo_QuestsChanged_DB.QC_Quests)
		end
		quests[questid] = true
	end
	if Octo_QuestsChanged_DB.removed then
		for questid in pairs(quests) do
			if not new_quests_byid[questid] and not SPAM_QUESTS[questid] then
				quests[questid] = nil
			end
		end
	end
end
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
_G["SLASH_".. GlobalAddonName:upper().."1"] = "/questschanged"
SlashCmdList[GlobalAddonName:upper()] = function(msg)
	msg = msg:trim()
	if msg == "QC_Quests" or msg == "" then
		E.func_ToggleLog()
	elseif msg == "LibDBIcon" then
		if not LibDBIcon then return end
		Octo_QuestsChanged_DB.hide = not Octo_QuestsChanged_DB.hide
		if Octo_QuestsChanged_DB.hide then
			LibDBIcon:Hide(GlobalAddonName)
		else
			LibDBIcon:Show(GlobalAddonName)
		end
	elseif msg == "removed" then
		Octo_QuestsChanged_DB.removed = not Octo_QuestsChanged_DB.removed
	elseif msg == "announce" then
		Octo_QuestsChanged_DB.announce = not Octo_QuestsChanged_DB.announce
	end
end

----------------------------------------------------------------
local dialogConfig = {
	text = E.classColorHexCurrent.."CTRL-C|r|n"..CALENDAR_COPY_EVENT,
	button1 = CLOSE,
	button2 = CANCEL,
	hasEditBox = 1,
	whileDead = 1,
	maxLetters = 0,
	timeout = 0,
	EditBoxOnEscapePressed = StaticPopup_StandardEditBoxOnEscapePressed,
	EditBoxOnEnterPressed = StaticPopup_StandardEditBoxOnEscapePressed,
	hideOnEscape = 1,
	editBoxWidth = 256,
	closeButton = false,
	preferredIndex = 3,
}
----------------------------------------------------------------
-- local editBoxKey = E.interfaceVersion < 110200 and "editBox" or "EditBox"
----------------------------------------------------------------
local STATICPOPUP_NUMDIALOGS = STATICPOPUP_NUMDIALOGS or 1
----------------------------------------------------------------
dialogConfig.OnShow = function(self, data)
	for i = 1, STATICPOPUP_NUMDIALOGS do
		local popup = _G["StaticPopup"..i]
		if not popup then break end
		local editBox = _G["StaticPopup"..i.."EditBox"]
		if editBox:IsShown() then
			if data then
				editBox:SetText(data)
				editBox:HighlightText()
			end
			editBox:SetScript("OnKeyUp", function(self, key)
					if IsControlKeyDown() and key == "C" then
						self:GetParent():Hide()
					end
			end)
		end
	end
end
----------------------------------------------------------------
StaticPopupDialogs["QuestsChanged_CopyBox"] = dialogConfig
----------------------------------------------------------------