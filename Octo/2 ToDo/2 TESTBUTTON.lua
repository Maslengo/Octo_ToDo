local GlobalAddonName, E = ...
if not E.Enable_ToDo then return end
local Octo_EventFrame = CreateFrame("FRAME")
Octo_EventFrame:Hide()


-- надо добавить если нельзя юзать в комбате ПОФИКСИТЬ
-- ActionButtonCastingAnimFrameTemplate
-- self.SpellCastAnimFrame:Setup(actionButtonCastType)

----------------------------------------------------------------
-- Frequently used functions and variables moved to the top
----------------------------------------------------------------
local UIParent = UIParent
local CreateFrame = CreateFrame
local Show = Show
local Hide = Hide
local pairs = pairs
local ipairs = ipairs
local table_remove = table.remove
local table_insert = table.insert
local C_Item = C_Item
local C_Spell = C_Spell
local C_Timer = C_Timer
local GameTooltip = GameTooltip
local C_TradeSkillUI = C_TradeSkillUI

local GetProfessionInfo = GetProfessionInfo
local BNGetInfo = BNGetInfo
local PlayerHasToy = PlayerHasToy
local CreateColor = CreateColor
local GameTooltip_Hide = GameTooltip_Hide
local StaticPopup_Show = StaticPopup_Show
local Settings = Settings
local SettingsPanel = SettingsPanel
local HideUIPanel = HideUIPanel
local GameMenuFrame = GameMenuFrame
local WorldFrame = WorldFrame
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS
local RAID_CLASS_COLORS = RAID_CLASS_COLORS

-- Spell functions
local GetSpellCooldown = GetSpellCooldown or C_Spell.GetSpellCooldown
local GetSpellDescription = GetSpellDescription or C_Spell.GetSpellDescription
local GetSpellName = GetSpellName or C_Spell.GetSpellName
local GetSpellSubtext = GetSpellSubtext or C_Spell.GetSpellSubtext
local GetSpellTexture = GetSpellTexture or C_Spell.GetSpellTexture
local IsSpellKnown = IsSpellKnown
-- Item functions
local GetItemCooldown = GetItemCooldown or C_Item.GetItemCooldown
local GetItemCount = GetItemCount or C_Item.GetItemCount
local GetItemIconByID = GetItemIconByID or C_Item.GetItemIconByID
local GetItemInfo = GetItemInfo or C_Item.GetItemInfo
local GetItemInfoInstant = GetItemInfoInstant or C_Item.GetItemInfoInstant
local GetItemInventoryTypeByID = GetItemInventoryTypeByID or C_Item.GetItemInventoryTypeByID
local GetItemMaxStackSizeByID = GetItemMaxStackSizeByID or C_Item.GetItemMaxStackSizeByID
local GetItemNameByID = GetItemNameByID or C_Item.GetItemNameByID
local GetItemQualityByID = GetItemQualityByID or C_Item.GetItemQualityByID
local GetItemQualityColor = GetItemQualityColor or C_Item.GetItemQualityColor
local IsItemDataCachedByID = IsItemDataCachedByID or C_Item.IsItemDataCachedByID
local IsAnimaItemByID = IsAnimaItemByID or C_Item.IsAnimaItemByID
local GetDetailedItemLevelInfo = GetDetailedItemLevelInfo or C_Item.GetDetailedItemLevelInfo

local secureButtons = {}
local secureButtonsPool = {}

local MyTESTid = 26573 -- Лужа паладина
local globalWidth, globalHeight = 40, 40 -- defaults
local DEFAULT_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"
local HighlightTexture = "Interface\\AddOns\\Octo\\Media\\BUTTON\\GlowTexture.tga"

----------------------------------------------------------------
-- Optimized helper functions
----------------------------------------------------------------
local function IsItemEquipped(id)
	return C_Item.IsEquippableItem(id) and C_Item.IsEquippedItem(id)
end

local function SetTextureByItemId(frame, itemId)
	frame.Icon:SetTexture(DEFAULT_ICON) -- Temp while loading
	local item = Item:CreateFromItemID(itemId)
	item:ContinueOnItemLoad(function()
			local icon = item:GetItemIcon()
			frame.Icon:SetTexture(E.func_GetItemIconByID(itemId))
	end)
end

local function ClearAllInvalidHighlights()
	for _, button in pairs(secureButtons) do
		-- button:ClearHighlightTexture()

		if button:GetAttribute("item") ~= nil then
			local id = string.match(button:GetAttribute("item"), "%d+")
			if IsItemEquipped(id) then
				-- button:Highlight()
			end
		end
	end
end
----------------------------------------------------------------
local function createCooldownFrame(frame)
	if frame.cooldown then
		return frame.cooldown
	end
	frame.cooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
	frame.cooldown:SetAllPoints()

	function frame.cooldown:CheckCooldown(id, curType)
		if not id or not E:func_IsAvailable(id, curType) then return end
		if frame:IsVisible() then
			local start, duration, enabled
			if curType == "toy" or curType == "item" then
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

	return frame.cooldown
end

----------------------------------------------------------------
function E:OctoCreateButton(id, point, parent, rPoint, x, y, size, curType)


	-- local function CreateButton(parent, curType, text, id)
	if id and type(id) == "number" then
		local curType = curType or "spell"
		local button
		if next(secureButtonsPool) then
			button = table_remove(secureButtonsPool)
		else
			button = CreateFrame('Button', nil, nil, "SecureActionButtonTemplate")
			button.Cooldown = createCooldownFrame(button)
			button.Text = button:CreateFontString(nil, 'OVERLAY', 'NumberFontNormal')
			-- button:LockHighlight()
			button.Text:SetPoint("BOTTOM", button, "BOTTOM", 0, 5)
			table_insert(secureButtons, button)
		end

		function button:Recycle()
			self:SetParent(nil)
			self:ClearAllPoints()
			self:Hide()
			if curType == "item" and not C_Item.IsEquippedItem(id) then
				-- self:ClearHighlightTexture()
			end

			table_insert(secureButtonsPool, self)
		end

		button:Hide()
		-- button:EnableMouse(true)




		button.Text:SetPoint('BOTTOMRIGHT', button, 'BOTTOMRIGHT', -1, 0)
		button.Text:SetText(text)

		button:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
				GameTooltip:ClearLines()
				-- self.Highlight:Show()

				if curType == "item" then
					GameTooltip:SetItemByID(id)
				elseif curType == "item_teleports" then
					GameTooltip:SetText(L["Item Teleports"] .. "\n" .. L["Item Teleports Tooltip"], 1, 1, 1)
				elseif curType == "toy" then
					-- GameTooltip:SetItemByID(id)
					GameTooltip:SetToyByItemID(id)
				elseif curType == "spell" then
					GameTooltip:SetSpellByID(id)
				elseif curType == "flyout" then
					local name = GetFlyoutInfo(id)
					GameTooltip:SetText(name, 1, 1, 1)
				elseif curType == "profession" then
					local professionInfo = C_TradeSkillUI.GetProfessionInfoBySkillLineID(id)
					if professionInfo then
						GameTooltip:SetText(professionInfo.professionName, 1, 1, 1)
					end
				elseif curType == "seasonalteleport" then
					local currExpID = GetExpansionLevel()
					local expName = _G["EXPANSION_NAME" .. currExpID]
					local title = MYTHIC_DUNGEON_SEASON:format(expName, tpm.settings.current_season)
					GameTooltip:SetText(title, 1, 1, 1)
					GameTooltip:AddLine(L["Seasonal Teleports Tooltip"], 1, 1, 1)
					GameTooltip:Show()
				end
		end)

		button:SetScript('OnLeave', GameTooltip_Hide)




		button:SetScript("PostClick", function(self)
				if curType == "item" and C_Item.IsEquippableItem(id) then
					C_Timer.After(0.25, function()
							if IsItemEquipped(id) then
								-- ClearAllInvalidHighlights()
								-- self:Highlight()
							end
					end)
				end
		end)

		button:SetScript("OnShow", function(self)
				self.cooldown:CheckCooldown(id, curType)
				self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
				-- self:RegisterEvent("PLAYER_REGEN_DISABLED")
		end)

		button:SetScript("OnHide", function(self)
				self:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
				-- self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end)

		button:SetScript("OnEvent", function(self, event)
				if event == "ACTIONBAR_UPDATE_COOLDOWN" then
					if curType == "spell" and IsSpellKnown(id) and C_Spell.GetSpellCharges(id) then
						button.Text:SetText(C_Spell.GetSpellCharges(id).currentCharges)
					end
					self.cooldown:CheckCooldown(id, curType)
				end

		end)

		-- Textures
		-- Icon
		button.Icon = button:CreateTexture(nil, "BACKGROUND")
		button.Icon:SetAllPoints(button)
		--PushedTexture
		button:SetPushedAtlas("UI-HUD-ActionBar-IconFrame-Down")
		button.PushedTexture = button:GetPushedTexture()
		button.PushedTexture:ClearAllPoints()
		button.PushedTexture:SetPoint("CENTER")
		button.PushedTexture:SetSize(size-2, size-2)
		button.PushedTexture:SetDrawLayer("OVERLAY")
		button.PushedTexture:SetSize(size, size)
		-- Highlight
		-- button.Highlight = button:CreateTexture()
		-- button.Highlight:SetAllPoints(button)


		button:SetHighlightTexture(HighlightTexture)
		button.HighlightTexture = button:GetHighlightTexture()
		-- button.Highlight:Hide()
		-- button:SetHighlightAtlas("UI-HUD-ActionBar-IconFrame-Mouseover", "ADD")
		-- button.HighlightTexture:SetSize(size, size)



		if curType == "spell" then
			button.Icon:SetTexture(E.func_GetSpellIcon(id))
		else -- item or toy
			SetTextureByItemId(button, id)
		end

		-- Attribute
		if E:func_IsAvailable(id, curType) == false then
			button.Icon:SetDesaturated(true)
			button:SetAlpha(.3)
		else
			button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
			-- button:RegisterForClicks("AnyDown", "AnyUp")

			if curType == "item" or curType == "toy" then
				button:SetAttribute("type", "item")
				button:SetAttribute("item", "item:"..id)
			else
				button:SetAttribute("type", "spell")
				button:SetAttribute("spell", GetSpellName(id)) -- или button:SetAttribute("spell", id) для ID
			end
		end


		-- Positioning/Size
		button:SetParent(parent)
		button:SetPoint(point, parent, rPoint, x, y)
		button:SetSize(size, size)
		button:SetFrameStrata("HIGH")
		button:SetFrameLevel(102)

		return button
	end
end
----------------------------------------------------------------
function Octo_EventFrame:ELVUI_STYLE()
	local function skinButton(button)
		if button.isSkinned then return end
		C_Timer.After(0, function()
				button.isSkinned = true
				local texture = button.Icon:GetTexture()
				button:StripTextures()
				button.Icon:SetTexCoord(unpack(ElvUI[1].TexCoords))
				if button.IconMask then -- retail
					button.IconMask:Hide()
				end
				button:CreateBackdrop(nil, true, nil, nil, nil, nil, nil, true)
				button:StyleButton(nil, nil, true)
				button.Icon:SetInside(button)
				button.Icon:SetTexture(texture)
				-- button.hover:Hide()
		end)
	end
	for _, button in ipairs(secureButtons) do
		skinButton(button)
	end
end

function Octo_EventFrame:OnPlayerLogin()
	if ElvDB then
		C_Timer.After(1, function()
			self:ELVUI_STYLE()
		end)
	end
end

function Octo_EventFrame:Update()
	-- for _, frame in ipairs(secureButtons) do
	-- if not frame:IsShown() then
	-- frame:Show()
	-- end
	-- end
end

----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
}
E.RegisterMyEventsToFrames(Octo_EventFrame, MyEventsTable)

----------------------------------------------------------------
function Octo_EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
end

function Octo_EventFrame:PLAYER_LOGIN()
	self:OnPlayerLogin()
end