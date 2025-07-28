local GlobalAddonName, ns = ...
E = _G.OctoEngine
local Octo_EventFrame_Auto_Gossip = CreateFrame("FRAME")
Octo_EventFrame_Auto_Gossip:Hide()
----------------------------------------------------------------

local targetNPCID = nil
local ignoreNPCID = {
	[213837] = true,
	[208831] = true,
	-- [207471] = true, -- wowhead.com/ptr-2/ru/quest=78392
	[223754] = true,
	[143925] = true,
}
-- IGNORE 120914
local gossipOptionIDs = {
	[51187] = true, -- (Задание)
	[53363] = true,

	[122416] = true, -- wowhead.com/ptr-2/ru/quest=82216
	[122431] = true,
	[122427] = true,
	[122423] = true,


	[122714] = true, -- wowhead.com/ptr-2/ru/quest=80049
	[122718] = true,
	[122722] = true,
	[122720] = true,
	[122712] = true,

	[120319] = true, -- Не бойся wowhead.com/ptr-2/ru/quest=78631



	[125466] = true, -- ВЫЛАЗКА АВТО
}




local ignoreICONS = {
	[132060] = true, -- TRADER
	[132058] = true, -- SKILL MASTER
}

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------


function Octo_EventFrame_Auto_Gossip:Auto_Gossip()
	local guid = UnitGUID("TARGET")
	-- if not guid or UnitGUID("TARGET"):match("%a+") == "Player" then return end
	if guid then
		targetNPCID = tonumber(guid:match("-(%d+)-%x+$"), 10)
		if ignoreNPCID[targetNPCID] then return end
	end
	local info = C_GossipInfo.GetOptions()
	local numOptions = #info
	-- for i = 1, math.min(numOptions, 4) do
	for i = 1, numOptions do
		local option = info[i]
		local gossipOptionID = option.gossipOptionID
		local name = option.name
		local icon = option.icon
		local flags = option.flags
		if option.gossipOptionID and not ignoreICONS[icon] then


			print (E.Green_Color..i..")|r ", E.Blue_Color..gossipOptionID.."|r", "flags:", flags, "icon: ", icon, name)





			if gossipOptionIDs[option.gossipOptionID] or flags == 1 or string.find(option.name:gsub("|", ""), "0000FF") then
				C_GossipInfo.SelectOption(option.gossipOptionID)
				StaticPopup_OnClick(StaticPopup1Button1:GetParent(), 1)
				DEFAULT_CHAT_FRAME:AddMessage(E:func_Gradient("Auto Gossip Select")..E.Green_Color.." ("..i..")|r "..E:func_texturefromIcon(option.icon)..option.name)
				break
			else
				if numOptions == 1 then
					C_GossipInfo.SelectOption(option.gossipOptionID)
					StaticPopup_OnClick(StaticPopup1Button1:GetParent(), 1)
					DEFAULT_CHAT_FRAME:AddMessage(E:func_Gradient("Auto Gossip Select")..E.Green_Color.." ("..i..")|r "..E:func_texturefromIcon(option.icon)..option.name)
				else
					if option.gossipOptionID and
						(E.First_Option[targetNPCID] or
						E.Second_Option[targetNPCID] or
						E.Third_Option[targetNPCID] or
						E.Fourth_Option[targetNPCID])
						then


					-- if option.gossipOptionID and E[({"First", "Second", "Third", "Fourth"})[i].."_Option"][targetNPCID] then
						C_GossipInfo.SelectOption(option.gossipOptionID)
						StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
						DEFAULT_CHAT_FRAME:AddMessage(E:func_Gradient("Auto Gossip Select")..E.Green_Color.." ("..i..")|r "..E:func_texturefromIcon(option.icon)..option.name)
						break
					end
				end
			end
		end
	end
end

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local MyEventsTable = {
	"GOSSIP_SHOW",
	-- "PLAYER_INTERACTION_MANAGER_FRAME_SHOW",
}
E:func_RegisterMyEventsToFrames(Octo_EventFrame_Auto_Gossip, MyEventsTable)
function Octo_EventFrame_Auto_Gossip:GOSSIP_SHOW()
	if IsShiftKeyDown() then return end
	if not Octo_ToDo_DB_Vars.Auto_Gossip then return end
	C_Timer.After(.1, function()
		Octo_EventFrame_Auto_Gossip:Auto_Gossip()
	end)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

