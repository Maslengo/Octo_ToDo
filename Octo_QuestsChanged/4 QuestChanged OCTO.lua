local GlobalAddonName, ns = ...
E = _G.OctoEngine

local Octo_EventFrame_QuestsChanged = CreateFrame("FRAME")
Octo_EventFrame_QuestsChanged:Hide()
local Octo_MainFrame_QuestsChanged = CreateFrame("BUTTON", "Octo_MainFrame_QuestsChanged", UIParent, "BackdropTemplate")
Octo_MainFrame_QuestsChanged:Hide()
----------------------------------------------------------------
local AddonHeight = 20
local AddonLeftFrameWeight = 200
local AddonCentralFrameWeight = 90
local MainFrameDefaultLines = 30
local MainFrameTotalLines = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / AddonHeight))*.7)
if MainFrameDefaultLines > MainFrameTotalLines then
	MainFrameDefaultLines = MainFrameTotalLines
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
-- 		local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
-- 		f:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
-- 		f:SetPoint("TOPLEFT", 8, -2)
-- 		f:SetPoint("BOTTOMRIGHT", -8, 2)
-- 		f:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
-- 		f:SetBackdropBorderColor(0, 0, 0, 1)
-- 		return f
-- end)
----------------------------------------------------------------
----------------------------------------------------------------
E.total_width = E.total_width or 500
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
			local JustifyV = "MIDDLE"
			local JustifyH = "LEFT"
			-- Frame setup
			frame:SetPropagateMouseClicks(true)
			frame:SetPropagateMouseMotion(true)
			------------------------------------------------
			------------------------------------------------
			-- Full texture background
			local frameFULL = CreateFrame("Button", nil, Octo_MainFrame_QuestsChanged)
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
			-- Icon setup
			local icon_1 = frame:CreateTexture(nil, "BACKGROUND")
			local icon_1_width = AddonHeight - 2
			local icon_1_height = AddonHeight - 2
			icon_1:SetSize(icon_1_width, icon_1_height)
			icon_1:SetPoint("TOPLEFT", 1, -1)
			icon_1:SetTexCoord(0.10, 0.90, 0.10, 0.90) -- zoom 10%
			frame.icon_1 = icon_1
			------------------------------------------------
			-- first
			local first = CreateFrame("FRAME", nil, frame)
			local first_width = AddonCentralFrameWeight
			local first_height = AddonHeight
			first:SetSize(first_width, first_height)
			first:SetPoint("TOPLEFT", icon_1, "TOPRIGHT")
			first:SetPropagateMouseClicks(true)
			first.text = first:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			first.text:SetAllPoints()
			first.text:SetFontObject(OctoFont11)
			first.text:SetJustifyV(JustifyV)
			first.text:SetJustifyH(JustifyH)
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
			second.text:SetJustifyV(JustifyV)
			second.text:SetJustifyH("RIGHT")
			second.text:SetTextColor(1, 1, 1, 1)
			frame.second = second
			------------------------------------------------
			-- Icon setup
			local icon_2 = frame:CreateTexture(nil, "BACKGROUND")
			local icon_2_width = AddonHeight - 2
			local icon_2_height = AddonHeight - 2
			icon_2:SetSize(icon_2_width, icon_2_height)
			icon_2:SetPoint("TOPLEFT", second, "TOPRIGHT", 1, -1)
			icon_2:SetTexCoord(0.10, 0.90, 0.10, 0.90) -- zoom 10%
			frame.icon_2 = icon_2
			------------------------------------------------
			-- third
			local third = CreateFrame("FRAME", nil, frame)
			local third_width = AddonCentralFrameWeight*2
			local third_height = AddonHeight
			third:SetSize(third_width, third_height)
			third:SetPoint("TOPLEFT", icon_2, "TOPRIGHT")
			third:SetPropagateMouseClicks(true)
			third.text = third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			third.text:SetAllPoints()
			third.text:SetFontObject(OctoFont11)
			third.text:SetJustifyV(JustifyV)
			third.text:SetJustifyH(JustifyH)
			third.text:SetTextColor(1, 1, 1, 1)
			frame.third = third
			------------------------------------------------
			-- fourth
			local fourth = CreateFrame("FRAME", nil, frame)
			local fourth_width = AddonCentralFrameWeight
			local fourth_height = AddonHeight
			fourth:SetSize(fourth_width, fourth_height)
			fourth:SetPoint("TOPLEFT", third, "TOPRIGHT")
			fourth:SetPropagateMouseClicks(true)
			fourth.text = fourth:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			fourth.text:SetAllPoints()
			fourth.text:SetFontObject(OctoFont11)
			fourth.text:SetJustifyV(JustifyV)
			fourth.text:SetJustifyH("RIGHT")
			fourth.text:SetTextColor(1, 1, 1, 1)
			frame.fourth = fourth
			------------------------------------------------
			-- fifth
			local fifth = CreateFrame("FRAME", nil, frame)
			local fifth_width = AddonCentralFrameWeight*2
			local fifth_height = AddonHeight
			fifth:SetSize(fifth_width, fifth_height)
			fifth:SetPoint("TOPLEFT", fourth, "TOPRIGHT")
			fifth:SetPropagateMouseClicks(true)
			fifth.text = fifth:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			fifth.text:SetAllPoints()
			fifth.text:SetFontObject(OctoFont11)
			fifth.text:SetJustifyV(JustifyV)
			fifth.text:SetJustifyH(JustifyH)
			fifth.text:SetTextColor(1, 1, 1, 1)
			frame.fifth = fifth
			------------------------------------------------
			-- sixth
			local sixth = CreateFrame("FRAME", nil, frame)
			local sixth_width = AddonCentralFrameWeight
			local sixth_height = AddonHeight
			sixth:SetSize(sixth_width, sixth_height)
			sixth:SetPoint("TOPLEFT", fifth, "TOPRIGHT")
			sixth:SetPropagateMouseClicks(true)
			sixth.text = sixth:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			sixth.text:SetAllPoints()
			sixth.text:SetFontObject(OctoFont11)
			sixth.text:SetJustifyV(JustifyV)
			sixth.text:SetJustifyH("CENTER")
			sixth.text:SetTextColor(1, 1, 1, 1)
			frame.sixth = sixth
			------------------------------------------------
			-- seventh
			local seventh = CreateFrame("FRAME", nil, frame)
			local seventh_width = AddonCentralFrameWeight
			local seventh_height = AddonHeight
			seventh:SetSize(seventh_width, seventh_height)
			seventh:SetPoint("TOPLEFT", sixth, "TOPRIGHT")
			seventh:SetPropagateMouseClicks(true)
			seventh.text = seventh:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			seventh.text:SetAllPoints()
			seventh.text:SetFontObject(OctoFont11)
			seventh.text:SetJustifyV(JustifyV)
			seventh.text:SetJustifyH("CENTER")
			seventh.text:SetTextColor(1, 1, 1, 1)
			frame.seventh = seventh
			-- ------------------------------------------------
			-- -- eighth
			-- local eighth = CreateFrame("FRAME", nil, frame)
			-- local eighth_width = AddonCentralFrameWeight
			-- local eighth_height = AddonHeight
			-- eighth:SetSize(eighth_width, eighth_height)
			-- eighth:SetPoint("TOPLEFT", seventh, "TOPRIGHT")
			-- eighth:SetPropagateMouseClicks(true)
			-- eighth.text = eighth:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			-- eighth.text:SetAllPoints()
			-- eighth.text:SetFontObject(OctoFont11)
			-- eighth.text:SetJustifyV(JustifyV)
			-- eighth.text:SetJustifyH(JustifyH)
			-- eighth.text:SetTextColor(1, 1, 1, 1)
			-- frame.eighth = eighth



			frame:SetScript("OnHide", func_OnHideFirst)
			frame:SetScript("OnShow", func_OnShowFirst)






			------------------------------------------------
			E.total_width = icon_1_width + first_width + icon_2_width + second_width + third_width + fourth_width + fifth_width + sixth_width + seventh_width -- + eighth_width
			------------------------------------------------
		end
	end
end
----------------------------------------------------------------
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ + ГОВНО
-- ЭТО ФУНКЦИЯ АПДЕЙТА(ОТРИСОФКИ)
function Octo_EventFrame_QuestsChanged:Octo_Frame_init(frame, node)
	local data = node:GetData()
	if not data.zxc then return end
	local frameData = data.zxc
	local playerName = (frameData.classColorHex or E.Red_Color)..(frameData.playerName or UNKNOWN).."|r-"..E:func_CurServerShort(frameData.curServer)




	frame.icon_1:SetTexture(frameData.specIcon)
	frame.first.text:SetText(playerName)



	if frameData.type == "QC_Quests" then
		if E:func_IsAccountQuest(frameData.id) or E:func_IsQuestFlaggedCompletedOnAccount(frameData.id) then
			frame.icon_2:SetAtlas("warbands-icon")
		else
			frame.icon_2:SetTexture(E.Icon_Empty)
		end
		frame.third.text:SetText(E:func_questName_SIMPLE(frameData.id))
	elseif frameData.type == "QC_Vignettes" then
		if frameData.atlas then
			frame.icon_2:SetAtlas(frameData.atlas)
		else
			frame.icon_2:SetAtlas(E.Icon_Empty)
		end
		frame.third.text:SetText(frameData.name)
	end

	if Octo_ToDo_DB_Vars.QC_Vignettes and Octo_ToDo_DB_Vars.QC_Quests and frameData.type == "QC_Quests" then
		frame.textureFULL:Show()
	else
		frame.textureFULL:Hide()
	end

	if frameData.id then
		frame.second.text:SetText(E.Gray_Color.."id: "..frameData.id.."|r")
	else
		frame.second.text:SetText("QWEQWEQWEQWEQWEQWE")
	end
	if frameData.mapID then
		frame.fourth.text:SetText(E.Gray_Color.."id: "..frameData.mapID.. "|r")
	else
		frame.second.text:SetText("QWEQWEQWEQWEQWEQWE")
	end
	----------------------------------------------------------------
	if frameData.curLocation and frameData.curLocation ~= "" then
		frame.fifth.text:SetText(frameData.curLocation)
	elseif frameData.mapID then
		frame.fifth.text:SetText(E:func_GetMapName(frameData.mapID))
	else
		frame.fifth.text:SetText("QWEQWEQWEQWEQWEQWE")
	end
	----------------------------------------------------------------
	-- frame.sixth.text:SetText(E.Green_Color..E:func_GetCoordFormated(frameData.x, frameData.y).."|r")
	frame.sixth.text:SetText(E:func_GetCoordFormated(frameData.x, frameData.y))


	if self.minTime then
		local done = frameData.time - self.minTime
		-- local total = self.maxTime - self.minTime
		local total = time() - self.minTime
		local red = min(255, (1 - done / total) * 510)
		local green = min(255, (done / total) * 510)
		local hexcolor = string.format("|cff%2x%2x00", red, green)
		frame.seventh.text:SetText(hexcolor..E:func_SecondsToClock(time()-frameData.time).."|r")
	end
	-- frame.eighth.text:SetText(8)
end
function Octo_EventFrame_QuestsChanged:Octo_Create_MainFrame_QuestsChanged()
	Octo_MainFrame_QuestsChanged:SetPoint("CENTER", 0, 0)
	-- Octo_MainFrame_QuestsChanged:SetSize(AddonCentralFrameWeight*7, AddonHeight*MainFrameDefaultLines)
	Octo_MainFrame_QuestsChanged:SetSize(E.total_width, AddonHeight*MainFrameDefaultLines)
	Octo_MainFrame_QuestsChanged:SetDontSavePosition(Octo_ToDo_DB_Vars.DontSavePosition)
	Octo_MainFrame_QuestsChanged:SetClampedToScreen(Octo_ToDo_DB_Vars.ClampedToScreen)
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
function E:QuestsChanged_CreateMyDataProvider()
	local count = 0
	local DataProvider = CreateTreeDataProvider()
	E.DataProvider_QuestsChanged = DataProvider
	local times = {}
	-- Octo_QuestsChanged_DB = Octo_QuestsChanged_DB or {}
	-- Octo_QuestsChanged_DB.QC_Quests = Octo_QuestsChanged_DB.QC_Quests or {}
	-- Octo_QuestsChanged_DB.QC_Vignettes = Octo_QuestsChanged_DB.QC_Vignettes or {}


	if Octo_ToDo_DB_Vars.QC_Quests then
		for k, v in next, (Octo_QuestsChanged_DB.QC_Quests) do
			if v.time then tinsert(times, v.time) end
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
				curLocation = v.curLocation,
				specIcon = v.specIcon,
				type = "QC_Quests",
			}
			DataProvider:Insert({zxc = zxc})
		end
	end

	if Octo_ToDo_DB_Vars.QC_Vignettes then
		for k, v in next, (Octo_QuestsChanged_DB.QC_Vignettes) do
			if v.time then tinsert(times, v.time) end
			count = count + 1
			local zxc = {
				id = v.id,
				time = v.time,
				mapID = v.mapID,
				x = v.x,
				y = v.y,
				atlas = v.atlas,
				curServer = v.curServer,
				playerName = v.playerName,
				classColorHex = v.classColorHex,
				curLocation = v.curLocation,
				specIcon = v.specIcon,
				type = "QC_Vignettes",
				name = v.name,
			}
			DataProvider:Insert({zxc = zxc})
		end
	end
	if #times > 0 then
		Octo_EventFrame_QuestsChanged.minTime = math.min(unpack(times))
		Octo_EventFrame_QuestsChanged.maxTime = math.max(unpack(times))
	end
	DataProvider:SetSortComparator(function(a, b)
			local aData = a.data.zxc
			local bData = b.data.zxc
			return aData.time > bData.time
	end)
	DataProvider:Sort()
	-- SetDataProvider триггерит создания фреймов
	Octo_MainFrame_QuestsChanged.view:SetDataProvider(E.DataProvider_QuestsChanged, ScrollBoxConstants.RetainScrollPosition)

	if count > MainFrameDefaultLines then
		Octo_MainFrame_QuestsChanged:SetSize(E.total_width, AddonHeight*MainFrameDefaultLines)
	elseif count == 0 then
		Octo_MainFrame_QuestsChanged:SetSize(E.total_width, AddonHeight*1)
	else
		Octo_MainFrame_QuestsChanged:SetSize(E.total_width, AddonHeight*count)
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
-- ДОЛЖНА ВЫЗЫВАТЬСЯ 1 РАЗ
-- ЧЕТ ТУТ
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_LOGIN",
}
E:func_RegisterMyEventsToFrames(Octo_EventFrame_QuestsChanged, MyEventsTable)
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
		self:Octo_Create_MainFrame_QuestsChanged()
		E:QuestsChanged_CreateMyDataProvider()
		----------------------------------------------------------------
		E:func_CreateMinimapButton(GlobalAddonName, "QuestsChanged", Octo_QuestsChanged_DB, Octo_MainFrame_QuestsChanged, function() E:QuestsChanged_CreateMyDataProvider() end, "Octo_MainFrame_QuestsChanged")
		----------------------------------------------------------------
	end
end
----------------------------------------------------------------
function Octo_EventFrame_QuestsChanged:PLAYER_REGEN_DISABLED()
	if Octo_MainFrame_QuestsChanged and Octo_MainFrame_QuestsChanged:IsShown() then
		Octo_MainFrame_QuestsChanged:Hide()
	end
end
function Octo_EventFrame_QuestsChanged:PLAYER_LOGIN()
	-- Cleanup event
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
	E:func_Create_DD_ToDo(Octo_MainFrame_QuestsChanged)
end