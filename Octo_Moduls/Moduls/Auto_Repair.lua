local GlobalAddonName, ns = ...
E = _G.OctoEngine



local L = LibStub("AceLocale-3.0"):GetLocale("Octo")

tinsert(E.Modules, function()
	if not Octo_ToDo_DB_Vars.AutoRepair then return end

	local function PlayNoGoldSound()
		local soundFile = E.curLocaleLang == "ruRU" and
			"Interface\\AddOns\\Octo\\Media\\sound\\Memes\\WeNeedMoreGold_RU.ogg" or
			"Interface\\AddOns\\Octo\\Media\\sound\\Memes\\WeNeedMoreGold_ENG.ogg"
		PlaySoundFile(soundFile, "Master")
	end

	local function HandleRepair()
		if not CanMerchantRepair() then return end

		local repairAllCost, canRepair = GetRepairAllCost()
		if not canRepair or repairAllCost <= 0 then return end

		local money = GetMoney()

		-- Недостаточно золота
		if repairAllCost > money then
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient(L["We need more gold"]).." "..C_CurrencyInfo.GetCoinTextureString(repairAllCost - money))
			PlayNoGoldSound()
			return
		end

		-- Попытка починки за счет гильдбанка
		if IsInGuild() and CanGuildBankRepair() then
			local guildMoney = GetGuildBankMoney()
			local withdrawLimit = GetGuildBankWithdrawMoney()

			if withdrawLimit == -1 or withdrawLimit >= repairAllCost then
				if guildMoney >= repairAllCost then
					RepairAllItems(true)
					return
				end
			end
		end

		-- Починка за свои деньги
		if repairAllCost <= money then
			RepairAllItems(false)
		end
	end

	-- Создаем и настраиваем фрейм
	local frame = CreateFrame("Frame")
	frame:SetScript("OnEvent", HandleRepair)
	frame:RegisterEvent("MERCHANT_SHOW")
end)