local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local DEFAULT_CHAT_FRAME = _G.DEFAULT_CHAT_FRAME
local BACKPACK_CONTAINER = _G.BACKPACK_CONTAINER
local NUM_BAG_SLOTS = _G.NUM_BAG_SLOTS
local CreateFrame = _G.CreateFrame
local C_Timer = _G.C_Timer
local C_Container = _G.C_Container
local C_Item = _G.C_Item
local InCombatLockdown = _G.InCombatLockdown
local UnitIsDead = _G.UnitIsDead
local UnitHasVehicleUI = _G.UnitHasVehicleUI
local select = _G.select
local ipairs = _G.ipairs
local table = _G.table
----------------------------------------------------------------
local freeSpaceThreshold = 20 -- процент
local openDelay = 3
local rescanDelay = 3
----------------------------------------------------------------
local function HELP_TEXT(icon, name)
	return E.func_Gradient("[AutoOpen]")..E.func_texturefromIcon(icon)..name
end
----------------------------------------------------------------
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetItemInfo = C_Item.GetItemInfo
local UseContainerItem = C_Container.UseContainerItem
local autoOpenItems = {}
local needRescan = false
local rescanScheduled = false
local openableScanQueued = false
local unit = "PLAYER"
-- Инициализация списка предметов для автоматического открытия
for _, id in ipairs(E.OctoTable_itemID_AutoOpen) do
	autoOpenItems[id] = true
end
----------------------------------------------------------------
local function PlayerIsControllable()
	if InCombatLockdown() then return false, "combat" end
	if UnitIsDead(unit) then return false, "dead" end
	if UnitOnTaxi(unit) then return false, "taxi" end
	if UnitHasVehicleUI(unit) then return false, "vehicle" end
	if not UnitPlayerControlled(unit) then return false, "control" end
	return true
end
----------------------------------------------------------------
local function HasEnoughFreeBagSpace()
	local totalSlots = 0
	local usedSlots = 0
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		local numSlots = GetContainerNumSlots(bag)
		if numSlots and numSlots > 0 then
			totalSlots = totalSlots + numSlots
			for slot = 1, numSlots do
				local containerInfo = GetContainerItemInfo(bag, slot)
				if containerInfo and containerInfo.iconFileID then
					usedSlots = usedSlots + 1
				end
			end
		end
	end
	if totalSlots == 0 then return true end
	local freePercent = ((totalSlots - usedSlots) / totalSlots) * 100
	return freePercent >= freeSpaceThreshold
end
----------------------------------------------------------------
local function OpenableScan()
	if _G.MerchantFrame and _G.MerchantFrame:IsShown() then return end
	if not PlayerIsControllable() then
		openableScanQueued = true
		return
	end

	local openList = {}
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		local numSlots = GetContainerNumSlots(bag)
		if numSlots and numSlots > 0 then
			for slot = 1, numSlots do
				local containerInfo = GetContainerItemInfo(bag, slot)
				if containerInfo and not containerInfo.isLocked and autoOpenItems[containerInfo.itemID] then
					table.insert(openList, {
						bag = bag,
						slot = slot,
						itemID = containerInfo.itemID,
						icon = containerInfo.iconFileID
					})
				end
			end
		end
	end
	-- Если предметов нет — ничего не делаем
	if #openList == 0 then
		return
	end
	-- Предметы есть, но места мало — сообщим и выходим
	if not HasEnoughFreeBagSpace() then
		DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[AutoOpen]|r Not enough bag space to auto-open containers.")
		return
	end
	-- Функция последовательного открытия
	local function OpenNext()
		local entry = table.remove(openList, 1)
		if not entry then
			if needRescan and not rescanScheduled then
				rescanScheduled = true
				C_Timer.After(rescanDelay, function()
					rescanScheduled = false
					needRescan = false
					EventFrame:OpenableScan()
				end)
			end
			return
		end
		if not PlayerIsControllable() then
			openableScanQueued = true
			return
		end
		if not HasEnoughFreeBagSpace() then
			DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[AutoOpen]|r Bag space too low — stopping.")
			needRescan = true
			openList = {}
			return
		end
		local itemLink = select(2, GetItemInfo(entry.itemID))
		if itemLink then
			UseContainerItem(entry.bag, entry.slot)
			DEFAULT_CHAT_FRAME:AddMessage(HELP_TEXT(entry.icon, itemLink)) -- .." bag:"..entry.bag.." slot:"..entry.slot
			return
		end
		if #openList > 0 then
			C_Timer.After(openDelay, OpenNext)
			return
		end
	end
	-- Запуск первой итерации
	OpenNext()
end
----------------------------------------------------------------
function EventFrame:OpenableScan()
	E.func_SpamBlock(OpenableScan, true)
end
----------------------------------------------------------------
local function HandleBagUpdate()
	if not EventFrame.savedVars.Config_Auto_OpenItems then return end
	if E._spamLocks and E._spamLocks["OpenableScan"] then
		needRescan = true
	else
		EventFrame:OpenableScan()
	end
end
local MyEventsTable = {
	"ADDON_LOADED",
	"BAG_UPDATE",
	"BAG_UPDATE_COOLDOWN",
	"BAG_UPDATE_DELAYED",
	"PLAYER_REGEN_ENABLED",
	"MERCHANT_CLOSED",
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
end
EventFrame.BAG_UPDATE = HandleBagUpdate
EventFrame.BAG_UPDATE_COOLDOWN = HandleBagUpdate
EventFrame.BAG_UPDATE_DELAYED = HandleBagUpdate
function EventFrame:PLAYER_REGEN_ENABLED()
	if openableScanQueued and EventFrame.savedVars.Config_Auto_OpenItems then
		openableScanQueued = false
		EventFrame:OpenableScan()
	end
end
function EventFrame:MERCHANT_CLOSED()
	if not InCombatLockdown() and EventFrame.savedVars.Config_Auto_OpenItems then
		EventFrame:OpenableScan()
	end
end