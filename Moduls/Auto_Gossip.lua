local GlobalAddonName, E = ... 
----------------------------------------------------------------------------------------------------------------------------------
-- Auto_Gossip
local targetNPCID = nil
local ignoreNPCID = {
	[213837] = true,
	[208831] = true,
}
local function govno_function(name)
	for _, v in next, (E.OctoTable_Gossip) do
		if name:find(v) then
			return true
		end
	end
	return false
end
tinsert(E.Modules, function()
		if Octo_ToDo_DB_Vars.config.Auto_Gossip then
			if not Octo_AUTO_GOSSIP then
				Octo_AUTO_GOSSIP = CreateFrame("Frame", GlobalAddonName.."Auto_Gossip"..E.func_GenerateUniqueID())
				Octo_AUTO_GOSSIP:Hide()
			end
			Octo_AUTO_GOSSIP:RegisterEvent("GOSSIP_SHOW")
			Octo_AUTO_GOSSIP:HookScript("OnEvent", function(self, event, ...)
					if Octo_ToDo_DB_Vars.config.Auto_Gossip and event == "GOSSIP_SHOW" then
						local UnitID = "TARGET"
						local guid = UnitGUID(UnitID)
						if guid and UnitGUID(UnitID):match("%a+") ~= "Player" and not IsShiftKeyDown() then
							targetNPCID = tonumber(UnitGUID(UnitID):match("-(%d+)-%x+$"), 10)
							if ignoreNPCID[targetNPCID] then
								return
							end
						end
						local numQuests1 = C_GossipInfo.GetNumActiveQuests()
						local numQuests2 = C_GossipInfo.GetNumAvailableQuests()
						if numQuests1 > 0 or numQuests2 > 0 then
							return
						end
						if not IsShiftKeyDown() and guid then
							local info = C_GossipInfo.GetOptions()
							for i, v in next, (info) do
								local gossipOptionID = v.gossipOptionID
								local name = v.name
								local icon = v.icon
								-- local rewards = v.rewards
								-- local status = v.status
								-- local spellID = v.spellID
								-- local flags = v.flags
								-- local overrideIconID = v.overrideIconID
								-- local selectOptionWhenOnlyOption = v.selectOptionWhenOnlyOption
								-- local orderIndex = v.orderIndex
								if #info == 1 then
									C_GossipInfo.SelectOption(gossipOptionID)
									StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
									ChatFrame1:AddMessage(E.func_Gradient("Auto Gossip Select")..E.Green_Color.." ("..i..")|r "..E.func_texturefromIcon(icon)..name)
								else
									if govno_function(v.name) then
										C_GossipInfo.SelectOption(gossipOptionID)
										StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
										ChatFrame1:AddMessage(E.func_Gradient("Auto Gossip Select")..E.Green_Color.." ("..i..")|r "..E.func_texturefromIcon(icon)..v.name)
									else
										if E.First_Option[targetNPCID] and i == 1 then
											C_GossipInfo.SelectOption(gossipOptionID)
											StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
											ChatFrame1:AddMessage(E.func_Gradient("Auto Gossip Select")..E.Green_Color.." ("..i..")|r "..E.func_texturefromIcon(icon)..name)
										elseif E.Second_Option[targetNPCID] and i == 2 then
											C_GossipInfo.SelectOption(gossipOptionID)
											StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
											ChatFrame1:AddMessage(E.func_Gradient("Auto Gossip Select")..E.Green_Color.." ("..i..")|r "..E.func_texturefromIcon(icon)..name)
										elseif E.Third_Option[targetNPCID] and i == 3 then
											C_GossipInfo.SelectOption(gossipOptionID)
											StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
											ChatFrame1:AddMessage(E.func_Gradient("Auto Gossip Select")..E.Green_Color.." ("..i..")|r "..E.func_texturefromIcon(icon)..name)
										elseif E.Fourth_Option[targetNPCID] and i == 4 then
											C_GossipInfo.SelectOption(gossipOptionID)
											StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
											ChatFrame1:AddMessage(E.func_Gradient("Auto Gossip Select")..E.Green_Color.." ("..i..")|r "..E.func_texturefromIcon(icon)..name)
										end
									end
								end
							end
						end
					end
			end)
		end
end)
