if not OctoToDo_FIRST_MarkOfHonorButton then
	OctoToDo_FIRST_MarkOfHonorButton = CreateFrame("Button", AddonTitle..lib:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
	OctoToDo_FIRST_MarkOfHonorButton:SetSize(E.curHeight, E.curHeight)
	OctoToDo_FIRST_MarkOfHonorButton:SetPoint("TOPLEFT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", E.curHeight, (-E.curHeight)*0)
	OctoToDo_FIRST_MarkOfHonorButton:SetBackdrop({
			edgeFile = edgeFile,
			edgeSize = 1
	})
	OctoToDo_FIRST_MarkOfHonorButton:SetBackdropBorderColor(r, g, b, 0)
	OctoToDo_FIRST_MarkOfHonorButton:SetScript("OnEnter", function(self)
			local i = 0
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(r, g, b, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(" ", " ")
			for k, CharInfo in pairs(Octo_ToDo_DB_Levels) do
				if (CharInfo.ItemsInBag[137642] ~= 0) then
					i = i + 1
					GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(1322720)..CharInfo.ItemsInBag[137642], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
				if CharInfo.ItemsInBag[202196] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(4909720)..CharInfo.ItemsInBag[202196], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
				if CharInfo.ItemsInBag[86547] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(237230)..CharInfo.ItemsInBag[86547], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
				if CharInfo.ItemsInBag[183616] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(133291)..CharInfo.ItemsInBag[183616], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
				if CharInfo.ItemsInBag[166751] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(967526)..CharInfo.ItemsInBag[166751], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
				if CharInfo.ItemsInBag[122457] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(667491)..CharInfo.ItemsInBag[122457], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
				if CharInfo.ItemsInBag[190189] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(519378)..CharInfo.ItemsInBag[190189], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
				if CharInfo.ItemsInBag[204464] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine("$$$"..LibOctopussy:func_texturefromIcon(5009042)..CharInfo.ItemsInBag[204464], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
				if CharInfo.ItemsInBag[201325] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine("$$$"..LibOctopussy:func_texturefromIcon(4644002)..CharInfo.ItemsInBag[201325], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
				if CharInfo.ItemsInBag[12811] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine("$$$"..LibOctopussy:func_texturefromIcon(134122)..CharInfo.ItemsInBag[12811], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
				if CharInfo.ItemsInBag[200652] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine("$$$"..lib:func_itemTexture(200652)..CharInfo.ItemsInBag[200652], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
				if CharInfo.ItemsInBag[122284] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine(E.WOW_Heirloom_Color..TOKEN_FILTER_LABEL.."|r"..LibOctopussy:func_texturefromIcon(1120721)..CharInfo.ItemsInBag[122284], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
			end
			if i == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" ", " ")
			GameTooltip:Show()
	end)
	OctoToDo_FIRST_MarkOfHonorButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(r, g, b, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_FIRST_MarkOfHonorButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(r, g, b, .5)
	end)
	OctoToDo_FIRST_MarkOfHonorButton:SetScript("OnClick", function()
			OctoToDo_FIRST_MainFrame:Hide()
	end)
	local t = OctoToDo_FIRST_MarkOfHonorButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_FIRST_MarkOfHonorButton.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow1.tga")
	t:SetAllPoints(OctoToDo_FIRST_MarkOfHonorButton)
end
if not OctoToDo_FIRST_QuestFeastButton then
	OctoToDo_FIRST_QuestFeastButton = CreateFrame("Button", AddonTitle..lib:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
	OctoToDo_FIRST_QuestFeastButton:SetSize(E.curHeight, E.curHeight)
	OctoToDo_FIRST_QuestFeastButton:SetPoint("TOPLEFT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", E.curHeight, (-E.curHeight)*2)
	OctoToDo_FIRST_QuestFeastButton:SetBackdrop({
			edgeFile = edgeFile,
			edgeSize = 1
	})
	OctoToDo_FIRST_QuestFeastButton:SetBackdropBorderColor(r, g, b, 0)
	OctoToDo_FIRST_QuestFeastButton:SetScript("OnEnter", function(self)
			local i = 0
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(r, g, b, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(" ", " ")
			for k, CharInfo in pairs(Octo_ToDo_DB_Levels) do
				if CharInfo.Octopussy_DF_Weekly_CommunityFeast_count ~= E.DONE and CharInfo.UnitLevel >= 60 then
					i = i +1
					GameTooltip:AddDoubleLine(CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r", CharInfo.Octopussy_DF_Weekly_CommunityFeast_count)
				end
				if CharInfo.ItemsInBag[200652] ~= 0 then
					i = i + 1
					GameTooltip:AddDoubleLine("$$$"..lib:func_itemTexture(200652)..CharInfo.ItemsInBag[200652], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
				end
			end
			if i == 0 then
				GameTooltip:AddLine(E.Green_Color.."All done|r")
			end
			GameTooltip:AddDoubleLine(" ", " ")
			GameTooltip:Show()
	end)
	OctoToDo_FIRST_QuestFeastButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(r, g, b, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_FIRST_QuestFeastButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(r, g, b, .5)
	end)
	OctoToDo_FIRST_QuestFeastButton:SetScript("OnClick", function()
			OctoToDo_FIRST_MainFrame:Hide()
	end)
	local t = OctoToDo_FIRST_QuestFeastButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_FIRST_QuestFeastButton.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow2.tga")
	t:SetAllPoints(OctoToDo_FIRST_QuestFeastButton)
end
if not OctoToDo_FIRST_EventsButton then
	OctoToDo_FIRST_EventsButton = CreateFrame("Button", AddonTitle..lib:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
	OctoToDo_FIRST_EventsButton:SetSize(E.curHeight, E.curHeight)
	OctoToDo_FIRST_EventsButton:SetPoint("TOPLEFT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", E.curHeight, (-E.curHeight)*4)
	OctoToDo_FIRST_EventsButton:SetBackdrop({
			edgeFile = edgeFile,
			edgeSize = 1
	})
	OctoToDo_FIRST_EventsButton:SetBackdropBorderColor(r, g, b, 0)
	OctoToDo_FIRST_EventsButton:SetScript("OnEnter", function(self)
			local countLines = 0
			self:SetBackdropBorderColor(0, 0, 0, 0)
			self.icon:SetVertexColor(r, g, b, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(" ", " ")
			local classFilename = UnitClassBase("PLAYER")
			GameTooltip:AddDoubleLine(classColorHexCurrent..(L["Current Date"]).."|r", classColorHexCurrent..(date("%d/%m/%Y").."|r"))
			GameTooltip:AddDoubleLine(" ", " ")
			for eventID, v in pairs(Octo_ToDo_DB_Other.Holiday.Active) do
				GameTooltip:AddDoubleLine(E.Yellow_Color..Octo_ToDo_DB_Other.Holiday.Active[eventID].title.."|r"..E.Gray_Color.." (id: "..Octo_ToDo_DB_Other.Holiday.Active[eventID].id..")|r", Octo_ToDo_DB_Other.Holiday.Active[eventID].startTime.." - "..Octo_ToDo_DB_Other.Holiday.Active[eventID].endTime)
			end
			if i == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" ", " ")
			GameTooltip:Show()
	end)
	OctoToDo_FIRST_EventsButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(r, g, b, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_FIRST_EventsButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(r, g, b, .5)
	end)
	OctoToDo_FIRST_EventsButton:SetScript("OnClick", function()
			OctoToDo_FIRST_MainFrame:Hide()
	end)
	local t = OctoToDo_FIRST_EventsButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_FIRST_EventsButton.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow6.tga")
	t:SetAllPoints(OctoToDo_FIRST_EventsButton)
end
if not OctoToDo_FIRST_ConsumableButton then
	OctoToDo_FIRST_ConsumableButton = CreateFrame("Button", AddonTitle..lib:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
	OctoToDo_FIRST_ConsumableButton:SetSize(E.curHeight, E.curHeight)
	OctoToDo_FIRST_ConsumableButton:SetPoint("TOPLEFT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", E.curHeight, (-E.curHeight)*6)
	OctoToDo_FIRST_ConsumableButton:SetBackdrop({
			edgeFile = edgeFile,
			edgeSize = 1
	})
	OctoToDo_FIRST_ConsumableButton:SetBackdropBorderColor(r, g, b, 0)
	OctoToDo_FIRST_ConsumableButton:SetScript("OnEnter", function(self)
			local i = 0
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(r, g, b, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(" ", " ")
			for itemID, v in pairs(Octo_ToDo_DB_Other.Items.Consumable) do
				for k, CharInfo in pairs(Octo_ToDo_DB_Levels) do
					if CharInfo.curServer == GetRealmName() then
						if (CharInfo.ItemsInBag[itemID] ~= 0) then
							i = i + 1
							GameTooltip:AddDoubleLine(lib:func_itemTexture(itemID)..lib:func_itemName(itemID).." "..CharInfo.ItemsInBag[itemID], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
					end
				end
			end
			if i == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" ", " ")
			GameTooltip:Show()
	end)
	OctoToDo_FIRST_ConsumableButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(r, g, b, 0)
			self.icon:SetVertexColor(1, 1, 1, 1)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_FIRST_ConsumableButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(r, g, b, .5)
	end)
	OctoToDo_FIRST_ConsumableButton:SetScript("OnClick", function()
			OctoToDo_FIRST_MainFrame:Hide()
	end)
	local t = OctoToDo_FIRST_ConsumableButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_FIRST_ConsumableButton.icon = t
	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow4.tga")
	t:SetAllPoints(OctoToDo_FIRST_ConsumableButton)
end