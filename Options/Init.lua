local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
local scale = WorldFrame:GetWidth() / GetPhysicalScreenSize() / UIParent:GetScale()
E.BUTTON_HEIGHT = 26
local BUTTON_WIDTH = 220
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
EventFrame:Hide()
----------------------------------------------------------------
----------------------------------------------------------------

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local icon = E.func_texturefromIcon(C_AddOns.GetAddOnMetadata(GlobalAddonName, "IconTexture"))
local SettingListHeaderName = E.func_GetAddOnMetadata(E.MainAddonName, "Title")
local vesrion = E.COLOR_GRAY.." ".. C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version").."|r"

local category1name = SettingListHeaderName
local category2name = COLORS
local category3name = "category3name"
----------------------------------------------------------------
local category1, layout1 = Settings.RegisterVerticalLayoutCategory(category1name)
Settings.RegisterAddOnCategory(category1)
local parentCategory = category1
----------------------------------------------------------------
-- OPEN CONFIG
----------------------------------------------------------------
function EventFrame:openConfig()
	if SettingsPanel:IsVisible() and self:IsVisible() then
		if InCombatLockdown() then return end
		HideUIPanel(SettingsPanel)
	else
		Settings.OpenToCategory(category1:GetID(), GlobalAddonName)
	end
end
function E.openConfig()
	EventFrame:openConfig()
end
SLASH_CALENDARTOOLTIPCONFIG1 = "/octosettings"
SlashCmdList["CALENDARTOOLTIPCONFIG"] = function() EventFrame:openConfig() end
----------------------------------------------------------------
local MyEventsTable = {
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	Octo_Options = Octo_Options or {}
	----------------------------------------------------------------
	-- 1 -----------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable then
			local category, layout = category1, layout1
			E.func_option_FONT(category, layout)
			E.func_option_OTHER(category, layout)
			E.func_option_TOOLTIP(category, layout)
			E.func_option_CHARACTER(category, layout)
			E.func_option_DEBUG(category, layout)
		end
	end
	----------------------------------------------------------------
	-- 2 -----------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable then

			local width = E.FOURTH_WIDTH
			-- local category3, layout3 = Settings.RegisterVerticalLayoutSubcategory(parentCategory, category3name)
			-- local category, layout = category3, layout3
			-- E.func_option_COLOR_PROFILE(category, layout)
			-- E.func_option_COLOR_MAIN(category, layout)
			if E.func_option_2_COLOR then
				local parent = E.func_GetAddOnMetadata(E.MainAddonName, "Title")
				local leftText = COLORS
				local rightText = COLORS
				AceConfigRegistry:RegisterOptionsTable(leftText, E.func_option_2_COLOR(width, rightText))
				AceConfigDialog:AddToBlizOptions(leftText, leftText, category1:GetID())
			end



		end
	end
	----------------------------------------------------------------
	-- 3 -----------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = false
		if enable then
			local category2, layout2 = Settings.RegisterVerticalLayoutSubcategory(parentCategory, category2name)
			local category, layout = category2, layout2
			E.func_option_COLOR_PROFILE(category, layout)
			E.func_option_COLOR_MAIN(category, layout)
		end
	end

	----------------------------------------------------------------

end
----------------------------------------------------------------