local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- Octo_WowheadQuickLink
local popupText = "%s Link\nCTRL-C to copy"


local function ShowUrlPopup(header, url)
	StaticPopup_Show("WowheadQuickLink_CopyBox", header, _, url)
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
	local focus = {}
	local foci = GetMouseFoci()
	if foci[1] then
		focus = foci[1]
	end
	local tooltip = GameTooltip
	return {focus = focus, tooltip = tooltip}
end


function RunWowheadQuickLink()
	CreateUrl(GetDataSources(), E.strategies)
end


function RunAlternativeQuickLink()
	CreateUrl(GetDataSources(), E.altStrategies)
end


StaticPopupDialogs["WowheadQuickLink_CopyBox"] = {
	text = E.classColorHexCurrent.."CTRL-C|r|n"..CALENDAR_COPY_EVENT,
	button1 = CLOSE,
	button2 = CANCEL,
	hasEditBox = 1, -- true
	whileDead = 1, -- true
	maxLetters = 0,
	timeout = 0,
	EditBoxOnEscapePressed = StaticPopup_StandardEditBoxOnEscapePressed,
	EditBoxOnEnterPressed = StaticPopup_StandardEditBoxOnEscapePressed,
	hideOnEscape = 1, -- true

	editBoxWidth = 256,
	closeButton = false,

	preferredIndex = 3,

	OnShow = function(self, data)
		if data then
			self.editBox:SetText(data)
			self.editBox:HighlightText()
		end
		self.editBox:SetScript("OnKeyUp", function(self, key)
				if IsControlKeyDown() and key == "C" then
					self:GetParent():Hide()
				end
		end)
	end,
}