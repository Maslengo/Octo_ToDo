local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
	local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
	f:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	f:SetPoint("TOPLEFT", 8, -2)
	f:SetPoint("BOTTOMRIGHT", -8, 2)
	f:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	f:SetBackdropBorderColor(0, 0, 0, 1)
	return f
end)
----------------------------------------------------------------
local OctoToDo_EventFrame_Minecraft = CreateFrame("FRAME")
OctoToDo_EventFrame_Minecraft:Hide()
OctoToDo_EventFrame_Minecraft:RegisterEvent("ADDON_LOADED")
OctoToDo_EventFrame_Minecraft:RegisterEvent("PLAYER_REGEN_DISABLED")
----------------------------------------------------------------
local AddonHeight = 68/2 -- Высота
local AddonRightFrameWeight = 1190/2 -- Ширина
local AddonLeftFrameWeight = 240
local MinecraftTable = ns.OctoTable_MinecraftColors2
local PhysicalScreenWidth, PhysicalScreenHeight = GetPhysicalScreenSize()
local row = math.floor((math.floor(PhysicalScreenHeight / AddonHeight))*.7)
-- дефолт 20
local MainFrameNumLines = 15
if MainFrameNumLines > #MinecraftTable then
	MainFrameNumLines = #MinecraftTable
end
if MainFrameNumLines > row then
	MainFrameNumLines = row
end
local texture = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\minecraft ALL.tga"
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
local function DropDownMenuSearchButton_OnAcquired(owner, frame, data, new)
	if new then
		frame.left = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
		frame.left:SetPropagateMouseClicks(true)
		frame.left:SetSize(AddonLeftFrameWeight, AddonHeight)
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
		frame.right.FG = frame.right:CreateTexture(nil, "BACKGROUND", nil, 2)
		frame.right.FG:SetTexture(texture)
		--left, right, top, bottom
		frame.right.FG:SetTexCoord(0, 1, 0, 0.5)
		frame.right.FG:SetAllPoints(frame.right)
		frame.right.BG = frame.right:CreateTexture(nil, "BACKGROUND", nil, 3)
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
	E:func_SetBackdrop(frame.right)
end
function OctoToDo_EventFrame_Minecraft:OctoToDo_THIRD_CreateMainFrame()
	local OctoToDo_MainFrame_Minecraft = CreateFrame("BUTTON", "OctoToDo_MainFrame_Minecraft", UIParent, "BackdropTemplate")
	OctoToDo_MainFrame_Minecraft:SetSize(AddonRightFrameWeight+AddonLeftFrameWeight, AddonHeight*MainFrameNumLines)
	OctoToDo_MainFrame_Minecraft:Hide()
	OctoToDo_MainFrame_Minecraft.ScrollBox = CreateFrame("FRAME", nil, OctoToDo_MainFrame_Minecraft, "WowScrollBoxList")
	OctoToDo_MainFrame_Minecraft.ScrollBox:SetAllPoints()
	OctoToDo_MainFrame_Minecraft.ScrollBox:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_Minecraft.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_Minecraft.ScrollBar = CreateFrame("EventFrame", nil, OctoToDo_MainFrame_Minecraft, "MinimalScrollBar")
	OctoToDo_MainFrame_Minecraft.ScrollBar:SetPoint("TOPLEFT", OctoToDo_MainFrame_Minecraft.ScrollBox, "TOPRIGHT", 6, 0)
	OctoToDo_MainFrame_Minecraft.ScrollBar:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_Minecraft.ScrollBox, "BOTTOMRIGHT", 6, 0)
	OctoToDo_MainFrame_Minecraft.view = CreateScrollBoxListLinearView()
	OctoToDo_MainFrame_Minecraft.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_Minecraft.view:SetElementInitializer("BackdropTemplate", OctoToDo_Frame_init)
	OctoToDo_MainFrame_Minecraft.view:RegisterCallback(OctoToDo_MainFrame_Minecraft.view.Event.OnAcquiredFrame, DropDownMenuSearchButton_OnAcquired, OctoToDo_MainFrame_Minecraft)
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame_Minecraft.ScrollBox, OctoToDo_MainFrame_Minecraft.ScrollBar, OctoToDo_MainFrame_Minecraft.view)
	-- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame_Minecraft.ScrollBox, OctoToDo_MainFrame_Minecraft.ScrollBar)
	OctoToDo_MainFrame_Minecraft:SetClampedToScreen(false)
	OctoToDo_MainFrame_Minecraft:SetFrameStrata("HIGH")
	OctoToDo_MainFrame_Minecraft:SetPoint("CENTER")
	OctoToDo_MainFrame_Minecraft:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	OctoToDo_MainFrame_Minecraft:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoToDo_MainFrame_Minecraft:SetBackdropBorderColor(0, 0, 0, 1)
	-- OctoToDo_MainFrame_Minecraft:SetBackdropColor(0, 0, 0, 0)
	-- OctoToDo_MainFrame_Minecraft:SetBackdropBorderColor(0, 0, 0, 0)
	OctoToDo_MainFrame_Minecraft:EnableMouse(true)
	OctoToDo_MainFrame_Minecraft:SetMovable(true)
	OctoToDo_MainFrame_Minecraft:RegisterForDrag("LeftButton")
	OctoToDo_MainFrame_Minecraft:SetScript("OnDragStart", function()
			OctoToDo_MainFrame_Minecraft:SetAlpha(E.bgCa/2)
			OctoToDo_MainFrame_Minecraft:StartMoving()
	end)
	OctoToDo_MainFrame_Minecraft:SetScript("OnDragStop", function()
			OctoToDo_MainFrame_Minecraft:SetAlpha(1)
			OctoToDo_MainFrame_Minecraft:StopMovingOrSizing()
	end)
	OctoToDo_MainFrame_Minecraft:RegisterForClicks("RightButtonUp")
	OctoToDo_MainFrame_Minecraft:SetScript("OnClick", function(self) self:Hide() end)
	----------------------------------------------------------------
	self:func_DataProvider()
end
function OctoToDo_EventFrame_Minecraft:func_DataProvider()
	local DataProvider = CreateDataProvider()
	for index, tbl in ipairs(MinecraftTable) do
		DataProvider:Insert({name = tbl.name, hex = tbl.hex})
	end
	OctoToDo_MainFrame_Minecraft.ScrollBox:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
end
----------------------------------------------------------------
OctoToDo_EventFrame_Minecraft:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
function OctoToDo_EventFrame_Minecraft:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		OctoToDo_Minecraft = OctoToDo_Minecraft or {}
		----------------------------------------------------------------
		self:OctoToDo_THIRD_CreateMainFrame()
		E:func_CreateUtilsButton(OctoToDo_MainFrame_Minecraft)
		----------------------------------------------------------------
		E:func_CreateMinimapButton(GlobalAddonName, OctoToDo_Minecraft, OctoToDo_MainFrame_Minecraft)
		----------------------------------------------------------------
	end
end
function OctoToDo_EventFrame_Minecraft:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_Minecraft and OctoToDo_MainFrame_Minecraft:IsShown() then
		OctoToDo_MainFrame_Minecraft:Hide()
	end
end
