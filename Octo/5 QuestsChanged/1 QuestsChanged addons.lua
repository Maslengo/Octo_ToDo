local GlobalAddonName, E = ...
local enable = true
if enable then
	-- print (E.func_Gradient("1 QuestsChanged addons: ")..VIDEO_OPTIONS_ENABLED)
	local icon = LibStub("LibDBIcon-1.0", true)
	E.VIGNETTES = C_EventUtils.IsEventValid("VIGNETTE_MINIMAP_UPDATED")
	local quests = {}
	local new_quests = {}
	local new_quests_byid = {}
	local session_quests = {}
	E.quests_completed = {}
	E.WARBANDS_ICON = CreateAtlasMarkup("warbands-icon", 16, 16)
	local SPAM_QUESTS = {
		[32468] = true, -- Crystal Clarity
		[32469] = true, -- Crystal Clarity
	}
	local Callbacks = CreateFrame("EventFrame")
	Callbacks:SetUndefinedEventsAllowed(true)
	Callbacks:SetScript("OnEvent", function(self, event, ...)
			self:TriggerEvent(event, event, ...)
	end)
	Callbacks:RegisterEvent("ADDON_LOADED")
	Callbacks:Hide()
	E.Callbacks = Callbacks
	Callbacks:GenerateCallbackEvents{
		"OnQuestAdded", "OnQuestRemoved", "OnAllQuestsRemoved",
		"OnVignetteAdded", "OnVignetteRemoved", "OnAllVignettesRemoved",
	}
	E.Event = Callbacks.Event
	-- help out with callback boilerplate:
	function E:RegisterCallback(event, func)
		if not func and E[event] then func = E[event] end
		if not Callbacks:DoesFrameHaveEvent(event) then
			Callbacks:RegisterEvent(event)
		end
		return Callbacks:RegisterCallback(event, func, self)
	end
	function E:UnregisterCallback(event)
		if not Callbacks:DoesFrameHaveEvent(event) then
			Callbacks:UnregisterEvent(event)
		end
		return Callbacks:UnregisterCallback(event, self)
	end
	function E:TriggerEvent(...)
		return Callbacks:TriggerEvent(...)
	end
	E:RegisterCallback("ADDON_LOADED", function(self, event, name)
			if name ~= GlobalAddonName then return end
			Octo_QuestsChangedDB = setmetatable(Octo_QuestsChangedDB or {}, {
					__index = {
						minimap = false,
						announce = false,
						removed = true,
						showInCompartment=true,
					},
			})
			if not Octo_QuestsChangedDB.log then
				Octo_QuestsChangedDB.log = {}
			end
			E.Octo_QuestsChangedDB = Octo_QuestsChangedDB
			if icon then
				icon:Register(GlobalAddonName, E.dataobject, Octo_QuestsChangedDB)
			end
			self:UnregisterCallback("ADDON_LOADED")
			if IsLoggedIn() then self:PLAYER_LOGIN() else self:RegisterCallback("PLAYER_LOGIN") end
	end)
	function E:PLAYER_LOGIN()
		-- Quests
		self:RegisterCallback("QUEST_LOG_UPDATE")
		if C_EventUtils.IsEventValid("ENCOUNTER_LOOT_RECEIVED") then
			self:RegisterCallback("ENCOUNTER_LOOT_RECEIVED")
		end
		self:UnregisterCallback("PLAYER_LOGIN")
		if C_QuestLog.GetAllCompletedQuestIDs then
			new_quests = C_QuestLog.GetAllCompletedQuestIDs(new_quests)
			for _, questid in pairs(new_quests) do
				quests[questid] = true
			end
		else
			quests = GetQuestsCompleted()
		end
		-- Vignettes
		if E.VIGNETTES then
			self:RegisterCallback("PLAYER_ENTERING_WORLD")
			self:RegisterCallback("VIGNETTE_MINIMAP_UPDATED")
			self:RegisterCallback("VIGNETTES_UPDATED")
		end
	end
	function E:QUEST_LOG_UPDATE()
		Callbacks:Show()
	end
	E.ENCOUNTER_LOOT_RECEIVED = E.QUEST_LOG_UPDATE
	do
		local time_since = 0
		Callbacks:SetScript("OnUpdate", function(self, elapsed)
				time_since = time_since + elapsed
				if time_since < 0.3 then
					return
				end
				E:CheckQuests()
				time_since = 0
				self:Hide()
		end)
	end
	E.quest_names = {}
	setmetatable(E.quest_names, {__index = function(self, key)
				local name = (C_QuestLog.GetTitleForQuestID or C_QuestLog.GetQuestInfo)(key)
				if name then
					self[key] = name
					return name
				end
				return false
	end,})
	function QuestsChangedGetQuestTitle(id)
		return E.quest_names[id]
	end
	function E:CheckQuests()
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
				local questName = self.quest_names[questid] -- prime it
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
				table.insert(self.Octo_QuestsChangedDB.log, quest)
				session_quests[questid] = true
				if Octo_QuestsChangedDB.announce then
					self.Print("Quest complete:", questid, questName or UNKNOWN)
				end
				self:TriggerEvent(self.Event.OnQuestAdded, quest, #self.Octo_QuestsChangedDB.log)
			end
			quests[questid] = true
		end
		if Octo_QuestsChangedDB.removed then
			for questid in pairs(quests) do
				if not new_quests_byid[questid] and not SPAM_QUESTS[questid] then
					quests[questid] = nil
					if Octo_QuestsChangedDB.announce then
						self.Print("Quest no longer complete:", questid, self.quest_names[questid] or UNKNOWN)
					end
				end
			end
		end
	end
	function E:RemoveQuest(index)
		if index == 0 then
			table.wipe(self.quests_completed)
			table.wipe(self.Octo_QuestsChangedDB.log)
			self:TriggerEvent(self.Event.OnAllQuestsRemoved)
		else
			local quest
			if type(index) == "table" then
				quest = index
				index = tIndexOf(self.Octo_QuestsChangedDB.log, quest)
				if not index then return end
			else
				quest = self.Octo_QuestsChangedDB.log[index]
			end
			for i, q in ipairs(self.quests_completed) do
				if q.id == quest.id then
					tremove(self.quests_completed, i)
					break
				end
			end
			tremove(self.Octo_QuestsChangedDB.log, index)
			self:TriggerEvent(self.Event.OnQuestRemoved, quest, index)
		end
	end
	local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
	local dataobject = ldb:GetDataObjectByName("QuestsChanged") or ldb:NewDataObject("QuestsChanged", {
			type = "data source",
			label = "QuestsChanged",
			icon = [[Interface\Minimap\Tracking\QuestBlob]],
	})
	dataobject.OnClick = function(frame, button)
		if button == "RightButton" then
			-- clear the current session
			table.wipe(E.quests_completed)
		else
			if IsShiftKeyDown() then
				local data = E.Octo_QuestsChangedDB.log[#E.Octo_QuestsChangedDB.log]
				StaticPopup_Show("QuestsChanged_CopyBox", nil, nil, ("[%d] = {quest=%d, label=\"\"},"):format(
						E.func_GetCoord(data.x, data.y),
						(data.id or "nil")
				))
			else
				E:ToggleLog()
			end
		end
	end
	dataobject.OnTooltipShow = function(tooltip)
		E:CheckQuests() -- in case
		tooltip:AddLine("QuestsChanged")
		for _, quest in ipairs(E.quests_completed) do
			local mapID, level
			if type(quest.mapID) == 'string' then
				-- pre-8.0 quest logging has mapFiles, just show them
				mapID = quest.mapID
				level = quest.level
			else
				mapID, level = E.func_GetMapNameFromID(quest.mapID)
			end
			tooltip:AddDoubleLine(
				("%d: %s %s"):format(
					quest.id, E.quest_names[quest.id] or UNKNOWN,
					C_QuestLog.IsQuestFlaggedCompletedOnAccount and C_QuestLog.IsQuestFlaggedCompletedOnAccount(quest.id) and E.WARBANDS_ICON or ""
				),
				("%s (%s) %.2f, %.2f"):format(quest.mapID, mapID .. (level and (' / ' .. level) or ''), quest.x * 100, quest.y * 100)
			)
		end
		local x, y
		local mapID = C_Map.GetBestMapForUnit('player')
		if mapID then
			local position = C_Map.GetPlayerMapPosition(mapID, 'player')
			if position then
				x, y = position:GetXY()
			end
		end
		local mapname, subname = E.func_GetMapNameFromID(mapID)
		tooltip:AddDoubleLine("Location", ("%s (%s) %.2f, %.2f"):format(mapID or UNKNOWN, mapname .. (subname and (' / ' .. subname) or ''), (x or 0) * 100, (y or 0) * 100), 1, 0, 1, 1, 0, 1)
		tooltip:AddLine("Left-click to show your quest history", 0, 1, 1)
		tooltip:AddLine("Shift-left-click to copy the last quest", 0, 1, 1)
		tooltip:AddLine("Right-click to clear the current session", 0, 1, 1)
	end
	E.dataobject = dataobject
	-- slash
	_G["SLASH_".. GlobalAddonName:upper().."1"] = "/questschanged"
	SlashCmdList[GlobalAddonName:upper()] = function(msg)
		msg = msg:trim()
		if msg == "log" or msg == "" then
			E:ToggleLog()
		elseif msg == "icon" then
			if not icon then return end
			Octo_QuestsChangedDB.hide = not Octo_QuestsChangedDB.hide
			if Octo_QuestsChangedDB.hide then
				icon:Hide(GlobalAddonName)
			else
				icon:Show(GlobalAddonName)
			end
			E.Print("icon", Octo_QuestsChangedDB.hide and "hidden" or "shown")
		elseif msg == "removed" then
			Octo_QuestsChangedDB.removed = not Octo_QuestsChangedDB.removed
			E.Print("watch for removed quests", Octo_QuestsChangedDB.removed and "enabled" or "disabled")
		elseif msg == "announce" then
			Octo_QuestsChangedDB.announce = not Octo_QuestsChangedDB.announce
			E.Print("announce in chat", Octo_QuestsChangedDB.announce and "enabled" or "disabled")
		end
	end
	StaticPopupDialogs["QuestsChanged_CopyBox"] = {
		text = E.classColorHexCurrent.."CTRL-C|r|n"..CALENDAR_COPY_EVENT,
		button1 = CLOSE,
		button2 = CANCEL,
		hasEditBox = 1, -- true
		whileDead = 1, -- true
		maxLetters = 0,
		timeout = 0,
		EditBoxOnEscapePressed = StaticPopup_StandardEditBoxOnEscapePressed,
		EditBoxOnEnterPressed = StaticPopup_StandardEditBoxOnEscapePressed,
		hideOnEscape = 1, -- true
		editBoxWidth = 256,
		closeButton = false,
		preferredIndex = 3,
		OnShow = function(self, data)
			if data then
				self.editBox:SetText(data)
				self.editBox:HighlightText()
			end
			self.editBox:SetScript("OnKeyUp", function(self, key)
					if IsControlKeyDown() and key == "C" then
						self:GetParent():Hide()
					end
			end)
		end,
	}
end