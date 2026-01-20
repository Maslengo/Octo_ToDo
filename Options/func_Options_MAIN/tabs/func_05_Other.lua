local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
function E.func_05_Other(width, tabName)
	-------------------------------------------------
	-- Вкладка: Другое
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