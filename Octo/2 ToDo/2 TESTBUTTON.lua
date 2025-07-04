local GlobalAddonName, E = ...
local Octo_EventFrame = CreateFrame("FRAME")
Octo_EventFrame:Hide()
----------------------------------------------------------------
local UIParent = UIParent
local CreateFrame = CreateFrame
local Show = Show
local Hide = Hide

--------------------------------------
-- Frames
--------------------------------------

local flyOutButtons = {}
local flyOutButtonsPool = {}
local flyOutFrames = {}
local flyOutFramesPool = {}
local secureButtons = {}
local secureButtonsPool = {}

local function IsItemEquipped(id)
	return C_Item.IsEquippableItem(id) and C_Item.IsEquippedItem(id)
end

local function SetTextureByItemId(frame, itemId)
	frame:SetNormalTexture(DEFAULT_ICON) -- Temp while loading
	local item = Item:CreateFromItemID(tonumber(itemId))
	item:ContinueOnItemLoad(function()
		local icon = item:GetItemIcon()
		frame:SetNormalTexture(icon)
	end)
end
----------------------------------------------------------------
local GlowTexture = "Interface\\AddOns\\Octo\\Media\\BUTTON\\GlowTexture.tga"
local ClickTexture = "Interface\\AddOns\\Octo\\Media\\BUTTON\\ClickTexture.tga"
local ShowBlackSwipe = true
local ShowYellowSwipe = true


local function createCooldownFrame(frame)
	-- Если у переданного frame уже есть cooldownFrame, функция просто возвращает существующий фрейм, а не создает новый

	if frame.cooldownFrame then
		return frame.cooldownFrame
	end
	frame.cooldownFrame = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate") -- '$parentCooldown'
	frame.cooldownFrame:SetAllPoints()

	function frame.cooldownFrame:CheckCooldown(id, type)
		if not id then
			return
		end
		if frame:IsVisible() then
			local start, duration, enabled
			if type == "toy" or type == "item" then
				start, duration, enabled = C_Item.GetItemCooldown(id)
			else
				local cooldown = C_Spell.GetSpellCooldown(id)
				start = cooldown.startTime
				duration = cooldown.duration
				enabled = true
			end
			if enabled and duration > 0 then
				self:SetCooldown(start, duration)
			else
				self:Clear()
			end
		end
	end

	return frame.cooldownFrame
end




local function onLeave()
	GameTooltip:Hide()
end

local function OnClick()

end


local type = "spell"
local MyTESTid = 26573 -- ЛУЖА ПАЛАДИНА
local size = 44


local function ClearAllInvalidHighlights()
	for _, button in pairs(secureButtons) do
		button:ClearHighlightTexture()

		if button:GetAttribute("item") ~= nil then
			local id = string.match(button:GetAttribute("item"), "%d+")
			if IsItemEquipped(id) then
				button:Highlight()
			end
		end
	end
end


local function CreateButton(frame, type, text, id, hearthstone)
	local button
	if next(secureButtonsPool) then
		button = table.remove(secureButtonsPool)
	else
		button = CreateFrame('Button', nil, nil, "SecureActionButtonTemplate") -- ActionButtonTemplate, ПОРТИТСЯ ХАЙЛАЙТ
		button.Cooldown = createCooldownFrame(button)
		button.Text = button:CreateFontString(nil, 'OVERLAY', 'NumberFontNormal')
		button:LockHighlight()
		button.Text:SetPoint("BOTTOM", button, "BOTTOM", 0, 5)
		table.insert(secureButtons, button)
	end

	function button:Recycle()
		self:SetParent(nil)
		self:ClearAllPoints()
		self:Hide()
		if type == "item" and not C_Item.IsEquippedItem(id) then
			self:ClearHighlightTexture()
		end
		table.insert(secureButtonsPool, self)
	end

	button:Hide()
	button:SetPoint("CENTER")
	button:SetSize(size, size)
	button:EnableMouse(true)
	button:RegisterForClicks("AnyDown", "AnyUp")


	----------------
	----------------
	button.Icon = button:CreateTexture(nil, "BACKGROUND")
	button.Icon:SetAllPoints(button)
	----------------
	button.Text:SetPoint('BOTTOMRIGHT', button, 'BOTTOMRIGHT', -1, 0)
	button.Text:SetText(text)
	----------------
	button:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:ClearLines()


			if type == "item" then
				GameTooltip:SetItemByID(MyTESTid)
			elseif type == "item_teleports" then
				GameTooltip:SetText(L["Item Teleports"] .. "\n" .. L["Item Teleports Tooltip"], 1, 1, 1)
			elseif type == "toy" then
				GameTooltip:SetToyByItemID(MyTESTid)
			elseif type == "spell" then
				GameTooltip:SetSpellByID(MyTESTid)
			elseif type == "flyout" then
				local name = GetFlyoutInfo(MyTESTid)
				GameTooltip:SetText(name, 1, 1, 1)
			elseif type == "profession" then
				local professionInfo = C_TradeSkillUI.GetProfessionInfoBySkillLineID(MyTESTid)
				if professionInfo then
					GameTooltip:SetText(professionInfo.professionName, 1, 1, 1)
				end
			elseif type == "seasonalteleport" then
				local currExpID = GetExpansionLevel()
				local expName = _G["EXPANSION_NAME" .. currExpID]
				local title = MYTHIC_DUNGEON_SEASON:format(expName, tpm.settings.current_season)
				GameTooltip:SetText(title, 1, 1, 1)
				GameTooltip:AddLine(L["Seasonal Teleports Tooltip"], 1, 1, 1)
					GameTooltip:Show()
			end

		end)

	button:SetScript('OnLeave', onLeave)
	button:SetScript('OnClick', OnClick)


	button:SetScript("PostClick", function(self)
		if type == "item" and C_Item.IsEquippableItem(id) then
			C_Timer.After(0.25, function() -- Slight delay due to equipping the item not being instant.
				if IsItemEquipped(id) then
					ClearAllInvalidHighlights()
					self:Highlight()
				end
			end)
		end
	end)

	button:SetScript("OnShow", function(self)
			self.cooldownFrame:CheckCooldown(id, type)
			self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	end)
	button:SetScript("OnHide", function(self)
			self:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	end)

	button:SetScript("OnEvent", function(self)
			self.cooldownFrame:CheckCooldown(id, type)
	end)

	-- Textures
	----------------
	button:SetPushedAtlas("UI-HUD-ActionBar-IconFrame-Down")
	button.PushedTexture = button:GetPushedTexture()
	button.PushedTexture:ClearAllPoints()
	button.PushedTexture:SetPoint("CENTER")
	button.PushedTexture:SetSize(size-2, size-2)
	button.PushedTexture:SetDrawLayer("OVERLAY")
	button.PushedTexture:SetSize(size, size)
	----------------
	-- button:SetHighlightAtlas("UI-HUD-ActionBar-IconFrame-Mouseover", "ADD")
	-- button.HighlightTexture:SetSize(size, size)
	----------------
	if type == "spell" then
		button.Icon:SetTexture(E.func_GetSpellIcon(id))
		-- icon:SetTexCoord(.05, .95, .05, .95) -- zoom 5%
	else -- item or toy
		SetTextureByItemId(button, id)
	end
	----------------
	-- Attributes
	button:SetAttribute("type", type)
	if type == "item" then
		button:SetAttribute(type, "item:" .. id)
		if C_Item.IsEquippableItem(id) and IsItemEquipped(id) then
			button:Highlight()
		end
	else
		button:SetAttribute(type, id)
	end


	-- Positioning/Size
	button:SetParent(frame)
	button:SetSize(size, size)
	button:SetFrameStrata("HIGH")
	button:SetFrameLevel(102) -- This needs to be lower than the flyout frame

	----------------
	return button
end
----------------------------------------------------------------
function Octo_EventFrame:OnLoad()
	CreateButton(UIParent, "spell", "teXT", MyTESTid)

	for k, frame in ipairs(secureButtons) do
		frame:Show()
	end
end
function Octo_EventFrame:Update()

	for k, frame in ipairs(secureButtons) do
		if not frame:IsShown() then
			frame:Show()
		end
		-- frame.cooldownFrame:CheckCooldown(MyTESTid, type)
	end



end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"UPDATE_BINDINGS",
	"GAME_PAD_ACTIVE_CHANGED",
	"PLAYER_ENTERING_WORLD",
	"ACTIONBAR_UPDATE_COOLDOWN",
}
E.RegisterMyEventsToFrames(Octo_EventFrame, MyEventsTable, E.func_DebugPath())
----------------------------------------------------------------
function Octo_EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	----------------
	self:OnLoad()
end
----------------------------------------------------------------
function Octo_EventFrame:ACTIONBAR_UPDATE_COOLDOWN()
	self:Update()
end