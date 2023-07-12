local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
local Octo_AUTO_OPEN = CreateFrame("Frame", AddonTitle)
--local Enable_Module = true
--Octo_AUTO_OPEN:RegisterEvent("PLAYER_ENTERING_WORLD")
Octo_AUTO_OPEN:RegisterEvent("BAG_UPDATE_DELAYED")
Octo_AUTO_OPEN:RegisterEvent("PLAYER_REGEN_ENABLED")
Octo_AUTO_OPEN:RegisterEvent("BAG_UPDATE")
Octo_AUTO_OPEN:RegisterEvent("LOOT_READY")
Octo_AUTO_OPEN:RegisterEvent("PLAYER_STARTED_MOVING")
local isDead = UnitIsDead("PLAYER")
local UnitLevel = UnitLevel("PLAYER")
-- local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
 if UnitLevel >= 60 then
	E.Octo_Func.TableConcat(E.Octo_Table.AutoOpen_openableIDs,E.Octo_Table.AutoOpen_openableIDs70lvl)
end
 local function OpenableScan()
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		for numSlots = C_Container.GetContainerNumSlots(bag),1,-1 do
			local containerInfo = C_Container.GetContainerItemInfo(bag, numSlots)
			if containerInfo then
				local itemID = containerInfo.itemID
				local isLocked = containerInfo.isLocked
				local iconFileID = containerInfo.iconFileID
				local name, itemLink = GetItemInfo(itemID)
				if E.Octo_Table.AutoOpen_openableIDs[itemID] and not isLocked then
					C_Container.UseContainerItem(bag, numSlots)
					--self:SetAttribute("macrotext", "/use item:"..itemID)
					if iconFileID and itemLink then
						print("|cffd177ffA|r|cffc77bfdu|r|cffbd7ffat|r|cffb483f7o|r |cffa987f4O|r|cff9f8bf1p|r|cff968fefe|r|cff8b93ecn|r |cff8197e9I|r|cff779be6t|r|cff6d9fe3e|r|cff63a4e0m|r |T "..iconFileID..":16:16:::64:64:4:60:4:60|t "..itemLink)
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
					if event == "BAG_UPDATE" then
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
