local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
local Octo_AUTO_OPEN = CreateFrame("Frame", AddonTitle)
Octo_AUTO_OPEN:RegisterEvent("BAG_UPDATE_DELAYED")
Octo_AUTO_OPEN:RegisterEvent("PLAYER_REGEN_ENABLED")
Octo_AUTO_OPEN:RegisterEvent("LOOT_READY")
Octo_AUTO_OPEN:RegisterEvent("PLAYER_STARTED_MOVING")
local isDead = UnitIsDead("PLAYER")
local function OpenableScan()
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		for numSlots = C_Container.GetContainerNumSlots(bag),1,-1 do
			local containerInfo = C_Container.GetContainerItemInfo(bag, numSlots)
			if containerInfo then
				local itemID = containerInfo.itemID
				local isLocked = containerInfo.isLocked
				local iconFileID = containerInfo.iconFileID
				local name, itemLink = GetItemInfo(itemID)
				if E.Octo_Table.AutoOpen_openableIDs[itemID] and itemLink and not isLocked then
					if iconFileID and itemLink then
						C_Timer.After(1, function()
							C_Container.UseContainerItem(bag, numSlots)
							print (E.Octo_Func.func_Gradient("Auto Open Item ", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), E.Octo_Func.func_texturefromIcon(iconFileID)..itemLink)
						end)
					end
				end
			end
		end
	end
end
local openableScanQueued = false
Octo_AUTO_OPEN:SetScript("OnEvent", function(self, event, ...)
		C_Timer.After(0.1, function()
				if Octo_ToDoVars.config.AutoOpen then
					if event == "BAG_UPDATE_DELAYED" then
						if not InCombatLockdown() and isDead == false  then
							OpenableScan()
						else
							openableScanQueued = true
						end
					elseif event == "PLAYER_REGEN_ENABLED" then
						if openableScanQueued then
							openableScanQueued = false
							OpenableScan()
						end
					end
				end
		end)
end)