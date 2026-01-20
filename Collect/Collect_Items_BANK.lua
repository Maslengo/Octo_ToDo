local GlobalAddonName, E = ...
----------------------------------------------------------------
-- /run opde(Enum.BagIndex)
-- [1] = {
----------------------------------------------------------------
--     ["Characterbanktab"] = -2,
--     ["CharacterBankTab_1"] = 6,
--     ["CharacterBankTab_6"] = 11,
--     ["CharacterBankTab_2"] = 7,
--     ["CharacterBankTab_3"] = 8,
--     ["CharacterBankTab_5"] = 10,
--     ["CharacterBankTab_4"] = 9,
----------------------------------------------------------------
--     ["Accountbanktab"] = -3,
--     ["AccountBankTab_1"] = 12,
--     ["AccountBankTab_2"] = 13,
--     ["AccountBankTab_3"] = 14,
--     ["AccountBankTab_4"] = 15,
--     ["AccountBankTab_5"] = 16,
----------------------------------------------------------------
--     ["Keyring"] = -1,
--     ["Backpack"] = 0,
--     ["Bag_1"] = 1,
--     ["Bag_2"] = 2,
--     ["Bag_3"] = 3,
--     ["Bag_4"] = 4,
--     ["ReagentBag"] = 5,
----------------------------------------------------------------
-- },
----------------------------------------------------------------
local OctoTable_bankTabs = E.OctoTable_bankTabs
local OctoTable_Account_bankTabs = E.OctoTable_Account_bankTabs


local function Collect_Items_BANK()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	C_Timer.After(0, function()
			if not BankFrame or not BankFrame:IsShown() then return end
			local usedSlots_BANK, totalSlots_BANK = 0, 0
			----------------------------------------------------------------
			collectMASLENGO.Items = collectMASLENGO.Items or {}
			collectMASLENGO.Items.Bank = {}
			----------------------------------------------------------------
			-- ПРОВЕРКА
			----------------------------------------------------------------
			if not Enum.BagIndex or not Enum.BagIndex.CharacterBankTab_1 then return end
			----------------------------------------------------------------
			-- BANK
			for _, bagID in next, (OctoTable_bankTabs) do
				local numSlots = C_Container.GetContainerNumSlots(bagID)
				if numSlots and numSlots > 0 then
					totalSlots_BANK = totalSlots_BANK + numSlots
					local free = C_Container.GetContainerNumFreeSlots(bagID)
					usedSlots_BANK = usedSlots_BANK + (numSlots - free)
					for slot = 1, numSlots do
						local info = C_Container.GetContainerItemInfo(bagID, slot)
						if info then
							local itemID = info.itemID
							local stack = info.stackCount or 1
							collectMASLENGO.Items.Bank[itemID] = (collectMASLENGO.Items.Bank[itemID] or 0) + stack
						end
					end
				end
			end
			----------------------------------------------------------------
			collectPlayerData.usedSlots_BANK = E.func_Save(usedSlots_BANK)
			collectPlayerData.totalSlots_BANK = E.func_Save(totalSlots_BANK)
			----------------------------------------------------------------
			-- opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.Items)
			----------------------------------------------------------------
	end)
end
local function Collect_Items_AccountBank()
	----------------------------------------------------------------
	if not E:func_CanCollectData() then return end
	local collectMASLENGO = Octo_ToDo_DB_Levels[E.curGUID].MASLENGO
	local collectPlayerData = Octo_ToDo_DB_Levels[E.curGUID].PlayerData
	----------------------------------------------------------------
	C_Timer.After(0, function()
			if not BankFrame or not BankFrame:IsShown() then return end
			local usedSlots_AccountBank, totalSlots_AccountBank = 0, 0
			----------------------------------------------------------------
			Octo_ToDo_DB_AccountData = Octo_ToDo_DB_AccountData or {}
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME] = Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME]or {}
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank = {}
			----------------------------------------------------------------
			-- ПРОВЕРКА
			----------------------------------------------------------------
			if C_Bank and C_Bank.FetchBankLockedReason and C_Bank.FetchBankLockedReason(Enum.BankType.Account) ~= nil then return end -- Банк заблокирован, не обрабатываем
			----------------------------------------------------------------
			-- ACCOUNT BANK

			for _, bagID in next, (OctoTable_Account_bankTabs) do
				local numSlots = C_Container.GetContainerNumSlots(bagID)
				if numSlots and numSlots > 0 then
					totalSlots_AccountBank = totalSlots_AccountBank + numSlots
					local free = C_Container.GetContainerNumFreeSlots(bagID)
					usedSlots_AccountBank = usedSlots_AccountBank + (numSlots - free)
					for slot = 1, numSlots do
						local info = C_Container.GetContainerItemInfo(bagID, slot)
						if info then
							local itemID = info.itemID
							local stack = info.stackCount or 1
							Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank[itemID] = (Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank[itemID] or 0) + stack
						end
					end
				end
			end
			----------------------------------------------------------------
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].usedSlots_AccountBank = E.func_Save(usedSlots_AccountBank)
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].totalSlots_AccountBank = E.func_Save(totalSlots_AccountBank)
			----------------------------------------------------------------
			-- opde(Octo_ToDo_DB_AccountData)
			----------------------------------------------------------------
	end)
end
----------------------------------------------------------------
function E.Collect_Items_BANK()
	E.func_SpamBlock(Collect_Items_BANK, true, 1)
end
----------------------------------------------------------------
function E.Collect_Items_AccountBank()
	E.func_SpamBlock(Collect_Items_AccountBank, true, 1)
end
----------------------------------------------------------------