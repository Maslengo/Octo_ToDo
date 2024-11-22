local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Auto_Gossip
local targetNPCID = nil
local First_Option = {
	[226775] = true,
	-- [110034] = true,
	-- [110035] = true,
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
local ignoreNPCID = {
	[213837] = true,
	[208831] = true,
}
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDo_DB_Vars.config.Auto_Gossip then
			if not Octo_AUTO_GOSSIP then
				Octo_AUTO_GOSSIP = CreateFrame("Frame", GlobalAddonName.."Auto_Gossip"..E.Octo_Func.GenerateUniqueID())
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
						-- if numQuests1 > 0 or numQuests2 > 0 then
						-- 	return
						-- end
						local GetActiveQuests = C_GossipInfo.GetActiveQuests() or 0
						if not IsShiftKeyDown() and GetActiveQuests == 0 then
							local info = C_GossipInfo.GetOptions()

							for i, v in pairs(info) do
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
								if icon then

										-- for z, x in pairs (E.Octo_Table.OctoTable_Gossip) do
										-- 	if v.name:find(z) then
										-- 		print ("PIZDA ".."|cffFF0000"..z.."|r", gossipOptionID)
										-- 	end
										-- 	C_GossipInfo.SelectOption(gossipOptionID)
										-- 	StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
										-- 	ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." ("..i..")|r "..E.Octo_Func.func_texturefromIcon(icon)..v.name)
										-- end






									if #info == 1 then
										C_GossipInfo.SelectOption(gossipOptionID)
										StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
										ChatFrame1:AddMessage(targetNPCID.. E.Octo_Func.func_Gradient(" Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." ("..i..")|r "..E.Octo_Func.func_texturefromIcon(icon)..name)

									else

										-- else
											if guid then
												if First_Option[targetNPCID] and i == 1 then
													C_GossipInfo.SelectOption(gossipOptionID)
													StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
													ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." ("..i..")|r "..E.Octo_Func.func_texturefromIcon(icon)..name)
												elseif Second_Option[targetNPCID] and i == 2 then
													C_GossipInfo.SelectOption(gossipOptionID)
													StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
													ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." ("..i..")|r "..E.Octo_Func.func_texturefromIcon(icon)..name)
												elseif Third_Option[targetNPCID] and i == 3 then
													C_GossipInfo.SelectOption(gossipOptionID)
													StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
													ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." ("..i..")|r "..E.Octo_Func.func_texturefromIcon(icon)..name)
												elseif Fourth_Option[targetNPCID] and i == 4 then
													C_GossipInfo.SelectOption(gossipOptionID)
													StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
													ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.." ("..i..")|r "..E.Octo_Func.func_texturefromIcon(icon)..name)
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