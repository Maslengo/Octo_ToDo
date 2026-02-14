local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local function func_Header(lay_out, text)
	if lay_out and lay_out.AddInitializer then
		lay_out:AddInitializer(CreateSettingsListSectionHeaderInitializer(text))
	end
end
function E.func_option_COLOR_PROFILE(category, layout)
	----------------------------------------------------------------
	-- HEADER
	----------------------------------------------------------------
	-- func_Header(layout, "Profiles")
	----------------------------------------------------------------
	-- 1. Кастомный фрейм (ШРИФТ) с кнопками навигации
	----------------------------------------------------------------
	do
		local tbl = {}
		for profileName in next, (Octo_profileColors.profiles) do
			table.insert(tbl, profileName)
		end
		local variable = E.func_GenerateID()
		local defaultValue = E.TEXT_DEFAULT
		local name = L["Profile"]
		local function GetValue()
			return Octo_profileColors.Current_profile or defaultValue
		end
		local function SetValue(value)
			Octo_profileColors.Current_profile = value -- Octo_profileKeys.Current_profile
		end
		-- Создаем настройку
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		setting:SetValueChangedCallback(E.func_UpdateGlobals)
		-- Создаем кастомный инициализатор
		local OctoFontDropdownInitializer = CreateFromMixins(
			ScrollBoxFactoryInitializerMixin,
			SettingsElementHierarchyMixin,
			SettingsSearchableElementMixin
		)
		function OctoFontDropdownInitializer:Init()
			-- Используем правильный template!
			ScrollBoxFactoryInitializerMixin.Init(self, "OctoSettingsDropdownControlTemplate")
			self.data = {
				name = name,
				tooltip = name,
			}
			self:AddSearchTags(name)
		end
		function OctoFontDropdownInitializer:GetExtent()
			return E.BUTTON_HEIGHT
		end
		-- Вспомогательные функции
		local function GetCurrentFontIndex(fontName)
			for i, font in ipairs(tbl) do
				if font == fontName then
					return i
				end
			end
			return 1
		end
		-- Локальная функция для обновления UI
		local function UpdateDropdownUI(frame, currentFont)
			if not frame or not frame.Control then return end
			local dd = frame.Control.Dropdown
			if dd then
				dd:ddSetSelectedValue(currentFont)
				dd:ddSetSelectedText(currentFont, nil, nil, nil, GameFontNormal, LibSharedMedia:Fetch("font", currentFont))
			end
			-- Обновляем кнопки навигации
			local leftBtn = frame.Control.DecrementButton
			local rightBtn = frame.Control.IncrementButton
			local currentIndex = GetCurrentFontIndex(currentFont)
			local totalFonts = #tbl
			if leftBtn then
				leftBtn:SetEnabled(currentIndex > 1)
			end
			if rightBtn then
				rightBtn:SetEnabled(currentIndex < totalFonts)
			end
		end
		function OctoFontDropdownInitializer:InitFrame(frame)
			-- Инициализируем базовые свойства фрейма
			frame.data = self.data
			-- Если у фрейма есть Text поле (как в SettingsListElementTemplate)
			if frame.Text then
				frame.Text:SetFontObject(GameFontNormal)
				frame.Text:SetText(name)
				frame.Text:SetPoint("LEFT", 37, 0)
			end
			-- Проверяем, есть ли Control (OctoSettingsDropdownControlTemplate)
			if not frame.Control then
				-- Это неправильный template! Нужно проверить структуру вашего template
				return
			end
			local dd = frame.Control.Dropdown
			local leftBtn = frame.Control.DecrementButton
			local rightBtn = frame.Control.IncrementButton
			-- Получаем текущее значение
			local currentValue = setting:GetValue() or defaultValue
			-- Инициализируем dropdown
			if dd then
				dd:ddSetSelectedValue(currentValue)
				dd:ddSetSelectedText(currentValue, nil, nil, nil, GameFontNormal, LibSharedMedia:Fetch("font", currentValue))
				local profilesMenu2 = E.CreateProfilesMenu(dd, providerfunc, Octo_profileColors, "Colors")
				dd:ddSetInitFunc(function(dd, level, value)
						return profilesMenu2(dd, level, value)


							-- local info = {list = {}}
							-- ----------------------------------------------------------------
							-- for i, fontName in ipairs(tbl) do
							-- 	info.list[#info.list + 1] = {
							-- 		text = fontName,
							-- 		value = fontName,
							-- 		fontObject = GameFontHighlightLeft,
							-- 		-- font = fonts[fontName],
							-- 		arg1 = dd,
							-- 		func = function(btn, ddBtn)
							-- 			setting:SetValue(btn.value)
							-- 			UpdateDropdownUI(frame, btn.value)
							-- 		end,
							-- 		checked = (setting:GetValue() or defaultValue) == fontName,
							-- 	}
							-- end
							-- dd:ddAddButton(info)
							-- ----------------------------------------------------------------
							-- dd:ddAddSeparator(level)
							-- ----------------------------------------------------------------
							-- local info = {}
							-- info.fontObject = OctoFont11
							-- info.keepShownOnClick = false
							-- info.notCheckable = true
							-- info.text = L["Create"]
							-- info.func = function()
							-- 	ShowCreateProfileDialog(false)
							-- end
							-- dd:ddAddButton(info, level)
							-- ----------------------------------------------------------------
							-- info = {}
							-- info.fontObject = OctoFont11
							-- info.keepShownOnClick = false
							-- info.notCheckable = true
							-- info.text = L["Copy current"]
							-- info.disabled = not Octo_profileColors.Current_profile or not Octo_profileColors.profiles[Octo_profileColors.Current_profile]
							-- info.func = function()
							-- 	ShowCreateProfileDialog(true)
							-- end
							-- dd:ddAddButton(info, level)
						----------------------------------------------------------------
				end)
			end
			-- Настраиваем кнопки навигации
			if leftBtn then
				leftBtn:SetScript("OnClick", function()
						E.sound_OnClick()
						local currentFont = setting:GetValue() or defaultValue
						local currentIndex = GetCurrentFontIndex(currentFont)
						if currentIndex > 1 then
							local newFont = tbl[currentIndex - 1]
							setting:SetValue(newFont)
							UpdateDropdownUI(frame, newFont)
						end
				end)
			end
			if rightBtn then
				rightBtn:SetScript("OnClick", function()
						E.sound_OnClick()
						local currentFont = setting:GetValue() or defaultValue
						local currentIndex = GetCurrentFontIndex(currentFont)
						if currentIndex < #tbl then
							local newFont = tbl[currentIndex + 1]
							setting:SetValue(newFont)
							UpdateDropdownUI(frame, newFont)
						end
				end)
			end
			-- ВАЖНО: Инициализируем callback контейнер ПРАВИЛЬНО
			-- Используем существующий или создаем новый
			frame.cbrHandles = frame.cbrHandles or Settings.CreateCallbackHandleContainer()
			-- Регистрируем callback для обновлений значения
			frame.cbrHandles:SetOnValueChangedCallback(setting:GetVariable(), function()
					local currentValue = setting:GetValue() or defaultValue
					UpdateDropdownUI(frame, currentValue)
			end)
			-- Обновляем UI сразу
			UpdateDropdownUI(frame, currentValue)
		end
		function OctoFontDropdownInitializer:Resetter(frame)
			-- Очищаем callback контейнер
			if frame.cbrHandles then
				frame.cbrHandles:Unregister()
				frame.cbrHandles = nil
			end
			-- Закрываем выпадающие меню
			if frame.Control and frame.Control.Dropdown then
				frame.Control.Dropdown:ddCloseMenus()
			end
		end
		-- Добавляем инициализатор
		local customFontInitializer = CreateFromMixins(OctoFontDropdownInitializer)
		customFontInitializer:Init()
		layout:AddInitializer(customFontInitializer)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
end