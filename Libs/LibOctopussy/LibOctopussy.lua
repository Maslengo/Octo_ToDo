local GlobalAddonName = ...
local MAJOR_VERSION, MINOR_VERSION = "LibOctopussy-1.0", 1
local lib, oldminor = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end
local type, next, xpcall, setmetatable, CallErrorHandler, C_Item, C_Spell = type, next, xpcall, setmetatable, CallErrorHandler, C_Item, C_Spell
local DoesItemExistByID, IsItemDataCachedByID, ITEM_QUALITY_COLORS = C_Item.DoesItemExistByID, C_Item.IsItemDataCachedByID, ITEM_QUALITY_COLORS
local GetItemInfo = GetItemInfo or C_Item.GetItemInfo
local GetDetailedItemLevelInfo = GetDetailedItemLevelInfo or C_Item.GetDetailedItemLevelInfo
local GetItemInfoInstant = GetItemInfoInstant or C_Item.GetItemInfoInstant
local DoesSpellExist, IsSpellDataCached = C_Spell.DoesSpellExist, C_Spell.IsSpellDataCached
local GetSpellSubtext = GetSpellSubtext or C_Spell.GetSpellSubtext
local GetSpellLink = GetSpellLink or C_Spell.GetSpellLink
local GetSpellTexture = GetSpellTexture or C_Spell.GetSpellTexture
local GetSpellDescription = GetSpellDescription or C_Spell.GetSpellDescription
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
local Red_Color = "|cffFF4C4F"
local Gray_Color = "|cff505050"
local White_Color = "|cffFFFFFF"
local Purple_Color = "|cffAF61FF"
local Yellow_Color = "|cffFFF371"
local Green_Color = "|cff4FFF79"
local Orange_Color = "|cffFF661A"
local Blue_Color = "|cff00A3FF"
local E_NONE = Gray_Color.."None|r"
local E_DONE = Green_Color.."Done|r"

local Region = GetLocale()




local localYEAR = "y. "
local localDAY = "d. "
local localHOUR = "h. "
local localMINUTE = "m. "
local localSECOND = "s. "
if Region == "ruRU" then

	localYEAR = "г. "
	localDAY = "д. "
	localHOUR = "ч. "
	localMINUTE = "м. "
	localSECOND = "с. "
end



local function func_texturefromIcon(iconID, iconSize, isShown)
	if isShown == nil then isShown = true end
	if iconSize == nil then iconSize = 14 end
	if iconID == nil then iconID = 134400 end
	local vivod
	if isShown == true then
		vivod = "|T".. iconID ..":"..iconSize..":"..iconSize..":::64:64:4:60:4:60|t"
	else
		vivod = ""
	end
	return vivod
end

local E_Icon_AccountWide = func_texturefromIcon(1120721)
local E_Icon_AccountTransferable = func_texturefromIcon(6124644)
local E_thursdayReset = (1514358000-10800)
local E_daytime = 86400

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
function lib:GetItemInfo(itemID)
	return GetItemInfo(itemID)
end
----------------------------------------------------------------
function lib:GetItemIcon(itemID)
	return C_Item.GetItemIconByID(itemID)
end
----------------------------------------------------------------
function lib:GetItemName(itemID)
	return C_Item.GetItemNameByID(itemID)
end
----------------------------------------------------------------
function lib:GetItemLink(itemID)
	local _, link = self:GetItemInfo(itemID)
	return link
end
----------------------------------------------------------------
function lib:GetItemQuality(itemID)
	return C_Item.GetItemQualityByID(itemID)
end
----------------------------------------------------------------
function lib:GetItemQualityColor(itemID)
	return ITEM_QUALITY_COLORS[self:GetItemQuality(itemID)]
end
----------------------------------------------------------------
function lib:GetItemQualityColorRGB(itemID)
	return self:GetItemQualityColor(itemID).color:GetRGB()
end
----------------------------------------------------------------
function lib:GetItemCurrentLevel(itemID)
	return GetDetailedItemLevelInfo(itemID)
end
----------------------------------------------------------------
function lib:GetItemMaxStackSize(itemID)
	return C_Item.GetItemMaxStackSizeByID(itemID)
end
----------------------------------------------------------------
function lib:IsItemStackable(itemID)
	local maxStackSize = self:GetItemMaxStackSize(itemID)
	return maxStackSize and maxStackSize > 1
end
----------------------------------------------------------------
function lib:GetItemInventoryType(itemID)
	return C_Item.GetItemInventoryTypeByID(itemID)
end
----------------------------------------------------------------
function lib:GetItemInventoryTypeName(itemID)
	local _,_,_, itemEquipLoc = GetItemInfoInstant(itemID)
	return itemEquipLoc
end
----------------------------------------------------------------
function lib:IsItemDataCached(itemID)
	return IsItemDataCachedByID(itemID)
end
----------------------------------------------------------------
-- SPELL UTILS
if C_Spell.GetSpellInfo then
	function lib:GetSpellInfo(spellID)
		return C_Spell.GetSpellInfo(spellID)
	end
else
	local GetSpellinfo = GetSpellinfo
	function lib:GetSpellInfo(spellID)
		local name, _, icon, castTime, minRange, maxRange, spellID, originalIcon = GetSpellInfo(spellID)
		return {
			name = name,
			iconID = icon,
			originalIconID = originalIcon,
			castTime = castTime,
			minRange = minRange,
			maxRange = maxRange,
			spellID = spellID,
		}
	end
end
----------------------------------------------------------------
if C_Spell.GetSpellCooldown then
	function lib:GetSpellCooldown(spellID)
		return C_Spell.GetSpellCooldown(spellID)
	end
else
	local GetSpellCooldown = GetSpellCooldown
	function lib:GetSpellCooldown(spellID)
		local start, duration, enabled, modRate = GetSpellCooldown(spellID)
		return {
			startTime = start,
			duration = duration,
			isEnabled = enabled == 0,
			modRate = modRate,
		}
	end
end
----------------------------------------------------------------
if C_Spell.GetSpellName then
	function lib:GetSpellName(spellID)
		return C_Spell.GetSpellName(spellID)
	end
else
	function lib:GetSpellName(spellID)
		return self:GetSpellInfo(spellID).name
	end
end
----------------------------------------------------------------
function lib:GetSpellSubtext(spellID)
	return GetSpellSubtext(spellID)
end
----------------------------------------------------------------м
function lib:GetSpellFullName(spellID)
	local name = self:GetSpellName(spellID)
	local subText = self:GetSpellSubtext(spellID)
	return subText and #subText > 0 and name.."("..subText..")" or name
end
----------------------------------------------------------------
function lib:GetSpellLink(...)
	return GetSpellLink(...)
end
----------------------------------------------------------------
function lib:GetSpellTexture(spellID)
	return GetSpellTexture(spellID)
end
----------------------------------------------------------------
function lib:GetSpellDescription(spellID)
	return GetSpellDescription(spellID)
end
----------------------------------------------------------------
function lib:IsSpellDataCached(spellID)
	return IsSpellDataCached(spellID)
end
----------------------------------------------------------------
----------------------------------------------------------------
function lib:func_hex2rgb(self)
	self = self:gsub("|cff", "")
	return tonumber("0x"..self:sub(1, 2)), tonumber("0x"..self:sub(3, 4)), tonumber("0x"..self:sub(5, 6))
end
----------------------------------------------------------------
function lib:func_rgb2hex(r, g, b, a)
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
function lib:func_rgb2hexDEV(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	return "c"..string.format("%02x", math.floor(a*255))..utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
end
----------------------------------------------------------------
function lib:func_percent(percent, maxvalue)
	return (maxvalue*percent)/100
end
----------------------------------------------------------------
function lib:func_Gradient(text, firstColor, secondColor)
	local vivod = ""
	local str = ""
	local total = utf8len(text)-1
	local r1, g1, b1 = lib:func_hex2rgb(firstColor)
	local r2, g2, b2 = lib:func_hex2rgb(secondColor)
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
function lib:func_GenerateUniqueID()
	local s = {}
	for i=1, 11 do
		tinsert(s, OctoTable_bytetoB64[math.random(0, 63)])
	end
	return table.concat(s)
end
----------------------------------------------------------------
function lib:func_GenerateUniqueColor()
	local s = {}
	for i=1, 6 do
		tinsert(s, OctoTable_bytetoB64Color[math.random(0, 15)])
	end
	return table.concat(s)
end
----------------------------------------------------------------
function lib:func_TableConcat(table1, table2)
	for i=1, #table2 do
		table1[#table1+1] = table2[i]
	end
	return table1
end
----------------------------------------------------------------
function lib:func_PlaySoundFile_whisper(self)
	if self then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Memes\\"..self..".ogg", "Master")
	end
end
----------------------------------------------------------------
function lib:func_CompactNumberFormat(self)
	if not self then
		self = 0
	end
	if self == 0 then
		return 0
	elseif self < 1000 then
		return (math.floor((self+0.5)-0.5)/10)*10
	elseif self < 1000000 then
		return (math.floor(self/100)/10).."k"
	else
		return (math.floor(self/100000)/10).."m"
	end
end
----------------------------------------------------------------
function lib:func_CompactNumberSimple(self)
	if not self then
		self = 0
	end
	if self == 0 then
		return 0
	else
		return math.floor(self+.5)
	end
end
----------------------------------------------------------------
function lib:func_texturefromIcon(iconID, iconSize, isShown)
	if isShown == nil then isShown = true end
	if iconSize == nil then iconSize = 14 end
	if iconID == nil then iconID = 134400 end
	local vivod
	if isShown == true then
		vivod = "|T".. iconID ..":"..iconSize..":"..iconSize..":::64:64:4:60:4:60|t"
	else
		vivod = ""
	end
	return vivod
end
----------------------------------------------------------------
function lib:func_questName(questID, useLargeIcon)
	local useLargeIcon = useLargeIcon or true
	local title = C_QuestLog.GetTitleForQuestID(questID)
	if title then
		return QuestUtils_DecorateQuestText(questID, title, useLargeIcon), true
	else
		return Red_Color.."notitle".."|r"
	end
end
----------------------------------------------------------------
function lib:func_reputationName(self)
	local AWide = ""
	local isAccountWide = C_Reputation.IsAccountWideReputation(self) or false
	if isAccountWide == true then
		AWide = E_Icon_AccountWide
	end
	local repInfo = C_Reputation.GetFactionDataByID(self)
	local name
	if repInfo then
		name = repInfo.name
	else
		local reputationInfo = C_GossipInfo.GetFriendshipReputation(self or 0)
		name = reputationInfo.name or "no name"--Red_Color.."id "..self.."|r"
	end
	return AWide..name
	-- return name
end
----------------------------------------------------------------
function lib:func_itemName_NOCOLOR(itemID)
	local itemName_NOCOLOR = C_Item.GetItemNameByID(itemID) or "itemName_NOCOLOR"
	return itemName_NOCOLOR
end
----------------------------------------------------------------
function lib:func_itemName(itemID)
	local itemName = lib:func_itemName_NOCOLOR(itemID) or "itemName"
	local itemQuality = select(3, GetItemInfo(itemID))
	if itemQuality then
		-- local r, g, b = ITEM_QUALITY_COLORS[itemQuality].color
		-- local r, g, b = GetItemQualityColor(itemQuality)
		-- local color = CreateColor(r, g, b, 1)
		-- local itemNameColored = color:WrapTextInColorCode(itemName)
		local itemNameColored = ITEM_QUALITY_COLORS[itemQuality].color:WrapTextInColorCode(itemName)
		return itemNameColored or Red_Color..RETRIEVING_ITEM_INFO.."|r"
	end
	return itemName or Red_Color..RETRIEVING_ITEM_INFO.."|r"
end
----------------------------------------------------------------
function lib:func_itemTexture(self)
	local itemTexture = select(10, GetItemInfo(self)) or 134400
	return lib:func_texturefromIcon(itemTexture)
end
----------------------------------------------------------------
function lib:func_GetItemCooldown(self)
	local start, duration = C_Item.GetItemCooldown(self)
	-- local start = C_Item.GetItemCooldown(self).startTimeSeconds or 0
	-- local duration = C_Item.GetItemCooldown(self).durationSeconds or 0
	-- local start = C_Container.GetItemCooldown(self).startTime or 0
	-- local duration = C_Container.GetItemCooldown(self).duration or 0
	local vivod = 0
	if start > 0 and duration > 0 then
		vivod = (start + duration - GetTime())
	end
	return lib:func_CompactNumberSimple(vivod)
end
----------------------------------------------------------------
function lib:func_currencyName(self)
	local AWide = ""
	local ATrans = ""
	local isAccountTransferableCurrency = C_CurrencyInfo.IsAccountTransferableCurrency(self) or false
	if isAccountTransferableCurrency == true then
		AWide = E_Icon_AccountTransferable
	end
	local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(self) or false
	if isAccountWideCurrency == true then
		AWide = E_Icon_AccountWide
	end
	local vivod = ""
	local info = C_CurrencyInfo.GetCurrencyInfo(self)
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
	return vivod
end
----------------------------------------------------------------
function lib:func_currencyName_NOCOLOR(self)
	local AWide = ""
	local ATrans = ""
	local isAccountTransferableCurrency = C_CurrencyInfo.IsAccountTransferableCurrency(self) or false
	if isAccountTransferableCurrency == true then
		AWide = E_Icon_AccountTransferable
	end
	local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(self) or false
	if isAccountWideCurrency == true then
		AWide = E_Icon_AccountWide
	end
	local vivod = ""
	local info = C_CurrencyInfo.GetCurrencyInfo(self)
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
	return vivod
end
----------------------------------------------------------------
function lib:func_currencyicon(self)
	local info = C_CurrencyInfo.GetCurrencyInfo(self)
	if info then
		iconFileID = info.iconFileID
	else
		iconFileID = 134400
	end
	return lib:func_texturefromIcon(iconFileID)
end
----------------------------------------------------------------
function lib:func_currencyquantity(self)
	local info = C_CurrencyInfo.GetCurrencyInfo(self)
	if info then
		quantity = info.quantity or 0
	end
	return quantity
end
----------------------------------------------------------------
function lib:func_GetSpellName(self)
	local name = C_Spell.GetSpellInfo(self).name
	return name
end
----------------------------------------------------------------
function lib:func_GetSpellIcon(self)
	local iconID = C_Spell.GetSpellInfo(self).iconID
	return iconID
end
----------------------------------------------------------------
function lib:func_GetSpellCooldown(self)
	local start = C_Spell.GetSpellCooldown(self).startTime
	local duration = C_Spell.GetSpellCooldown(self).duration
	local vivod = 0
	if start > 0 and duration > 0 then
		vivod = (start + duration - GetTime())
	end
	return lib:func_CompactNumberSimple(vivod)
end
----------------------------------------------------------------
function lib:func_SecondsToClock(self)
	-- local years, days, hours, mins, secs = "", "", "", "", ""
	local years, days, hours, mins, secs = 0, 0, 0, 0, 0
	local self = tonumber(self)
	if self <= 0 or self == nil then --
		return "0:00"
	elseif self >= (86400*365) then -- год
		years = floor(self / (86400*365))
		days = floor(mod(self, 31536000) / 86400)
		hours = floor(mod(self, 86400) / 3600)
		mins = floor(mod(self, 3600) / 60)
		return years..localYEAR..days..localDAY..hours..localHOUR..mins..localMINUTE
	elseif self >= 86400 then -- 24ч
		days = floor(self / 86400)
		hours = floor(mod(self, 86400) / 3600)
		mins = floor(mod(self, 3600) / 60)
		return days..localDAY..hours..localHOUR..mins..localMINUTE
	elseif self >= 3600 then -- 1 час
		hours = string.format("%01.f", math.floor(self/3600))
		mins = string.format("%02.f", math.floor(self/60 - (hours*60)))
		return hours..localHOUR..mins..localMINUTE
	elseif self >= 600 then -- 10 минут
		hours = string.format("%01.f", math.floor(self/3600))
		mins = string.format("%02.f", math.floor(self/60 - (hours*60)))
		return mins..localMINUTE
	elseif self >= 60 then -- минута
		hours = string.format("%01.f", math.floor(self/3600))
		mins = string.format("%01.f", math.floor(self/60 - (hours*60)))
		return mins..localMINUTE
	else
		return self..localSECOND
	end
end
----------------------------------------------------------------
function lib:func_EmptyZero(self)
	if tonumber(self) == 0 then
		return ""
	end
	return self
end
----------------------------------------------------------------
function lib:func_tmstpDayReset(self)
	local self = self or 1
	return (math.ceil((tonumber(GetServerTime()) - E_thursdayReset)/(E_daytime*self))*E_daytime*self)+E_thursdayReset
end
----------------------------------------------------------------
function lib:func_All_objectives(self)
	local str = ""
	local objectives = C_QuestLog.GetQuestObjectives(self)
	local text, objectiveType, finished, fulfilled, required = GetQuestObjectiveInfo(self, 1, false)
	if objectives == nil then
		return ""
	end
	if objectiveType == "progressbar" then
		return "|cffFF0000"..GetQuestProgressBarPercent(self).."%|r"
	end
	if objectives then
		if objectives[5] then
			str = str..(objectives[5].finished and Gray_Color or White_Color) ..objectives[5].text.."|r\n"
			str = str..(objectives[4].finished and Gray_Color or White_Color) ..objectives[4].text.."|r\n"
			str = str..(objectives[3].finished and Gray_Color or White_Color) ..objectives[3].text.."|r\n"
			str = str..(objectives[2].finished and Gray_Color or White_Color) ..objectives[2].text.."|r\n"
			str = str..(objectives[1].finished and Gray_Color or White_Color) ..objectives[1].text.."|r\n"
		elseif objectives[4] then
			str = str..(objectives[4].finished and Gray_Color or White_Color) ..objectives[4].text.."|r\n"
			str = str..(objectives[3].finished and Gray_Color or White_Color) ..objectives[3].text.."|r\n"
			str = str..(objectives[2].finished and Gray_Color or White_Color) ..objectives[2].text.."|r\n"
			str = str..(objectives[1].finished and Gray_Color or White_Color) ..objectives[1].text.."|r\n"
		elseif objectives[3] then
			str = str..(objectives[3].finished and Gray_Color or White_Color) ..objectives[3].text.."|r\n"
			str = str..(objectives[2].finished and Gray_Color or White_Color) ..objectives[2].text.."|r\n"
			str = str..(objectives[1].finished and Gray_Color or White_Color) ..objectives[1].text.."|r\n"
		elseif objectives[2] then
			str = str..(objectives[2].finished and Gray_Color or White_Color) ..objectives[2].text.."|r\n"
			str = str..(objectives[1].finished and Gray_Color or White_Color) ..objectives[1].text.."|r\n"
		elseif objectives[1] then
			str = str..(objectives[1].finished and Gray_Color or White_Color) ..objectives[1].text.."|r\n"
		end
	end
	return str
end
----------------------------------------------------------------
function lib:func_Octo_LoadAddOn(GlobalAddonName)
	local loaded, reason = C_AddOns.LoadAddOn(GlobalAddonName)
	if not loaded and reason == "DISABLED" then
		-- if select(5, C_AddOns.GetAddOnInfo(GlobalAddonName)) == "DISABLED" then
		C_AddOns.EnableAddOn(GlobalAddonName)
		C_AddOns.LoadAddOn(GlobalAddonName)
	end
end
----------------------------------------------------------------
function lib:func_CheckCompletedByQuestID(questID)
	local vivod
	local TEST = ""
	if C_QuestLog.IsQuestFlaggedCompleted(questID) == true then
		vivod = (E_DONE)
	elseif C_QuestLog.IsComplete(questID) == true then
		vivod = Purple_Color..">>DONE<<".."|r"
	elseif C_QuestLog.IsQuestFlaggedCompleted(questID) == false and C_QuestLog.IsOnQuest(questID) == false then
		vivod = (E_NONE)
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
function lib:func_OnlyFirstWord(self)
	self = tostring(self)
	local a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z = strsplit(" ", self)
	return a or b or c or d or e or f or g or h or i or j or k or l or m or n or o or p or q or r or s or t or u or v or w or x or y or z
end
----------------------------------------------------------------
function lib:func_OnlyLastWord(self)
	self = tostring(self)
	local a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z = strsplit(" ", self)
	return z or y or x or w or v or u or t or s or r or q or p or i or n or m or l or k or j or i or h or g or f or e or d or c or b or a
end
----------------------------------------------------------------
function lib:func_InList(k, t, p)
	for _, v in next, (t) do
		if (p and v[p]==k) or (not p and v==k) then
			return true
		end
	end
end
----------------------------------------------------------------
function lib:func_achievementID(self)
	return Yellow_Color.." (id: "..self..")".."|r"
end
----------------------------------------------------------------
function lib:func_achievementComplete(self)
	if not self then
		return false
	end
	local completed = select(4, GetAchievementInfo(self))
	return completed
end
----------------------------------------------------------------
function lib:func_achievementName(self)
	local Name = select(2, GetAchievementInfo(self))
	return Name..lib:func_achievementID(self)
end
----------------------------------------------------------------
function lib:func_achievementIcon(self)
	local Icon = select(10, GetAchievementInfo(self))
	return lib:func_texturefromIcon(Icon)
end
----------------------------------------------------------------
function lib:func_achievementvivod(self)
	local vivod = ""
	local completed = select(4, GetAchievementInfo(self))
	if completed == true then
		vivod = E_DONE
	else
		local numCriteria = GetAchievementNumCriteria(self)
		if numCriteria ~= 0 then
			local count = 0
			for i = 1, numCriteria do
				local _, _, completedCrit, quantity, reqQuantity = GetAchievementCriteriaInfo(self, i, false)
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
function lib:func_achievementcriteriaString(self, i)
	i = i or 1
	local vivod = ""
	local completed = select(4, GetAchievementInfo(self))
	local description = select(8, GetAchievementInfo(self))
	local numCriteria = GetAchievementNumCriteria(self)
	local criteriaString, _, completedCrit, quantity = GetAchievementCriteriaInfo(self, i, false)
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
function lib:func_achievementquantity(self, i)
	i = i or 1
	local vivod = ""
	local completed = select(4, GetAchievementInfo(self))
	local description = select(8, GetAchievementInfo(self))
	local numCriteria = GetAchievementNumCriteria(self)
	local _, _, completedCrit, quantity, reqQuantity = GetAchievementCriteriaInfo(self, i, false)
	local color = White_Color
	if completedCrit == true then
		color = Green_Color
	elseif completedCrit == false and quantity == 0 then
		color = Red_Color
	end
	if quantity then
		vivod = vivod..color..quantity.." / "..reqQuantity.."|r"
	else
		vivod = vivod..color.."0/1PIZDA".."|r"
	end
	return vivod
end
----------------------------------------------------------------
function lib:func_achievementdescription(self)
	local description = select(8, GetAchievementInfo(self))
	return description
end
----------------------------------------------------------------
function lib:func_CurServerShort(self)
	local text = (self):gsub("-", " "):gsub("'", " ")
	local a, b = strsplit(" ", text)
	if b then
		self = utf8sub(a, 1, 1):upper()..utf8sub(b, 1, 1):upper()
	else
		self = utf8sub(a, 1, 1):upper()..utf8sub(a, 2, 3):lower()
	end
	return self
end
----------------------------------------------------------------
function lib:func_GetMapName(self)
	if not self then return end
	local info = C_Map.GetMapInfo(self)
	if info then
		local name = info.name
		return tostring(name)
	end
end
----------------------------------------------------------------
function lib:func_npcName(self)
	local inspectScantipFUNC = nil
	if not inspectScantipFUNC then
		inspectScantipFUNC = CreateFrame("GameTooltip", "OctoToDoScanningTooltipFUNC", nil, "GameTooltipTemplate")
		inspectScantipFUNC:SetOwner(UIParent, "ANCHOR_NONE")
	end
	local name = "|cffFF0000error|r"
	if not self then return E_NONE end
	if self then
		inspectScantipFUNC:SetHyperlink("unit:Creature-0-0-0-0-"..self)
		if inspectScantipFUNC:NumLines() > 0 then
			name = _G["OctoToDoScanningTooltipFUNCTextLeft1"]:GetText()
			return name
		end
		inspectScantipFUNC:ClearLines()
	end
	return name
end
----------------------------------------------------------------
function lib:func_RIOColor(self)
	local hexColor = Gray_Color
	if not self or self == 0 then return hexColor end
	for _, v in next, (OctoTable_RIO_COLORS) do
		if self <= v.score then
			hexColor = lib:func_rgb2hex(v.color[1],v.color[2],v.color[3])
		end
	end
	return hexColor
end
----------------------------------------------------------------
function lib:func_encryption(self)
	local self = utf8reverse(tostring(self))
	local text = strsplit("-", self)
	local vivod = ""
	vivod = utf8lower(text:gsub("0", ""):gsub("1", ""):gsub("2", ""):gsub("3", ""):gsub("4", ""):gsub("5", ""):gsub("6", ""):gsub("7", ""):gsub("8", ""):gsub("9", ""))
	return vivod
end
----------------------------------------------------------------
function lib:func_GetClassColor(self) -- C_ClassColor.GetClassColor(classFilename)
	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[self]
	if color then
		return color.colorStr:gsub("^ff", "")
	end
	return "ffffff"
end
----------------------------------------------------------------
function lib:func_Reverse_order(a, b)
	return b < a
end
----------------------------------------------------------------
function lib:func_CheckReputationByRepID(self)
	local color = White_Color
	local r = "|r"
	local standingTEXT = ""
	local vivod = ""
	local repInfo = C_Reputation.GetFactionDataByID(self)
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
	local reputationInfo = C_GossipInfo.GetFriendshipReputation(self or 0)
	if C_Reputation.IsFactionParagon(self) then
		local currentValue = C_Reputation.GetFactionParagonInfo(self) or 0
		local threshold = 1
		local _, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(self)
		if threshold then
			local value = currentValue % threshold
			vivod = Blue_Color..(value).."/"..(threshold)..r
			if hasRewardPending then
				vivod = lib:func_CheckCompletedByQuestID(rewardQuestID)
			end
		end
	elseif C_Reputation.IsMajorFaction(self) then
		local data = C_MajorFactions.GetMajorFactionData(self) or 0
		if data ~= 0 then
			local currentValue = data.renownReputationEarned
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
	return vivod
end
----------------------------------------------------------------
function lib:func_CurrentNumQuests()
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
function lib:func_RemoveDuplicates(table1)
	if type(table1) ~= "table" then
		print (Red_Color.."ERROR: |r"..table1..Red_Color.." not a table|r")
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
