local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
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
                        print ("|cFFFF5771"..L["We need more gold"].."|r "..GetCoinTextureString((repairAllCost-money)))
                        if locale ~= "ruRU" then
                            PlaySoundFile("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\sound\\Memes\\WeNeedMoreGold_ENG.ogg", "Master")
                        else
                            PlaySoundFile("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\sound\\Memes\\WeNeedMoreGold_RU.ogg", "Master")
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
                                    -- print("|cFF00A3FFAutoRepair|r|cffFF4C4F -".. costTextureString.."|r")
                                    -- DEFAULT_CHAT_FRAME:AddMessage(AddonTitle .. L["Your items have been repaired using guild bank funds for: "]..costTextureString, 255, 255, 255)
                                end
                            end
                            -- Use own funds
                            if (repairAllCost <= money and not guildRepairedItems) then
                                RepairAllItems(false)
                                -- print("|cFF00A3FFAutoRepair|r|cffFF4C4F -".. costTextureString.."|r")
                                -- DEFAULT_CHAT_FRAME:AddMessage(AddonTitle .. L["Your items have been repaired for: "]..costTextureString, 255, 255, 255)
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