local GlobalAddonName, E = ...
local EventFrame = CreateFrame("FRAME")
local L = E.L
local HEIGHT = 20
local WIDTH = 20
local GetInfo = GetInfo or C_QuestLog.GetInfo
local SetSelectedQuest = SetSelectedQuest or C_QuestLog.SetSelectedQuest
local SetAbandonQuest = SetAbandonQuest or C_QuestLog.SetAbandonQuest
local AbandonQuest = AbandonQuest or C_QuestLog.AbandonQuest
local GetNumQuestLogEntries = GetNumQuestLogEntries or C_QuestLog.GetNumQuestLogEntries
local utilityFrames = {
	buttons = {},
	framerate = nil
}
local function CreateUtilButton(name, frame, texture, size, func_onEnter, func_onClick)
	local button = utilityFrames.buttons[name]
	if not button then
		button = CreateFrame("Button", E.MainAddonName..name, UIParent)
		button:SetSize(size, size)
		if texture then
			button.icon = button:CreateTexture(nil, "BACKGROUND")
			button.icon:SetTexture(texture)
			button.icon:SetAtlas(texture)
			button.icon:SetAllPoints()
		end
		button:SetScript("OnMouseDown", function(self)
				if self.icon then
					self.icon:SetAlpha(0.7)
				end
		end)
		button:SetScript("OnMouseUp", function(self)
				if self.icon then
					self.icon:SetAlpha(1)
				end
		end)
		button:SetScript("OnLeave", function(self)
				if self.icon then
					self.icon:SetAlpha(1)
				end
		end)
		utilityFrames.buttons[name] = button
	end
	if func_onEnter then
		button:SetScript("OnEnter", function(self)
				button.tooltip = func_onEnter()
				E.func_OctoTooltip_OnEnter(button, {"BOTTOMLEFT", "TOPRIGHT"})
		end)
	end
	if func_onClick then
		button:SetScript("OnClick", function()
				func_onClick()
				button.tooltip = nil
		end)
	end
	return button
end
local utilityButtonsOrder = {
	"CloseButton",
	"OptionsButton",
	"GreatVaultButton"
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
				button:SetPoint("RIGHT", prevButton, "LEFT", -4, 0)
			end
			prevButton = button
			button:Show()
		end
	end
end
function EventFrame:Octo_CloseButton(frame)
	local button = CreateUtilButton(
		"CloseButton",
		frame,
		"Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Textures\\Close.tga",
		20,
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
		18,
		func_onEnter,
		func_onClick
	)
end
function EventFrame:Octo_GreatVaultButton(frame)
	local function func_onEnter()
		if not C_AddOns.IsAddOnLoaded("Blizzard_WeeklyRewards") then
			C_AddOns.LoadAddOn("Blizzard_WeeklyRewards")
		end
		return {{E.classColorHexCurrent..RATED_PVP_WEEKLY_VAULT.."|r"}}
	end
	local function func_onClick()
		if not C_AddOns.IsAddOnLoaded("Blizzard_WeeklyRewards") then
			C_AddOns.LoadAddOn("Blizzard_WeeklyRewards")
		end
		if WeeklyRewards_ShowUI then
			WeeklyRewards_ShowUI()
		end
	end
	CreateUtilButton(
		"GreatVaultButton",
		frame,
		"greatVault-whole-normal",
		20,
		func_onEnter,
		func_onClick
	)
end
function E.func_CreateUtilsButton(frame, addonIconTexture)
	if not utilityFrames.initialized then
		EventFrame:Octo_CloseButton(frame)
		EventFrame:Octo_OptionsButton(frame, addonIconTexture)
		EventFrame:Octo_GreatVaultButton(frame)
		utilityFrames.initialized = true
	end
	frame:HookScript("OnShow", function()
			AttachUtilityFrames(frame)
	end)
	if frame:IsShown() then
		AttachUtilityFrames(frame)
	end
end
local MyEventsTable = {
	"VARIABLES_LOADED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:VARIABLES_LOADED()
	C_Timer.After(0, function()
			for i, frame in ipairs(E.OctoTable_Frames_ICONS) do
				E.func_CreateUtilsButton(frame, "ToDo")
			end
	end)
end