local GlobalAddonName, E = ...
local L = E.L

local LibSharedMedia = LibStub("LibSharedMedia-3.0")

local function func_Header(lay_out, text)
	if lay_out and lay_out.AddInitializer then
		lay_out:AddInitializer(CreateSettingsListSectionHeaderInitializer(text))
	end
end


function E.func_option_FONT(category, layout)
	----------------------------------------------------------------
	-- HEADER
	----------------------------------------------------------------
	func_Header(layout, L["Font"])

	----------------------------------------------------------------
	-- 1 Кастомный Dropdown
	-- Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		-- local defaultValue = "Friz Quadrata TT"
		local defaultValue = E.DefaultFont
		local name = L["Font"]

		local function GetValue()
			return Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle or defaultValue
		end

		local function SetValue(value)
			Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle = value
		end

		-- Создаем настройку
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		setting:SetValueChangedCallback(E.func_UpdateFont)

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
			local fontsList = LibSharedMedia:List("font")
			for i, font in ipairs(fontsList) do
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
				dd:ddSetSelectedText(currentFont, nil, nil, nil, GameFontNormal,
					LibSharedMedia:Fetch("font", currentFont))
			end

			-- Обновляем кнопки навигации
			local leftBtn = frame.Control.DecrementButton
			local rightBtn = frame.Control.IncrementButton
			local fontsList = LibSharedMedia:List("font")
			local currentIndex = GetCurrentFontIndex(currentFont)
			local totalFonts = #fontsList

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
				dd:ddSetSelectedText(currentValue, nil, nil, nil, GameFontNormal,
					LibSharedMedia:Fetch("font", currentValue))

				dd:ddSetInitFunc(function(dd, level, value)
					local fonts = LibSharedMedia:HashTable("font")
					local info = {list = {}}

					for i, fontName in ipairs(LibSharedMedia:List("font")) do
						info.list[#info.list + 1] = {
							text = fontName,
							value = fontName,
							fontObject = GameFontHighlightLeft,
							font = fonts[fontName],
							arg1 = dd,
							func = function(btn, ddBtn)
								setting:SetValue(btn.value)
								UpdateDropdownUI(frame, btn.value)
							end,
							checked = (setting:GetValue() or defaultValue) == fontName,
						}
					end
					dd:ddAddButton(info)
				end)
			end

			-- Настраиваем кнопки навигации
			if leftBtn then
				leftBtn:SetScript("OnClick", function()
					E.sound_OnClick()
					local currentFont = setting:GetValue() or defaultValue
					local currentIndex = GetCurrentFontIndex(currentFont)

					if currentIndex > 1 then
						local fontsList = LibSharedMedia:List("font")
						local newFont = fontsList[currentIndex - 1]
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

					if currentIndex < #LibSharedMedia:List("font") then
						local fontsList = LibSharedMedia:List("font")
						local newFont = fontsList[currentIndex + 1]
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
	-- 2 Settings.CreateSlider
	-- Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize
	----------------------------------------------------------------
	do
		-- RegisterProxySetting example. This will run the GetValue and SetValue
		-- callbacks whenever access to the setting is required.
		local variable = E.func_GenerateID()
		local name = FONT_SIZE
		local defaultValue = 11
		local minValue = 8
		local maxValue = 32
		local step = 1
		local function GetValue()
			return Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize or defaultValue
		end
		local function SetValue(value)
			Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontSize = value
		end
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		setting:SetValueChangedCallback(E.func_UpdateFont)
		-- local tooltip = "This is a tooltip for the slider."
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		Settings.CreateSlider(category, setting, options, tooltip)
	end
	----------------------------------------------------------------
	-- 3 Settings.CreateDropdown
	-- Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags
	----------------------------------------------------------------
	do
		local variable = E.func_GenerateID()
		local defaultValue = "OUTLINE"
		local name = L["Font Outline"]
		-- local fonts = LibSharedMedia:HashTable("font")
		-- NAME, VALUE
		local tbl = {
			[""] = NPC_NAMES_DROPDOWN_NONE,
			["MONOCHROME"] = "MONOCHROME",
			["OUTLINE"] = "OUTLINE",
			["THICKOUTLINE"] = "THICKOUTLINE",
			["MONOCHROME, OUTLINE"] = "MONOCHROME, OUTLINE",
			["MONOCHROME, THICKOUTLINE"] = "MONOCHROME, THICKOUTLINE",
		}
		local function GetValue()
			for value, name in next,(tbl) do
				if value == Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags then
					return value
				end
			end
			return defaultValue
		end
		local function SetValue(value)
			Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontFlags = value
		end
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		setting:SetValueChangedCallback(E.func_UpdateFont)
		local function GetFontOptions()
			local container = Settings.CreateControlTextContainer()
			for value, name in next,(tbl) do
				container:Add(value, name) -- container:Add(value, name)
			end
			return container:GetData()
		end
		Settings.CreateDropdown(category, setting, GetFontOptions)
	end
	----------------------------------------------------------------
end