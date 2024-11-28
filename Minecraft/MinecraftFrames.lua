local GlobalAddonName, E = ...
----------------------------------------------------------------
local LibOctopussy = LibStub("LibOctopussy-1.0")
local EventFrame = nil
local AnchorFrame = nil
local texture_FG = "Interface\\Addons\\"..GlobalAddonName.."\\Minecraft\\minecraft.tga"
local texture_BG = "Interface\\Addons\\"..GlobalAddonName.."\\Minecraft\\minecraft BG.tga"
-- local texture_FG = "Interface\\Addons\\"..GlobalAddonName.."\\Minecraft\\ALL.tga"
-- local texture_BG = "Interface\\Addons\\"..GlobalAddonName.."\\Minecraft\\ALL BG.tga"
local startHiding = true
local EmptyFrame = CreateFrame("BUTTON", GlobalAddonName..LibOctopussy:func_GenerateUniqueID(), UIParent)
EmptyFrame.FG = EmptyFrame:CreateTexture()
EmptyFrame.FG:SetPoint("CENTER")
EmptyFrame.FG:SetTexture(texture_FG)
local height = 1190/2 -- Высота
local width = 68/2 -- Ширина
-- local height = 256/3 -- Высота
-- local width = 64/3 -- Ширина
local PhysicalScreenWidth, PhysicalScreenHeight = GetPhysicalScreenSize()
local row = PhysicalScreenWidth / width
----------------------------------------------------------------
if EventFrame == nil then
	EventFrame = CreateFrame("Frame")
	EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	EventFrame:RegisterEvent("PLAYER_STARTED_MOVING")
	EventFrame:RegisterEvent("PLAYER_STOPPED_MOVING")
end
----------------------------------------------------------------
local function Create_AnchorFrame()
	if AnchorFrame == nil then
		AnchorFrame = CreateFrame("BUTTON", GlobalAddonName..LibOctopussy:func_GenerateUniqueID(), UIParent)
	end
	AnchorFrame:Hide()
	AnchorFrame:SetPoint("TOPLEFT", 0, 0)
	AnchorFrame:SetFrameStrata("BACKGROUND")
	AnchorFrame:SetSize(width, width)
	AnchorFrame.FG = AnchorFrame:CreateTexture()
	AnchorFrame.FG:SetAllPoints(AnchorFrame)
	AnchorFrame.FG:SetVertexColor(1, 0, 0, 1)
	AnchorFrame.FG:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
	AnchorFrame:SetClampedToScreen(false)
	AnchorFrame:EnableMouse(true)
	AnchorFrame:SetMovable(true)
	AnchorFrame:RegisterForDrag("LeftButton")
	AnchorFrame:SetScript("OnDragStart", AnchorFrame.StartMoving)
	AnchorFrame:SetScript("OnDragStop", function() AnchorFrame:StopMovingOrSizing() end)
	AnchorFrame:RegisterForClicks("RightButtonUp")
	AnchorFrame:SetScript("OnClick", function(self)
			for i, v in ipairs({self:GetChildren()}) do
				v:SetShown(not v:IsShown())
			end
	end)
end
----------------------------------------------------------------
local function Create_Colored_Frames(anchor, self, number, text, color, height, width)
	if color == nil then color = "|cffFFFFFF" end
	if self[number] == nil then
		local r, g, b = LibOctopussy:func_hex2rgb(color)
		self[number] = CreateFrame("Frame", nil, anchor, "BackdropTemplate")
		frame = self[number]
		if startHiding == true then frame:Hide() end
		number = number - 1
		local x = number % row*(width-1)
		local y = -math.floor(number / row)*(height-1)
		frame:SetPoint("TOPLEFT", anchor, "BOTTOMRIGHT", x, y)
		frame:SetFrameStrata("HIGH")
		frame:SetSize(width, height)
		frame.BG = frame:CreateTexture(nil, "BACKGROUND", nil, -7)
		frame.BG:SetTexture(texture_BG)
		frame.BG:SetAllPoints(frame)
		frame.BG:SetVertexColor(1, 1, 1, 1)
		frame.FG = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
		frame.FG:SetTexture(texture_FG)
		frame.FG:SetAllPoints(frame)
		frame.FG:SetVertexColor(r/255, g/255, b/255, 1)
	end
end
local function OnEvent(self, event, ...)
	if Octo_ToDo_DB_Vars.config.Minecraft == true then
		if event == "PLAYER_ENTERING_WORLD" then
			Create_AnchorFrame()
			AnchorFrame:Show()
			for number, v in ipairs(E.OctoTable_MinecraftColors) do
				Create_Colored_Frames(AnchorFrame, self, number, v.name, v.hex, height, width)
			end
		end
		if event == "PLAYER_STARTED_MOVING" or event == "PLAYER_STOPPED_MOVING" then
			for i, v in ipairs({AnchorFrame:GetChildren()}) do
				-- v:SetShown(not v:IsShown())
				if v:IsShown() then
					v:Hide()
				end
			end
		end
	end
end
EventFrame:SetScript("OnEvent", OnEvent)
