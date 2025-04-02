local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
local AddonManager = CreateFrame("Frame")
local profiles = {}
local currentProfile = "default"
-- Инициализация
AddonManager:RegisterEvent("ADDON_LOADED")
AddonManager:RegisterEvent("PLAYER_LOGIN")
-- Функция для вывода сообщения в чат
function E.func_Print(msg)
	print("!|cffd177ffO|r|cffc27dfbc|r|cffb283f7t|r|cffa28af2o_|r|cff9390eeT|r|cff8397e9o|r|cff739de5D|r|cff63a4e0o|r AddonsManager " .. msg.. "|r")
end
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
	E.func_Print("Список аддонов (" .. #addons .. "):")
	for i, name in ipairs(addons) do
		if not filter or string.find(string.lower(name), string.lower(filter)) then
			local status = C_AddOns.IsAddOnLoaded(name) and "|cff00ff00ВКЛ|r" or "|cffff0000ВЫКЛ|r"
			print(string.format("%3d. %s - %s", i, name, status))
		end
	end
end
-- Переключить аддон
function E.func_ToggleAddon(addonName)
	local addons = E.func_GetAllAddons()
	local index = tonumber(addonName)
	-- Если введен номер
	if index and index >= 1 and index <= #addons then
		addonName = addons[index]
	end
	if not C_AddOns.GetAddOnInfo(addonName) then
		E.func_Print("Аддон '" .. addonName .. "' не найден")
		return
	end
	if C_AddOns.IsAddOnLoaded(addonName) then
		C_AddOns.DisableAddOn(addonName)
		E.func_Print("Аддон '" .. addonName .. "' |cffff0000отключен|r")
	else
		C_AddOns.EnableAddOn(addonName)
		-- C_AddOns.LoadAddOn(addonName)
		E.func_Print("Аддон '" .. addonName .. "' |cff00ff00включен|r")
	end
	-- ReloadUI()
end
-- Включить все аддоны
function E.func_EnableAllAddons()
	for i, name in ipairs(E.func_GetAllAddons()) do
		C_AddOns.EnableAddOn(name)
	end
	E.func_Print("Все аддоны |cff00ff00включены|r")
	-- ReloadUI()
end
-- Выключить все аддоны
function E.func_DisableAllAddons()
	for i, name in ipairs(E.func_GetAllAddons()) do
		C_AddOns.DisableAddOn(name)
	end
	E.func_Print("Все аддоны |cffff0000отключены|r")
	-- ReloadUI()
end
-- Сохранить текущий профиль
function E.func_SaveProfile(profileName)
	if not profileName or profileName == "" then
		profileName = currentProfile
	end
	profiles[profileName] = {}
	local addons = E.func_GetAllAddons()
	for i, name in ipairs(addons) do
		profiles[profileName][name] = C_AddOns.IsAddOnLoaded(name)
	end
	E.func_Print("Профиль '" .. profileName .. "' сохранен (" .. #addons .. " аддонов)")
end
-- Загрузить профиль
function E.func_LoadProfile(profileName)
	if not profiles[profileName] then
		E.func_Print("Профиль '" .. profileName .. "' не найден")
		return
	end
	for name, enabled in pairs(profiles[profileName]) do
		if enabled then
			C_AddOns.EnableAddOn(name)
		else
			C_AddOns.DisableAddOn(name)
		end
	end
	currentProfile = profileName
	E.func_Print("Профиль '" .. profileName .. "' загружен")
	-- ReloadUI()
end
-- Список профилей
function E.func_ListProfiles()
	E.func_Print("Доступные профили:")
	for name, _ in pairs(profiles) do
		print("- " .. name)
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
		E.func_Print("Команды:")
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
			if not profiles.default then
				E.func_SaveProfile("default")
			end
			print ("/uam")
		end
end)
-- Регистрируем команды
SLASH_UNIVERSALADDONMANAGER1 = "/uam"
SlashCmdList["UNIVERSALADDONMANAGER"] = E.func_HandleCommand
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
-- REQUIRES_RELOAD - Перезагрузите интерф.
-- SLASH_TEXTTOSPEECH_ENABLED - Включено
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
		return E.GetWarningFor(percent) .. E.FormatProfilerPercent(percent * 100.0)
	end
	return E.FormatProfilerPercent(percent * 100.0) .. E.GetWarningFor(percent)
end
----------------------------------------------------------------
function E.FormatProfilerPercent(pct)
	local color = E.White_Color
	if (pct > 25) then color = E.Yellow_Color end
	if (pct > 50) then color = E.Orange_Color end
	if (pct > 80) then color = E.Red_Color end
	local vivod = string.format("%.2f", pct)
	return vivod
	-- return color:WrapText(string.format("%.2f", pct)) .. E.White_Color:WrapText("%")
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
function E.AddonTooltip_BuildDeps(...)
	local deps = ""
	for i=1, select("#", ...) do
		if ( i == 1 ) then
			deps = ADDON_DEPENDENCIES .. select(i, ...)
		else
			deps = deps..", "..select(i, ...)
		end
	end
	return deps
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------