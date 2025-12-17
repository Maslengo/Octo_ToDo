local GlobalAddonName, E = ...
----------------------------------------------------------------
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
function E.Cleanup_Obsolete_Reputations()
	-- E.func_StartDebugTimer()
	local validReps = {}
	for reputationID in next,(E.OctoTable_Reputations_DB) do
		validReps[reputationID] = true
	end
	for GUID, CharInfo in next, Octo_ToDo_DB_Levels do
		local cm = CharInfo.MASLENGO
		if cm and cm.Reputation then
			local toRemove = {}
			for reputationID in next, cm.Reputation do
				if not validReps[reputationID] then
					table.insert(toRemove, reputationID)
				end
			end
			for _, repID in ipairs(toRemove) do
				cm.Reputation[repID] = nil
			end
			if next(cm.Reputation) == nil then
				cm.Reputation = nil
			end
		end
	end
	-- E.func_StopDebugTimer()
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