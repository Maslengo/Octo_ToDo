local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------

local func_OnAcquiredLeft do
	local function Create_TextureLeft(frame)
		frame.TextureLeft = frame:CreateTexture(nil, "BACKGROUND", nil, -3)
		frame.TextureLeft:Hide()
		frame.TextureLeft:SetAllPoints()
		frame.TextureLeft:SetTexture(E.TEXTURE_LEFT_PATH)
	end
	local function Create_zebraBG_LEFT(frame)
		frame.zebraBG_LEFT = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
		frame.zebraBG_LEFT:SetAllPoints()
	end
	function func_OnAcquiredLeft(owner, frame, node, new)
		if not new then return end
		local frameData = node:GetData()
		frame.SettingsButton, frame.SettingsTexture = E.CreateSettingsButton(frame)
		frame.icon1frame, frame.icon1texture = E.CreateIconFrame(frame, frame.SettingsButton)
		frame.icon2frame, frame.icon2texture = E.CreateIconFrame(frame, frame.icon1frame)
		frame.icon3frame, frame.icon3texture = E.CreateIconFrame(frame, frame.icon2frame)
		frame.TextLeft = E.func_CreateStandardText(frame, frame.icon3frame)
		Create_TextureLeft(frame)
		Create_zebraBG_LEFT(frame)
		E.func_Create_Highlight(frame, owner)
		if frame.Highlight then
			frame:SetScript("OnHide", function() frame.Highlight:Hide() end)
			frame:SetScript("OnShow", function() frame.Highlight:Show() end)
		end
	end
end
local func_OnAcquiredCenter do
	local function Create_CurrentCharBackground(columnFrame)
		columnFrame.CurrentCharBackground = columnFrame:CreateTexture(nil, "BACKGROUND", nil, -3)
		columnFrame.CurrentCharBackground:SetAllPoints()
		columnFrame.CurrentCharBackground:SetTexture(E.TEXTURE_CENTRAL_PATH)
		columnFrame.CurrentCharBackground:Hide()
	end
	local function Create_ReputationBackground(columnFrame)
		columnFrame.ReputationBackground = columnFrame:CreateTexture(nil, "BACKGROUND", nil, -2)
		columnFrame.ReputationBackground:SetPoint("TOPLEFT")
		columnFrame.ReputationBackground:SetHeight(E.GLOBAL_LINE_HEIGHT)
		columnFrame.ReputationBackground:SetTexture(E.TEXTURE_CENTRAL_PATH)
		columnFrame.ReputationBackground:Hide()
	end
	local function Create_TextCenter(columnFrame)
		columnFrame.TextCenter = columnFrame:CreateFontString()
		columnFrame.TextCenter:SetFontObject(OctoFont11)
		columnFrame.TextCenter:SetAllPoints()
		columnFrame.TextCenter:SetWordWrap(false)
		columnFrame.TextCenter:SetJustifyV("MIDDLE")
		columnFrame.TextCenter:SetJustifyH("CENTER")
		columnFrame.TextCenter:SetTextColor(E.textR, E.textG, E.textB, E.textA)
	end
	local function Create_zebraBG_RIGHT(columnFrame)
		columnFrame.zebraBG_RIGHT = columnFrame:CreateTexture(nil, "BACKGROUND", nil, -3)
		columnFrame.zebraBG_RIGHT:SetAllPoints()
		columnFrame.zebraBG_RIGHT:Hide()
	end
	function func_OnAcquiredCenter(owner, frame, node, new)
		if not new then return end
		local frameData = node:GetData()
		frame.columnFrames = setmetatable({}, {
				__index = function(self, key)
					if type(key) == "number" then
						local columnFrame = CreateFrame("BUTTON", nil, frame, "OctoRectTemplate")
						columnFrame:Hide()
						Create_CurrentCharBackground(columnFrame)
						Create_ReputationBackground(columnFrame)
						Create_TextCenter(columnFrame)
						Create_zebraBG_RIGHT(columnFrame)
						columnFrame:SetHeight(E.GLOBAL_LINE_HEIGHT)
						if key == 1 then
							columnFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
						else
							columnFrame:SetPoint("TOPLEFT", self[key-1], "TOPRIGHT", 0, 0)
						end
						columnFrame:SetScript("OnHide", function()
								columnFrame:Hide()
						end)
						columnFrame.CurrentCharBackground:SetScript("OnHide", columnFrame.CurrentCharBackground.Hide)
						columnFrame.zebraBG_RIGHT:SetScript("OnHide", columnFrame.zebraBG_RIGHT.Hide)
						rawset(self, key, columnFrame)
						return columnFrame
					end
				end
		})
	end
end


----------------------------------------------------------------
E.func_OnAcquiredLeft = func_OnAcquiredLeft
E.func_OnAcquiredCenter = func_OnAcquiredCenter