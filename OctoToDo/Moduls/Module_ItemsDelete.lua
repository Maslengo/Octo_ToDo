local GlobalAddonName, E = ...
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibCustomGlow = LibStub("LibCustomGlow-1.0")
----------------------------------------------------------------------------------------------------------------------------------
local OctoToDo_EventFrame = CreateFrame("Frame")
OctoToDo_EventFrame:Hide()
OctoToDo_EventFrame:RegisterEvent("ADDON_LOADED")
OctoToDo_EventFrame:RegisterEvent("BAG_UPDATE_DELAYED")
OctoToDo_EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
OctoToDo_EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

function OctoToDo_EventFrame:ItemsDeleteFrame()
	if not InCombatLockdown() then
		Clickable_ItemsDelete:Hide()
		Clickable_ItemsDelete.icon:SetTexture(413587)
		Clickable_ItemsDelete.text:SetText("")
		for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
			for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
				local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
				if containerInfo then
					local itemID = containerInfo.itemID
					if E.OctoTable_itemID_ItemsDelete[itemID] or (E:IsPTR() and E.OctoTable_itemID_ItemsDelete_PTR[itemID]) then
						Clickable_ItemsDelete:Show()
						Clickable_ItemsDelete:SetScript("OnClick", function()
								C_Container.PickupContainerItem(bag, slot)
								DeleteCursorItem()
								Clickable_ItemsDelete:Hide()
						end)
						Clickable_ItemsDelete.icon:SetTexture(select(10, GetItemInfo(itemID)) or 413587)
						Clickable_ItemsDelete.itemID = itemID
						Clickable_ItemsDelete.text:SetText(" "..GetItemCount(itemID, true, true, true).." "..E.Red_Color..E.func_itemName_NOCOLOR(itemID).."|r")
						break
					end
				end
			end
		end
	end
end

OctoToDo_EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

function OctoToDo_EventFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		local Clickable_ItemsDelete = CreateFrame("Button", "Clickable_ItemsDelete", UIParent, "SecureActionButtonTemplate, BackDropTemplate")
		Clickable_ItemsDelete:Hide()
		Clickable_ItemsDelete:SetSize(64*E.scale, 64*E.scale)
		Clickable_ItemsDelete:SetPoint("TOPLEFT", 0, -128*E.scale)
		Clickable_ItemsDelete:SetBackdrop({edgeFile = E.edgeFile, edgeSize = 1})
		Clickable_ItemsDelete:SetBackdropBorderColor(1, 0, 0, 1)
		Clickable_ItemsDelete:HookScript("OnEnter", function()
				GameTooltip:SetOwner(Clickable_ItemsDelete, "ANCHOR_BOTTOMRIGHT", 20, -20) -- ANCHOR_CURSOR
				GameTooltip:ClearLines()
				if Clickable_ItemsDelete.itemID then
					local itemLink = select(2, GetItemInfo(Clickable_ItemsDelete.itemID))
					GameTooltip:SetHyperlink(itemLink)
				else
					GameTooltip:SetText(E.Black_Color.."Clickable_ItemsDelete".."|r")
				end
				GameTooltip:Show()
				-- LibCustomGlow.ButtonGlow_Start(Clickable_ItemsDelete, {.31, 1, .47, 1}, .1)
				LibCustomGlow.AutoCastGlow_Start(
					Clickable_ItemsDelete,     -- `frame` - target frame to set glowing;
					{1, 0, 0, 1},     -- `color` - {r,g,b,a}, color of particles and opacity, from 0 to 1. Default value is {0.95, 0.95, 0.32, 1};
					4,                     -- `N` - number of particle groups. Each group contains 4 particles. Default value is 4;
					0.125,                 -- `frequency` - frequency, set to negative to inverse direction of rotation. Default value is 0.125;
					1,                     -- `scale` - scale of particles;
					nil,                 -- `xOffset`,`yOffset`
					1                     -- `key` - key of glow, allows for multiple glows on one frame;
				)
		end)
		Clickable_ItemsDelete:HookScript("OnLeave", function()
				GameTooltip:ClearLines()
				GameTooltip:Hide()
				-- LibCustomGlow.ButtonGlow_Stop(Clickable_ItemsDelete)
				LibCustomGlow.AutoCastGlow_Stop(Clickable_ItemsDelete)
		end)
		Clickable_ItemsDelete:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
		Clickable_ItemsDelete:SetAttribute("type", "macro")
		Clickable_ItemsDelete.text = Clickable_ItemsDelete:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		Clickable_ItemsDelete.text:SetPoint("LEFT", Clickable_ItemsDelete, "RIGHT")
		Clickable_ItemsDelete.text:SetFontObject(OctoFont22)
		-- Clickable_ItemsDelete.text:SetFont(E.OctoFont, 22, "OUTLINE")
		Clickable_ItemsDelete.text:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))
		Clickable_ItemsDelete.icon = Clickable_ItemsDelete:CreateTexture(nil, "BACKGROUND")
		Clickable_ItemsDelete.icon:SetAllPoints(Clickable_ItemsDelete)
		Clickable_ItemsDelete.icon:SetTexture(413587)
		----------------------------------------------------------------
	end
end



function OctoToDo_EventFrame:BAG_UPDATE_DELAYED()
	----------------------------------------------------------------
	if not InCombatLockdown() then
		self:ItemsDeleteFrame()
	end
	----------------------------------------------------------------
end

function OctoToDo_EventFrame:PLAYER_REGEN_DISABLED()
	----------------------------------------------------------------
	if Clickable_ItemsDelete and Clickable_ItemsDelete:IsShown() then
		Clickable_ItemsDelete:Hide()
	end
	----------------------------------------------------------------
end

function OctoToDo_EventFrame:PLAYER_REGEN_ENABLED()
	----------------------------------------------------------------
	self:ItemsDeleteFrame()
	----------------------------------------------------------------
end

