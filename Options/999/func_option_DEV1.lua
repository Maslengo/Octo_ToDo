local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
function E.func_option_DEV1(category, layout)
	----------------------------------------------------------------
	local db = Octo_DevTool_DB
	----------------------------------------------------------------
	if E.Octo_DevTool_DB_defaultOptions then
		for headerName, headers in next,(E.Octo_DevTool_DB_defaultOptions) do
			----------------------------------------------------------------
			-- HEADER ------------------------------------------------------
			----------------------------------------------------------------
			E.func_Header(layout, headerName)
			----------------------------------------------------------------
			for _, tbl in ipairs(headers) do
				local variableKey = tbl.variableKey
				local defaultValue = tbl.defaultValue
				local name = tbl.name
				local minValue = tbl.minValue
				local maxValue = tbl.maxValue
				local step = tbl.step
				local variable = E.func_GenerateID()
				local TYPE = type(defaultValue)
				local values = tbl.values or E.editorThemes or {}
				if TYPE == "boolean" then
					----------------------------------------------------------------
					local tooltip = L["CURSOR_SIZE_DEFAULT"]..": "..(defaultValue and L["YES"] or L["NO"])
					local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, db, TYPE, name, defaultValue)
					setting:SetValueChangedCallback(E.func_UpdateGlobals)
					local initializer = Settings.CreateCheckbox(category, setting, tooltip)
					initializer:AddModifyPredicate(function()
							return Octo_DevTool_DB.CONFIG_DEBUG_OPTIONS or false
					end)
					----------------------------------------------------------------
				elseif TYPE == "number" then
					----------------------------------------------------------------
					local function GetValue()
						return db[variableKey] or defaultValue
					end
					local function SetValue(value)
						db[variableKey] = value
					end
					local setting = Settings.RegisterProxySetting(category, variable, TYPE, name, defaultValue, GetValue, SetValue)
					-- setting:SetValueChangedCallback(E.func_CALLBACKTEXTURE)
					local tooltip = L["CURSOR_SIZE_DEFAULT"]..": "..(defaultValue)
					local options = Settings.CreateSliderOptions(minValue, maxValue, step)
					options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
					local initializer = Settings.CreateSlider(category, setting, options, tooltip)
					initializer:AddModifyPredicate(function()
							return Octo_DevTool_DB.CONFIG_DEBUG_OPTIONS or false
					end)
					----------------------------------------------------------------
				elseif TYPE == "string" then
					----------------------------------------------------------------
					local variable = E.func_GenerateID()
					local function GetValue()
						for Wname, tbl in next,(values) do
							if Wname == db[variableKey] then
								return Wname
							end
						end
						return defaultValue
					end
					local function SetValue(v)
						db[variableKey] = v
					end
					local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue, GetValue, SetValue)
					setting:SetValueChangedCallback(E.func_UpdateGlobals)
					local function GetFontOptions()
						local container = Settings.CreateControlTextContainer()
						local count = 0
						for Wname, tbl in next,(values) do
							count = count + 1
							container:Add(Wname, Wname) -- container:Add(value, name)
						end
						return container:GetData()
					end
					local tooltip = L["CURSOR_SIZE_DEFAULT"]..": "..(defaultValue)
					local initializer = Settings.CreateDropdown(category, setting, GetFontOptions, tooltip)
					initializer:AddModifyPredicate(function()
							return Octo_DevTool_DB.CONFIG_DEBUG_OPTIONS or false
					end)
					----------------------------------------------------------------
				end
			end
		end
	end
	----------------------------------------------------------------
end