local GlobalAddonName, E = ...
local Octo_EventFrame_OCTOTOOLTIP = CreateFrame("FRAME")
Octo_EventFrame_OCTOTOOLTIP:Hide()
local OctoTooltip = CreateFrame("BUTTON", "OctoTooltip", UIParent, "BackdropTemplate")
OctoTooltip:Hide()
----------------------------------------------------------------
local AddonHeight = 20
local AddonLeftFrameWeight = 200
local AddonCentralFrameWeight = 90
local OctoTooltipDefaultLines = 30
local OctoTooltipTotalLines = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / AddonHeight))*.7)
if OctoTooltipDefaultLines > OctoTooltipTotalLines then
	OctoTooltipDefaultLines = OctoTooltipTotalLines
end
local r, g, b = GetClassColor(E.classFilename)
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
-- LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
--         local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
--         f:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
--         f:SetPoint("TOPLEFT", 8, -2)
--         f:SetPoint("BOTTOMRIGHT", -8, 2)
--         f:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
--         f:SetBackdropBorderColor(0, 0, 0, 1)
--         return f
-- end)
----------------------------------------------------------------
----------------------------------------------------------------
E.total_widthTOOLTIP = E.total_widthTOOLTIP or 100
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function func_OnHideFirst(frame)
	frame.frameFULL:Hide()
end
local function func_OnShowFirst(frame)
	frame.frameFULL:Show()
end
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
local func_OnAcquired do
	------------------------------------------------
	function func_OnAcquired(owner, frame, data, new)
		if new then
			-- Frame setup
			frame:SetPropagateMouseClicks(true)
			frame:SetPropagateMouseMotion(true)
			------------------------------------------------
			------------------------------------------------
			-- Full texture background
			local frameFULL = CreateFrame("Button", nil, OctoTooltip)
			frameFULL:SetPropagateMouseClicks(true)
			frameFULL:SetPropagateMouseMotion(true)
			frameFULL:SetFrameLevel(frame:GetFrameLevel()+2) -- ВСЕГДА НА ВЕРХНЕМ СЛОЕ
			frameFULL:SetHighlightAtlas("auctionhouse-ui-row-highlight", "ADD")
			frameFULL.HighlightTexture = frameFULL:GetHighlightTexture()
			frameFULL.HighlightTexture:SetAlpha(.2)
			frameFULL:SetPoint("LEFT", frame)
			frameFULL:SetPoint("TOP", frame)
			frameFULL:SetPoint("BOTTOM", frame)
			frameFULL:SetPoint("RIGHT")
			frame.frameFULL = frameFULL
			------------------------------------------------
			local textureFULL = frameFULL:CreateTexture(nil, "BACKGROUND", nil, -3)
			textureFULL:Hide()
			textureFULL:SetAllPoints()
			textureFULL:SetTexture(E.TEXTURE_LEFT_PATH)
			textureFULL:SetVertexColor(r, g, b, E.bgCaOverlay)
			frame.textureFULL = textureFULL
			------------------------------------------------
			------------------------------------------------
			-- first
			local first = CreateFrame("FRAME", nil, frame)
			local first_width = AddonCentralFrameWeight
			local first_height = AddonHeight
			first:SetSize(first_width, first_height)
			first:SetPoint("TOPLEFT")
			first:SetPropagateMouseClicks(true)
			first.text = first:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			first.text:SetAllPoints()
			first.text:SetFontObject(OctoFont11)
			first.text:SetJustifyV("MIDDLE")
			first.text:SetJustifyH("LEFT")
			first.text:SetTextColor(1, 1, 1, 1)
			frame.first = first
			------------------------------------------------
			------------------------------------------------
			-- second
			local second = CreateFrame("FRAME", nil, frame)
			local second_width = AddonCentralFrameWeight
			local second_height = AddonHeight
			second:SetSize(second_width, second_height)
			second:SetPoint("TOPLEFT", first, "TOPRIGHT")
			second:SetPropagateMouseClicks(true)
			second.text = second:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			second.text:SetAllPoints()
			second.text:SetFontObject(OctoFont11)
			second.text:SetJustifyV("MIDDLE")
			second.text:SetJustifyH("CENTER")
			second.text:SetTextColor(1, 1, 1, 1)
			frame.second = second
			------------------------------------------------
			------------------------------------------------
			-- third
			local third = CreateFrame("FRAME", nil, frame)
			local third_width = AddonCentralFrameWeight*2
			local third_height = AddonHeight
			third:SetSize(third_width, third_height)
			third:SetPoint("TOPLEFT", second, "TOPRIGHT")
			third:SetPropagateMouseClicks(true)
			third.text = third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			third.text:SetAllPoints()
			third.text:SetFontObject(OctoFont11)
			third.text:SetJustifyV("MIDDLE")
			third.text:SetJustifyH("RIGHT")
			third.text:SetTextColor(1, 1, 1, 1)
			frame.third = third
			------------------------------------------------
			-- frame:SetScript("OnLeave", GameTooltip_Hide)
			frame:SetScript("OnHide", func_OnHideFirst)
			frame:SetScript("OnShow", func_OnShowFirst)
			------------------------------------------------
			E.total_widthTOOLTIP = first_width + second_width + third_width
			------------------------------------------------
		end
	end
end
----------------------------------------------------------------
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ + ГОВНО
-- ЭТО ФУНКЦИЯ АПДЕЙТА(ОТРИСОФКИ)
function Octo_EventFrame_OCTOTOOLTIP:Octo_Frame_init(frame, node)
	local data = node:GetData()
	if not data.zxc then return end
	local frameData = data.zxc
	frame.first.text:SetText(frameData.leftText)
	frame.second.text:SetText(frameData.centText)
	frame.third.text:SetText(frameData.righText)
	if frameData.ShownGUID and frameData.ShownGUID == E.curGUID then
		frame.textureFULL:Show()
	else
		frame.textureFULL:Hide()
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- frame.eighth.text:SetText(8)
end
function Octo_EventFrame_OCTOTOOLTIP:Create_OctoTooltip()
	OctoTooltip:SetPoint("CENTER", 0, 0)
	OctoTooltip:SetSize(E.total_widthTOOLTIP, AddonHeight*OctoTooltipDefaultLines) -- НУЛЁВЫЙ ТУЛТИП (E.total_widthTOOLTIP)
	-- OctoTooltip:SetDontSavePosition(Octo_ToDo_DB_Vars.DontSavePosition)
	-- OctoTooltip:SetClampedToScreen(Octo_ToDo_DB_Vars.ClampedToScreen)
	OctoTooltip:SetDontSavePosition(false)
	OctoTooltip:SetClampedToScreen(true)
	OctoTooltip:SetFrameStrata("HIGH")
	OctoTooltip:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	OctoTooltip:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoTooltip:SetBackdropBorderColor(0, 0, 0, 1)
	OctoTooltip:EnableMouse(true)
	OctoTooltip:SetMovable(true)
	OctoTooltip:RegisterForDrag("LeftButton")
	OctoTooltip:SetScript("OnDragStart", function()
			OctoTooltip:SetAlpha(E.bgCa)
			OctoTooltip:StartMoving()
	end)
	OctoTooltip:SetScript("OnDragStop", function()
			OctoTooltip:SetAlpha(1)
			OctoTooltip:StopMovingOrSizing()
	end)
	OctoTooltip:RegisterForClicks("RightButtonUp") -- ПОФИКСИТЬ (ДОБАВИТЬ ОПЦИЮ ЛОКА)
	OctoTooltip:SetScript("OnClick", function(self) self:Hide() end)
	OctoTooltip.ScrollBox = CreateFrame("FRAME", nil, OctoTooltip, "WowScrollBoxList")
	OctoTooltip.ScrollBox:SetAllPoints()
	OctoTooltip.ScrollBox:SetPropagateMouseClicks(true)
	OctoTooltip.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	OctoTooltip.ScrollBox:Layout()
	OctoTooltip.ScrollBar = CreateFrame("EventFrame", nil, OctoTooltip, "MinimalScrollBar")
	OctoTooltip.ScrollBar:SetPoint("TOPLEFT", OctoTooltip.ScrollBox, "TOPRIGHT", 6, 0)
	OctoTooltip.ScrollBar:SetPoint("BOTTOMLEFT", OctoTooltip.ScrollBox, "BOTTOMRIGHT", 6, 0)
	OctoTooltip.view = CreateScrollBoxListTreeListView()
	OctoTooltip.view:SetElementExtent(AddonHeight)
	OctoTooltip.view:SetElementInitializer("BUTTON",
		function(...)
			self:Octo_Frame_init(...)
	end)
	OctoTooltip.view:RegisterCallback(OctoTooltip.view.Event.OnAcquiredFrame, func_OnAcquired, OctoTooltip) -- ПОФИКСИТЬ
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoTooltip.ScrollBox, OctoTooltip.ScrollBar, OctoTooltip.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoTooltip.ScrollBox, OctoTooltip.ScrollBar) -- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	----------------------------------------------------------------
end
function E:OCTOTOOLTIP_CreateMyDataProvider(tbl)
	local count = 0
	local DataProvider = CreateTreeDataProvider()
	E.DataProvider_OCTOTOOLTIP = DataProvider
	-- local times = {}

	if tbl then
		for i, v in ipairs(tbl) do
			local zxc = {
				leftText = i..") "..v[1],
				centText = v[2],
				righText = v[3],
			}
			DataProvider:Insert({zxc = zxc})
		end
		count = (#tbl or 0)
	else
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			-- if GUID == E.curGUID then
				count = count + 1
				local zxc = {
					leftText = CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r",
					centText = CharInfo.PlayerData.curServer,
					righText = CharInfo.PlayerData.guildName,
					ShownGUID = GUID,
				}
				DataProvider:Insert({zxc = zxc})
			-- end
		end
	end




	OctoTooltip.view:SetDataProvider(E.DataProvider_OCTOTOOLTIP, ScrollBoxConstants.RetainScrollPosition)
	if count > 0 and count < OctoTooltipDefaultLines then
		OctoTooltip:SetSize(E.total_widthTOOLTIP, AddonHeight*count)
	elseif count > OctoTooltipDefaultLines then
		OctoTooltip:SetSize(E.total_widthTOOLTIP, AddonHeight*OctoTooltipDefaultLines)
	elseif count == 0 then
		OctoTooltip:SetSize(E.total_widthTOOLTIP, AddonHeight*1)
	end
end




----------------------------------------------------------------
local function CreateMyButtonFrame()
	local tooltip = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		tooltip[#tooltip+1] = {CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r", "XCZ", "ASDASD"}
		tooltip.ShownGUID = GUID
	end

	local function func_OnEnter(frame)
		E:OCTOTOOLTIP_CreateMyDataProvider()
		OctoTooltip:Show()
	end

	local function func_OnLeave()
		OctoTooltip:Hide()
	end

	-- local function func_OnClick(frame)
		-- E:OCTOTOOLTIP_CreateMyDataProvider()
		-- OctoTooltip:SetShown(not OctoTooltip:IsShown())
	-- end
	local btn = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
	btn:SetPoint("TOPLEFT", UIParent, 128, -64)
	btn:SetSize(100, 40)
	btn:SetText("Click me")
	-- btn:SetScript("OnClick", func_OnClick)
	btn:SetScript("OnEnter", func_OnEnter)
	btn:SetScript("OnLeave", func_OnLeave)
	btn:EnableMouse(true)
	btn:SetMovable(true)
	btn:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				btn:SetAlpha(.5)
				btn:StartMoving()
			end
	end)
	btn:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				btn:SetAlpha(1)
				btn:StopMovingOrSizing()
			end
	end)
end
----------------------------------------------------------------
-- ДОЛЖНА ВЫЗЫВАТЬСЯ 1 РАЗ
-- ЧЕТ ТУТ
local MyEventsTable = {
	"ADDON_LOADED",
}
E:func_RegisterMyEventsToFrames(Octo_EventFrame_OCTOTOOLTIP, MyEventsTable)
function Octo_EventFrame_OCTOTOOLTIP:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		CreateMyButtonFrame()
		self:Create_OctoTooltip()
		----------------------------------------------------------------
	end
end