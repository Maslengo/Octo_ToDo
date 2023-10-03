local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--AUTO GOSSIP
tinsert(E.Octo_Globals.modules, function()
        if Octo_ToDoVars.config.AutoGossip then
            local ignore_list_NPC = {
                    --[206572] = true,
                }
            if not Octo_AUTO_GOSSIP then
                Octo_AUTO_GOSSIP = CreateFrame("Frame", AddonTitle)
                Octo_AUTO_GOSSIP:Hide()
            end
            Octo_AUTO_GOSSIP:RegisterEvent("GOSSIP_SHOW")
            Octo_AUTO_GOSSIP:SetScript("OnEvent", function(self, event, ...)
                    if Octo_ToDoVars.config.AutoGossip and event == "GOSSIP_SHOW" then
                        --https://wowpedia.fandom.com/wiki/Category:API_namespaces/C_GossipInfo
                        local numQuests1 = C_GossipInfo.GetNumActiveQuests()
                        local numQuests2 = C_GossipInfo.GetNumAvailableQuests()
                        if numQuests1 > 0 or numQuests2 > 0 --[[or InCombatLockdown()]] then
                            return
                        end
                        local UnitID = "TARGET"
                        local guid = UnitGUID(UnitID)
                        local First_Option = {
                            [168432] = true,
                            [149626] = true,
                            [167032] = true,
                            [167298] = true,
                            [167598] = true,
                            [168441] = true,
                            [171589] = true,
                            [171787] = true,
                            [171795] = true,
                            [171821] = true,
                            [184787] = true,
                            [184795] = true,
                            [184796] = true,
                            [185894] = true,
                            [187495] = true,
                            [188868] = true,
                            [189869] = true,
                            [189895] = true,
                            [192722] = true,
                            [193127] = true,
                            [194916] = true,
                            [198927] = true,
                            [199532] = true,
                            [200987] = true,
                            [204185] = true,
                            [36939] = true,
                            [37187] = true,
                            [38995] = true,
                            [4311] = true,
                            [78423] = true,
                            [78556] = true,
                            [78563] = true,
                            [80225] = true,
                            [86775] = true,
                            [91483] = true,
                            [180162] = true,
                            [161509] = true,
                            [203011] = true,
                            [200172] = true, -- test
                            [200171] = true, -- test
                            [200170] = true, -- test
                            [199198] = true, -- test
                        }
                        local Second_Option = {
                            [201398] = true,
                            --[205089] = true,
                        }
                        if guid and UnitGUID(UnitID):match("%a+") ~= "Player" and not IsShiftKeyDown() then
                            local info = C_GossipInfo.GetOptions()
                            local targetNPCID = tonumber(UnitGUID(UnitID):match("-(%d+)-%x+$"), 10)
                            for i, v in ipairs(info) do
                                if
                                v.name == "Выбрать временную линию." or
                                v.name:find("Попробовать") or
                                v.name:find("Кинуук") or
                                v.name:find("Нужно добавить") or
                                v.name:find("taste") or
                                v.name:find("Задание") or
                                v.name:find("сказать") or
                                v.name:find("Пропустить") or
                                v.name:find("Указать на Ральфа мистеру Солнечноцветику.") or
                                v.name:find("Можешь снова активировать этого голиафа?") or
                                v.name:find("Начать испытание") or
                                v.name:find("Я готов.") or
                                v.name:find("Я готова.") or
                                v.name:find("У меня потерялся ключ.") or
                                v.name:find("Эти цветы - от Киригосы.") or
                                v.name:find("Напасть.") or
                                v.name:find("Телепорт к Ночному Шпилю.") or -- Элисанда
                                v.name:find("Телепорт к Купели Ночи") or -- Гул'дан
                                -- v.name:find("Начать копать") or
                                v.name:find("cff0000FF")
                                 --[[and not ignore_list_NPC[targetNPCID] then]] then
                                    C_GossipInfo.SelectOption(v.gossipOptionID)
                                    StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
                                    print (E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.."("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t"..v.name)
                                elseif First_Option[targetNPCID] --[[and not ignore_list_NPC[targetNPCID] then]] then
                                    C_GossipInfo.SelectOption(v.gossipOptionID)
                                    StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
                                    print (E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.."("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t"..v.name)
                                elseif Second_Option[targetNPCID] and i == 2 --[[and not ignore_list_NPC[targetNPCID] then]] then
                                    C_GossipInfo.SelectOption(v.gossipOptionID)
                                    StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
                                    print (E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.."("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t"..v.name)
                                elseif #info == 1 --[[and not ignore_list_NPC[targetNPCID] then]] then
                                    C_GossipInfo.SelectOption(v.gossipOptionID)
                                    StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
                                    print (E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.."("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t"..v.name)
                                end
                            end
                        end
                    end
            end)
        end
end)