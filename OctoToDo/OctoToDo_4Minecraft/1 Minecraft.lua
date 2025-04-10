local GlobalAddonName, E = ...
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
----------------------------------------------------------------
local AddonHeight = 68 -- Высота 27    --
local AddonRightFrameWeight = 1256 -- Ширина 54    --
local MinecraftTable = E.OctoTable_MinecraftColors
local PhysicalScreenWidth, PhysicalScreenHeight = GetPhysicalScreenSize()
local NumberOfLines = math.floor((math.floor(PhysicalScreenHeight / AddonHeight))*.7)
-- дефолт 15
local row = 1 -- 11
local MainFrameNumLines = math.ceil(#MinecraftTable/row)
if MainFrameNumLines > #MinecraftTable then
	MainFrameNumLines = #MinecraftTable
end
if MainFrameNumLines > NumberOfLines then
	MainFrameNumLines = NumberOfLines
end

local MINECRAFTtextureFG = "Interface\\Addons\\"..GlobalAddonName.."\\OctoToDo_4Minecraft\\Media\\minecraft FG.tga"
local MINECRAFTtextureBG = "Interface\\Addons\\"..GlobalAddonName.."\\OctoToDo_4Minecraft\\Media\\minecraft BG.tga"
local MINECRAFTtextureALL = "Interface\\Addons\\"..GlobalAddonName.."\\OctoToDo_4Minecraft\\Media\\minecraft ALL.tga"
-- frame.cent.FG:SetTexCoord(0, 1, 0, 0.5)
-- frame.cent.BG:SetTexCoord(0, 1, 0.5, 1)
----------------------------------------------------------------
local function OnENTERTTOOLTIP(f)
	if not f.tooltip then
		return
	elseif #f.tooltip == 0 then
		return
	end
	GameTooltip:SetOwner(f, "ANCHOR_RIGHT", 0, 0)
	-- GameTooltip:AddLine("QWEQWE")
	for index, v in ipairs(f.tooltip) do
		GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
	end
	-- GameTooltip:AddLine("ASDASD")
	GameTooltip:Show()
end
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
local function OnAcquired(owner, frame, data, new)
	if new then
		frame:SetSize(AddonRightFrameWeight, AddonHeight)
		frame.cent = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
		frame.cent:SetPropagateMouseClicks(true)
		frame.cent:SetSize(AddonRightFrameWeight, AddonHeight)
		frame.cent:SetPoint("TOPLEFT", frame, "TOPLEFT")

		frame.cent.FG = frame.cent:CreateTexture(nil, "BACKGROUND", nil, 2)
		frame.cent.FG:SetTexture(MINECRAFTtextureFG)
		frame.cent.FG:SetAllPoints(frame.cent)

		frame.cent.BG = frame.cent:CreateTexture(nil, "BACKGROUND", nil, 3)
		frame.cent.BG:SetTexture(MINECRAFTtextureBG)
		frame.cent.BG:SetAllPoints(frame.cent)
		frame.cent.BG:SetScript("OnEnter", OnENTERTTOOLTIP)
		frame.cent.BG:SetScript("OnLeave", GameTooltip_Hide)
	end
end
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ
local function OctoToDo_Frame_init(frame, data)
	local r, g, b, a = E.func_hex2rgbNUMBER(data.hex)
	frame.cent.FG:SetVertexColor(r, g, b, 1)
	local hexcolor = nil
	local BackdropAlpha = 0
	local BackdropBorderAlpha = .5
	E:func_SetBackdrop(frame.cent, hexcolor, BackdropAlpha, BackdropBorderAlpha)
	frame.cent.BG.tooltip = {{data.name}}
end
function OctoToDo_EventFrame_Minecraft:OctoToDo_Create_MainFrame_Minecraft()
	local OctoToDo_MainFrame_Minecraft = CreateFrame("BUTTON", "OctoToDo_MainFrame_Minecraft", UIParent, "BackdropTemplate")
	tinsert(E.OctoTable_Frames, OctoToDo_MainFrame_Minecraft)
	OctoToDo_MainFrame_Minecraft:SetSize(AddonRightFrameWeight*row, AddonHeight*MainFrameNumLines)
	OctoToDo_MainFrame_Minecraft:SetPoint("TOPLEFT", 100, -100)
	OctoToDo_MainFrame_Minecraft:Hide()
	OctoToDo_MainFrame_Minecraft:SetDontSavePosition(true)
	OctoToDo_MainFrame_Minecraft.ScrollBox = CreateFrame("FRAME", nil, OctoToDo_MainFrame_Minecraft, "WowScrollBoxList")
	OctoToDo_MainFrame_Minecraft.ScrollBox:SetAllPoints()
	OctoToDo_MainFrame_Minecraft.ScrollBox:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_Minecraft.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_Minecraft.ScrollBar = CreateFrame("EventFrame", nil, OctoToDo_MainFrame_Minecraft, "MinimalScrollBar")
	OctoToDo_MainFrame_Minecraft.ScrollBar:SetPoint("TOPLEFT", OctoToDo_MainFrame_Minecraft.ScrollBox, "TOPRIGHT", 6, 0)
	OctoToDo_MainFrame_Minecraft.ScrollBar:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_Minecraft.ScrollBox, "BOTTOMRIGHT", 6, 0)
	-- OctoToDo_MainFrame_Minecraft.view = CreateScrollBoxListLinearView()
	-- return CreateAndInitFromMixin(ScrollBoxListGridViewMixin, stride or 1, top or 0, bottom or 0, left or 0, right or 0, horizontalSpacing or 0, verticalSpacing or 0);
	OctoToDo_MainFrame_Minecraft.view = CreateScrollBoxListGridView(row, 0, 0, 0, 0, 0, 0)
	OctoToDo_MainFrame_Minecraft.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_Minecraft.view:SetElementInitializer("BackdropTemplate", OctoToDo_Frame_init)
	OctoToDo_MainFrame_Minecraft.view:RegisterCallback(OctoToDo_MainFrame_Minecraft.view.Event.OnAcquiredFrame, OnAcquired, OctoToDo_MainFrame_Minecraft)
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame_Minecraft.ScrollBox, OctoToDo_MainFrame_Minecraft.ScrollBar, OctoToDo_MainFrame_Minecraft.view)
	-- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame_Minecraft.ScrollBox, OctoToDo_MainFrame_Minecraft.ScrollBar)
	OctoToDo_MainFrame_Minecraft:SetClampedToScreen(false)
	OctoToDo_MainFrame_Minecraft:SetFrameStrata("HIGH")
	OctoToDo_MainFrame_Minecraft:SetPoint("CENTER")
	OctoToDo_MainFrame_Minecraft:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	OctoToDo_MainFrame_Minecraft:SetBackdropColor(29/255, 42/255, 76/255, 1)
	OctoToDo_MainFrame_Minecraft:SetBackdropBorderColor(0, 0, 0, 0)
	OctoToDo_MainFrame_Minecraft:EnableMouse(true)
	OctoToDo_MainFrame_Minecraft:SetMovable(true)
	OctoToDo_MainFrame_Minecraft:RegisterForDrag("LeftButton")
	OctoToDo_MainFrame_Minecraft:SetScript("OnDragStart", function()
			OctoToDo_MainFrame_Minecraft:SetAlpha(E.bgCa)
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
OctoToDo_EventFrame_Minecraft:SetScript("OnEvent",
	function(self, event, ...)
		if self[event] then
			self[event](self, ...)
		else
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("UNUSED UVENT: ", E.Red_Color, E.Venthyr_Color).. E.Green_Color.. event.."|r")
			self:UnregisterEvent(event)
			self.event = nil
		end
end)



local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_REGEN_DISABLED",
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_Minecraft, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_Minecraft:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		OctoToDo_Minecraft = OctoToDo_Minecraft or {}
		----------------------------------------------------------------
		self:OctoToDo_Create_MainFrame_Minecraft()
		-- OctoToDo_MainFrame_Minecraft:ClearAllPoints()
		-- OctoToDo_MainFrame_Minecraft:SetPoint("CENTER", UIParent)
		----------------------------------------------------------------
		E:func_CreateUtilsButton(OctoToDo_MainFrame_Minecraft, "Minecraft")
		E:func_CreateMinimapButton(GlobalAddonName, "Minecraft", OctoToDo_Minecraft, OctoToDo_MainFrame_Minecraft)
		----------------------------------------------------------------
	end
end

function OctoToDo_EventFrame_Minecraft:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_Minecraft and OctoToDo_MainFrame_Minecraft:IsShown() then
		OctoToDo_MainFrame_Minecraft:Hide()
	end
end