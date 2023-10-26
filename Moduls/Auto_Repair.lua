local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
----------------------------------------------------------------------------------------------------------------------------------
--AutoRepair
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.AutoRepair then
			local function OnEvent(self, event)
				if (CanMerchantRepair()) then
					repairAllCost, canRepair = GetRepairAllCost()
					local money = GetMoney()
					local locale = GetLocale()
					if canRepair and repairAllCost > money then
						ChatFrame1:AddMessage(E.Octo_Func.func_Gradient(L["We need more gold"], E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color).." "..GetCoinTextureString((repairAllCost-money)))
						if locale == "ruRU" then
							PlaySoundFile("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\sound\\Memes\\WeNeedMoreGold_RU.ogg", "Master")
						else
							PlaySoundFile("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\sound\\Memes\\WeNeedMoreGold_ENG.ogg", "Master")
						end
						-- If merchant can repair and there is something to repair
					else if (canRepair and repairAllCost > 0) then
							costTextureString = GetCoinTextureString(repairAllCost)
							-- Use Guild Bank
							guildRepairedItems = false
							if (IsInGuild() and CanGuildBankRepair()) then
								-- Checks if guild has enough money
								local amount = GetGuildBankWithdrawMoney()
								local guildBankMoney = GetGuildBankMoney()
								amount = amount == -1 and guildBankMoney or min(amount, guildBankMoney)
								if (amount >= repairAllCost) then
									RepairAllItems(true)
									guildRepairedItems = true
								end
							end
							-- Use own funds
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