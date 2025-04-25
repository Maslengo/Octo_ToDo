-- local GlobalAddonName, E = ...
-- ----------------------------------------------------------------------------------------------------------------------------------
-- -- Auto_Open
-- local Octo_AUTO_OPEN = CreateFrame("Frame", GlobalAddonName.."Auto_Open"..E.func_GenerateUniqueID())
-- Octo_AUTO_OPEN:RegisterEvent("BAG_UPDATE_DELAYED")
-- Octo_AUTO_OPEN:RegisterEvent("PLAYER_REGEN_ENABLED")
-- Octo_AUTO_OPEN:RegisterEvent("LOOT_READY")
-- Octo_AUTO_OPEN:RegisterEvent("PLAYER_STARTED_MOVING")
-- local isDead = UnitIsDead("PLAYER")
-- local function OpenableScan()
-- 	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
-- 		for numSlots = C_Container.GetContainerNumSlots(bag),1,-1 do
-- 			local containerInfo = C_Container.GetContainerItemInfo(bag, numSlots)
-- 			if containerInfo then
-- 				local itemID = containerInfo.itemID
-- 				local isLocked = containerInfo.isLocked
-- 				local iconFileID = containerInfo.iconFileID
-- 				local itemLink = select(2, C_Item.GetItemInfo(itemID))
-- 				for _, ids in next, (E.OctoTable_itemID_AutoOpen) do
-- 					if ids == itemID and itemLink and not isLocked then
-- 						if iconFileID and itemLink and not InCombatLockdown() then
-- 							C_Timer.After(1, function()
-- 								if not InCombatLockdown() then
-- 									C_Container.UseContainerItem(bag, numSlots)
-- 									print (E.func_Gradient("Auto Open Item ", E.Addon_Left_Color, E.Addon_Right_Color), E.func_texturefromIcon(iconFileID)..itemLink)
-- 								end
-- 							end)
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end
-- local openableScanQueued = false
-- Octo_AUTO_OPEN:SetScript("OnEvent", function(self, event, ...)
-- 		C_Timer.After(0.1, function()
-- 				if Octo_ToDo_DB_Vars.AutoOpen then
-- 					if event == "BAG_UPDATE_DELAYED" then
-- 						if not InCombatLockdown() and isDead == false then
-- 							OpenableScan()
-- 						else
-- 							openableScanQueued = true
-- 						end
-- 					elseif event == "PLAYER_REGEN_ENABLED" then
-- 						if openableScanQueued then
-- 							openableScanQueued = false
-- 							OpenableScan()
-- 						end
-- 					end
-- 				end
-- 		end)
-- end)

-- ВАРИАНТ 2
local GlobalAddonName, E = ...

-- Auto_Open
local Octo_AUTO_OPEN = CreateFrame("Frame", GlobalAddonName.."Auto_Open"..E.func_GenerateUniqueID())
Octo_AUTO_OPEN:RegisterEvent("BAG_UPDATE_DELAYED")
Octo_AUTO_OPEN:RegisterEvent("PLAYER_REGEN_ENABLED")
Octo_AUTO_OPEN:RegisterEvent("LOOT_READY")
Octo_AUTO_OPEN:RegisterEvent("PLAYER_STARTED_MOVING")

-- Кэшируем часто используемые функции
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetItemInfo = C_Item.GetItemInfo
local UseContainerItem = C_Container.UseContainerItem
local InCombatLockdown = InCombatLockdown
local UnitIsDead = UnitIsDead
local select = select
local next = next
local print = print

-- Оптимизация: создаем таблицу для быстрого поиска itemID
local autoOpenItems = {}
for _, id in ipairs(E.OctoTable_itemID_AutoOpen) do
	autoOpenItems[id] = true
end

local function OpenableScan()
	local isDead = UnitIsDead("player") -- Локальная проверка вместо глобальной

	-- Проверяем условия один раз перед сканированием
	if InCombatLockdown() or isDead or not Octo_ToDo_DB_Vars.AutoOpen then
		return
	end

	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		local numSlots = GetContainerNumSlots(bag)
		for slot = numSlots, 1, -1 do
			local containerInfo = GetContainerItemInfo(bag, slot)
			if containerInfo and not containerInfo.isLocked and autoOpenItems[containerInfo.itemID] then
				local itemLink = select(2, GetItemInfo(containerInfo.itemID))
				if itemLink then
					C_Timer.After(1, function()
						if not InCombatLockdown() then
							UseContainerItem(bag, slot)
							print(E.func_Gradient("Auto Open Item ", E.Addon_Left_Color, E.Addon_Right_Color),
								 E.func_texturefromIcon(containerInfo.iconFileID)..itemLink)
						end
					end)
				end
			end
		end
	end
end

local openableScanQueued = false

Octo_AUTO_OPEN:SetScript("OnEvent", function(self, event)
	if not Octo_ToDo_DB_Vars.AutoOpen then return end

	if event == "BAG_UPDATE_DELAYED" then
		if not InCombatLockdown() and not UnitIsDead("player") then
			C_Timer.After(0.1, OpenableScan)
		else
			openableScanQueued = true
		end
	elseif event == "PLAYER_REGEN_ENABLED" and openableScanQueued then
		openableScanQueued = false
		C_Timer.After(0.1, OpenableScan)
	end
end)