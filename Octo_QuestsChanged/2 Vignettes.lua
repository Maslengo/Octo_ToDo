local GlobalAddonName, ns = ...
E = _G.OctoEngine
if not C_EventUtils.IsEventValid("VIGNETTE_MINIMAP_UPDATED") then return end
local Octo_EventFrame = CreateFrame("FRAME")
Octo_EventFrame:Hide()


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
	if not Octo_QuestsChanged_DB then return end
	Octo_QuestsChanged_DB.QC_Vignettes = Octo_QuestsChanged_DB.QC_Vignettes or {}
	local GUID = vignetteInfo.vignetteGUID
	local atlasName = vignetteInfo.atlasName
	local id = vignetteInfo.vignetteID
	local name = vignetteInfo.name
	local mapID, x, y = VignettePosition(GUID)
	local curLocation, locationsFind = E.func_GetCurrentLocation()
	if mapID and locationsFind then
		local vignetteKey = atlasName..name..mapID..E.curCharName
		if not Octo_QuestsChanged_DB.QC_Vignettes[vignetteKey] then
			if Octo_ToDo_DB_Vars.DebugQC_Vignettes then
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
			Octo_QuestsChanged_DB.QC_Vignettes[vignetteKey] = vignettes
		end
	end
end
function Octo_EventFrame:OnVignetteEvent()
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
	"PLAYER_ENTERING_WORLD",
	"VIGNETTES_UPDATED",
	"VIGNETTE_MINIMAP_UPDATED",
	"ZONE_CHANGED",
	"ZONE_CHANGED_NEW_AREA",
	"ZONE_CHANGED_INDOORS",
}
E.func_RegisterMyEventsToFrames(Octo_EventFrame, MyEventsTable)
function Octo_EventFrame:PLAYER_ENTERING_WORLD()
	Octo_EventFrame:OnVignetteEvent()
end
function Octo_EventFrame:VIGNETTES_UPDATED()
	Octo_EventFrame:OnVignetteEvent()
end
function Octo_EventFrame:VIGNETTE_MINIMAP_UPDATED()
	Octo_EventFrame:OnVignetteEvent()
end
function Octo_EventFrame:ZONE_CHANGED()
	Octo_EventFrame:OnVignetteEvent()
end
function Octo_EventFrame:ZONE_CHANGED_NEW_AREA()
	Octo_EventFrame:OnVignetteEvent()
end
function Octo_EventFrame:ZONE_CHANGED_INDOORS()
	Octo_EventFrame:OnVignetteEvent()
end