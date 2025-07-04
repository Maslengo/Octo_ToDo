local GlobalAddonName, E = ...
local Octo_EventFrame = CreateFrame("FRAME")
Octo_EventFrame:Hide()
----------------------------------------------------------------
local UIParent = UIParent
local CreateFrame = CreateFrame
local Show = Show
local Hide = Hide






----------------------------------------------------------------
local GlowTexture = "Interface\\AddOns\\Octo\\Media\\BUTTON\\GlowTexture.tga"
local ClickTexture = "Interface\\AddOns\\Octo\\Media\\BUTTON\\ClickTexture.tga"
local ShowBlackSwipe = true
local ShowYellowSwipe = true


local function createCooldownFrame(frame, id, type)
	-- Если у переданного frame уже есть cooldownFrame, функция просто возвращает существующий фрейм, а не создает новый

	if frame.cooldownFrame then
		return frame.cooldownFrame
	end
	frame.cooldownFrame = CreateFrame("Cooldown", '$parentCooldown', frame, "CooldownFrameTemplate")
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

local function onEnter(self)
	if(not self:IsVisible()) then return end
	self.Overlay:Show()
end

local function onLeave()
	GameTooltip:Hide()
end

local function OnClick()

end


local type = "spell"
local spellID = 26573 -- ЛУЖА ПАЛАДИНА
local size = 64
local function CreateButton(element, index, spellID)
	local button = CreateFrame('Button', element:GetName() .. 'Button' .. index, element, "BackdropTemplate")
	button:Hide()
	button:SetPoint("CENTER")
	button:SetSize(size, size)
	button:RegisterForClicks('RightButtonUp')

	local cd = createCooldownFrame(button, spellID, type)
	cd:SetAllPoints()
	button.Cooldown = cd

	-- local icon = button:CreateTexture(nil, 'BORDER')
	local icon = button:CreateTexture()
	icon:SetAllPoints(button)
	icon:SetTexture(E.func_GetSpellIcon(spellID))
	button.Icon = icon
	icon:SetTexCoord(.05, .95, .05, .95) -- zoom 5%

	local countFrame = CreateFrame('Frame', nil, button)
	countFrame:SetAllPoints(button)
	countFrame:SetFrameLevel(cd:GetFrameLevel() + 1)

	local count = countFrame:CreateFontString(nil, 'OVERLAY', 'NumberFontNormal')
	count:SetPoint('BOTTOMRIGHT', countFrame, 'BOTTOMRIGHT', -1, 0)
	button.Count = count

	local overlay = button:CreateTexture(nil, 'OVERLAY')
	overlay:SetTexture([[Interface\Buttons\UI-Debuff-Overlays]])
	overlay:SetAllPoints()
	overlay:SetTexCoord(0.296875, 0.5703125, 0, 0.515625)
	button.Overlay = overlay

	button:SetScript('OnEnter', onEnter)
	button:SetScript('OnLeave', onLeave)
	button:SetScript('OnClick', OnClick)

	return button
end
----------------------------------------------------------------
function Octo_EventFrame:OnLoad()
	CreateButton(UIParent, 1, spellID)
	UIParentButton1:Show()
	UIParentButton1.Icon:Show()
end
function Octo_EventFrame:Update()
	UIParentButton1.Count:SetText("123123")
	if not UIParentButton1:IsShown() then
		UIParentButton1:Show()
	end
	UIParentButton1.cooldownFrame:CheckCooldown(spellID, type)
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- -- Charge Cooldown stuff

-- local numChargeCooldowns = 0
-- local function CreateChargeCooldownFrame(parent)
-- 	numChargeCooldowns = numChargeCooldowns + 1
-- 	local cooldown = CreateFrame("Cooldown", "ChargeCooldown"..numChargeCooldowns, parent, "CooldownFrameTemplate")
-- 	cooldown:SetHideCountdownNumbers(true)
-- 	cooldown:SetDrawSwipe(false)
-- 	local icon = parent.Icon or parent.icon
-- 	cooldown:SetPoint("TOPLEFT", icon, "TOPLEFT", 2, -2)
-- 	cooldown:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", -2, 2)
-- 	cooldown:SetFrameLevel(parent:GetFrameLevel())
-- 	return cooldown
-- end

-- function StartChargeCooldown(parent, chargeStart, chargeDuration, chargeModRate)
-- 	if chargeStart == 0 then
-- 		ClearChargeCooldown(parent)
-- 		return
-- 	end

-- 	parent.chargeCooldown = parent.chargeCooldown or CreateChargeCooldownFrame(parent)

-- 	CooldownFrame_Set(parent.chargeCooldown, chargeStart, chargeDuration, true, true, chargeModRate)
-- end

-- function ClearChargeCooldown(parent)
-- 	if parent.chargeCooldown then
-- 		CooldownFrame_Clear(parent.chargeCooldown)
-- 	end
-- end