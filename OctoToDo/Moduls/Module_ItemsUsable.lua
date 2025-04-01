local GlobalAddonName, E = ...
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibCustomGlow = LibStub("LibCustomGlow-1.0")
------------------------------------------------------
local OctoToDo_EventFrame_ItemsUsable = CreateFrame("Frame")
OctoToDo_EventFrame_ItemsUsable:Hide()
----------------------------------------------------------------------------
local inspectScantipUsable = CreateFrame("GameTooltip", "OctoToDoScanningTooltipUsable", nil, "GameTooltipTemplate")
inspectScantipUsable:SetOwner(UIParent, "ANCHOR_NONE")


function OctoToDo_EventFrame_ItemsUsable:TEST_FUNC(itemLink)
	if itemLink then
		local count = 0
		inspectScantipUsable:ClearLines()
		inspectScantipUsable:SetHyperlink(itemLink)
		if inspectScantipUsable:NumLines() > 0 then
			for i = 1, inspectScantipUsable:NumLines() do
				local r, g, b, a = _G["OctoToDoScanningTooltipUsableTextLeft"..i]:GetTextColor()
				local TEXTLEFT = _G["OctoToDoScanningTooltipUsableTextLeft"..i]:GetText()
				local QWE_LEFT = E.func_coloredText(_G["OctoToDoScanningTooltipUsableTextLeft"..i])
				local TEXTRIGHT = _G["OctoToDoScanningTooltipUsableTextRight"..i]:GetText()
				local QWE_RIGHT = E.func_coloredText(_G["OctoToDoScanningTooltipUsableTextRight"..i])
				if TEXTLEFT and TEXTLEFT ~= "" and QWE_LEFT ~= nil then
					if QWE_LEFT:find("^|cffFF2020") or QWE_LEFT:find("^|cffFF0000") then
						count = count + 1
					end
				end
				if TEXTRIGHT and TEXTRIGHT ~= "" and QWE_RIGHT ~= nil then
					if QWE_RIGHT:find("^|cffFF2020") or QWE_RIGHT:find("^|cffFF0000") then
						count = count + 1
					end
				end
			end
		end
		inspectScantipUsable:ClearLines()
		return count
	end
end

function OctoToDo_EventFrame_ItemsUsable:ItemsUsableFrame()
	if not InCombatLockdown() then
		Clickable_ItemsUsable:Hide()
		Clickable_ItemsUsable.icon:SetTexture(413587)
		Clickable_ItemsUsable.text:SetText("")
		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
				local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
				if containerInfo then
					local itemID = containerInfo.itemID
					if itemID and E.OctoTable_itemID_ItemsUsable[itemID] and not E.OctoTable_itemID_Ignore_List[itemID] and C_Item.GetItemCount(itemID) >= E.OctoTable_itemID_ItemsUsable[itemID] then
						if self:TEST_FUNC(E.func_GetItemLink(itemID)) == 0 then
							Clickable_ItemsUsable:Show()
							if not InCombatLockdown() then
								Clickable_ItemsUsable:SetAttribute("macrotext", "/use item:"..itemID)
							end
							Clickable_ItemsUsable.icon:SetTexture(select(10, C_Item.GetItemInfo(itemID)) or 413587)
							local RGB = E.func_GetItemQualityColor(itemID)
							if RGB then
								local r, g, b = RGB.r, RGB.g, RGB.b
								Clickable_ItemsUsable:SetBackdropBorderColor(r, g, b, 1)
							end
							Clickable_ItemsUsable.itemID = itemID
							Clickable_ItemsUsable.text:SetText(" "..C_Item.GetItemCount(itemID, true, true, true).." "..E.func_itemName(itemID))
							break
						end
					end
				end
			end
		end
	end
end

----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"BAG_UPDATE_DELAYED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_REGEN_ENABLED",
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_ItemsUsable, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_ItemsUsable:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		local Clickable_ItemsUsable = CreateFrame("Button", "Clickable_ItemsUsable", UIParent, "SecureActionButtonTemplate, BackDropTemplate")
		Clickable_ItemsUsable:Hide()
		Clickable_ItemsUsable:SetSize(64*E.scale, 64*E.scale)
		Clickable_ItemsUsable:SetPoint("TOPLEFT", 0, 0)
		Clickable_ItemsUsable:SetBackdrop({edgeFile = E.edgeFile, edgeSize = 1})
		Clickable_ItemsUsable:SetBackdropBorderColor(1, 1, 1, 1)
		Clickable_ItemsUsable:HookScript("OnEnter", function()
				GameTooltip:SetOwner(Clickable_ItemsUsable, "ANCHOR_BOTTOMRIGHT", 20, -20) -- ANCHOR_CURSOR
				GameTooltip:ClearLines()
				if Clickable_ItemsUsable.itemID then
					local itemLink = select(2, C_Item.GetItemInfo(Clickable_ItemsUsable.itemID))
					GameTooltip:SetHyperlink(itemLink)
				else
					GameTooltip:SetText(E.Black_Color.."Clickable_ItemsUsable".."|r")
				end
				GameTooltip:Show()
				-- LibCustomGlow.ButtonGlow_Start(Clickable_ItemsUsable, {.31, 1, .47, 1}, .1)
				LibCustomGlow.AutoCastGlow_Start(
					Clickable_ItemsUsable,     -- `frame` - target frame to set glowing;
					{.31, 1, .47, 1},     -- `color` - {r,g,b,a}, color of particles and opacity, from 0 to 1. Default value is {0.95, 0.95, 0.32, 1};
					4,                     -- `N` - number of particle groups. Each group contains 4 particles. Default value is 4;
					0.125,                 -- `frequency` - frequency, set to negative to inverse direction of rotation. Default value is 0.125;
					1,                     -- `scale` - scale of particles;
					nil,                 -- `xOffset`,`yOffset`
					1                     -- `key` - key of glow, allows for multiple glows on one frame;
				)
		end)
		Clickable_ItemsUsable:HookScript("OnLeave", function()
				GameTooltip:ClearLines()
				GameTooltip:Hide()
				-- LibCustomGlow.ButtonGlow_Stop(Clickable_ItemsUsable)
				LibCustomGlow.AutoCastGlow_Stop(Clickable_ItemsUsable)
		end)
		Clickable_ItemsUsable:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
		Clickable_ItemsUsable:SetAttribute("type", "macro")
		Clickable_ItemsUsable.text = Clickable_ItemsUsable:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		Clickable_ItemsUsable.text:SetPoint("LEFT", Clickable_ItemsUsable, "RIGHT")
		Clickable_ItemsUsable.text:SetFontObject(OctoFont22)
		-- Clickable_ItemsUsable.text:SetFont(E.OctoFont, 22, "OUTLINE")
		Clickable_ItemsUsable.text:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
		Clickable_ItemsUsable.icon = Clickable_ItemsUsable:CreateTexture(nil, "BACKGROUND")
		Clickable_ItemsUsable.icon:SetAllPoints(Clickable_ItemsUsable)
		Clickable_ItemsUsable.icon:SetTexture(413587)
	end
end

function OctoToDo_EventFrame_ItemsUsable:BAG_UPDATE_DELAYED()
	if not InCombatLockdown() then
		self:ItemsUsableFrame()
	end
end

function OctoToDo_EventFrame_ItemsUsable:PLAYER_REGEN_DISABLED()
	if Clickable_ItemsUsable and Clickable_ItemsUsable:IsShown() then
		Clickable_ItemsUsable:Hide()
	end
end

function OctoToDo_EventFrame_ItemsUsable:PLAYER_REGEN_ENABLED()
	----------------------------------------------------------------
	self:ItemsUsableFrame()
	----------------------------------------------------------------
end


