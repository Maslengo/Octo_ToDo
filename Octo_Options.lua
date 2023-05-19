local AddonName, L = ...
local config = CreateFrame("FRAME", AddonName.."config")
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

	-- BUTTON 1 TEST
	self.button1 = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
	self.button1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -16)
	self.button1:SetText(APPLY)
	self.button1:SetScript("OnClick", function(btn)
		print ("qwe")
	end)
	self.button1:SetText("qew")








end)

-- ADD CATEGORY
local category, layout = Settings.RegisterCanvasLayoutCategory(config, AddonName)
category.ID = AddonName
Settings.RegisterAddOnCategory(category)