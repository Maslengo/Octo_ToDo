local GlobalAddonName, ns = ...
E = _G.OctoEngine
--
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
if not C_EventUtils.IsEventValid("VIGNETTE_MINIMAP_UPDATED") then return end
local GetVignettePosition = GetVignettePosition or C_VignetteInfo.GetVignettePosition
local GetVignettes = GetVignettes or C_VignetteInfo.GetVignettes
local GetVignetteInfo = GetVignetteInfo or C_VignetteInfo.GetVignetteInfo
local GetBestMapForUnit = GetBestMapForUnit or C_Map.GetBestMapForUnit
local function VignettePosition(vignetteGUID)
	local mapID = GetBestMapForUnit("PLAYER")
	if not mapID then return end
	local position = GetVignettePosition(vignetteGUID, mapID)
	if position then
		return mapID, position:GetXY()
	end
end
--  Добавление новой виньетки в базу
local function AddVignettesToDB(vignetteInfo)
	local GUID = vignetteInfo.vignetteGUID
	local atlasName = vignetteInfo.atlasName
	local id = vignetteInfo.vignetteID
	local name = vignetteInfo.name
	local mapID, x, y = VignettePosition(GUID)
	local curLocation, locationsFind = E.func_GetCurrentLocation()
	if mapID and locationsFind then
		local vignetteKey = atlasName..name..mapID..E.curCharName
		if not EventFrame.savedVars.QC_Vignettes[vignetteKey] then
			if Octo_Debug_DB.DebugQC_Vignettes then
				print (atlasName, E.Gray_Color.."id:"..id.."|r", E.func_texturefromIcon(atlasName, nil, nil, true), name)
			end
			local vignettes = {
				id = id,
				time = time(),
				mapID = mapID, -- locations might be nil if it's from an instance
				x = x,
				y = y,
				playerName = E.curCharName,
				curServer = GetRealmName(),
				classColorHex = E.classColorHexCurrent,
				curLocation = curLocation,
				specIcon = select(4, GetSpecializationInfo(GetSpecialization())),
				guid = GUID,
				name = name,
				atlas = atlasName,
			}
			EventFrame.savedVars.QC_Vignettes[vignetteKey] = vignettes
		end
	end
end
function EventFrame:OnVignetteEvent()
	local vignetteids = GetVignettes()
	if not vignetteids then return end
	for _, instanceid in ipairs(vignetteids) do
		local vignetteInfo = GetVignetteInfo(instanceid)
		if vignetteInfo then
			if vignetteInfo.atlasName and vignetteInfo.name and Octo_Cache_DB and Octo_Cache_DB.AllVignettes and E.curLocaleLang then
				Octo_Cache_DB.AllVignettes[vignetteInfo.atlasName] = Octo_Cache_DB.AllVignettes[vignetteInfo.atlasName] or {}
				Octo_Cache_DB.AllVignettes[vignetteInfo.atlasName][E.curLocaleLang] = Octo_Cache_DB.AllVignettes[vignetteInfo.atlasName][E.curLocaleLang] or {}
				Octo_Cache_DB.AllVignettes[vignetteInfo.atlasName][E.curLocaleLang][vignetteInfo.name] = true
			end
			AddVignettesToDB(vignetteInfo)
		end
	end
end
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_ENTERING_WORLD",
	"VIGNETTES_UPDATED",
	"VIGNETTE_MINIMAP_UPDATED",
	"ZONE_CHANGED",
	"ZONE_CHANGED_NEW_AREA",
	"ZONE_CHANGED_INDOORS",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
end
function EventFrame:PLAYER_ENTERING_WORLD()
	EventFrame:OnVignetteEvent()
end
function EventFrame:VIGNETTES_UPDATED()
	EventFrame:OnVignetteEvent()
end
function EventFrame:VIGNETTE_MINIMAP_UPDATED()
	EventFrame:OnVignetteEvent()
end
function EventFrame:ZONE_CHANGED()
	EventFrame:OnVignetteEvent()
end
function EventFrame:ZONE_CHANGED_NEW_AREA()
	EventFrame:OnVignetteEvent()
end
function EventFrame:ZONE_CHANGED_INDOORS()
	EventFrame:OnVignetteEvent()
end