local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
function E.func_option_userscript(width, tabName)
	-------------------------------------------------
	-- Вкладка: Цвета
	-------------------------------------------------
	local tbl = {
		type = "group",
		name = tabName,
		order = E.func_GetOrder(),
		args = {
			-------------------------------------------------
			-- Сброс цвета
			-------------------------------------------------
			[E.func_AutoKey()] = {
				type = "select",
				name = L["Profiles"],
				desc = E.TEXT_INDEV,
				values = function()
					local t = {}
					local names = {}
					for name in pairs(Octo_profileColors.profiles) do
						names[#names + 1] = name
					end
					table.sort(names)
					for _, name in ipairs(names) do
						t[name] = name
					end
					return t
				end,
				get = function()
					return Octo_profileColors.Current_profile
				end,
				set = function(_, value)
					Octo_profileColors.Current_profile = value
					E.func_UpdateGlobals()
				end,
				width = width,
				order = E.func_GetOrder(),
			},
			-------------------------------------------------
		},
	}
	return tbl
end