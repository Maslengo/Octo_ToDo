local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
function E.func_04_Characters(width, tabName)
	-------------------------------------------------
	-- Вкладка: Отображение персонажей
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