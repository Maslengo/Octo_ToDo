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

----------------------------------------------------------------
do
	local function updateState(self)
		-- if self:IsEnabled() then
		-- if self.down and self.over then
		-- self.Icon:SetAtlas("common-dropdown-a-button-pressedhover", true)
		-- elseif self.over then
		-- self.Icon:SetAtlas("common-dropdown-a-button-hover", true)
		-- elseif self.down then
		-- self.Icon:SetAtlas("common-dropdown-a-button-pressed", true)
		-- else
		-- self.Icon:SetAtlas("common-dropdown-a-button", true)
		-- end
		-- else
		-- self.Icon:SetAtlas("common-dropdown-a-button-disabled", true)
		-- end
	end
	local function OnEnter(self, tooltipFunc)
		self.over = true
		self.tooltip = tooltipFunc
		E.func_Octo_TooltipFrame_OnEnter(self, { "BOTTOMLEFT", "TOPRIGHT" })
		self:SetAlpha(1)
		updateState(self)
	end
	local function OnLeave(self)
		self.over = nil
		self:SetAlpha(.8)
		updateState(self)
	end
	local function OnShow(self)
		self:SetAlpha(.8)
		Octo_TooltipFrame:Hide()
	end
	local function OnHide(self)
		Octo_TooltipFrame:Hide()
	end
	local function OnMouseDown(self)
		self.down = true
		self.Icon:ClearAllPoints()
		self.Icon:SetPoint("TOPLEFT", 1, -1)
		self.Icon:SetPoint("BOTTOMRIGHT", 1, -1)
		updateState(self)
	end
	local function OnMouseUp(self)
		self.down = nil
		self.Icon:ClearAllPoints()
		self.Icon:SetPoint("TOPLEFT", 0, 0)
		self.Icon:SetPoint("BOTTOMRIGHT", 0, 0)
		updateState(self)
	end
	local function OnEnable(self)
		self.Icon:SetDesaturated()
		updateState(self)
	end
	local function OnDisable(self)
		self.Icon:SetDesaturated(true)
		updateState(self)
	end
	function E.func_CreateUtilityButton(parent, texture, width, height, tooltipFunc, clickFunc, isToggle, frameName)
		local btn = CreateFrame("BUTTON", frameName, parent)
		btn:SetSize(width or 20, height or 20)
		btn.Icon = btn:CreateTexture(nil, "ARTWORK")
		btn.Icon:SetAllPoints()
		if isToggle then
			btn.IconBG = btn:CreateTexture(nil, "BACKGROUND")
			btn.IconBG:SetAllPoints()
			E.func_SetupTextureToFrame(btn.IconBG, E.ICON_SETTINGS_BACKGROUD)
		end
		if texture then
			if E.func_isAtlas(texture) then
				btn.Icon:SetAtlas(texture)
			else
				btn.Icon:SetTexture(texture)
			end
		end
		-- Скрипты
		btn:SetScript("OnEnter", function(self) OnEnter(self, tooltipFunc) end)
		btn:SetScript("OnLeave", OnLeave)
		btn:SetScript("OnShow", OnShow)
		btn:SetScript("OnHide", OnHide)
		btn:SetScript("OnMouseDown", OnMouseDown)
		btn:SetScript("OnMouseUp", OnMouseUp)
		btn:SetScript("OnEnable", OnEnable)
		btn:SetScript("OnDisable", OnDisable)
		btn:SetMotionScriptsWhileDisabled(true)
		-- btn:SetCollapsesLayout(true)
		-- Для обычных кнопок (не toggle) - сразу вешаем clickFunc
		if not isToggle then
			btn:SetScript("OnClick", function(self)
				parent:Hide()
				if clickFunc then
					clickFunc(self)
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
				end
			end)
		end
		-- Метод для установки данных и обновления иконки (для toggle кнопок)
		btn.SetData = function(self, targetTable, targetKey, onClickCallback)
			self.targetTable = targetTable
			self.targetKey = targetKey
			local value = targetTable and targetTable[targetKey] or false
			E.func_SetupTextureToToggleFrameWithValue(self.Icon, value)
			self:SetScript("OnClick", function()
					if not self.targetTable then return end
					local newValue = not self.targetTable[self.targetKey]
					self.targetTable[self.targetKey] = newValue
					E.func_SetupTextureToToggleFrameWithValue(self.Icon, newValue)
					if onClickCallback then onClickCallback() end
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			end)
		end
		return btn, btn.Icon
	end
end
------------------------------------------------------------
-- buttons
------------------------------------------------------------
local function CreateCloseButton(frame, anchor)
	if not frame or not anchor then return end
	----------------
	local parent = frame
	local texture = "Interface\\AddOns\\" .. E.MainAddonName .. "\\Media\\Textures\\ICON_CLOSE.tga" -- "common-icon-redx" -- "decor-controls-exit-active" -- "128-RedButton-Exit"
	local width = BUTTON_SIZE-2
	local height = BUTTON_SIZE-2
	local tooltipFunc = function()
		local tooltip = {}
		tooltip[#tooltip+1] = { E.classColorHexCurrent .. L["CLOSE"] .. "|r" }
		return tooltip
	end
	local clickFunc = nil
	local isToggle = nil
	local frameName = nil
	----------------
	local button = E.func_CreateUtilityButton(parent, texture, width, height, tooltipFunc, clickFunc, isToggle, frameName)
	button:SetPoint("BOTTOMRIGHT", anchor, "TOPRIGHT", 0, 0)
	return button
end
local function CreateOptionsButton(frame, anchor, addonIconTexture)
	if not frame or not anchor then return end
	----------------
	local parent = frame
	local texture = "Interface\\AddOns\\" .. E.MainAddonName .. "\\Media\\IconTexture\\" .. addonIconTexture
	local width = 18-2
	local height = 18-2
	local tooltipFunc = function()
		local tooltip = {}
		tooltip[#tooltip+1] = { E.classColorHexCurrent .. L["OPTIONS"] .. "|r" }
		return tooltip
	end
	local clickFunc = function()
			E.func_OpenToCategory(frame)

	end
	local isToggle = nil
	local frameName = nil
	----------------
	local button = E.func_CreateUtilityButton(parent, texture, width, height, tooltipFunc, clickFunc, isToggle, frameName)
	button:SetPoint("RIGHT", anchor, "LEFT", -BUTTON_SPACING, 0)
	return button
end
local function CreateGreatVaultButton(frame, anchor)
	if not frame or not anchor then return end
	----------------
	local parent = frame
	local texture = E.ATLAS_GREATVAULT
	local width = BUTTON_SIZE-2
	local height = BUTTON_SIZE-2
	local tooltipFunc = function()
		if InCombatLockdown() then
			return { { L["ERR_NOT_IN_COMBAT"] } }
		end
		return { { E.classColorHexCurrent .. L["RATED_PVP_WEEKLY_VAULT"] .. "|r" } }
	end
 	local clickFunc = function()
		if InCombatLockdown() then
			return
		end
		if not E.func_IsAddOnLoaded("Blizzard_WeeklyRewards") then
			E.func_LoadAddOn("Blizzard_WeeklyRewards")
		end
		if WeeklyRewards_ShowUI then
			WeeklyRewards_ShowUI()
		end
 	end
	local isToggle = nil
	local frameName = nil
	----------------
	local button = E.func_CreateUtilityButton(parent, texture, width, height, tooltipFunc, clickFunc, isToggle, frameName)
	button:SetPoint("RIGHT", anchor, "LEFT", -BUTTON_SPACING, 0)
	return button
end
------------------------------------------------------------
local function CreateCalendarButton(frame, anchor)
	if not frame or not anchor then return end
	----------------
	local parent = frame
	local texture = tostringall("UI-HUD-Calendar-" .. E.func_GetCurrentDay() .. "-Mouseover")
	local width = BUTTON_SIZE-2
	local height = BUTTON_SIZE-2
	local tooltipFunc = nil
	local clickFunc = function(self)
		if not E.func_IsAddOnLoaded("Blizzard_Calendar") then
			-- UIParentLoadAddOn("Blizzard_Calendar")
			E.func_LoadAddOn("Blizzard_Calendar")
		end
		if Calendar_Toggle then
			Calendar_Toggle()
		end
	end
	local isToggle = nil
	local frameName = "Octo_CalendarButton"
	----------------
	local button = E.func_CreateUtilityButton(parent, texture, width, height, tooltipFunc, clickFunc, isToggle, frameName)
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
	local GreatVaultButton = CreateGreatVaultButton(frame, optionsButton)
	local Octo_CalendarButton = CreateCalendarButton(frame, GreatVaultButton)

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
------------------------------------------------------------