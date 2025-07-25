local GlobalAddonName, E = ...
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
----------------------------------------------------------------
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")

local LibSFDropDown = LibStub("LibSFDropDown-1.5") -- Для выпадающих меню
----------------------------------------------------------------
-- Настраиваем стиль выпадающего меню
----------------------------------------------------------------
LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
		local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
		f:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
		f:SetPoint("TOPLEFT", 8, -2)
		f:SetPoint("BOTTOMRIGHT", -8, 2)
		f:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
		f:SetBackdropBorderColor(0, 0, 0, 1)
		return f
end)
----------------------------------------------------------------

function E:reloadMenu(DD_ToDo, level, value)
	DD_ToDo:ddCloseMenus(level)
	local menu = LibSFDropDown:GetMenu(level)
	DD_ToDo:ddToggle(level, value, menu.anchorFrame)
end
-- Функция создания выпадающего меню
function E:func_Create_DD_ToDo(frame, hex, providerfunc)
	local AddonLeftFrameWeight = Octo_ToDo_DB_Vars.AddonLeftFrameWeight -- Ширина левой панели
	local AddonHeight = Octo_ToDo_DB_Vars.AddonHeight

	local DD_ToDo = CreateFrame("Button", "DD_ToDo", frame, "SecureActionButtonTemplate, BackDropTemplate")
	DD_ToDo:SetSize(AddonLeftFrameWeight/2, AddonHeight) -- Octo_ToDo_DB_Vars.SFDropDownWeight
	E:func_SetBackdrop(DD_ToDo) -- Устанавливаем фон
	-- Стрелка раскрытия меню
	DD_ToDo.ExpandArrow = DD_ToDo:CreateTexture(nil, "ARTWORK")
	DD_ToDo.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DD_ToDo.ExpandArrow:SetPoint("RIGHT", -4, 0)
	-- Текст меню
	DD_ToDo.text = DD_ToDo:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD_ToDo.text:SetAllPoints()
	DD_ToDo.text:SetFontObject(OctoFont11)
	DD_ToDo.text:SetJustifyV("MIDDLE")
	DD_ToDo.text:SetJustifyH("CENTER")
	DD_ToDo.text:SetTextColor(1, 1, 1, 1)
	DD_ToDo.text:SetText(hex..GAMEMENU_OPTIONS.."|r")
	-- Настраиваем библиотеку выпадающего меню
	LibSFDropDown:SetMixin(DD_ToDo)
	DD_ToDo:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 0)
	DD_ToDo:ddSetDisplayMode(GlobalAddonName)
	DD_ToDo:ddSetNoGlobalMouseEvent(true)
	DD_ToDo:ddHideWhenButtonHidden()
	DD_ToDo:RegisterForClicks("LeftButtonUp")
	DD_ToDo:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)
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
		-- E:reloadMenu(unpack(arg1))
	end
	local function selectFunctionExpansion(menuButton, _, _, checked)
		Octo_ToDo_DB_Vars.ExpansionToShow[menuButton.value] = checked or nil
		providerfunc()
	end
	-- Функция инициализации меню
	DD_ToDo:ddSetInitFunc(function(self, level, value)
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
				-- Сортируем персонажей по серверу, уровню и предметам
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
				-- Кнопка "Показать всех"
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
				-- Кнопка "Скрыть всех"
				info.text = HIDE
				info.func = function(_, _, _, checked)
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.PlayerData.isShownPLAYER = false
					end
					providerfunc()
				end
				self:ddAddButton(info, level)
				self:ddAddSeparator(level)
				-- Кнопка "Только текущий сервер"
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = L["Only Current Server"]
				info.hasArrow = nil
				info.checked = Octo_ToDo_DB_Vars.ShowOnlyCurrentServer
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.ShowOnlyCurrentServer = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
				-- Кнопка "Только текущий Region" (если их несколько)
				if countRegions > 1 then
					info.text = L["Only Current Region"]
					info.checked = Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion
					info.func = function(_, _, _, checked)
						Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion = checked
						providerfunc()
					end
					self:ddAddButton(info, level)
				end
				-- Кнопка "Только текущая фракция"
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
				-- Кнопка "Репутация"
				info.text = REPUTATION
				info.checked = Octo_ToDo_DB_Vars.Reputations
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.Reputations = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
				self:ddAddSeparator(level)
			end
			-- Меню фильтров по дополнениям
			if level == 1 then
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = EXPANSION_FILTER_TEXT
				info.value = EXPANSION_FILTER_TEXT
				info.icon = false
				info.hasArrow = true
				info.hasArrowUp = true
				info.func = nil
				self:ddAddButton(info, level)
			elseif value == EXPANSION_FILTER_TEXT then
				-- Виджеты для кнопок
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
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				local filterButtons = {
					{text = QUESTS_LABEL, var = "Quests"},
					{text = CALENDAR_FILTER_HOLIDAYS, var = "Holidays"},
					{text = DUNGEONS, var = "Dungeons"},
					{text = ITEMS, var = "Items"},
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
	DD_ToDo:ddSetOpenMenuUp(true)
	DD_ToDo:ddSetMenuButtonHeight(E.ddMenuButtonHeight)
end
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_Create_DDframe_Achievements(frame, hex, providerfunc)
	local AddonLeftFrameWeight = Octo_ToDo_DB_Vars.AddonLeftFrameWeight -- Ширина левой панели
	local AddonHeight = Octo_ToDo_DB_Vars.AddonHeight


	local DD_Achievements = CreateFrame("Button", "DD_Achievements", frame, "SecureActionButtonTemplate, BackDropTemplate")
	DD_Achievements:SetSize(AddonLeftFrameWeight/2, AddonHeight) -- Octo_ToDo_DB_Vars.SFDropDownWeight
	E:func_SetBackdrop(DD_Achievements)
	DD_Achievements.ExpandArrow = DD_Achievements:CreateTexture(nil, "ARTWORK")
	DD_Achievements.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DD_Achievements.ExpandArrow:SetPoint("RIGHT", -4, 0)
	DD_Achievements.text = DD_Achievements:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD_Achievements.text:SetAllPoints()
	DD_Achievements.text:SetFontObject(OctoFont11)
	DD_Achievements.text:SetJustifyV("MIDDLE")
	DD_Achievements.text:SetJustifyH("CENTER")
	DD_Achievements.text:SetTextColor(1, 1, 1, 1)
	DD_Achievements.text:SetText(hex..GAMEMENU_OPTIONS.."|r")
	LibSFDropDown:SetMixin(DD_Achievements)
	DD_Achievements:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 0)
	DD_Achievements:ddSetDisplayMode(GlobalAddonName)
	DD_Achievements:ddSetOpenMenuUp(true)
	DD_Achievements:ddSetNoGlobalMouseEvent(true)
	DD_Achievements:ddHideWhenButtonHidden()
	DD_Achievements:RegisterForClicks("LeftButtonUp")
	DD_Achievements:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)
	local function selectFunctionAchievementToShow(menuButton, _, arg2, checked)
		Octo_Achievements_DB.AchievementToShow[menuButton.value] = checked or nil
		if arg2 == 2 then
			DD_Achievements:ddRefresh(arg2-1)
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
	DD_Achievements:ddSetInitFunc(function(self, level, value)
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
	DD_Achievements:ddSetMenuButtonHeight(16)
end
----------------------------------------------------------------


function E:func_createDDMenu()
	local DDFrame = CreateFrame("EventFrame", "DDFrame", UIParent)
	DDFrame:Hide()
	LibSFDropDown:SetMixin(DDFrame)
	DDFrame:ddSetDisplayMode(GlobalAddonName)
	DDFrame:ddSetInitFunc(function(self, level, value)
			local info = {}
			local index = DDFrame.index
			local addonName = E:func_GetAddonName(index)
			----------------------------------------------------------------
			if level == 1 then
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				-- info.keepShownOnClick = false
				-- info.notCheckable = true -- TRUE убрать чекбокс
				-- info.isNotRadio = true -- TRUE круг, а не квадрат
				-- info.text = ADD.." или Убрать"
				-- info.value = ADD
				-- info.hasArrow = true
				-- self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				if Octo_AddonsManager_DB.lock.addons[E:func_GetAddonName(index)] then
					info.text = UNLOCK
				else
					info.text = LOCK
				end
				info.checked = Octo_AddonsManager_DB.lock.addons[E:func_GetAddonName(index)]
				info.hasArrow = nil
				info.func = function()
					-- E:func_LockAddon(index)
					E:func_lockAddonNEW(index)
					providerfunc()
				end
				self:ddAddButton(info, level)
				-- elseif value == ADD then
				----------------------------------------------------------------
				self:ddAddSeparator(level)
				----------------------------------------------------------------
				for profileName, v in pairs(Octo_AddonsManager_DB.profiles) do
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = false -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.hasArrow = nil
					info.text = profileName
					info.checked = v[E:func_GetAddonName(index)]
					info.func = function(_, _, _, checked)
						if v[E:func_GetAddonName(index)] == true then
							v[E:func_GetAddonName(index)] = false
						else
							v[E:func_GetAddonName(index)] = true
						end
					end
					self:ddAddButton(info, level)
				end
			end
			----------------------------------------------------------------
	end)
end


----------------------------------------------------------------
function E:func_Create_DDframe_AddonsManager(frame, hex, providerfunc)
	local AddonLeftFrameWeight = Octo_ToDo_DB_Vars.AddonLeftFrameWeight -- Ширина левой панели
	local AddonHeight = Octo_ToDo_DB_Vars.AddonHeight

	local DD_AddonsManager = CreateFrame("Button", "DD_AddonsManager", frame, "BackDropTemplate")
	DD_AddonsManager:SetSize(AddonLeftFrameWeight/2, AddonHeight) -- Octo_ToDo_DB_Vars.SFDropDownWeight
	E:func_SetBackdrop(DD_AddonsManager)
	DD_AddonsManager.ExpandArrow = DD_AddonsManager:CreateTexture(nil, "ARTWORK")
	DD_AddonsManager.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	--DD_AddonsManager.ExpandArrow:SetSize(AddonHeight, AddonHeight)
	DD_AddonsManager.ExpandArrow:SetPoint("RIGHT", -4, 0)
	DD_AddonsManager.text = DD_AddonsManager:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD_AddonsManager.text:SetAllPoints()
	DD_AddonsManager.text:SetFontObject(OctoFont11)
	DD_AddonsManager.text:SetJustifyV("MIDDLE")
	DD_AddonsManager.text:SetJustifyH("CENTER")
	DD_AddonsManager.text:SetTextColor(1, 1, 1, 1)
	DD_AddonsManager.text:SetText(hex..GAMEMENU_OPTIONS.."|r")
	LibSFDropDown:SetMixin(DD_AddonsManager)
	DD_AddonsManager:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 0)
	DD_AddonsManager:ddSetDisplayMode(GlobalAddonName)
	DD_AddonsManager:ddSetOpenMenuUp(true)
	DD_AddonsManager:ddSetNoGlobalMouseEvent(true)
	DD_AddonsManager:ddHideWhenButtonHidden()
	DD_AddonsManager:RegisterForClicks("LeftButtonUp")
	DD_AddonsManager:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)
	DD_AddonsManager:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			if level == 1 then
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = L["fullName"]
				info.hasArrow = nil
				info.checked = Octo_AddonsManager_DB.config.fullName
				info.func = function(_, _, _, checked)
					Octo_AddonsManager_DB.config.fullName = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = L["showIcons"]
				info.value = "showIcons"
				info.hasArrow = true
				info.checked = Octo_AddonsManager_DB.config.showIcons
				info.func = function(_, _, _, checked)
					Octo_AddonsManager_DB.config.showIcons = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = L["showVersion"]
				info.hasArrow = nil
				info.checked = Octo_AddonsManager_DB.config.showVersion
				info.func = function(_, _, _, checked)
					Octo_AddonsManager_DB.config.showVersion = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = E.Debug_Color..L["showIndex"].."|r"
				info.hasArrow = nil
				info.checked = Octo_AddonsManager_DB.config.showIndex
				info.func = function(_, _, _, checked)
					Octo_AddonsManager_DB.config.showIndex = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = ADDON_FORCE_LOAD
				info.hasArrow = nil
				info.checked = not E:func_IsAddonVersionCheckEnabled()
				info.func = function(_, _, _, checked)
					C_AddOns.SetAddonVersionCheck(not checked)
					providerfunc()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				self:ddAddSeparator(level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = "ПРОФИЛИ"
				info.value = "ПРОФИЛИ"
				info.hasArrow = true
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE
				info.value = CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE
				info.hasArrow = true
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				self:ddAddSeparator(level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = ENABLE_ALL_ADDONS
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					E:func_EnableAllAddOns()
					providerfunc()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = DISABLE_ALL_ADDONS
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					E:func_DisableAllAddons()
					providerfunc()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				self:ddAddSeparator(level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = E.Debug_Color..BINDING_HEADER_DEBUG.."|r"
				info.value = BINDING_HEADER_DEBUG
				info.hasArrow = true
				self:ddAddButton(info, level)
				----------------------------------------------------------------
			elseif value == BINDING_HEADER_DEBUG then
				----------------------------------------------------------------
				-- info.fontObject = OctoFont11
				-- info.keepShownOnClick = true
				-- info.notCheckable = true -- TRUE убрать чекбокс
				-- info.isNotRadio = true -- TRUE круг, а не квадрат
				-- info.text = E.Debug_Color.."fpde(Octo_AddonsManager_DB)".."|r"
				-- info.hasArrow = nil
				-- info.func = function(_, _, _, checked)
				-- 	fpde(Octo_AddonsManager_DB)
				-- 	for k, v in ipairs(E.OctoTable_Frames) do
				-- 		if v:IsShown() then
				-- 			if k == 2 then
				-- 				-- ПОФИКСИТЬ
				-- 				v:Hide()
				-- 			end
				-- 		end
				-- 	end
				-- end
				-- self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = E.Debug_Color..DELETE.." "..ALL.."|r"
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					Octo_AddonsManager_DB = {}
					ReloadUI()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = E.Debug_Color..RELOADUI.."|r"
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					ReloadUI()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
			elseif value == "showIcons" then
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = L["showIconsQuestionMark"]
				info.hasArrow = nil
				info.checked = Octo_AddonsManager_DB.config.showIconsQuestionMark
				info.func = function(_, _, _, checked)
					Octo_AddonsManager_DB.config.showIconsQuestionMark = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
			elseif value == CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE then
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = "Create"
				info.hasArrow = nil
				info.func = function() self:createProfile() end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = "|cffFFFFFFCopy current|r" -- ПОФИКСИТЬ
				info.hasArrow = nil
				info.func = function() self:createProfile(true) end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
			elseif value == "ПРОФИЛИ" then
				----------------------------------------------------------------
				for profileName, v in next, (Octo_AddonsManager_DB.profiles) do
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = profileName
					info.value = v
					info.hasArrow = true
					info.func = function()
						E:func_LoadProfile(profileName)
						providerfunc()
					end
					self:ddAddButton(info, level)
				end
				----------------------------------------------------------------
				self:ddAddSeparator(level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true -- TRUE убрать чекбокс
				info.isNotRadio = true -- TRUE круг, а не квадрат
				info.text = E.Debug_Color..RELOADUI.."|r"
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					ReloadUI()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
			elseif value then -- type(value) == "table"
				----------------------------------------------------------------
				for k, v in next, (value) do
					if v == true then
						info.fontObject = OctoFont11
						info.keepShownOnClick = true
						info.notCheckable = true -- TRUE убрать чекбокс
						info.isNotRadio = true -- TRUE круг, а не квадрат
						info.text = k
						info.hasArrow = nil
						info.func = function(_, _, _, checked)
							ReloadUI()
						end
						self:ddAddButton(info, level)
					end
				end
				----------------------------------------------------------------
			end
			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
	end)
	DD_AddonsManager:ddSetMenuButtonHeight(16)
end
----------------------------------------------------------------
----------------------------------------------------------------




function E:func_Create_DD_QuestsChanged(frame, hex, providerfunc)
	local AddonLeftFrameWeight = Octo_ToDo_DB_Vars.AddonLeftFrameWeight -- Ширина левой панели
	local AddonHeight = Octo_ToDo_DB_Vars.AddonHeight


	local DD_QuestsChanged = CreateFrame("Button", "DD_QuestsChanged", frame, "BackDropTemplate")
	DD_QuestsChanged:SetSize(AddonLeftFrameWeight/2, AddonHeight) -- Octo_ToDo_DB_Vars.SFDropDownWeight
	E:func_SetBackdrop(DD_QuestsChanged)
	DD_QuestsChanged.ExpandArrow = DD_QuestsChanged:CreateTexture(nil, "ARTWORK")
	DD_QuestsChanged.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	--DD_QuestsChanged.ExpandArrow:SetSize(AddonHeight, AddonHeight)
	DD_QuestsChanged.ExpandArrow:SetPoint("RIGHT", -4, 0)
	DD_QuestsChanged.text = DD_QuestsChanged:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD_QuestsChanged.text:SetAllPoints()
	DD_QuestsChanged.text:SetFontObject(OctoFont11)
	DD_QuestsChanged.text:SetJustifyV("MIDDLE")
	DD_QuestsChanged.text:SetJustifyH("CENTER")
	DD_QuestsChanged.text:SetTextColor(1, 1, 1, 1)
	DD_QuestsChanged.text:SetText(hex..GAMEMENU_OPTIONS.."|r")
	LibSFDropDown:SetMixin(DD_QuestsChanged)
	DD_QuestsChanged:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 0)
	DD_QuestsChanged:ddSetDisplayMode(GlobalAddonName)
	DD_QuestsChanged:ddSetOpenMenuUp(true)
	DD_QuestsChanged:ddSetNoGlobalMouseEvent(true)
	DD_QuestsChanged:ddHideWhenButtonHidden()
	DD_QuestsChanged:RegisterForClicks("LeftButtonUp")
	DD_QuestsChanged:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)
	DD_QuestsChanged:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			if level == 1 then
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = "QC_Quests"
				info.hasArrow = nil
				info.checked = Octo_ToDo_DB_Vars.QC_Quests
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.QC_Quests = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = "QC_Vignettes"
				info.hasArrow = nil
				info.checked = Octo_ToDo_DB_Vars.QC_Vignettes
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.QC_Vignettes = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
			end
			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
	end)
	DD_QuestsChanged:ddSetMenuButtonHeight(16)
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