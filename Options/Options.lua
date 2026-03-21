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
local icon = E.func_texturefromIcon(C_AddOns.GetAddOnMetadata(GlobalAddonName, "IconTexture"))
-- local SettingListHeaderName = E.func_GetAddOnMetadata(GlobalAddonName, "Title")
local SettingListHeaderName = E.func_AddonNameForOptions(GlobalAddonName)
local vesrion = E.COLOR_GRAY.." ".. C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version").."|r"
local category1name = SettingListHeaderName
local category2name = CURRENCY -- COLORS
local category3name = DUNGEONS
local category4name = E.COLOR_GRAY..REPUTATION.."|r"
local category5name = "func_option_moduls" -- E.func_AddonNameForOptions(GlobalAddonName)
local category999name = BINDING_HEADER_DEBUG
----------------------------------------------------------------
local main_category, main_layout = Settings.RegisterVerticalLayoutCategory(category1name)
Settings.RegisterAddOnCategory(main_category)
local parentCategory = main_category
----------------------------------------------------------------
-- OPEN CONFIG
----------------------------------------------------------------
function EventFrame:openConfig()
	if SettingsPanel:IsVisible() and self:IsVisible() then
		if InCombatLockdown() then return end
		HideUIPanel(SettingsPanel)
	else
		Settings.OpenToCategory(main_category:GetID(), GlobalAddonName)
	end
end
function E.openConfig()
	EventFrame:openConfig()
end
SLASH_OCTO_TODO_OPTIONS1 = "/octosettings"
SlashCmdList["OCTO_TODO_OPTIONS"] = function() EventFrame:openConfig() end
----------------------------------------------------------------
local MyEventsTable = {
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	Octo_Options = Octo_Options or {}
	----------------------------------------------------------------
	-- 0 -----------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable
		and E.func_option_FONT
		and E.func_option_OTHER
		and E.func_option_CHARACTER
		then
			E.func_option_FONT(main_category, main_layout)
			E.func_option_OTHER(main_category, main_layout)
			E.func_option_CHARACTER(main_category, main_layout)
		end
	end
	----------------------------------------------------------------
	-- 2 -----------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable
		and E.func_option_CURRENCY
		then
			local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, category2name) -- CURRENCY
			E.func_option_CURRENCY(category, layout, tabName)
		end
	end
	----------------------------------------------------------------
	-- 3 -----------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable
		and E.func_option_REPUTATION
		then
			local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, category4name) -- REPUTATION
			E.func_option_REPUTATION(category, layout)
		end
	end
	----------------------------------------------------------------
	-- 4 -----------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable
		and E.func_option_DUNGEONS
		then
			local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, category3name) -- DUNGEONS
			E.func_option_DUNGEONS(category, layout)
		end
	end






	----------------------------------------------------------------
	-- 10 -----------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable then
			local width = E.FOURTH_WIDTH
			-- local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, category3name)
			-- E.func_option_COLOR_PROFILE(category, layout)
			-- E.func_option_COLOR_MAIN(category, layout)
			if E.func_option_COLOR then
				local parent = E.func_GetAddOnMetadata(E.MainAddonName, "Title")
				local leftText = COLORS
				local rightText = COLORS
				AceConfigRegistry:RegisterOptionsTable(leftText, E.func_option_COLOR(width, rightText))
				AceConfigDialog:AddToBlizOptions(leftText, leftText, main_category:GetID())
			end
		end
	end
	----------------------------------------------------------------
	-- 11 ---------------------------------------------------------
	----------------------------------------------------------------
	-- do
	-- 	local enable = true
	-- 	if enable and E.func_option_COLOR_PROFILE and E.func_option_COLOR_MAIN then
	-- 		local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, category3name)
	-- 		E.func_option_COLOR_PROFILE(category, layout)
	-- 		E.func_option_COLOR_MAIN(category, layout)
	-- 	end
	-- end
	----------------------------------------------------------------
	-- 998 ---------------------------------------------------------
	----------------------------------------------------------------
	-- do
	-- 	local enable = true
	-- 	if enable and E.func_option_userscript then
	-- 		local category2, layout2 = Settings.RegisterVerticalLayoutSubcategory(parentCategory, category4name)
	-- 		local category, layout = category2, layout2
	-- 		E.func_option_userscript(category, layout)
	-- 	end
	-- end
	----------------------------------------------------------------
	-- 999 ---------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable
		and E.func_option_DEBUG
		then
			local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, category999name) -- CURRENCY
			E.func_option_DEBUG(category, layout)
		end
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------