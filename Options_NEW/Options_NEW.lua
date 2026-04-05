local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
EventFrame:Hide()
----------------------------------------------------------------
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local new = E.COLOR_BLUE.."NEW: |r"
local ICON_NORMAL = E.func_texturefromIcon(E.RESET_INFO["Normal"].icon)
local ICON_DAILY = E.func_texturefromIcon(E.RESET_INFO["Daily"].icon)
local ICON_WEEKLY = E.func_texturefromIcon(E.RESET_INFO["Weekly"].icon)
local DailyResetSTR = E.func_Gradient(">>Daily Reset<<")
-- local className, classFilename, classId = E.className, E.classFilename, E.classId
-- local classColor = E.classColor
-- local r, g, b = C_ClassColor.GetClassColor(classFilename).r, C_ClassColor.GetClassColor(classFilename).g, C_ClassColor.GetClassColor(classFilename).b
----------------------------------------------------------------
local indent = 19
local POS_LEFT = 6
local POS_RIGHT = 474
local POS_CENTER = POS_RIGHT/2
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function CreateMainConfig()
	----------------------------------------------------------------
	local MAIN_Config = CreateFrame("ScrollFrame", GlobalAddonName.."MAIN_Config")
	MAIN_Config:Hide()
	local MAIN_ScrollBar = CreateFrame("EventFrame", nil, MAIN_Config, "MinimalScrollBar")
	MAIN_ScrollBar:SetPoint("TOPLEFT", MAIN_Config, "TOPRIGHT", 6, 0)
	MAIN_ScrollBar:SetPoint("BOTTOMLEFT", MAIN_Config, "BOTTOMRIGHT", 6, 0)

	local MAIN_scrollChild = CreateFrame("Frame", "MAIN_scrollChild", MAIN_Config)
	MAIN_Config:SetScrollChild(MAIN_scrollChild)
	MAIN_Config:SetAllPoints()
	MAIN_scrollChild:SetSize(1, 1)
	ScrollUtil.InitScrollFrameWithScrollBar(MAIN_Config, MAIN_ScrollBar)
	local MAIN_OnMouseWheel = MAIN_Config:GetScript("OnMouseWheel")
	MAIN_Config:SetScript("OnMouseWheel", function(self, ...)
			if MAIN_ScrollBar:IsShown() then
				MAIN_OnMouseWheel(self, ...)
			end
	end)
	----------------------------------------------------------------
	local MAIN_TITLE = MAIN_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	MAIN_TITLE:SetPoint("TOPLEFT", 4, 30)
	MAIN_TITLE:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
	MAIN_TITLE:SetTextColor(.5, .5, .5, 1)
	local category, layout = Settings.RegisterCanvasLayoutCategory(MAIN_Config, AddonTitle)
	category.ID = AddonTitle
	Settings.RegisterAddOnCategory(category)
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local FIRST_Config = CreateFrame("ScrollFrame", GlobalAddonName.."FIRST_Config")
	FIRST_Config:Hide()
	local FIRST_ScrollBar = CreateFrame("EventFrame", nil, FIRST_Config, "MinimalScrollBar")
	FIRST_ScrollBar:SetPoint("TOPLEFT", FIRST_Config, "TOPRIGHT", 6, 0)
	FIRST_ScrollBar:SetPoint("BOTTOMLEFT", FIRST_Config, "BOTTOMRIGHT", 6, 0)
	local FIRST_scrollChild = CreateFrame("Frame", "FIRST_scrollChild", FIRST_Config)
	FIRST_Config:SetScrollChild(FIRST_scrollChild)
	FIRST_Config:SetAllPoints()
	FIRST_scrollChild:SetSize(1, 1)
	ScrollUtil.InitScrollFrameWithScrollBar(FIRST_Config, FIRST_ScrollBar)
	local FIRST_OnMouseWheel = FIRST_Config:GetScript("OnMouseWheel")
	FIRST_Config:SetScript("OnMouseWheel", function(self, ...)
			if FIRST_ScrollBar:IsShown() then
				FIRST_OnMouseWheel(self, ...)
			end
	end)
	local TITLE_FIRST = FIRST_Config:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	TITLE_FIRST:SetPoint("TOPLEFT", 4, 30)
	TITLE_FIRST:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
	TITLE_FIRST:SetTextColor(.5, .5, .5, 1)
	local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, FIRST_Config, "FIRST_Config")
	subcategory.ID = L["InDev"].."FIRST_Config"
	----------------------------------------------------------------
end
----------------------------------------------------------------
----------------------------------------------------------------
local positions_tbl = {
	["LEFT"] = POS_LEFT,
	["CENTER"] = POS_CENTER,
	["RIGHT"] = POS_RIGHT,
}
----------------------------------------------------------------
local function INITONPTIONS(parent, options_table)
	local position = 6
	local count = 0 -- EventFrame.count
	for header, t in next,(options_table) do


		E.func_CreateColor(parent, count, position, UNKNOWN, "|cffFF00FF")

		for i, v in ipairs(t) do
			-- position = positions_tbl[p]
			count = count + 1
			local defaultValue = v.defaultValue or false
			local variableKey = v.variableKey or "UNKNOWN"
			Octo_ToDo_DB_Vars[variableKey] = Octo_ToDo_DB_Vars[variableKey] or defaultValue
			local name = v.name or L["UNKNOWN"]
			local TYPE = v.TYPE or type(defaultValue)
			local func = v.func
			local color = v.color or E.COLOR_WHITE




			if TYPE == "number" then
				local minValue = v.minValue or 0
				local maxValue = v.maxValue or 1
				local step = v.step or 1
				E.func_CreateSlider(parent, count, position, variableKey, name, color, defaultValue, minValue, maxValue)
			elseif TYPE == "string" then
				print (TYPE, variableKey, defaultValue)
			elseif TYPE == "boolean" then
				E.func_CreateCheckButton(parent, count, position, variableKey, name, color, defaultValue)
			elseif TYPE == "button" then
				E.func_CreateSimpleButton(parent, count, position, func, name, color)
			elseif TYPE == "colorPicker" then
				E.func_CreateColorPicker(parent, count, position, name, defaultValue)
			elseif TYPE == "color" then
				E.func_CreateColor(parent, count, position, name, color)
			elseif TYPE == "dropdown" then

			end
		end
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function INITONPTIONS_FIRST()
	local parent = FIRST_scrollChild -- GlobalAddonName.."FIRST_Config"
	for k, v in next,(E.OctoTable_Colors) do
		E.func_CreateColor(parent, k, POS_LEFT, v.name, v.hex)
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	if not E.DEBUG then return end
	CreateMainConfig()
end
function EventFrame:PLAYER_LOGIN()
	if not E.DEBUG then return end
	INITONPTIONS(MAIN_scrollChild, E.Octo_ToDo_DB_Vars_DEFAULTS_NEW)
	INITONPTIONS(FIRST_scrollChild, E.OctoTable_DEBUG_NEW)
	-- INITONPTIONS_FIRST()
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------