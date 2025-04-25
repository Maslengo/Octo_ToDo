local GlobalAddonName, E = ...

-- Auto_Gossip
local targetNPCID = nil
local ignoreNPCID = {
	[213837] = true,
	[208831] = true,
}

tinsert(E.Modules, function()
	if not Octo_ToDo_DB_Vars.Auto_Gossip then return end

	if not Octo_AUTO_GOSSIP then
		Octo_AUTO_GOSSIP = CreateFrame("Frame", GlobalAddonName.."Auto_Gossip"..E.func_GenerateUniqueID())
		Octo_AUTO_GOSSIP:Hide()
	end

	Octo_AUTO_GOSSIP:RegisterEvent("GOSSIP_SHOW")
	Octo_AUTO_GOSSIP:SetScript("OnEvent", function(self, event)
		if not Octo_ToDo_DB_Vars.Auto_Gossip or event ~= "GOSSIP_SHOW" or IsShiftKeyDown() then return end

		local guid = UnitGUID("TARGET")
		if not guid or UnitGUID("TARGET"):match("%a+") == "Player" then return end

		targetNPCID = tonumber(guid:match("-(%d+)-%x+$"), 10)
		if ignoreNPCID[targetNPCID] then return end

		local numQuests1 = C_GossipInfo.GetNumActiveQuests()
		local numQuests2 = C_GossipInfo.GetNumAvailableQuests()
		if numQuests1 > 0 or numQuests2 > 0 then return end

		local info = C_GossipInfo.GetOptions()
		local numOptions = #info

		if numOptions == 1 then
			local option = info[1]
			C_GossipInfo.SelectOption(option.gossipOptionID)
			StaticPopup_OnClick(StaticPopup1Button1:GetParent(), 1)
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Auto Gossip Select")..E.Green_Color.." (1)|r "..E.func_texturefromIcon(option.icon)..option.name)
			return
		end

		for i = 1, math.min(numOptions, 4) do
			local option = info[i]
			if option.gossipOptionID and E[({"First", "Second", "Third", "Fourth"})[i].."_Option"][targetNPCID] then
				C_GossipInfo.SelectOption(option.gossipOptionID)
				StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
				DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Auto Gossip Select")..E.Green_Color.." ("..i..")|r "..E.func_texturefromIcon(option.icon)..option.name)
				break
			end
		end
	end)
end)