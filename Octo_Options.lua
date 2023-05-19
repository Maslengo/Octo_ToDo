local AddonName, E = ...
local config = CreateFrame("FRAME", AddonName.."config")
-- config:RegisterEvent("VARIABLES_LOADED")
config:Hide()

config:SetScript("OnShow", function(self)
	self:SetScript("OnShow", function(self)
		self:SetPoint("TOPLEFT", -12, 8)
	end)
	self:SetPoint("TOPLEFT", -12, 8)





	-- VERSION
	local ver = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	ver:SetPoint("TOPLEFT", 40, 20)
	ver:SetTextColor(.5, .5, .5, 1)
	ver:SetJustifyH("RIGHT")
	ver:SetText(GetAddOnMetadata(AddonName, "Version"))

	-- TITLE
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(AddonName)

	-- BUTTON 1 CVar
	-----------------------------------------------
	self.btn1 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, 0)
	self.btn1:SetChecked(Octo_ToDo_DragonflyVars.config.CVar)
	self.btn1:SetScript("OnClick", function(btn)
		Octo_ToDo_DragonflyVars.config.CVar = btn:GetChecked()
		ReloadUI()
	end)
	self.btn1.text:SetText("|cffFF0000CVar|r")
	-----------------------------------------------
	-- BUTTON 2 InputDelete
	-----------------------------------------------
	self.btn2 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -30)
	self.btn2:SetChecked(Octo_ToDo_DragonflyVars.config.InputDelete)
	self.btn2:SetScript("OnClick", function(btn)
		Octo_ToDo_DragonflyVars.config.InputDelete = btn:GetChecked()
		ReloadUI()
	end)
	self.btn2.text:SetText("|cffFF0000InputDelete|r")
	-----------------------------------------------
	-----------------------------------------------
	-- BUTTON 3 UsableItems
	-----------------------------------------------
	self.btn3 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn3:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -60)
	self.btn3:SetChecked(Octo_ToDo_DragonflyVars.config.UsableItems)
	self.btn3:SetScript("OnClick", function(btn)
		Octo_ToDo_DragonflyVars.config.UsableItems = btn:GetChecked()
		if Octo_ToDo_DragonflyVars.config.UsableItems == false then
			E.UsableItems_Frame:Hide()
		else
			E.TESTFUNC()
		end
	end)
	self.btn3.text:SetText("UsableItems")
	-----------------------------------------------
	-- BUTTON 4 AutoOpen
	-----------------------------------------------
	self.btn4 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn4:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -90)
	self.btn4:SetChecked(Octo_ToDo_DragonflyVars.config.AutoOpen)
	self.btn4:SetScript("OnClick", function(btn)
		Octo_ToDo_DragonflyVars.config.AutoOpen = btn:GetChecked()
	end)
	self.btn4.text:SetText("AutoOpen")
	-----------------------------------------------
	-- BUTTON 5 AutoGossip
	-----------------------------------------------
	self.btn5 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.btn5:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -120)
	self.btn5:SetChecked(Octo_ToDo_DragonflyVars.config.AutoGossip)
	self.btn5:SetScript("OnClick", function(btn)
		Octo_ToDo_DragonflyVars.config.AutoGossip = btn:GetChecked()
	end)
	self.btn5.text:SetText("AutoGossip")
	-----------------------------------------------

end)

-- ADD CATEGORY
local category, layout = Settings.RegisterCanvasLayoutCategory(config, AddonName)
category.ID = AddonName
Settings.RegisterAddOnCategory(category)