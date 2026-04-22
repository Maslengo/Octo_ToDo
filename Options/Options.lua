local GlobalAddonName, E = ...
-- if not E.IsMidnight then return end
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
local category2name = L["CURRENCY"] -- L["COLORS"]
local category3name = L["DUNGEONS"]
local category4name = L["REPUTATION"]
local category5name = L["ITEMS"]
-- local category5name = "func_option_moduls" -- E.func_AddonNameForOptions(GlobalAddonName)

local category999name = E.COLOR_GRAY..L["BINDING_HEADER_DEBUG"].."|r"
-- local category999name = E.func_Gradient(L["BINDING_HEADER_DEBUG"], E.COLOR_GRAY, E.COLOR_WHITE)
----------------------------------------------------------------
local main_category, main_layout = Settings.RegisterVerticalLayoutCategory(category1name)
Settings.RegisterAddOnCategory(main_category)
local parentCategory = main_category
E.main_category = main_category
----------------------------------------------------------------
local MyEventsTable = {
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	----------------------------------------------------------------
	-- MAIN --------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable then
			if E.func_option_FONT then
				E.func_option_FONT(main_category, main_layout)
			end
			if E.func_option_OTHER then
				E.func_option_OTHER(main_category, main_layout)
			end
		end
	end
	----------------------------------------------------------------
	-- CHARACTERS_OLD ----------------------------------------------
	----------------------------------------------------------------
	-- do
	-- 	local enable = true
	-- 	if enable then
	-- 		local tabName = L["Characters"]
	-- 		local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, tabName)
	-- 		if E.func_option_CHARACTERS_OLD then
	-- 			E.func_option_CHARACTERS_OLD(category, layout)
	-- 		end
	-- 	end
	-- end
	----------------------------------------------------------------
	-- CHARACTERS --------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable then
			local sortCategoryName = L["BAG_FILTER_TITLE_SORTING"] -- L["Characters"]
			local layout = CreateFrame("FRAME", GlobalAddonName.."CHARACTERS_LAYOUT") -- СОЗДАЁМ FRAME
			layout:Hide()
			local category = Settings.RegisterCanvasLayoutSubcategory(parentCategory, layout, sortCategoryName) -- РЕГИСТРИРУЕМ КАК ПОДКАТЕГОРИЮ (без RegisterAddOnCategory)
			category.ID = sortCategoryName

			if E.func_option_CHARACTERS then
				E.func_option_CHARACTERS(category, layout)
			end
		end
	end
	----------------------------------------------------------------
	-- CURRENCY ----------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable then
			-- local iconID = E.func_texturefromIcon(E.func_GetIcon("currency", 1166))
			local tabName = L["CURRENCY"]
			local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, tabName) -- CURRENCY
			if E.func_option_CURRENCY_ICONS then
				E.func_option_CURRENCY_ICONS(category, layout)
			end
			if E.func_option_CURRENCY_COLORS then
				E.func_option_CURRENCY_COLORS(category, layout)
			end
			if E.func_option_CURRENCY_OTHER then
				E.func_option_CURRENCY_OTHER(category, layout)
			end
			if E.func_option_CURRENCY_TOOLTIP then
				E.func_option_CURRENCY_TOOLTIP(category, layout)
			end
		end
	end
	----------------------------------------------------------------
	-- ITEMS -------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable then
			-- local iconID = E.func_texturefromIcon(E.func_GetIcon("item", 5081)) -- (49778 sword) (2362 shield)
			local tabName = L["ITEMS"]
			local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, tabName) -- L["ITEMS"]
			if E.func_option_ITEMS_ICONS then
				E.func_option_ITEMS_ICONS(category, layout)
			end
			if E.func_option_ITEMS_COLORS then
				E.func_option_ITEMS_COLORS(category, layout)
			end
		end
	end
	----------------------------------------------------------------
	-- REPUTATION --------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable then
			-- local iconID = E.func_texturefromIcon(E.ICON_TABARD)
			local tabName = L["REPUTATION"]
			local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, tabName) -- REPUTATION
			if E.func_option_REPUTATION_ICONS then
				E.func_option_REPUTATION_ICONS(category, layout)
			end
			if E.func_option_REPUTATION_PARAGON then
				E.func_option_REPUTATION_PARAGON(category, layout)
			end
			if E.func_option_REPUTATION_MAJOR then
				E.func_option_REPUTATION_MAJOR(category, layout)
			end
			if E.func_option_REPUTATION_FRIEND then
				E.func_option_REPUTATION_FRIEND(category, layout)
			end
			if E.func_option_REPUTATION_SIMPLE then
				E.func_option_REPUTATION_SIMPLE(category, layout)
			end
		end
	end
	----------------------------------------------------------------
	-- RAIDS -------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable then
			-- local iconID = E.func_texturefromIcon(E.ATLAS_RAID)
			local tabName = L["RAIDS"]
			local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, tabName)
			if E.func_option_RAIDS_ICONS then
				E.func_option_RAIDS_ICONS(category, layout)
			end
			if E.func_option_RAIDS_TOOLTIP then
				E.func_option_RAIDS_TOOLTIP(category, layout)
			end
		end
	end
	----------------------------------------------------------------
	-- COLORS ------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable then
			local width = E.FOURTH_WIDTH
			-- local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, category3name)
			-- E.func_option_COLOR_PROFILE(category, layout)
			-- E.func_option_COLOR_MAIN(category, layout)
			if width and E.func_option_COLORS then
				local parent = E.func_GetAddOnMetadata(E.MainAddonName, "Title")
				local leftText = L["COLORS"]
				local rightText = L["COLORS"]
				AceConfigRegistry:RegisterOptionsTable(leftText, E.func_option_COLORS(width, rightText))
				AceConfigDialog:AddToBlizOptions(leftText, leftText, main_category:GetID())
			end
		end
	end

	----------------------------------------------------------------
	-- 11 ---------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable and E.func_option_COLOR_PROFILE and E.func_option_COLOR_MAIN then
			local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, category3name)
			E.func_option_COLOR_PROFILE(category, layout)
			E.func_option_COLOR_MAIN(category, layout)
		end
	end
	----------------------------------------------------------------
	-- DEBUG -------------------------------------------------------
	----------------------------------------------------------------
	do
		local enable = true
		if enable then
			local category, layout = Settings.RegisterVerticalLayoutSubcategory(parentCategory, E.COLOR_GRAY .. L["BINDING_HEADER_DEBUG"] .. "|r") -- BINDING_HEADER_DEBUG
			if E.func_option_DEBUG then
				E.func_option_DEBUG(category, layout)
			end

			if not E.DEBUG then return end
			if E.func_option_DEV1 then
				E.func_option_DEV1(category, layout)
			end
			if E.func_option_DEV2 then
				E.func_option_DEV2(category, layout)
			end
		end
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------