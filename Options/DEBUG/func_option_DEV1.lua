local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
function E.func_option_DEV1(category, layout)
	----------------------------------------------------------------
	local variableTbl = Octo_DevTool_DB
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
				local TYPE = type(defaultValue)
				-- local values = tbl.values or E.editorThemes or {}
				if TYPE == "boolean" then
					----------------------------------------------------------------
					E.func_Options_CreateCheckbox(category, variableKey, variableTbl, name, defaultValue, tooltip, true)
					----------------------------------------------------------------
				elseif TYPE == "number" then
					----------------------------------------------------------------
					E.func_Options_CreateSlider(category, variableKey, variableTbl, name, defaultValue, tooltip, minValue, maxValue, step)
					----------------------------------------------------------------
				elseif TYPE == "string" then
					----------------------------------------------------------------
					local values = {}
					for themeName, themeData in pairs(E.editorThemes) do
						table.insert(values, {
							value = themeName,
							text = themeName,  -- или можешь использовать локализацию, если есть
						})
					end
					E.func_Options_CreateDropdown(category, variableKey, variableTbl, name, defaultValue, values, tooltip, true)
					----------------------------------------------------------------
				end
			end
		end
	end
	----------------------------------------------------------------
end