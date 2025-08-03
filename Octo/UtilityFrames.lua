local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local Octo_Event_UtilityFrames = CreateFrame("FRAME")
Octo_Event_UtilityFrames:Hide()

-- Constants
local HEIGHT = 20
local WIDTH = 20

-- Fallback to C_QuestLog if direct functions aren't available
local GetInfo = GetInfo or C_QuestLog.GetInfo
local SetSelectedQuest = SetSelectedQuest or C_QuestLog.SetSelectedQuest
local SetAbandonQuest = SetAbandonQuest or C_QuestLog.SetAbandonQuest
local AbandonQuest = AbandonQuest or C_QuestLog.AbandonQuest
local GetNumQuestLogEntries = GetNumQuestLogEntries or C_QuestLog.GetNumQuestLogEntries

-- Main utility frames storage
local utilityFrames = {
	buttons = {},
	framerate = nil
}

--[[
	Creates a utility button with specified properties
	@param name - Unique identifier for the button
	@param frame - Parent frame
	@param xOffset - X offset position
	@param texture - Button texture path
	@param func_onEnter - Function to call on mouse enter (tooltip)
	@param func_onClick - Function to call on click
	@return The created button
]]
local function CreateUtilButton(name, frame, xOffset, texture, func_onEnter, func_onClick)
	-- Reuse existing button if available
	local button = utilityFrames.buttons[name]

	if not button then
		button = CreateFrame("Button", E.MainAddonName..name, UIParent)
		button:SetSize(WIDTH, HEIGHT)

		if texture then
			button.icon = button:CreateTexture(nil, "BACKGROUND")
			button.icon:SetTexture(texture)
			button.icon:SetAllPoints()
		end

		utilityFrames.buttons[name] = button
	end

	-- Set tooltip on enter
	if func_onEnter then
		button:SetScript("OnEnter", function(self)
			button.tooltip = func_onEnter()
			E:func_OctoTooltip_OnEnter(button, {"BOTTOMLEFT", "TOPRIGHT"})
		end)
	end

	-- Set click handler
	if func_onClick then
		button:SetScript("OnClick", function()
			func_onClick()
			button.tooltip = nil
		end)
	end

	return button
end

-- Button order for attachment
local utilityButtonsOrder = {
	"CloseButton",
	"OptionsButton",
	"AbandonButton",
	"EventsButton",
}

--[[
	Attaches utility frames to a target frame
	@param targetFrame - The frame to attach utility buttons to
]]
local function AttachUtilityFrames(targetFrame)
	local prevButton = nil

	for i, buttonName in ipairs(utilityButtonsOrder) do
		local button = utilityFrames.buttons[buttonName]
		if button then
			button:SetParent(targetFrame)
			button:ClearAllPoints()

			if i == 1 then
				button:SetPoint("BOTTOMRIGHT", targetFrame, "TOPRIGHT", 0, 0)
			else
				button:SetPoint("RIGHT", prevButton, "LEFT", 0, 0)
			end

			prevButton = button
			button:Show()
		end
	end

	-- Attach framerate display if available
	if utilityFrames.framerate then
		utilityFrames.framerate:SetParent(targetFrame)
		utilityFrames.framerate:ClearAllPoints()
		utilityFrames.framerate:SetPoint("RIGHT", prevButton, "LEFT", 0, 0)
		utilityFrames.framerate:Show()
	end
end

--[[
	Creates the close button
	@param frame - Parent frame
]]
function Octo_Event_UtilityFrames:Octo_CloseButton(frame)
	local button = CreateUtilButton(
		"CloseButton",
		frame,
		0,
		"Interface\\AddOns\\"..GlobalAddonName.."\\Media\\CloseTest.tga",
		function() return {{E.classColorHexCurrent..CLOSE.."|r"}} end,
		nil
	)

	button:SetScript("OnClick", function(self)
		local parent = self:GetParent()
		if parent then
			parent:Hide()
		end
		self.tooltip = nil
	end)
end

--[[
	Creates the options button
	@param frame - Parent frame
	@param addonIconTexture - Texture path for the button icon
]]
function Octo_Event_UtilityFrames:Octo_OptionsButton(frame, addonIconTexture)
	local function func_onEnter()
		return {{E.classColorHexCurrent..OPTIONS.."|r"}}
	end

	local function func_onClick()
		local parent = self:GetParent()
		if parent and parent:IsShown() then
			parent:Hide()
		end

		if SettingsPanel:IsVisible() then
			HideUIPanel(SettingsPanel)
		else
			Settings.OpenToCategory(E:func_AddonTitle(E.MainAddonName), true)
		end
	end

	CreateUtilButton(
		"OptionsButton",
		frame,
		-WIDTH,
		"Interface\\AddOns\\"..GlobalAddonName.."\\Media\\IconTexture\\"..addonIconTexture,
		func_onEnter,
		func_onClick
	)
end

--[[
	Creates the abandon quest button
	@param frame - Parent frame
]]
function Octo_Event_UtilityFrames:Octo_AbandonButton(frame)
	local function func_onEnter()
		local tooltip = {}
		local numQuests = E:func_CurrentNumQuests()

		if numQuests > 0 then
			tooltip[#tooltip+1] = {E.classColorHexCurrent..L["Abandon All Quests"].."|r".." ("..numQuests..")"}
			tooltip[#tooltip+1] = {" ", " "}

			local list = {}
			for i = 1, GetNumQuestLogEntries() do
				local info = GetInfo(i)
				if info and info.questID ~= 0 and not info.isHeader and not info.isHidden then
					table.insert(list, info.questID)
				end
			end

			table.sort(list, E.func_Reverse_order)

			for _, questID in ipairs(list) do
				tooltip[#tooltip+1] = {E:func_questName(questID), E:func_CheckCompletedByQuestID(questID)}
			end
		else
			tooltip[#tooltip+1] = {E.classColorHexCurrent..L["No quests"].."|r"}
		end

		return tooltip
	end

	local function f_AbandonQuests()
		local numQuests = E:func_CurrentNumQuests()

		for i = 1, GetNumQuestLogEntries() do
			if numQuests ~= 0 then
				local info = GetInfo(i)
				if info and not info.isHeader and not info.isHidden then
					DEFAULT_CHAT_FRAME:AddMessage(E:func_Gradient(L["Abandon: "])..E:func_questName(info.questID))
					SetSelectedQuest(info.questID)
					SetAbandonQuest()
					AbandonQuest()
				end
			end
		end

		DEFAULT_CHAT_FRAME:AddMessage(E:func_Gradient(L["Total"]).." "..E.Green_Color..numQuests.."|r")
	end

	-- Create confirmation dialog
	StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
		text = E.classColorHexCurrent..L["Abandon All Quests"].."?|r",
		button1 = YES,
		button2 = NO,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function() C_Timer.After(1, f_AbandonQuests) end,
	}

	local function func_onClick()
		if E:func_CurrentNumQuests() > 0 then
			StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
		end
	end

	CreateUtilButton(
		"AbandonButton",
		frame,
		-WIDTH*2,
		"Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Arrow72.tga",
		func_onEnter,
		func_onClick
	)
end

--[[
	Creates the events button
	@param frame - Parent frame
]]
function Octo_Event_UtilityFrames:Octo_EventsButton(frame)
	local function func_onEnter()
		wipe(E.Holiday)
		E.Collect_All_Holiday()

		local tooltip = {}
		local curdatetable = date("*t")
		local curdate = FormatShortDate(curdatetable.day, curdatetable.month, curdatetable.year)

		tooltip[#tooltip+1] = {E.classColorHexCurrent..L["Current Date"].."|r", E.classColorHexCurrent..curdate.."|r"}

		local sorted = {}
		for k in pairs(E.Holiday) do
			table.insert(sorted, k)
		end

		table.sort(sorted, function(a, b)
			return E.Holiday[a].priority < E.Holiday[b].priority
		end)

		for _, eventKey in ipairs(sorted) do
			local v = E.Holiday[eventKey]
			local titleText = E:func_texturefromIconEVENT(v.iconTexture)
			local timeText = v.startTime.." - "..v.endTime

			if v.Active then
				titleText = titleText..E.Green_Color..v.title.."|r"..E.White_Color.." ("..v.ENDS..")|r"
				timeText = E.Green_Color..timeText.."|r"
			else
				titleText = titleText..E.Gray_Color..v.title.."|r"
				timeText = E.Gray_Color..timeText.."|r"
			end

			if E.DebugIDs then
				titleText = titleText..E.Gray_Color.." id:"..v.eventID.."|r"
			end

			tooltip[#tooltip+1] = {titleText, timeText}
		end

		return tooltip
	end

	local function func_onClick()
		local parent = self:GetParent()
		if parent then
			parent:Hide()
		end

		if fpde then fpde(E.Holiday) end
	end

	CreateUtilButton(
		"EventsButton",
		frame,
		-WIDTH*3,
		"Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Arrow6.tga",
		func_onEnter,
		func_onClick
	)
end

--[[
	Creates the framerate display frame
	@param frame - Parent frame
]]
function Octo_Event_UtilityFrames:Octo_FramerateFrame(frame)
	if not utilityFrames.framerate then
		local Octo_FramerateFrame = CreateFrame("Frame", nil, UIParent)
		Octo_FramerateFrame:Hide()
		Octo_FramerateFrame:SetSize(WIDTH*2, HEIGHT)
		Octo_FramerateFrame:SetFrameStrata("HIGH")

		local text_fps = Octo_FramerateFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		text_fps:SetAllPoints()
		text_fps:SetFontObject(OctoFont11)
		text_fps:SetJustifyH("CENTER")

		Octo_FramerateFrame.ticker = nil
		Octo_FramerateFrame.isTickerActive = false

		local function UpdateFPS()
			local FPS = math.floor(GetFramerate() * 10) / 10

			if FPS >= 144 then
				text_fps:SetTextColor(0, 1, 1, 1)
			elseif FPS >= 60 then
				text_fps:SetTextColor(0.31, 1, 0.47, 1)
			else
				text_fps:SetTextColor(1, 0, 0, 1)
			end

			text_fps:SetText(FPS)
		end

		local function StartTicker()
			if not Octo_FramerateFrame.isTickerActive then
				Octo_FramerateFrame.ticker = C_Timer.NewTicker(.4, UpdateFPS)
				Octo_FramerateFrame.isTickerActive = true
			end
		end

		local function StopTicker()
			if Octo_FramerateFrame.isTickerActive and Octo_FramerateFrame.ticker then
				Octo_FramerateFrame.ticker:Cancel()
				Octo_FramerateFrame.ticker = nil
				Octo_FramerateFrame.isTickerActive = false
			end
		end

		Octo_FramerateFrame:SetScript("OnShow", StartTicker)
		Octo_FramerateFrame:SetScript("OnHide", StopTicker)

		if Octo_FramerateFrame:IsShown() then
			StartTicker()
		end

		utilityFrames.framerate = Octo_FramerateFrame
	end
end

--[[
	Creates all utility buttons for a frame
	@param frame - Target frame to attach buttons to
	@param addonIconTexture - Texture path for options button
]]
function E:func_CreateUtilsButton(frame, addonIconTexture)
	if not utilityFrames.initialized then
		Octo_Event_UtilityFrames:Octo_CloseButton(frame)
		Octo_Event_UtilityFrames:Octo_OptionsButton(frame, addonIconTexture)
		Octo_Event_UtilityFrames:Octo_AbandonButton(frame)
		Octo_Event_UtilityFrames:Octo_EventsButton(frame)
		Octo_Event_UtilityFrames:Octo_FramerateFrame(frame)
		utilityFrames.initialized = true
	end

	frame:HookScript("OnShow", function()
		AttachUtilityFrames(frame)
	end)

	if frame:IsShown() then
		AttachUtilityFrames(frame)
	end
end

-- Event registration
local MyEventsTable = {
	"ADDON_LOADED",
}

E:func_RegisterMyEventsToFrames(Octo_Event_UtilityFrames, MyEventsTable)

--[[
	Handles ADDON_LOADED event
	@param addonName - Name of the loaded addon
]]
function Octo_Event_UtilityFrames:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil

	C_Timer.After(0, function()
		for i, frame in ipairs(E.OctoTable_Frames) do
			E:func_CreateUtilsButton(frame, "ToDo")
		end
	end)
end