local GlobalAddonName, E = ...
----------------------------------------------------------------
local function Collect_Mounts()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	local GetMountIDs = C_MountJournal.GetMountIDs
	local GetMountInfoExtraByID = C_MountJournal.GetMountInfoExtraByID
	local cache_1166 = E.func_Mounts_1166()
	E.OctoTable_ALL_Mounts[1166] = E.OctoTable_ALL_Mounts[1166] or {}
	local cache_3252 = E.func_Mounts_3252()
	E.OctoTable_ALL_Mounts[3252] = E.OctoTable_ALL_Mounts[3252] or {}
	local cache_2778 = E.func_Mounts_2778()
	E.OctoTable_ALL_Mounts[2778] = E.OctoTable_ALL_Mounts[2778] or {}

	for _, mountID in ipairs(GetMountIDs()) do
		local _, _, source = GetMountInfoExtraByID(mountID)
		source = source:gsub(" ", "") -- mountID == 645
		source = source:gsub(",", "") -- mountID == 645
		source = source:gsub(" ", "") -- mountID == 645
		local price, currencyID = source:match("([%d %.,]+)|Hcurrency:(%d+)")
		local curName = E.func_GetCurrencyName(currencyID)
		-- local mouName = E.func_GetMountName(mountID)
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
		for i, v in ipairs(cache_1166) do
			if v.itemID then
				local mountID = v.mountID or C_MountJournal.GetMountFromItem(v.itemID)
				if mountID then
					E.OctoTable_ALL_Mounts[1166][mountID] = v.price
				end
			end
		end
		-- Бронза (legion)
		for i, v in ipairs(cache_3252) do
			if v.itemID then
				local mountID = v.mountID or C_MountJournal.GetMountFromItem(v.itemID)
				if mountID then
					E.OctoTable_ALL_Mounts[3252][mountID] = v.price
				end
			end
		end
		-- Бронза (panda)
		for i, v in ipairs(cache_2778) do
			if v.itemID then
				local mountID = v.mountID or C_MountJournal.GetMountFromItem(v.itemID)
				if mountID then
					E.OctoTable_ALL_Mounts[2778][mountID] = v.price
				end
			end
		end


	end
end
----------------------------------------------------------------
function E.Collect_Mounts()
	E.func_SpamBlock(Collect_Mounts, false)
end