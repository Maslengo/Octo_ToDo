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
			local loadedOrLoading = E.IsAddOnLoaded(i) -- and "|cff00ff00ВКЛ|r" or "|cffff0000ВЫКЛ|r" -- STATUS
			local textRIGHT = ""
			local colorAddon = E.White_Color
			local iconTexture = C_AddOns.GetAddOnMetadata(i, "IconTexture")
			local iconAtlas = C_AddOns.GetAddOnMetadata(i, "IconAtlas")
			local Version = C_AddOns.GetAddOnMetadata(i, "Version") or 0
			local Author = C_AddOns.GetAddOnMetadata(i, "Author") or ""
			local RecentAverageTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.RecentAverageTime)
			local SessionAverageTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.SessionAverageTime)
			local PeakTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.PeakTime)
			local EncounterAverageTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.EncounterAverageTime)
			local Ticksover5ms = E.GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver5Ms)
			local Ticksover10ms = E.GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver10Ms)
			local Ticksover50ms = E.GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver50Ms)
			local Ticksover100ms = E.GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver100Ms)
			local Ticksover500ms = E.GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver100Ms)
			local state = C_AddOns.GetAddOnEnableState(name)
			local exists = C_AddOns.DoesAddOnExist(name)
			local defaultEnabled = C_AddOns.IsAddOnDefaultEnabled(name)
			local memory = GetAddOnMemoryUsage(i) or 0
			local enabled = (C_AddOns.GetAddOnEnableState(i, UnitName("player")) > Enum.AddOnEnableState.None);
			local needReload = false
			if E.IsAddOnLoaded(i) then
				if SessionAverageTime ~= "0.00" then
					textRIGHT = SessionAverageTime.."%" .. " ~ ".. PeakTime.."%"
				else
					textRIGHT = PeakTime.."%"
				end
			else
				textRIGHT = ADDON_DISABLED
				colorAddon = E.Gray_Color
			end
			-- if state == 2 then
			-- 	if loadedOrLoading then
			-- 		firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonON"
			-- 	else
			-- 		firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonSOON"
			-- 	end
			-- elseif state == 1 then
			-- 		firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonGRAY"
			-- 	else
			-- 	firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonOFF"
			-- end
			if loadedOrLoading then
				firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonONgreen"
			else
				firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonOFFblack"
			end
			if (enabled and not loadedOrLoading) then
				needReload = true
				textRIGHT = "Будет включено" -- "REQUIRES_RELOAD" VIDEO_OPTIONS_ENABLED
				colorAddon = "|cff".."355C24" -- E.Green_Color
				firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonOFFgreen"
			end
			if (not enabled and loadedOrLoading) then
				needReload = true
				textRIGHT =  "Будет отключено" -- "REQUIRES_RELOAD" ADDON_DISABLED
				colorAddon = "|cff".."BA1525" -- E.Red_Color
				firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonOFFred"
			end
			if reason == "DEP_DISABLED" then
				textRIGHT = ADDON_DEP_DISABLED
				colorAddon = E.Red_Color
			end
			if reason == "DEMAND_LOADED" then
				textRIGHT = ADDON_DEMAND_LOADED
				colorAddon = E.Yellow_Color
			end
			local dep = E.AddonTooltipBuildDepsString(i)
			-- print (i, SessionAverageTime, type(SessionAverageTime))
			collect[i].colorAddon = colorAddon
			collect[i].name = name
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
			collect[i].memory = memory
			collect[i].textRIGHT = textRIGHT
			collect[i].defaultEnabled = defaultEnabled
			collect[i].exists = exists
			collect[i].state = state
			collect[i].enabled = enabled
			collect[i].needReload = needReload
			collect[i].addonindex = i
			collect[i].loadedOrLoading = loadedOrLoading
			collect[i].vivod = E.func_Reason(reason)
			collect[i].dep = dep
		end
	end
	return collect
end

