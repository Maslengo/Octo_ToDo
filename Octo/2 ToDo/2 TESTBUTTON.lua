local GlobalAddonName, E = ...
local Octo_EventFrame = CreateFrame("FRAME")
Octo_EventFrame:Hide()
----------------------------------------------------------------
local GlowTexture = "Interface\\AddOns\\Octo\\Media\\BUTTON\\GlowTexture.tga"
local ClickTexture = "Interface\\AddOns\\Octo\\Media\\BUTTON\\ClickTexture.tga"
local spellID = 26573 -- ЛУЖА ПАЛАДИНА
local type = "spell"
local size = 64
local ShowBlackSwipe = true
local ShowYellowSwipe = true
local IconTexture = E.func_GetSpellIcon(spellID) --"interface/icons/inv_mushroom_11"
-- Create text elements
function Octo_EventFrame:CreateTextElement(frame, color)
	local text = frame:CreateFontString(nil, "HIGHLIGHT", "GameFontNormalSmall")
	text:SetFontObject(OctoFont11)
	text:SetJustifyV("MIDDLE")
	text:SetJustifyH("CENTER")
	text:SetTextColor(unpack(color))
	return text
end


local function createCooldownFrame(frame)
	if frame.cooldownFrame then
		return frame.cooldownFrame
	end
	frame.cooldownFrame = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")

	frame.cooldownFrame:SetAllPoints()
	frame.cooldownFrame:SetReverse(false) -- РЕВЕРСИЯ
	frame.cooldownFrame:SetDrawBling(false)
	frame.cooldownFrame:SetDrawEdge(true) -- ЖЕЛТАЯ ХУЙНЯ
	frame.cooldownFrame:SetHideCountdownNumbers(true)
	-- frame.cooldownFrame:ClearAllPoints()
	-- frame.cooldownFrame:SetPoint("CENTER")
	-- frame.cooldownFrame:SetSize(size*3-4, size*3-4)


	-- frame.cooldownFrame:SetDrawSwipe(ShowBlackSwipe) -- Включить/Отключить свайп
	-- if not ShowYellowSwipe then
	-- 	frame.cooldownFrame:SetEdgeTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\EMPTY")
	-- end




	-- frame.cooldownFrame:SetHideCountdownNumbers(true)
										--
	-- frame.cooldownFrame:ClearAllPoints()
	-- frame.cooldownFrame:SetPoint("CENTER")
	-- frame.cooldownFrame:SetSize(size, size)

	-- frame.cooldownFrame:SetPoint("TOPLEFT", frame.IconTexture, "TOPLEFT", 1.7, -1.7)
	-- frame.cooldownFrame:SetPoint("BOTTOMRIGHT", frame.IconTexture, "BOTTOMRIGHT", -1, 1)

	-- для секонд кулдаунов(чарджей)
		-- Розовый
			-- self.cooldown:SetEdgeTexture("Interface\\Cooldown\\UI-HUD-ActionBar-LoC")
			-- self.cooldown:SetSwipeColor(0.17, 0, 0)

			-- Жёлтый
			-- self.cooldown:SetEdgeTexture("Interface\\Cooldown\\UI-HUD-ActionBar-SecondaryCooldown")
			-- self.cooldown:SetSwipeColor(0, 0, 0)
	function frame.cooldownFrame:CheckCooldown(spellID, type)
		if not spellID then
			return
		end
		local start, duration, enabled
		if type == "toy" or type == "item" then
			start, duration, enabled = C_Item.GetItemCooldown(spellID)
		else
			local cooldown = C_Spell.GetSpellCooldown(spellID)
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
function Octo_EventFrame:CreateButtons()
	local function func_OnEnter(frame)
		E.func_TooltipOnEnter(frame, true, true)
		frame.GlowTexture:Show()
	end
	local function func_OnLeave(frame)
		GameTooltip_Hide()
		frame.GlowTexture:Hide()
	end
	local frame = CreateFrame("BUTTON", "PIZDALISHE", UIParent, "ActionButtonTemplate, SecureActionButtonTemplate")
	frame:Hide()
	-- frame:SetPropagateMouseClicks(true)
	-- frame:SetPropagateMouseMotion(true)
	frame:RegisterForClicks("LeftButtonUp")
	frame:SetPoint("CENTER")
	frame:SetSize(size, size)
	frame.IconTexture = frame:CreateTexture(nil, "BACKGROUND") -- low
	frame.IconTexture:SetAllPoints(frame)
	frame.IconTexture:SetTexture(IconTexture)

	frame:SetNormalTexture(IconTexture)
	frame.NormalTexture:SetDrawLayer("OVERLAY")
	frame.NormalTexture:SetSize(size, size)



	frame:SetPushedAtlas("UI-HUD-ActionBar-IconFrame-Down")
	frame.pushedTexture = frame:GetPushedTexture()
	frame.pushedTexture:ClearAllPoints()
	frame.pushedTexture:SetPoint("CENTER")
	frame.pushedTexture:SetSize(size-2, size-2)
	frame.pushedTexture:SetDrawLayer("OVERLAY")
	frame.pushedTexture:SetSize(size, size)




	frame:SetHighlightAtlas("UI-HUD-ActionBar-IconFrame-Mouseover", "ADD")
	frame.HighlightTexture:SetSize(size, size)
	-- local HighlightTexture = frame:GetHighlightTexture()
	-- HighlightTexture:ClearAllPoints()
	-- HighlightTexture:SetPoint("CENTER")
	-- HighlightTexture:SetSize(size-4, size-4)


	createCooldownFrame(frame)

	frame:SetScript("OnShow", function(self)
			self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	end)
	frame:SetScript("OnHide", function(self)
			self:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	end)

	frame.Count = self:CreateTextElement(frame, {0, .65, 1, 1})
	frame.Count:ClearAllPoints()
	frame.Count:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, 1)

	frame.HotKey = self:CreateTextElement(frame, {0, .65, 1, 1})
	frame.HotKey:ClearAllPoints()
	frame.HotKey:SetPoint("TOPRIGHT", -3, -4)


	frame.IconMask:ClearAllPoints()
	frame.IconMask:SetSize(size, size)
	frame.IconMask:SetPoint("CENTER", 0.5, -0.5)






	-- frame:SetScript("OnEnter", func_OnEnter)
	-- frame:SetScript("OnLeave", func_OnLeave)
end
function Octo_EventFrame:ELVUI_STYLE()
	local function skinButton(btn)
		if btn.isSkinned then return end
		C_Timer.After(0, function()
				btn.isSkinned = true
				local texture = btn.IconTexture:GetTexture()
				btn:StripTextures()
				btn.IconTexture:SetTexCoord(unpack(ElvUI[1].TexCoords))
				if btn.IconMask then -- retail
					btn.IconMask:Hide()
				end
				btn:CreateBackdrop(nil, true, nil, nil, nil, nil, nil, true)
				btn:StyleButton()
				btn.IconTexture:SetInside(btn)
				btn.IconTexture:SetTexture(texture)
		end)
	end
	skinButton(PIZDALISHE)
end
----------------------------------------------------------------
function Octo_EventFrame:OnLoad()
	self:CreateButtons()
	if ElvDB then
		self:ELVUI_STYLE()
	end
	PIZDALISHE.IconTexture:Show()
end
function Octo_EventFrame:Update()
	PIZDALISHE.HotKey:SetText("1")
	PIZDALISHE.Count:SetText("2")
	if not PIZDALISHE:IsShown() then
		PIZDALISHE:Show()
	end
	PIZDALISHE.cooldownFrame:CheckCooldown(spellID, type)
end
function Octo_EventFrame:UpdateHotkeys()
	PIZDALISHE.HotKey:SetText("1")
end
function Octo_EventFrame:UpdateCounts()
	PIZDALISHE.Count:SetText("2")
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
	-- self:UpdateHotkeys()
	-- self:UpdateCounts()
end
----------------------------------------------------------------
function Octo_EventFrame:PLAYER_ENTERING_WORLD()
	self:Update()
end
----------------------------------------------------------------
function Octo_EventFrame:UPDATE_BINDINGS()
	self:UpdateHotkeys()
end
function Octo_EventFrame:GAME_PAD_ACTIVE_CHANGED()
	self:UpdateHotkeys()
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