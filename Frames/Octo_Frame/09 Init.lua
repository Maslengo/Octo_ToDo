local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------

local function func_SettingsButton_OnClick(button, dataType, old_id, frame)
	local id = E.func_SetType(old_id, dataType)
	local Current_profile = Octo_Todo_DB_Profiles and Octo_Todo_DB_Profiles.KEYS and Octo_Todo_DB_Profiles.KEYS.CURRENT
	if not Current_profile then return end
	local profile = Octo_Todo_DB_Profiles.KEYS.profiles and Octo_Todo_DB_Profiles.KEYS.profiles[Current_profile]
	if not profile then return end
	if not profile[dataType] then
		profile[dataType] = {}
	end
	local settingsTable = profile[dataType]
	local newValue = not settingsTable[id]
	settingsTable[id] = newValue
	local texture = newValue and E.ICON_SETTINGS_GREEN or E.ICON_SETTINGS_RED
	if frame and frame.SettingsTexture then
		frame.SettingsTexture:SetTexture(texture)
	end
end

local function installTEXTURE(frameTexture, frame, ICON)
	local isAtlas = E.func_isAtlas(ICON)
	if isAtlas then
		frameTexture:SetAtlas(ICON, false)
	else
		frameTexture:SetTexture(ICON)
	end
	frame:Show()
end
local function func_Setup_Currencies(frame, id)
	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
	if settingsProfile.CONFIG_CURRENCY_ICON then
		local icon1 = E.func_GetIcon("currency", id)
		installTEXTURE(frame.icon1texture, frame.icon1frame, icon1)
	else
		frame.icon1texture:SetTexture(E.ICON_EMPTY)
		frame.icon1frame:Hide()
	end
	if settingsProfile.CONFIG_CURRENCY_WARBAND_ICON then
		frame.icon2texture:SetAtlas(E.ATLAS_ACCOUNT_WIDE, false)
		if E.func_IsAccountWideCurrency(id) then
			installTEXTURE(frame.icon2texture, frame.icon2frame, E.ATLAS_ACCOUNT_WIDE)
		elseif E.func_IsAccountTransferableCurrency(id) then
			installTEXTURE(frame.icon2texture, frame.icon2frame, E.ATLAS_ACCOUNT_TRANSFERABLE)
		end
	else
		frame.icon2texture:SetTexture(E.ICON_EMPTY)
		frame.icon2frame:Show()
		frame.icon2frame:Hide()
	end
	frame.icon3texture:SetTexture(E.ICON_EMPTY)
	frame.icon3frame:Show()
	frame.icon3frame:Hide()
end
local function func_Setup_Reputations(frame, id)
	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
	if settingsProfile.CONFIG_REPUTATION_ICON then
		installTEXTURE(frame.icon1texture, frame.icon1frame, E.ICON_TABARD)
	else
		frame.icon1texture:SetTexture(E.ICON_EMPTY)
		frame.icon1frame:Hide()
	end
	local AdditionalIcon = settingsProfile.CONFIG_REPUTATION_EXTRA_ICON and E.func_GetReputationIcon(id)
	local ReputationSide = settingsProfile.CONFIG_REPUTATION_FACTION_ICON and E.func_GetReputationSide(id)
	if AdditionalIcon then
		installTEXTURE(frame.icon2texture, frame.icon2frame, AdditionalIcon)
	elseif ReputationSide then
		local icon = E.ICON_QUESTION_MARK
		if ReputationSide == "Horde" then
			icon = E.ICON_HORDE
		elseif ReputationSide == "Alliance" then
			icon = E.ICON_ALLIANCE
		elseif ReputationSide == "Neutral" then
			icon = E.ICON_NEUTRAL
		end
		installTEXTURE(frame.icon2texture, frame.icon2frame, icon)
	else
		frame.icon2texture:SetTexture(E.ICON_EMPTY)
		frame.icon2frame:Hide()
	end
	local warbandICON = settingsProfile.CONFIG_REPUTATION_WARBAND_ICON and E.func_IsAccountWideReputation(id) and E.ATLAS_ACCOUNT_WIDE
	if warbandICON then
		installTEXTURE(frame.icon3texture, frame.icon3frame, warbandICON)
	else
		frame.icon3texture:SetTexture(E.ICON_EMPTY)
		frame.icon3frame:Hide()
	end
end
local function func_Setup_Items(frame, id)
	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
	local icon1 = E.func_GetIcon("item", id)
	if settingsProfile.CONFIG_ITEMS_ICON then
		frame.icon1texture:SetTexture(icon1)
		frame.icon1frame:Show()
	else
		frame.icon1texture:SetTexture(E.ICON_EMPTY)
		frame.icon1frame:Hide()
	end
end
local function func_Setup_Quests(frame, id)
	local icon1 = E.func_GetIcon("quest", id)
end
local function func_Setup_Raids(frame, id)
	local settingsProfile = E.func_GetProfile_SETTINGS_CURRENT()
	local icon = E.func_GetIcon("dungeon", id)
	local isRaid = E.func_DungeonOrRaid(id)
	if settingsProfile.CONFIG_RAIDS_ICON then
		frame.icon1texture:SetTexture(icon)
	else
		frame.icon1texture:SetTexture(E.ICON_EMPTY)
		frame.icon1frame:Hide()
	end
	if settingsProfile.CONFIG_RAIDS_EXTRA_ICON then
		if isRaid == true then
			frame.icon2frame:Show()
			frame.icon2texture:SetAtlas(E.ATLAS_RAID)
		elseif isRaid == false then
			frame.icon2frame:Show()
			frame.icon2texture:SetAtlas(E.ATLAS_DUNGEON)
		end
	else
		frame.icon2texture:SetTexture(E.ICON_EMPTY)
		frame.icon2frame:Hide()
	end
end
local function func_Setup_UniversalQuests(frame, id)
	local IconLeft
	local info = E.UniversalQuestMap[id]
	if info then
		local reset = info.reset
		if info.isAccount then
			IconLeft = E.ICON_QUESTWEEKLY_ACCOUNT
		else
			IconLeft = E.RESET_INFO[reset].icon
		end
	end
	if IconLeft then
		frame.icon3texture:SetAtlas(IconLeft, false)
		frame.icon3frame:Show()
		frame.icon1frame:Hide()
	else
		frame.icon3texture:SetTexture(E.ICON_EMPTY)
		frame.icon3frame:Hide()
	end
end
----------------------------------------------------------------
local function func_Setup_Maps(frame, id)
	local IconLeft = E.func_GetIcon("map", id)
	if IconLeft then
		E.func_SetupTextureToFrame(frame.icon1texture, IconLeft)
		frame.icon1frame:Show()
	else
		frame.icon1texture:SetTexture(E.ICON_EMPTY)
		frame.icon1frame:Hide()
	end
end
----------------------------------------------------------------

function E.func_InitCenter(frame, node)
	local frameData = node:GetData()
	local rowIndex = node.rowIndex or 0
	for i = 1, (frameData.totalColumns or 0) do
		local columnFrame = frame.columnFrames[i]
		if columnFrame and columnFrame.zebraBG_RIGHT then
			if (E.PROFTBL and E.PROFTBL.CONFIG_ZEBRA_MODE or 0) == 1 then
				local r, g, b, a = E.GetZebraColor(rowIndex, 1)
				columnFrame.zebraBG_RIGHT:SetColorTexture(r, g, b, a)
				columnFrame.zebraBG_RIGHT:Show()
			elseif (E.PROFTBL and E.PROFTBL.CONFIG_ZEBRA_MODE or 0) == 2 then
				local r, g, b, a = E.GetZebraColor(i, 2)
				columnFrame.zebraBG_RIGHT:SetColorTexture(r, g, b, a)
				columnFrame.zebraBG_RIGHT:Show()
			else
				columnFrame.zebraBG_RIGHT:Hide()
			end
		end
	end
	if not frameData.SettingsType then
		for i = 1, (frameData.totalColumns or 0) do
			local columnFrames = frame.columnFrames[i]
			if not columnFrames then
				columnFrames = frame.columnFrames[i]
			end
			columnFrames.TextCenter:SetText(frameData.TextCenter[i])
			columnFrames:Show()
			columnFrames:SetScript("OnEnter", function()
					columnFrames.tooltip = nil
			end)
			columnFrames.ReputationBackground:Hide()
		end
	else
		local dataType, old_id = ("#"):split(frameData.SettingsType)
		local id = E.func_SetType(old_id, dataType)
		local accumulatedWidth = 0
		local columnWidthsCenter = E.columnWidthsCenter or {}
		for i = 1, (frameData.totalColumns or 0) do
			local columnFrames = frame.columnFrames[i]
			if not columnFrames then
				columnFrames = frame.columnFrames[i]
			end
			columnFrames:ClearAllPoints()
			columnFrames:SetPoint("TOPLEFT", frame, "TOPLEFT", accumulatedWidth, 0)
			local columnWidth = columnWidthsCenter[i] or E.MIN_COLUMN_WIDTH_CENTER
			columnFrames:SetWidth(columnWidth)
			accumulatedWidth = accumulatedWidth + columnWidth
			if frameData.TextCenter and frameData.TextCenter[i] then
				local TextCenter = frameData.TextCenter[i]
				columnFrames.ReputationBackground:Hide()
				if frameData.ColorCenter and frameData.ColorCenter[i] then
					local r1, g1, b1, a1 = E.func_Hex2RGBA(frameData.ColorCenter[i])
					columnFrames.ReputationBackground:Show()
					columnFrames.ReputationBackground:SetVertexColor(r1, g1, b1, a1)
					if dataType == "Reputations" and frameData.FirstReputation and tonumber(frameData.FirstReputation[i]) ~= 0 then
						local FirstReputation = tonumber(frameData.FirstReputation[i])
						local SecondReputation = tonumber(frameData.SecondReputation[i])
						if FirstReputation == SecondReputation then
							columnFrames.ReputationBackground:SetWidth(columnWidth)
						elseif FirstReputation >= 1 then
							columnFrames.ReputationBackground:SetWidth(columnWidth/SecondReputation*FirstReputation)
						end
					elseif dataType == "Reputations" and frameData.FirstReputation and tonumber(frameData.FirstReputation[i]) == 0 then
						columnFrames.ReputationBackground:Hide()
					else
						columnFrames.ReputationBackground:SetWidth(columnWidth)
					end
				end
				columnFrames.TextCenter:SetText(TextCenter)
				if frameData.totalColumns > 1 and i == frameData.currentCharacterIndex then
					local r, g, b, a = E.func_DB_CHARLINE_COLOR()
					columnFrames.CurrentCharBackground:SetVertexColor(r, g, b, a)
					columnFrames.CurrentCharBackground:Show()
				else
					columnFrames.CurrentCharBackground:Hide()
				end
			else
				columnFrames.TextCenter:SetText("")
				columnFrames.ReputationBackground:SetVertexColor(0, 0, 0, 0)
				columnFrames.CurrentCharBackground:Hide()
			end
			columnFrames:SetScript("OnEnter", function()
					if frameData.SettingsType and frameData.GUID[i] then
						columnFrames.tooltip = E.func_KeyTooltip_RIGHT(frameData.GUID[i], frameData.SettingsType)
					else
						columnFrames.tooltip = nil
					end
					E.SafeTooltipShow(columnFrames)
			end)
			columnFrames:Show()
		end
		for i = frameData.totalColumns + 1, #frame.columnFrames do
			frame.columnFrames[i]:Hide()
		end
	end
end







function E.func_InitLEFT(frame, node)
	local frameData = node:GetData()
	local rowIndex = node.rowIndex or 0
	frame.zebraBG_LEFT:Hide()
	if frame.zebraBG_LEFT then
		if (E.PROFTBL and E.PROFTBL.CONFIG_ZEBRA_MODE or 0) == 1 then
			local r, g, b, a = E.GetZebraColor(rowIndex, 1)
			frame.zebraBG_LEFT:SetColorTexture(r, g, b, a)
			frame.zebraBG_LEFT:Show()
		end
	end
	if E.columnWidthsLeft and E.columnWidthsLeft[1] then
		local newLeftWidth = math.max(E.MIN_COLUMN_WIDTH_LEFT, E.columnWidthsLeft[1])
		local MAIN_FRAME = E.FRAMES[E.MAIN_FRAME_NAME]
		MAIN_FRAME.ScrollBoxLEFT:SetWidth(newLeftWidth + E.INDENT_TEXT)
		if MAIN_FRAME.Octo_SearchBox then
			-- MAIN_FRAME.Octo_SearchBox:SetSize(newLeftWidth - E.INDENT_TEXT - 40, 22)
			MAIN_FRAME.Octo_SearchBox:SetSize(newLeftWidth - E.INDENT_TEXT - 40, E.GLOBAL_LINE_HEIGHT)
			MAIN_FRAME.Octo_SearchBox:SetPoint("LEFT", E.INDENT_TEXT + 30, -E.HEADER_TEXT_OFFSET)
		end
		frame.TextLeft:SetWidth(newLeftWidth)
	end
	if not frameData.SettingsType then
		frame.SettingsButton:Show()
		frame.SettingsButton:Hide()
		frame.icon1frame:Show()
		frame.icon2frame:Show()
		frame.icon3frame:Show()
		frame.icon2frame:Hide()
		frame.icon3frame:Hide()
		frame.TextLeft:SetText("")
		frame.icon1texture:SetTexture(E.ICON_EMPTY)
		frame:SetScript("OnEnter", function()
				frame.tooltip = nil
		end)
	else
		local dataType, old_id = ("#"):split(frameData.SettingsType)
		local id = E.func_SetType(old_id, dataType)
		frame.SettingsButton:Show()
		frame.icon1frame:Show()
		frame.icon2frame:Show()
		frame.icon3frame:Show()
		frame.SettingsButton:Hide()
		frame.icon2frame:Hide()
		frame.icon3frame:Hide()
		if frameData.IconLeft then
			if E.func_isAtlas and E.func_isAtlas(frameData.IconLeft) then
				frame.icon1texture:SetAtlas(frameData.IconLeft, false)
			else
				frame.icon1texture:SetTexture(frameData.IconLeft)
			end
		else
			frame.icon1texture:SetTexture(E.ICON_EMPTY)
		end
		if dataType == "Currencies" then
			func_Setup_Currencies(frame, id)
		end
		if dataType == "Quests" then
			func_Setup_Quests(frame, id)
		end
		if dataType == "Items" then
			func_Setup_Items(frame, id)
		end
		if dataType == "Reputations" then
			func_Setup_Reputations(frame, id)
		end
		if dataType == "RaidsOrDungeons" then
			func_Setup_Raids(frame, id)
		end
		if dataType == "UniversalQuests" then
			func_Setup_UniversalQuests(frame, id)
		end
		if dataType == "Maps" then
			func_Setup_Maps(frame, id)
		end
		if Octo_Todo_DB_Profiles.KEYS.isSettingsEnabled then
			local texture = E.ICON_EMPTY
			if Octo_Todo_DB_Profiles.KEYS.profiles[Octo_Todo_DB_Profiles.KEYS.CURRENT][dataType] and Octo_Todo_DB_Profiles.KEYS.profiles[Octo_Todo_DB_Profiles.KEYS.CURRENT][dataType][id] ~= nil then
				if Octo_Todo_DB_Profiles.KEYS.profiles[Octo_Todo_DB_Profiles.KEYS.CURRENT][dataType][id] or Octo_Todo_DB_Profiles.KEYS.profiles[Octo_Todo_DB_Profiles.KEYS.CURRENT][dataType][tonumber(id)] then
					texture = E.ICON_SETTINGS_GREEN
				else
					texture = E.ICON_SETTINGS_RED
				end
			end
			frame.SettingsTexture:SetTexture(texture)
			frame.SettingsButton:Show()
		else
			frame.SettingsButton:Hide()
		end
		frame.SettingsButton:SetScript("OnClick", function(self)
				func_SettingsButton_OnClick(self, dataType, id, frame)
		end)
		if type(frameData.TextLeft) == "function" then
			frame.TextLeft:SetText(frameData.TextLeft())
		else
			frame.TextLeft:SetText(frameData.TextLeft)
		end
		if frameData.ColorLeft then
			local r, g, b = E.func_Hex2RGBA(frameData.ColorLeft)
			frame.TextureLeft:SetVertexColor(r, g, b, E.LEFT_TEXTURE_ALPHA)
			frame.TextureLeft:Show()
		else
			frame.TextureLeft:Hide()
		end
		frame:SetScript("OnEnter", function()
				if frameData.SettingsType then
					frame.tooltip = E.func_KeyTooltip_LEFT(frameData.SettingsType)
				else
					frame.tooltip = nil
				end
				E.SafeTooltipShow(frame, {"RIGHT", "LEFT"})
		end)
	end
end