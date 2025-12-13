
function EventFrame:Octo_AbandonButton(frame)
	local function func_onEnter()
		local tooltip = {}
		local numQuests = E.func_GetQuestLogCount()
		if numQuests > 0 then
			tooltip[#tooltip+1] = {E.classColorHexCurrent..L["Abandon All Quests"].."|r".." ("..numQuests..")"}
			tooltip[#tooltip+1] = {" ", " "}
			local list = {}
			for i = 1, GetNumQuestLogEntries() do
				local info = GetInfo(i)
				if info and info.questID ~= 0 and not info.isHeader and not info.isHidden then
					table.insert(list, info.questID)
				end
			end
			table.sort(list, E.func_SortByDescending)
			for _, questID in ipairs(list) do
				tooltip[#tooltip+1] = {E.func_GetQuestName(questID), E.func_GetQuestStatus(questID)}
			end
		else
			tooltip[#tooltip+1] = {E.classColorHexCurrent..L["No quests"].."|r"}
		end
		return tooltip
	end
	local function f_AbandonQuests()
		local numQuests = E.func_GetQuestLogCount()
		for i = 1, GetNumQuestLogEntries() do
			if numQuests ~= 0 then
				local info = GetInfo(i)
				if info and not info.isHeader and not info.isHidden then
					DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient(L["Abandon: "])..E.func_GetQuestName(info.questID))
					SetSelectedQuest(info.questID)
					SetAbandonQuest()
					AbandonQuest()
				end
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient(L["Total"]).." "..E.COLOR_GREEN..numQuests.."|r")
	end
	-- Create confirmation dialog
	StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
		text = E.classColorHexCurrent..L["Abandon All Quests"].."?|r",
		button1 = YES,
		button2 = NO,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function() C_Timer.After(E.SPAM_TIME, f_AbandonQuests) end,
	}
	local function func_onClick()
		if E.func_GetQuestLogCount() > 0 then
			StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
		end
	end
	CreateUtilButton(
		"AbandonButton",
		frame,
		"Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Arrow72.tga",
		func_onEnter,
		func_onClick
	)
end