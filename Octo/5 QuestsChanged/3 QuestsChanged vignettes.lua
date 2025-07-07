local GlobalAddonName, E = ...
local enable = true
if enable then
	print (E.func_Gradient("3 QuestsChanged vignettes: ")..VIDEO_OPTIONS_ENABLED)


	local function VignettePosition(vignetteGUID)
		local mapID = C_Map.GetBestMapForUnit('player')
		if not mapID then return end
		local position = C_VignetteInfo.GetVignettePosition(vignetteGUID, mapID)
		if position then
			return mapID, position, position:GetXY()
		end
	end
	local log = {}
	local ordered = {}
	E.vignetteLog = log
	E.vignetteLogOrder = ordered
	-- QClog = log
	function E:OnVignetteEvent()



		local vignetteids = C_VignetteInfo.GetVignettes()

		if not vignetteids then return end

		for i, instanceid in ipairs(vignetteids) do
			local vignetteInfo = C_VignetteInfo.GetVignetteInfo(instanceid)
			if vignetteInfo and vignetteInfo.vignetteGUID and not log[vignetteInfo.vignetteGUID] then
				local mapID, _, x, y = VignettePosition(vignetteInfo.vignetteGUID)
				log[vignetteInfo.vignetteGUID] = {
					id = vignetteInfo.vignetteID,
					time = time(),
					mapID = mapID or 0, -- locations might be nil if it's from an instance
					x = x or 0,
					y = y or 0,
					playerName = E.curCharName,
					curServer = GetRealmName(),
					classColorHex = E.classColorHexCurrent,

					guid = vignetteInfo.vignetteGUID,
					name = vignetteInfo.name,
					atlas = vignetteInfo.atlasName,
				}
				table.insert(ordered, vignetteInfo.vignetteGUID)
				table.insert(Octo_QuestsChangedDB.vignette, log[vignetteInfo.vignetteGUID])
				fpde(Octo_QuestsChangedDB.vignette)




				self:TriggerEvent(self.Event.OnVignetteAdded, log[vignetteInfo.vignetteGUID], vignetteInfo.vignetteGUID)
			end
		end
	end
	E.PLAYER_ENTERING_WORLD = E.OnVignetteEvent
	E.VIGNETTE_MINIMAP_UPDATED = E.OnVignetteEvent
	E.VIGNETTES_UPDATED = E.OnVignetteEvent

	function E:RemoveVignette(vignette)
		if not (vignette and vignette.guid) then return end
		log[vignette.guid] = nil
		table.remove(ordered, tIndexOf(ordered, vignette.guid))
		self:TriggerEvent(self.Event.OnVignetteRemoved, vignette, vignette.guid)
	end
end