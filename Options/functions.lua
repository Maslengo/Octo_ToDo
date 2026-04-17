local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
function E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue, tooltip, needBlock)
	local variable = E.func_GenerateID()
	local tooltipTEXT = E.func_defaultValue_tooltip(defaultValue)
	if tooltip then
		tooltipTEXT = tooltipTEXT .. "|n|n" .. tooltip
	end
	local function GetValue()
		return variableTbl[variableKey] or defaultValue
	end
	local function SetValue(value)
		variableTbl[variableKey] = value
		E.func_UpdateGlobals()
	end
	if E.interfaceVersion > 120000 then
		local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue), name, defaultValue)
		-- setting:SetValueChangedCallback(E.func_UpdateGlobals)
		local initializer = Settings.CreateCheckbox(category, setting, tooltipTEXT)
		if needBlock then
			initializer:AddModifyPredicate(function()
					return E.DEBUG or false
			end)
		end
	elseif E.interfaceVersion > 10000 then -- WoW 10.2.7 используем CreateCheckBox (большая B)
		-- local setting = Settings.RegisterProxySetting(category, variable, variableTbl, type(defaultValue), name, defaultValue, GetValue, SetValue)
		local v = GetValue()
		local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaultValue), v)
		Settings.SetOnValueChangedCallback(variable, function(event, settingObj, value)
			variableTbl[variableKey] = value -- setting:GetValue()
			E.func_UpdateFont()
			E.func_UpdateGlobals()
		end)

		local initializer = Settings.CreateCheckBox(category, setting, tooltipTEXT)
		if needBlock then
			initializer:AddModifyPredicate(function()
					return E.DEBUG or false
			end)
		end
	end
end
----------------------------------------------------------------
function E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
	local variable = E.func_GenerateID()
	name = name or L["UNKNOWN"]
	minValue = minValue or 0
	maxValue = maxValue or 1
	step = step or 1
	local tooltipText = E.func_defaultValue_tooltip(defaultValue)
	if tooltip then
		tooltipText = tooltipText .. "|n|n" .. tooltip
	end
	local function GetValue()
		return variableTbl[variableKey] or defaultValue
	end
	local function SetValue(value)
		variableTbl[variableKey] = value
		E.func_UpdateFont()
	end
	if E.interfaceVersion > 120000 then
		-- WoW 11.0+
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		-- setting:SetValueChangedCallback(E.func_UpdateFont)
		local initializer = Settings.CreateSliderOptions(minValue, maxValue, step)
		initializer:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		Settings.CreateSlider(category, setting, initializer, tooltipText)

	elseif E.interfaceVersion > 10000 then -- WoW 10.2.7
		-- local setting = Settings.RegisterProxySetting(category, variable, variableTbl, type(defaultValue), name, defaultValue, GetValue, SetValue)
		local v = GetValue()
		local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaultValue), v)
		Settings.SetOnValueChangedCallback(variable, function(event, settingObj, value)
			variableTbl[variableKey] = value -- setting:GetValue()
			E.func_UpdateFont()
			E.func_UpdateGlobals()
		end)

		local initializer = Settings.CreateSliderOptions(minValue, maxValue, step)
		initializer:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		-- Создаём слайдер
		Settings.CreateSlider(category, setting, initializer, tooltipText)

	end
end
----------------------------------------------------------------
function E.func_Options_CreateButton(category, name, buttonText, buttonClick, tooltip)
	-- if E.interfaceVersion > 120000 then
	-- end

	if E.interfaceVersion > 100000 then
		-- local tooltip = L["tooltip text"]
		local addSearchTags = true
		local newTagID = nil
		local gameDataFunc = nil
		local initializer = CreateSettingsButtonInitializer(name, buttonText, buttonClick, tooltip, addSearchTags, newTagID, gameDataFunc)
		local addonLayout = SettingsPanel:GetLayout(category)
		if addonLayout then
			addonLayout:AddInitializer(initializer)
		end
	end
end
----------------------------------------------------------------
function E.func_Options_CreateColorSwatch(category, variableKey, variableTbl, name, defaultValue, tooltip)
	do
		local variable = E.func_GenerateID()

		local function GetValue()
			return variableTbl[variableKey] or defaultValue
		end

		local function SetValue(value)
			variableTbl[variableKey] = value
			E.func_UpdateGlobals()
		end

		local tooltipText = E.func_defaultValue_tooltip(defaultValue)

		local tooltip = nil
		if tooltip then
			tooltipText = tooltipText .. "|n|n" .. tooltip
		end

		if E.interfaceVersion > 150000 then
			-- WoW 11.0+
			local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
			local initializer = Settings.CreateColorSwatch(category, setting)

			local originalCreate = initializer.CreateControl
			initializer.CreateControl = function(self, initializerData)
				local frame = originalCreate(self, initializerData)
				if frame and frame.ColorSwatch then
					frame.ColorSwatch:SetHasOpacity(true)
				end
				return frame
			end

		elseif E.interfaceVersion > 10000 then
			-- WoW 10.2.7
			local layout = SettingsPanel:GetLayout(category)
			if not layout then return end

			local ColorSwatchInitializer = CreateFromMixins(
				ScrollBoxFactoryInitializerMixin,
				SettingsElementHierarchyMixin,
				SettingsSearchableElementMixin
			)

			function ColorSwatchInitializer:Init()
				ScrollBoxFactoryInitializerMixin.Init(self, "SettingsListElementTemplate")
				self.data = {
					name = name,
					tooltip = tooltipText,
				}
				self:AddSearchTags(name)
			end

			function ColorSwatchInitializer:GetExtent()
				return E.BUTTON_HEIGHT
			end

			function ColorSwatchInitializer:InitFrame(frame)
				frame.data = self.data

				if frame.Text then
					frame.Text:SetText(name)
					frame.Text:SetPoint("LEFT", 37, 0)
				end

				local swatch = CreateFrame("Button", nil, frame, "ColorSwatchTemplate")
				swatch:SetPoint("CENTER", -64, 0)
				swatch:SetSize(26, 26)
				swatch:SetFrameStrata("HIGH")

				-- актуальное обновление цвета
				local function UpdateSwatch()
					local color = GetValue()

					-- нормализация (если вдруг прилетит 6 символов)
					if #color == 6 then
						color = "FF" .. color
					end

					local r, g, b, a = E.func_Hex2RGBA(color)

					if swatch.Color then
						swatch.Color:SetColorTexture(r, g, b)
					end

					return r, g, b, a
				end

				-- первичная установка
				local r, g, b, a = UpdateSwatch()

				swatch:SetScript("OnClick", function()
					ColorPickerFrame:Hide()

					-- ПОЛУЧАЕМ ТЕКУЩИЕ ЗНАЧЕНИЯ
					local currentR, currentG, currentB, currentA = UpdateSwatch()

					-- СОХРАНЯЕМ ЗНАЧЕНИЯ ДЛЯ ОТМЕНЫ (копия из переменной)
					local canceledValue = variableTbl[variableKey]  -- сохраняем старое значение

					local function SwatchFunc()
						local newR, newG, newB = ColorPickerFrame:GetColorRGB()
						local newA = ColorPickerFrame:GetColorAlpha()

						swatch.Color:SetColorTexture(newR, newG, newB)

						local colorStr = E.func_RGB2HexString(newR, newG, newB, newA)
						SetValue(colorStr)  -- сохраняем в переменную
					end

					local function CancelFunc()
						-- ВОССТАНАВЛИВАЕМ СТАРОЕ ЗНАЧЕНИЕ В ПЕРЕМЕННУЮ
						if canceledValue then
							variableTbl[variableKey] = canceledValue
							E.func_UpdateGlobals()
						end

						-- ВОССТАНАВЛИВАЕМ ВИЗУАЛЬНОЕ ОТОБРАЖЕНИЕ
						local r, g, b, a = UpdateSwatch()
					end

					ColorPickerFrame:SetupColorPickerAndShow({
						swatchFunc = SwatchFunc,
						cancelFunc = CancelFunc,
						hasOpacity = true,
						opacity = currentA,
						r = currentR,
						g = currentG,
						b = currentB,
						parent = swatch,
					})
				end)

				if tooltipText then
					swatch:SetScript("OnEnter", function()
						GameTooltip:SetOwner(swatch, "ANCHOR_RIGHT")
						GameTooltip:SetText(tooltipText, nil, nil, nil, nil, true)
						GameTooltip:Show()
					end)
					swatch:SetScript("OnLeave", function()
						GameTooltip:Hide()
					end)
				end

				frame.swatch = swatch
			end

			function ColorSwatchInitializer:Resetter(frame)
				if frame.swatch then
					frame.swatch:SetScript("OnClick", nil)
					frame.swatch:SetScript("OnEnter", nil)
					frame.swatch:SetScript("OnLeave", nil)
				end
			end

			local colorInitializer = CreateFromMixins(ColorSwatchInitializer)
			colorInitializer:Init()
			layout:AddInitializer(colorInitializer)
		end
	end
end
----------------------------------------------------------------
function E.func_Options_CreateDropdown(category, variableKey, variableTbl, name, defaultValue, values, tooltip, needBlock)
	local variable = E.func_GenerateID()
	local tooltipText = E.func_defaultValue_tooltip(defaultValue)
	if tooltip then
		tooltipText = tooltipText .. "|n|n" .. tooltip
	end

	local function GetValue()
		local val = variableTbl[variableKey]
		-- Для 12.0+ values может быть таблицей с полями value/text
		for _, option in ipairs(values) do
			if option.value == val then
				return val
			end
		end
		return defaultValue
	end

	local function SetValue(v)
		variableTbl[variableKey] = v
		E.func_UpdateGlobals()
	end

	local function GetOptions()
		local container = Settings.CreateControlTextContainer()
		for _, option in ipairs(values) do
			-- Для 12.0+ нужен именно такой формат
			container:Add(option.value, option.text)
		end
		return container:GetData()
	end

	if E.interfaceVersion > 120000 then -- WoW 12.0+
		-- В 12.0+ RegisterProxySetting: category, variable, variableType, name, defaultValue, getter, setter
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		-- setting:SetValueChangedCallback(E.func_UpdateGlobals)
		Settings.CreateDropdown(category, setting, GetOptions, tooltipText)

	elseif E.interfaceVersion > 10000 then -- WoW 10.2.7
		-- В 10.2.7 RegisterProxySetting: category, variable, variableTbl, variableType, name, defaultValue, getter, setter
		-- local setting = Settings.RegisterProxySetting(category, variable, variableTbl, type(defaultValue), name, defaultValue, GetValue, SetValue)
		local v = GetValue()
		local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaultValue), v)
		Settings.SetOnValueChangedCallback(variable, function(event, settingObj, value)
			variableTbl[variableKey] = value -- setting:GetValue()
			E.func_UpdateFont()
			E.func_UpdateGlobals()
		end)

		Settings.CreateDropDown(category, setting, GetOptions, tooltipText)
	end
end
----------------------------------------------------------------
function E.func_Options_CreateDropdown_FontStyle(category, layout)
	local variable = E.func_GenerateID()
	local variableTbl = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang]
	local variableKey = "Config_FontStyle"
	local function GetValue()
		return variableTbl[variableKey] or defaultValue
	end
	local function SetValue(value)
		variableTbl[variableKey] = value
		E.func_UpdateFont()
	end
	local name = L["Font"]
	local defaultValue = E.DefaultFont
	local fontsList = LibSharedMedia:List("font")
	local tooltipText = E.func_defaultValue_tooltip(defaultValue)
	if E.interfaceVersion > 120000 then
		-- local defaultValue = "Friz Quadrata TT"
		-- Создаем настройку
		local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
		-- setting:SetValueChangedCallback(E.func_UpdateFont)
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
			local dropdown = frame.Control.Dropdown
			if dropdown then
				dropdown:ddSetSelectedValue(currentFont)
				dropdown:ddSetSelectedText(currentFont, nil, nil, nil, GameFontNormal,
					LibSharedMedia:Fetch("font", currentFont))
			end
			-- Обновляем кнопки навигации
			local leftBtn = frame.Control.DecrementButton
			local rightBtn = frame.Control.IncrementButton
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
			local dropdown = frame.Control.Dropdown
			local leftBtn = frame.Control.DecrementButton
			local rightBtn = frame.Control.IncrementButton
			-- Получаем текущее значение
			local currentValue = setting:GetValue() or defaultValue
			-- Инициализируем dropdown
			if dropdown then
				dropdown:ddSetSelectedValue(currentValue)
				dropdown:ddSetSelectedText(currentValue, nil, nil, nil, GameFontNormal, LibSharedMedia:Fetch("font", currentValue))
				dropdown:ddSetInitFunc(function(dropdown, level, value)
						local fonts = LibSharedMedia:HashTable("font")
						local info = {list = {}}
						for i, fontName in ipairs(LibSharedMedia:List("font")) do
							info.list[#info.list + 1] = {
								text = fontName,
								value = fontName,
								fontObject = GameFontHighlightLeft,
								font = fonts[fontName],
								arg1 = dropdown,
								func = function(btn, ddBtn)
									setting:SetValue(btn.value)
									UpdateDropdownUI(frame, btn.value)
								end,
								checked = (setting:GetValue() or defaultValue) == fontName,
							}
						end
						dropdown:ddAddButton(info)
				end)
			end
			-- Настраиваем кнопки навигации
			if leftBtn then
				leftBtn:SetScript("OnClick", function()
						E.sound_OnClick()
						local currentFont = setting:GetValue() or defaultValue
						local currentIndex = GetCurrentFontIndex(currentFont)
						if currentIndex > 1 then
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
	elseif E.interfaceVersion > 10000 then
		local fontValues = {}
		for _, fontName in ipairs(fontsList) do
			fontValues[fontName] = fontName
		end
		-- local setting = Settings.RegisterProxySetting(category, variable, variableTbl, type(defaultValue), name, defaultValue, GetValue, SetValue)
		local v = GetValue()
		local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaultValue), v)
		Settings.SetOnValueChangedCallback(variable, function(event, settingObj, value)
			variableTbl[variableKey] = value -- setting:GetValue()
			E.func_UpdateFont()
			E.func_UpdateGlobals()
		end)

		local function GetOptions()
			local container = Settings.CreateControlTextContainer()
			for fontName in pairs(fontValues) do
				container:Add(fontName, fontName)
			end
			return container:GetData()
		end
		local initializer = Settings.CreateDropDown(category, setting, GetOptions, tooltipText)

	end
end
----------------------------------------------------------------
function E.func_Create(category, layout)

end
----------------------------------------------------------------