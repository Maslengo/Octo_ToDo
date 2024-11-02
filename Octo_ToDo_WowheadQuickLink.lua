local GlobalAddonName, E = ...
-- if IsRetail() then
--     E.Octo_Globals.baseWowheadUrl = "https://%swowhead.com/%s=%s%s"
-- end
-- if IsClassic() then
--     E.Octo_Globals.baseWowheadUrl = "https://%swowhead.com/classic/%s=%s%s"
-- end
-- if IsCata() then
--     E.Octo_Globals.baseWowheadUrl = "https://%swowhead.com/cata/%s=%s%s"
-- end
-- E.Octo_Globals.baseWowheadAzEsUrl = "https://%swowhead.com/azerite-essence/%s%s"
-- E.Octo_Globals.baseWowheadTradingPostActivityUrl = "https://%swowhead.com/trading-post-activity/%s%s"
-- E.Octo_Globals.baseArmoryUrl = "https://worldofwarcraft.com/%s/character/%s/%s"
-- E.Octo_Globals.baseRaiderIoUrl = "https://raider.io/characters/%s/%s/%s"
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
local GetMouseFocus = GetMouseFocus
if not GetMouseFocus then
	local GetMouseFoci = GetMouseFoci
	GetMouseFocus = function() return GetMouseFoci()[1] end
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
	preferredIndex = 3,
}