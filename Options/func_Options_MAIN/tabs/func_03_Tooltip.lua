local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
function E.func_03_Tooltip(width, tabName)
	-------------------------------------------------
	-- Вкладка: Подсказки
	-------------------------------------------------
	local tbl = {
		type = "group",
		name = tabName,
		order = E.func_GetOrder(),
		args = {
		},
	}
	return tbl
end