local GlobalAddonName, ns = ...
local OctoToDo_EventFrame = CreateFrame("FRAME")
OctoToDo_EventFrame:Hide()
local E = OctoToDo_ToDO_E
----------------------------------------------------------------
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
----------------------------------------------------------------
local OctoToDo_EventFrame = CreateFrame("FRAME")
OctoToDo_EventFrame:Hide()
OctoToDo_EventFrame:RegisterEvent("ADDON_LOADED")
OctoToDo_EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
----------------------------------------------------------------
-- local texture_FG = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\minecraft.tga"
-- local texture_BG = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\minecraft BG.tga"
local AddonHeight = 68 -- Высота
local AddonRightFrameWeight = 1190 -- Ширина
local AddonLeftFrameWeight = 240
local MinecraftTable = ns.OctoTable_MinecraftColors2
local PhysicalScreenWidth, PhysicalScreenHeight = GetPhysicalScreenSize()
local row = math.floor((math.floor(PhysicalScreenHeight / AddonHeight))*.7)
-- print (row, math.floor(row))
local MainFrameNumLines = #MinecraftTable or row
if MainFrameNumLines > row then
	MainFrameNumLines = row
end
local texture = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\minecraft ALL.tga"
-- local texture_FG = texture:SetTexCoord(0, 0, .5, 0)
-- local texture_BG =  texture:SetTexCoord(0, 0, 0, .5)
----------------------------------------------------------------

-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
local function DropDownMenuSearchButton_OnAcquired(owner, frame, data, new)
	if new then
		-- E:func_SetBackdrop(frame)
		frame.left = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
		frame.left:SetPropagateMouseClicks(true)
		frame.left:SetSize(AddonLeftFrameWeight, AddonHeight)
		-- frame.left:SetSize(142, 34)
		frame.left:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.left.text = frame.left:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.left.text:SetAllPoints()
		frame.left.text:SetFontObject(OctoFont11)
		frame.left.text:SetJustifyV("MIDDLE")
		frame.left.text:SetJustifyH("CENTER")
		frame.left.text:SetTextColor(1, 1, 1, 1)
		frame.right = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
		frame.right:SetPropagateMouseClicks(true)
		frame.right:SetSize(AddonRightFrameWeight, AddonHeight)
		frame.right:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
		frame.right.FG = frame.right:CreateTexture(nil, "BACKGROUND", nil, 0)
		frame.right.FG:SetTexture(texture)
		--left, right, top, bottom
		frame.right.FG:SetTexCoord(0, 1, 0, 0.5)
		frame.right.FG:SetAllPoints(frame.right)
		frame.right.BG = frame.right:CreateTexture(nil, "BACKGROUND", nil, 1)
		frame.right.BG:SetTexture(texture)
		frame.right.BG:SetTexCoord(0, 1, 0.5, 1)
		frame.right.BG:SetAllPoints(frame.right)
		frame.right.text = frame.right:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.right.text:SetAllPoints()
		frame.right.text:SetFontObject(OctoFont11)
		frame.right.text:SetJustifyV("MIDDLE")
		frame.right.text:SetJustifyH("CENTER")
		frame.right.text:SetTextColor(1, 1, 1, 1)
	end
end

-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ
local function OctoToDo_Frame_init(frame, data)
	frame.left.text:SetText(data.name)
	local r, g, b, a = E.func_hex2rgbNUMBER(data.hex)
	frame.right.FG:SetVertexColor(r, g, b, 1)
	E:func_SetBackdrop(frame.left)
	E:func_SetBackdrop(frame.right, nil, 0)
end

function OctoToDo_EventFrame:OctoToDo_THIRD_CreateMainFrame()
	local OctoToDo_MainFrame = CreateFrame("BUTTON", "OctoToDo_MainFrame", UIParent, "BackdropTemplate")
	OctoToDo_MainFrame:SetSize(AddonRightFrameWeight+AddonLeftFrameWeight, AddonHeight*MainFrameNumLines)
	OctoToDo_MainFrame:Hide()
	-- OctoToDo_MainFrame.ScrollFrame = CreateFrame("ScrollFrame", "ScrollFrame", OctoToDo_MainFrame)
	OctoToDo_MainFrame.ScrollBox = CreateFrame("FRAME", nil, OctoToDo_MainFrame, "WowScrollBoxList")
	OctoToDo_MainFrame.ScrollBox:SetAllPoints()
	OctoToDo_MainFrame.ScrollBox:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	-- OctoToDo_MainFrame.ScrollBox.ScrollTarget:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame.ScrollBar = CreateFrame("EventFrame", nil, OctoToDo_MainFrame, "MinimalScrollBar")
	OctoToDo_MainFrame.ScrollBar:SetPoint("TOPLEFT", OctoToDo_MainFrame.ScrollBox, "TOPRIGHT", 6, 0)
	OctoToDo_MainFrame.ScrollBar:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame.ScrollBox, "BOTTOMRIGHT", 6, 0)
	OctoToDo_MainFrame.view = CreateScrollBoxListLinearView()
	OctoToDo_MainFrame.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame.view:SetElementInitializer("BackdropTemplate", OctoToDo_Frame_init)
	OctoToDo_MainFrame.view:RegisterCallback(OctoToDo_MainFrame.view.Event.OnAcquiredFrame, DropDownMenuSearchButton_OnAcquired, OctoToDo_MainFrame)
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame.ScrollBox, OctoToDo_MainFrame.ScrollBar, OctoToDo_MainFrame.view)
	-- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame.ScrollBox, OctoToDo_MainFrame.ScrollBar)
	OctoToDo_MainFrame:SetClampedToScreen(false)
	OctoToDo_MainFrame:SetFrameStrata("HIGH")
	OctoToDo_MainFrame:SetPoint("CENTER")
	OctoToDo_MainFrame:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	OctoToDo_MainFrame:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoToDo_MainFrame:SetBackdropBorderColor(0, 0, 0, 0)
	OctoToDo_MainFrame:EnableMouse(true)
	OctoToDo_MainFrame:SetMovable(true)
	OctoToDo_MainFrame:RegisterForDrag("LeftButton")
	OctoToDo_MainFrame:SetScript("OnDragStart", function()
			OctoToDo_MainFrame:SetAlpha(E.bgCa/2)
			OctoToDo_MainFrame:StartMoving()
	end)
	OctoToDo_MainFrame:SetScript("OnDragStop", function()
			OctoToDo_MainFrame:SetAlpha(1)
			OctoToDo_MainFrame:StopMovingOrSizing()
	end)
	OctoToDo_MainFrame:RegisterForClicks("RightButtonUp")
	OctoToDo_MainFrame:SetScript("OnClick", function(self) self:Hide() end)
	----------------------------------------------------------------
	self:func_DataProvider()
end

function OctoToDo_EventFrame:func_DataProvider()
	local DataProvider = CreateDataProvider()
	for index, tbl in ipairs(MinecraftTable) do
		DataProvider:Insert({name = tbl.name, hex = tbl.hex})
	end
	OctoToDo_MainFrame.ScrollBox:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
end
----------------------------------------------------------------
OctoToDo_EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

function OctoToDo_EventFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		-- self:OctoToDo_AddDataToAltFrame()
		----------------------------------------------------------------
		OctoToDo_Minecraft = OctoToDo_Minecraft or {}
		----------------------------------------------------------------
		self:OctoToDo_THIRD_CreateMainFrame()
		E:func_CreateCloseButton(OctoToDo_MainFrame)
		----------------------------------------------------------------
		E:func_CreateMinimapButton(GlobalAddonName, OctoToDo_Minecraft, OctoToDo_MainFrame)
		----------------------------------------------------------------
	end
end


function OctoToDo_EventFrame:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then
		OctoToDo_MainFrame:Hide()
	end
end
