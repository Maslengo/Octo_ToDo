local GlobalAddonName, E = ... 
----------------------------------------------------------------------------------------------------------------------------------
-- Auto_Open
local OctoToDo_AUTO_OPEN = CreateFrame("Frame", GlobalAddonName.."Auto_Open"..E.func_GenerateUniqueID())
OctoToDo_AUTO_OPEN:RegisterEvent("BAG_UPDATE_DELAYED")
OctoToDo_AUTO_OPEN:RegisterEvent("PLAYER_REGEN_ENABLED")
OctoToDo_AUTO_OPEN:RegisterEvent("LOOT_READY")
OctoToDo_AUTO_OPEN:RegisterEvent("PLAYER_STARTED_MOVING")
local isDead = UnitIsDead("PLAYER")
local function OpenableScan()
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		for numSlots = C_Container.GetContainerNumSlots(bag),1,-1 do
			local containerInfo = C_Container.GetContainerItemInfo(bag, numSlots)
			if containerInfo then
				local itemID = containerInfo.itemID
				local isLocked = containerInfo.isLocked
				local iconFileID = containerInfo.iconFileID
				local itemLink = select(2, C_Item.GetItemInfo(itemID))
				for _, ids in next, (E.OctoTable_itemID_AutoOpen) do
					if ids == itemID and itemLink and not isLocked then
						if iconFileID and itemLink and not InCombatLockdown() then
							C_Timer.After(1, function()
								if not InCombatLockdown() then
									C_Container.UseContainerItem(bag, numSlots)
									print (E.func_Gradient("Auto Open Item ", E.Addon_Left_Color, E.Addon_Right_Color), E.func_texturefromIcon(iconFileID)..itemLink)
								end
							end)
						end
					end
				end
			end
		end
	end
end
local openableScanQueued = false
OctoToDo_AUTO_OPEN:SetScript("OnEvent", function(self, event, ...)
		C_Timer.After(0.1, function()
				if OctoToDo_DB_Vars.AutoOpen then
					if event == "BAG_UPDATE_DELAYED" then
						if not InCombatLockdown() and isDead == false then
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