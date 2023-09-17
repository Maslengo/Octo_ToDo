local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
--USABLEITEMS
tinsert(E.Octo_Globals.modules, function()
        if Octo_ToDoVars.config.UsableItems then
            local UnitLevel = UnitLevel("PLAYER")
            local classFilename = select(2, UnitClass("PLAYER"))
            -- https://www.wowhead.com/ru/item=205151/%D0%B8%D0%B7%D0%B2%D0%B8%D0%BB%D0%B8%D1%81%D0%BA#comments
            -- https://www.wowhead.com/ru/item=206009/ https://www.wowhead.com/ru/item=206010/ https://www.wowhead.com/ru/item=206014/
            -- https://www.wowhead.com/ru/item=206014/ https://www.wowhead.com/ru/item=206011/ https://www.wowhead.com/ru/item=206015/
            -- https://www.wowhead.com/ru/item=206015/ https://www.wowhead.com/ru/item=206012/ https://www.wowhead.com/ru/item=206016/
            -- https://www.wowhead.com/ru/item=206016/ https://www.wowhead.com/ru/item=206013/ https://www.wowhead.com/ru/item=206017/
            -- https://www.wowhead.com/ru/item=206017/ https://www.wowhead.com/ru/item=206021/ https://www.wowhead.com/ru/item=205151/
            if classFilename == "WARRIOR" or classFilename == "PALADIN" or classFilename == "DEATHKNIGHT" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_70, E.Octo_Table.white_list_Krokuun_Plate)
            end
            if classFilename == "HUNTER" or classFilename == "EVOKER" or classFilename == "SHAMAN" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_70, E.Octo_Table.white_list_Krokuun_ChainMail)
            end
            if classFilename == "DRUID" or classFilename == "MONK" or classFilename == "DEMONHUNTER" or classFilename == "ROGUE" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_70, E.Octo_Table.white_list_Krokuun_Leather)
            end
            if classFilename == "PRIEST" or classFilename == "MAGE" or classFilename == "WARLOCK" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_70, E.Octo_Table.white_list_Krokuun_Cloth)
            end
            if UnitLevel == 70 then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_70)
            end
            --ТОКЕНЫ
            if classFilename == "WARRIOR" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_WARRIOR)
            end
            if classFilename == "PALADIN" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_PALADIN)
            end
            if classFilename == "HUNTER" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_HUNTER)
            end
            if classFilename == "ROGUE" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_ROGUE)
            end
            if classFilename == "PRIEST" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_PRIEST)
            end
            if classFilename == "DEATHKNIGHT" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_DEATHKNIGHT)
            end
            if classFilename == "SHAMAN" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_SHAMAN)
            end
            if classFilename == "MAGE" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_MAGE)
            end
            if classFilename == "WARLOCK" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_WARLOCK)
            end
            if classFilename == "MONK" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_MONK)
            end
            if classFilename == "DRUID" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_DRUID)
            end
            if classFilename == "DEMONHUNTER" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_DEMONHUNTER)
            end
            if classFilename == "EVOKER" then
                E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_EVOKER)
            end
            local function UsableItems_Frame_OnEnter(self)
                GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 10)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(E.Octo_Func.func_itemName(self.itemid))
                GameTooltip:Show()
            end
            local function UsableItems_Frame_OnLeave(self)
                GameTooltip:ClearLines()
                GameTooltip:Hide()
            end
            --local function UsableItems_Frame(itemID)
            if not UsableItems_Frame then
                UsableItems_Frame = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "SecureActionButtonTemplate, BackDropTemplate")
                UsableItems_Frame:Hide()
            end
            UsableItems_Frame:Hide()
            UsableItems_Frame:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
            UsableItems_Frame:SetPoint("TOPLEFT", 0, 0)
            UsableItems_Frame:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 4})
            UsableItems_Frame:SetBackdropBorderColor(1, 1, 1, 1)
            UsableItems_Frame:HookScript("OnEnter", UsableItems_Frame_OnEnter)
            UsableItems_Frame:HookScript("OnLeave", UsableItems_Frame_OnLeave)
            UsableItems_Frame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
            UsableItems_Frame:SetAttribute("type", "macro")
            local texture = UsableItems_Frame:CreateTexture(nil, "BACKGROUND")
            UsableItems_Frame.icon = texture
            texture:SetAllPoints(UsableItems_Frame)
            texture:SetTexture(413587)
            --end
            local function UsableItemFrame_OnLoad()
                if not EventFrame then
                    EventFrame = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent)
                    EventFrame:Hide()
                end
                if not InCombatLockdown() then
                    EventFrame:Hide()
                    EventFrame:RegisterEvent("PLAYER_LOGIN")
                    EventFrame:RegisterEvent("BAG_UPDATE")
                    EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
                    EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
                    EventFrame:SetScript("OnEvent", UsableItemFrame_OnEvent)
                end
            end
            function UsableItemFrame_OnEvent(self, event)
                --local isGroup = IsInGroup(INSTANCE)
                if event == "BAG_UPDATE" or event == "PLAYER_REGEN_ENABLED" and not InCombatLockdown() --[[and isGroup == false]] then
                    UsableItemFrame()
                elseif event == "PLAYER_REGEN_DISABLED" then
                    if UsableItems_Frame:IsShown() then
                        UsableItems_Frame:Hide()
                    end
                end
            end
            function UsableItemFrame()
                if not InCombatLockdown() and UsableItems_Frame then
                    local testtable = {}
                    for myBags = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
                        for bagSlots = 1, C_Container.GetContainerNumSlots(myBags) do
                            CurrentItemLink = C_Container.GetContainerItemLink(myBags, bagSlots)
                            if CurrentItemLink then
                                local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(CurrentItemLink)
                                local itemInfo = C_Container.GetContainerItemInfo(myBags, bagSlots)
                                if (classID == 15 and (subclassID == 2 or subclassID == 5 )) -- 2ПЕТЫ 5маунты
                                or (classID == 8 and subclassID)
                                -- or (classID == 15 and (subclassID == 4) and itemQuality == 4 and expacID ~= 7) -- 4сундуки эпик
                                -- or (classID == 9) -- РЕЦЕПТЫ
                                then
                                    local itemID = tonumber(strmatch(itemLink, "item:(%d+):"))
                                    local testtable = {{itemid = itemID, count = 1}, }
                                    E.Octo_Func.TableConcat (E.Octo_Table.white_list_ALL, testtable)
                                end
                            end
                        end
                    end
                    for _, v in pairs(E.Octo_Table.white_list_ALL) do
                        if GetItemCount(v.itemid) >= v.count then
                            UsableItems_Frame:Show()
                            UsableItems_Frame:SetAttribute("macrotext", "/use item:"..v.itemid)
                            UsableItems_Frame.icon:SetTexture(select(10, GetItemInfo(v.itemid)) or 413587)
                            local itemQuality = (select(3, GetItemInfo(v.itemid)) or 0)
                            local r, g, b = GetItemQualityColor(itemQuality)
                            UsableItems_Frame:SetBackdropBorderColor(r, g, b, 1)
                            -- local color = CreateColor(r, g, b, 1)
                            -- local name = color:WrapTextInColorCode(itemName)
                            UsableItems_Frame.itemid = v.itemid
                            break
                        elseif GetItemCount(v.itemid) <= (v.count-1) and UsableItems_Frame:IsShown() then
                            UsableItems_Frame:Hide()
                            UsableItems_Frame.icon:SetTexture(413587)
                        end
                    end
                end
            end
            E.UsableItems_Frame = UsableItems_Frame
            E.UsableItemFrame_OnLoad = UsableItemFrame_OnLoad
            E.UsableItemFrame = UsableItemFrame
            UsableItemFrame_OnLoad()
        end
end)