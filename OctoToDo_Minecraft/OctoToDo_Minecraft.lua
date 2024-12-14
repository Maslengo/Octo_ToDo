local GlobalAddonName, ns = ...
local OctoToDo_EventFrame = CreateFrame("FRAME")
OctoToDo_EventFrame:Hide()
local E = OctoToDo_ToDO_E
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
----------------------------------------------------------------
local OctoToDo_EventFrame = CreateFrame("FRAME")
OctoToDo_EventFrame:Hide()
OctoToDo_EventFrame:RegisterEvent("ADDON_LOADED")
----------------------------------------------------------------
local texture_FG = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\minecraft.tga"
local texture_BG = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\minecraft BG.tga"
-- local texture_FG = "Interface\\Addons\\"..GlobalAddonName.."\\Minecraft\\ALL.tga"
-- local texture_BG = "Interface\\Addons\\"..GlobalAddonName.."\\Minecraft\\ALL BG.tga"
local EmptyFrame = CreateFrame("BUTTON", "EmptyFrame", UIParent)
EmptyFrame.FG = EmptyFrame:CreateTexture()
EmptyFrame.FG:SetPoint("CENTER")
EmptyFrame.FG:SetTexture(texture_FG)
local height = 1190/8 -- Высота
local width = 68/8 -- Ширина
-- local height = 256/3 -- Высота
-- local width = 64/3 -- Ширина
local PhysicalScreenWidth, PhysicalScreenHeight = GetPhysicalScreenSize()
local row = PhysicalScreenWidth / width - 10
print (PhysicalScreenWidth, PhysicalScreenHeight, row)
----------------------------------------------------------------
function OctoToDo_EventFrame:Create_AnchorFrame()
	local AnchorFrame = CreateFrame("BUTTON", "AnchorFrame", UIParent)
	AnchorFrame:Hide()
	AnchorFrame:SetPoint("TOPLEFT", 0, 0)
	AnchorFrame:SetFrameStrata("BACKGROUND")
	AnchorFrame:SetSize(32, 32)
	AnchorFrame.FG = AnchorFrame:CreateTexture()
	AnchorFrame.FG:SetAllPoints(AnchorFrame)
	AnchorFrame.FG:SetVertexColor(1, 1, 1, 1)
	AnchorFrame.FG:SetTexture("Interface\\AddOns\\OctoToDo\\Media\\AddonTexture_3.tga")
	-- AnchorFrame.FG:SetTexture(1269444)
	AnchorFrame:SetClampedToScreen(true)
	AnchorFrame:EnableMouse(true)
	AnchorFrame:SetMovable(true)
	AnchorFrame:RegisterForDrag("LeftButton")
	AnchorFrame:SetScript("OnDragStart", AnchorFrame.StartMoving)
	AnchorFrame:SetScript("OnDragStop", function() AnchorFrame:StopMovingOrSizing() end)
	AnchorFrame:RegisterForClicks("RightButtonUp")


end

function OctoToDo_EventFrame:Create_Colored_Frames(anchor, self, number, text, color, height, width)
	if color == nil then color = "|cffFFFFFF" end
	if self[number] == nil then
		local r, g, b = E.func_hex2rgb(color)
		self[number] = CreateFrame("Frame", "Colored_Frames"..number, anchor, "BackdropTemplate")
		frame = self[number]
		frame:Hide()
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

function OctoToDo_EventFrame:main_frame_toggle()
	if AnchorFrame:IsShown() then
		AnchorFrame:Hide()
	else
		AnchorFrame:Show()
	end


	-- self:SetScript("OnClick", function(self)
		for i, v in ipairs({AnchorFrame:GetChildren()}) do
			v:SetShown(not v:IsShown())
		end
	-- end)

end

----------------------------------------------------------------
OctoToDo_EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
function OctoToDo_EventFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		OctoToDo_Minecraft = OctoToDo_Minecraft or {}
		self:Create_AnchorFrame()
		for number, v in ipairs(ns.OctoTable_MinecraftColors2) do
			self:Create_Colored_Frames(AnchorFrame, self, number, v.name, v.hex, height, width)
		end
		----------------------------------------------------------------
		local MinimapName = E.func_AddonTitle(GlobalAddonName)
		local ldb_icon = LibDataBroker:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = E.func_AddonIconTexture(GlobalAddonName),
				OnClick = function(_, button)
					if button == "LeftButton" then
						if not InCombatLockdown() then
							self:main_frame_toggle()



						end
					end
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, E.func_AddonTitle(GlobalAddonName))
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		OctoToDo_Minecraft.minimap = OctoToDo_Minecraft.minimap or {}
		OctoToDo_Minecraft.minimap.minimapPos = OctoToDo_Minecraft.minimap.minimapPos or 244
		LibDBIcon:Register(MinimapName, ldb_icon, OctoToDo_Minecraft.minimap)
		LibDBIcon:Show(MinimapName)
		----------------------------------------------------------------
	end
end