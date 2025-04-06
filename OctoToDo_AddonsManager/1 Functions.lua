local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
local AddonManager = CreateFrame("Frame")
local profiles = {}
local currentProfile = "default"
-- Инициализация
AddonManager:RegisterEvent("ADDON_LOADED")
AddonManager:RegisterEvent("PLAYER_LOGIN")
-- Получить список всех аддонов
function E.func_GetAllAddons()
	local addons = {}
	for i = 1, C_AddOns.GetNumAddOns() do
		local name, title, _, _, _, reason = C_AddOns.GetAddOnInfo(i)
		if reason ~= "MISSING" then -- Исключаем отсутствующие аддоны
			table.insert(addons, name)
		end
	end
	return addons
end
-- Показать список аддонов с их статусом
function E.func_ListAddons(filter)
	local addons = E.func_GetAllAddons()
	print ("Список аддонов ("..#addons.."):")
	for i, name in ipairs(addons) do
		if not filter or string.find(string.lower(name), string.lower(filter)) then
			local status = E.IsAddOnLoaded(name) and "|cff00ff00ВКЛ|r" or "|cffff0000ВЫКЛ|r"
			print(string.format("%3d. %s - %s", i, name, status))
		end
	end
end

function E.IsAddonInstalled(indexOrName)
	local _, _, _, _, reason = C_AddOns.GetAddOnInfo(indexOrName)
	return reason ~= "MISSING"
end

function E.IsAddonSelected(nameOrIndex, forSome, charGuid)
	if (forSome) then
		local state = C_AddOns.GetAddOnEnableState(nameOrIndex, nil)
		return state == 1
	end
	-- local guid = charGuid or E.GetSelectedCharGuid()
	-- if (charGuid == true) then
	-- 	guid = nil
	-- end
	local state = C_AddOns.GetAddOnEnableState(nameOrIndex, guid)
	return state == 2
end

-- function E.GetSelectedCharGuid()
-- 	if (selectedCharIndex >= 1) then return orderedCharList[selectedCharIndex + 1].guid end
-- 	return nil
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
		C_AddOns.DisableAddOn(index)
		print ("|cffff0000отключен|r".. index)
	else
		C_AddOns.EnableAddOn(index)
		print ("|cff00ff00включен|r".. index)
	end
	if E.depsByIndex[index] and not IsModifierKeyDown() then
		for i, depIndex in ipairs(E.depsByIndex[index]) do
			E.rec_toggle(depIndex, state)
		end
	end
end
-- Переключить аддон
function E.func_ToggleAddon(index, state)
	local addonName = C_AddOns.GetAddOnInfo(index)
	local enabled = C_AddOns.GetAddOnEnableState(index, UnitName("player")) > Enum.AddOnEnableState.None
	E.rec_toggle(index, enabled)
	-- IsControlKeyDown()
	-- IsShiftKeyDown()
	-- IsAltKeyDown()
end
-- Включить все аддоны
function E.func_EnableAllAddons()
	for i, name in ipairs(E.func_GetAllAddons()) do
		C_AddOns.EnableAddOn(name)
	end
	print ("Все аддоны |cff00ff00включены|r")
	-- local character = GetAddonCharacter();
	-- C_AddOns.EnableAllAddOns(character);
	-- AddonList_Update();
end
-- Выключить все аддоны
function E.func_DisableAllAddons()
	local str = ""
	for i, name in ipairs(E.func_GetAllAddons()) do
		if not OctoToDo_AddonsManager.lock.addons[name] then
			C_AddOns.DisableAddOn(name)
		else -- ПОФИКСИТЬ (ДОБАВИТЬ ВКЛЮЧЕН ЛИ АДДОН)
			if i == 1 then
				str = name
			else
				str = str ..", ".. name
			end
		end
	end
	if str ~= "" then
		print ("Все аддоны отключены, кроме: " .. E.Green_Color.. str.."|r")
	end
end
-- Сохранить текущий профиль
function E.func_SaveProfile(profileName)
	if not profileName or profileName == "" then
		profileName = currentProfile
	end
	OctoToDo_AddonsManager.profiles[profileName] = {}
	local addons = E.func_GetAllAddons()
	for i, name in ipairs(addons) do
		OctoToDo_AddonsManager.profiles[profileName][name] = E.IsAddOnLoaded(name)
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
			C_AddOns.EnableAddOn(name)
		else
			C_AddOns.DisableAddOn(name)
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
		E.func_EnableAllAddons()
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
AddonManager:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and ... == GlobalAddonName then
			-- Создаем дефолтный профиль при первом запуске
			-- if not profiles.default then
			-- 	E.func_SaveProfile("default")
			-- end
			print ("/uam")
		end
end)
-- Регистрируем команды
SLASH_UNIVERSALADDONMANAGER1 = "/uam"
SlashCmdList["UNIVERSALADDONMANAGER"] = E.func_HandleCommand
function E.GetAddonMetricPercent(addonName, metric, warningInLeftSide, def)
	if (not C_AddOnProfiler.IsEnabled()) then
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
	if (not C_AddOnProfiler.IsEnabled()) then
		return ""
	end
	local count = C_AddOnProfiler.GetAddOnMetric(addonName, metric) or 0
	return count
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- function E.func_CompactMemory(memory)
-- 	if memory > 0 then
-- 		if memory > 1024 then
-- 			return string.format(ADDON_LIST_PERFORMANCE_MEMORY_MB, memory/1024)
-- 		else
-- 			return string.format(ADDON_LIST_PERFORMANCE_MEMORY_KB, memory)
-- 		end
-- 	else
-- 		return 0
-- 	end
-- end
----------------------------------------------------------------
function E.IsAddOnLoaded(addonName)
	return C_AddOns.IsAddOnLoaded(addonName)
end
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
		local deps = C_AddOns.GetAddOnDependencies(index)
		local okay = true
		for i = 1, select('#', deps) do
			local dep = select(i, deps)
			if ( dep and not C_AddOns.IsAddOnLoaded(select(i, deps)) ) then
				okay = false
				break
			end
		end
		lod = okay
	end
	return lod
end
----------------------------------------------------------------
function E.AddonTooltipBuildDepsString(index)
	local deps = { C_AddOns.GetAddOnDependencies(index) }
	local depsString = ""
	for i, name in ipairs(deps) do
		local color = E.Green_Color
		if i == 1 then
			depsString = color..name.."|r"
		else
			depsString = depsString..", "..color..name.."|r"
		end
	end
	return depsString
end












----------------------------------------------------------------
function E.AddonList_HasAnyChanged()
	if (AddonList.outOfDate and not C_AddOns.IsAddonVersionCheckEnabled() or (not AddonList.outOfDate and C_AddOns.IsAddonVersionCheckEnabled() and AddonList_HasOutOfDate())) then
		return true;
	end
	for i=1,C_AddOns.GetNumAddOns() do
		local character = nil;
		if (not InGlue()) then
			character = UnitName("player");
		end
		local enabled = (C_AddOns.GetAddOnEnableState(i, character) > Enum.AddOnEnableState.None);
		local reason = select(5,C_AddOns.GetAddOnInfo(i))
		if ( enabled ~= AddonList.startStatus[i] and reason ~= "DEP_DISABLED" ) then
			return true
		end
	end
	return false
end
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
----------------------------------------------------------------
-- ADDON_DEP_EXCLUDED_FROM_BUILD - Зависимость исключена из данной версии
-- ADDON_DEP_DISABLED - Зависимость отключена
-- ADDON_DEP_MISSING - Зависимость отсутствует
-- ADDON_DEP_INSECURE - Зависимость небезопасна
-- ADDON_DEP_NOT_AVAILABLE - Зависимость недоступна
-- ADDON_DEP_INTERFACE_VERSION - Зависимость устарела
-- ADDON_DEP_BANNED - Зависимость заблокирована
-- ADDON_DEP_CORRUPT - Зависимость повреждена
-- RELOADUI - Перезагрузка
-- REQUIRES_RELOAD - Перезагрузите интерф.
-- ADDON_DISABLED (Отключено)
-- SLASH_TEXTTOSPEECH_ENABLED - Включено
-- ADDON_FORCE_LOAD - Устаревшие модификации
-- NEW_COMPACT_UNIT_FRAME_PROFILE - Новый профиль
-- CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE - Новый профиль
-- NEW - Создать

