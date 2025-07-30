local GlobalAddonName, E = ...
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
----------------------------------------------------------------
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibIndentation = LibStub("LibIndentation-1.0")
----------------------------------------------------------------
-- Настраиваем стиль выпадающего меню
----------------------------------------------------------------
LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
		local frame = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
		frame:SetBackdrop(E.menuBackdrop)
		frame:SetPoint("TOPLEFT", 8, -2)
		frame:SetPoint("BOTTOMRIGHT", -8, 2)
		frame:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA)
		frame:SetBackdropBorderColor(0, 0, 0, 1)
		return frame
end)

----------------------------------------------------------------
-- Общие функции
----------------------------------------------------------------
-- function E:reloadMenu(DropDown, level, value)
--     DropDown:ddCloseMenus(level)
--     local menu = LibSFDropDown:GetMenu(level)
--     DropDown:ddToggle(level, value, menu.anchorFrame)
-- end

local function CreateBaseDropDown(frame, hex, providerfunc)
	local WIDTH = Octo_ToDo_DB_Vars.AddonLeftFrameWeight or 200
	local HEIGHT = Octo_ToDo_DB_Vars.AddonHeight or 20
	-- local DropDown = CreateFrame("Button", nil, frame, "SecureActionButtonTemplate, BackDropTemplate")
	local DropDown = CreateFrame("Button", nil, frame, "BackDropTemplate")

	DropDown:SetSize(WIDTH/2, HEIGHT)
	E:func_SetBackdrop(DropDown)

	-- Стрелка раскрытия меню
	DropDown.ExpandArrow = DropDown:CreateTexture(nil, "ARTWORK")
	DropDown.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DropDown.ExpandArrow:SetPoint("RIGHT", -4, 0)

	-- Текст меню
	DropDown.text = DropDown:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DropDown.text:SetAllPoints()
	DropDown.text:SetFontObject(OctoFont11)
	DropDown.text:SetJustifyV("MIDDLE")
	DropDown.text:SetJustifyH("CENTER")
	DropDown.text:SetTextColor(1, 1, 1, 1)
	DropDown.text:SetText(hex..GAMEMENU_OPTIONS.."|r")

	-- Настраиваем библиотеку выпадающего меню
	LibSFDropDown:SetMixin(DropDown)
	DropDown:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 1)
	DropDown:ddSetDisplayMode(GlobalAddonName)
	DropDown:ddSetNoGlobalMouseEvent(true)
	DropDown:ddHideWhenButtonHidden()
	DropDown:RegisterForClicks("LeftButtonUp")

	DropDown:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)

	DropDown:ddSetOpenMenuUp(true)
	DropDown:ddSetMenuButtonHeight(E.ddMenuButtonHeight)

	return DropDown
end

----------------------------------------------------------------
-- Меню ToDo
----------------------------------------------------------------
function E:func_Create_DDframe_ToDo(frame, hex, providerfunc)
	local DropDown = CreateBaseDropDown(frame, hex, providerfunc)

	-- Функции для обработки выбора в меню
	local function selectFunctionisShownPLAYER(menuButton, _, _, checked)
		Octo_ToDo_DB_Levels[menuButton.value].PlayerData.isShownPLAYER = checked
		providerfunc()
		frame.ScrollBoxCENT:ScrollToOffset(0)
		frame.barPanelScroll:SetHorizontalScroll(0)
	end

	local function func_remove_GUID(menuButton, arg1)
		Octo_ToDo_DB_Levels[menuButton.value] = nil
		providerfunc()
	end

	local function selectFunctionExpansion(menuButton, _, _, checked)
		Octo_ToDo_DB_Vars.ExpansionToShow[menuButton.value] = checked or nil
		providerfunc()
	end

	-- Функция инициализации меню
	DropDown:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			info.fontObject = OctoFont11
			local countRegions = 0

			if level == 1 then
				-- Собираем список Region'ов
				local RegionList = {}
				local Octo_Regions = {}
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if CharInfo.PlayerData then
						if not RegionList[CharInfo.PlayerData.CurrentRegionName] then
							countRegions = countRegions + 1
							Octo_Regions[countRegions] = CharInfo.PlayerData.CurrentRegionName
						end
						RegionList[CharInfo.PlayerData.CurrentRegionName] = true
					end
				end
				sort(Octo_Regions)

				-- Если Region'ов больше одного, создаем подменю
				if countRegions > 1 then
					for i, Regions in ipairs(Octo_Regions) do
						local info = {}
						info.fontObject = OctoFont11
						info.hasArrow = true
						info.hasArrowUp = true
						info.keepShownOnClick = true
						info.notCheckable = true
						local vivod = Regions
						if Regions == E.CurrentRegionName then
							vivod = E.classColorHexCurrent..Regions.."|r"
						elseif Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion then
							vivod = E.Gray_Color..vivod.."|r"
						end
						info.text = vivod
						info.value = Regions
						tinsert(list, info)
					end
				else
					local GUID, CharInfo = next(Octo_ToDo_DB_Levels)
					value = CharInfo.PlayerData.CurrentRegionName
				end
			end

			self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)

			-- Обработка разных уровней меню
			if type(value) == "string" then
				-- Меню серверов
				local tbl_Players = {}
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if CharInfo.PlayerData and (CharInfo.PlayerData.CurrentRegionName == value or not value) then
						tbl_Players[CharInfo.PlayerData.curServer] = tbl_Players[CharInfo.PlayerData.curServer] or {}
						tbl_Players[CharInfo.PlayerData.curServer][GUID] = tbl_Players[CharInfo.PlayerData.curServer][GUID] or {}
						tbl_Players[CharInfo.PlayerData.curServer][GUID] = CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r"..(CharInfo.PlayerData.UnitLevel or 0)
					end
				end

				for Server, v in next, (tbl_Players) do
					local info = {}
					info.fontObject = OctoFont11
					info.hasArrow = true
					info.hasArrowUp = true
					info.keepShownOnClick = true
					info.notCheckable = true
					local vivod = Server

					-- Подсвечиваем текущий сервер
					if Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion and (value ~= E.CurrentRegionName or Octo_ToDo_DB_Vars.ShowOnlyCurrentServer and Server ~= E.curServer)
					or not Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion and Octo_ToDo_DB_Vars.ShowOnlyCurrentServer and Server ~= E.curServer then
						vivod = E.Gray_Color..vivod.."|r"
					elseif Server == E.curServer then
						vivod = E.classColorHexCurrent..vivod.."|r"
					end

					info.text = vivod
					info.value = v
					tinsert(list, info)
				end

				self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			elseif type(value) == "table" then
				-- Меню персонажей
				local players_list = {}
				for GUID, names in next, (value) do
					tinsert(players_list, GUID)
				end

				-- Сортируем персонажей
				sort(players_list, function(a, b)
						if Octo_ToDo_DB_Levels[a] and Octo_ToDo_DB_Levels[b] then
							local infoA = Octo_ToDo_DB_Levels[a].PlayerData
							local infoB = Octo_ToDo_DB_Levels[b].PlayerData
							if infoA and infoB then
								return
								(infoA.curServer or 0) > (infoB.curServer or 0) or
								(infoA.curServer or 0) == (infoB.curServer or 0) and (infoA.UnitLevel or 0) > (infoB.UnitLevel or 0) or
								(infoA.UnitLevel or 0) == (infoB.UnitLevel or 0) and (infoA.avgItemLevel or 0) > (infoB.avgItemLevel or 0) or
								(infoA.avgItemLevel or 0) == (infoB.avgItemLevel or 0) and (infoB.Name or 0) > (infoA.Name or 0)
							end
						end
				end)

				-- Добавляем персонажей в меню
				for _, GUID in next, (players_list) do
					if Octo_ToDo_DB_Levels[GUID].PlayerData then
						local info = {}
						info.fontObject = OctoFont11
						info.keepShownOnClick = true
						info.isNotRadio = true
						local vivod = Octo_ToDo_DB_Levels[GUID].PlayerData.classColorHex..Octo_ToDo_DB_Levels[GUID].PlayerData.Name.."|r"
						if Octo_ToDo_DB_Levels[GUID].PlayerData.UnitLevel ~= E.currentMaxLevel then
							vivod = vivod.." "..E.Yellow_Color..(Octo_ToDo_DB_Levels[GUID].PlayerData.UnitLevel or 0).."|r"
						end
						if Octo_ToDo_DB_Levels[GUID].PlayerData.Name == E.curCharName then
							vivod = vivod..E.Green_Color.."*|r"
						end
						info.text = vivod
						info.value = GUID
						info.func = selectFunctionisShownPLAYER
						info.checked = Octo_ToDo_DB_Levels[GUID].PlayerData.isShownPLAYER
						info.arg1 = {self, level, value}
						info.remove = func_remove_GUID
						info.removeDoNotHide = true
						info.icon = Octo_ToDo_DB_Levels[GUID].PlayerData.specIcon
						info.iconInfo = {tSizeX = 16, tSizeY = 16}
						tinsert(list, info)
					end
				end

				self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			end

			-- Добавляем общие кнопки в меню
			if level == 1 then
				-- Кнопки "Показать всех" и "Скрыть всех"
				local function AddShowHideButtons()
					local info = {}
					info.fontObject = OctoFont11
					info.keepShownOnClick = false
					info.notCheckable = true
					info.text = INTERACT_ICONS_SHOW_ALL
					info.icon = false
					info.hasArrow = nil
					info.func = function(_, _, _, checked)
						for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
							CharInfo.PlayerData.isShownPLAYER = true
						end
						providerfunc()
					end
					self:ddAddButton(info, level)

					info.text = HIDE
					info.func = function(_, _, _, checked)
						for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
							CharInfo.PlayerData.isShownPLAYER = false
						end
						providerfunc()
					end
					self:ddAddButton(info, level)
					self:ddAddSeparator(level)
				end

				-- Кнопки фильтров
				local function AddFilterButtons()
					local info = {}
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = false
					info.isNotRadio = true

					-- Только текущий сервер
					info.text = L["Only Current Server"]
					info.hasArrow = nil
					info.checked = Octo_ToDo_DB_Vars.ShowOnlyCurrentServer
					info.func = function(_, _, _, checked)
						Octo_ToDo_DB_Vars.ShowOnlyCurrentServer = checked
						providerfunc()
					end
					self:ddAddButton(info, level)

					-- Только текущий Region (если их несколько)
					if countRegions > 1 then
						info.text = L["Only Current Region"]
						info.checked = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
						info.func = function(_, _, _, checked)
							Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion = checked
							providerfunc()
						end
						self:ddAddButton(info, level)
					end

					-- Только текущая фракция
					if E.curFaction == "Horde" then
						info.text = E:func_texturefromIcon(E.Icon_Horde)..L["Only Horde"]
					else
						info.text = E:func_texturefromIcon(E.Icon_Alliance)..L["Only Alliance"]
					end
					info.checked = Octo_ToDo_DB_Vars.OnlyCurrentFaction
					info.func = function(_, _, _, checked)
						Octo_ToDo_DB_Vars.OnlyCurrentFaction = checked
						providerfunc()
					end
					self:ddAddButton(info, level)

					-- Репутация
					info.text = REPUTATION
					info.checked = Octo_ToDo_DB_Vars.Reputations
					info.func = function(_, _, _, checked)
						Octo_ToDo_DB_Vars.Reputations = checked
						providerfunc()
					end
					self:ddAddButton(info, level)
					self:ddAddSeparator(level)
				end

				AddShowHideButtons()
				AddFilterButtons()

				-- Меню фильтров по дополнениям
				local info = {}
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = EXPANSION_FILTER_TEXT
				info.value = EXPANSION_FILTER_TEXT
				info.icon = false
				info.hasArrow = true
				info.hasArrowUp = true
				self:ddAddButton(info, level)
			elseif value == EXPANSION_FILTER_TEXT then
				-- Виджеты для кнопок
				local info = {}
				info.widgets = {{
						icon = "interface/worldmap/worldmappartyicon",
						OnClick = function(btn)
							PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
							for expansionID = #E.OctoTable_Expansions, 1, -1 do
								Octo_ToDo_DB_Vars.ExpansionToShow[expansionID] = false
							end
							Octo_ToDo_DB_Vars.ExpansionToShow[btn.value] = true
							self:ddRefresh(level)
							providerfunc()
						end,
				}}
				info.checked = function(btn)
					return Octo_ToDo_DB_Vars.ExpansionToShow[btn.value]
				end
				info.func = selectFunctionExpansion
				info.iconInfo = {tSizeX = E.ddMenuButtonHeight*2, tSizeY = E.ddMenuButtonHeight}

				-- Добавляем кнопки для каждого дополнения (в обратном порядке)
				for expansionID = #E.OctoTable_Expansions, 1, -1 do
					local v = E.OctoTable_Expansions[expansionID]
					info.isNotRadio = true
					info.notCheckable = false
					info.keepShownOnClick = true
					info.text = v.color..v.name.."|r"
					info.value = expansionID
					info.icon = v.icon
					self:ddAddButton(info, level)
				end

				info.widgets = nil
				info.iconInfo = nil
				info.checked = nil
				self:ddAddSeparator(level)

				-- Кнопки "Показать все" и "Скрыть все" для дополнений
				local info = {}
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = INTERACT_ICONS_SHOW_ALL
				info.icon = false
				info.func = function(_, _, _, checked)
					for expansionID, v in ipairs(E.OctoTable_Expansions) do
						Octo_ToDo_DB_Vars.ExpansionToShow[expansionID] = true
					end
					self:ddRefresh(level)
					providerfunc()
				end
				self:ddAddButton(info, level)

				info.text = HIDE
				info.func = function(_, _, _, checked)
					for expansionID, v in ipairs(E.OctoTable_Expansions) do
						Octo_ToDo_DB_Vars.ExpansionToShow[expansionID] = false
					end
					self:ddRefresh(level)
					providerfunc()
				end
				self:ddAddButton(info, level)
				self:ddAddSeparator(level)

				-- Кнопки фильтров для разных типов контента
				local info = {}
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true

				local filterButtons = {
					{text = ITEMS, var = "Items"},
					{text = CURRENCY, var = "Currencies"},
					{text = QUESTS_LABEL, var = "Quests"},

					{text = CALENDAR_FILTER_HOLIDAYS, var = "Holidays"},
					{text = DUNGEONS, var = "Dungeons"},
					{text = TRADE_SKILLS, var = "Professions"},
					{text = BONUS_ROLL_REWARD_MONEY, var = "Gold"},
					{text = STAT_AVERAGE_ITEM_LEVEL, var = "ItemLevel"},
					{text = L["Was online"], var = "WasOnline"},
				}

				for _, btn in ipairs(filterButtons) do
					info.text = btn.text
					info.checked = Octo_ToDo_DB_Vars[btn.var]
					info.func = function(_, _, _, checked)
						Octo_ToDo_DB_Vars[btn.var] = checked
						providerfunc()
					end
					self:ddAddButton(info, level)
				end
			end
	end)

end

----------------------------------------------------------------
-- Меню Achievements
----------------------------------------------------------------
function E:func_Create_DDframe_Achievements(frame, hex, providerfunc)
	local DropDown = CreateBaseDropDown(frame, hex, providerfunc)

	local function selectFunctionAchievementToShow(menuButton, _, arg2, checked)
		Octo_Achievements_DB.AchievementToShow[menuButton.value] = checked or nil
		if arg2 == 2 then
			DropDown:ddRefresh(arg2-1)
		end
		providerfunc()
	end

	local function TEST_FUNC(menuButton, arg1)
		local categories = GetCategoryList()
		local cID = menuButton.value
		for i = 1, #categories do
			local categoryID = categories[i]
			local _, parentCategoryID = GetCategoryInfo(categoryID)
			if arg1 and cID == parentCategoryID and Octo_Achievements_DB.AchievementToShow[categoryID] == true then
				return E:func_Gradient(arg1.name)..arg1.vivod
			end
		end
		return arg1.name..arg1.vivod
	end

	DropDown:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			local categories = GetCategoryList()

			for i = 1, #categories do
				local info = {}
				local categoryID = categories[i]
				local name, parentCategoryID = GetCategoryInfo(categoryID)
				local total, completed = GetCategoryNumAchievements(categoryID, true)
				local vivod = " ("..completed.."/"..total..")"

				if total == completed then
					vivod = " "..E.DONE
				else
					if completed == 0 then
						vivod = E.Red_Color..vivod.."|r"
					else
						vivod = E.Yellow_Color..vivod.."|r"
					end
				end

				if parentCategoryID == value or parentCategoryID == -1 and not value then
					info.fontObject = OctoFont11
					info.hasArrow = parentCategoryID == -1 and categoryID ~= 92
					info.keepShownOnClick = true
					info.notCheckable = false
					info.isNotRadio = true

					if parentCategoryID == -1 then
						info.text = TEST_FUNC
					else
						info.text = name..vivod
					end

					info.arg1 = {name = name, vivod = vivod}
					info.arg2 = level
					info.value = categoryID
					info.checked = Octo_Achievements_DB.AchievementToShow[categoryID]
					info.func = selectFunctionAchievementToShow
					tinsert(list, info)
				end
			end

			self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)

			if level == 1 then
				self:ddAddSeparator(level)

				local info = {}
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = "Показывать завершенные"
				info.hasArrow = nil
				info.checked = Octo_Achievements_DB.AchievementShowCompleted
				info.func = function(_, _, _, checked)
					Octo_Achievements_DB.AchievementShowCompleted = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
			end
	end)

end

----------------------------------------------------------------
-- Меню AddonsManager
----------------------------------------------------------------
function E:func_Create_DDframe_AddonsManager_DDMenu()
	local DropDown = CreateFrame("EventFrame", nil, UIParent)
	DropDown:Hide()
	LibSFDropDown:SetMixin(DropDown)
	DropDown:ddSetDisplayMode(GlobalAddonName)

	DropDown:ddSetInitFunc(function(self, level, value)
			local info = {}
			local index = DropDown.index
			local addonName = E:func_GetAddonName(index)

			if level == 1 then
				-- Кнопка Lock/Unlock
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = true
				info.isNotRadio = true
				info.text = Octo_AddonsManager_DB.lock.addons[addonName] and UNLOCK or LOCK
				info.hasArrow = nil
				info.func = function()
					E:func_lockAddonNEW(index)
					providerfunc()
				end
				self:ddAddButton(info, level)

				self:ddAddSeparator(level)

				-- Кнопка профилей
				info.text = "ПРОФИЛИ"
				info.value = "ПРОФИЛИ"
				info.hasArrow = true
				self:ddAddButton(info, level)

				-- Кнопка создания профиля
				info.text = CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE
				info.value = CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE
				info.hasArrow = true
				self:ddAddButton(info, level)

				self:ddAddSeparator(level)

				-- Кнопки Enable/Disable All
				info.text = ENABLE_ALL_ADDONS
				info.hasArrow = nil
				info.func = function()
					E:func_EnableAllAddOns()
					providerfunc()
				end
				self:ddAddButton(info, level)

				info.text = DISABLE_ALL_ADDONS
				info.func = function()
					E:func_DisableAllAddons()
					providerfunc()
				end
				self:ddAddButton(info, level)

				self:ddAddSeparator(level)

				-- Кнопка Debug
				info.text = E.Debug_Color..BINDING_HEADER_DEBUG.."|r"
				info.value = BINDING_HEADER_DEBUG
				info.hasArrow = true
				self:ddAddButton(info, level)
			elseif value == BINDING_HEADER_DEBUG then
				-- Debug меню
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = E.Debug_Color..DELETE.." "..ALL.."|r"
				info.func = function()
					Octo_AddonsManager_DB = {}
					ReloadUI()
				end
				self:ddAddButton(info, level)

				info.text = E.Debug_Color..RELOADUI.."|r"
				info.func = function()
					ReloadUI()
				end
				self:ddAddButton(info, level)
			elseif value == CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE then
				-- Создание профиля
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = "Create"
				info.func = function() self:createProfile() end
				self:ddAddButton(info, level)

				info.text = "|cffFFFFFFCopy current|r"
				info.func = function() self:createProfile(true) end
				self:ddAddButton(info, level)
			elseif value == "ПРОФИЛИ" then
				-- Список профилей
				for profileName, v in next, (Octo_AddonsManager_DB.profiles) do
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true
					info.isNotRadio = true
					info.text = profileName
					info.value = v
					info.hasArrow = true
					info.func = function()
						E:func_LoadProfile(profileName)
						providerfunc()
					end
					self:ddAddButton(info, level)
				end

				self:ddAddSeparator(level)

				info.text = E.Debug_Color..RELOADUI.."|r"
				info.func = function()
					ReloadUI()
				end
				self:ddAddButton(info, level)
			elseif value then -- type(value) == "table"
				-- Список аддонов в профиле
				for k, v in next, (value) do
					if v == true then
						info.fontObject = OctoFont11
						info.keepShownOnClick = true
						info.notCheckable = true
						info.text = k
						info.func = function()
							ReloadUI()
						end
						self:ddAddButton(info, level)
					end
				end
			end
	end)


end

function E:func_Create_DDframe_AddonsManager(frame, hex, providerfunc)
	local DropDown = CreateBaseDropDown(frame, hex, providerfunc)

	DropDown:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}

			if level == 1 then
				-- Основные настройки
				local function AddConfigOption(text, var, hasArrow)
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = false
					info.isNotRadio = true
					info.text = text
					info.value = var
					info.hasArrow = hasArrow or nil
					info.checked = Octo_AddonsManager_DB.config[var]
					info.func = function(_, _, _, checked)
						Octo_AddonsManager_DB.config[var] = checked
						providerfunc()
					end
					self:ddAddButton(info, level)
				end

				AddConfigOption(L["fullName"], "fullName")
				AddConfigOption(L["showIcons"], "showIcons", true)
				AddConfigOption(L["showVersion"], "showVersion")
				AddConfigOption(E.Debug_Color..L["showIndex"].."|r", "showIndex")

				-- Настройка Force Load
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = ADDON_FORCE_LOAD
				info.checked = not E:func_IsAddonVersionCheckEnabled()
				info.func = function(_, _, _, checked)
					C_AddOns.SetAddonVersionCheck(not checked)
					providerfunc()
				end
				self:ddAddButton(info, level)

				self:ddAddSeparator(level)

				-- Профили
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = "ПРОФИЛИ"
				info.value = "ПРОФИЛИ"
				info.hasArrow = true
				self:ddAddButton(info, level)

				-- Создание профиля
				info.text = CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE
				info.value = CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE
				info.hasArrow = true
				self:ddAddButton(info, level)

				self:ddAddSeparator(level)

				-- Enable/Disable All
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = ENABLE_ALL_ADDONS
				info.func = function()
					E:func_EnableAllAddOns()
					providerfunc()
				end
				self:ddAddButton(info, level)

				info.text = DISABLE_ALL_ADDONS
				info.func = function()
					E:func_DisableAllAddons()
					providerfunc()
				end
				self:ddAddButton(info, level)

				self:ddAddSeparator(level)

				-- Debug
				info.text = E.Debug_Color..BINDING_HEADER_DEBUG.."|r"
				info.value = BINDING_HEADER_DEBUG
				info.hasArrow = true
				self:ddAddButton(info, level)
			elseif value == BINDING_HEADER_DEBUG then
				-- Debug меню
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = E.Debug_Color..DELETE.." "..ALL.."|r"
				info.func = function()
					Octo_AddonsManager_DB = {}
					ReloadUI()
				end
				self:ddAddButton(info, level)

				info.text = E.Debug_Color..RELOADUI.."|r"
				info.func = function()
					ReloadUI()
				end
				self:ddAddButton(info, level)
			elseif value == "showIcons" then
				-- Настройки иконок
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = L["showIconsQuestionMark"]
				info.checked = Octo_AddonsManager_DB.config.showIconsQuestionMark
				info.func = function(_, _, _, checked)
					Octo_AddonsManager_DB.config.showIconsQuestionMark = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
			elseif value == CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE then
				-- Создание профиля
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = "Create"
				info.func = function() self:createProfile() end
				self:ddAddButton(info, level)

				info.text = "|cffFFFFFFCopy current|r"
				info.func = function() self:createProfile(true) end
				self:ddAddButton(info, level)
			elseif value == "ПРОФИЛИ" then
				-- Список профилей
				for profileName, v in next, (Octo_AddonsManager_DB.profiles) do
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true
					info.text = profileName
					info.value = v
					info.hasArrow = true
					info.func = function()
						E:func_LoadProfile(profileName)
						providerfunc()
					end
					self:ddAddButton(info, level)
				end

				self:ddAddSeparator(level)

				info.text = E.Debug_Color..RELOADUI.."|r"
				info.func = function()
					ReloadUI()
				end
				self:ddAddButton(info, level)
			elseif value then -- type(value) == "table"
				-- Список аддонов в профиле
				for k, v in next, (value) do
					if v == true then
						info.fontObject = OctoFont11
						info.keepShownOnClick = true
						info.notCheckable = true
						info.text = k
						info.func = function()
							ReloadUI()
						end
						self:ddAddButton(info, level)
					end
				end
			end
	end)

end

----------------------------------------------------------------
-- Меню QuestsChanged
----------------------------------------------------------------
function E:func_Create_DDframe_QuestsChanged(frame, hex, providerfunc)
	local DropDown = CreateBaseDropDown(frame, hex, providerfunc)

	DropDown:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}

			if level == 1 then
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = "QC_Quests"
				info.checked = Octo_ToDo_DB_Vars.QC_Quests
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.QC_Quests = checked
					providerfunc()
				end
				self:ddAddButton(info, level)

				info.text = "QC_Vignettes"
				info.checked = Octo_ToDo_DB_Vars.QC_Vignettes
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.QC_Vignettes = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
			end
	end)

end

----------------------------------------------------------------
-- Меню editFrame
----------------------------------------------------------------
function E:func_Create_DDframe_editFrame(frame, hex, providerfunc)
	local DropDown = CreateBaseDropDown(frame, hex, providerfunc)
	local editBox = frame.editFrame:GetEditBox()

	-- Создаем weak-таблицу для хранения обработчиков (если нужно кэшировать)
	local handlerCache = setmetatable({}, { __mode = "v" }) -- weak values

	-- Выносим общие функции за пределы ddSetInitFunc, чтобы не создавать их каждый раз
	local function makeThemeHandler(themeName)
		return function(btn)
			Octo_ToDo_DB_Vars.editorTheme = themeName
			LibIndentation.enable(editBox, E:func_createColorScheme(themeName or "Twilight"), Octo_ToDo_DB_Vars.editorTabSpaces)
			editBox:SetText(editBox:GetText():trim())
			LibIndentation.indentEditbox(editBox)
			DropDown:ddRefresh(1)
		end
	end

	local function makeTabSizeHandler(tabSize)
		return function(btn)
			Octo_ToDo_DB_Vars.editorTabSpaces = tabSize
			LibIndentation.enable(editBox, E:func_createColorScheme(Octo_ToDo_DB_Vars.editorTheme or "Twilight"), tabSize)
			editBox:SetText(editBox:GetText():trim())
			LibIndentation.indentEditbox(editBox)
			DropDown:ddRefresh(2)
		end
	end

	local function makeFontSizeHandler(fontSize)
		return function(btn)
			Octo_ToDo_DB_Vars.editorFontSize = fontSize
			editBox:SetFont(E.Octo_font, fontSize, "")
			DropDown:ddRefresh(2)
		end
	end

	DropDown:ddSetInitFunc(function(dd, level, value)
			local info = {}
			info.keepShownOnClick = true

			if level == 1 then
				-- Обработчики тем
				for name in next, E.editorThemes do
					local cacheKey = "theme_"..name
					if not handlerCache[cacheKey] then
						handlerCache[cacheKey] = makeThemeHandler(name)
					end

					info.text = name
					info.value = name
					info.checked = function(btn) return Octo_ToDo_DB_Vars.editorTheme == name end
					info.func = handlerCache[cacheKey]
					dd:ddAddButton(info, level)
				end

				dd:ddAddSeparator(level)

				info.notCheckable = true
				info.hasArrow = true
				info.checked = nil
				info.func = nil

				info.text = L["Tab Size"]
				info.value = "tab"
				dd:ddAddButton(info, level)

				info.text = FONT_SIZE
				info.value = "font"
				dd:ddAddButton(info, level)

			elseif value == "tab" then
				-- Обработчики размера табуляции
				for _, v in ipairs({0, 2, 3, 4}) do
					local cacheKey = "tab_"..v
					if not handlerCache[cacheKey] then
						handlerCache[cacheKey] = makeTabSizeHandler(v)
					end

					info.text = v
					info.value = v
					info.checked = function(btn) return btn.value == Octo_ToDo_DB_Vars.editorTabSpaces end
					info.func = handlerCache[cacheKey]
					dd:ddAddButton(info, level)
				end

			elseif value == "font" then
				-- Обработчики размера шрифта
				for i = 10, 16 do
					local cacheKey = "font_"..i
					if not handlerCache[cacheKey] then
						handlerCache[cacheKey] = makeFontSizeHandler(i)
					end

					info.text = i
					info.value = i
					info.checked = function(btn) return btn.value == Octo_ToDo_DB_Vars.editorFontSize end
					info.func = handlerCache[cacheKey]
					dd:ddAddButton(info, level)
				end
			end
	end)
end