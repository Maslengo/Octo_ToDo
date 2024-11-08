local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Auto_Gossip
local targetNPCID = nil
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDo_DB_Vars.config.AutoGossip then
			if not Octo_AUTO_GOSSIP then
				Octo_AUTO_GOSSIP = CreateFrame("Frame", GlobalAddonName.."Auto_Gossip"..E.Octo_Func.GenerateUniqueID())
				Octo_AUTO_GOSSIP:Hide()
			end
			Octo_AUTO_GOSSIP:RegisterEvent("GOSSIP_SHOW")
			Octo_AUTO_GOSSIP:HookScript("OnEvent", function(self, event, ...)
					if Octo_ToDo_DB_Vars.config.AutoGossip and event == "GOSSIP_SHOW" then
						local numQuests1 = C_GossipInfo.GetNumActiveQuests()
						local numQuests2 = C_GossipInfo.GetNumAvailableQuests()
						if numQuests1 > 0 or numQuests2 > 0 then
							return
						end
						local UnitID = "TARGET"
						local guid = UnitGUID(UnitID)
						local First_Option = {
							[226775] = true,
							[110034] = true,
							[110035] = true,
							[210718] = true,
							[207779] = true,
							[168432] = true,
							[149626] = true,
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
							[200172] = true,
							[200171] = true,
							[200170] = true,
							[199198] = true,
							[56592] = true,
							[188246] = true,
							[206941] = true,
						}
						local Second_Option = {
							[201398] = true,
							[56591] = true,
						}
						local Third_Option = {
							[56585] = true,
							[191156] = true,
							[188601] = true,
						}
						local Fourth_Option = {
							[54959] = true,
						}
						if not IsShiftKeyDown() then
							local info = C_GossipInfo.GetOptions()
							if guid and UnitGUID(UnitID):match("%a+") ~= "Player" and not IsShiftKeyDown() then
								targetNPCID = tonumber(UnitGUID(UnitID):match("-(%d+)-%x+$"), 10)
									if tonumber(targetNPCID) == 208831 then
										return
									end
							end
							for i, v in pairs(info) do
								if v.icon then
									if #info == 1 then
										C_GossipInfo.SelectOption(v.gossipOptionID)
										StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
										ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." ("..i..")|r "..E.Octo_Func.func_texturefromIcon(v.icon)..v.name)
									else
										if
											v.name:find("Пропустить разговор") or
											v.name:find("получить печать") or
											v.name:find("Попробовать") or
											v.name:find("Кинуук") or
											v.name:find("Нужно добавить") or
											v.name:find("taste") or
											v.name:find("Задание") or
											v.name:find("сказать") or
											v.name:find("Пропустить") or
											v.name:find("Указать на Ральфа мистеру Солнечноцветику") or
											v.name:find("Можешь снова активировать этого голиафа?") or
											v.name:find("Начать испытание") or
											v.name:find("Я готов") or
											v.name:find("Я готова") or
											v.name:find("У меня потерялся ключ") or
											v.name:find("Эти цветы - от Киригосы") or
											v.name:find("Напасть") or
											v.name:find("Телепорт к Ночному Шпилю") or
											v.name:find("Телепорт к Купели Ночи") or
											v.name:find("cff0000FF") or
											v.name:find("Мур'далаки") or
											v.name:find("Гнусное отродье элекка") or
											v.name:find("Гелбин Меггакрут") or
											v.name:find("Круг Кенария") or
											v.name:find("Татай") or
											v.name:find("Щелкозуб") or
											v.name:find("Род синих драконов") or
											v.name:find("Акерус") or
											v.name:find("Талак") or
											v.name:find("Верховный друид") or
											v.name:find("Резервуар Кривого Клыка") or
											v.name:find("Калисса Харрингтон") or
											v.name:find("Острый коготь") or
											v.name:find("Королева Миа Седогрив") or
											v.name:find("Тиффин Эллериан Ринн") or
											v.name:find("Тенеброн, Весперон и Шадрон") or
											v.name:find("Норганнон") or
											v.name:find("Нобундо") or
											v.name:find("К'ареш") or
											v.name:find("Сайаад") or
											v.name:find("Терон Кровожад") or
											v.name:find("Командир") or
											v.name:find("Холия Солнечный щит.")
										then
											C_GossipInfo.SelectOption(v.gossipOptionID)
											StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
											ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." ("..i..")|r "..E.Octo_Func.func_texturefromIcon(v.icon)..v.name)
										else
											if guid then
												if First_Option[targetNPCID] and i == 1 then
													C_GossipInfo.SelectOption(v.gossipOptionID)
													StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
													ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." ("..i..")|r "..E.Octo_Func.func_texturefromIcon(v.icon)..v.name)
												elseif Second_Option[targetNPCID] and i == 2 then
													C_GossipInfo.SelectOption(v.gossipOptionID)
													StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
													ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." ("..i..")|r "..E.Octo_Func.func_texturefromIcon(v.icon)..v.name)
												elseif Third_Option[targetNPCID] and i == 3 then
													C_GossipInfo.SelectOption(v.gossipOptionID)
													StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
													ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." ("..i..")|r "..E.Octo_Func.func_texturefromIcon(v.icon)..v.name)
												elseif Fourth_Option[targetNPCID] and i == 4 then
													C_GossipInfo.SelectOption(v.gossipOptionID)
													StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
													ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." ("..i..")|r "..E.Octo_Func.func_texturefromIcon(v.icon)..v.name)
												end
											end
										end
									end
								end
							end
						end
					end
			end)
		end
end)