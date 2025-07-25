local GlobalAddonName, ns = ...
E = _G.OctoEngine

local Octo_EventFrame_Achievements = CreateFrame("FRAME")
Octo_EventFrame_Achievements:Hide()
local Octo_MainFrame_Achievements = CreateFrame("BUTTON", "Octo_MainFrame_Achievements", UIParent, "BackdropTemplate")
Octo_MainFrame_Achievements:Hide()
----------------------------------------------------------------
local AddonHeight = 20
local AddonLeftFrameWeight = 200
local AddonCentralFrameWeight = 90
local MainFrameDefaultLines = 30
local MainFrameTotalLines = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / AddonHeight))*.7)
if MainFrameDefaultLines > MainFrameTotalLines then
	MainFrameDefaultLines = MainFrameTotalLines
end
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
----------------------------------------------------------------
local table_insert = table.insert
local table_concat = table.concat
local CreateFrame = CreateFrame
local GetAchievementInfo = GetAchievementInfo
local GetCategoryNumAchievements = GetCategoryNumAchievements
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local IsTracking = C_ContentTracking.IsTracking
local StartTracking = C_ContentTracking.StartTracking
local StopTracking = C_ContentTracking.StopTracking
----------------------------------------------------------------
local function ToggleAchievement(AchievementID)
	if E:func_achievementComplete(AchievementID) and IsTracking(2, AchievementID) then
		return StopTracking(2, AchievementID, 2)
	elseif E:func_achievementComplete(AchievementID) then
		return
	elseif IsTracking(2, AchievementID) then
		return StopTracking(2, AchievementID, 2)
	else
		return StartTracking(2, AchievementID)
	end
end
------------------------------------------------
------------------------------------------------
------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
local func_OnAcquired do
	------------------------------------------------
	local function func_OnClick(frame)
		if Octo_MainFrame_Achievements:IsDragging() then
			return
		end
		local AchievementID = frame:GetData().AchievementID
		ToggleAchievement(AchievementID)
	end
	------------------------------------------------
	local function func_OnEnter(frame)
		E:func_OctoTooltip_OnEnter(frame, false, false)
	end
	------------------------------------------------
	function func_OnAcquired(owner, frame, data, new)
		if new then
			local JustifyV = "MIDDLE"
			local JustifyH = "LEFT"
			------------------------------------------------
			frame:SetPropagateMouseClicks(true)
			frame:SetPropagateMouseMotion(true)
			------------------------------------------------
			-- Full texture background
			local frameFULL = CreateFrame("Button", nil, Octo_MainFrame_Achievements)
			frameFULL:SetPropagateMouseClicks(true)
			frameFULL:SetPropagateMouseMotion(true)
			frameFULL:SetFrameLevel(frame:GetFrameLevel()+2)
			frameFULL:SetHighlightAtlas(E.TEXTURE_HIGHLIGHT_ATLAS, "ADD")
			frameFULL.HighlightTexture = frameFULL:GetHighlightTexture()
			frameFULL.HighlightTexture:SetAlpha(.2)
			frameFULL:SetPoint("LEFT", frame)
			frameFULL:SetPoint("TOP", frame)
			frameFULL:SetPoint("BOTTOM", frame)
			frameFULL:SetPoint("RIGHT")
			------------------------------------------------
			------------------------------------------------
			frame.icon_1 = frame:CreateTexture(nil, "BACKGROUND", nil, 5)
			frame.icon_1:SetPoint("TOPLEFT", 1, -1)
			frame.icon_1:SetSize(AddonHeight-2, AddonHeight-2)
			frame.icon_1:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
			------------------------------------------------
			frame.texture_2 = frame:CreateTexture(nil, "BACKGROUND", nil, -3)
			frame.texture_2:SetSize(AddonLeftFrameWeight*3, AddonHeight)
			frame.texture_2:SetPoint("RIGHT")
			frame.texture_2:SetTexture(E.TEXTURE_LEFT_PATH)
			frame.texture_2:SetVertexColor(1, 1, 1, .1)
			------------------------------------------------
			frame.textLEFT = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			frame.textLEFT:SetPoint("LEFT", frame, "LEFT", AddonHeight+2, 0)
			frame.textLEFT:SetFontObject(OctoFont11)
			frame.textLEFT:SetJustifyV("MIDDLE")
			frame.textLEFT:SetJustifyH("LEFT")
			frame.textLEFT:SetTextColor(1, 1, 1, 1)
			------------------------------------------------
			frame.textRIGHT = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			frame.textRIGHT:SetPoint("RIGHT", frame, "RIGHT", -4, 0)
			frame.textRIGHT:SetFontObject(OctoFont11)
			frame.textRIGHT:SetJustifyV("MIDDLE")
			frame.textRIGHT:SetJustifyH("RIGHT")
			frame.textRIGHT:SetTextColor(1, 1, 1, 1)
			------------------------------------------------
			frame:SetScript("OnClick", func_OnClick)
			frame:SetScript("OnEnter", func_OnEnter)
			------------------------------------------------
		end
	end
	------------------------------------------------
end
local function CreateAchievementTooltip(achievementID)
	local tooltipData = {}
	local _, name, points, completed, month, day, year, description, _, icon, _, _, _, _, isStatistic = GetAchievementInfo(achievementID)
	local color = completed and E.Green_Color or E.Red_Color
	-- Build header line
	local textLEFT = E:func_texturefromIcon(icon)..name
	if E.DebugIDs then
		textLEFT = textLEFT..E.Gray_Color.." id:"..achievementID.."|r"
	end
	if points and points ~= 0 then
		textLEFT = textLEFT.." "..color..points.."|r"
	end
	local textRIGHT = day and (day.."/"..month.."/20"..year) or ""
	table_insert(tooltipData, {textLEFT, textRIGHT})
	-- Add description if exists
	if description and description ~= "" then
		table_insert(tooltipData, {" ", " "})
		table_insert(tooltipData, {E.Yellow_Color..description.."|r"})
		table_insert(tooltipData, {" ", " "})
	end
	-- Process criteria data
	local vivodLeft, vivodRight = {}, {}
	local numCriteria = GetAchievementNumCriteria(achievementID)
	for critIndex = 1, numCriteria do
		local criteriaString, _, completedCrit, quantity, reqQuantity = GetAchievementCriteriaInfo(achievementID, critIndex, false)
		-- Left column (criteria text)
		local text = criteriaString and criteriaString ~= "" and criteriaString or description
		local critColor = completedCrit and E.Green_Color or (not completedCrit and quantity == 0 and E.Gray_Color or E.White_Color)
		table_insert(vivodLeft, critColor .. text .. "|r")
		-- Right column (quantity)
		local qText = isStatistic and "" or (critColor..(quantity or 0).." / "..(reqQuantity or 1).."|r")
		table_insert(vivodRight, qText)
	end
	-- Add criteria data to tooltip if any criteria exists
	if #vivodLeft > 0 then
		table_insert(tooltipData, {table_concat(vivodLeft, "|n"), table_concat(vivodRight, "|n")} )
	end
	return tooltipData
end
----------------------------------------------------------------
----------------------------------------------------------------
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ (АПДЕЙТ)
function Octo_EventFrame_Achievements:Octo_Frame_init(frame, node)
	local data = node:GetData()
	frame.icon_1:SetTexture(data.icon)
	frame.textLEFT:SetText(data.textLEFT)
	frame.textRIGHT:SetText(data.textRIGHT or "NIL?")
	frame.tooltip = CreateAchievementTooltip(data.AchievementID)
	if IsTracking(2, data.AchievementID) then
		frame.texture_2:Show()
		-- E:func_SetBackdrop(frame, E.classColorHexCurrent, .3, 0)
	else
		frame.texture_2:Hide()
		-- E:func_SetBackdrop(frame, nil, 0, 0)
	end
end
function Octo_EventFrame_Achievements:Octo_Create_MainFrame_Achievements()
	Octo_MainFrame_Achievements:SetPoint("CENTER", 0, 0)
	-- Octo_MainFrame_Achievements:SetPoint("TOP", 0, -200)
	Octo_MainFrame_Achievements:SetSize(AddonLeftFrameWeight*3, AddonHeight*MainFrameDefaultLines)
	Octo_MainFrame_Achievements:SetDontSavePosition(Octo_ToDo_DB_Vars.DontSavePosition)
	Octo_MainFrame_Achievements:SetClampedToScreen(Octo_ToDo_DB_Vars.ClampedToScreen)
	Octo_MainFrame_Achievements:SetFrameStrata("HIGH")
	Octo_MainFrame_Achievements:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	Octo_MainFrame_Achievements:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	Octo_MainFrame_Achievements:SetBackdropBorderColor(0, 0, 0, 1)
	Octo_MainFrame_Achievements:EnableMouse(true)
	Octo_MainFrame_Achievements:SetMovable(true)
	Octo_MainFrame_Achievements:RegisterForDrag("LeftButton")
	Octo_MainFrame_Achievements:SetScript("OnDragStart", function()
			Octo_MainFrame_Achievements:SetAlpha(E.bgCa)
			Octo_MainFrame_Achievements:StartMoving()
	end)
	Octo_MainFrame_Achievements:SetScript("OnDragStop", function()
			Octo_MainFrame_Achievements:SetAlpha(1)
			Octo_MainFrame_Achievements:StopMovingOrSizing()
	end)
	Octo_MainFrame_Achievements:RegisterForClicks("RightButtonUp")
	Octo_MainFrame_Achievements:SetScript("OnClick", function(self) self:Hide() end)
	Octo_MainFrame_Achievements.ScrollBox = CreateFrame("FRAME", nil, Octo_MainFrame_Achievements, "WowScrollBoxList")
	Octo_MainFrame_Achievements.ScrollBox:SetAllPoints()
	Octo_MainFrame_Achievements.ScrollBox:SetPropagateMouseClicks(true)
	Octo_MainFrame_Achievements.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	Octo_MainFrame_Achievements.ScrollBox:Layout()
	Octo_MainFrame_Achievements.ScrollBar = CreateFrame("EventFrame", nil, Octo_MainFrame_Achievements, "MinimalScrollBar")
	Octo_MainFrame_Achievements.ScrollBar:SetPoint("TOPLEFT", Octo_MainFrame_Achievements.ScrollBox, "TOPRIGHT", 6, 0)
	Octo_MainFrame_Achievements.ScrollBar:SetPoint("BOTTOMLEFT", Octo_MainFrame_Achievements.ScrollBox, "BOTTOMRIGHT", 6, 0)
	Octo_MainFrame_Achievements.view = CreateScrollBoxListTreeListView()
	Octo_MainFrame_Achievements.view:SetElementExtent(AddonHeight)
	Octo_MainFrame_Achievements.view:SetElementInitializer("BUTTON",
		function(...)
			self:Octo_Frame_init(...)
	end)
	Octo_MainFrame_Achievements.view:RegisterCallback(Octo_MainFrame_Achievements.view.Event.OnAcquiredFrame, func_OnAcquired, Octo_MainFrame_Achievements) -- ПОФИКСИТЬ
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_Achievements.ScrollBox, Octo_MainFrame_Achievements.ScrollBar, Octo_MainFrame_Achievements.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_Achievements.ScrollBox, Octo_MainFrame_Achievements.ScrollBar) -- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
end
function Octo_EventFrame_Achievements:Update()
	Octo_MainFrame_Achievements.view:SetDataProvider(Octo_EventFrame_Achievements.DataProvider, ScrollBoxConstants.RetainScrollPosition)
end
function E:func_Achievements_CreateDataProvider()
	if Octo_MainFrame_Achievements then
		Octo_EventFrame_Achievements.DataProvider = CreateTreeDataProvider()
		local count = 0
		for categoryID, v in next, (Octo_Achievements_DB.AchievementToShow) do
			local total = GetCategoryNumAchievements(categoryID, true)
			if total then
				for i = 1, total do
					local AchievementID, name, points, completedAchi, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy, isStatistic = GetAchievementInfo(categoryID, i)
					if AchievementID then
						if completedAchi == false or (completedAchi == Octo_Achievements_DB.AchievementShowCompleted) then
							local color = E.Red_Color
							if completedAchi then color = E.Green_Color end
							local textLEFT = name
							if points and points ~= 0 then
								textLEFT = textLEFT .. " " .. color..points.."|r"
							end
							count = count + 1
							Octo_EventFrame_Achievements.DataProvider:Insert({
									textLEFT = textLEFT,
									textRIGHT = E:func_achievementvivod(AchievementID),
									AchievementID = AchievementID,
									icon = icon,
							})
						end
					end
				end
			end
		end

		if count > MainFrameDefaultLines then
			Octo_MainFrame_Achievements:SetSize(AddonLeftFrameWeight*3, AddonHeight*MainFrameDefaultLines)
		elseif count == 0 then
			Octo_MainFrame_Achievements:SetSize(AddonLeftFrameWeight*3, AddonHeight*1)
		else
			Octo_MainFrame_Achievements:SetSize(AddonLeftFrameWeight*3, AddonHeight*count)
		end
		Octo_EventFrame_Achievements:Update()
	end
end
local MyEventsTable = {
	"ADDON_LOADED",
	"CONTENT_TRACKING_UPDATE",
	"PLAYER_REGEN_DISABLED",
}
E:func_RegisterMyEventsToFrames(Octo_EventFrame_Achievements, MyEventsTable)
function Octo_EventFrame_Achievements:ADDON_LOADED(addonName)
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
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		self:Octo_Create_MainFrame_Achievements()
		E:func_Achievements_CreateDataProvider()
		E:func_Create_DDframe_Achievements(Octo_MainFrame_Achievements, E.Lime_Color, function() E:func_Achievements_CreateDataProvider() end)
		E:func_CreateMinimapButton(GlobalAddonName, "Achievements", Octo_Achievements_DB, Octo_MainFrame_Achievements, function() Octo_EventFrame_Achievements:Update() end, "Octo_MainFrame_Achievements")
		Octo_MainFrame_Achievements:SetScript("OnShow", function()
				E:func_Achievements_CreateDataProvider()
		end)
	end
end
function Octo_EventFrame_Achievements:CONTENT_TRACKING_UPDATE(type, AchievementID, isTracked)
	if type == 2 then -- Enum.ContentTrackingType
		self:Update()
	end
end
function Octo_EventFrame_Achievements:PLAYER_REGEN_DISABLED()
	if Octo_MainFrame_Achievements and Octo_MainFrame_Achievements:IsShown() then
		Octo_MainFrame_Achievements:Hide()
	end
end