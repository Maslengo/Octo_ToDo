local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("Frame")

EventFrame:RegisterEvent("BAG_UPDATE_DELAYED")
EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
EventFrame:RegisterEvent("LOOT_READY")
EventFrame:RegisterEvent("PLAYER_STARTED_MOVING")
-- Кэшируем часто используемые функции
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetItemInfo = C_Item.GetItemInfo
local UseContainerItem = C_Container.UseContainerItem
local InCombatLockdown = InCombatLockdown
local UnitIsDead = UnitIsDead
local select = select
local next = next
-- Оптимизация: создаем таблицу для быстрого поиска itemID
local autoOpenItems = {}
for _, id in ipairs(E.OctoTable_itemID_AutoOpen) do
	autoOpenItems[id] = true
end
local function OpenableScan()
	local isDead = UnitIsDead("player") -- Локальная проверка вместо глобальной
	-- Проверяем условия один раз перед сканированием
	if InCombatLockdown() or isDead then
		return
	end
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		local numSlots = GetContainerNumSlots(bag)
		for slot = numSlots, 1, -1 do
			local containerInfo = GetContainerItemInfo(bag, slot)
			if containerInfo and not containerInfo.isLocked and autoOpenItems[containerInfo.itemID] then
				local itemLink = select(2, GetItemInfo(containerInfo.itemID))
				-- if itemLink then
				-- 	C_Timer.After(1, function()
				-- 			if not InCombatLockdown() then
				-- 				UseContainerItem(bag, slot)
				-- 				DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Auto Open Item ")..E.func_texturefromIcon(containerInfo.iconFileID)..itemLink)
				-- 			end
				-- 	end)
				-- end
			end
		end
	end
end
local openableScanQueued = false
EventFrame:SetScript("OnEvent", function(self, event)
		-- if not Octo_ToDo_DB_Vars.AutoOpen then return end
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