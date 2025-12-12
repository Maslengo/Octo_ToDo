local GlobalAddonName, E = ...
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
-- function E.func_reloadMenu(DropDown, level, value)
-- DropDown:ddCloseMenus(level)
-- local menu = LibSFDropDown:GetMenu(level)
-- DropDown:ddToggle(level, value, menu.anchorFrame)
-- end
local LINE_WIDTH_LEFT = E.GLOBAL_LINE_WIDTH_LEFT/2

local function CreateBaseDropDown(frame, hex, providerfunc)
	-- local DropDown = CreateFrame("Button", nil, frame, "SecureActionButtonTemplate, BackDropTemplate")
	local DropDown = CreateFrame("Button", nil, frame, "BackDropTemplate")
	DropDown:SetSize(LINE_WIDTH_LEFT, E.GLOBAL_LINE_HEIGHT)
	E.func_SetBackdrop(DropDown)
	-- Стрелка раскрытия меню
	DropDown.ExpandArrow = DropDown:CreateTexture(nil, "ARTWORK")
	DropDown.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DropDown.ExpandArrow:SetPoint("RIGHT", -4, 0)
	-- Текст меню
	DropDown.text = DropDown:CreateFontString()
	DropDown.text:SetFontObject(OctoFont11)
	DropDown.text:SetAllPoints()
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
	DropDown:ddSetMenuButtonHeight(E.ddMenuButtonHeight-4)
	return DropDown
end
----------------------------------------------------------------
-- Меню ToDo
----------------------------------------------------------------
function E.func_Create_DDframe_ToDo(frame, hex, providerfunc)
	local DropDown = CreateBaseDropDown(frame, hex, providerfunc)
	-- Функции для обработки выбора в меню
	local function selectFunctionisShownPLAYER(menuButton, _, _, checked)
		Octo_ToDo_DB_Levels[menuButton.value].PlayerData.isShownPLAYER = checked
		providerfunc()
		frame.ScrollBoxCenter:ScrollToOffset(0)
		frame.horizontalScrollFrame:SetHorizontalScroll(0)
	end
	local function func_remove_GUID(menuButton, arg1)
		local guid = menuButton.value
		Octo_ToDo_DB_Levels[guid] = nil
		if guid == E.curGUID then
			E.func_CheckAll()
			E.func_Collect_All()
		end
		C_Timer.After(1, providerfunc)
	end



	local function func_remove_Profile(menuButton, arg1)
		local profileName = menuButton.value

		-- Проверяем, что это не профиль по умолчанию
		if profileName == "Default" then
			E.func_ShowMessage(L["Cannot delete the default profile"])
			return
		end

		-- Удаляем профиль
		Octo_profileKeys.profiles[profileName] = nil

		-- Если удаляем текущий профиль, переключаемся на Default
		if Octo_profileKeys.CurrentProfile == profileName then
			Octo_profileKeys.CurrentProfile = "Default"
		end

		-- Обновляем интерфейс
		C_Timer.After(1, providerfunc)

		E.func_ShowMessage(L["Profile successfully deleted"])
	end

	local function func_rename_Profile(menuButton, arg1)
		local profileName = menuButton.value

		-- Показываем диалог переименования
		StaticPopupDialogs["OCTO_RENAME_PROFILE_INLINE"] = {
			text = "Введите новое название для профиля '"..profileName.."':",
			button1 = RENAME_GUILD,
			button2 = CANCEL,
			hasEditBox = true,
			editBoxWidth = 260,
			maxLetters = 30,
			OnAccept = function(dialog)
				local newName = dialog.EditBox:GetText():trim()
				if newName and newName ~= "" and newName ~= profileName then
					-- Проверяем, не существует ли уже профиль с таким именем
					if Octo_profileKeys.profiles[newName] then
						E.func_ShowMessage(L["A profile with the same name exists"])
						return
					end

					-- Сохраняем данные профиля под новым именем
					Octo_profileKeys.profiles[newName] = Octo_profileKeys.profiles[profileName]
					-- Удаляем старый профиль
					Octo_profileKeys.profiles[profileName] = nil

					-- Обновляем текущий профиль, если переименовываем текущий
					if Octo_profileKeys.CurrentProfile == profileName then
						Octo_profileKeys.CurrentProfile = newName
					end

					-- Закрываем меню
					self:ddCloseMenus()

					-- Обновляем интерфейс
					providerfunc()

					E.func_ShowMessage(L["Profile successfully renamed"])
				end
			end,
			OnShow = function(dialog)
				dialog.EditBox:SetText(profileName)
				dialog.EditBox:SetFocus()
				dialog.EditBox:HighlightText()
			end,
			EditBoxOnEnterPressed = function(editBox)
				local dialog = editBox:GetParent()
				local newName = editBox:GetText():trim()
				if newName and newName ~= "" and newName ~= profileName then
					if Octo_profileKeys.profiles[newName] then
						E.func_ShowMessage(L["A profile with the same name exists"])
						return
					end

					Octo_profileKeys.profiles[newName] = Octo_profileKeys.profiles[profileName]
					Octo_profileKeys.profiles[profileName] = nil

					if Octo_profileKeys.CurrentProfile == profileName then
						Octo_profileKeys.CurrentProfile = newName
					end

					dialog:Hide()
					providerfunc()
					E.func_ShowMessage(L["Profile successfully renamed"])
				end
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
			preferredIndex = 3,
		}
		StaticPopup_Show("OCTO_RENAME_PROFILE_INLINE")
	end



	local function selectFunctionExpansion(menuButton, _, _, checked)
		Octo_ToDo_DB_Vars.ExpansionToShow[menuButton.value] = checked or nil
		providerfunc()
	end
	local function selectFunctionProfiles(menuButton, _, _, checked)
		Octo_profileKeys.CurrentProfile[menuButton.value] = checked or nil
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
			self:ddAddButton({list = list, LIST_MAX_SIZE = E.LIST_MAX_SIZE}, level)
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
					if Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion and (value ~= E.CurrentRegionName or Octo_ToDo_DB_Vars.ShowOnlyCurrentServer and Server ~= E.func_GetRealmName())
					or not Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion and Octo_ToDo_DB_Vars.ShowOnlyCurrentServer and Server ~= E.func_GetRealmName() then
						vivod = E.Gray_Color..vivod.."|r"
					elseif Server == E.func_GetRealmName() then
						vivod = E.classColorHexCurrent..vivod.."|r"
					end
					info.text = vivod
					info.value = v
					tinsert(list, info)
				end
				self:ddAddButton({list = list, LIST_MAX_SIZE = E.LIST_MAX_SIZE}, level)
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
				self:ddAddButton({list = list, LIST_MAX_SIZE = E.LIST_MAX_SIZE}, level)
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
						info.text = E.func_texturefromIcon(E.ICON_HORDE)..L["Only Horde"]
					else
						info.text = E.func_texturefromIcon(E.ICON_ALLIANCE)..L["Only Alliance"]
					end
					info.checked = Octo_ToDo_DB_Vars.OnlyCurrentFaction
					info.func = function(_, _, _, checked)
						Octo_ToDo_DB_Vars.OnlyCurrentFaction = checked
						providerfunc()
					end
					self:ddAddButton(info, level)
					-- SettingsEnabled
					info.text = "SettingsEnabled"
					info.checked = Octo_profileKeys.SettingsEnabled
					info.func = function(_, _, _, checked)
						Octo_profileKeys.SettingsEnabled = checked
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
				-- Меню фильтров по дополнениям
				local info = {}
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = L["Profiles"]
				info.value = L["Profiles"]
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
							-- for expansionID = #E.OctoTable_Expansions, 1, -1 do
							for expansionID, v in next,(E.OctoTables_Vibor) do
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
				for expansionID, v in next,(E.OctoTables_Vibor) do
					-- for expansionID = #E.OctoTable_Expansions, 1, -1 do
					-- local v = E.OctoTable_Expansions[expansionID]
					info.isNotRadio = true
					info.notCheckable = false
					info.keepShownOnClick = true
					info.text = v.name
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
					-- for expansionID, v in ipairs(E.OctoTable_Expansions) do
					for expansionID, v in next,(E.OctoTables_Vibor) do
						Octo_ToDo_DB_Vars.ExpansionToShow[expansionID] = true
					end
					self:ddRefresh(level)
					providerfunc()
				end
				self:ddAddButton(info, level)
				info.text = HIDE
				info.func = function(_, _, _, checked)
					-- for expansionID, v in ipairs(E.OctoTable_Expansions) do
					for expansionID, v in next,(E.OctoTables_Vibor) do
						Octo_ToDo_DB_Vars.ExpansionToShow[expansionID] = false
					end
					self:ddRefresh(level)
					providerfunc()
				end
				self:ddAddButton(info, level)



				-- Кнопки фильтров для разных типов контента
				local info = {}
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true

			elseif value == L["Profiles"] then
				-- Получаем список профилей
				local profiles = Octo_profileKeys.profiles
				local profileNames = {}

				-- Собираем названия профилей
				for profileName, _ in next, profiles do
					tinsert(profileNames, profileName)
				end

				-- Сортируем имена профилей
				sort(profileNames)

				-- Добавляем кнопки для каждого профиля как радиокнопки
				for _, profileName in ipairs(profileNames) do
					local info = {}
					info.fontObject = OctoFont11
					info.keepShownOnClick = false
					info.notCheckable = false
					info.isNotRadio = false  -- Радиокнопки (только один выбран)
					info.text = profileName
					info.value = profileName
					info.checked = Octo_profileKeys.CurrentProfile == profileName
					info.func = function(menuButton, _, _, checked)
						-- При выборе нового профиля
						Octo_profileKeys.CurrentProfile = menuButton.value
						-- Закрываем меню
						-- self:ddCloseMenus()
						-- Вызываем провайдер для обновления интерфейса
						providerfunc()
					end
					info.arg1 = {self, level, value}
					-- info.remove = func_remove_Profile


					if profileName ~= "Default" then
						info.remove = func_remove_Profile
						info.removeDoNotHide = false
					else
						-- Для профиля Default убираем возможность удаления
						info.remove = nil
					end

					if profileName ~= "Default" then
						info.settings = func_rename_Profile
						info.settingsDoNotHide = true  -- Чтобы меню не закрывалось
					end



					-- info.removeDoNotHide = false
					self:ddAddButton(info, level)
				end

				-- Добавляем разделитель
				self:ddAddSeparator(level)

				-- Функция для создания нового профиля
				local function CreateNewProfile(profileName, copyFromCurrent)
					if profileName and profileName:trim() ~= "" then
						-- Проверяем, не существует ли уже профиль с таким именем
						if profiles[profileName] then
							E.func_ShowMessage(L["A profile with the same name exists"])
							return false
						end

						-- Создаем новый профиль
						if copyFromCurrent and Octo_profileKeys.CurrentProfile then
							-- Копируем данные из текущего профиля
							local currentProfileData = profiles[Octo_profileKeys.CurrentProfile]
							if currentProfileData then
								profiles[profileName] = E.func_DeepCopy(currentProfileData)
							else
								profiles[profileName] = {}
							end
						else
							E.func_CreateNewProfile(profileName) -- СОЗДАТЬ ТУТ НОВЫЙ ПРОФИЛЬ(ИМЯ)
						end

						-- Устанавливаем новый профиль как текущий
						Octo_profileKeys.CurrentProfile = profileName

						-- Закрываем меню (если оно еще открыто)
						self:ddCloseMenus()

						-- Обновляем интерфейс
						providerfunc()

						E.func_ShowMessage(L["Profile successfully created"])
						return true
					end
					return false
				end

				-- Функция показа диалога создания профиля
				local function ShowCreateProfileDialog(copyFromCurrent)
					-- Создаем диалоговое окно
					StaticPopupDialogs["OCTO_CREATE_PROFILE"] = {
						text = copyFromCurrent and L["Enter a name for the new profile|n(will be copied from the current one)"]
						or L["Enter a name for the new profile"],
						button1 = NEW, -- Создать
						button2 = CANCEL,
						hasEditBox = true,
						editBoxWidth = 260,
						maxLetters = 30,
						OnAccept = function(dialog)
							local profileName = dialog.EditBox:GetText():trim()
							CreateNewProfile(profileName, copyFromCurrent)
						end,
						OnShow = function(dialog)
							dialog.EditBox:SetText("")
							dialog.EditBox:SetFocus()
						end,
						EditBoxOnEnterPressed = function(editBox)
							local dialog = editBox:GetParent()
							local profileName = editBox:GetText():trim()
							if CreateNewProfile(profileName, copyFromCurrent) then
								dialog:Hide()
							end
						end,
						EditBoxOnEscapePressed = function(editBox)
							editBox:GetParent():Hide()
						end,
						timeout = 0,
						whileDead = true,
						hideOnEscape = true,
						preferredIndex = 3,
					}
					StaticPopup_Show("OCTO_CREATE_PROFILE")
				end

				-- Кнопка "Создать новый профиль"
				local info = {}
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = L["New profile"]
				info.func = function()
					ShowCreateProfileDialog(false)
				end
				self:ddAddButton(info, level)

				-- Кнопка "Создать и копировать из текущего"
				info = {}
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = L["Copy current"]
				info.disabled = not Octo_profileKeys.CurrentProfile or not profiles[Octo_profileKeys.CurrentProfile]
				info.func = function()
					ShowCreateProfileDialog(true)
				end
				self:ddAddButton(info, level)

				-- Добавляем разделитель
				self:ddAddSeparator(level)

				-- Кнопка "Переименовать текущий профиль"
				info = {}
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = RENAME_GUILD
				info.disabled = Octo_profileKeys.CurrentProfile == "Default" or not profiles[Octo_profileKeys.CurrentProfile]
				info.func = function()
					StaticPopupDialogs["OCTO_RENAME_PROFILE"] = {
						text = L["Enter a new name for the profile"].."|n"..Octo_profileKeys.CurrentProfile,
						button1 = RENAME_GUILD,
						button2 = CANCEL,
						hasEditBox = true,
						editBoxWidth = 260,
						maxLetters = 30,
						OnAccept = function(dialog)
							local newName = dialog.EditBox:GetText():trim()
							if newName and newName ~= "" and newName ~= Octo_profileKeys.CurrentProfile then
								-- Проверяем, не существует ли уже профиль с таким именем
								if profiles[newName] then
									E.func_ShowMessage(L["A profile with the same name exists"])
									return
								end

								-- Сохраняем данные текущего профиля под новым именем
								profiles[newName] = profiles[Octo_profileKeys.CurrentProfile]
								-- Удаляем старый профиль
								profiles[Octo_profileKeys.CurrentProfile] = nil
								-- Устанавливаем новый профиль как текущий
								Octo_profileKeys.CurrentProfile = newName

								-- Закрываем меню
								self:ddCloseMenus()

								-- Обновляем интерфейс
								providerfunc()

								E.func_ShowMessage(L["Profile successfully renamed"])
							end
						end,
						OnShow = function(dialog)
							dialog.EditBox:SetText(Octo_profileKeys.CurrentProfile or "")
							dialog.EditBox:SetFocus()
							dialog.EditBox:HighlightText()
						end,
						EditBoxOnEnterPressed = function(editBox)
							local dialog = editBox:GetParent()
							local newName = editBox:GetText():trim()
							if newName and newName ~= "" and newName ~= Octo_profileKeys.CurrentProfile then
								-- Проверяем, не существует ли уже профиль с таким именем
								if profiles[newName] then
									E.func_ShowMessage(L["A profile with the same name exists"])
									return
								end

								profiles[newName] = profiles[Octo_profileKeys.CurrentProfile]
								profiles[Octo_profileKeys.CurrentProfile] = nil
								Octo_profileKeys.CurrentProfile = newName

								dialog:Hide()
								providerfunc()
								E.func_ShowMessage(L["Profile successfully renamed"])
							end
						end,
						timeout = 0,
						whileDead = true,
						hideOnEscape = true,
						preferredIndex = 3,
					}
					StaticPopup_Show("OCTO_RENAME_PROFILE")
				end
				self:ddAddButton(info, level)

				-- Кнопка "Удалить текущий профиль"
				info = {}
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = L["Delete current profile"]
				info.disabled = Octo_profileKeys.CurrentProfile == "Default" or not profiles[Octo_profileKeys.CurrentProfile]
				info.func = function()
					if Octo_profileKeys.CurrentProfile ~= "Default" then
						-- Запрос подтверждения
						StaticPopupDialogs["OCTO_DELETE_PROFILE"] = {
							text = L["Are you sure you want to delete the profile?"],
							button1 = DELETE, -- Удалить
							button2 = CANCEL,
							OnAccept = function()
								-- Удаляем текущий профиль
								profiles[Octo_profileKeys.CurrentProfile] = nil
								-- Переключаемся на профиль по умолчанию
								Octo_profileKeys.CurrentProfile = "Default"

								-- Закрываем меню
								self:ddCloseMenus()

								-- Обновляем интерфейс
								providerfunc()

								E.func_ShowMessage(L["Profile successfully deleted"])
							end,
							timeout = 0,
							whileDead = true,
							hideOnEscape = true,
							preferredIndex = 3,
						}
						StaticPopup_Show("OCTO_DELETE_PROFILE")
					end
				end
				self:ddAddButton(info, level)






				-- Кнопка "Удалить текущий профиль"
				info = {}
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = E.DEBUG_TEXT.." Удалить Octo_profileKeys"
				info.func = function()
					wipe(Octo_profileKeys)
					-- Octo_profileKeys = nil
					Octo_profileKeys = {}
					Octo_profileKeys.CurrentProfile = "Default"
					Octo_profileKeys.SettingsEnabled = false
					Octo_profileKeys.useGlobalProfile = false
					E.func_CreateNewProfile("Default")
					C_Timer.After(1, function()
						providerfunc()
					end)

				end
				self:ddAddButton(info, level)








			end

	end)
end
----------------------------------------------------------------
-- Меню Achievements
----------------------------------------------------------------
function E.func_Create_DDframe_Achievements(frame, hex, providerfunc)
	local DropDown = CreateBaseDropDown(frame, hex, providerfunc)
	local function selectFunctionAchievementToShow(menuButton, _, arg2, checked)
		Octo_Achievements_DB.Config_Achievements.AchievementToShow[menuButton.value] = checked or nil
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
			if arg1 and cID == parentCategoryID and Octo_Achievements_DB.Config_Achievements.AchievementToShow[categoryID] == true then
				return E.func_Gradient(arg1.name)..arg1.vivod
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
					info.checked = Octo_Achievements_DB.Config_Achievements.AchievementToShow[categoryID]
					info.func = selectFunctionAchievementToShow
					tinsert(list, info)
				end
			end
			self:ddAddButton({list = list, LIST_MAX_SIZE = E.LIST_MAX_SIZE}, level)
			if level == 1 then
				self:ddAddSeparator(level)
				local info = {}
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = "Показывать завершенные"
				info.hasArrow = nil
				info.checked = Octo_Achievements_DB.Config_AchievementShowCompleted
				info.func = function(_, _, _, checked)
					Octo_Achievements_DB.Config_AchievementShowCompleted = checked
					providerfunc()
				end
				self:ddAddButton(info, level)
				info.text = RESET
				info.keepShownOnClick = false
				info.notCheckable = true
				info.func = function(_, _, _, checked)
					-- wipe(Octo_Achievements_DB.Config_Achievements.AchievementToShow)
					Octo_Achievements_DB.Config_Achievements.AchievementToShow = {[92] = true}
					providerfunc()
				end
				self:ddAddButton(info, level)
			end
	end)
end
----------------------------------------------------------------
-- Меню QuestsChanged
----------------------------------------------------------------
function E.func_Create_DDframe_QuestsChanged(frame, hex, providerfunc)
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
				self:ddAddSeparator(level)
				info.text = "wipe QC_Quests"
				info.keepShownOnClick = false
				info.notCheckable = true
				info.func = function(_, _, _, checked)
					wipe(Octo_QuestsChanged_DB.QC_Quests)
					providerfunc()
				end
				self:ddAddButton(info, level)
				info.text = "wipe QC_Vignettes"
				info.keepShownOnClick = false
				info.notCheckable = true
				info.func = function(_, _, _, checked)
					wipe(Octo_QuestsChanged_DB.QC_Vignettes)
					providerfunc()
				end
				self:ddAddButton(info, level)
			end
	end)
end
----------------------------------------------------------------
-- Меню editFrame
----------------------------------------------------------------
function E.func_Create_DDframe_editFrame(frame, hex, providerfunc)
	local DropDown = CreateBaseDropDown(frame, hex, providerfunc)
	local editBox = frame.editFrame:GetEditBox()
	-- Создаем weak-таблицу для хранения обработчиков (если нужно кэшировать)
	local handlerCache = setmetatable({}, { __mode = "v" }) -- weak values
	-- Выносим общие функции за пределы ddSetInitFunc, чтобы не создавать их каждый раз
	local function makeThemeHandler(themeName)
		return function(btn)
			Octo_DevTool_DB.editorTheme = themeName
			LibIndentation.enable(editBox, E.func_createColorScheme(themeName or "Twilight"), Octo_DevTool_DB.editorTabSpaces)
			editBox:SetText(editBox:GetText():trim())
			LibIndentation.indentEditbox(editBox)
			DropDown:ddRefresh(1)
		end
	end
	local function makeTabSizeHandler(tabSize)
		return function(btn)
			Octo_DevTool_DB.editorTabSpaces = tabSize
			LibIndentation.enable(editBox, E.func_createColorScheme(Octo_DevTool_DB.editorTheme or "Twilight"), tabSize)
			editBox:SetText(editBox:GetText():trim())
			LibIndentation.indentEditbox(editBox)
			DropDown:ddRefresh(2)
		end
	end
	local function makeFontSizeHandler(fontSize)
		return function(btn)
			Octo_DevTool_DB.editorFontSize = fontSize
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
					info.checked = function(btn) return Octo_DevTool_DB.editorTheme == name end
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
					info.checked = function(btn) return btn.value == Octo_DevTool_DB.editorTabSpaces end
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
					info.checked = function(btn) return btn.value == Octo_DevTool_DB.editorFontSize end
					info.func = handlerCache[cacheKey]
					dd:ddAddButton(info, level)
				end
			end
	end)
end