local GlobalAddonName, E = ...
local popupText = "%s Link\nCTRL-C to copy"
local function ShowUrlPopup(header, url)
	StaticPopup_Show("WowheadQuickLinkUrl", header, _, url)
end
local function CreateUrl(dataSources, strategies)
	for _, strategy in pairs(strategies) do
		local header, url = strategy(dataSources)
		if header and url then
			ShowUrlPopup(header, url)
			return
		end
	end
end
local function GetDataSources()
	local focus = GetMouseFocus()
	local tooltip = GameTooltip
	return {focus = focus, tooltip = tooltip}
end
function RunWowheadQuickLink()
	CreateUrl(GetDataSources(), E.Octo_Globals.strategies)
end
function RunAlternativeQuickLink()
	CreateUrl(GetDataSources(), E.Octo_Globals.altStrategies)
end
StaticPopupDialogs["WowheadQuickLinkUrl"] = {
	text = popupText,
	button1 = "Close",
	OnShow = function(self, data)
		local function HidePopup(self) self:GetParent():Hide() end
		self.editBox:SetScript("OnEscapePressed", HidePopup)
		self.editBox:SetScript("OnEnterPressed", HidePopup)
		self.editBox:SetScript("OnKeyUp", function(self, key)
				if IsControlKeyDown() and key == "C" then
					HidePopup(self)
				end
		end)
		self.editBox:SetMaxLetters(0)
		self.editBox:SetText(data)
		self.editBox:HighlightText()
	end,
	hasEditBox = true,
	editBoxWidth = 240,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3
}

