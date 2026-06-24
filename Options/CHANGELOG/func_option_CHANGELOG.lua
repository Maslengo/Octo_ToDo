local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local WIDTH_FRAME = 660
local HEIGHT_FRAME = 560
local WIDTH_ROW = WIDTH_FRAME
local HEIGHT_ROW = 32
local INDENT_CONTAINER = 16
local WIDTH_DATAPROVIDER = WIDTH_ROW
local INDENT_SCROLL = 6
----------------------------------------------------------------
local minAddonVersion, maxAddonVersion
local table_insert = table.insert
----------------------------------------------------------------
local VERSION_COLOR = E.COLOR_GRAY
local NAME_COLOR = E.COLOR_SKYBLUE
local REMOVED_COLOR = E.COLOR_RED
-- E.TOTALCOLORFOROPTIONSCHANGELOG = {}
local func_DataProviderData do
	-- E.TOTALCOLORFOROPTIONSCHANGELOG = {120100, 120007, 120005}
	-- minWowVersion, maxWowVersion = E.func_GetMinMaxValue(E.TOTALCOLORFOROPTIONSCHANGELOG)
	function func_DataProviderData()
		-- local function versionColor(ver)
		-- 	return E.func_GetColorGradient(ver, minWowVersion, maxWowVersion, true)
		-- end
		local function formatterstr(str)
			local result = E.COLOR_GRAY .. "(" .. str .. ")|r"
			return result
		end
		local Version_120100 = formatterstr("12.1.0") -- .. E.func_NumberToVersion(120100) -- , versionColor(120100)
		local Version_120007 = formatterstr("12.0.7") -- .. E.func_NumberToVersion(120007) -- , versionColor(120007)
		local Version_120005 = formatterstr("12.0.5") -- .. E.func_NumberToVersion(120005) -- , versionColor(120005)
		local tbl = {
			{
				version = 115.7,
				date = formatterstr("24.06.2026"),
				-- date = { day = 24, month = 6, year = 2026 },
				wowVersion = Version_120007,
				text = {
					"Добавлен " .. NAME_COLOR .. L["Changelog"] .. "|r",
					-- "Добавлена кнопка с порталами",
					"Настройки шрифта теперь не зависят от языка",
					"Унифицирован FontObject для настроек через метаттаблицу: " .. NAME_COLOR .. "E.OctoFont11_MT|r",
					"Пофиксил сбор валюты",
					"LibSFDropDown добавлена функция: " .. NAME_COLOR .. "ddReopenAllMenus|r",
					NAME_COLOR .. "DataProvider Expansion|r теперь по индексу",
					REMOVED_COLOR .. "Octo_ToDo_DBVersion|r" .. " -> " .. NAME_COLOR .. "Octo_ToDo_DB_Variables|r",
					REMOVED_COLOR .. "Octo_DevTool_DB|r" .. " -> " .. NAME_COLOR .. "Octo_ToDo_DB_Variables|r",
					REMOVED_COLOR .. "Octo_ToDo_DB_Calendar|r" .. " -> " .. NAME_COLOR .. "Octo_ToDo_DB_Variables.Calendar|r",
					NAME_COLOR .. "OctoTables_Vibor|r[categoryKey].defs = true",
				},
			},
			{
				version = 115.6,
				date = formatterstr("21.06.2026"),
				-- date = { day = 21, month = 6, year = 2026 },
				wowVersion = Version_120007,
				text = {
					"Добавлена возможность передвигать скроллбокс по СКМ",
					"Все настройки перенесены в \"выпадающее меню\" (Dropdown)",
					"Добавлена кнока для ивентов",
					"Добавлен рейд " .. NAME_COLOR .. E.func_GetName("dungeon", 3004) .. "|r" .. Version_120100,
					"Добавлен рейд " .. NAME_COLOR .. E.func_GetName("dungeon", 2987) .. "|r" .. Version_120100,
					"Добавлена аббревиатура для " .. NAME_COLOR .. E.func_GetName("challenge", 586) .. "|r" .. Version_120100,
					"Добавлена аббревиатура для " .. NAME_COLOR .. E.func_GetName("challenge", 588) .. "|r" .. Version_120100,
					"Добавлена аббревиатура для " .. NAME_COLOR .. E.func_GetName("challenge", 585) .. "|r" .. Version_120100,
					"Добавлена аббревиатура для " .. NAME_COLOR .. E.func_GetName("challenge", 587) .. "|r" .. Version_120100,
					"Добавлена аббревиатура для " .. NAME_COLOR .. E.func_GetName("challenge", 584) .. "|r" .. Version_120100,
					"Добавлена возможность сохранять позиции основного фрейма",
					"Исправлена привязка ScrollBox у основного фрейма",
				},
			},
			{
				version = 115.5,
				date = formatterstr("19.06.2026"),
				-- date = { day = 19, month = 6, year = 2026 },
				wowVersion = Version_120007,
				text = {
					L["Border"] .. " " .. NAME_COLOR .. "Octo.tga|r",
					L["RAID"] .. " " .. NAME_COLOR .. E.func_GetName("dungeon", 1592) .. "|r" .. Version_120007,
					L["RAID_INFO_WORLD_BOSS"] .. " " .. NAME_COLOR .. E.func_GetName("npc", 260833) .. "|r",
				},
			},
			{
				version = 115.4,
				date = formatterstr("18.06.2026"),
				-- date = { day = 18, month = 6, year = 2026 },
				wowVersion = Version_120007,
				text = {
					"Добавлено отображение " .. E.COLOR_RED .. E.func_GetName("spell", 306715) .. "|r",
				},
			},
			{
				version = 115.3,
				date = formatterstr("08.05.2026"),
				-- date = { day = 8, month = 5, year = 2026 },
				wowVersion = Version_120005,
				text = {
					"text 1",
				},
			},
		}
		return tbl
	end
end
----------------------------------------------------------------
local function UpdateToggleIcon(frame, enabled)
	-- frame.SettingsTexture:SetAtlas("bag-arrow")
	-- if enabled then
	--     frame.SettingsTexture:SetRotation(math.pi/2)
	-- else
	--     frame.SettingsTexture:SetRotation(math.pi)
	-- end
	if enabled then
		frame.SettingsTexture:SetAtlas("QuestLog-icon-shrink")
	else
		frame.SettingsTexture:SetAtlas("QuestLog-icon-Expand")
	end
end
function E.func_option_CHANGELOG(category, layout)
	----------------------------------------------------------------
	local EventFrame = CreateFrame("FRAME")
	EventFrame:Hide()
	----------------------------------------------------------------
	local scrollContentFrame_LEFT = CreateFrame("FRAME", nil, layout)
	scrollContentFrame_LEFT:Hide()
	----------------------------------------------------------------
	layout:SetScript("OnShow", function()
			scrollContentFrame_LEFT:Show()
			RunNextFrame(E.func_CreateDataProvider_CHANGELOG)
	end)
	----------------------------------------------------------------
	local func_OnAcquiredLEFT do
		local function togglebuttonOnclick(self, button)
			local frame = self:GetParent()   -- получаем родительский фрейм (тот, где хранятся isParent, version)
			if not frame.isParent then return end
			local version = frame.version
			if version then
				local current = Octo_ToDo_DB_Variables.dataprovider[version]
				Octo_ToDo_DB_Variables.dataprovider[version] = not current
				local newState = Octo_ToDo_DB_Variables.dataprovider[version]
				UpdateToggleIcon(frame, newState)
				-- E.func_CreateDataProvider_CHANGELOG()
				frame.isCollapsed = newState
				frame.node:SetCollapsed(newState)
			end
		end
		function Create_ToggleButton(frame)
			frame.SettingsButton = CreateFrame("BUTTON", nil, frame, "OctoRectTemplate")
			-- frame.SettingsButton:SetSize(WIDTH_BUTTON, WIDTH_BUTTON)
			-- frame.SettingsButton:SetPoint("RIGHT", 1, -1)
			frame.SettingsButton:SetAllPoints()
			frame.SettingsButton:RegisterForClicks("LeftButtonUp")
			frame.SettingsButton:EnableMouse(true)
			frame.SettingsButton:SetCollapsesLayout(true)
			frame.SettingsTexture = frame.SettingsButton:CreateTexture(nil, "BACKGROUND", nil, 5)
			frame.SettingsTexture:SetPoint("RIGHT", 1, -1)
			frame.SettingsTexture:SetSize(HEIGHT_ROW, HEIGHT_ROW)
			-- frame.SettingsTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9) -- zoom 10%
			frame.SettingsButton:SetScript("OnClick", togglebuttonOnclick)
		end
		function Create_TEXTLEFT(frame)
			frame.text = frame:CreateFontString()
			-- frame.text:SetFontObject(E.OctoFont12_MT)
			frame.text:SetPoint("LEFT")
			frame.text:SetWordWrap(false)
			frame.text:SetJustifyV("MIDDLE")
			frame.text:SetJustifyH("LEFT")
		end
		function Create_BACKGROUND(frame)
			frame.BACKGROUND = frame:CreateTexture(nil, "BACKGROUND", nil, -2)
			frame.BACKGROUND:SetAllPoints()
			-- local r, g, b = E.func_Hex2RGBA(E.classColorHexCurrent)
			-- frame.BACKGROUND:SetVertexColor(r, g, b, .2)
			E.func_SetupTextureToFrame(frame.BACKGROUND, E.TEXTURE_HEADER)
		end
		function func_OnAcquiredLEFT(owner, frame, node, new)
			if not new then
				return
			end
			frame:SetWidth(WIDTH_ROW)
			frame:Hide()
			Create_ToggleButton(frame)
			Create_TEXTLEFT(frame)
			Create_BACKGROUND(frame)
			frame:SetHeight(HEIGHT_ROW)
			frame:SetPoint("LEFT", owner, "LEFT")
			frame:SetScript("OnHide", function() frame:Hide() end)
			frame:EnableMouse(true)
			-- E.func_Create_Highlight(frame, owner)
			-- if frame.Highlight then
			-- 	frame:SetScript("OnHide", function() frame.Highlight:Hide() end)
			-- 	frame:SetScript("OnShow", function() frame.Highlight:Show() end)
			-- end
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	local func_Init do
		local function func_ToggleButton(frame)
			if frame.isParent then
				frame.SettingsButton:Show()
				local version = frame.version
				local isEnabled = Octo_ToDo_DB_Variables.dataprovider[version]
				UpdateToggleIcon(frame, isEnabled)
			else
				frame.SettingsButton:Hide()
			end
		end
		local function func_text_LEFT(frame)
			if frame.isParent then
				frame.text:SetFontObject(E.OctoFont14_MT)
			else
				frame.text:SetFontObject(E.OctoFont11_MT)
			end
			frame.text:SetText(frame.dataText)
		end
		local function func_BACKGROUND(frame)
			if frame.isParent then
				local version = frame.version
				local color = E.func_GetColorGradient(version, minAddonVersion, maxAddonVersion, true)
				local r, g, b = E.func_Hex2RGBA(color)
				frame.BACKGROUND:SetVertexColor(r, g, b, .2)
			end
			frame.BACKGROUND:SetShown(frame.isParent)
		end
		function func_Init(frame, node)
			local data = node:GetData()
			frame:Show()
			frame.dataText = data.text
			frame.isParent = data.isParent
			frame.version = data.version
			frame.isCollapsed = data.isCollapsed or false
			frame.node = node
			func_ToggleButton(frame)
			func_text_LEFT(frame)
			func_BACKGROUND(frame)
		end
	end
	----------------------------------------------------------------
	local func_CreateOcto_CHANGELOG do
		local function setup_scroll(layout)
			scrollContentFrame_LEFT:SetPoint("TOPLEFT", layout, "TOPLEFT", 0, -INDENT_CONTAINER-40) -- ОТСТУП СВЕРХУ
			scrollContentFrame_LEFT:SetPoint("BOTTOMRIGHT", layout, "BOTTOMRIGHT", -INDENT_CONTAINER-INDENT_SCROLL, INDENT_CONTAINER) -- ОТСТУП ДЛЯ СКРОЛЛА
			scrollContentFrame_LEFT:SetWidth(WIDTH_DATAPROVIDER)
			scrollContentFrame_LEFT.ScrollBoxLEFT = CreateFrame("FRAME", nil, scrollContentFrame_LEFT, "WowScrollBoxList")
			scrollContentFrame_LEFT.ScrollBoxLEFT:SetAllPoints()
			scrollContentFrame_LEFT.ScrollBarLEFT = CreateFrame("EventFrame", nil, scrollContentFrame_LEFT, "MinimalScrollBar")
			scrollContentFrame_LEFT.ScrollBarLEFT:SetPoint("TOPLEFT", scrollContentFrame_LEFT, "TOPRIGHT", INDENT_SCROLL, 0)
			scrollContentFrame_LEFT.ScrollBarLEFT:SetPoint("BOTTOMLEFT", scrollContentFrame_LEFT, "BOTTOMRIGHT", INDENT_SCROLL, 0)
			scrollContentFrame_LEFT.ViewLEFT = CreateScrollBoxListTreeListView(HEIGHT_ROW) -- (indent, pad, pad, left, pad, spacing)
			scrollContentFrame_LEFT.ViewLEFT:SetElementExtent(HEIGHT_ROW)
			scrollContentFrame_LEFT.ViewLEFT:SetElementInitializer("OctoRectTemplate", function(...) func_Init(...) end)
			scrollContentFrame_LEFT.ViewLEFT:RegisterCallback(scrollContentFrame_LEFT.ViewLEFT.Event.OnAcquiredFrame, func_OnAcquiredLEFT, scrollContentFrame_LEFT)
			ScrollUtil.InitScrollBoxListWithScrollBar(scrollContentFrame_LEFT.ScrollBoxLEFT, scrollContentFrame_LEFT.ScrollBarLEFT, scrollContentFrame_LEFT.ViewLEFT)
			ScrollUtil.AddManagedScrollBarVisibilityBehavior(scrollContentFrame_LEFT.ScrollBoxLEFT, scrollContentFrame_LEFT.ScrollBarLEFT)
		end
		function func_CreateOcto_CHANGELOG()
			layout:SetPoint("TOPLEFT", INDENT_CONTAINER, -INDENT_CONTAINER*2)
			layout:SetPoint("BOTTOMRIGHT", -INDENT_CONTAINER, INDENT_CONTAINER)
			setup_scroll(layout)
		end
	end
	Octo_ToDo_DB_Variables = Octo_ToDo_DB_Variables or {}
	Octo_ToDo_DB_Variables.dataprovider = Octo_ToDo_DB_Variables.dataprovider or {}
	function E.func_CreateDataProvider_CHANGELOG()
		E.CHANGELOG_COLORS_FORTEXT = {}
		local DataProvider = CreateTreeDataProvider()
		local dataArray = func_DataProviderData()  -- теперь это массив
		-- Сразу вычисляем min/max для фона (если нужно)
		-- Можно использовать E.func_GetMinMaxValue с ключом "version" на этом массиве
		minAddonVersion, maxAddonVersion = E.func_GetMinMaxValue(dataArray, "version")
		for _, item in ipairs(dataArray) do
			local versionNumber = item.version
			local data = item  -- теперь data содержит все поля
			table_insert(E.CHANGELOG_COLORS_FORTEXT, versionNumber)
			if Octo_ToDo_DB_Variables.dataprovider[versionNumber] == nil then
				Octo_ToDo_DB_Variables.dataprovider[versionNumber] = false -- ОТКРЫТО
			end
			local parentNode = DataProvider:Insert({
				text = "  v" .. versionNumber .. " " .. data.wowVersion .. data.date .. "|r",
				isParent = true,
				version = versionNumber,
				isCollapsed = Octo_ToDo_DB_Variables.dataprovider[versionNumber],
			})
			parentNode:SetCollapsed(Octo_ToDo_DB_Variables.dataprovider[versionNumber])
			for _, childText in ipairs(data.text) do
				parentNode:Insert({
					text = "• " .. childText,
					isParent = false,
				})
			end
		end
		EventFrame:UpdateDataProvider(DataProvider)
	end
	function EventFrame:UpdateDataProvider(DataProvider)
		scrollContentFrame_LEFT.ViewLEFT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	end
	func_CreateOcto_CHANGELOG()
end