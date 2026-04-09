local GlobalAddonName, E = ...
local L = E.L
local EventFrame = CreateFrame("FRAME")
------------------------------------------------------------
-- constants
------------------------------------------------------------
local BUTTON_SIZE = 20
local BUTTON_SPACING = 4
------------------------------------------------------------
-- helpers
------------------------------------------------------------
local function CreateUtilityButton(parent, name, texture, size, tooltipFunc, clickFunc)
	local button = CreateFrame("BUTTON", nil, parent)
	button:SetSize(size, size)
	button.icon = button:CreateTexture(nil, "BACKGROUND")
	button.icon:SetAllPoints()
	-- atlas or texture path
	if texture:find("\\") then
		button.icon:SetTexture(texture)
	else
		button.icon:SetAtlas(texture)
	end
	button:SetScript("OnMouseDown", function(self)
			self.icon:SetAlpha(0.7)
	end)
	button:SetScript("OnMouseUp", function(self)
			self.icon:SetAlpha(1)
	end)
	button:SetScript("OnLeave", function(self)
			self.icon:SetAlpha(1)
			self.tooltip = nil
	end)
	if tooltipFunc then
		button:SetScript("OnEnter", function(self)
				self.tooltip = tooltipFunc()
				E.func_Octo_TooltipFrame_OnEnter(self, { "BOTTOMLEFT", "TOPRIGHT" })
		end)
	end
	if clickFunc then
		button:SetScript("OnClick", function(self)
				clickFunc(self)
				self.tooltip = nil
		end)
	end
	return button
end
------------------------------------------------------------
-- buttons
------------------------------------------------------------
local function CreateCloseButton(frame, anchor)
	local button = CreateUtilityButton(
		frame,
		"CloseButton",

		"Interface\\AddOns\\" .. GlobalAddonName .. "\\Media\\Textures\\Close.tga",

		-- "common-icon-redx",
		-- "decor-controls-exit-active",
		-- "128-RedButton-Exit",
		BUTTON_SIZE,
		function()
			return { { E.classColorHexCurrent .. L["CLOSE"] .. "|r" } }
		end,
		function(self)
			local parent = self:GetParent()
			if parent then
				parent:Hide()
			end
		end
	)
	button:SetPoint("BOTTOMRIGHT", anchor, "TOPRIGHT", 0, 0)
	return button
end
local function CreateOptionsButton(frame, anchor, addonIconTexture)
	local button = CreateUtilityButton(
		frame,
		"OptionsButton",

		"Interface\\AddOns\\" .. GlobalAddonName .. "\\Media\\IconTexture\\" .. addonIconTexture,
		-- "QuestLog-icon-setting",


		-- "decor-controls-settings-active",
		-- "QuestLog-icon-Expand", -- ПЛЮС
		-- "QuestLog-icon-shrink", -- МИНУС
		18,
		function()
			return { { E.classColorHexCurrent .. L["OPTIONS"] .. "|r" } }
		end,
		function()
			E.func_OpenToCategory(frame)
		end
	)
	button:SetPoint("RIGHT", anchor, "LEFT", -BUTTON_SPACING, 0)
	return button
end
local function CreateGreatVaultButton(frame, anchor)
	local button = CreateUtilityButton(
		frame,
		"GreatVaultButton",
		E.ATLAS_GREATVAULT,
		BUTTON_SIZE,
		function()
			if InCombatLockdown() then
				return { { ERR_NOT_IN_COMBAT } }
			end
			return { { E.classColorHexCurrent .. L["RATED_PVP_WEEKLY_VAULT"] .. "|r" } }
		end,
		function()
			if InCombatLockdown() then
				return
			end
			if not E.func_IsAddOnLoaded("Blizzard_WeeklyRewards") then
				E.func_LoadAddOn("Blizzard_WeeklyRewards")
			end
			E.func_WeeklyRewards_ShowUI()
		end
	)
	button:SetPoint("RIGHT", anchor, "LEFT", -BUTTON_SPACING, 0)
	return button
end
------------------------------------------------------------
-- public API
------------------------------------------------------------
function E.func_CreateUtilsButton(frame, addonIconTexture)
	if frame.__OctoUtilityButtons then
		return
	end
	frame.__OctoUtilityButtons = true
	local closeButton = CreateCloseButton(frame, frame)
	local optionsButton = CreateOptionsButton(frame, closeButton, addonIconTexture)
	CreateGreatVaultButton(frame, optionsButton)
end
------------------------------------------------------------
-- init
------------------------------------------------------------
local MyEventsTable = {
	"VARIABLES_LOADED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:VARIABLES_LOADED()
	C_Timer.After(0, function()
			for _, frame in ipairs(E.OctoTable_Frames_ICONS) do
				E.func_CreateUtilsButton(frame, GlobalAddonName)
			end
			CreateCloseButton(Octo_EquipmentsFrame, Octo_EquipmentsFrame)
	end)
end