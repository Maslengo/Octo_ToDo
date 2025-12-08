local GlobalAddonName, E = ...
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
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
local function CreateUtilButton(name, frame, texture, func_onEnter, func_onClick)
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
			E.func_OctoTooltip_OnEnter(button, {"BOTTOMLEFT", "TOPRIGHT"})
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
}
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
				button:SetPoint("RIGHT", prevButton, "LEFT", -2, 0)
			end
			prevButton = button
			button:Show()
		end
	end
	-- Attach framerate display if available
	if utilityFrames.framerate then
		utilityFrames.framerate:SetParent(targetFrame)
		utilityFrames.framerate:ClearAllPoints()
		utilityFrames.framerate:SetPoint("RIGHT", prevButton, "LEFT", -4, 0)
		utilityFrames.framerate:Show()
	end
end
function EventFrame:Octo_CloseButton(frame)
	local button = CreateUtilButton(
		"CloseButton",
		frame,
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
function EventFrame:Octo_OptionsButton(frame, addonIconTexture)
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
			Settings.OpenToCategory(E.func_GetAddOnMetadata(E.MainAddonName, "Title"), true)
		end
	end
	CreateUtilButton(
		"OptionsButton",
		frame,
		"Interface\\AddOns\\"..GlobalAddonName.."\\Media\\IconTexture\\"..addonIconTexture,
		func_onEnter,
		func_onClick
	)
end
function E.func_CreateUtilsButton(frame, addonIconTexture)
	if not utilityFrames.initialized then
		EventFrame:Octo_CloseButton(frame)
		EventFrame:Octo_OptionsButton(frame, addonIconTexture)
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
	"VARIABLES_LOADED",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:VARIABLES_LOADED()
	C_Timer.After(0, function()
		for i, frame in ipairs(E.OctoTable_Frames) do
			E.func_CreateUtilsButton(frame, "ToDo")
		end
	end)
end