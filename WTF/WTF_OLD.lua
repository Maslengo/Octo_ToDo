local GlobalAddonName, E = ...
----------------------------------------------------------------
local currentVersion = tonumber(C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version"):match("v(%d+%.%d+)")) -- lastAddonVersion
----------------------------------------------------------------
local function compareVersion(v1, v2)
	return v1 > (v2 or 0)
end
----------------------------------------------------------------
local function updateChars(CharInfo)
	local pd = CharInfo and CharInfo.PlayerData
	local cm = CharInfo and CharInfo.MASLENGO
	if pd and cm then
		local CharDBVersion = pd.CharDBVersion
		----------------------------------------------------------------
		if compareVersion(96.7, CharDBVersion) then
			cm.currencyID = nil
			cm.CurrencyID_Total = nil
			cm.CurrencyID_totalEarned = nil
		end
		----------------------------------------------------------------
		if compareVersion(108.0, CharDBVersion) then
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
	end
end
----------------------------------------------------------------
local function updateGlobal(GlobalDBVersion)
	----------------------------------------------------------------
	if compareVersion(108.0, GlobalDBVersion) then
		Octo_profileKeys = {}
		E.func_CreateNewProfile("Default")
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
function E.func_setOldChanges()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels or {}) do
		updateChars(CharInfo)
		local pd = CharInfo and CharInfo.PlayerData
		if pd then
			pd.CharDBVersion = currentVersion
		end
	end
	Octo_ToDo_DB_Vars = Octo_ToDo_DB_Vars or {}
	Octo_ToDo_DB_Vars.GlobalDBVersion = Octo_ToDo_DB_Vars.GlobalDBVersion or 1
	updateGlobal(Octo_ToDo_DB_Vars.GlobalDBVersion)
	Octo_ToDo_DB_Vars.GlobalDBVersion = currentVersion
end
----------------------------------------------------------------