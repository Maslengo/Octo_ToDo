local GlobalAddonName, E = ...
----------------------------------------------------------------

local Warmup_font = "Interface\\Addons\\Octo\\Media\\font\\00 consolas.TTF"
-- local Warmup_font = "Interface\\Addons\\Octo\\Media\\font\\00 FiraCode-Regular.TTF"
local Warmup_fontObject12 = CreateFont("Warmup_font12")
Warmup_fontObject12:CopyFontObject(SystemFont_Outline_Small)-- local font = GameFontHighlightSmallLeft
Warmup_fontObject12:SetFont(Warmup_font, 12, "OUTLINE")
----------------------------------------------------------------

-- Создание фреймов
local containerFrame = CreateFrame("Frame", "WarmupOutputFrameOCTO", UIParent, "BackdropTemplate")
containerFrame:Hide()
local outputFrame = CreateFrame("ScrollingMessageFrame", "WarmupChatFrameOCTO", containerFrame, "BackdropTemplate")

outputFrame:SetFontObject(Warmup_font12 or "GameTooltipText" or "ChatFontNormal") -- ChatFontNormal

outputFrame:SetMaxLines(512)

-- Инициализация GUI
local function InitializeGUI()
	containerFrame:SetPoint("TOPLEFT", 64, -64)
	containerFrame:SetSize(512, 640)
	containerFrame:EnableMouse(true)
	containerFrame:SetMovable(true)

	containerFrame:SetScript("OnMouseDown", function(_, button)
		if button == "LeftButton" then
			containerFrame:SetAlpha(0.5)
			containerFrame:StartMoving()
		end
	end)

	containerFrame:SetScript("OnMouseUp", function(_, button)
		if button == "LeftButton" then
			containerFrame:SetAlpha(1)
			containerFrame:StopMovingOrSizing()
		end
	end)

	outputFrame:SetPoint("TOPLEFT", 12, -29)
	outputFrame:SetPoint("BOTTOMRIGHT", -8, 12)
	outputFrame:SetJustifyH("LEFT")

	containerFrame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	containerFrame:SetBackdropColor(0, 0, 0)
	containerFrame:SetBackdropBorderColor(0.8, 0.8, 0.8)

	local bg = containerFrame:CreateTexture(nil, "BORDER")
	bg:SetAllPoints()
	bg:SetAtlas("collections-background-tile")
	bg:SetAlpha(0.9)

	local close = CreateFrame("Button", nil, containerFrame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", -4, -4)

	local title = containerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	title:SetPoint("TOPLEFT", 12, -8)
	title:SetPoint("RIGHT", close, "LEFT", -6, 0)
	title:SetHeight(18)
	title:SetJustifyH("CENTER")
	title:SetText(GlobalAddonName)

	local div = containerFrame:CreateTexture(nil, "ARTWORK")
	div:SetPoint("TOPLEFT", 8, -32)
	div:SetPoint("TOPRIGHT", -8, -32)
	div:SetHeight(8)
	div:SetTexture("Interface\\Common\\UI-TooltipDivider-Transparent")

	outputFrame:SetFading(false)
	outputFrame:EnableMouseWheel(true)
	outputFrame:SetScript("OnMouseWheel", function(_, delta)
		if IsControlKeyDown() then
			return delta > 0 and outputFrame:PageUp() or outputFrame:PageDown()
		end

		local numLines = IsShiftKeyDown() and outputFrame:GetNumMessages() or 5
		local scrollFunc = delta > 0 and outputFrame.ScrollUp or outputFrame.ScrollDown

		for i = 1, numLines do
			scrollFunc(outputFrame)
		end
	end)
end

containerFrame:SetScript("OnShow", function(self)
	self:SetScript("OnShow", nil)
	InitializeGUI()
end)

-- Инициализация памяти и статистики
collectgarbage("stop")
collectgarbage("collect")
local initmem = collectgarbage("count")
local memstack = {initmem}  -- Восстановлен стек памяти
local longesttime, biggestmem, totalmem, totalgarbage, mostgarbage = 0, 0, 0, 0, 0
local totaltime = 0
local eventcounts = {}
local eventargs = {}
local threshtimes, threshmems = {1.0, 0.5, 0.1}, {1000, 500, 100}

local Blue_Color = "|cff00A3FF"

local Red_Color = "|cffFF0000" -- 1
local Orange_Color = "|cffFF8000" -- 2
local Yellow_Color = "|cffFFFF00" -- 3
local Green_Color = "|cff00ff00" -- 4
local threshcolors = {Red_Color, Orange_Color, Yellow_Color, Green_Color}
local WarmupDB, varsloadtime, logging, longestaddon, biggestaddon, mostgarbageaddon, leftworld

-- Таймер
local timerStartTime
local function StartTimer()
	if timerStartTime then return end
	timerStartTime = debugprofilestop()
end

local function StopTimer()
	if not timerStartTime then return 0 end
	local elapsed = debugprofilestop() - timerStartTime
	timerStartTime = nil
	return elapsed
end

StartTimer()

-- Перехват LoadAddOn с использованием memstack
local orig_LoadAddOn = C_AddOns and C_AddOns.LoadAddOn or LoadAddOn
local function LoadAddOnWrapper(name)
	if timerStartTime then
		StopTimer()
	end

	-- Сбор мусора и сохранение состояния памяти
	collectgarbage("collect")
	local currentMem = collectgarbage("count")
	table.insert(memstack, currentMem)
	table.insert(memstack, currentMem)  -- Дважды для совместимости
	StartTimer()
	return orig_LoadAddOn(name)
end

if C_AddOns then
	C_AddOns.LoadAddOn = LoadAddOnWrapper
else
	LoadAddOn = LoadAddOnWrapper
end

-- Проверка ранее загруженных аддонов
for i = 1, C_AddOns.GetNumAddOns() do
	if C_AddOns.IsAddOnLoaded(i) and C_AddOns.GetAddOnInfo(i) ~= GlobalAddonName then
		outputFrame:AddMessage("Addon loaded before Warmup: ".. C_AddOns.GetAddOnInfo(i))
	end
end

-- Основной фрейм
local frame = CreateFrame("Frame", "WarmupFrame", UIParent)
Warmup = {}

frame:SetScript("OnEvent", function(self, event, ...)
	if eventcounts then
		eventcounts[event] = (eventcounts[event] or 0) + 1
		eventargs[event] = math.max(select("#", ...), eventargs[event] or 0)
	end
	if Warmup[event] then Warmup[event](Warmup, ...) end
end)

-- Вспомогательные функции
local function GetThreshColor(value, thresholds)
	for i, threshold in ipairs(thresholds) do
		if value >= threshold then return threshcolors[i] end
	end
	return threshcolors[#threshcolors]
end

local function AddOutput(text, time, mem, gc)
	local parts = {}
	if time then
		table.insert(parts, string.format("%s%.3f sec|r | ", GetThreshColor(time, threshtimes), time))
	end
	table.insert(parts, text)
	local octomem = tostring(mem):gsub("-", "")
	local newOctomem = tonumber(octomem)
	if newOctomem then
		local memColor = GetThreshColor(newOctomem, threshmems)
		local memText = string.format(" (garbage: %s%d KiB|r", memColor, newOctomem)

		-- if gc and gc ~= newOctomem then
		if gc then
			local gcColor = GetThreshColor(gc, threshmems)
			memText = memText .. string.format(" - %s%d KiB|r)", gcColor, gc)
		else
			memText = memText .. ")"
		end
		table.insert(parts, memText)
	end

	outputFrame:AddMessage(table.concat(parts))
end

-- Обработчики событий
function Warmup:Init()
	if not WarmupSV then WarmupSV = {} end
	WarmupDB = WarmupSV
	WarmupDB.addoninfo = {}
	WarmupDB.init = true
end

function Warmup:ADDON_LOADED(addon)
	if addon == GlobalAddonName then
		self:Init()
		return
	end

	local elapsed = StopTimer() / 1000
	totaltime = totaltime + elapsed

	-- Восстановление логики работы с memstack
	local newmem = collectgarbage("count")
	local lastmem = table.remove(memstack) or newmem
	local origmem = table.remove(memstack) or lastmem

	collectgarbage("collect")
	local gcmem = collectgarbage("count")
	local garbage = newmem - gcmem
	local memUsed = newmem - lastmem - garbage

	-- Инициализация WarmupDB при первом вызове
	if not WarmupDB then self:Init() end

	-- Обновление статистики
	if elapsed > longesttime then
		longesttime = elapsed
		longestaddon = addon
	end

	if memUsed > biggestmem then
		biggestmem = memUsed
		biggestaddon = addon
	end

	if garbage > mostgarbage then
		mostgarbage = garbage
		mostgarbageaddon = addon
	end

	totalgarbage = totalgarbage + garbage
	totalmem = totalmem + memUsed

	-- Сохранение информации об аддоне
	-- elapsed ВРЕМЯ
	-- addon Название
	-- memUsed мемори
	-- garbage мусор
	print (addon, newmem, memUsed)
	table.insert(WarmupDB.addoninfo, string.format("%.3f sec | %s (%d KiB ~ %d KiB)", elapsed, addon, memUsed, garbage))

	-- Вывод информации
	AddOutput(addon, elapsed, memUsed, garbage)

	StartTimer()
end

function Warmup:VARIABLES_LOADED()
	local elapsed = StopTimer() / 1000
	totaltime = totaltime + elapsed

	collectgarbage("collect")
	local totalMemory = collectgarbage("count") - initmem

	AddOutput(" ")
	AddOutput(Blue_Color.."Все аддоны|r", totaltime, totalMemory, totalgarbage) -- Addon Loadup
	AddOutput(Orange_Color.."Самый долгий:|r ".. (longestaddon or "N/A"), longesttime) -- Longest addon
	AddOutput(Orange_Color.."            Самый большой:|r ".. (biggestaddon or "N/A"), nil, biggestmem) -- Biggest addon
	AddOutput(Orange_Color.."            Самый мусорный:|r ".. (mostgarbageaddon or "N/A"), nil, mostgarbage) -- Most Garbage
	AddOutput(" ")

	-- Настройка команд
	SLASH_WARMUP1, SLASH_WARMUP2 = "/wu", "/warmup"
	SlashCmdList.WARMUP = function()
		WarmupOutputFrameOCTO:SetShown(not WarmupOutputFrameOCTO:IsShown())
	end

	-- Регистрация следующих событий
	frame:RegisterEvent("PLAYER_LOGIN")
	frame:RegisterEvent("PLAYER_LOGOUT")

	varsloadtime = GetTime()
	StartTimer()
end

function Warmup:PLAYER_LOGIN()
	table.insert(UISpecialFrames, "WarmupOutputFrameOCTO")
	if WarmupDB.init then
		C_Timer.After(2, function()
			if not InCombatLockdown() then
				WarmupOutputFrameOCTO:Show()
			end
		end)
		WarmupDB.init = false
	end

	logging = true
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function Warmup:PLAYER_ENTERING_WORLD()
	if logging then
		local entrytime = StopTimer() / 1000
		AddOutput(" ")
		AddOutput("Вход в мир", entrytime) -- World entry
		AddOutput("Общее время", entrytime + totaltime) -- Total time

		WarmupDB.time = nil
		varsloadtime = nil
		logging = nil

		frame:RegisterAllEvents()
		frame:UnregisterEvent("PLAYER_LOGIN")
		frame:UnregisterEvent("PLAYER_LOGOUT")
		frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif leftworld then
		AddOutput("Zoning", StopTimer() / 1000)
		leftworld = nil
	end
end

function Warmup:PLAYER_LEAVING_WORLD()
	WarmupDB.time = GetTime()
	leftworld = true

	frame:UnregisterAllEvents()
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("PLAYER_LOGOUT")

	StartTimer()
end

function Warmup:PLAYER_LOGOUT()
	if not WarmupDB.reloadingUI then
		WarmupDB.time = nil
	end
end

-- Старт мониторинга
frame:RegisterAllEvents()