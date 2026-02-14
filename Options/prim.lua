

----------------------------------------------------------------
-- 1. Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang].Config_FontStyle
----------------------------------------------------------------
-- do
--     local variable = E.func_GenerateID()
--     local defaultValue = "Friz Quadrata TT"
--     local name = L["Default Font"]
--     local db = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang]
--     db.Config_FontStyle = db.Config_FontStyle or defaultValue
--     local tbl = LibSharedMedia:HashTable("font")
--     local function GetValue()
--         for value, path in next,(tbl) do
--             if value == db.Config_FontStyle then
--                 return value
--             end
--         end
--         return db.Config_FontStyle
--     end
--     local function SetValue(value)
--         db.Config_FontStyle = value
--     end
--     local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
--     setting:SetValueChangedCallback(OnSettingChanged)
--     local function GetFontOptions()
--         local container = Settings.CreateControlTextContainer()
--         for value, path in next,(tbl) do
--             container:Add(value, value)
--         end
--         return container:GetData()
--     end
--     Settings.CreateDropdown(category, setting, GetFontOptions)
-- end


----------------------------------------------------------------
-- 5. МНОЖЕСТВЕННЫЙ ВЫБОР (Checkboxes in Dropdown)
----------------------------------------------------------------
do
	local variable = E.func_GenerateID()
	local name = "Multi-Selection"
	local defaultValue = 0 -- Битовая маска
	local function GetValue()
		return Octo_Options and Octo_Options.testMultiSelect or defaultValue
	end
	local function SetValue(value)
		Octo_Options.testMultiSelect = value
	end
	local setting = Settings.RegisterProxySetting(category, variable, "number", name, defaultValue, GetValue, SetValue)
	setting:SetValueChangedCallback(OnSettingChanged)
	-- Создаем опции с чекбоксами (битовая маска)
	local function GetMultiSelectOptions()
		local container = Settings.CreateControlTextContainer()
		-- Значения: 1, 2, 4, 8 (биты)
		container:AddCheckbox(1, "Enable Feature A", "Toggle feature A")
		container:AddCheckbox(2, "Enable Feature B", "Toggle feature B")
		container:AddCheckbox(3, "Enable Feature C", "Toggle feature C")
		container:AddCheckbox(4, "Enable Feature D", "Toggle feature D")
		return container:GetData()
	end
	Settings.CreateDropdown(category, setting, GetMultiSelectOptions)
end
----------------------------------------------------------------
-- 6. CVAR НАСТРОЙКА (пример)
----------------------------------------------------------------
do
	local variable = E.func_GenerateID()
	local name = "AIBrain"
	-- Регистрируем CVar настройку (пример с чекбоксом)
	local setting = Settings.RegisterCVarSetting(category, variable, "boolean", name)
	setting:SetValueChangedCallback(OnSettingChanged)
	local tooltip = "This uses Blizzard's CVar system"
	Settings.CreateCheckbox(category, setting, tooltip)
end
----------------------------------------------------------------
-- 10
----------------------------------------------------------------
do
	local variable = E.func_GenerateID()
	local defaultValue = "Friz Quadrata TT"
	local name = L["Default Font"]
	local db = Octo_ToDo_DB_Vars.FontOption[E.curLocaleLang]
	db.Config_FontStyle = db.Config_FontStyle or defaultValue
	local tbl = LibSharedMedia:HashTable("font")
	local function GetValue()
		for value, path in next,(tbl) do
			if value == db.Config_FontStyle then
				return value
			end
		end
		return db.Config_FontStyle
	end
	local function SetValue(value)
		db.Config_FontStyle = value
	end
	local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
	setting:SetValueChangedCallback(OnSettingChanged)
	-- local function GetFontOptions()
	--     local container = Settings.CreateControlTextContainer()
	--     for value, path in next,(tbl) do
	--         container:Add(value, value)
	--     end
	--     return container:GetData()
	-- end
	-- Settings.CreateDropdown(category, setting, GetFontOptions)
	local fontDropdownInitializer = CreateFontDropdownWithLibSFDropDown(name, setting, GetValue, SetValue, OnSettingChanged)
	fontDropdownInitializer:Init()
	layout:AddInitializer(fontDropdownInitializer)
end