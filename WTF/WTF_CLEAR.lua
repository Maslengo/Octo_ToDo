local GlobalAddonName, E = ...
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
function E.Cleanup_Obsolete_Reputations()
	-- E.DEBUG_START() -- 7 ms
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local cm = CharInfo.MASLENGO
		if cm then
			if cm.Reputation then
				for reputationID in next, cm.Reputation do
					if not E.TBL_validReps[reputationID] then
						-- E.func_PrintMessage(pd.classColorHex..pd.Name.."|r", "cm.Reputation[reputationID] = nil")
						cm.Reputation[reputationID] = nil
					end
				end
			end
			----------------------------------------------------------------
			-- /run opde(Octo_ToDo_DB_Levels[E.curGUID])
			cm.GarrisonFollowers = nil
			cm.GarrisonFollowersCount = nil
			cm.garrisonType = nil
			cm.HasGarrison = nil
			cm.ItemsALL = nil
			----------------------------------------------------------------
			if cm.Currency then
				for currencyID, v in next, (cm.Currency) do
					if not next(v) then
						cm.Currency[currencyID] = nil
						-- E.func_PrintMessage(pd.classColorHex..pd.Name.."|r", "cm.Currency[currencyID] = nil")
					end
				end
			end
			----------------------------------------------------------------
		end
	end
	-- E.DEBUG_STOP()
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
----------------------------------------------------------------
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
end
function EventFrame:PLAYER_LOGIN()
	E.Cleanup_Obsolete_Reputations()
end