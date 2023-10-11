local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
--StaticPopup1Button1
tinsert(E.Octo_Globals.modules, function()
        if Octo_ToDoVars.config.StaticPopup1Button1 then
            ----------------------------------------------------------------------------------------------------------------------------------
            ----------------------------------------------------------------------------------------------------------------------------------
            local function accept()
                if StaticPopup1Button1 then
                    StaticPopup1Button1:Click()
                end
            end
            function Octo_OnLoad()
                local EventFrame = nil
                if not EventFrame then
                    EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
                end
                EventFrame:RegisterEvent("EQUIP_BIND_CONFIRM")
                EventFrame:RegisterEvent("EQUIP_BIND_REFUNDABLE_CONFIRM")
                -- EventFrame:RegisterEvent("SPELL_CONFIRMATION_PROMPT") --block
                EventFrame:SetScript("OnEvent", function(...)
                        Octo_OnEvent(...)
                end)
            end
            function Octo_OnEvent(self, event, ...)
                if (event == "EQUIP_BIND_CONFIRM" or event == "EQUIP_BIND_REFUNDABLE_CONFIRM") and not InCombatLockdown() then
                    accept()
                end
            end
            Octo_OnLoad()
            -- /run local function accept() StaticPopup1Button1:Click() end
            -- StaticPopupDialogs["BID_AUCTION"].OnShow=accept
            -- StaticPopupDialogs["BUYOUT_AUCTION"].OnShow=accept
        end
end)