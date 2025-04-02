local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
function E.CollectAllAddons()
	local collect = OctoToDo_AddonsManager.AddonList
	collect = collect or {}
	wipe(collect)
	local addonsList = {}
	local interfaceVersion = select(4, GetBuildInfo()) or 1
	for i = 1, C_AddOns.GetNumAddOns() do
		local name, title, notes, loadable, reason, security, updateAvailable = C_AddOns.GetAddOnInfo(i)
		if reason ~= "MISSING" then -- Исключаем отсутствующие аддоны
			collect[i] = collect[i] or {}
			local firsticonTexture = ""
			local loadedOrLoading = C_AddOns.IsAddOnLoaded(i) -- and "|cff00ff00ВКЛ|r" or "|cffff0000ВЫКЛ|r" -- STATUS
			local textRIGHT = ""
			local AddonInterfaceVersion = C_AddOns.GetAddOnInterfaceVersion(i)
			local colorAddon = E.White_Color
			local iconTexture = C_AddOns.GetAddOnMetadata(i, "IconTexture") or ""
			local iconAtlas = C_AddOns.GetAddOnMetadata(i, "IconAtlas") or ""
			local Version = C_AddOns.GetAddOnMetadata(i, "Version") or ""
			local Author = C_AddOns.GetAddOnMetadata(i, "Author") or ""
			local RecentAverageTime = E.Red_Color..E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.RecentAverageTime).."%|r" -- ПИКОВЫЙ GPU
			local SessionAverageTime = E.Red_Color..E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.SessionAverageTime).."%|r" -- Average CPU:
			local PeakTime = E.Red_Color..E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.PeakTime).."%|r" -- Peak CPU:
			local EncounterAverageTime = E.Red_Color..E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.EncounterAverageTime).."%|r"  -- Encounter CPU:
			local Ticksover5ms = E.Red_Color..E.GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver5Ms).."|r"
			local Ticksover10ms = E.Red_Color..E.GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver10Ms).."|r"
			local Ticksover50ms = E.Red_Color..E.GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver50Ms).."|r"
			local Ticksover100ms = E.Red_Color..E.GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver100Ms).."|r"
			local Ticksover500ms = E.Red_Color..E.GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver100Ms).."|r"
			local memory = GetAddOnMemoryUsage(i)
			local memoryVivod = 0
			if memory > 0 then
				if memory > 1024 then
					memoryVivod = memory / 1024
				else
					memoryVivod = memory
				end
			end
			if AddonInterfaceVersion < interfaceVersion then
				colorAddon = E.Red_Color
			end
			if loadedOrLoading then
				textRIGHT = ""
				if AddonInterfaceVersion < interfaceVersion then
					textRIGHT = REQUIRES_RELOAD
				else
					textRIGHT = SessionAverageTime
				end



				fivetext = SessionAverageTime
				sixtext = PeakTime
				firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\buttonON"
			else
				textRIGHT = ADDON_DISABLED
				fivetext = ""
				sixtext = ""
				colorAddon = E.Gray_Color
				firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\buttonOFF"
			end
			-- print (i, SessionAverageTime, type(SessionAverageTime))
			collect[i].colorAddon = colorAddon
			collect[i].title = title
			collect[i].reason = reason
			collect[i].iconTexture = iconTexture
			collect[i].iconAtlas = iconAtlas
			collect[i].Version = Version
			collect[i].Author = Author
			collect[i].RecentAverageTime = RecentAverageTime
			collect[i].SessionAverageTime = SessionAverageTime
			collect[i].PeakTime = PeakTime
			collect[i].EncounterAverageTime = EncounterAverageTime
			collect[i].Ticksover5ms = Ticksover5ms
			collect[i].Ticksover10ms = Ticksover10ms
			collect[i].Ticksover50ms = Ticksover50ms
			collect[i].Ticksover100ms = Ticksover100ms
			collect[i].Ticksover500ms = Ticksover500ms
			collect[i].firsticonTexture = firsticonTexture
			collect[i].memoryVivod = memoryVivod
			collect[i].memory = memory
			collect[i].textRIGHT = textRIGHT
			collect[i].AddonInterfaceVersion = AddonInterfaceVersion
		end
	end
	return collect
end