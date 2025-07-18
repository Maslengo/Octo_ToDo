local GlobalAddonName, E = ...

function E.Collect_All_BfA_Cloaklvl()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if collectPlayerData and not InCombatLockdown() then
		local hasItem = E:func_GetItemCount(169223, true, true, true, false)
		if hasItem ~= 0 then
			local itemLink = GetInventoryItemLink("player", 15)
			if itemLink then
				local itemID = itemLink:match("item:(%d+)")
				if itemID == "169223" then
					local itemLevel = select(4, E:func_GetItemInfo(itemLink))
					if itemLevel then
						collectPlayerData.cloak_lvl = min(15, max((itemLevel - 125) / 2 + 1, 1))
					end
				end
			end
			if itemLink and itemLink:find("item:169223:") then
				OctpToDo_inspectScantip:SetInventoryItem("player", 15)
				if OctpToDo_inspectScantip:NumLines() > 0 then
					for j = 2, OctpToDo_inspectScantip:NumLines() do
						local text = _G["OctoScanningTooltipFIRSTTextLeft"..j]:GetText()
						if text and text ~= "" then
							local res = text:gsub("[, ]", ""):gsub("(%d+)[ ]+(%d+)", "%1%2"):match("%+(%d+) ?"..(ITEM_MOD_CORRUPTION_RESISTANCE or "Corruption resistance").."$")
							if res then
								collectPlayerData.cloak_res = res
								break
							end
						end
					end
				end
				OctpToDo_inspectScantip:ClearLines()
			end
		else
			collectPlayerData.cloak_lvl = nil
			collectPlayerData.cloak_res = nil
		end
	end
end