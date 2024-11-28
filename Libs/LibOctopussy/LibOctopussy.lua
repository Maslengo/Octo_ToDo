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
