local GlobalAddonName, E = ...
----------------------------------------------------------------
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
local function RegisterMyTables(dataType, value, number, index, path)
	local leftText = E.COLOR_ADDON_RIGHT..tostring(number).."|r"
	if dataType == "sound" then
		LibSharedMedia:Register(dataType, leftText.." "..E.func_Gradient(value), path..value..[[.ogg]])
	elseif dataType == "font" then
		LibSharedMedia:Register(dataType, E.func_Gradient(value), path..value..[[.TTF]], LibSharedMedia.LOCALE_BIT_ruRU + LibSharedMedia.LOCALE_BIT_western)
	elseif dataType == "border" then
		LibSharedMedia:Register(dataType, E.func_Gradient(value), path..value..[[.tga]])
	elseif dataType == "statusbar" then
		LibSharedMedia:Register(dataType, E.func_Gradient(dataType.." "..value), path..value..[[.tga]])
	end
end
----------------------------------------------------------------
do
	local font_tbl = {
		"Expressway Rg Bold",
		-- "Fira Code Regular",
		-- "wqy-zenhei",
	}
	local path = [[Interface\Addons\]]..GlobalAddonName..[[\Media\Fonts\]]
	for index, value in ipairs(font_tbl) do
		RegisterMyTables("font", value, 1, index, path)
	end
end
----------------------------------------------------------------
----------------------------------------------------------------