local GlobalAddonName, E = ...
----------------------------------------------------------------
local LibStub = LibStub
local L = E.L
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibIndentation = LibStub("LibIndentation-1.0")
-- local classR, classG, classB = GetClassColor(E.classFilename) -- Цвет класса игрока
----------------------------------------------------------------
-- Настраиваем стиль выпадающего меню
----------------------------------------------------------------
function E.func_CreateMenuStyle()
	LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
			local frame = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
			frame:SetBackdrop(E.menuBackdrop)
			frame:SetPoint("TOPLEFT", 8, -2)
			frame:SetPoint("BOTTOMRIGHT", -8, 2)
			frame:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA)
			frame:SetBackdropBorderColor(0, 0, 0, 1)
			return frame
	end)
end
----------------------------------------------------------------
function E.func_SetBackdropStyle(frame, hex)
	if not frame then return end
	if not frame.isInit then
		frame.isInit = true
		tinsert(E.OctoFrames_Dropdowns, DropDown)
		local bgCr, bgCg, bgCb, bgCa = E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA
		local R1, G1, B1, A1 = E.func_Hex2RGBA(E.COLOR_FACTION)
		if hex then
			R1, G1, B1, A1 = E.func_Hex2RGBA(hex)
		end
		-- local R1, G1, B1, A1 = GetClassColor(E.classFilename)
		frame:SetBackdrop(E.menuBackdrop)
		-- frame.r, frame.g, frame.b, frame.a = bgCr, bgCg, bgCb, bgCa
		-- frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
		-- frame:SetBackdropBorderColor(0, 0, 0, 1)
		frame:HookScript("OnEnter", function(self)
				self:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA)
				self:SetBackdropBorderColor(R1, G1, G1, 1)
		end)
		frame:HookScript("OnLeave", function(self)
				self:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA)
				self:SetBackdropBorderColor(0, 0, 0, 1)
		end)
		frame:SetScript("OnShow", function(self)
				self:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA)
				self:SetBackdropBorderColor(0, 0, 0, 1)
		end)
	end
end
----------------------------------------------------------------
-- Общие функции
----------------------------------------------------------------
E.OctoFrames_Dropdowns = {}
local LINE_WIDTH_LEFT = E.GLOBAL_LINE_WIDTH_LEFT/2
local function CreateBaseDropDown(frame, hex, providerfunc)
	local DropDown = CreateFrame("BUTTON", nil, frame, "BackDropTemplate")



	DropDown:SetSize(LINE_WIDTH_LEFT, E.GLOBAL_LINE_HEIGHT)
	E.func_SetBackdropStyle(DropDown, hex)
	DropDown.ExpandArrow = DropDown:CreateTexture(nil, "ARTWORK")
	DropDown.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DropDown.ExpandArrow:SetPoint("RIGHT", -4, 0)
	DropDown.text = DropDown:CreateFontString()
	DropDown.text:SetFontObject(OctoFont11)
	DropDown.text:SetAllPoints()
	DropDown.text:SetJustifyV("MIDDLE")
	DropDown.text:SetJustifyH("CENTER")
	DropDown.text:SetTextColor(1, 1, 1, 1)
	DropDown.text:SetText(hex..GAMEMENU_OPTIONS.."|r")
	local width = math.max(math.ceil(DropDown.text:GetStringWidth())+50, 90)
	if width % 2 == 1 then
		width = width + 1
	end
	DropDown:SetSize(width, E.GLOBAL_LINE_HEIGHT)
	LibSFDropDown:SetMixin(DropDown)
	DropDown:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 1)
	DropDown:ddSetDisplayMode(GlobalAddonName)
	DropDown:ddSetNoGlobalMouseEvent(true)
	DropDown:ddHideWhenButtonHidden()
	DropDown:RegisterForClicks("LeftButtonUp")
	DropDown:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)
	DropDown:SetScript("OnMouseDown", function(self)
			-- self.text:ClearAllPoints()
			-- self.text:SetPoint("CENTER", 1, -1)
			self.text:AdjustPointsOffset(1, -1)
	end)
	DropDown:SetScript("OnMouseUp", function(self)
			self.text:SetAllPoints()
			self.text:AdjustPointsOffset(-1, 1)
	end)
	DropDown:ddSetOpenMenuUp(true)
	DropDown:ddSetMenuButtonHeight(E.ddMenuButtonHeight-4)
	return DropDown
end
----------------------------------------------------------------
-- Функции меню персонажей
----------------------------------------------------------------
local function GetRegionsData()
	local RegionList = {}
	local Octo_Regions = {}
	local countRegions = 0
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		if pd and pd.CurrentRegionName then
			if not RegionList[pd.CurrentRegionName] then
				countRegions = countRegions + 1
				Octo_Regions[countRegions] = pd.CurrentRegionName
			end
			RegionList[pd.CurrentRegionName] = true
		end
	end
	if countRegions > 0 then
		sort(Octo_Regions)
	end
	return Octo_Regions, countRegions
end
local function GetServersData(regionName)
	local tbl_Servers = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local curServer = pd.curServer
		-- local curServer = E.func_CharInfo_Server(CharInfo, true)
		local CurrentRegionName = pd.CurrentRegionName
		if pd and curServer and
		(not regionName or CurrentRegionName == regionName) then
			tbl_Servers[curServer] = tbl_Servers[curServer] or {}
		end
	end
	local serverNames = {}
	for serverName, _ in next, tbl_Servers do
		tinsert(serverNames, serverName)
	end
	if #serverNames > 0 then
		sort(serverNames)
	end
	return serverNames
end
local function GetCharactersData(serverName, regionName)
	local characters = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local pd = CharInfo.PlayerData
		local curServer = pd.curServer
		-- local curServer = E.func_CharInfo_Server(CharInfo, true)
		if pd and curServer == serverName and
		(not regionName or pd.CurrentRegionName == regionName) then
			tinsert(characters, {
					GUID = GUID,
					-- Name = pd.Name,
					Name = E.func_CharInfo_NickName(CharInfo, true, false, false, true),
					classColorHex = pd.classColorHex,
					UnitLevel = pd.UnitLevel,
					avgItemLevel = pd.avgItemLevel,
					specIcon = pd.specIcon,
					isShownPlayer = pd.isShownPlayer,
					curServer = curServer
			})
		end
	end
	sort(characters, function(a, b)
			if a.curServer ~= b.curServer then
				return (a.curServer or "") > (b.curServer or "")
			elseif a.UnitLevel ~= b.UnitLevel then
				return (a.UnitLevel or 0) > (b.UnitLevel or 0)
			elseif a.avgItemLevel ~= b.avgItemLevel then
				return (a.avgItemLevel or 0) > (b.avgItemLevel or 0)
			else
				return (a.Name or "") < (b.Name or "")
			end
	end)
	return characters
end
----------------------------------------------------------------
-- Функции меню персонажей
----------------------------------------------------------------
local function CreateCharactersMenu(dropdown, providerfunc)
	local function selectFunctionisShownPlayer(menuButton, _, _, checked)
		Octo_ToDo_DB_Levels[menuButton.value].PlayerData.isShownPlayer = checked
		providerfunc()
	end
	local function RemoveGuid(menuButton, arg1)
		local guid = menuButton.value
		Octo_ToDo_DB_Levels[guid] = nil
		C_Timer.After(1, providerfunc)
	end
	return function(self, level, value)
		if level == 2 then
			-- Сначала иерархия персонажей
			local info = {}
			info.fontObject = OctoFont11
			info.hasArrow = true
			info.hasArrowUp = true
			info.keepShownOnClick = true
			info.notCheckable = true
			local regions, countRegions = GetRegionsData()
			if countRegions > 1 then
				-- Если регионов несколько, показываем их
				for _, regionName in ipairs(regions) do
					info.text = regionName == E.CurrentRegionName and
					E.classColorHexCurrent..regionName.."|r" or regionName
					info.value = regionName
					self:ddAddButton(info, level)
				end
			elseif countRegions == 1 then
				-- Если регион один, показываем сразу сервера этого региона
				local regionName = regions[1]
				local servers = GetServersData(regionName)
				for _, serverName in ipairs(servers) do
					local output = serverName
					if Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion and (regionName ~= E.CurrentRegionName or
						Octo_ToDo_DB_Vars.isOnlyCurrentServer and serverName ~= E.func_GetPlayerRealm()) or
					not Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion and Octo_ToDo_DB_Vars.isOnlyCurrentServer and
					serverName ~= E.func_GetPlayerRealm() then
						output = E.COLOR_GRAY..output.."|r"
					elseif serverName == E.func_GetPlayerRealm() then
						output = E.classColorHexCurrent..output.."|r"
					end
					info.text = output
					info.value = {server = serverName, region = regionName}
					self:ddAddButton(info, level)
				end
			end
			-- Разделитель после иерархии персонажей
			self:ddAddSeparator(level)
			-- Затем кнопки фильтров
			local info = {}
			info.fontObject = OctoFont11
			-- Кнопки "Показать всех" и "Скрыть всех"
			info.hasArrow = nil
			info.keepShownOnClick = false
			info.notCheckable = true
			info.text = L["Show All"] -- INTERACT_ICONS_SHOW_ALL
			info.func = function(_, _, _, checked)
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					local pd = CharInfo.PlayerData
					pd.isShownPlayer = true
				end
				providerfunc()
			end
			self:ddAddButton(info, level)
			info.text = L["Hide All"]
			info.func = function(_, _, _, checked)
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					local pd = CharInfo.PlayerData
					pd.isShownPlayer = false
				end
				providerfunc()
			end
			self:ddAddButton(info, level)
			self:ddAddSeparator(level)
			-- Фильтры
			info.keepShownOnClick = true
			info.notCheckable = false
			info.isNotRadio = true
			-- Только текущий сервер
			info.text = L["Only Current Server"]
			info.checked = Octo_ToDo_DB_Vars.isOnlyCurrentServer
			info.func = function(_, _, _, checked)
				Octo_ToDo_DB_Vars.isOnlyCurrentServer = checked
				providerfunc()
			end
			self:ddAddButton(info, level)
			-- Только текущий регион
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
			if E.FACTION_CURRENT == "Horde" then
				info.text = E.func_texturefromIcon(E.ICON_HORDE)..L["Only Horde"]
			else
				info.text = E.func_texturefromIcon(E.ICON_ALLIANCE)..L["Only Alliance"]
			end
			info.checked = Octo_ToDo_DB_Vars.isOnlyCurrentFaction
			info.func = function(_, _, _, checked)
				Octo_ToDo_DB_Vars.isOnlyCurrentFaction = checked
				providerfunc()
			end
			self:ddAddButton(info, level)
		elseif level == 3 then
			if type(value) == "string" then
				-- Третий уровень: сервера региона
				local info = {}
				info.fontObject = OctoFont11
				info.hasArrow = true
				info.hasArrowUp = true
				info.keepShownOnClick = true
				info.notCheckable = true
				local servers = GetServersData(value)
				for _, serverName in ipairs(servers) do
					local output = serverName
					if Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion and (value ~= E.CurrentRegionName or
						Octo_ToDo_DB_Vars.isOnlyCurrentServer and serverName ~= E.func_GetPlayerRealm()) or
					not Octo_ToDo_DB_Vars.ShowOnlyCurrentRegion and Octo_ToDo_DB_Vars.isOnlyCurrentServer and
					serverName ~= E.func_GetPlayerRealm() then
						output = E.COLOR_GRAY..output.."|r"
					elseif serverName == E.func_GetPlayerRealm() then
						output = E.classColorHexCurrent..output.."|r"
					end
					info.text = output
					info.value = {server = serverName, region = value}
					self:ddAddButton(info, level)
				end
			elseif type(value) == "table" then
				-- Это персонажи сервера (перешли с уровня 2 когда регион один)
				local serverName = value.server
				local regionName = value.region
				local characters = GetCharactersData(serverName, regionName)
				for _, char in ipairs(characters) do
					local info = {}
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.isNotRadio = true
					-- local output = char.classColorHex..char.Name.."|r"
					-- if char.UnitLevel ~= E.currentMaxLevel then
					-- 	output = output.." "..E.COLOR_YELLOW..(char.UnitLevel or 0).."|r"
					-- end
					-- if char.Name == E.curCharName then
					-- 	output = output..E.COLOR_GREEN.."*|r"
					-- end
					-- info.text = output
					info.text = char.Name
					info.value = char.GUID
					info.func = selectFunctionisShownPlayer
					info.checked = char.isShownPlayer
					info.arg1 = {self, level, value}
					if char.GUID ~= E.curGUID then
						info.remove = RemoveGuid
						info.removeDoNotHide = true
					end
					info.icon = char.specIcon
					info.iconInfo = {tSizeX = 16, tSizeY = 16}
					self:ddAddButton(info, level)
				end
			end
		elseif level == 4 then
			-- Четвертый уровень: персонажи сервера
			if value and type(value) == "table" then
				local serverName = value.server
				local regionName = value.region
				local characters = GetCharactersData(serverName, regionName)
				for _, char in ipairs(characters) do
					local info = {}
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.isNotRadio = true
					-- local output = char.classColorHex..char.Name.."|r"
					-- if char.UnitLevel ~= E.currentMaxLevel then
					-- 	output = output.." "..E.COLOR_YELLOW..(char.UnitLevel or 0).."|r"
					-- end
					-- if char.Name == E.curCharName then
					-- 	output = output..E.COLOR_GREEN.."*|r"
					-- end
					-- info.text = output
					info.text = char.Name
					info.value = char.GUID
					info.func = selectFunctionisShownPlayer
					info.checked = char.isShownPlayer
					info.arg1 = {self, level, value}
					if char.GUID ~= E.curGUID then
						info.remove = RemoveGuid
						info.removeDoNotHide = true
					end
					info.icon = char.specIcon
					info.iconInfo = {tSizeX = 16, tSizeY = 16}
					self:ddAddButton(info, level)
				end
			end
		end
	end
end
----------------------------------------------------------------
-- Функции меню дополнений
----------------------------------------------------------------
local function CreateExpansionsMenu(dropdown, providerfunc)
	----------------------------------------------------------------
	local function selectFunctionExpansion(menuButton, _, _, checked)
		local ExpansionToShowTBL = E.func_GetProfileData("ExpansionToShow")
		ExpansionToShowTBL[menuButton.value] = checked or nil
		providerfunc()
	end
	return function(self, level, value)
		local ExpansionToShowTBL = E.func_GetProfileData("ExpansionToShow")
		local info = {}
		info.fontObject = OctoFont11
		info.widgets = {{
				icon = "interface/worldmap/worldmappartyicon",
				OnClick = function(btn)
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
					for expansionID, v in next, E.OctoTables_Vibor do
						ExpansionToShowTBL[expansionID] = false
					end
					ExpansionToShowTBL[btn.value] = true
					self:ddRefresh(level)
					providerfunc()
				end,
		}}
		info.checked = function(btn)
			return ExpansionToShowTBL[btn.value]
		end
		info.func = selectFunctionExpansion
		info.iconInfo = {tSizeX = E.ddMenuButtonHeight*2, tSizeY = E.ddMenuButtonHeight}
		for expansionID, v in next, E.OctoTables_Vibor do
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
		local info = {}
		info.fontObject = OctoFont11
		info.keepShownOnClick = true
		info.notCheckable = true
		info.text = L["Show All"] -- INTERACT_ICONS_SHOW_ALL
		info.func = function(_, _, _, checked)
			for expansionID, v in next, E.OctoTables_Vibor do
				ExpansionToShowTBL[expansionID] = true
			end
			self:ddRefresh(level)
			providerfunc()
		end
		self:ddAddButton(info, level)
		info.text = L["Hide All"]
		info.func = function(_, _, _, checked)
			for expansionID, v in next, E.OctoTables_Vibor do
				ExpansionToShowTBL[expansionID] = false
			end
			self:ddRefresh(level)
			providerfunc()
		end
		self:ddAddButton(info, level)
	end
end
----------------------------------------------------------------
-- Функции меню профилей
----------------------------------------------------------------
local function CreateProfilesMenu(dropdown, providerfunc)
	local function func_remove_Profile(menuButton, arg1)
		local profileName = menuButton.value
		if profileName == "Default" then
			Octo_profileKeys.profiles[profileName] = nil
			E.func_CreateNewProfile(profileName)
			if Octo_profileKeys.CurrentProfile == profileName then
				Octo_profileKeys.CurrentProfile = "Default"
			end
			return
		end
		Octo_profileKeys.profiles[profileName] = nil
		if Octo_profileKeys.CurrentProfile == profileName then
			Octo_profileKeys.CurrentProfile = "Default"
		end
		C_Timer.After(1, providerfunc)
		E.func_PrintMessage(L["Profile successfully deleted"])
	end
	local function func_rename_Profile(menuButton, arg1)
		local profileName = menuButton.value
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
					if Octo_profileKeys.profiles[newName] then
						E.func_PrintMessage(L["A profile with the same name exists"])
						return
					end
					Octo_profileKeys.profiles[newName] = Octo_profileKeys.profiles[profileName]
					Octo_profileKeys.profiles[profileName] = nil
					if Octo_profileKeys.CurrentProfile == profileName then
						-- Octo_profileKeys.CurrentProfile = newName
						E.func_UpdateCurrentProfile(newName)
					end
					dropdown:ddCloseMenus()
					providerfunc()
					E.func_PrintMessage(L["Profile successfully renamed"])
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
						E.func_PrintMessage(L["A profile with the same name exists"])
						return
					end
					Octo_profileKeys.profiles[newName] = Octo_profileKeys.profiles[profileName]
					Octo_profileKeys.profiles[profileName] = nil
					if Octo_profileKeys.CurrentProfile == profileName then
						E.func_UpdateCurrentProfile(newName)
						-- Octo_profileKeys.CurrentProfile = newName
					end
					dialog:Hide()
					providerfunc()
					E.func_PrintMessage(L["Profile successfully renamed"])
				end
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
			preferredIndex = 3,
		}
		StaticPopup_Show("OCTO_RENAME_PROFILE_INLINE")
	end
	local function CreateNewProfile(profileName, copyFromCurrent)
		if profileName and profileName:trim() ~= "" then
			if Octo_profileKeys.profiles[profileName] then
				E.func_PrintMessage(L["A profile with the same name exists"])
				return false
			end
			if copyFromCurrent and Octo_profileKeys.CurrentProfile then
				local currentProfileData = Octo_profileKeys.profiles[Octo_profileKeys.CurrentProfile]
				if currentProfileData then
					Octo_profileKeys.profiles[profileName] = E.func_CopyTableDeep(currentProfileData)
				else
					Octo_profileKeys.profiles[profileName] = {}
				end
			else
				E.func_CreateNewProfile(profileName)
			end
			Octo_profileKeys.CurrentProfile = profileName
			dropdown:ddCloseMenus()
			providerfunc()
			E.func_PrintMessage(L["Profile successfully created"])
			return true
		end
		return false
	end
	local function ShowCreateProfileDialog(copyFromCurrent)
		StaticPopupDialogs["OCTO_CREATE_PROFILE"] = {
			text = copyFromCurrent and L["Enter a name for the new profile|n(will be copied from the current one)"]
			or L["Enter a name for the new profile"],
			button1 = L["Create"],
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
	-- Создаем кнопку удаления с тултипом
	local function createDeleteWidget(profileName)
		return {
			icon = [[Interface/BUTTONS/UI-GroupLoot-Pass-Up]], -- Иконка удаления
			width = 16,
			height = 16,
			OnClick = function(btn)
				func_remove_Profile({value = profileName})
				dropdown:ddCloseMenus()
			end,
			OnTooltipShow = function(btn, tooltip)
				tooltip:AddLine(DELETE, nil, nil, nil, true)
			end,
		}
	end
	-- Interface\GossipFrame\HealerGossipIcon
	-- Interface\Icons\Trade_Engineering
	-- Interface\Buttons\UI-OptionsButton
	-- Создаем кнопку переименования с тултипом
	local function createRenameWidget(profileName)
		return {
			icon = [[Interface\WorldMap\GEAR_64GREY]], -- Иконка шестерёнки
			width = 16,
			height = 16,
			OnClick = function(btn)
				func_rename_Profile({value = profileName})
				dropdown:ddCloseMenus()
			end,
			OnTooltipShow = function(btn, tooltip)
				tooltip:AddLine(RENAME_GUILD, nil, nil, nil, true)
			end,
		}
	end
	local function createResetWidget(profileName)
		return {
			icon = [[talents-button-undo]], -- Иконка удаления
			width = 16,
			height = 16,
			OnClick = function(btn)
				func_remove_Profile({value = profileName})
				dropdown:ddCloseMenus()
			end,
			OnTooltipShow = function(btn, tooltip)
				tooltip:AddLine(RESET, nil, nil, nil, true)
			end,
		}
	end
	return function(self, level, value)
		local profiles = Octo_profileKeys.profiles
		local profileNames = {}
		for profileName, _ in next, profiles do
			tinsert(profileNames, profileName)
		end
		sort(profileNames)
		for _, profileName in ipairs(profileNames) do
			local info = {}
			info.fontObject = OctoFont11
			info.keepShownOnClick = true
			info.notCheckable = false
			info.isNotRadio = false
			info.value = profileName
			info.checked = function(btn) return Octo_profileKeys.CurrentProfile == profileName end
			info.func = function(menuButton, _, _, checked)
				Octo_profileKeys.CurrentProfile = menuButton.value
				self:ddRefresh(level)
				providerfunc()
			end
			info.arg1 = {self, level, value}
			if profileName ~= "Default" then
				info.widgets = {} -- Виджеты
				tinsert(info.widgets, createDeleteWidget(profileName)) -- Кнопка удаления
				tinsert(info.widgets, createRenameWidget(profileName)) -- Кнопка ренейма
				info.text = profileName
			elseif profileName == "Default" then
				info.widgets = {}
				tinsert(info.widgets, createResetWidget(profileName))
				info.text = DEFAULT
				-- else
				--     info.widgets = nil -- Для профиля Default
				--     info.text = DEFAULT
			end
			self:ddAddButton(info, level)
		end
		self:ddAddSeparator(level)
		local info = {}
		info.fontObject = OctoFont11
		info.keepShownOnClick = false
		info.notCheckable = true
		info.text = L["Create"]
		info.func = function()
			ShowCreateProfileDialog(false)
		end
		self:ddAddButton(info, level)
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
	end
end
----------------------------------------------------------------
-- Основная функция меню ToDo
----------------------------------------------------------------
function E.func_Create_DDframe_ToDo(frame, hex, providerfunc)
	local DropDown = CreateBaseDropDown(frame, hex, providerfunc)
	-- Создаем обработчики для каждого типа меню
	local charactersMenu = CreateCharactersMenu(DropDown, providerfunc)
	local expansionsMenu = CreateExpansionsMenu(DropDown, providerfunc)
	local profilesMenu = CreateProfilesMenu(DropDown, providerfunc)
	DropDown:ddSetInitFunc(function(self, level, value)
			if level == 1 then
				-- Основное меню первого уровня
				local info = {}
				info.fontObject = OctoFont11
				-- Меню персонажей
				info.hasArrow = true
				info.hasArrowUp = true
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = L["Characters"]
				info.value = L["Characters"]
				self:ddAddButton(info, level)
				-- Меню дополнений
				info.text = EXPANSION_FILTER_TEXT
				info.value = "expansions"
				self:ddAddButton(info, level)
				-- Меню профилей
				info.text = L["Profiles"]
				info.value = L["Profiles"]
				self:ddAddButton(info, level)
			elseif level == 2 then
				-- Роутинг на соответствующие меню
				if value == L["Characters"] then
					return charactersMenu(self, level, value)
				elseif value == "expansions" then
					return expansionsMenu(self, level, value)
				elseif value == L["Profiles"] then
					return profilesMenu(self, level, value)
				end
			elseif level >= 3 then
				-- Определяем тип меню по значению
				if value == EXPANSION_FILTER_TEXT or (type(value) == "number" and E.OctoTables_Vibor[value]) then
					return expansionsMenu(self, level, value)
				elseif value == L["Profiles"] then
					return profilesMenu(self, level, value)
				else
					return charactersMenu(self, level, value)
				end
			end
	end)
	return DropDown
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
				return E.func_Gradient(arg1.name)..arg1.output
			end
		end
		return arg1.name..arg1.output
	end
	DropDown:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			local categories = GetCategoryList()
			for i = 1, #categories do
				local info = {}
				local categoryID = categories[i]
				local name, parentCategoryID = GetCategoryInfo(categoryID)
				local total, completed = GetCategoryNumAchievements(categoryID, true)
				local output = " ("..completed.."/"..total..")"
				if total == completed then
					output = " "..E.DONE
				else
					if completed == 0 then
						output = E.COLOR_RED..output.."|r"
					else
						output = E.COLOR_YELLOW..output.."|r"
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
						info.text = name..output
					end
					info.arg1 = {name = name, output = output}
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
	local handlerCache = setmetatable({}, { __mode = "kv" }) -- (ПОФИКСИТЬ) Weak table с __mode = "v" работает только со значениями, но ключи могут накапливаться. Лучше использовать __mode = "kv" или очищать периодически.
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