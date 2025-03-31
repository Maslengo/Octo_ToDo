local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO") 
----------------------------------------------------------------------------------------------------------------------------------
-- Auto_Repair
tinsert(E.Modules, function()
		if OctoToDo_DB_Vars.AutoRepair then
			local function OnEvent(self, event)
				if (CanMerchantRepair()) then
					local repairAllCost, canRepair = GetRepairAllCost()
					local money = GetMoney()
					local locale = GetLocale()
					if canRepair and repairAllCost > money then
						DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient(L["We need more gold"], E.Addon_Left_Color, E.Addon_Right_Color).." "..C_CurrencyInfo.GetCoinTextureString((repairAllCost-money)))
						if locale == "ruRU" then
							PlaySoundFile("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\sound\\Memes\\WeNeedMoreGold_RU.ogg", "Master")
						else
							PlaySoundFile("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\sound\\Memes\\WeNeedMoreGold_ENG.ogg", "Master")
						end
					else if (canRepair and repairAllCost > 0) then
							local guildRepairedItems = false
							if (IsInGuild() and CanGuildBankRepair()) then
								local amount = GetGuildBankWithdrawMoney()
								local guildBankMoney = GetGuildBankMoney()
								amount = amount == -1 and guildBankMoney or min(amount, guildBankMoney)
								if (amount >= repairAllCost) then
									RepairAllItems(true)
									guildRepairedItems = true
								end
							end
							if (repairAllCost <= money and not guildRepairedItems) then
								RepairAllItems(false)
							end
						end
					end
				end
			end
			if not AutoRepairFrame then
				AutoRepairFrame = CreateFrame("Frame")
				AutoRepairFrame:Hide()
			end
			AutoRepairFrame:SetScript("OnEvent", OnEvent)
			AutoRepairFrame:RegisterEvent("MERCHANT_SHOW")
		end
end)