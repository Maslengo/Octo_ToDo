local GlobalAddonName, E = ...
local LibCustomGlow = LibStub("LibCustomGlow-1.0")

-----------------------------------------------------
local Octo_EventFrame_ItemsDelete = CreateFrame("Frame")
Octo_EventFrame_ItemsDelete:Hide()
-----------------------------------------------------

-- Cache frequently used functions
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetItemInfo = C_Item.GetItemInfo
local GetItemCount = C_Item.GetItemCount
local PickupContainerItem = C_Container.PickupContainerItem
local DeleteCursorItem = DeleteCursorItem

-- Local references for better performance
local Red_Color = E.Red_Color
local func_GetItemName = E.func_GetItemName
local OctoTable_itemID_ItemsDelete = E.OctoTable_itemID_ItemsDelete

function Octo_EventFrame_ItemsDelete:ItemsDeleteFrame()
	if InCombatLockdown() then return end

	local foundItem = false

	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		for slot = GetContainerNumSlots(bag), 1, -1 do
			local containerInfo = GetContainerItemInfo(bag, slot)
			if containerInfo and OctoTable_itemID_ItemsDelete[containerInfo.itemID] then
				local itemID = containerInfo.itemID
				local _, itemLink, _, _, _, _, _, _, _, itemTexture = GetItemInfo(itemID)

				Clickable_ItemsDelete:Show()
				Clickable_ItemsDelete:SetScript("OnClick", function()
					PickupContainerItem(bag, slot)
					DeleteCursorItem()
					Clickable_ItemsDelete:Hide()
				end)

				Clickable_ItemsDelete.icon:SetTexture(itemTexture or 413587)
				Clickable_ItemsDelete.itemID = itemID
				Clickable_ItemsDelete.text:SetText(" "..GetItemCount(itemID, false, false, false).." "..Red_Color..func_GetItemName(itemID).."|r")

				foundItem = true
				break
			end
		end
		if foundItem then break end
	end

	if not foundItem then
		Clickable_ItemsDelete:Hide()
		Clickable_ItemsDelete.icon:SetTexture(413587)
		Clickable_ItemsDelete.text:SetText("")
	end
end

----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"BAG_UPDATE_DELAYED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_REGEN_ENABLED",
}

E.RegisterMyEventsToFrames(Octo_EventFrame_ItemsDelete, MyEventsTable, E.func_DebugPath())

function Octo_EventFrame_ItemsDelete:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil

	local Clickable_ItemsDelete = CreateFrame("Button", "Clickable_ItemsDelete", UIParent, "SecureActionButtonTemplate, BackDropTemplate")
	Clickable_ItemsDelete:Hide()
	Clickable_ItemsDelete:SetSize(64*E.scale, 64*E.scale)
	Clickable_ItemsDelete:SetPoint("TOPLEFT", 0, -128*E.scale)
	Clickable_ItemsDelete:SetBackdrop({edgeFile = E.edgeFile, edgeSize = 1})
	Clickable_ItemsDelete:SetBackdropBorderColor(1, 0, 0, 1)

	local function OnEnter()
		GameTooltip:SetOwner(Clickable_ItemsDelete, "ANCHOR_BOTTOMRIGHT", 20, -20)
		GameTooltip:ClearLines()

		if Clickable_ItemsDelete.itemID then
			local itemLink = select(2, GetItemInfo(Clickable_ItemsDelete.itemID))
			GameTooltip:SetHyperlink(itemLink)
		else
			GameTooltip:SetText(E.Black_Color.."Clickable_ItemsDelete".."|r")
		end
		GameTooltip:Show()

		LibCustomGlow.AutoCastGlow_Start(
			Clickable_ItemsDelete,
			{1, 0, 0, 1},
			4,
			0.125,
			1,
			nil,
			1
		)
	end

	local function OnLeave()
		GameTooltip:ClearLines()
		GameTooltip:Hide()
		LibCustomGlow.AutoCastGlow_Stop(Clickable_ItemsDelete)
	end

	Clickable_ItemsDelete:HookScript("OnEnter", OnEnter)
	Clickable_ItemsDelete:HookScript("OnLeave", OnLeave)
	Clickable_ItemsDelete:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	Clickable_ItemsDelete:SetAttribute("type", "macro")

	Clickable_ItemsDelete.text = Clickable_ItemsDelete:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	Clickable_ItemsDelete.text:SetPoint("LEFT", Clickable_ItemsDelete, "RIGHT")
	Clickable_ItemsDelete.text:SetFontObject(OctoFont22)
	Clickable_ItemsDelete.text:SetText(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"))

	Clickable_ItemsDelete.icon = Clickable_ItemsDelete:CreateTexture(nil, "BACKGROUND")
	Clickable_ItemsDelete.icon:SetAllPoints(Clickable_ItemsDelete)
	Clickable_ItemsDelete.icon:SetTexture(413587)
end

function Octo_EventFrame_ItemsDelete:BAG_UPDATE_DELAYED()
	if not InCombatLockdown() then
		self:ItemsDeleteFrame()
	end
end

function Octo_EventFrame_ItemsDelete:PLAYER_REGEN_DISABLED()
	if Clickable_ItemsDelete then
		Clickable_ItemsDelete:Hide()
	end
end

function Octo_EventFrame_ItemsDelete:PLAYER_REGEN_ENABLED()
	self:ItemsDeleteFrame()
end