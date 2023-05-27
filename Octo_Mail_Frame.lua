local AddonName, E = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
--E.modules = {}
--------------------------------------------------------------------------------
local Enable_Module = false
local scale = WorldFrame:GetWidth() / GetPhysicalScreenSize() / UIParent:GetScale()
local bgCr, bgCg, bgCb, bgCa = 14/255, 14/255, 14/255, 0.8 --0.1,0.1,0.1,1
function Octo_MAIL_DragonflyOnLoad()
	local Octo_Mail_Frame = CreateFrame("Frame", AddonTitle)
	Octo_Mail_Frame:RegisterEvent("MAIL_SHOW")
	Octo_Mail_Frame:RegisterEvent("SECURE_TRANSFER_CANCEL")
	Octo_Mail_Frame:RegisterEvent("MERCHANT_SHOW")
	Octo_Mail_Frame:RegisterEvent("MERCHANT_CLOSED")
	Octo_Mail_Frame:RegisterEvent("BANKFRAME_OPENED")
	Octo_Mail_Frame:RegisterEvent("BANKFRAME_CLOSED")
	Octo_Mail_Frame:RegisterEvent("PLAYER_STARTED_MOVING")
	Octo_Mail_Frame:SetScript("OnEvent", Octo_MAIL_DragonflyOnEvent)
end
local ignore_list = {
	[109076] = true, -- Планер
	[166751] = true, --настой на опыт
	[49040] = true, --Дживс
	[203703] = true,
	[191251] = true,
	[193201] = true,
	[81055] = true, -- Ярмарка
	[180653] = true, -- КЛюч
	[204193] = true,
	[204075] = true,
	[204195] = true,
	[204076] = true,
	[204196] = true,
	[204077] = true,
	[204194] = true,
	[204078] = true,
}
local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel()
local ilvlStr = avgItemLevelEquipped or 0
-- local OILVLFrame = CreateFrame('GameTooltip', 'OILVLTooltip', nil, 'GameTooltipTemplate');
-- OILVLFrame:SetOwner(UIParent, 'ANCHOR_NONE');
local function MASLENGO_Mail()
	SELL_Frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	SELL_Frame:SetSize(64*scale, 64*scale)
	--SELL_Frame:SetClampedToScreen(false)
	SELL_Frame:SetFrameStrata("DIALOG")
	SELL_Frame:EnableMouse(true)
	SELL_Frame:SetMovable(true)
	SELL_Frame:RegisterForDrag("RightButton")
	SELL_Frame:SetScript("OnDragStart", SELL_Frame.StartMoving)
	SELL_Frame:SetScript("OnDragStop", function() SELL_Frame:StopMovingOrSizing() end)
	SELL_Frame:SetPoint("CENTER", -551, 12)
	SELL_Frame:SetBackdrop({
			bgFile = "Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	SELL_Frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	SELL_Frame:SetBackdropBorderColor(0, 0, 0, 1)
	SELL_Frame.Button = CreateFrame("BUTTON", nil, SELL_Frame)
	SELL_Frame.Button:SetAllPoints()
	SELL_Frame.Button:RegisterForClicks("LeftButtonUp")
	SELL_Frame.Button:SetScript("OnClick",function()
			for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
				for slot=1, C_Container.GetContainerNumSlots(bag) do
					local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
					if containerInfo then
						local itemID = containerInfo.itemID
						--local hyperlink = containerInfo.hyperlink
						local itemLink = C_Container.GetContainerItemLink(bag, slot)
						local name, _, itemQuality, itemLevel, _, _, _,_, _, _, sellPrice = GetItemInfo(itemLink)
						local effectiveILvl = GetDetailedItemLevelInfo(itemID) or 0
						local baseILvl = tonumber(select(3,GetDetailedItemLevelInfo(itemID))) or 0
						-----------------------
						--if (itemLevel == nil) then return end
						local ItemTooltip = _G["OctoScanningTooltip"] or
						CreateFrame("GameTooltip", "OctoScanningTooltip", WorldFrame, "GameTooltipTemplate")
						ItemTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
						ItemTooltip:ClearLines()
						ItemTooltip:SetHyperlink(itemLink)
						local enchant = ""
						local emptySockets = 0
						-- local foundEnchant = nil
						local foundLevel = nil
						-- local foundEmptySocket = nil
						for i = 1, ItemTooltip:NumLines() do
							-- foundEnchant = _G["OctoScanningTooltipTextLeft" .. i]:GetText():match(ENCHANTED_TOOLTIP_LINE:gsub("%%s", "(.+)"))
							-- if foundEnchant then
							--     enchant = foundEnchant
							-- end
							foundLevel = _G["OctoScanningTooltipTextLeft" .. i]:GetText():match(ITEM_LEVEL:gsub("%%d", "(%%d+)"))
							if foundLevel then
								itemLevel = tonumber(foundLevel) or 0
							end
							-- foundEmptySocket = _G["OctoScanningTooltipTextLeft" .. i]:GetText():match(EMPTY_SOCKET_PRISMATIC)
							-- if foundEmptySocket then
							--     emptySockets = emptySockets + 1
							-- end
						end
						-----------------------
						if sellPrice ~= 0 and itemQuality < 5 and not ignore_list[itemID] --[[and baseILvl > 1]] and itemLevel < ((ilvlStr/10)*9) then
							C_Container.UseContainerItem(bag,slot)
						end
					end
				end
			end
		end
	)
	local t = SELL_Frame.Button:CreateTexture(nil,"BACKGROUND")
	SELL_Frame.Button.icon = t
	t:SetTexture("Interface\\AddOns\\Octo_ToDo_Dragonfly\\Media\\SELL.tga")
	t:SetVertexColor(1,0,1,1)
	t:SetAllPoints(SELL_Frame.Button)
end
local function MASLENGO_BANK()
	---------------------------------------------------------------------------------------------------
	FROMBANK_Frame = CreateFrame("BUTTON", nil, UIParent, "BackdropTemplate")
	FROMBANK_Frame:SetSize(64*scale, 64*scale)
	--FROMBANK_Frame:SetClampedToScreen(false)
	FROMBANK_Frame:SetFrameStrata("DIALOG")
	FROMBANK_Frame:SetPoint("CENTER", -500, 32)
	FROMBANK_Frame:SetBackdrop({
			bgFile = "Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	FROMBANK_Frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	FROMBANK_Frame:SetBackdropBorderColor(0, 0, 0, 1)
	FROMBANK_Frame.Button = CreateFrame("BUTTON", nil, FROMBANK_Frame, "SecureActionButtonTemplate")
	FROMBANK_Frame.Button:SetAllPoints()
	FROMBANK_Frame.Button:RegisterForClicks("LeftButtonDown", "LeftButtonUp", "RightButtonUp", "RightButtonDown")
	FROMBANK_Frame.Button:SetAttribute("type", "macro")
	FROMBANK_Frame.Button:SetAttribute("macrotext",
		[[
/run for b=REAGENTBANK_CONTAINER,BANK_CONTAINER do for s=1,C_Container.GetContainerNumSlots(b) do local n=C_Container.GetContainerItemLink(b,s) if n then C_Container.UseContainerItem(b,s) end end end
/run for b=NUM_TOTAL_EQUIPPED_BAG_SLOTS+1,NUM_TOTAL_EQUIPPED_BAG_SLOTS+NUM_BANKBAGSLOTS do for s=1,C_Container.GetContainerNumSlots(b) do local n=C_Container.GetContainerItemLink(b,s) if n then C_Container.UseContainerItem(b,s) end end end
]]
	)
	local t = FROMBANK_Frame.Button:CreateTexture(nil,"BACKGROUND")
	FROMBANK_Frame.Button.icon = t
	t:SetTexture("Interface\\AddOns\\Octo_ToDo_Dragonfly\\Media\\Arrow_RIGHT.tga")
	t:SetVertexColor(1,1,1,1)
	t:SetAllPoints(FROMBANK_Frame.Button)
	---------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	TOBANK_Frame = CreateFrame("BUTTON", nil, UIParent, "BackdropTemplate")
	TOBANK_Frame:SetSize(64*scale, 64*scale)
	--TOBANK_Frame:SetClampedToScreen(false)
	TOBANK_Frame:SetFrameStrata("DIALOG")
	TOBANK_Frame:SetPoint("CENTER", -500, -32)
	TOBANK_Frame:SetBackdrop({
			bgFile = "Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	TOBANK_Frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	TOBANK_Frame:SetBackdropBorderColor(0, 0, 0, 1)
	TOBANK_Frame.Button = CreateFrame("BUTTON", nil, TOBANK_Frame, "SecureActionButtonTemplate")
	TOBANK_Frame.Button:SetAllPoints()
	TOBANK_Frame.Button:RegisterForClicks("LeftButtonDown", "LeftButtonUp", "RightButtonUp", "RightButtonDown")
	TOBANK_Frame.Button:SetAttribute("type", "macro")
	TOBANK_Frame.Button:SetAttribute("macrotext",
		[[
/run for b=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do for s=1,C_Container.GetContainerNumSlots(b) do local n=C_Container.GetContainerItemLink(b,s) if n then C_Container.UseContainerItem(b,s) end end end
]]
	)
	local t = TOBANK_Frame.Button:CreateTexture(nil,"BACKGROUND")
	TOBANK_Frame.Button.icon = t
	t:SetTexture("Interface\\AddOns\\Octo_ToDo_Dragonfly\\Media\\Arrow_LEFT.tga")
	t:SetVertexColor(1,1,1,1)
	t:SetAllPoints(TOBANK_Frame.Button)
	---------------------------------------------------------------------------------------------------
end
function Octo_MAIL_DragonflyOnEvent(self, event, ...)
	if Enable_Module == true then
		if event == "MERCHANT_SHOW" and not InCombatLockdown() then
			MASLENGO_Mail()
		elseif event == "SECURE_TRANSFER_CANCEL" or event == "MERCHANT_CLOSED" or event == "PLAYER_STARTED_MOVING" then
			if SELL_Frame then
				SELL_Frame:Hide()
			end
		elseif event == "BANKFRAME_OPENED" and not InCombatLockdown()  then
			MASLENGO_BANK()
		elseif event == "BANKFRAME_CLOSED" or event == "PLAYER_STARTED_MOVING" then
			if FROMBANK_Frame then
				FROMBANK_Frame:Hide()
			end
			if TOBANK_Frame then
				TOBANK_Frame:Hide()
			end
		end
	end
end
Octo_MAIL_DragonflyOnLoad()

