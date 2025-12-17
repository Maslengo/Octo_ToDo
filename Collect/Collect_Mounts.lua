local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Mounts()
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	if not collectPlayerData then return end

	local GetMountIDs = C_MountJournal.GetMountIDs
	local GetMountInfoExtraByID = C_MountJournal.GetMountInfoExtraByID
	for _, mountID in ipairs(GetMountIDs()) do
		local _, _, source = GetMountInfoExtraByID(mountID)
		local price, currencyID = source:match("([%d %.,]+)|Hcurrency:(%d+)")
		local curName = E.func_GetCurrencyName(currencyID)
		local mouName = E.func_GetMountName(mountID)
		if price and currencyID then
			if type(price) == "string" then
				price = price:gsub("[%s%.]", "")
				price = tonumber(price)
			end
			currencyID = tonumber(currencyID)
			E.ALL_Currencies[currencyID] = true
			E.OctoTable_CurrencyMountForFuncCurName[currencyID] = true
			E.OctoTable_ALL_Mounts[currencyID] = E.OctoTable_ALL_Mounts[currencyID] or {}
			E.OctoTable_ALL_Mounts[currencyID][mountID] = price
		end
		-- таймволк
		E.OctoTable_ALL_Mounts[1166] = E.OctoTable_ALL_Mounts[1166] or {}
		for i, v in ipairs(E.func_Mounts_1166()) do
			E.OctoTable_ALL_Mounts[1166][v.mountID] = v.price
		end
		-- Бронза
		E.OctoTable_ALL_Mounts[3252] = E.OctoTable_ALL_Mounts[3252] or {}
		for i, v in ipairs(E.func_Mounts_3252()) do
			E.OctoTable_ALL_Mounts[3252][v.mountID] = v.price
		end
	end
end
----------------------------------------------------------------
function E.Collect_Mounts()
	E.func_SpamBlock(Collect_Mounts, false)
end