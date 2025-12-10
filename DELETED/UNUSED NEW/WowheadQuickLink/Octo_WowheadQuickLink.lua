local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
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
----------------------------------------------------------------
local dialogConfig = {
	text = E.classColorHexCurrent.."CTRL-C|r|n"..CALENDAR_COPY_EVENT,
	-- button1 = CLOSE,
	button2 = CANCEL,
	hasEditBox = 1,
	whileDead = 1,
	maxLetters = 0,
	timeout = 0,
	EditBoxOnEscapePressed = StaticPopup_StandardEditBoxOnEscapePressed,
	EditBoxOnEnterPressed = StaticPopup_StandardEditBoxOnEscapePressed,
	hideOnEscape = 1,
	editBoxWidth = 256,
	closeButton = false,
	preferredIndex = 3,
}
----------------------------------------------------------------
-- local editBoxKey = E.interfaceVersion < 110200 and "editBox" or "EditBox"
----------------------------------------------------------------
local STATICPOPUP_NUMDIALOGS = STATICPOPUP_NUMDIALOGS or 1
----------------------------------------------------------------
dialogConfig.OnShow = function(self, data)
	for i = 1, STATICPOPUP_NUMDIALOGS do
		local popup = _G["StaticPopup"..i]
		if not popup then break end
		local editBox = _G["StaticPopup"..i.."EditBox"]
		if editBox:IsShown() then
			if data then
				editBox:SetText(data)
				editBox:HighlightText()
			end
			editBox:SetScript("OnKeyUp", function(self, key)
					if IsControlKeyDown() and key == "C" then
						self:GetParent():Hide()
					end
			end)
		end
	end
end
----------------------------------------------------------------
StaticPopupDialogs["WowheadQuickLink_CopyBox"] = dialogConfig
----------------------------------------------------------------