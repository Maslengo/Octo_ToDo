local GlobalAddonName, E = ...
----------------------------------------------------------------
----------------------------------------------------------------
local function compareVersion(v1, v2)
	return v1 > (v2 or 0)
end
----------------------------------------------------------------
local function updateChars(pd, cm, DBVersion)
	----------------------------------------------------------------
	if compareVersion(96.7, DBVersion) then
		print ("96.7, DBVersion) then")
		cm.currencyID = nil
		cm.CurrencyID_Total = nil
		cm.CurrencyID_totalEarned = nil
	end
	----------------------------------------------------------------
	if compareVersion(108.0, DBVersion) then
		if cm.GreatVault then
			wipe(cm.GreatVault)
		end
		cm.GreatVault = {}
		if Enum and Enum.WeeklyRewardChestThresholdType then
			for name, i in next, Enum.WeeklyRewardChestThresholdType do
				cm.GreatVault[i] = cm.GreatVault[i] or {}
			end
		end
	end
	----------------------------------------------------------------
	if compareVersion(108.5, DBVersion) then
		cm.Items = cm.Items or {}
		cm.Items.Bags = cm.Items.Bags or {}
		if cm.ItemsInBag then
			for itemID, count in next,(cm.ItemsInBag) do
				print (pd.Name, itemID, count)
				cm.Items.Bags[itemID] = count
			end
			cm.ItemsInBag = nil
		end
		if pd.usedSlots then
			pd.usedSlots_BAGS = pd.usedSlots
			pd.usedSlots = nil
		end
		if pd.totalSlots then
			pd.totalSlots_BAGS = pd.totalSlots
			pd.totalSlots = nil
		end
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
local function updateGlobal(DBVersion)
	----------------------------------------------------------------
	-- if compareVersion(108.0, DBVersion) then
	-- 	Octo_profileKeys = {}
	-- 	E.func_CreateNewProfile("Default")
	-- end
	----------------------------------------------------------------
	if compareVersion(108.5, DBVersion) then
		Octo_ToDo_DB_Vars.Config_SPAM_TIME = 2
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
function E.func_setOldChanges()
	local currentVersion = tonumber(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"):match("v(%d+%.%d+)")) -- lastAddonVersion
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels or {}) do
		local pd = CharInfo and CharInfo.PlayerData
		local cm = CharInfo and CharInfo.MASLENGO
		if pd and cm then
			local DBVersion = pd.CharDBVersion
			updateChars(pd, cm, DBVersion)
			pd.CharDBVersion = currentVersion
		end
	end
	Octo_ToDo_DB_Vars = Octo_ToDo_DB_Vars or {}
	Octo_ToDo_DB_Vars.GlobalDBVersion = Octo_ToDo_DB_Vars.GlobalDBVersion or 1
	updateGlobal(Octo_ToDo_DB_Vars.GlobalDBVersion)
	Octo_ToDo_DB_Vars.GlobalDBVersion = currentVersion
end
----------------------------------------------------------------