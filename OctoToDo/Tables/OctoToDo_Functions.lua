local GlobalAddonName, E = ...
----------------------------------------------------------------
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
----------------------------------------------------------------
local type, next = type, next
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
local Red_Color = "|cffFF4C4F"
local Gray_Color = "|cff505050"
local White_Color = "|cffFFFFFF"
local Purple_Color = "|cffAF61FF"
local Yellow_Color = "|cffFFF371"
local Green_Color = "|cff4FFF79"
local Orange_Color = "|cffFF661A"
local Blue_Color = "|cff00A3FF"

----------------------------------------------------------------
local OctoTable_bytetoB64 = {
	[0] =
	"a", "b", "c", "d", "e", "f", "g", "h",
	"i", "j", "k", "l", "m", "n", "o", "p",
	"q", "r", "s", "t", "u", "v", "w", "x",
	"y", "z", "A", "B", "C", "D", "E", "F",
	"G", "H", "I", "J", "K", "L", "M", "N",
	"O", "P", "Q", "R", "S", "T", "U", "V",
	"W", "X", "Y", "Z", "0", "1", "2", "3",
	"4", "5", "6", "7", "8", "9", "(", ")",
}
--------------------------------------------------------------------------------
local OctoTable_bytetoB64Color = {
	[0] =
	"0", "1", "2", "3", "4", "5", "6", "7", "8",
	"9", "A", "B", "C", "D", "E", "F",
}
local OctoTable_RIO_COLORS = {
	{["score"] = 10000, ["color"] = {1, 0.5, 0}},
	{["score"] = 3975, ["color"] = {1, 0.5, 0}},
	{["score"] = 3900, ["color"] = {1, 0.49, 0.07}},
	{["score"] = 3875, ["color"] = {0.99, 0.49, 0.11}},
	{["score"] = 3850, ["color"] = {0.99, 0.48, 0.14}},
	{["score"] = 3825, ["color"] = {0.99, 0.48, 0.17}},
	{["score"] = 3805, ["color"] = {0.98, 0.47, 0.19}},
	{["score"] = 3780, ["color"] = {0.98, 0.47, 0.22}},
	{["score"] = 3755, ["color"] = {0.98, 0.46, 0.24}},
	{["score"] = 3730, ["color"] = {0.97, 0.45, 0.25}},
	{["score"] = 3705, ["color"] = {0.97, 0.45, 0.27}},
	{["score"] = 3685, ["color"] = {0.96, 0.44, 0.29}},
	{["score"] = 3660, ["color"] = {0.96, 0.44, 0.31}},
	{["score"] = 3635, ["color"] = {0.96, 0.43, 0.33}},
	{["score"] = 3610, ["color"] = {0.95, 0.42, 0.35}},
	{["score"] = 3585, ["color"] = {0.95, 0.42, 0.36}},
	{["score"] = 3565, ["color"] = {0.95, 0.41, 0.38}},
	{["score"] = 3540, ["color"] = {0.94, 0.41, 0.4}},
	{["score"] = 3515, ["color"] = {0.93, 0.4, 0.41}},
	{["score"] = 3490, ["color"] = {0.93, 0.39, 0.43}},
	{["score"] = 3465, ["color"] = {0.93, 0.39, 0.44}},
	{["score"] = 3445, ["color"] = {0.92, 0.38, 0.46}},
	{["score"] = 3420, ["color"] = {0.91, 0.38, 0.47}},
	{["score"] = 3395, ["color"] = {0.91, 0.37, 0.49}},
	{["score"] = 3370, ["color"] = {0.9, 0.36, 0.51}},
	{["score"] = 3345, ["color"] = {0.9, 0.36, 0.52}},
	{["score"] = 3325, ["color"] = {0.89, 0.35, 0.54}},
	{["score"] = 3300, ["color"] = {0.89, 0.35, 0.55}},
	{["score"] = 3275, ["color"] = {0.88, 0.34, 0.56}},
	{["score"] = 3250, ["color"] = {0.87, 0.33, 0.58}},
	{["score"] = 3225, ["color"] = {0.87, 0.33, 0.6}},
	{["score"] = 3205, ["color"] = {0.86, 0.32, 0.61}},
	{["score"] = 3180, ["color"] = {0.85, 0.32, 0.63}},
	{["score"] = 3155, ["color"] = {0.84, 0.31, 0.64}},
	{["score"] = 3130, ["color"] = {0.84, 0.31, 0.66}},
	{["score"] = 3105, ["color"] = {0.83, 0.3, 0.67}},
	{["score"] = 3085, ["color"] = {0.82, 0.29, 0.69}},
	{["score"] = 3060, ["color"] = {0.81, 0.29, 0.7}},
	{["score"] = 3035, ["color"] = {0.8, 0.28, 0.72}},
	{["score"] = 3010, ["color"] = {0.8, 0.27, 0.73}},
	{["score"] = 2985, ["color"] = {0.78, 0.27, 0.75}},
	{["score"] = 2965, ["color"] = {0.78, 0.27, 0.76}},
	{["score"] = 2940, ["color"] = {0.76, 0.26, 0.78}},
	{["score"] = 2915, ["color"] = {0.76, 0.25, 0.8}},
	{["score"] = 2890, ["color"] = {0.75, 0.25, 0.81}},
	{["score"] = 2865, ["color"] = {0.73, 0.24, 0.82}},
	{["score"] = 2845, ["color"] = {0.72, 0.24, 0.84}},
	{["score"] = 2820, ["color"] = {0.71, 0.23, 0.85}},
	{["score"] = 2795, ["color"] = {0.7, 0.23, 0.87}},
	{["score"] = 2770, ["color"] = {0.68, 0.22, 0.89}},
	{["score"] = 2745, ["color"] = {0.67, 0.22, 0.9}},
	{["score"] = 2725, ["color"] = {0.65, 0.21, 0.92}},
	{["score"] = 2700, ["color"] = {0.64, 0.21, 0.93}},
	{["score"] = 2660, ["color"] = {0.62, 0.23, 0.93}},
	{["score"] = 2635, ["color"] = {0.6, 0.25, 0.93}},
	{["score"] = 2610, ["color"] = {0.58, 0.27, 0.92}},
	{["score"] = 2585, ["color"] = {0.55, 0.29, 0.92}},
	{["score"] = 2560, ["color"] = {0.53, 0.31, 0.91}},
	{["score"] = 2540, ["color"] = {0.51, 0.32, 0.91}},
	{["score"] = 2515, ["color"] = {0.48, 0.34, 0.91}},
	{["score"] = 2490, ["color"] = {0.46, 0.35, 0.9}},
	{["score"] = 2465, ["color"] = {0.43, 0.36, 0.9}},
	{["score"] = 2440, ["color"] = {0.4, 0.37, 0.89}},
	{["score"] = 2420, ["color"] = {0.37, 0.38, 0.89}},
	{["score"] = 2395, ["color"] = {0.34, 0.4, 0.89}},
	{["score"] = 2370, ["color"] = {0.3, 0.4, 0.88}},
	{["score"] = 2345, ["color"] = {0.26, 0.42, 0.88}},
	{["score"] = 2320, ["color"] = {0.21, 0.42, 0.87}},
	{["score"] = 2300, ["color"] = {0.14, 0.43, 0.87}},
	{["score"] = 2275, ["color"] = {0, 0.44, 0.87}},
	{["score"] = 2195, ["color"] = {0.08, 0.45, 0.85}},
	{["score"] = 2170, ["color"] = {0.13, 0.46, 0.85}},
	{["score"] = 2145, ["color"] = {0.16, 0.47, 0.84}},
	{["score"] = 2120, ["color"] = {0.19, 0.48, 0.83}},
	{["score"] = 2100, ["color"] = {0.21, 0.49, 0.82}},
	{["score"] = 2075, ["color"] = {0.23, 0.5, 0.81}},
	{["score"] = 2050, ["color"] = {0.24, 0.51, 0.8}},
	{["score"] = 2025, ["color"] = {0.26, 0.51, 0.78}},
	{["score"] = 2000, ["color"] = {0.27, 0.53, 0.78}},
	{["score"] = 1980, ["color"] = {0.28, 0.53, 0.76}},
	{["score"] = 1955, ["color"] = {0.29, 0.55, 0.76}},
	{["score"] = 1930, ["color"] = {0.3, 0.55, 0.75}},
	{["score"] = 1905, ["color"] = {0.31, 0.56, 0.73}},
	{["score"] = 1880, ["color"] = {0.32, 0.57, 0.73}},
	{["score"] = 1860, ["color"] = {0.33, 0.58, 0.71}},
	{["score"] = 1835, ["color"] = {0.33, 0.59, 0.7}},
	{["score"] = 1810, ["color"] = {0.34, 0.6, 0.69}},
	{["score"] = 1785, ["color"] = {0.35, 0.61, 0.68}},
	{["score"] = 1760, ["color"] = {0.35, 0.62, 0.67}},
	{["score"] = 1740, ["color"] = {0.36, 0.63, 0.66}},
	{["score"] = 1715, ["color"] = {0.36, 0.64, 0.65}},
	{["score"] = 1690, ["color"] = {0.36, 0.65, 0.64}},
	{["score"] = 1665, ["color"] = {0.36, 0.66, 0.63}},
	{["score"] = 1640, ["color"] = {0.37, 0.67, 0.62}},
	{["score"] = 1620, ["color"] = {0.37, 0.68, 0.61}},
	{["score"] = 1595, ["color"] = {0.37, 0.69, 0.6}},
	{["score"] = 1570, ["color"] = {0.37, 0.7, 0.58}},
	{["score"] = 1545, ["color"] = {0.37, 0.71, 0.57}},
	{["score"] = 1520, ["color"] = {0.37, 0.72, 0.56}},
	{["score"] = 1500, ["color"] = {0.37, 0.73, 0.55}},
	{["score"] = 1475, ["color"] = {0.37, 0.74, 0.54}},
	{["score"] = 1450, ["color"] = {0.37, 0.75, 0.53}},
	{["score"] = 1425, ["color"] = {0.37, 0.76, 0.51}},
	{["score"] = 1400, ["color"] = {0.37, 0.77, 0.5}},
	{["score"] = 1380, ["color"] = {0.37, 0.78, 0.49}},
	{["score"] = 1355, ["color"] = {0.36, 0.79, 0.47}},
	{["score"] = 1330, ["color"] = {0.36, 0.8, 0.46}},
	{["score"] = 1305, ["color"] = {0.36, 0.82, 0.45}},
	{["score"] = 1280, ["color"] = {0.35, 0.82, 0.44}},
	{["score"] = 1260, ["color"] = {0.35, 0.84, 0.42}},
	{["score"] = 1235, ["color"] = {0.34, 0.84, 0.41}},
	{["score"] = 1210, ["color"] = {0.34, 0.85, 0.39}},
	{["score"] = 1185, ["color"] = {0.33, 0.87, 0.38}},
	{["score"] = 1160, ["color"] = {0.32, 0.87, 0.36}},
	{["score"] = 1140, ["color"] = {0.31, 0.89, 0.35}},
	{["score"] = 1115, ["color"] = {0.31, 0.9, 0.33}},
	{["score"] = 1090, ["color"] = {0.29, 0.91, 0.31}},
	{["score"] = 1065, ["color"] = {0.28, 0.92, 0.29}},
	{["score"] = 1040, ["color"] = {0.27, 0.93, 0.27}},
	{["score"] = 1020, ["color"] = {0.26, 0.94, 0.25}},
	{["score"] = 995, ["color"] = {0.24, 0.95, 0.23}},
	{["score"] = 970, ["color"] = {0.22, 0.96, 0.2}},
	{["score"] = 945, ["color"] = {0.2, 0.97, 0.17}},
	{["score"] = 920, ["color"] = {0.18, 0.98, 0.14}},
	{["score"] = 900, ["color"] = {0.15, 0.99, 0.09}},
	{["score"] = 875, ["color"] = {0.12, 1, 0}},
	{["score"] = 850, ["color"] = {0.22, 1, 0.13}},
	{["score"] = 825, ["color"] = {0.29, 1, 0.19}},
	{["score"] = 800, ["color"] = {0.35, 1, 0.24}},
	{["score"] = 775, ["color"] = {0.4, 1, 0.29}},
	{["score"] = 750, ["color"] = {0.44, 1, 0.33}},
	{["score"] = 725, ["color"] = {0.47, 1, 0.36}},
	{["score"] = 700, ["color"] = {0.51, 1, 0.4}},
	{["score"] = 675, ["color"] = {0.55, 1, 0.44}},
	{["score"] = 650, ["color"] = {0.58, 1, 0.47}},
	{["score"] = 625, ["color"] = {0.6, 1, 0.5}},
	{["score"] = 600, ["color"] = {0.64, 1, 0.53}},
	{["score"] = 575, ["color"] = {0.66, 1, 0.56}},
	{["score"] = 550, ["color"] = {0.69, 1, 0.59}},
	{["score"] = 525, ["color"] = {0.71, 1, 0.62}},
	{["score"] = 500, ["color"] = {0.74, 1, 0.65}},
	{["score"] = 475, ["color"] = {0.76, 1, 0.68}},
	{["score"] = 450, ["color"] = {0.79, 1, 0.71}},
	{["score"] = 425, ["color"] = {0.81, 1, 0.74}},
	{["score"] = 400, ["color"] = {0.83, 1, 0.77}},
	{["score"] = 375, ["color"] = {0.85, 1, 0.8}},
	{["score"] = 350, ["color"] = {0.88, 1, 0.83}},
	{["score"] = 325, ["color"] = {0.9, 1, 0.85}},
	{["score"] = 300, ["color"] = {0.92, 1, 0.88}},
	{["score"] = 275, ["color"] = {0.94, 1, 0.91}},
	{["score"] = 250, ["color"] = {0.96, 1, 0.94}},
	{["score"] = 225, ["color"] = {0.98, 1, 0.97}},
	{["score"] = 200, ["color"] = {1, 1, 1}}
}
-- ITEM UTILS
----------------------------------------------------------------
function E.func_GetItemInfo(itemID)
	return C_Item.GetItemInfo(itemID)
end
----------------------------------------------------------------
function E.func_GetItemIcon(itemID)
	return C_Item.GetItemIconByID(itemID)
end
----------------------------------------------------------------
function E.func_GetItemName(itemID)
	return C_Item.GetItemNameByID(itemID)
end
----------------------------------------------------------------
function E.func_GetItemLink(itemID)
	local _, link = E.func_GetItemInfo(itemID)
	return link
end
----------------------------------------------------------------
function E.func_GetItemQuality(itemID)
	return C_Item.GetItemQualityByID(itemID)
end
----------------------------------------------------------------
function E.func_GetItemQualityColor(itemID)
	return ITEM_QUALITY_COLORS[E.func_GetItemQuality(itemID)]
end
----------------------------------------------------------------
function E.func_GetItemQualityColorRGB(itemID)
	return E.func_GetItemQualityColor(itemID).color:GetRGB()
end
----------------------------------------------------------------
function E.func_GetItemCurrentLevel(itemID)
	return C_Item.GetDetailedItemLevelInfo(itemID)
end
----------------------------------------------------------------
function E.func_GetItemMaxStackSize(itemID)
	return C_Item.GetItemMaxStackSizeByID(itemID)
end
----------------------------------------------------------------
function E.func_IsItemStackable(itemID)
	local maxStackSize = E.func_GetItemMaxStackSize(itemID)
	return maxStackSize and maxStackSize > 1
end
----------------------------------------------------------------
function E.func_GetItemInventoryType(itemID)
	return C_Item.GetItemInventoryTypeByID(itemID)
end
----------------------------------------------------------------
function E.func_GetItemInventoryTypeName(itemID)
	local _,_,_, itemEquipLoc = C_Item.GetItemInfoInstant(itemID)
	return itemEquipLoc
end
----------------------------------------------------------------
function E.func_IsItemDataCached(itemID)
	return C_Item.IsItemDataCachedByID(itemID)
end
----------------------------------------------------------------
function E.func_itemName_NOCOLOR(itemID)
	local vivod = C_Item.GetItemNameByID(itemID) or SEARCH_LOADING_TEXT
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..Gray_Color.." id:"..itemID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_itemName(itemID)
	local itemName = C_Item.GetItemNameByID(itemID) or Red_Color..SEARCH_LOADING_TEXT.."|r" -- RETRIEVING_ITEM_INFO
	local itemQuality = select(3, C_Item.GetItemInfo(itemID))
	local vivod
	if itemQuality then
		vivod = ITEM_QUALITY_COLORS[itemQuality].color:WrapTextInColorCode(itemName)
	else
		vivod = itemName
	end
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..Gray_Color.." id:"..itemID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_itemTexture(itemID)
	local icon = C_Item.GetItemIconByID(itemID) or 134400
	return E.func_texturefromIcon(icon)
end
----------------------------------------------------------------
function E.func_GetItemCooldown(itemID)
	local start, duration = C_Item.GetItemCooldown(itemID)
	-- local start = C_Item.GetItemCooldown(itemID).startTimeSeconds or 0
	-- local duration = C_Item.GetItemCooldown(itemID).durationSeconds or 0
	-- local start = C_Container.GetItemCooldown(itemID).startTime or 0
	-- local duration = C_Container.GetItemCooldown(itemID).duration or 0
	local vivod = 0
	if start > 0 and duration > 0 then
		vivod = (start + duration - GetTime())
	end
	return E.func_CompactNumberSimple(vivod)
end
----------------------------------------------------------------
-- SPELLS
----------------------------------------------------------------
function E.func_GetSpellSubtext(spellID)
	local vivod = C_Spell.GetSpellSubtext(spellID)
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..Gray_Color.." id:"..spellID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_GetSpellNameFull(spellID)
	local name = E.GetSpellName(spellID)
	local subText = E.GetSpellSubtext(spellID)
	local vivod = subText and #subText > 0 and name.."("..subText..")" or name
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..Gray_Color.." id:"..spellID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_GetSpellDescription(spellID)
	return GetSpellDescription(spellID)
end
----------------------------------------------------------------
function E.func_GetSpellName(spellID)
	local vivod = C_Spell.GetSpellName(spellID)
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..Gray_Color.." id:"..spellID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_GetSpellIcon(spellID)
	local iconID = C_Spell.GetSpellTexture(spellID)
	return iconID
end
----------------------------------------------------------------
function E.func_GetSpellCooldown(spellID)
	local start = C_Spell.GetSpellCooldown(spellID).startTime
	local duration = C_Spell.GetSpellCooldown(spellID).duration
	local vivod = 0
	if start > 0 and duration > 0 then
		vivod = (start + duration - GetTime())
	end
	return E.func_CompactNumberSimple(vivod)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.COMPLETE()
	-- return Purple_Color..">>".."Complete".."<<".."|r"
	-- return Purple_Color..">"..COMPLETE.."<".."|r"
	return Purple_Color..">"..QUEST_WATCH_QUEST_READY.."<".."|r"
end
----------------------------------------------------------------
function E.func_hex2rgb(hex)
	hex = hex:gsub("|cff", "")
	return tonumber("0x"..hex:sub(1, 2)), tonumber("0x"..hex:sub(3, 4)), tonumber("0x"..hex:sub(5, 6))
end
----------------------------------------------------------------
function E.func_hex2rgbNUMBER(hex)
	hex = hex:gsub("|cff", "")
	return tonumber("0x"..hex:sub(1, 2))/255, tonumber("0x"..hex:sub(3, 4))/255, tonumber("0x"..hex:sub(5, 6))/255, 1
end
----------------------------------------------------------------
function E.func_rgb2hex(r, g, b, a)
	local r = r or 1
	local g = g or 1
	local b = b or 1
	local a = a or 1
	if not a then
		a = 1
	end
	return "|c"..string.format("%02x", math.floor(a*255))..utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
end
----------------------------------------------------------------
function E.func_rgb2hexDEV(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	return "c"..string.format("%02x", math.floor(a*255))..utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
end
----------------------------------------------------------------
function E.func_percent(percent, maxvalue)
	return (maxvalue*percent)/100
end
----------------------------------------------------------------
function E.func_Gradient(text, firstColor, secondColor)
	if not firstColor then firstColor = "|cffD177FF" end
	if not secondColor then secondColor = "|cff63A4E0" end
	local vivod = ""
	local str = ""
	local total = utf8len(text)-1
	local r1, g1, b1 = E.func_hex2rgb(firstColor)
	local r2, g2, b2 = E.func_hex2rgb(secondColor)
	local rdelta, gdelta, bdelta = (r2-r1)/total, (g2-g1)/total, (b2-b1)/total
	local r3 = r1
	local g3 = g1
	local b3 = b1
	for i = 1, total do
		str = str..("|cff%02x%02x%02x%s|r"):format(math.floor(r3+.5), math.floor(g3+.5), math.floor(b3+.5), utf8sub(text, i, i))
		r3 = r3 + rdelta
		g3 = g3 + gdelta
		b3 = b3 + bdelta
	end
	vivod = str..secondColor..utf8sub(text, utf8len(text)).."|r"
	return vivod
end
----------------------------------------------------------------
function E.func_GenerateUniqueID()
	local s = {}
	for i=1, 11 do
		tinsert(s, OctoTable_bytetoB64[math.random(0, 63)])
	end
	return table.concat(s)
end
----------------------------------------------------------------
function E.func_GenerateUniqueColor()
	local s = {}
	for i=1, 6 do
		tinsert(s, OctoTable_bytetoB64Color[math.random(0, 15)])
	end
	return table.concat(s)
end
----------------------------------------------------------------
function E.func_PlaySoundFile_whisper(fileName)
	if fileName then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Memes\\"..fileName..".ogg", "Master")
	end
end
----------------------------------------------------------------
function E.func_CompactNumberFormat(number)
	if not number then
		number = 0
	end
	if number == 0 then
		return 0
	elseif number < 1000 then
		return (math.floor((number+0.5)-0.5)/10)*10
	elseif number < 1000000 then
		return (math.floor(number/100)/10).."k"
	else
		return (math.floor(number/100000)/10).."m"
	end
end
----------------------------------------------------------------
function E.func_CompactNumberSimple(number)
	if not number then
		number = 0
	end
	if number == 0 then
		return 0
	else
		return math.floor(number+.5)
	end
end
----------------------------------------------------------------
function E.func_texturefromIcon(icon, iconSize, isShown)
	if isShown == nil then isShown = true end
	if iconSize == nil then iconSize = 14 end
	if icon == nil then icon = 134400 end
	local vivod
	if isShown == true then
		vivod = "|T".. icon ..":"..iconSize..":"..iconSize..":::64:64:4:60:4:60|t"
	else
		vivod = ""
	end
	return vivod.." "
end
----------------------------------------------------------------
function E.func_questName(questID, useLargeIcon)
	local vivod = ""
	local useLargeIcon = useLargeIcon or true
	local isAccountQuest = C_QuestLog.IsAccountQuest(questID)
	local isCompletedOnAccount = C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID)
	local title = C_QuestLog.GetTitleForQuestID(questID)
	if title then
		vivod = vivod..QuestUtils_DecorateQuestText(questID, title, useLargeIcon)
	else
		vivod = vivod..Red_Color.."hidden?".."|r"
	end
	if isAccountQuest then
		vivod = E.Icon_AccountWide.."|cffFFFF00"..vivod.."|r"
	end
	if isCompletedOnAccount then
		vivod = E.Icon_AccountWide.."|cff9fc5e8"..vivod.."|r"
	end
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..Gray_Color.." id:"..questID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_reputationName(reputationID)
	local vivod = ""
	if reputationID and type(reputationID) == "number" then
		local isAccountWide = C_Reputation.IsAccountWideReputation(reputationID) or false
		if isAccountWide == true then
			vivod = E.Icon_AccountWide..vivod
		end
		local repInfo = C_Reputation.GetFactionDataByID(reputationID)
		local name
		if repInfo then
			name = repInfo.name
		else
			local reputationInfo = C_GossipInfo.GetFriendshipReputation(reputationID)
			-- name = reputationInfo.name or E.Blue_Color..SEARCH_LOADING_TEXT.."|r"
			if reputationInfo.name then
				name = reputationInfo.name
			elseif E.OctoTable_FACTIONTABLE[reputationID] then
				name = E.OctoTable_FACTIONTABLE[reputationID].name
			else
				name = reputationID.. " (UNKNOWN)"
			end
		end
		vivod = vivod..name
		if E.DebugIDs == true and vivod ~= nil then
			vivod = vivod..E.Gray_Color.." id:"..reputationID.."|r"
		end
		if E.OctoTable_FACTIONTABLE[reputationID] then
			return E.OctoTable_FACTIONTABLE[reputationID].faction..vivod
		else
			print (reputationID.. " <- MISSING REPUTATION ID -> "..name)
			return name
		end
	else
		return "reputationID"
	end
end
----------------------------------------------------------------
function E.func_reputationNameSIMPLE(reputationID)
	local vivod = ""
	if reputationID and type(reputationID) == "number" then
		-- local isAccountWide = C_Reputation.IsAccountWideReputation(reputationID) or false
		-- if isAccountWide == true then
		-- vivod = E.Icon_AccountWide..vivod
		-- end
		local repInfo = C_Reputation.GetFactionDataByID(reputationID)
		local name
		if repInfo then
			name = repInfo.name
		else
			local reputationInfo = C_GossipInfo.GetFriendshipReputation(reputationID or 0)
			name = reputationInfo.name or Red_Color..SEARCH_LOADING_TEXT.."|r"
		end
		vivod = vivod..name
		-- if E.DebugIDs == true and vivod ~= nil then
		-- vivod = vivod..Gray_Color.." id:"..reputationID.."|r"
		-- end
		vivod = vivod
	else
		vivod = reputationID
	end
	return vivod
end
----------------------------------------------------------------
function E.func_currencyName(currencyID)
	if currencyID then
		local vivod
		local AWide = ""
		local ATrans = ""
		local isAccountTransferableCurrency = C_CurrencyInfo.IsAccountTransferableCurrency(currencyID) or false
		if isAccountTransferableCurrency == true then
			AWide = E.Icon_AccountTransferable
		end
		local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(currencyID) or false
		if isAccountWideCurrency == true then
			AWide = E.Icon_AccountWide
		end
		local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
		if info then
			local name = info.name
			local iconFileID = info.iconFileID
			local quality = info.quality
			local r, g, b = GetItemQualityColor(quality)
			local color = CreateColor(r, g, b, 1)
			local currencyName = color:WrapTextInColorCode(name)
			vivod = ATrans..AWide..currencyName
		else
			vivod = ATrans..AWide..Red_Color..RETRIEVING_ITEM_INFO.."|r"
		end
		if E.DebugIDs == true and vivod ~= nil then
			vivod = vivod..Gray_Color.." id:"..currencyID.."|r"
		end
		return vivod
	else
		return "currencyID = NIL"
	end
end
----------------------------------------------------------------
function E.func_currencyName_NOCOLOR(currencyID)
	local vivod
	local AWide = ""
	local ATrans = ""
	local isAccountTransferableCurrency = C_CurrencyInfo.IsAccountTransferableCurrency(currencyID) or false
	if isAccountTransferableCurrency == true then
		AWide = E.Icon_AccountTransferable
	end
	local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(currencyID) or false
	if isAccountWideCurrency == true then
		AWide = E.Icon_AccountWide
	end
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	if info then
		local name = info.name
		-- local iconFileID = info.iconFileID
		-- local quality = info.quality
		-- local r, g, b = GetItemQualityColor(quality)
		-- local color = CreateColor(r, g, b, 1)
		-- local currencyName = color:WrapTextInColorCode(name)
		vivod = ATrans..AWide..name
	else
		vivod = ATrans..AWide..Red_Color..RETRIEVING_ITEM_INFO.."|r"
	end
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..Gray_Color.." id:"..currencyID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_currencyIcon(currencyID)
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	if info then
		iconFileID = info.iconFileID
	else
		iconFileID = 134400
	end
	return E.func_texturefromIcon(iconFileID)
end
----------------------------------------------------------------
function E.func_currencyquantity(currencyID)
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	if info then
		quantity = info.quantity or 0
	end
	return quantity
end
----------------------------------------------------------------
----------------------------------------------------------------
-- function E.func_SecondsToClock(time)
-- 	-- local years, days, hours, mins, secs = "", "", "", "", ""
-- 	local years, days, hours, mins, secs = 0, 0, 0, 0, 0
-- 	local time = tonumber(time)
-- 	if time <= 0 or time == nil then --
-- 		return "0:00"
-- 	elseif time >= (86400*365) then -- год
-- 		years = floor(time / (86400*365))
-- 		days = floor(mod(time, 31536000) / 86400)
-- 		hours = floor(mod(time, 86400) / 3600)
-- 		mins = floor(mod(time, 3600) / 60)
-- 		return years..E.time_YEAR..days..E.time_DAY..hours..E.time_HOUR..mins..E.time_MINUTE
-- 	elseif time >= 86400 then -- 24ч
-- 		days = floor(time / 86400)
-- 		hours = floor(mod(time, 86400) / 3600)
-- 		mins = floor(mod(time, 3600) / 60)
-- 		return days..E.time_DAY..hours..E.time_HOUR..mins..E.time_MINUTE
-- 	elseif time >= 3600 then -- 1 час
-- 		hours = string.format("%01.f", math.floor(time/3600))
-- 		mins = string.format("%02.f", math.floor(time/60 - (hours*60)))
-- 		return hours..E.time_HOUR..mins..E.time_MINUTE
-- 	elseif time >= 600 then -- 10 минут
-- 		hours = string.format("%01.f", math.floor(time/3600))
-- 		mins = string.format("%02.f", math.floor(time/60 - (hours*60)))
-- 		return mins..E.time_MINUTE
-- 	elseif time >= 60 then -- минута
-- 		hours = string.format("%01.f", math.floor(time/3600))
-- 		mins = string.format("%01.f", math.floor(time/60 - (hours*60)))
-- 		return mins..E.time_MINUTE
-- 	else
-- 		return time..E.time_SECOND
-- 	end
-- end
function E.func_SecondsToClock(time)
	time = tonumber(time) or 0
	if time <= 0 then
		return "0"..(E.time_MINUTE)
	end

	local years = floor(time / 31536000)  -- 86400*365
	local days = floor(time % 31536000 / 86400)
	local hours = floor(time % 86400 / 3600)
	local mins = floor(time % 3600 / 60)
	local secs = floor(time % 60)

	-- Формируем строку по частям
	local parts = {}

	if years > 0 then
		table.insert(parts, years..(E.time_YEAR or "y"))
		table.insert(parts, days..(E.time_DAY or "d"))
		table.insert(parts, hours..(E.time_HOUR or "h"))
		table.insert(parts, mins..(E.time_MINUTE or "m"))
	elseif days > 0 then
		table.insert(parts, days..(E.time_DAY or "d"))
		table.insert(parts, hours..(E.time_HOUR or "h"))
		table.insert(parts, mins..(E.time_MINUTE or "m"))
	elseif hours > 0 then
		table.insert(parts, hours..(E.time_HOUR or "h"))
		table.insert(parts, string.format("%02d", mins)..(E.time_MINUTE or "m"))
	elseif time >= 60 then
		table.insert(parts, mins..(E.time_MINUTE or "m"))
		if time < 600 then  -- Только для 1-9 минут добавляем секунды
			table.insert(parts, secs..(E.time_SECOND or "s"))
		end
	else
		table.insert(parts, secs..(E.time_SECOND or "s"))
	end

	return table.concat(parts)
end













function E.ChatFrame_TimeBreakDown(time)
	local days = floor(time / (60 * 60 * 24));
	local hours = floor((time - (days * (60 * 60 * 24))) / (60 * 60));
	local minutes = floor((time - (days * (60 * 60 * 24)) - (hours * (60 * 60))) / 60);
	local seconds = mod(time, 60);
	return days, hours, minutes, seconds;
end
----------------------------------------------------------------
function E.func_tmstpDayReset(time)
	local time = time or 1
	return (math.ceil((tonumber(GetServerTime()) - E.thursdayReset)/(E.daytime*time))*E.daytime*time)+E.thursdayReset
end
----------------------------------------------------------------
-- function E.func_All_objectives(questID)
-- local str = ""
-- local objectives = C_QuestLog.GetQuestObjectives(questID)
-- local text, objectiveType, finished, fulfilled, required = GetQuestObjectiveInfo(questID, 1, false)
-- if objectives == nil then
-- return ""
-- end
-- if objectiveType == "progressbar" then
-- return "|cffFF0000"..GetQuestProgressBarPercent(questID).."%|r"
-- end
-- if objectives then
-- if objectives[5] then
-- str = str..(objectives[5].finished and Gray_Color or White_Color) ..objectives[5].text.."|r\n"
-- str = str..(objectives[4].finished and Gray_Color or White_Color) ..objectives[4].text.."|r\n"
-- str = str..(objectives[3].finished and Gray_Color or White_Color) ..objectives[3].text.."|r\n"
-- str = str..(objectives[2].finished and Gray_Color or White_Color) ..objectives[2].text.."|r\n"
-- str = str..(objectives[1].finished and Gray_Color or White_Color) ..objectives[1].text.."|r\n"
-- elseif objectives[4] then
-- str = str..(objectives[4].finished and Gray_Color or White_Color) ..objectives[4].text.."|r\n"
-- str = str..(objectives[3].finished and Gray_Color or White_Color) ..objectives[3].text.."|r\n"
-- str = str..(objectives[2].finished and Gray_Color or White_Color) ..objectives[2].text.."|r\n"
-- str = str..(objectives[1].finished and Gray_Color or White_Color) ..objectives[1].text.."|r\n"
-- elseif objectives[3] then
-- str = str..(objectives[3].finished and Gray_Color or White_Color) ..objectives[3].text.."|r\n"
-- str = str..(objectives[2].finished and Gray_Color or White_Color) ..objectives[2].text.."|r\n"
-- str = str..(objectives[1].finished and Gray_Color or White_Color) ..objectives[1].text.."|r\n"
-- elseif objectives[2] then
-- str = str..(objectives[2].finished and Gray_Color or White_Color) ..objectives[2].text.."|r\n"
-- str = str..(objectives[1].finished and Gray_Color or White_Color) ..objectives[1].text.."|r\n"
-- elseif objectives[1] then
-- str = str..(objectives[1].finished and Gray_Color or White_Color) ..objectives[1].text.."|r\n"
-- end
-- end
-- return str
-- end
----------------------------------------------------------------
function E.func_CheckCompletedByQuestID(questID)
	local vivod
	local TEST = ""
	if C_QuestLog.IsFailed(questID) then return "|cffFF0000>"..FAILED.."<|r" end
	if C_QuestLog.IsQuestFlaggedCompleted(questID) == true then
		vivod = E.DONE
	elseif C_QuestLog.IsComplete(questID) == true then
		vivod = E.COMPLETE()
	elseif C_QuestLog.IsQuestFlaggedCompleted(questID) == false and C_QuestLog.IsOnQuest(questID) == false then
		vivod = E.NONE
	elseif C_QuestLog.IsOnQuest(questID) == true --[[and C_QuestLog.IsComplete(questID) == false ]]then
		local objectives = C_QuestLog.GetQuestObjectives(questID)
		if objectives == nil then
			return ""
		end
		for i = 1, #objectives do
			if objectives[i] then
				local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, i, false)
				if objectiveType == "progressbar" then
					TEST = Red_Color..GetQuestProgressBarPercent(questID).."%|r"
				else
					if finished then
						TEST = Yellow_Color..(objectives[i].numFulfilled).."/"..(objectives[i].numRequired).."|r"
					else
						TEST = Red_Color..(objectives[i].numFulfilled).."/"..(objectives[i].numRequired).."|r"
					end
				end
			end
			vivod = vivod and vivod.."»"..TEST or TEST
		end
	end
	return vivod
end
----------------------------------------------------------------
function E.func_OnlyFirstWord(text)
	local text = tostring(text)
	local a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z = strsplit(" ", text)
	return a or b or c or d or e or f or g or h or i or j or k or l or m or n or o or p or q or r or s or t or u or v or w or x or y or z
end
----------------------------------------------------------------
function E.func_OnlyLastWord(text)
	local text = tostring(text)
	local a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z = strsplit(" ", text)
	return z or y or x or w or v or u or t or s or r or q or p or i or n or m or l or k or j or i or h or g or f or e or d or c or b or a
end
----------------------------------------------------------------
function E.func_InList(k, t, p)
	for _, v in next, (t) do
		if (p and v[p]==k) or (not p and v==k) then
			return true
		end
	end
end
----------------------------------------------------------------
function E.func_achievementID(achievementID)
	return Yellow_Color.." (id: "..achievementID..")".."|r"
end
----------------------------------------------------------------
function E.func_achievementComplete(achievementID)
	if not achievementID then
		return false
	end
	local completed = select(4, GetAchievementInfo(achievementID))
	return completed
end
----------------------------------------------------------------
function E.func_achievementName(achievementID)
	local vivod = select(2, GetAchievementInfo(achievementID))
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..Gray_Color.." id:"..achievementID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_achievementIcon(achievementID)
	local Icon = select(10, GetAchievementInfo(achievementID))
	return Icon
end
----------------------------------------------------------------
function E.func_achievementvivod(achievementID)
	local vivod = ""
	local completed = select(4, GetAchievementInfo(achievementID))
	local wasEarnedByMe = select(13, GetAchievementInfo(achievementID))
	local earnedBy = select(14, GetAchievementInfo(achievementID))
	if completed == true then
		vivod = E.DONE
	else
		local numCriteria = GetAchievementNumCriteria(achievementID)
		if numCriteria ~= 0 then
			local count = 0
			for i = 1, numCriteria do
				local _, _, completedCrit, quantity, reqQuantity = GetAchievementCriteriaInfo(achievementID, i, false)
				if numCriteria == 1 then
					if quantity == 0 then
						vivod = Red_Color..quantity.." / "..reqQuantity.."|r"
					else
						vivod = quantity.." / "..reqQuantity
					end
				else
					if completedCrit == true then
						count = count + 1
					end
					if count == 0 then
						vivod = Red_Color..count.." / "..numCriteria.."|r"
					else
						vivod = count.." / "..numCriteria
					end
				end
			end
		else
			vivod = Red_Color.."0 / 1".."|r"
		end
	end
	return vivod
end
----------------------------------------------------------------
function E.func_achievementcriteriaString(achievementID, i)
	i = i or 1
	local vivod = ""
	local completed = select(4, GetAchievementInfo(achievementID))
	local description = select(8, GetAchievementInfo(achievementID))
	local numCriteria = GetAchievementNumCriteria(achievementID)
	local criteriaString, _, completedCrit, quantity = GetAchievementCriteriaInfo(achievementID, i, false)
	local color = White_Color
	if completedCrit == true then
		color = Green_Color
	elseif completedCrit == false and quantity == 0 then
		color = Red_Color
	end
	if criteriaString and criteriaString ~= "" then
		vivod = vivod..color..criteriaString.."|r"
	else
		vivod = vivod..color..description.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_achievementquantity(achievementID, i)
	i = i or 1
	local vivod = ""
	local completed = select(4, GetAchievementInfo(achievementID))
	local description = select(8, GetAchievementInfo(achievementID))
	local numCriteria = GetAchievementNumCriteria(achievementID)
	local _, _, completedCrit, quantity, reqQuantity = GetAchievementCriteriaInfo(achievementID, i, false)
	local color = White_Color
	if completedCrit == true then
		color = Green_Color
	elseif completedCrit == false and quantity == 0 then
		color = Red_Color
	end
	if quantity then
		vivod = vivod..color..quantity.." / "..reqQuantity.."|r"
	else
		vivod = vivod..color.."0/1PIZZA".."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_CurServerShort(text)
	local text = (text):gsub("-", " "):gsub("'", " ")
	local a, b = strsplit(" ", text)
	if b then
		text = utf8sub(a, 1, 1):upper()..utf8sub(b, 1, 1):upper()
	else
		text = utf8sub(a, 1, 1):upper()..utf8sub(a, 2, 3):lower()
	end
	return text
end
----------------------------------------------------------------
function E.func_GetMapName(mapID)
	if not mapID then return end
	local info = C_Map.GetMapInfo(mapID)
	if info then
		local name = info.name
		return tostring(name)
	end
end
----------------------------------------------------------------
function E.func_npcName(npcName)
	local inspectScantipFUNC = nil
	if not inspectScantipFUNC then
		inspectScantipFUNC = CreateFrame("GameTooltip", "OctoToDoScanningTooltipFUNC", nil, "GameTooltipTemplate")
		inspectScantipFUNC:SetOwner(UIParent, "ANCHOR_NONE")
	end
	local vivod = "|cffFF0000error|r"
	if not npcName then return E.NONE end
	if npcName then
		inspectScantipFUNC:SetHyperlink("unit:Creature-0-0-0-0-"..npcName)
		if inspectScantipFUNC:NumLines() > 0 then
			vivod = _G["OctoToDoScanningTooltipFUNCTextLeft1"]:GetText()
			return vivod
		end
		inspectScantipFUNC:ClearLines()
	end
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..Gray_Color.." id:"..npcName.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_RIOColor(RIOscore)
	local hexColor = Gray_Color
	if not RIOscore or RIOscore == 0 then
		return hexColor
	end
	for _, v in next, (OctoTable_RIO_COLORS) do
		if RIOscore <= v.score then
			hexColor = E.func_rgb2hex(v.color[1],v.color[2],v.color[3])
		end
	end
	return hexColor
end
----------------------------------------------------------------
function E.func_encryption(text)
	local text = utf8reverse(tostring(text))
	local text = strsplit("-", text)
	local vivod = ""
	vivod = utf8lower(text:gsub("0", ""):gsub("1", ""):gsub("2", ""):gsub("3", ""):gsub("4", ""):gsub("5", ""):gsub("6", ""):gsub("7", ""):gsub("8", ""):gsub("9", ""))
	return vivod
end
----------------------------------------------------------------
function E.func_GetClassColor(className) -- C_ClassColor.GetClassColor(classFilename)
	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[className]
	if color then
		return color.colorStr:gsub("^ff", "")
	end
	return "ffffff"
end
----------------------------------------------------------------
function E.func_Reverse_order(a, b)
	return b < a
end
----------------------------------------------------------------
function E.func_CheckReputationByRepID(reputationID)
	local vivod = ""
	if reputationID then
		local color = White_Color
		local r = "|r"
		local standingTEXT = ""
		local repInfo = C_Reputation.GetFactionDataByID(reputationID)
		local name
		local barMin
		local barMax
		local barValue
		local standingID
		if repInfo then
			name = repInfo.name
			barMin = repInfo.currentReactionThreshold
			barMax = repInfo.nextReactionThreshold
			barValue = repInfo.currentStanding
			standingID = repInfo.reaction
			if standingID == 1 then
				color = Red_Color
				standingTEXT = " ("..FACTION_STANDING_LABEL1..")"
			elseif standingID == 2 then
				color = Red_Color
				standingTEXT = " ("..FACTION_STANDING_LABEL2..")"
			elseif standingID == 3 then
				color = Orange_Color
				standingTEXT = " ("..FACTION_STANDING_LABEL3..")"
			elseif standingID == 4 then
				color = Yellow_Color
				standingTEXT = " ("..FACTION_STANDING_LABEL4..")"
			elseif standingID == 5 then
				color = Yellow_Color
				standingTEXT = " ("..FACTION_STANDING_LABEL5..")"
			elseif standingID == 6 then
				color = Green_Color
				standingTEXT = " ("..FACTION_STANDING_LABEL6..")"
			elseif standingID == 7 then
				color = Green_Color
				standingTEXT = " ("..FACTION_STANDING_LABEL7..")"
			elseif standingID == 8 then
				color = Green_Color
				standingTEXT = " ("..FACTION_STANDING_LABEL8..")"
			elseif standingID == 9 then
				color = Green_Color
				standingTEXT = " ("..FACTION_STANDING_LABEL9..")"
			end
		end
		local reputationInfo = C_GossipInfo.GetFriendshipReputation(reputationID or 0)
		if C_Reputation.IsFactionParagon(reputationID) then
			local currentValue = C_Reputation.GetFactionParagonInfo(reputationID) or 0
			local threshold = 1
			local _, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(reputationID)
			if threshold then
				local value = currentValue % threshold
				vivod = Blue_Color..(value).."/"..(threshold)..r
				if hasRewardPending then
					vivod = E.func_CheckCompletedByQuestID(rewardQuestID)
				end
			end
		elseif C_Reputation.IsMajorFaction(reputationID) then
			local data = C_MajorFactions.GetMajorFactionData(reputationID) or 0
			if data ~= 0 then
				local currentValue = data.renownReputationEarned%data.renownLevelThreshold
				local totalValue = data.renownLevelThreshold
				local standing = data.renownLevel
				vivod = (currentValue).."/"..(totalValue)..Green_Color.."("..(standing)..")|r"
			end
		elseif (reputationInfo and reputationInfo.friendshipFactionID and reputationInfo.friendshipFactionID > 0) then
			local friendshipFactionID = reputationInfo.friendshipFactionID or 0
			local reactionThreshold = reputationInfo.reactionThreshold or 0
			local nextThreshold = reputationInfo.nextThreshold or 0
			local standing = reputationInfo.standing or 0
			local name = reputationInfo.name
			local currentValue = standing-reactionThreshold
			local totalValue = nextThreshold-reactionThreshold
			local rankInfo = C_GossipInfo.GetFriendshipReputationRanks(friendshipFactionID)
			local currentLevel, maxLevel
			if rankInfo then
				currentLevel = rankInfo.currentLevel or 0
				maxLevel = rankInfo.maxLevel or 0
			end
			standingTEXT = " ("..currentLevel.."/"..maxLevel..")"
			vivod = color..(currentValue).."/"..(totalValue)..standingTEXT..r
			if currentLevel == maxLevel then vivod = Green_Color.."Done|r" end
		else
			if barValue then
				local currentValue = barValue-barMin
				local totalValue = barMax-barMin
				vivod = color..(currentValue).."/"..(totalValue)..standingTEXT..r
				if currentValue == totalValue or nextThreshold == 0 then vivod = Green_Color.."Done|r" end
			end
		end
	else
		vivod = "ERROR NO ID"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_CurrentNumQuests()
	local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
	local numQuests = 0
	for i = 1, numShownEntries do
		local info = C_QuestLog.GetInfo(i) -- questLogIndex
		if info then
			if info.questID ~= 0 then
				if (not info.isHeader and not info.isHidden) then
					numQuests = numQuests + 1
				else
					numQuests = numQuests
				end
			end
		end
	end
	return numQuests
end
----------------------------------------------------------------
function E.ReloadUI()
	return ReloadUI
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.GetAddOnMetadata(name, variable)
	local GetAddOnMetadata = C_AddOns.GetAddOnMetadata
	return GetAddOnMetadata(name, variable)
end
----------------------------------------------------------------
function E.GetAddOnInfo(name)
	local GetAddOnInfo = C_AddOns.GetAddOnInfo
	return GetAddOnInfo(name)
end
----------------------------------------------------------------
function E.EnableAddOn(name, character)
	local EnableAddOn = C_AddOns.EnableAddOn
	return EnableAddOn(name, character)
end
----------------------------------------------------------------
function E.DisableAddOn(name, character)
	local DisableAddOn = C_AddOns.DisableAddOn
	return DisableAddOn(name, character)
end
----------------------------------------------------------------
function E.LoadAddOn(name)
	local LoadAddOn = C_AddOns.LoadAddOn
	return LoadAddOn(name)
end
----------------------------------------------------------------
function E.IsAddOnLoaded(name)
	local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded
	return IsAddOnLoaded(name)
end
----------------------------------------------------------------
function E.func_LoadAddOn(AddonName)
	local LoadAddOn = C_AddOns.LoadAddOn
	local loaded, reason = LoadAddOn(AddonName)
	if not loaded and reason == "DISABLED" then
		E.EnableAddOn(AddonName)
		E.LoadAddOn(AddonName)
	end
end
----------------------------------------------------------------
function E.func_AddonTitle(AddonName)
	local AddonTitle = C_AddOns.GetAddOnMetadata(AddonName, "Title")
	return AddonTitle
end
----------------------------------------------------------------
function E.func_AddonNotes(AddonName)
	local AddonNotes = C_AddOns.GetAddOnMetadata(AddonName, "Notes")
	return AddonNotes
end
----------------------------------------------------------------
function E.func_AddonAuthor(AddonName)
	local AddonAuthor = C_AddOns.GetAddOnMetadata(AddonName, "Author")
	return AddonAuthor
end
----------------------------------------------------------------
function E.func_AddonVersion(AddonName)
	local AddonVersion = C_AddOns.GetAddOnMetadata(AddonName, "Version")
	return AddonVersion
end
----------------------------------------------------------------
function E.func_AddonIconTexture(AddonName)
	local AddonIconTexture = C_AddOns.GetAddOnMetadata(AddonName, "IconTexture")
	return AddonIconTexture
end
----------------------------------------------------------------
----------------------------------------------------------------
-- C_AddOns.DoesAddOnExist(name)
-- C_AddOns.GetAddOnDependencies(name)
-- C_AddOns.GetAddOnOptionalDependencies(name)
-- C_AddOns.GetNumAddOns()
-- C_AddOns.GetScriptsDisallowedForBeta()
-- C_AddOns.IsAddOnLoaded(name)
-- C_AddOns.IsAddOnLoadOnDemand(name)
-- C_AddOns.IsAddonVersionCheckEnabled()
-- C_AddOns.ResetAddOns()
-- C_AddOns.ResetDisabledAddOns()
-- C_AddOns.SaveAddOns()
-- C_AddOns.SetAddonVersionCheck(enabled)
-- C_AddOns.DisableAllAddOns([character])
-- C_AddOns.EnableAllAddOns([character])
-- C_AddOns.GetAddOnEnableState(name [, character])
-- C_AddOns.IsAddOnLoadable(name [, character [, demandLoaded]])
----------------------------------------------------------------
function E.IsInArray(arr, subj)
	for i = 1, #arr do
		if arr[i] == subj then
			return i
		end
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_EmptyZero(value)
	if tonumber(value) == 0 then
		return "" --Red_Color.."NEEDDELETE|r"
	end
	return value
end
----------------------------------------------------------------
-- https://warcraft.wiki.gg/wiki/API_GetAccountExpansionLevel
function E.func_CurrentExpansion()
	if LE_EXPANSION_LEVEL_CURRENT ~= nil then
		return LE_EXPANSION_LEVEL_CURRENT+1
	else
		return 1
	end
end
----------------------------------------------------------------
function E.func_EventName(eventID)
	local vivod
	local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime()
	local monthDay = currentCalendarTime.monthDay -- The current day of the month [1-31]
	local month = 0 -- currentCalendarTime.month -- The current month [1-12]
	local numEvents = C_Calendar.GetNumDayEvents(month, monthDay)
	for i = 1, numEvents do
		local eID = C_Calendar.GetDayEvent(month, monthDay, i).eventID
		if eID == eventID then
			vivod = C_Calendar.GetDayEvent(month, monthDay, i).title
		end
	end
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..Gray_Color.." id:"..eventID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_ProfessionName(skillLine)
	local vivod = ""
	local name = C_TradeSkillUI.GetTradeSkillDisplayName(skillLine)
	vivod = name
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..Gray_Color.." id:"..skillLine.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_ProfessionIcon(skillLine)
	local vivod = ""
	local icon = C_TradeSkillUI.GetTradeSkillTexture(skillLine)
	vivod = E.func_texturefromIcon(icon)
	return vivod
end
----------------------------------------------------------------
function E.func_ProfessionSkillLevel(skillLine)
	local vivod = ""
	local skillLevel = select(3, GetProfessionInfo(skillLine))
	vivod = skillLevel
	return vivod
end
----------------------------------------------------------------
function E.func_ProfessionMaxSkillLevel(skillLine)
	local vivod = ""
	local maxSkillLevel = select(4, GetProfessionInfo(skillLine))
	vivod = maxSkillLevel
	return vivod
end
----------------------------------------------------------------
function E.START()
	local timer = debugprofilestart()
	return timer
end
----------------------------------------------------------------
function E.STOP()
	local timer = E.func_CompactNumberSimple(debugprofilestop())
	local vivod = E.func_Gradient("debug timer: ", "|cffD177FF", "|cff63A4E0")
	vivod = vivod..timer
	return DEFAULT_CHAT_FRAME:AddMessage(vivod.. "|cff63A4E0 ms.|r")
end
----------------------------------------------------------------
function E.func_dungeonName(dungeonID)
	if dungeonID then
		local vivod = C_ChallengeMode.GetMapUIInfo(dungeonID)
		if E.DebugIDs == true and vivod ~= nil then
			vivod = vivod..Gray_Color.." id:"..dungeonID.."|r"
		end
		return vivod
	end
end
----------------------------------------------------------------
function E.func_dungeontimeLimit(dungeonID)
	if dungeonID then
		local timeLimit = select(3, C_ChallengeMode.GetMapUIInfo(dungeonID))
		return timeLimit
	end
end
----------------------------------------------------------------
function E.func_dungeonIcon(dungeonID)
	if dungeonID then
		local texture = select(4, C_ChallengeMode.GetMapUIInfo(dungeonID))
		return texture
	end
end
----------------------------------------------------------------
function E.FriendsFrame_GetLastOnlineText(time, color)
	if not time then
		return FRIENDS_LIST_OFFLINE
	else
		return string.format(BNET_LAST_ONLINE_TIME, color..E.FriendsFrame_GetLastOnline(time).."|r")
	end
end
----------------------------------------------------------------
function E.FriendsFrame_GetLastOnline(timeDifference, isAbsolute)
	if (not isAbsolute) then
		timeDifference = time() - timeDifference
	end
	if (timeDifference < SECONDS_PER_MIN) then
		return LASTONLINE_SECS
	elseif (timeDifference >= SECONDS_PER_MIN and timeDifference < SECONDS_PER_HOUR) then
		return format(LASTONLINE_MINUTES, floor(timeDifference / SECONDS_PER_MIN))
	elseif (timeDifference >= SECONDS_PER_HOUR and timeDifference < SECONDS_PER_DAY) then
		return format(LASTONLINE_HOURS, floor(timeDifference / SECONDS_PER_HOUR))
	elseif (timeDifference >= SECONDS_PER_DAY and timeDifference < SECONDS_PER_MONTH) then
		return format(LASTONLINE_DAYS, floor(timeDifference / SECONDS_PER_DAY))
	elseif (timeDifference >= SECONDS_PER_MONTH and timeDifference < SECONDS_PER_YEAR) then
		return format(LASTONLINE_MONTHS, floor(timeDifference / SECONDS_PER_MONTH))
	else
		return format(LASTONLINE_YEARS, floor(timeDifference / SECONDS_PER_YEAR))
	end
end
----------------------------------------------------------------
function E.func_TableMerge(table1, table2)
	for k, v in pairs(table2) do
		if table1[k] == nil or type(table1[k]) ~= type(table2[k]) then
			table1[k] = v
			-- print("replacing key", k, v)
		elseif type(v) == "table" then
			table1[k] = MergeTable(table1[k], table2[k])
		end
	end
	return table1
end
----------------------------------------------------------------
function E.func_TableConcat(table1, table2)
	for i = 1, #table2 do
		table1[#table1+1] = table2[i]
	end
	return table1
end
----------------------------------------------------------------
function E.func_TableRemoveDuplicates(table1)
	if type(table1) ~= "table" then
		table1 = {}
	end
	local table2 = {}
	local i = 1
	while table1[i] do
		local value = table1[i]
		if table2[value] then
			tremove(table1, i)
		else
			i = i + 1
		end
		table2[value] = true
	end
end
----------------------------------------------------------------
function E.func_SetScriptAfter(frame, event, method, ids, func)
	frame:SetScript(event, function(frame)
			frame:SetScript(event, nil)
			if frame.Disable then frame:Disable() end
			if type(ids) == "function" then ids = ids() end
			self[method](self, ids):Then(function()
					func(frame)
					frame:SetScript(event, func)
					if frame.Enable then frame:Enable() end
			end)
	end)
end
----------------------------------------------------------------
function E.func_coloredText(fontstring)
	if not fontstring then
		return nil
	end
	local text = fontstring:GetText()
	if not text then
		return nil
	end
	local r, g, b, a = fontstring:GetTextColor()
	return E.func_rgb2hex(r, g, b, a)..text.."|r"
end
----------------------------------------------------------------
function E:func_SetBackdrop(frame, hexcolor, BackdropAlpha, edgeAlpha)
	local _, classFilename = UnitClass("PLAYER")
	local r, g, b = GetClassColor(classFilename)
	local bgCr, bgCg, bgCb, bgCa = E.bgCr, E.bgCg, E.bgCb, E.bgCa
	if hexcolor then
		bgCr, bgCg, bgCb = self.func_hex2rgbNUMBER(hexcolor)
	end
	if BackdropAlpha then
		bgCa = BackdropAlpha
	end
	local bbalpha = bbalpha or edgeAlpha or 1
	frame:SetBackdrop({
			bgFile = E.bgFile,
			edgeFile = E.edgeFile,
			edgeSize = 1,
			insets = {left = 0, right = 0, top = 0, bottom = 0},
	})
	frame.r = bgCr
	frame.g = bgCg
	frame.b = bgCb
	frame.a = bgCa
	frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	frame:SetBackdropBorderColor(0, 0, 0, bbalpha)
	-- frame:SetScript("OnShow", function(self)
	-- self:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	-- self:SetBackdropBorderColor(0, 0, 0, bbalpha)
	-- end)
	if not frame.isInit then
		frame.isInit = true
		frame:HookScript("OnEnter", function(self)
				self:SetBackdropColor(self.r, self.g, self.b, frame.a)
				self:SetBackdropBorderColor(r, g, b, 1)
		end)
		frame:HookScript("OnLeave", function(self)
				self:SetBackdropColor(self.r, self.g, self.b, frame.a)
				self:SetBackdropBorderColor(0, 0, 0, bbalpha)
		end)
		if frame.icon then
			frame.icon:SetAllPoints(frame)
			frame:SetScript("OnShow", function(self)
					self.icon:SetVertexColor(1, 1, 1, 1)
			end)
			frame:SetScript("OnEnter", function(self)
					self.icon:SetVertexColor(r, g, b, 1)
			end)
			frame:SetScript("OnLeave", function(self)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			frame:SetScript("OnMouseDown", function(self)
					self.icon:SetVertexColor(1, 0, 0, .5)
					self:SetBackdropBorderColor(1, 0, 0, bbalpha)
			end)
			frame:SetScript("OnMouseUp", function(self)
					self.icon:SetVertexColor(r, g, b, 1)
					self:SetBackdropBorderColor(r, g, b, bbalpha)
			end)
		end
	end
end
----------------------------------------------------------------
function E:func_CreateUtilsButton(frame)
	----------------------------------------------------------------
	-- OctoToDo_CloseButton
	----------------------------------------------------------------
	local OctoToDo_CloseButton = CreateFrame("Button", "OctoToDo_CloseButton", frame)
	OctoToDo_CloseButton:SetSize(E.curHeight, E.curHeight)
	OctoToDo_CloseButton:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, 0)
	OctoToDo_CloseButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(E.WOW_Artifact_Color..CLOSE.."|r")
			GameTooltip:Show()
	end)
	OctoToDo_CloseButton:SetScript("OnClick", function()
			frame:Hide()
	end)
	OctoToDo_CloseButton:SetScript("OnKeyDown", function(self, key)
			if key == GetBindingKey("TOGGLEGAMEMENU") then
				self:GetParent():Hide()
				self:SetPropagateKeyboardInput(false)
			else
				self:SetPropagateKeyboardInput(true)
			end
	end)
	OctoToDo_CloseButton:SetScript("OnLeave", function(self)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_CloseButton.icon = OctoToDo_CloseButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_CloseButton.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\CloseTest.tga")
	OctoToDo_CloseButton.icon:SetAllPoints()
	----------------------------------------------------------------
	-- OctoToDo_OptionsButton
	----------------------------------------------------------------
	local OctoToDo_OptionsButton = CreateFrame("Button", "OctoToDo_OptionsButton", frame)
	OctoToDo_OptionsButton:SetSize(E.curHeight, E.curHeight)
	OctoToDo_OptionsButton:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", (-E.curHeight)*1, 0)
	OctoToDo_OptionsButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:AddLine(E.WOW_Artifact_Color..OPTIONS.."|r")
			GameTooltip:Show()
	end)
	OctoToDo_OptionsButton:SetScript("OnClick", function()
			-- frame:SetShown(not frame:IsShown())
			if frame and frame:IsShown() then
				frame:Hide()
			end
			if SettingsPanel:IsVisible() and self:IsVisible() then
				HideUIPanel(SettingsPanel)
			else
				Settings.OpenToCategory(E.func_AddonTitle(GlobalAddonName), true)
			end
	end)
	OctoToDo_OptionsButton:SetScript("OnLeave", function(self)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_OptionsButton.icon = OctoToDo_OptionsButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_OptionsButton.icon:SetTexture(E.AddonTexture_1)
	OctoToDo_OptionsButton.icon:SetAllPoints()
	----------------------------------------------------------------
	-- OctoToDo_AbandonButton
	----------------------------------------------------------------
	local function AbandonQuests()
		local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
		local numQuests = E.func_CurrentNumQuests()
		for i = 1, numShownEntries do
			if numQuests ~= 0 then
				local info = C_QuestLog.GetInfo(i)
				if info then
					if (not info.isHeader and not info.isHidden) then
						DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient(L["Abandon: "])..E.func_questName(info.questID))
						C_QuestLog.SetSelectedQuest(info.questID)
						C_QuestLog.SetAbandonQuest()
						C_QuestLog.AbandonQuest()
					end
				end
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient(L["Total"]).." "..E.Green_Color..numQuests.."|r")
	end
	----------------------------------------------------------------
	StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
		text = E.Red_Color.."!!! ACHTUNG !!!|r\n"..E.WOW_Artifact_Color.."Отменить все задания?|r",
		button1 = YES,
		button2 = NO,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function()
			C_Timer.After(1, AbandonQuests)
		end,
	}
	local OctoToDo_AbandonButton = CreateFrame("Button", "OctoToDo_AbandonButton", frame)
	OctoToDo_AbandonButton:SetSize(E.curHeight, E.curHeight)
	OctoToDo_AbandonButton:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", (-E.curHeight)*2, 0)
	OctoToDo_AbandonButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:ClearLines()
			if E.func_CurrentNumQuests() > 0 then
				GameTooltip:AddLine(E.WOW_Artifact_Color..L["Abandon All Quests"].."|r".." ("..E.func_CurrentNumQuests()..")")
				GameTooltip:AddLine(" ")
			else
				GameTooltip:AddLine(L["No quests"], r, g, b)
			end
			local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
			local list = {}
			for i = 1, numShownEntries do
				if E.func_CurrentNumQuests() ~= 0 then
					local info = C_QuestLog.GetInfo(i)
					if info then
						if info.questID ~= 0 then
							if (not info.isHeader and not info.isHidden) then
								tinsert(list, info.questID)
							else
							end
						end
					end
				end
			end
			sort(list, E.func_Reverse_order)
			for k, questID in next, (list) do
				GameTooltip:AddDoubleLine(E.func_questName(questID),E.func_CheckCompletedByQuestID(questID) , 1, 1, 1, 1, 1, 1)
			end
			GameTooltip:Show()
	end)
	OctoToDo_AbandonButton:SetScript("OnLeave", function(self)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_AbandonButton:SetScript("OnClick", function()
			if E.func_CurrentNumQuests() > 0 then
				StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
			end
	end)
	OctoToDo_AbandonButton.icon = OctoToDo_AbandonButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_AbandonButton.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow72.tga")
	OctoToDo_AbandonButton.icon:SetAllPoints()
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- OctoToDo_MplusButton
	----------------------------------------------------------------
	local OctoToDo_MplusButton = CreateFrame("Button", "OctoToDo_MplusButton", frame)
	OctoToDo_MplusButton:SetSize(E.curHeight, E.curHeight)
	OctoToDo_MplusButton:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", (-E.curHeight)*3, 0)
	local list = {}
	local list2 = {}
	OctoToDo_MplusButton:SetScript("OnEnter", function(self)
			local i = 0
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(E.WOW_Artifact_Color.."OctoToDo_MplusButton".."|r")
			GameTooltip:AddDoubleLine(" ", " ")
			list = {}
			for dungeonID = 1, 1000 do
				local name = E.func_dungeonName(dungeonID)
				if name then
					tinsert(list, dungeonID)
					-- tinsert(list2, E.func_dungeonName(dungeonID))
				end
			end
			sort(list, E.func_Reverse_order)
			for count, dungeonID in next, (list) do
				local name = E.func_dungeonName(dungeonID)
				local timeLimit = E.func_dungeontimeLimit(dungeonID)
				local icon = E.func_dungeonIcon(dungeonID)
				i = i + 1
				local vivod_LEFT = E.func_texturefromIcon(icon)..name
				local vivod_RIGHT = E.Gray_Color.."icon:|r"..E.Green_Color..icon.."|r "..E.Gray_Color.."time:|r"..E.Green_Color..E.func_SecondsToClock(timeLimit).."|r"
				GameTooltip:AddDoubleLine(vivod_LEFT, vivod_RIGHT, 1, 1, 1, 1, 1, 1)
				OctoToDo_TrashCan.OctoToDo_MplusButton[dungeonID] = C_ChallengeMode.GetMapUIInfo(dungeonID)
			end
			if i == 0 then
				GameTooltip:AddLine(E.WOW_Artifact_Color.."No Data".."|r")
				OctoToDo_MplusButton:Hide()
			end
			GameTooltip:AddDoubleLine(" ", " ")
			GameTooltip:Show()
	end)
	OctoToDo_MplusButton:SetScript("OnLeave", function(self)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_MplusButton:SetScript("OnClick", function()
			frame:Hide()
			if OctoToDo_TrashCan and OctoToDo_TrashCan.OctoToDo_MplusButton then
				print ("OctoToDo_TrashCan EST")
			end
			fpde(OctoToDo_TrashCan.OctoToDo_MplusButton)
			-- fpde(list)
	end)
	OctoToDo_MplusButton.icon = OctoToDo_MplusButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_MplusButton.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow4.tga")
	OctoToDo_MplusButton.icon:SetAllPoints()
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- OctoToDo_ItemsButton
	----------------------------------------------------------------
	local OctoToDo_ItemsButton = CreateFrame("Button", "OctoToDo_ItemsButton", frame)
	OctoToDo_ItemsButton:SetSize(E.curHeight, E.curHeight)
	OctoToDo_ItemsButton:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", (-E.curHeight)*4, 0)
	OctoToDo_ItemsButton:SetScript("OnEnter", function(self)
			local i = 0
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(E.WOW_Artifact_Color.."OctoToDo_ItemsButton".."|r")
			GameTooltip:AddDoubleLine(" ", " ")
			local BattleTag = select(2, BNGetInfo()) or "Trial Account"
			local BTAG = tostringall(strsplit("#", BattleTag))
			local GameVersion = GetCurrentRegion() >= 72 and "PTR" or "Retail"
			local BattleTagLocal = BTAG.." ("..GameVersion..")"
			for _, itemID in next, (E.OctoTable_itemID_Config) do
				for curCharGUID, CharInfo in next, (OctoToDo_DB_Levels) do
					if CharInfo.BattleTagLocal == BattleTagLocal then
						if CharInfo.MASLENGO.ItemsInBag[itemID] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.func_itemTexture(itemID)..E.func_itemName(itemID), CharInfo.MASLENGO.ItemsInBag[itemID].." "..CharInfo.classColorHex..CharInfo.Name.."|r "..CharInfo.curServerShort)
						end
					end
				end
			end
			if i == 0 then
				GameTooltip:AddLine(E.WOW_Artifact_Color.."No Data".."|r")
			end
			GameTooltip:AddDoubleLine(" ", " ")
			GameTooltip:Show()
	end)
	OctoToDo_ItemsButton:SetScript("OnLeave", function(self)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_ItemsButton:SetScript("OnClick", function()
			local curGUID = UnitGUID("PLAYER")
			frame:Hide()
			for curCharGUID, CharInfo in next, (OctoToDo_DB_Levels) do
				if curCharGUID == curGUID then
					fpde(CharInfo)
				end
			end
	end)
	OctoToDo_ItemsButton.icon = OctoToDo_ItemsButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_ItemsButton.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow21.tga")
	OctoToDo_ItemsButton.icon:SetAllPoints()
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- OctoToDo_EventsButton
	----------------------------------------------------------------
	-- local OctoToDo_EventsButton = CreateFrame("Button", "OctoToDo_EventsButton", frame, "BackDropTemplate")
	local OctoToDo_EventsButton = CreateFrame("Button", "OctoToDo_EventsButton", frame)
	OctoToDo_EventsButton:SetSize(E.curHeight, E.curHeight)
	OctoToDo_EventsButton:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", (-E.curHeight)*5, 0)
	OctoToDo_EventsButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:ClearLines()
			local curdatetable = date("*t")
			-- fpde(date("*t"))
			-- [1] = {
			-- ["hour"] = 2,
			-- ["min"] = 15,
			-- ["wday"] = 1,
			-- ["day"] = 30,
			-- ["month"] = 3,
			-- ["year"] = 2025,
			-- ["sec"] = 28,
			-- ["yday"] = 89,
			-- ["isdst"] = "false",
			-- },
			local curdate = (FormatShortDate(curdatetable.day, curdatetable.month, curdatetable.year))
			-- local curdate = E:func_fixdate(curdatetable.day).."/"..E:func_fixdate(curdatetable.month).."/"..E:func_fixdate(curdatetable.year)
			GameTooltip:AddDoubleLine(E.WOW_Artifact_Color..(L["Current Date"]).."|r", E.WOW_Artifact_Color..(curdate.."|r"))
			GameTooltip:AddDoubleLine(" ", " ")
			local count = 0
			local sorted = {}
			for k, v in pairs (OctoToDo_DB_Other.Holiday) do
				tinsert(sorted, k)
			end
			sort(sorted, function(a, b) return OctoToDo_DB_Other.Holiday[a].priority < OctoToDo_DB_Other.Holiday[b].priority end)
			for i, eventID in ipairs(sorted) do
				local v = OctoToDo_DB_Other.Holiday[eventID]
				count = count + 1
				if v.Active == true then
					-- BRAWL_TOOLTIP_ENDS - Заканчивается через %s

					-- СЕЙЧАС
					GameTooltip:AddDoubleLine(E.Green_Color..v.title.."|r"..E.White_Color.." (".. string.format(BRAWL_TOOLTIP_ENDS, v.ENDS)..")|r"..(E.DebugIDs and E.Gray_Color.. " id:"..eventID.."|r" or ""), E.Green_Color..v.startTime.." - "..v.endTime.."|r")
				elseif v.Possible == true then
					-- БУДУЩЕЕ
					GameTooltip:AddDoubleLine(E.Gray_Color..v.title .." ("..v.event_duration..")|r"..(E.DebugIDs and E.Gray_Color.. " id:"..eventID.."|r" or ""), E.Gray_Color..v.startTime.." - "..v.endTime.."|r")
				else
					-- ПРОШЛОЕ
					GameTooltip:AddDoubleLine(E.Gray_Color..v.title .." ("..v.event_duration..")|r"..(E.DebugIDs and E.Gray_Color.. " id:"..eventID.."|r" or ""), E.Gray_Color..v.startTime.." - "..v.endTime.."|r")
				end
			end
			if count == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" ", " ")
			GameTooltip:Show()
	end)
	OctoToDo_EventsButton:SetScript("OnLeave", function(self)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_EventsButton:SetScript("OnClick", function()
			frame:Hide()
			fpde(OctoToDo_DB_Other.Holiday)
	end)
	OctoToDo_EventsButton.icon = OctoToDo_EventsButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_EventsButton.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow6.tga")
	OctoToDo_EventsButton.icon:SetAllPoints()
	-- E:func_SetBackdrop(OctoToDo_EventsButton)
end
----------------------------------------------------------------
function E:func_CreateMinimapButton(addonName, vars, frame, func)
	local info = {
		type = "data source",
		text = MinimapName,
		icon = E.func_AddonIconTexture(addonName),
		OnEnter = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
			GameTooltip_SetTitle(GameTooltip, E.func_AddonTitle(addonName))
			GameTooltip:Show()
		end,
		OnLeave = function()
			GameTooltip:Hide()
		end,
	}
	info.OnClick = function(_, button)
		if button == "LeftButton" then
			if not InCombatLockdown() then
				if func then
					func()
				end
				for index, frames in ipairs(E.OctoTable_Frames) do
					if frame ~= frames and frames:IsShown() then
						frames:Hide()
					end
				end
				frame:SetShown(not frame:IsShown())
			end
		end
	end
	-- if func then
	-- info.OnClick = func
	-- else
	-- info.OnClick = function(_, button)
	-- if button == "LeftButton" then
	-- if not InCombatLockdown() then
	-- frame:SetShown(not frame:IsShown())
	-- end
	-- end
	-- end
	-- end
	local MinimapName = E.func_AddonTitle(addonName)
	local ldb_icon = LibDataBroker:NewDataObject(MinimapName, info)
	if vars.minimapPos == nil then vars.minimapPos = 244 end
	LibDBIcon:Register(MinimapName, ldb_icon, vars.minimap)
	LibDBIcon:Show(MinimapName)
end
----------------------------------------------------------------
function E:func_fixdate(date)
	-- GameTooltip:AddDoubleLine(E.WOW_Artifact_Color..(L["Current Date"]).."|r", E.WOW_Artifact_Color..(date("%d/%m/%Y").."|r"))
	-- local curdate = (FormatShortDate(curdatetable.day, curdatetable.month, curdatetable.year))
	local vivod = ("%.2d"):format(date)
	--return format("%.2d", date)
	return vivod
end
----------------------------------------------------------------
function E:StopSpam(func)
	print ("StopSpam", tostring(func))
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------