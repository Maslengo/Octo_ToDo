local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local slider_scale = 1
local multiplier = 1
local modules = {}
local FRAME_WIDTH = 200
local FRAME_HEIGHT = 20
local indent = FRAME_HEIGHT + 4
local POS_LEFT = 6
local POS_RIGHT = 474
local POS_CENTER = POS_RIGHT/2
local OctoFont11 = OctoFont11
local editBoxBackdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
	tile = true, edgeSize = 1, tileSize = 5,
}
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function createBGframe(parent, position, count)
	local MAINFRAME = CreateFrame("Frame", nil, parent)
	MAINFRAME.texture = MAINFRAME:CreateTexture()
	MAINFRAME.texture:SetAllPoints()
	MAINFRAME:SetScript("OnShow", function()
		-- MAINFRAME:Hide()
		-- frame:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", position*multiplier+11, (-indent*(count-1)*multiplier)-multiplier*count)
		-- MAINFRAME.texture:SetColorTexture(math.random(0,1), math.random(0,1), math.random(0,1), .2)
	end)

	return MAINFRAME
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CreateSlider(parent, count, position, variableKey, name, color, defaultValue, minValue, maxValue, Octo_Callback_func)
	----------------------------------------------------------------
	local MAINFRAME = createBGframe(parent, count, position)
	MAINFRAME:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", position, -indent*(count-1))
	MAINFRAME:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	----------------------------------------------------------------
	color = color or E.COLOR_WHITE
	local steps = maxValue-minValue
	local frame = CreateFrame("Slider", nil, MAINFRAME, "MinimalSliderWithSteppersTemplate")
	frame:SetPoint("LEFT")
	frame:SetScale(slider_scale)
	local formatters = {
		[MinimalSliderWithSteppersMixin.Label.Top] = function(value)
			return name
		end,
		[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
			if variableKey == "Addon_Height" then
				return color..math.ceil(value/20).."|r"
			else
				return color..value.."|r"
			end
		end,
	}
	frame:Init(Octo_ToDo_DB_Vars[variableKey], minValue, maxValue, steps, formatters)
	frame:SetWidth(FRAME_WIDTH)
	frame:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, value)
			Octo_ToDo_DB_Vars[variableKey] = value
			if Octo_Callback_func then
				for i, func in next,(modules) do
					if func == Octo_Callback_func then
						func()
					end
				end
			end
	end)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CreateCheckButton(parent, count, position, variableKey, name, color, defaultValue)
	----------------------------------------------------------------
	local MAINFRAME = createBGframe(parent, count, position)
	MAINFRAME:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", position, -indent*(count-1))
	MAINFRAME:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	----------------------------------------------------------------
	local frame = CreateFrame("CheckButton", nil, MAINFRAME, "InterfaceOptionsCheckButtonTemplate")
	frame:SetPoint("LEFT")
	frame:SetChecked(Octo_ToDo_DB_Vars[variableKey])
	frame:SetScript("OnClick", function(btn)
			Octo_ToDo_DB_Vars[variableKey] = btn:GetChecked()
	end)
	local fontString = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	fontString:SetPoint("LEFT", frame, "RIGHT")
	-- fontString:SetFontObject(OctoFont11)
	fontString:SetJustifyV("MIDDLE")
	fontString:SetJustifyH("LEFT")
	fontString:SetWordWrap(false)
	fontString:SetTextColor(1, 1, 1, 1)
	fontString:SetText(color..name..FONT_COLOR_CODE_CLOSE)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CreateSimpleButton(parent, count, position, func, name, color)
	----------------------------------------------------------------
	local MAINFRAME = createBGframe(parent, count, position)
	MAINFRAME:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", position, -indent*(count-1))
	MAINFRAME:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	----------------------------------------------------------------
	color = color or E.COLOR_WHITE
	local frame = CreateFrame("Button", nil, MAINFRAME, "UIPanelButtonTemplate")
	frame:SetPoint("LEFT")
	frame:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	frame:SetSize(indent*6, indent)
	frame:SetText(name)
	frame:SetScript("OnClick", function(btn)
			if func then
				func()
			end
	end)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CreateEditBox(parent, count, position, variableKey)
	----------------------------------------------------------------
	local MAINFRAME = createBGframe(parent, count, position)
	MAINFRAME:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", position, -indent*(count-1))
	MAINFRAME:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	----------------------------------------------------------------
	color = color or E.COLOR_WHITE
	local frame = CreateFrame("Button", nil, MAINFRAME, "SecureActionButtonTemplate, BackDropTemplate")
	frame:SetPoint("LEFT")
	frame:SetSize(indent*6, 20)
	frame:SetBackdrop(editBoxBackdrop)
	frame:SetBackdropColor(0, 0, 0, 0.5)
	frame:SetBackdropBorderColor(0.3, 0.3, 0.30, 0.80)
	local editBox = CreateFrame("EditBox", "EditBox"..count..position, frame)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(OctoFont12)
	editBox:SetJustifyH("CENTER")
	editBox:EnableMouse(true)
	editBox:SetAllPoints(frame)
	editBox:SetMultiLine(false)
	editBox:SetText(Octo_ToDo_DB_Vars[variableKey])
	editBox:SetJustifyV("MIDDLE")
	editBox:SetScript("OnEscapePressed", editBox.ClearFocus)
	editBox:SetScript("OnEnterPressed", editBox.ClearFocus)
	editBox:SetScript("OnTextChanged", function()
			Octo_ToDo_DB_Vars[variableKey] = editBox:GetText() -- 000AD0FD (0AE9B27E RETAIL)
	end)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CreateColorPicker(parent, count, position, name, defaultValue)
	----------------------------------------------------------------
	local MAINFRAME = createBGframe(parent, count, position)
	MAINFRAME:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", position, -indent*(count-1))
	MAINFRAME:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	----------------------------------------------------------------
	local color = defaultValue
	local r, g, b, a = E.func_Hex2RGBA(color)
	local frame = CreateFrame("Frame", nil, MAINFRAME)
	frame:SetPoint("LEFT")
	frame.texture = frame:CreateTexture()
	frame.texture:SetAllPoints()
	-- frame.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
	frame.texture:SetColorTexture(r, g, b, a)
	frame:SetFrameStrata("BACKGROUND")
	frame:SetSize(20, 20)
	local fontString = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	fontString:SetPoint("LEFT", frame, "RIGHT")
	-- fontString:SetFontObject(OctoFont11)
	fontString:SetJustifyV("MIDDLE")
	fontString:SetJustifyH("LEFT")
	fontString:SetWordWrap(false)
	fontString:SetTextColor(1, 1, 1, 1)
	fontString:SetText(" "..name.." "..color)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CreateText(parent, count, position, name)
	----------------------------------------------------------------
	local MAINFRAME = createBGframe(parent, count, position)
	MAINFRAME:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", position, -indent*(count-1))
	MAINFRAME:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	----------------------------------------------------------------

end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CreateIndent()
	----------------------------------------------------------------
	local MAINFRAME = createBGframe(parent, count, position)
	MAINFRAME:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", position, -indent*(count-1))
	MAINFRAME:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	----------------------------------------------------------------

end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_CreateColor(parent, count, position, name, color)
	----------------------------------------------------------------
	local MAINFRAME = createBGframe(parent, count, position)
	MAINFRAME:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", position, -indent*(count-1))
	MAINFRAME:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	----------------------------------------------------------------
	local r, g, b, a = E.func_Hex2RGBA(color)
	local frame = CreateFrame("Frame", nil, MAINFRAME)
	frame:SetPoint("LEFT")

	frame.texture = frame:CreateTexture()
	frame.texture:SetAllPoints()
	-- frame.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
	frame.texture:SetColorTexture(r, g, b, a)
	frame:SetFrameStrata("BACKGROUND")
	frame:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
	local fontString = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	fontString:SetAllPoints()
	-- fontString:SetFontObject(OctoFont11)
	fontString:SetJustifyV("MIDDLE")
	fontString:SetJustifyH("LEFT")
	fontString:SetWordWrap(false)
	fontString:SetTextColor(1, 1, 1, 1)
	fontString:SetText(color..name..FONT_COLOR_CODE_CLOSE)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------