local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local function HELP_TEXT(i, icon, name)
	return E.func_Gradient("Gossip:")..E.Green_Color.." ("..i..")|r "..E.func_texturefromIcon(icon)..name
end
----------------------------------------------------------------
local targetNPCID = nil
----------------------------------------------------------------
local First_Option_NPC = {
	[244792] = true,
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
local Second_Option_NPC = {
	[201398] = true,
	[56591] = true,
}
local Third_Option_NPC = {
	[56585] = true,
	[191156] = true,
	[188601] = true,
}
local Fourth_Option_NPC = {
	[54959] = true,
}


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
	[217861] = true, -- dornogal (SKIP)
	[241748] = true, -- remix legion
	[38297] = true, -- koren hoodovar (napast)
	[241140] = true, -- LEGION REMIX (SKIP)
}
-- IGNORE 120914
local gossipOptionIDs = {
	[51970] = true, -- KYRIAN
	[53984] = true, -- KYRIAN

	[51951] = true, -- FAE
	[53922] = true, -- FAE

	[52694] = true, -- VENT
	[53870] = true, -- VENT

	[51959] = true, -- NECR
	[54449] = true, -- NECR

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


local nonSecretSubZoneText = {
	["Анклав"] = true,
}


local mapIDs_table = {
	[1670] = true,
}
----------------------------------------------------------------
function EventFrame:func_Config_Auto_Gossip()
	local guid = UnitGUID("TARGET")
	if not guid or UnitGUID("TARGET"):match("%a+") == "Player" then return end
	if guid then
		targetNPCID = tonumber(guid:match("-(%d+)-%x+$"), 10)
		if ignoreNPCID[targetNPCID] then return end
	end
	local info = C_GossipInfo.GetOptions()
	local numOptions = #info
	local SubZoneText = GetSubZoneText()
	local mapID = MapUtil.GetDisplayableMapForPlayer()
	-- for i = 1, math.min(numOptions, 4) do
	for i = 1, numOptions do
		local option = info[i]
		local gossipOptionID = option.gossipOptionID
		local name = option.name
		local icon = option.icon
		local flags = option.flags
		local unitname = UnitName("TARGET")
		if Octo_DevTool_DB and Octo_DevTool_DB.DebugGossip then
			DEFAULT_CHAT_FRAME:AddMessage(E.Green_Color..i..")|r ", E.Blue_Color..gossipOptionID.."|r", "flags:", flags, "icon: ", icon, E.func_texturefromIcon(icon), name)
		end
		-- print (option.gossipOptionID)
		if option.gossipOptionID and not ignoreICONS[icon] and not gossipOptionIDsIGNORE[option.gossipOptionID] then
			if string.find(option.name:gsub("|", ""), "FF0000") then
				break
			end
			-- if nonSecretSubZoneText[SubZoneText] then
			if gossipOptionIDs[option.gossipOptionID] or flags == 1 or string.find(option.name:gsub("|", ""), "0000FF") then
				C_GossipInfo.SelectOption(option.gossipOptionID)
				StaticPopup_OnClick(StaticPopup1Button1:GetParent(), 1)
				DEFAULT_CHAT_FRAME:AddMessage(HELP_TEXT(i, option.icon, option.name))
				break
			elseif mapIDs_table[mapID] then
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
					if (First_Option_NPC[targetNPCID] or
						Second_Option_NPC[targetNPCID] or
						Third_Option_NPC[targetNPCID] or
						Fourth_Option_NPC[targetNPCID]) then
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
	"ADDON_LOADED",
	"GOSSIP_SHOW",
}
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
end
function EventFrame:GOSSIP_SHOW()
	if IsShiftKeyDown() then return end
	if not EventFrame.savedVars.Config_Auto_Gossip then return end
	C_Timer.After(.1, function()
			EventFrame:func_Config_Auto_Gossip()
	end)
end
----------------------------------------------------------------