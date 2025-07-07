-- ДАТА ПРОВАЙДЕР - ОБНОВЛЕНИЕ ПРИ КЛИКЕ
-- СОРТИРОВКА ТЕКУЩЕЙ ТАБЛЫ
local GlobalAddonName, E = ...
local Octo_EventFrame_QuestsChanged = CreateFrame("FRAME")
Octo_EventFrame_QuestsChanged:Hide()
local Octo_MainFrame_QuestsChanged = CreateFrame("BUTTON", "Octo_MainFrame_QuestsChanged", UIParent, "BackdropTemplate")
Octo_MainFrame_QuestsChanged:Hide()
tinsert(UISpecialFrames, "Octo_MainFrame_QuestsChanged")
tinsert(E.OctoTable_Frames, Octo_MainFrame_QuestsChanged)
----------------------------------------------------------------
local AddonHeight = 20
local AddonLeftFrameWeight = 200
local AddonCentralFrameWeight = 90
local MainFrameDefaultLines = 30
local MainFrameTotalLines = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / AddonHeight))*.7)
if MainFrameDefaultLines > MainFrameTotalLines then
	MainFrameDefaultLines = MainFrameTotalLines
end
local SFDropDownWeight = 100
local MaxNumCharacters = 10
local r, g, b = GetClassColor(E.classFilename)
local TEXTURE_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga"
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
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
----------------------------------------------------------------
local ADDON_ACTIONS_BLOCKED = { }
local ALL_CHARACTERS = "All"
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
local func_OnAcquired do
	local function func_OnEnter(frame)
		frame.texture:Show()
	end
	local function func_OnLeave(frame)
		frame.texture:Hide()
	end
	------------------------------------------------
	function func_OnAcquired(owner, frame, data, new)
		if new then
			-- |    1player        |    2id       |    3name                |   4 mapID        |    5mapName        |    6coords            |    7time?    |    closebutton    |
			-- |    Масленго   |    29438    |    В яблочко!        |    84            |    Штормград        |    33.39, 35.23        |    59мин    |
			------------------------------------------------
			-- Frame setup
			frame:SetPropagateMouseClicks(true)
			frame:SetPropagateMouseMotion(true)
			-- Full texture background
			local frameFULL = CreateFrame("Frame", nil, Octo_MainFrame_QuestsChanged)
			frameFULL:SetPropagateMouseClicks(true)
			frameFULL:SetPropagateMouseMotion(true)
			frameFULL:SetFrameLevel(frame:GetFrameLevel()+2)
			local texture = frameFULL:CreateTexture(nil, "BACKGROUND", nil, 3)
			texture:Hide()
			texture:SetAllPoints()
			texture:SetTexture(TEXTURE_PATH)
			texture:SetVertexColor(r, g, b, E.bgCaOverlay)
			frameFULL.texture = texture
			frameFULL:SetPoint("LEFT", frame)
			frameFULL:SetPoint("TOP", frame)
			frameFULL:SetPoint("BOTTOM", frame)
			frameFULL:SetPoint("RIGHT")
			frameFULL:SetScript("OnEnter", func_OnEnter)
			frameFULL:SetScript("OnLeave", func_OnLeave)
			------------------------------------------------
			-- Icon setup
			local icon = frame:CreateTexture(nil, "BACKGROUND")
			icon:SetSize(AddonHeight - 2, AddonHeight - 2)
			icon:SetPoint("TOPLEFT", 1, -1)
			icon:SetTexCoord(0.10, 0.90, 0.10, 0.90) -- zoom 10%
			frame.icon_1 = icon
			------------------------------------------------
			-- -- first
			local first = CreateFrame("Frame", nil, frame)
			first:SetPropagateMouseClicks(true)
			first:SetSize(AddonCentralFrameWeight, AddonHeight)
			first:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonCentralFrameWeight*0, 0)
			first:SetScript("OnLeave", GameTooltip_Hide)
			first.textLEFT = first:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			first.textLEFT:SetAllPoints()
			first.textLEFT:SetFontObject(OctoFont11)
			first.textLEFT:SetJustifyV("MIDDLE")
			first.textLEFT:SetJustifyH("LEFT")
			first.textLEFT:SetTextColor(1, 1, 1, 1)
			frame.first = first
			------------------------------------------------
			-- second
			local second = CreateFrame("Frame", nil, frame)
			second:SetPropagateMouseClicks(true)
			second:SetSize(AddonCentralFrameWeight, AddonHeight)
			second:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonCentralFrameWeight*0, 0)
			second:SetScript("OnLeave", GameTooltip_Hide)
			second.textLEFT = second:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			second.textLEFT:SetAllPoints()
			second.textLEFT:SetFontObject(OctoFont11)
			second.textLEFT:SetJustifyV("MIDDLE")
			second.textLEFT:SetJustifyH("LEFT")
			second.textLEFT:SetTextColor(1, 1, 1, 1)
			frame.second = second
			------------------------------------------------
			-- third
			local third = CreateFrame("Frame", nil, frame)
			third:SetPropagateMouseClicks(true)
			third:SetSize(AddonCentralFrameWeight, AddonHeight)
			third:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonCentralFrameWeight*1, 0)
			third:SetScript("OnLeave", GameTooltip_Hide)
			third.textLEFT = third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			third.textLEFT:SetAllPoints()
			third.textLEFT:SetFontObject(OctoFont11)
			third.textLEFT:SetJustifyV("MIDDLE")
			third.textLEFT:SetJustifyH("LEFT")
			third.textLEFT:SetTextColor(1, 1, 1, 1)
			frame.third = third
			------------------------------------------------
			-- fourth
			local fourth = CreateFrame("Frame", nil, frame)
			fourth:SetPropagateMouseClicks(true)
			fourth:SetSize(AddonCentralFrameWeight, AddonHeight)
			fourth:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonCentralFrameWeight*2, 0)
			fourth:SetScript("OnLeave", GameTooltip_Hide)
			fourth.textLEFT = fourth:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			fourth.textLEFT:SetAllPoints()
			fourth.textLEFT:SetFontObject(OctoFont11)
			fourth.textLEFT:SetJustifyV("MIDDLE")
			fourth.textLEFT:SetJustifyH("LEFT")
			fourth.textLEFT:SetTextColor(1, 1, 1, 1)
			frame.fourth = fourth
			------------------------------------------------
			-- fifth
			local fifth = CreateFrame("Frame", nil, frame)
			fifth:SetPropagateMouseClicks(true)
			fifth:SetSize(AddonCentralFrameWeight, AddonHeight)
			fifth:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonCentralFrameWeight*3, 0)
			fifth:SetScript("OnLeave", GameTooltip_Hide)
			fifth.textLEFT = fifth:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			fifth.textLEFT:SetAllPoints()
			fifth.textLEFT:SetFontObject(OctoFont11)
			fifth.textLEFT:SetJustifyV("MIDDLE")
			fifth.textLEFT:SetJustifyH("LEFT")
			fifth.textLEFT:SetTextColor(1, 1, 1, 1)
			frame.fifth = fifth
			------------------------------------------------
			-- sixth
			local sixth = CreateFrame("Frame", nil, frame)
			sixth:SetPropagateMouseClicks(true)
			sixth:SetSize(AddonCentralFrameWeight, AddonHeight)
			sixth:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonCentralFrameWeight*4, 0)
			sixth:SetScript("OnLeave", GameTooltip_Hide)
			sixth.textLEFT = sixth:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			sixth.textLEFT:SetAllPoints()
			sixth.textLEFT:SetFontObject(OctoFont11)
			sixth.textLEFT:SetJustifyV("MIDDLE")
			sixth.textLEFT:SetJustifyH("LEFT")
			sixth.textLEFT:SetTextColor(1, 1, 1, 1)
			frame.sixth = sixth
			------------------------------------------------
			-- seventh
			local seventh = CreateFrame("Frame", nil, frame)
			seventh:SetPropagateMouseClicks(true)
			seventh:SetSize(AddonCentralFrameWeight, AddonHeight)
			seventh:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonCentralFrameWeight*5, 0)
			seventh:SetScript("OnLeave", GameTooltip_Hide)
			seventh.textLEFT = seventh:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			seventh.textLEFT:SetAllPoints()
			seventh.textLEFT:SetFontObject(OctoFont11)
			seventh.textLEFT:SetJustifyV("MIDDLE")
			seventh.textLEFT:SetJustifyH("LEFT")
			seventh.textLEFT:SetTextColor(1, 1, 1, 1)
			frame.seventh = seventh
			------------------------------------------------
			-- eighth
			local eighth = CreateFrame("Frame", nil, frame)
			eighth:SetPropagateMouseClicks(true)
			eighth:SetSize(AddonCentralFrameWeight, AddonHeight)
			eighth:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonCentralFrameWeight*6, 0)
			eighth:SetScript("OnLeave", GameTooltip_Hide)
			eighth.textLEFT = eighth:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			eighth.textLEFT:SetAllPoints()
			eighth.textLEFT:SetFontObject(OctoFont11)
			eighth.textLEFT:SetJustifyV("MIDDLE")
			eighth.textLEFT:SetJustifyH("LEFT")
			eighth.textLEFT:SetTextColor(1, 1, 1, 1)
			frame.eighth = eighth
			------------------------------------------------
			------------------------------------------------
		end
	end
end
----------------------------------------------------------------
local function UpdateExpandOrCollapseButtonState(button, isCollapsed)
	if (isCollapsed) then
		button:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\SimpleAddonManager\\zakrito")
		button:SetVertexColor(1, 0, 0, 1)
		-- button:SetTexture("Interface\\Buttons\\UI-PlusButton-Up")
	else
		button:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\SimpleAddonManager\\otkrito")
		button:SetVertexColor(1, 1, 1, 1)
		-- button:SetTexture("Interface\\Buttons\\UI-MinusButton-Up")
	end
end
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ + ГОВНО
-- ЭТО ФУНКЦИЯ АПДЕЙТА(ОТРИСОФКИ)
function Octo_EventFrame_QuestsChanged:Octo_Frame_init(frame, node)
	local data = node:GetData()
	if not data.zxc then return end
	local frameData = data.zxc
	-- local index = node:GetData().index
	-- frame.icon_1:SetTexture(data.headerIcon or (data.zxc and data.zxc.icon) or E.Icon_Empty)
	frame.icon_1:SetTexture(E.Icon_LFG)
	frame.second.textLEFT:SetText(frameData.classColorHex..frameData.playerName.."|r-"..E.func_CurServerShort(frameData.curServer))
	frame.third.textLEFT:SetText(frameData.id)
	frame.fourth.textLEFT:SetText(E.func_questName(frameData.id))
	frame.fifth.textLEFT:SetText(frameData.mapID)
	frame.sixth.textLEFT:SetText(E.func_GetMapName(frameData.mapID))
	-- frame.seventh.textLEFT:SetText(string.format("%.1f", frameData.x*100).." / "..string.format("%.1f", frameData.y*100))
	frame.seventh.textLEFT:SetText(E.func_GetCoordFormated(frameData.x, frameData.y))
	frame.eighth.textLEFT:SetText(E.func_SecondsToClock(time()-frameData.time))
end
function Octo_EventFrame_QuestsChanged:Octo_Create_MainFrame_QuestsChanged()
	Octo_MainFrame_QuestsChanged:SetPoint("CENTER", 0, 0)
	Octo_MainFrame_QuestsChanged:SetSize(AddonCentralFrameWeight*7, AddonHeight*MainFrameDefaultLines)
	Octo_MainFrame_QuestsChanged:SetDontSavePosition(true)
	Octo_MainFrame_QuestsChanged:SetClampedToScreen(false)
	Octo_MainFrame_QuestsChanged:SetFrameStrata("HIGH")
	Octo_MainFrame_QuestsChanged:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	Octo_MainFrame_QuestsChanged:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	Octo_MainFrame_QuestsChanged:SetBackdropBorderColor(0, 0, 0, 1)
	Octo_MainFrame_QuestsChanged:EnableMouse(true)
	Octo_MainFrame_QuestsChanged:SetMovable(true)
	Octo_MainFrame_QuestsChanged:RegisterForDrag("LeftButton")
	Octo_MainFrame_QuestsChanged:SetScript("OnDragStart", function()
			Octo_MainFrame_QuestsChanged:SetAlpha(E.bgCa)
			Octo_MainFrame_QuestsChanged:StartMoving()
	end)
	Octo_MainFrame_QuestsChanged:SetScript("OnDragStop", function()
			Octo_MainFrame_QuestsChanged:SetAlpha(1)
			Octo_MainFrame_QuestsChanged:StopMovingOrSizing()
	end)
	Octo_MainFrame_QuestsChanged:RegisterForClicks("RightButtonUp") -- ПОФИКСИТЬ (ДОБАВИТЬ ОПЦИЮ ЛОКА)
	Octo_MainFrame_QuestsChanged:SetScript("OnClick", function(self) self:Hide() end)
	Octo_MainFrame_QuestsChanged.ScrollBox = CreateFrame("FRAME", nil, Octo_MainFrame_QuestsChanged, "WowScrollBoxList")
	Octo_MainFrame_QuestsChanged.ScrollBox:SetAllPoints()
	Octo_MainFrame_QuestsChanged.ScrollBox:SetPropagateMouseClicks(true)
	Octo_MainFrame_QuestsChanged.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	Octo_MainFrame_QuestsChanged.ScrollBox:Layout()
	Octo_MainFrame_QuestsChanged.ScrollBar = CreateFrame("EventFrame", nil, Octo_MainFrame_QuestsChanged, "MinimalScrollBar")
	Octo_MainFrame_QuestsChanged.ScrollBar:SetPoint("TOPLEFT", Octo_MainFrame_QuestsChanged.ScrollBox, "TOPRIGHT", 6, 0)
	Octo_MainFrame_QuestsChanged.ScrollBar:SetPoint("BOTTOMLEFT", Octo_MainFrame_QuestsChanged.ScrollBox, "BOTTOMRIGHT", 6, 0)
	Octo_MainFrame_QuestsChanged.view = CreateScrollBoxListTreeListView()
	Octo_MainFrame_QuestsChanged.view:SetElementExtent(AddonHeight)
	Octo_MainFrame_QuestsChanged.view:SetElementInitializer("BUTTON",
		function(...)
			self:Octo_Frame_init(...)
	end)
	Octo_MainFrame_QuestsChanged.view:RegisterCallback(Octo_MainFrame_QuestsChanged.view.Event.OnAcquiredFrame, func_OnAcquired, Octo_MainFrame_QuestsChanged) -- ПОФИКСИТЬ
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_QuestsChanged.ScrollBox, Octo_MainFrame_QuestsChanged.ScrollBar, Octo_MainFrame_QuestsChanged.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_QuestsChanged.ScrollBox, Octo_MainFrame_QuestsChanged.ScrollBar) -- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	----------------------------------------------------------------
end
function E.QuestsChanged_CreateMyDataProvider()
	print ("QuestsChanged_CreateMyDataProvider")
	local count = 0
	local DataProvider = CreateTreeDataProvider()
	E.DataProvider_QuestsChanged = DataProvider
	for k, v in next, (Octo_QuestsChangedDB.log) do
		count = count + 1
		local zxc = {
			id = v.id,
			time = v.time,
			mapID = v.mapID,
			x = v.x,
			y = v.y,
			curServer = v.curServer,
			playerName = v.playerName,
			classColorHex = v.classColorHex,
		}
		local groupNode = DataProvider:Insert({zxc = zxc})
	end
	DataProvider:SetSortComparator(function(a, b)
			local aData = a.data.zxc
			local bData = b.data.zxc
			return aData.time > bData.time
	end)
	DataProvider:Sort()
	if count > 0 and count < MainFrameDefaultLines then
		Octo_MainFrame_QuestsChanged:SetSize(AddonCentralFrameWeight*7, AddonHeight*count)
	elseif count > MainFrameDefaultLines then
		Octo_MainFrame_QuestsChanged:SetSize(AddonCentralFrameWeight*7, AddonHeight*MainFrameDefaultLines)
	elseif count == 0 then
		Octo_MainFrame_QuestsChanged:SetSize(AddonCentralFrameWeight*7, AddonHeight*1)
	end
	Octo_MainFrame_QuestsChanged.view:SetDataProvider(E.DataProvider_QuestsChanged, ScrollBoxConstants.RetainScrollPosition)
end
----------------------------------------------------------------
----------------------------------------------------------------
-- ДОЛЖНА ВЫЗЫВАТЬСЯ 1 РАЗ
-- ЧЕТ ТУТ
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
	"PLAYER_REGEN_DISABLED",
	"QUEST_LOG_UPDATE",
	"ENCOUNTER_LOOT_RECEIVED",
	-- Vignettes
	"PLAYER_ENTERING_WORLD",
	"VIGNETTE_MINIMAP_UPDATED",
	"VIGNETTES_UPDATED",
}
E.RegisterMyEventsToFrames(Octo_EventFrame_QuestsChanged, MyEventsTable, E.func_DebugPath())
function Octo_EventFrame_QuestsChanged:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if Octo_ToDo_DB_Vars.AddonHeight then
			AddonHeight = Octo_ToDo_DB_Vars.AddonHeight
		end
		if Octo_ToDo_DB_Vars.AddonLeftFrameWeight then
			AddonLeftFrameWeight = Octo_ToDo_DB_Vars.AddonLeftFrameWeight
		end
		if Octo_ToDo_DB_Vars.AddonCentralFrameWeight then
			AddonCentralFrameWeight = Octo_ToDo_DB_Vars.AddonCentralFrameWeight
		end
		if Octo_ToDo_DB_Vars.MainFrameDefaultLines then
			MainFrameDefaultLines = Octo_ToDo_DB_Vars.MainFrameDefaultLines
		end
		if Octo_ToDo_DB_Vars.SFDropDownWeight then
			SFDropDownWeight = Octo_ToDo_DB_Vars.SFDropDownWeight
		end
		if Octo_ToDo_DB_Vars.MaxNumCharacters then
			MaxNumCharacters = Octo_ToDo_DB_Vars.MaxNumCharacters
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		self:Octo_Create_MainFrame_QuestsChanged()
		E.QuestsChanged_CreateMyDataProvider()
		----------------------------------------------------------------
		E:func_CreateUtilsButton(Octo_MainFrame_QuestsChanged, "QuestsChanged", AddonHeight, 0)
		E:func_CreateMinimapButton(GlobalAddonName, "QuestsChanged", Octo_QuestsChangedDB, Octo_MainFrame_QuestsChanged, function() E.QuestsChanged_CreateMyDataProvider() end, "Octo_MainFrame_QuestsChanged")
		-- Octo_MainFrame_QuestsChanged:SetScript("OnShow", function()
		--         C_Timer.After(.1, function()
		--                 E.QuestsChanged_CreateMyDataProvider()
		--         end)
		-- end)
		----------------------------------------------------------------
	end
end
----------------------------------------------------------------
function Octo_EventFrame_QuestsChanged:PLAYER_REGEN_DISABLED()
	print ("PLAYER_REGEN_DISABLED")
	if Octo_MainFrame_QuestsChanged and Octo_MainFrame_QuestsChanged:IsShown() then
		Octo_MainFrame_QuestsChanged:Hide()
	end
end
-- function Octo_EventFrame_QuestsChanged:PLAYER_LOGIN()
--     print ("PLAYER_LOGIN")
-- end
-- function Octo_EventFrame_QuestsChanged:QUEST_LOG_UPDATE()
--     if InCombatLockdown() or self.QUEST_LOG_UPDATE_Pause then return end
--     self.QUEST_LOG_UPDATE_Pause = true
--     C_Timer.After(5, function()
--             print ("QUEST_LOG_UPDATE")
--             E.QuestsChanged_CreateMyDataProvider()
--             self.QUEST_LOG_UPDATE_Pause = nil
--     end)
-- end
-- function Octo_EventFrame_QuestsChanged:ENCOUNTER_LOOT_RECEIVED()
--     if InCombatLockdown() or self.ENCOUNTER_LOOT_RECEIVED_Pause then return end
--     self.ENCOUNTER_LOOT_RECEIVED_Pause = true
--     C_Timer.After(1, function()
--             print ("ENCOUNTER_LOOT_RECEIVED")
--             E.QuestsChanged_CreateMyDataProvider()
--             self.ENCOUNTER_LOOT_RECEIVED_Pause = nil
--     end)
-- end
-- function Octo_EventFrame_QuestsChanged:PLAYER_ENTERING_WORLD()
--     if InCombatLockdown() or self.PLAYER_ENTERING_WORLD_Pause then return end
--     self.PLAYER_ENTERING_WORLD_Pause = true
--     C_Timer.After(1, function()
--             print ("PLAYER_ENTERING_WORLD")
--             E.QuestsChanged_CreateMyDataProvider()
--             self.PLAYER_ENTERING_WORLD_Pause = nil
--     end)
-- end
-- function Octo_EventFrame_QuestsChanged:VIGNETTE_MINIMAP_UPDATED()
--     if InCombatLockdown() or self.VIGNETTE_MINIMAP_UPDATED_Pause then return end
--     self.VIGNETTE_MINIMAP_UPDATED_Pause = true
--     C_Timer.After(1, function()
--             print ("VIGNETTE_MINIMAP_UPDATED")
--             E.QuestsChanged_CreateMyDataProvider()
--             self.VIGNETTE_MINIMAP_UPDATED_Pause = nil
--     end)
-- end
-- function Octo_EventFrame_QuestsChanged:VIGNETTES_UPDATED()
--     if InCombatLockdown() or self.VIGNETTES_UPDATED_Pause then return end
--     self.VIGNETTES_UPDATED_Pause = true
--     C_Timer.After(1, function()
--             print ("VIGNETTES_UPDATED")
--             E.QuestsChanged_CreateMyDataProvider()
--             self.VIGNETTES_UPDATED_Pause = nil
--     end)
-- end