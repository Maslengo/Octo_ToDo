local GlobalAddonName, E = ...
----------------------------------------------------------------
E.ItemInfoCache_BANK = E.ItemInfoCache_BANK or {}
local function Collect_Items_BANK()
	if not BankFrame or not BankFrame:IsShown() then return end
	local player = Octo_ToDo_DB_Levels[E.curGUID]
	if not player then return end
	local collectPlayerData = player.PlayerData
	local collectMASLENGO = player.MASLENGO
	if not collectPlayerData or not collectMASLENGO then return end
	local usedSlots_BANK, totalSlots_BANK = 0, 0
	local keystoneFound = false
	local ItemCounts_BANK = {}
	-- Перебираем основные вкладки персонального банка (CharacterBankTab_1 - CharacterBankTab_6)
	-- Это соответствует ячейкам -2 до 11 в Enum.BagIndex
	local bankTabs = {
		-2,  -- Characterbanktab (основной банк?)
		6,   -- CharacterBankTab_1
		7,   -- CharacterBankTab_2
		8,   -- CharacterBankTab_3
		9,   -- CharacterBankTab_4
		10,  -- CharacterBankTab_5
		11,  -- CharacterBankTab_6
	}
	for _, bagID in ipairs(bankTabs) do
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
	-- Банковские сумки (purchased bank bags)
	-- В Retail банковские сумки имеют ID 12-16 (AccountBankTab_1 - AccountBankTab_5)
	for bagID = 12, 16 do
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
	-- collectMASLENGO.Items = collectMASLENGO.Items or {}
	-- collectMASLENGO.Items.Bank = {}
	if BankFrame and BankFrame:IsShown() then
		wipe(collectMASLENGO.Items.Bank or {})
	end
	collectMASLENGO.Items.Bank = ItemCounts_BANK
	collectPlayerData.usedSlots_BANK = usedSlots_BANK
	collectPlayerData.totalSlots_BANK = totalSlots_BANK
	-- opde(Octo_ToDo_DB_Levels[E.curGUID].MASLENGO.Items)
end
----------------------------------------------------------------
function E.Collect_Items_BANK()
	E.func_SpamBlock(Collect_Items_BANK, true, 1)
end