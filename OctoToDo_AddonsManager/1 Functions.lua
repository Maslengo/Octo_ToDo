local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
local AddonManager = CreateFrame("Frame")
local profiles = {}
local currentProfile = "default"

function E.func_GetAddonIndex(name)
	local index = OctoToDo_AddonsTable.indexByName[name]
	return tonumber(index)
end
function E.func_GetAddonName(index)
	local name = select(1, C_AddOns.GetAddOnInfo(index))
	return name
end
function E.func_GetAddonTitle(index)
	local title = select(2, C_AddOns.GetAddOnInfo(index))
	return title
end
function E.func_GetAddonNotes(index)
	local notes = select(2, C_AddOns.GetAddOnInfo(index))
	return notes
end
function E.func_GetAddonLoadable(index, character)
	character = character or UnitName("player")
	local loadable = select(1, C_AddOns.IsAddOnLoadable(index, character));
	return loadable
end
function E.func_GetAddonReason(index, character)
	character = character or UnitName("player")
	local reason = select(2, C_AddOns.IsAddOnLoadable(index, character));
	return reason
end
function E.func_IsAddonInstalled(index) -- Исключаем отсутствующие аддоны
	local reason = select(5, C_AddOns.GetAddOnInfo(index))
	return reason ~= "MISSING"
end
function E.func_GetAddonSecurity(index)
	local security = select(6, C_AddOns.GetAddOnInfo(index))
	return security
end
function E.func_GetAddonUpdateAvailable(index)
	local updateAvailable = select(7, C_AddOns.GetAddOnInfo(index))
	return updateAvailable
end
function E.func_GetAddonVersion(index)
	local Version = C_AddOns.GetAddOnMetadata(index, "Version") or 0
	return Version
end
function E.func_GetAddonAuthor(index)
	local Author = C_AddOns.GetAddOnMetadata(index, "Author") or ""
	return Author
end
function E.func_GetAddoniconTexture(index)
	local iconTexture = C_AddOns.GetAddOnMetadata(index, "IconTexture")
	return iconTexture
end
function E.func_GetAddoniconAtlas(index)
	local iconAtlas = C_AddOns.GetAddOnMetadata(index, "IconAtlas")
	return iconAtlas
end

function E.func_GetAddonCategory(index)
	local Category = C_AddOns.GetAddOnMetadata(index, "Category")
	return Category
end
function E.func_GetAddonGroup(index)
	local Group = C_AddOns.GetAddOnMetadata(index, "Group")
	return Group
end





function E.func_IsAddOnLoaded(index)
	local loadedOrLoading = select(1, C_AddOns.IsAddOnLoaded(index))
	return loadedOrLoading
end
function E.func_GetAddOnEnableState(i, character)
	character = character or UnitName("player")
	return C_AddOns.GetAddOnEnableState(i, character)
end
function E.func_IsAddOnLoadable(index, character)
	local loadable = select(1, C_AddOns.IsAddOnLoadable(index, character)) -- reason 2
	return loadable
end
function E.func_DoesAddOnExist(index)
	return C_AddOns.DoesAddOnExist(index)
end
function E.func_IsAddOnDefaultEnabled(index)
	return C_AddOns.IsAddOnDefaultEnabled(index)
end
function E.func_GetAddOnDependenciesTable(index)
	return {C_AddOns.GetAddOnDependencies(index)}
end

function E.func_GetAddOnDependenciesSTR(index)
	return C_AddOns.GetAddOnDependencies(index)
end










function E.func_GetNumAddOns()
	local NumAddOns = C_AddOns.GetNumAddOns()
	return NumAddOns
end
function E.func_EnableAddOn(name, character)
	character = character or UnitName("player")
	return C_AddOns.EnableAddOn(name, character)
end
function E.func_EnableAllAddOns(character) -- Включить все аддоны
	character = character or UnitName("player")
	return C_AddOns.EnableAllAddOns(character)
end
function E.func_DisableAddOn(name, character)
	character = character or UnitName("player")
	return C_AddOns.DisableAddOn(name, character)
end
function E.func_DisableAllAddons()
	for index, name in ipairs(E.func_GetAllAddons()) do
		if not OctoToDo_AddonsManager.lock.addons[name] then
			E.func_DisableAddOn(index)
		end
	end
end


function E.func_IsProfilerEnabled()
	return C_AddOnProfiler.IsEnabled()
end

function E.UpdatePerformance()
	if E.func_IsProfilerEnabled() then
		UpdateAddOnMemoryUsage()
		-- UpdateAddOnCPUUsage() -- НЕ РАБОТАЕТ?
	end
end

function E.func_IsAddonVersionCheckEnabled()
	return C_AddOns.IsAddonVersionCheckEnabled()
end




-- Получить список всех аддонов
function E.func_GetAllAddons()
	local addons = {}
	for index = 1, E.func_GetNumAddOns() do
		if E.func_IsAddonInstalled(index) then -- Исключаем отсутствующие аддоны
			table.insert(addons, E.func_GetAddonName(index))
		end
	end
	return addons
end
-- Показать список аддонов с их статусом
function E.func_ListAddons(filter)
	local addons = E.func_GetAllAddons()
	print ("Список аддонов ("..#addons.."):")
	for index, name in ipairs(addons) do
		if not filter or string.find(string.lower(name), string.lower(filter)) then
			local status = E.func_IsAddOnLoaded(index) and "|cff00ff00ВКЛ|r" or "|cffff0000ВЫКЛ|r"
			print(string.format("%3d. %s - %s", index, name, status))
		end
	end
end




function E.AddonListEntry_SetEnabled(index, character, enabled)
	if enabled == nil then
		enabled = C_AddOns.IsAddOnDefaultEnabled(index)
	end
	if enabled then
		E.func_EnableAddOn(index, character)
	else
		E.func_DisableAddOn(index, character)
	end
end



function E.AddonList_HasAnyChanged()
	if (AddonList.outOfDate and not E.func_IsAddonVersionCheckEnabled() or (not AddonList.outOfDate and E.func_IsAddonVersionCheckEnabled() and AddonList_HasOutOfDate())) then
		return true
	end
	for i=1,E.func_GetNumAddOns() do
		local character = nil
		character = UnitName("player")
		local enabled = (E.func_GetAddOnEnableState(i, character) > Enum.AddOnEnableState.None)
		local reason = select(5,C_AddOns.GetAddOnInfo(i))
		if ( enabled ~= AddonList.startStatus[i] and reason ~= "DEP_DISABLED" ) then
			return true
		end
	end
	return false
end

function E.AddonTooltipBuildDepsString(index, color)
	color = color or "|cff000000"
	local deps = E.func_GetAddOnDependenciesTable(index)
	local depsString = ""
	for i, name in ipairs(deps) do
		if i == 1 then
			depsString = "Родители:|n" -- ADDON_DEPENDENCIES
		end
		depsString = depsString..color.."    "..(name).."|r|n"
	end
	return depsString
end
function E.IsAddonSelected(nameOrIndex, forSome, charGuid)
	if (forSome) then
		local state = E.func_GetAddOnEnableState(nameOrIndex, nil)
		return state == 1
	end
	-- local guid = charGuid or E.GetSelectedCharGuid()
	-- if (charGuid == true) then
	--     guid = nil
	-- end
	local state = E.func_GetAddOnEnableState(nameOrIndex, guid)
	return state == 2
end
-- function E.GetSelectedCharGuid()
--     if (selectedCharIndex >= 1) then return orderedCharList[selectedCharIndex + 1].guid end
--     return nil
-- end
function E.LocalizeCategoryName(name, isUserCategory)
	if (isUserCategory) then
		return name
	end
	return rawget(L, string.lower(name)) or name
end
function E.GetCategoryTables()
	local db = self:GetDb()
	local userCategories = db.categories
	local tocCategories = categoryTocTable
	return userCategories, tocCategories, fixedCategories
end
function E.CategoriesForAddon(name)
	local userTable, tocTable, fixedTable = E.GetCategoryTables()
	local resultText = ""
	local sep = ""
	for _, categoryTable in pairs(userTable) do
		if (categoryTable.addons[name]) then
			resultText = resultText .. sep .. E.LocalizeCategoryName(categoryTable.name, userTable)
			sep = ", "
		end
	end
	for _, categoryTable in pairs(tocTable) do
		if (categoryTable.addons[name]) then
			resultText = resultText .. sep .. E.LocalizeCategoryName(categoryTable.name, tocTable)
			sep = ", "
		end
	end
	for _, categoryTable in pairs(fixedTable) do
		if (categoryTable.prepare) then categoryTable:prepare() end
		if (categoryTable:addons(name)) then
			resultText = resultText .. sep .. categoryTable.name
			sep = ", "
		end
	end
	return resultText
end
function E.rec_toggle(index, state)
	if state then
		E.func_DisableAddOn(index)
		-- print ("|cffff0000отключен|r".. index)
	else
		E.func_EnableAddOn(index)
		-- print ("|cff00ff00включен|r".. index)
	end
	if OctoToDo_AddonsTable.depsByIndex[index] and not IsModifierKeyDown() then
		for i, depIndex in ipairs(OctoToDo_AddonsTable.depsByIndex[index]) do
			E.rec_toggle(depIndex, state)
		end
	end
end
-- Переключить аддон
function E.func_ToggleAddon(index, state)
	local addonName = C_AddOns.GetAddOnInfo(index)
	local enabled = E.func_GetAddOnEnableState(index, UnitName("player")) > Enum.AddOnEnableState.None
	E.rec_toggle(index, enabled)
end









































-- Сохранить текущий профиль
function E.func_SaveProfile(profileName)
	if not profileName or profileName == "" then
		profileName = currentProfile
	end
	OctoToDo_AddonsManager.profiles = OctoToDo_AddonsManager.profiles or {}
	OctoToDo_AddonsManager.profiles[profileName] = {}
	local addons = E.func_GetAllAddons()
	for index, name in ipairs(addons) do
		OctoToDo_AddonsManager.profiles[profileName][name] = E.func_IsAddOnLoaded(index)
	end
	print ("Профиль '"..profileName.." сохранен ("..#addons.." аддонов)")
end
-- Загрузить профиль
function E.func_LoadProfile(profileName)
	if not OctoToDo_AddonsManager.profiles[profileName] then
		print ("Профиль '"..profileName.." не найден")
		return
	end
	for name, enabled in pairs(OctoToDo_AddonsManager.profiles[profileName]) do
		if enabled then
			E.func_EnableAddOn(name)
		else
			E.func_DisableAddOn(name)
		end
	end
	currentProfile = profileName
	print ("Профиль '"..profileName.." загружен")
	-- ReloadUI()
end
-- Список профилей
function E.func_ListProfiles()
	print ("Доступные профили:")
	for name, _ in pairs(OctoToDo_AddonsManager.profiles) do
		print("- "..name)
	end
end
-- Обработчик команд
function E.func_HandleCommand(msg)
	local command, arg1, arg2 = strsplit(" ", msg, 3)
	if command == "list" then
		E.func_ListAddons(arg1)
	elseif command == "toggle" then
		E.func_ToggleAddon(arg1)
	elseif command == "enableall" then
		E.func_EnableAllAddOns()
	elseif command == "disableall" then
		E.func_DisableAllAddons()
	elseif command == "save" then
		E.func_SaveProfile(arg1)
	elseif command == "load" then
		E.func_LoadProfile(arg1)
	elseif command == "profiles" then
		E.func_ListProfiles()
	else
		print ("Команды:")
		print("/uam list [фильтр] - список аддонов")
		print("/uam toggle <имя/номер> - переключить аддон")
		print("/uam enableall - включить все аддоны")
		print("/uam disableall - выключить все аддоны")
		print("/uam save [профиль] - сохранить текущие настройки")
		print("/uam load <профиль> - загрузить профиль")
		print("/uam profiles - список профилей")
	end
end
-- Инициализация при загрузке
-- Регистрируем команды
SLASH_UNIVERSALADDONMANAGER1 = "/uam"
SlashCmdList["UNIVERSALADDONMANAGER"] = E.func_HandleCommand
function E.GetAddonMetricPercent(addonName, metric, warningInLeftSide, def)
	if (not E.func_IsProfilerEnabled()) then
		return def or ""
	end
	local overall = C_AddOnProfiler.GetOverallMetric(metric)
	local addon = C_AddOnProfiler.GetAddOnMetric(addonName, metric)
	local relative = overall
	if (C_AddOnProfiler.GetApplicationMetric) then
		local app = C_AddOnProfiler.GetApplicationMetric(metric)
		relative = app - overall + addon
	end
	if relative <= 0 then
		return def or ""
	end
	local percent = addon / relative
	if (warningInLeftSide) then
		return E.GetWarningFor(percent)..E.FormatProfilerPercent(percent * 100.0)
	end
	return E.FormatProfilerPercent(percent * 100.0)..E.GetWarningFor(percent)
end
----------------------------------------------------------------
function E.FormatProfilerPercent(pct)
	local color = E.White_Color
	if (pct > 25) then color = E.Yellow_Color end
	if (pct > 50) then color = E.Orange_Color end
	if (pct > 80) then color = E.Red_Color end
	local vivod = string.format("%.2f", pct)
	return vivod
	-- return color:WrapText(string.format("%.2f", pct))..E.White_Color:WrapText("%")
end
----------------------------------------------------------------
function E.GetCVarNumber(name)
	-- if the CVar doesn't exist, the GetCVar returns "nothing" (not even nil) and the tonumber fails
	local number = tonumber(GetCVar(name) or nil)
	return number or tonumber(GetCVarDefault(name) or nil)
end
----------------------------------------------------------------
----------------------------------------------------------------
function E.GetWarningFor(percent)
	local warningPercent = E.GetCVarNumber("addonPerformanceMsgWarning") or -1
	if (warningPercent > 0.0 and warningPercent < 1.0 and percent > warningPercent) then
		return " "..CreateSimpleTextureMarkup([[Interface\DialogFrame\DialogIcon-AlertNew-16]], 16, 16)
	end
	return ""
end
----------------------------------------------------------------
----------------------------------------------------------------
function E.GetAddonMetricCount(addonName, metric)
	if (not E.func_IsProfilerEnabled()) then
		return ""
	end
	local count = C_AddOnProfiler.GetAddOnMetric(addonName, metric) or 0
	return count
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- function E.func_CompactMemory(memory)
--     if memory > 0 then
--         if memory > 1024 then
--             return string.format(ADDON_LIST_PERFORMANCE_MEMORY_MB, memory/1024)
--         else
--             return string.format(ADDON_LIST_PERFORMANCE_MEMORY_KB, memory)
--         end
--     else
--         return 0
--     end
-- end
----------------------------------------------------------------
function E.AddonTooltip_BuildDeps(...)
	local deps = ""
	for i=1, select("#", ...) do
		if i == 1 then
			deps = ADDON_DEPENDENCIES..select(i, ...)
		else
			deps = deps..", "..select(i, ...)
		end
	end
	return deps
end
----------------------------------------------------------------
function E.AddonList_IsAddOnLoadOnDemand(index)
	local lod = false
	if C_AddOns.IsAddOnLoadOnDemand(index) then
		local deps = E.func_GetAddOnDependenciesSTR(index)
		local okay = true
		for i = 1, select('#', deps) do
			local dep = select(i, deps)
			if ( dep and not E.func_IsAddOnLoaded(select(i, deps)) ) then
				okay = false
				break
			end
		end
		lod = okay
	end
	return lod
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function getFunction(fun)
	return (C_AddOns and C_AddOns[fun]) or _G[fun]
end
E.compat = {
	EnableAddOn = getFunction("EnableAddOn"),
	DisableAddOn = getFunction("DisableAddOn"),
	IsAddOnLoaded = getFunction("IsAddOnLoaded"),
	EnableAllAddOns = getFunction("EnableAllAddOns"),
	DisableAllAddOns = getFunction("DisableAllAddOns"),
	GetAddOnInfo = getFunction("GetAddOnInfo"),
	GetAddOnDependencies = getFunction("GetAddOnDependencies"),
	GetNumAddOns = getFunction("GetNumAddOns"),
	SaveAddOns = getFunction("SaveAddOns"),
	ResetAddOns = getFunction("ResetAddOns"),
	IsAddonVersionCheckEnabled = getFunction("IsAddonVersionCheckEnabled"),
	SetAddonVersionCheck = getFunction("SetAddonVersionCheck"),
	IsAddOnLoadOnDemand = getFunction("IsAddOnLoadOnDemand"),
	GetAddOnEnableState = (C_AddOns and C_AddOns.GetAddOnEnableState) or function(nameOrIndex, character)
		return GetAddOnEnableState(character, nameOrIndex) -- the old API has inverted parameters
	end
}
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------