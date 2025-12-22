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
local function Collect_Items_BANK()
	C_Timer.After(0, function()
			if not BankFrame or not BankFrame:IsShown() then return end
			local player = Octo_ToDo_DB_Levels[E.curGUID]
			if not player then return end
			local collectPlayerData = player.PlayerData
			local collectMASLENGO = player.MASLENGO
			if not collectPlayerData or not collectMASLENGO then return end
			local usedSlots_BANK, totalSlots_BANK = 0, 0
			local usedSlots_AccountBank, totalSlots_AccountBank = 0, 0
			local keystoneFound = false
			local ItemCounts_BANK = {}
			----------------------------------------------------------------
			-- ПРОВЕРКА
			----------------------------------------------------------------
			if not Enum.BagIndex or not Enum.BagIndex.CharacterBankTab_1 then return end
			----------------------------------------------------------------
			local bankTabs = {
				-- Enum.BagIndex.CharacterBankTab, -- -2,  (classic?)
				Enum.BagIndex.CharacterBankTab_1, -- 6,
				Enum.BagIndex.CharacterBankTab_2, -- 7,
				Enum.BagIndex.CharacterBankTab_3, -- 8,
				Enum.BagIndex.CharacterBankTab_4, -- 9,
				Enum.BagIndex.CharacterBankTab_5, -- 10,
				Enum.BagIndex.CharacterBankTab_6, -- 11,
			}
			-- BANK
			for _, bagID in next,(bankTabs) do
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
							ItemCounts_BANK[itemID] = (ItemCounts_BANK[itemID] or 0) + stack
							-- Keystone (по itemID, без строк)
							if not keystoneFound and E.KeyStoneTBL[itemID] then
								local link = info.hyperlink
								if link then
									local _, _, _, dungeonID, lvl = strsplit(":", link)
									dungeonID = tonumber(dungeonID)
									collectPlayerData.CurrentKeyLevel = tonumber(lvl)
									collectPlayerData.CurrentKeyName = C_ChallengeMode.GetMapUIInfo(dungeonID)
									keystoneFound = true
								end
							end
						end
					end
				end
			end
			----------------------------------------------------------------
			collectMASLENGO.Items = collectMASLENGO.Items or {}
			collectMASLENGO.Items.Bank = {}
			----------------------------------------------------------------
			collectMASLENGO.Items.Bank = ItemCounts_BANK
			collectPlayerData.usedSlots_BANK = usedSlots_BANK and usedSlots_BANK > 0 and usedSlots_BANK or nil
			collectPlayerData.totalSlots_BANK = totalSlots_BANK and totalSlots_BANK > 0 and totalSlots_BANK or nil
			----------------------------------------------------------------
			-- opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.Items)
			----------------------------------------------------------------
	end)
end
local function Collect_Items_AccountBank()
	C_Timer.After(0, function()
			if not BankFrame or not BankFrame:IsShown() then return end
			local player = Octo_ToDo_DB_Levels[E.curGUID]
			if not player then return end
			local collectPlayerData = player.PlayerData
			local collectMASLENGO = player.MASLENGO
			if not collectPlayerData or not collectMASLENGO then return end
			local usedSlots_BANK, totalSlots_BANK = 0, 0
			local usedSlots_AccountBank, totalSlots_AccountBank = 0, 0
			local keystoneFound = false
			local ItemCounts_ACCOUNTBANK = {}
			----------------------------------------------------------------
			-- ПРОВЕРКА
			----------------------------------------------------------------
			if C_Bank and C_Bank.FetchBankLockedReason and C_Bank.FetchBankLockedReason(Enum.BankType.Account) ~= nil then return end -- Банк заблокирован, не обрабатываем
			----------------------------------------------------------------
			-- ACCOUNT BANK
			local Account_bankTabs = {
				-- Enum.BagIndex.Accountbanktab, -- (такого нет? хотя есть в Enum)
				Enum.BagIndex.AccountBankTab_1, -- 12
				Enum.BagIndex.AccountBankTab_2, -- 13
				Enum.BagIndex.AccountBankTab_3, -- 14
				Enum.BagIndex.AccountBankTab_4, -- 15
				Enum.BagIndex.AccountBankTab_5, -- 16
			}
			for _, bagID in next,(Account_bankTabs) do
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
							ItemCounts_ACCOUNTBANK[itemID] = (ItemCounts_ACCOUNTBANK[itemID] or 0) + stack
						end
					end
				end
			end
			----------------------------------------------------------------
			Octo_ToDo_DB_AccountData = Octo_ToDo_DB_AccountData or {}
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME] = Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME]or {}
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank = {}
			----------------------------------------------------------------
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].AccountBank = ItemCounts_ACCOUNTBANK
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].usedSlots_AccountBank = usedSlots_AccountBank and usedSlots_AccountBank > 0 and usedSlots_AccountBank or nil
			Octo_ToDo_DB_AccountData[E.CURRENT_REGION_NAME].totalSlots_AccountBank = totalSlots_AccountBank and totalSlots_AccountBank > 0 and totalSlots_AccountBank or nil
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