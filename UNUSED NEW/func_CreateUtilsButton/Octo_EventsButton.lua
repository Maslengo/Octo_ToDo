
function EventFrame:Octo_EventsButton(frame)
	local function func_onEnter()
		wipe(E.Holiday)
		E.Collect_All_Holiday()
		local tooltip = {}
		local curdatetable = date("*t")
		local curdate = FormatShortDate(curdatetable.day, curdatetable.month, curdatetable.year)
		tooltip[#tooltip+1] = {E.classColorHexCurrent..L["Current Date"].."|r", E.classColorHexCurrent..curdate.."|r"}
		local sorted = {}
		for k in pairs(E.Holiday) do
			table.insert(sorted, k)
		end
		table.sort(sorted, function(a, b)
			return E.Holiday[a].priority < E.Holiday[b].priority
		end)
		for _, eventKey in ipairs(sorted) do
			local v = E.Holiday[eventKey]
			local titleText = E.func_texturefromIconEVENT(v.iconTexture)
			local timeText = v.startTime.." - "..v.endTime
			-- local name = v.title
			local name = E.func_EventName(v.eventID)
			if v.Active then
				titleText = titleText..E.White_Color..name.."|r"..E.Green_Color.." ("..v.ENDS..")|r"
				timeText = E.White_Color..timeText.."|r"
			else
				titleText = titleText..E.Gray_Color..name.."|r"
				timeText = E.Gray_Color..timeText.."|r"
			end
			if E.Config_DebugID_ALL then
				titleText = titleText..E.Gray_Color.." id:"..v.eventID.."|r"
			end
			tooltip[#tooltip+1] = {titleText, timeText}
		end
		return tooltip
	end
	local function func_onClick()
		local parent = self:GetParent()
		if parent then
			parent:Hide()
		end
		if opde then opde(E.Holiday) end
	end
	CreateUtilButton(
		"EventsButton",
		frame,
		"Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Arrow6.tga",
		func_onEnter,
		func_onClick
	)
end