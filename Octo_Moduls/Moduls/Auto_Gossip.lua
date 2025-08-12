local GlobalAddonName, ns = ...
E = _G.OctoEngine
local Octo_EventFrame_Config_Auto_Gossip = CreateFrame("FRAME")
Octo_EventFrame_Config_Auto_Gossip:Hide()
----------------------------------------------------------------
local targetNPCID = nil
local ignoreNPCID = {
	[213837] = true,
	[208831] = true,
	-- [207471] = true, -- wowhead.com/ptr-2/ru/quest=78392
	[223754] = true,
	[143925] = true,
	[212407] = true, -- Enter Delve
	[230495] = true, -- Enter Delve
	[239700] = true, -- Enter Delve
	[246671] = true, -- Enter Delve
	[245822] = true, -- Enter Delve
	[231036] = true, -- Enter Delve
	-- [47502] = true,
	[153993] = true, -- BfA Chromi



	[77789] = true, -- 5000
	[153897] = true, -- 7000
	[177927] = true, -- Кортия главный(воспроизводит долгий диалог)
	[167745] = true, -- KYRIAN (ANIMA)
	[168427] = true, -- KYRIAN (ENTER ARENA)
	[175573] = true, -- KYRIAN (EXIT ARENA)
	[171816] = true, -- KYRIAN (SHMOT ARENA)


	[213627] = true, -- SKIP TWW (DALARAN 70lvl)
	[232498] = true, -- SPAM (taz)
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
	[47616] = true, -- (BFA auto skip alliance) wowhead.com/ru/quest=46728
	[47502] = true,
	[49920] = true,
	[49826] = true,
	[49081] = true, -- (BFA auto skip Horde) wowhead.com/ru/quest=50769
	[53062] = true,
	[54044] = true, -- pokopok
	[53607] = true,
	[53524] = true, -- Korthia research
}


local gossipOptionIDsIGNORE = {
	[50310] = true,
	[48127] = true, -- BfA EXIT FROM Hram Setralis
	[40457] = true, -- yarmarka
	[46761] = true, -- ODIN LEGION
	[53878] = true, -- ZM movie
}

local ignoreICONS = {
	[132060] = true, -- TRADER
	[132058] = true, -- SKILL MASTER
	[136458] = true, -- BIND NEW HOME
	[132057] = true, -- FLY
}
----------------------------------------------------------------
local function HELP_TEXT(i, icon, name)
	return E.func_Gradient(GlobalAddonName)..E.Green_Color.." ("..i..")|r "..E.func_texturefromIcon(icon)..name
end
----------------------------------------------------------------
function Octo_EventFrame_Config_Auto_Gossip:func_Config_Auto_Gossip()
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

		if Octo_ToDo_DB_Vars.DebugGossip then
			print (E.Green_Color..i..")|r ", E.Blue_Color..gossipOptionID.."|r", "flags:", flags, "icon: ", icon, E.func_texturefromIcon(icon), name)
		end





		if option.gossipOptionID and not ignoreICONS[icon] and not gossipOptionIDsIGNORE[option.gossipOptionID] then
			if string.find(option.name:gsub("|", ""), "FF0000") then
				-- print ("break")
				break
			end


			if gossipOptionIDs[option.gossipOptionID] or flags == 1 or string.find(option.name:gsub("|", ""), "0000FF") then
				C_GossipInfo.SelectOption(option.gossipOptionID)
				StaticPopup_OnClick(StaticPopup1Button1:GetParent(), 1)
				DEFAULT_CHAT_FRAME:AddMessage(HELP_TEXT(i, option.icon, option.name))
				break
			else
				if numOptions == 1 then
					C_GossipInfo.SelectOption(option.gossipOptionID)
					StaticPopup_OnClick(StaticPopup1Button1:GetParent(), 1)
					DEFAULT_CHAT_FRAME:AddMessage(HELP_TEXT(i, option.icon, option.name))
				else
					if option.gossipOptionID and
					(E.First_Option[targetNPCID] or
						E.Second_Option[targetNPCID] or
						E.Third_Option[targetNPCID] or
						E.Fourth_Option[targetNPCID]) then
						C_GossipInfo.SelectOption(option.gossipOptionID)
						StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
						DEFAULT_CHAT_FRAME:AddMessage(HELP_TEXT(i, option.icon, option.name))
						break
					end
				end
			end
		end
	end
end
----------------------------------------------------------------
local MyEventsTable = {
	"GOSSIP_SHOW",
}
E.func_RegisterMyEventsToFrames(Octo_EventFrame_Config_Auto_Gossip, MyEventsTable)
function Octo_EventFrame_Config_Auto_Gossip:GOSSIP_SHOW()
	if IsShiftKeyDown() then return end
	if not Octo_ToDo_DB_Vars.Config_Auto_Gossip then return end
	C_Timer.After(.1, function()
			Octo_EventFrame_Config_Auto_Gossip:func_Config_Auto_Gossip()
	end)
end
----------------------------------------------------------------