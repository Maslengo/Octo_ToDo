local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--LootFrame
tinsert(E.Octo_Globals.modules, function()
        if Octo_ToDoVars.config.LootFrame then
            ----------------------------------------------------------------------------------------------------------------------------------
            ----------------------------------------------------------------------------------------------------------------------------------
            local OctoFrame_EventFrame = nil
            local Octo_Frame_Loot = nil
            local Octo_Frame_RCLootCouncil = nil
            if not OctoFrame_EventFrame then
                OctoFrame_EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
            end
            OctoFrame_EventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
            OctoFrame_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
            OctoFrame_EventFrame:RegisterEvent("ZONE_CHANGED")
            OctoFrame_EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
            if not InCombatLockdown() then
                OctoFrame_EventFrame:SetScript("OnEvent", function(...) Octo_Frame_OnEvent(...) end)
            end
            local normal_difficulty = 14
            local heroic_difficulty = 15
            local mythic_difficulty = 16
            local LFG_difficulty = 17
            -- https://wowpedia.fandom.com/wiki/DifficultyID
            --------------------------------------------------------------------------------
            if not Octo_Frame_Loot then
                Octo_Frame_Loot = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "SecureActionButtonTemplate, BackDropTemplate")
            end
            Octo_Frame_Loot:Hide()
            Octo_Frame_Loot:SetSize(24*E.Octo_Globals.scale, 24*E.Octo_Globals.scale)
            Octo_Frame_Loot:SetPoint("TOPLEFT", 64, 0)
            Octo_Frame_Loot:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
            Octo_Frame_Loot:SetBackdropBorderColor(0, 0, 0, 1)
            Octo_Frame_Loot:RegisterForClicks("LeftButtonUp")
            local texture = Octo_Frame_Loot:CreateTexture(nil, "BACKGROUND")
            Octo_Frame_Loot.icon = texture
            texture:SetAllPoints(Octo_Frame_Loot)
            texture:SetTexture(413587)
            Octo_Frame_Loot:Hide()
            Octo_Frame_Loot:SetScript("OnClick",
                function(_, button)
                    GroupLootHistoryFrame:SetShown(not GroupLootHistoryFrame:IsShown())
            end)
            --if select(5, GetAddOnInfo("RCLootCouncil")) ~= "DISABLED" then
            --------------------------------------------------------------------------------
            if not Octo_Frame_RCLootCouncil then
                Octo_Frame_RCLootCouncil = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "SecureActionButtonTemplate, BackDropTemplate")
            end
            Octo_Frame_RCLootCouncil:Hide()
            Octo_Frame_RCLootCouncil:SetSize(24*E.Octo_Globals.scale, 24*E.Octo_Globals.scale)
            Octo_Frame_RCLootCouncil:SetPoint("TOPLEFT", 128, 0)
            Octo_Frame_RCLootCouncil:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
            Octo_Frame_RCLootCouncil:SetBackdropBorderColor(0, 0, 0, 1)
            Octo_Frame_RCLootCouncil:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
            local texture = Octo_Frame_RCLootCouncil:CreateTexture(nil, "BACKGROUND")
            Octo_Frame_RCLootCouncil.icon = texture
            texture:SetAllPoints(Octo_Frame_RCLootCouncil)
            texture:SetTexture(133785)
            Octo_Frame_RCLootCouncil:Hide()
            Octo_Frame_RCLootCouncil:SetAttribute("type", "macro")
            Octo_Frame_RCLootCouncil:SetAttribute("macrotext", "/rc open")
            --------------------------------------------------------------------------------
            function Octo_Frame_OnEvent(self, event, ...)
                if (event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA") and not InCombatLockdown() then
                    local difficultyID = select(3, GetInstanceInfo()) or "|cffFF0000-|r"
                    if difficultyID == 14 or difficultyID == 15 or difficultyID == 16 or difficultyID == 17 then
                        if E.Octo_Globals.isRCLootCouncil and Octo_Frame_RCLootCouncil then
                            Octo_Frame_RCLootCouncil:Show()
                        end
                        Octo_Frame_Loot:Show()
                    end
                    if (difficultyID ~= 14 and difficultyID ~= 15 and difficultyID ~= 16 and difficultyID ~= 17) then
                        if E.Octo_Globals.isRCLootCouncil and Octo_Frame_RCLootCouncil then
                            Octo_Frame_RCLootCouncil:Hide()
                        end
                        if Octo_Frame_Loot:IsShown() then
                            Octo_Frame_Loot:Hide()
                        end
                    end
                end
            end
            if InCombatLockdown then
                if Octo_Frame_Loot and Octo_Frame_Loot:IsShown() then
                    Octo_Frame_Loot:Hide()
                end
                if Octo_Frame_RCLootCouncil and Octo_Frame_RCLootCouncil:IsShown() then
                    Octo_Frame_RCLootCouncil:Hide()
                end
            end
        end
end)