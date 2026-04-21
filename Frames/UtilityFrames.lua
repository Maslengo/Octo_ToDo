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
-- buttons
------------------------------------------------------------
local function CreateCloseButton(frame, anchor)
	local button = E.func_CreateUtilityButton(
		frame,
		"Interface\\AddOns\\" .. GlobalAddonName .. "\\Media\\Textures\\ICON_CLOSE.tga",

		-- "common-icon-redx",
		-- "decor-controls-exit-active",
		-- "128-RedButton-Exit",
		BUTTON_SIZE-2,
		BUTTON_SIZE-2,
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
	local button = E.func_CreateUtilityButton(
		frame,
		"Interface\\AddOns\\" .. GlobalAddonName .. "\\Media\\IconTexture\\" .. addonIconTexture,
		-- "QuestLog-icon-setting",


		-- "decor-controls-settings-active",
		-- "QuestLog-icon-Expand", -- ПЛЮС
		-- "QuestLog-icon-shrink", -- МИНУС
		18-2,
		18-2,
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
	local button = E.func_CreateUtilityButton(
		frame,
		E.ATLAS_GREATVAULT,
		BUTTON_SIZE-2,
		BUTTON_SIZE-2,
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