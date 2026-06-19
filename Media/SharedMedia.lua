local GlobalAddonName, E = ...
----------------------------------------------------------------
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
local border_tbl = {
	"Octo",
}
local font_tbl = {
	"Expressway Rg Bold",
}
local sound_tbl = {

}
local statusbar_tbl = {

}
----------------------------------------------------------------
local fields = {
	{field = "border", format = "tga", tbl = border_tbl,},
	{field = "font", format = "TTF", tbl = font_tbl,},
	{field = "sound", format = "ogg", tbl = sound_tbl,},
	{field = "statusbar", format = "tga", tbl = statusbar_tbl,},
}

local COLOR_LEFT = E.COLOR_ADDON_LEFT --  E.COLOR_GREEN
local COLOR_RIGHT = E.COLOR_ADDON_RIGHT -- E.COLOR_RED
local func_Gradient = E.func_Gradient
for _, v in ipairs(fields) do

	local field = v.field
	local format = v.format
	local path = [[Interface\Addons\]] .. GlobalAddonName .. [[\Media\]] .. field .. [[\]]
	local tbl = v.tbl
	for i, fileName in ipairs(tbl) do
		LibSharedMedia:Register(
			field,
			func_Gradient(fileName, COLOR_LEFT, COLOR_RIGHT),
			path .. fileName .. [[.]] .. format,
			field == "font" and LibSharedMedia.LOCALE_BIT_ruRU + LibSharedMedia.LOCALE_BIT_western or nil
		)
	end
end
----------------------------------------------------------------