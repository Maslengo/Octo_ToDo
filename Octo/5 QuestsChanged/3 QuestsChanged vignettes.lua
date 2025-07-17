local GlobalAddonName, E = ...
if not E.Enable_QuestsChanged then return end

if not C_EventUtils.IsEventValid("VIGNETTE_MINIMAP_UPDATED") then return end


local Octo_EventFrame_Vignettes = CreateFrame("FRAME")
Octo_EventFrame_Vignettes:Hide()
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
function Octo_EventFrame_Vignettes:OnVignetteEvent()
	local vignetteids = C_VignetteInfo.GetVignettes()
	if not vignetteids then return end
	-- print (GetZoneText(), GetSubZoneText(), GetRealZoneText())
	-- print (E:func_GetCurrentLocation())
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
				curLocation = E:func_GetCurrentLocation(),
				specIcon = select(4, GetSpecializationInfo(GetSpecialization())),
				guid = vignetteInfo.vignetteGUID,
				name = vignetteInfo.name,
				atlas = vignetteInfo.atlasName,
			}
			table.insert(ordered, vignetteInfo.vignetteGUID)
			table.insert(Octo_QuestsChangedDB.QC_Vignettes, log[vignetteInfo.vignetteGUID])
			E:TriggerEvent(E.Event.OnVignetteAdded, log[vignetteInfo.vignetteGUID], vignetteInfo.vignetteGUID)
		end
	end
end
local MyEventsTable = {
	-- "PLAYER_ENTERING_WORLD",
	"VIGNETTES_UPDATED",
	"VIGNETTE_MINIMAP_UPDATED",
	"ZONE_CHANGED",
	"ZONE_CHANGED_NEW_AREA",
	"ZONE_CHANGED_INDOORS",
}
E:func_RegisterMyEventsToFrames(Octo_EventFrame_Vignettes, MyEventsTable)

-- function Octo_EventFrame_Vignettes:PLAYER_ENTERING_WORLD()
	C_Timer.After(2, function()
			Octo_EventFrame_Vignettes:OnVignetteEvent()
	end)
-- end
Octo_EventFrame_Vignettes.VIGNETTES_UPDATED = Octo_EventFrame_Vignettes.OnVignetteEvent
Octo_EventFrame_Vignettes.VIGNETTE_MINIMAP_UPDATED = Octo_EventFrame_Vignettes.OnVignetteEvent
Octo_EventFrame_Vignettes.ZONE_CHANGED = Octo_EventFrame_Vignettes.OnVignetteEvent
Octo_EventFrame_Vignettes.ZONE_CHANGED_INDOORS = Octo_EventFrame_Vignettes.OnVignetteEvent
Octo_EventFrame_Vignettes.ZONE_CHANGED_NEW_AREA = Octo_EventFrame_Vignettes.OnVignetteEvent

-- function Octo_EventFrame_Vignettes:ZONE_CHANGED()
-- 	self:OnVignetteEvent()
-- end
-- function Octo_EventFrame_Vignettes:ZONE_CHANGED_INDOORS()
-- 	self:OnVignetteEvent()
-- end
-- function Octo_EventFrame_Vignettes:ZONE_CHANGED_NEW_AREA()
-- 	self:OnVignetteEvent()
-- end
function E:RemoveVignette(QC_Vignettes)
	if not (QC_Vignettes and QC_Vignettes.guid) then return end
	log[QC_Vignettes.guid] = nil
	table.remove(ordered, tIndexOf(ordered, QC_Vignettes.guid))
	self:TriggerEvent(self.Event.OnVignetteRemoved, QC_Vignettes, QC_Vignettes.guid)
end