local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local function func_ResetsearchFilter(frame)
	E.searchFilter = nil
	if frame.Octo_SearchBox then
		frame.Octo_SearchBox:SetText("")
	end
	E.func_UPDATE_MAINFRAME(frame)
end

local function ApplySearchFilter(frame, searchText)
	if not frame or not frame.ViewLeft then return end
	searchText = searchText and searchText:lower():trim() or ""
	local dataProvider = frame.ViewLeft:GetDataProvider()
	if not dataProvider then return end
	if searchText == "" then
		func_ResetsearchFilter(frame)
		return
	end
	E.searchFilter = searchText
	E.func_UPDATE_MAINFRAME(frame)
end



function E.Octo_SearchBox_OnShow(frame)
	if E.PROFTBL then
		local Border_r = E.PROFTBL.ConfigColor_MAIN_Border_r or 0
		local Border_g = E.PROFTBL.ConfigColor_MAIN_Border_g or 0
		local Border_b = E.PROFTBL.ConfigColor_MAIN_Border_b or 0
		local Border_a = E.PROFTBL.ConfigColor_MAIN_Border_a or 1
		frame.Octo_SearchBox.Border:SetColorTexture(Border_r, Border_g, Border_b, Border_a)
	end
	frame.NewSettingsButton:SetChecked(Octo_Todo_DB_Profiles.KEYS.isSettingsEnabled or false)
end

function E.func_CreateSearchBox(frame)
	if not frame then return end
	frame.Octo_SearchBox = CreateFrame("EditBox", "Octo_SearchBox", frame, "SearchBoxTemplate") -- ,OctoBackdropTemplate
	frame.NewSettingsButton = CreateFrame("CheckButton", "NewSettingsButton", frame, "UICheckButtonTemplate")
	----------------------------------------------------------------
	frame.Octo_SearchBox.Border = frame.Octo_SearchBox:CreateTexture(nil, "BACKGROUND")
	frame.Octo_SearchBox.Border:SetColorTexture(0, 0, 0, 1)
	frame.Octo_SearchBox.Border:SetPoint("TOPLEFT", frame.Octo_SearchBox, "TOPLEFT", -5, 0)
	frame.Octo_SearchBox.Border:SetPoint("BOTTOMRIGHT", frame.Octo_SearchBox, "BOTTOMRIGHT", 0, 0)
	frame.Octo_SearchBox.Border:SetDrawLayer("BACKGROUND", -1)
	frame.Octo_SearchBox.Background = frame.Octo_SearchBox:CreateTexture(nil, "BACKGROUND")
	frame.Octo_SearchBox.Background:SetColorTexture(0.15, 0.15, 0.15, 0.8)
	frame.Octo_SearchBox.Background:SetPoint("TOPLEFT", frame.Octo_SearchBox, "TOPLEFT", -4, -1)
	frame.Octo_SearchBox.Background:SetPoint("BOTTOMRIGHT", frame.Octo_SearchBox, "BOTTOMRIGHT", -1, 1)
	frame.Octo_SearchBox:SetPoint("TOPLEFT", E.INDENT_TEXT + 30, -E.HEADER_TEXT_OFFSET)
	-- frame.Octo_SearchBox:SetSize(E.MIN_COLUMN_WIDTH_LEFT - E.INDENT_TEXT - 40, E.GLOBAL_LINE_HEIGHT/2)
	-- frame.Octo_SearchBox:SetSize(20, 20)

	frame.Octo_SearchBox:SetAutoFocus(false)
	frame.Octo_SearchBox:SetFontObject(OctoFont11)
	frame.Octo_SearchBox:SetText("")
	frame.Octo_SearchBox.Left:Hide()
	frame.Octo_SearchBox.Middle:Hide()
	frame.Octo_SearchBox.Right:Hide()
	frame.Octo_SearchBox:HookScript("OnTextChanged", function(self)
			ApplySearchFilter(frame, self:GetText())
	end)
	frame.NewSettingsButton:SetPoint("RIGHT", frame.Octo_SearchBox, "LEFT", -9, 0)
	frame.NewSettingsButton:SetSize(20, 20)
	frame.NewSettingsButton:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	frame.NewSettingsButton:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	frame.NewSettingsButton:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	frame.NewSettingsButton:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	frame.NewSettingsButton:SetScript("OnClick", function(self)
			local checked = self:GetChecked()
			Octo_Todo_DB_Profiles.KEYS.isSettingsEnabled = checked
			-- E.func_UPDATE_MAINFRAME(frame)
			E.func_MAIN_CreateDataProvider(frame)
	end)
	frame.NewSettingsButton:SetChecked(Octo_Todo_DB_Profiles.KEYS.isSettingsEnabled or false)
	frame.NewSettingsButton:SetScript("OnShow", function(self)
		E.Octo_SearchBox_OnShow(frame)
	end)
	local tooltip = {}
	tooltip[#tooltip + 1] = {L["Settings mode"]}
	frame.NewSettingsButton.tooltip = tooltip
	frame.NewSettingsButton:SetScript("OnEnter", function()
			E.SafeTooltipShow(frame.NewSettingsButton, {"RIGHT", "LEFT"})
	end)
end


function E.PassSearchFilter(TextLeft, searchText)
	if not searchText or searchText == "" then
		return true
	end
	local text = type(TextLeft) == "function"
	and TextLeft()
	or tostring(TextLeft or "")
	return text:lower():find(searchText:lower(), 1, true) ~= nil
end