local GlobalAddonName, E = ...
local OctoToDo_EventFrame_Achievements = CreateFrame("FRAME")
OctoToDo_EventFrame_Achievements:Hide()
local OctoToDo_MainFrame_Achievements = CreateFrame("BUTTON", "OctoToDo_MainFrame_Achievements", UIParent, "BackdropTemplate")
OctoToDo_MainFrame_Achievements:Hide()
tinsert(E.OctoTable_Frames, OctoToDo_MainFrame_Achievements)
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
----------------------------------------------------------------
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

local function ToggleAchievement(AchievementID)
	if E.func_achievementComplete(AchievementID) and C_ContentTracking.IsTracking(2, AchievementID) then
		return C_ContentTracking.StopTracking(2, AchievementID, 2)
	elseif E.func_achievementComplete(AchievementID) then
		return
	elseif C_ContentTracking.IsTracking(2, AchievementID) then
		return C_ContentTracking.StopTracking(2, AchievementID, 2)
	else
		return C_ContentTracking.StartTracking(2, AchievementID)
	end
end
local function OnClick_Second(frame)
	if OctoToDo_MainFrame_Achievements:IsDragging() then
		return
	end
	local parent = frame:GetParent()
	local node = parent:GetElementData()
	local AchievementID = parent:GetData().AchievementID
	ToggleAchievement(AchievementID)
end
local function func_OnAcquired(owner, frame, data, new)
	if new then
		frame.first = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
		frame.first:SetPropagateMouseClicks(false)
		frame.first:SetSize(AddonHeight, AddonHeight)
		frame.first:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.first.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.first.icon:SetAllPoints(frame.first)
		frame.first.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		frame.second = CreateFrame("BUTTON", nil, frame, "BackdropTemplate")
		frame.second:SetPropagateMouseClicks(true)
		frame.second:SetSize(AddonLeftFrameWeight*3, AddonHeight)
		frame.second:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.second:RegisterForClicks("LeftButtonUp")
		frame.second:SetScript("OnClick", OnClick_Second)
		frame.second:SetScript("OnEnter", function()
				E.func_TooltipOnEnter(frame.second, false, false)
		end)
		frame.second:SetScript("OnLeave", GameTooltip_Hide)
		frame.second.textLEFT = frame.second:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.second.textLEFT:SetPoint("LEFT", frame, "LEFT", AddonHeight+2, 0)
		frame.second.textLEFT:SetFontObject(OctoFont11)
		frame.second.textLEFT:SetJustifyV("MIDDLE")
		frame.second.textLEFT:SetJustifyH("LEFT")
		frame.second.textLEFT:SetTextColor(1, 1, 1, 1)
		frame.second.textRIGHT = frame.second:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.second.textRIGHT:SetPoint("RIGHT", frame, "RIGHT", -4, 0)
		frame.second.textRIGHT:SetFontObject(OctoFont11)
		frame.second.textRIGHT:SetJustifyV("MIDDLE")
		frame.second.textRIGHT:SetJustifyH("RIGHT")
		frame.second.textRIGHT:SetTextColor(1, 1, 1, 1)
		-- frame.second:SetScript("OnHide", frame.second.Hide)
	end
end
local function CreateTooltip(AchievementID)
	local tooltipsecond = {}
	tooltipsecond[#tooltipsecond+1] = {E.func_texturefromIcon(E.func_achievementIcon(AchievementID)).. E.func_achievementName(AchievementID), AchievementID}
	tooltipsecond[#tooltipsecond+1] = {" ", " "}
	if E.func_achievementDescription(AchievementID) ~= "" then
		tooltipsecond[#tooltipsecond+1] = {E.func_achievementDescription(AchievementID)}
		tooltipsecond[#tooltipsecond+1] = {" ", " "}
	end
	tooltipsecond[#tooltipsecond+1] = {E.func_achievementcriteriaString(AchievementID), E.func_achievementquantity(AchievementID)}
	return tooltipsecond
end
----------------------------------------------------------------
----------------------------------------------------------------
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ (АПДЕЙТ)
function OctoToDo_EventFrame_Achievements:OctoToDo_Frame_init(frame, node)
	local data = node:GetData()
	frame.first.icon:SetTexture(data.icon)
	frame.second.textLEFT:SetText(data.textLEFT)
	frame.second.textRIGHT:SetText(data.textRIGHT or "NIL?")
	frame.second.tooltip = CreateTooltip(data.AchievementID)
	if C_ContentTracking.IsTracking(2, data.AchievementID) then
		E:func_SetBackdrop(frame.second, E.classColorHexCurrent, .3, 0)
	else
		E:func_SetBackdrop(frame.second, nil, 0, 0)
	end
end
function OctoToDo_EventFrame_Achievements:OctoToDo_Create_MainFrame_Achievements()
	OctoToDo_MainFrame_Achievements:SetPoint("TOP", 0, -200)
	OctoToDo_MainFrame_Achievements:SetSize(AddonLeftFrameWeight*3, AddonHeight*MainFrameDefaultLines)
	OctoToDo_MainFrame_Achievements:SetDontSavePosition(true)
	OctoToDo_MainFrame_Achievements:SetClampedToScreen(false)
	OctoToDo_MainFrame_Achievements:SetFrameStrata("HIGH")

	OctoToDo_MainFrame_Achievements:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	OctoToDo_MainFrame_Achievements:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoToDo_MainFrame_Achievements:SetBackdropBorderColor(0, 0, 0, 1)
	OctoToDo_MainFrame_Achievements:EnableMouse(true)
	OctoToDo_MainFrame_Achievements:SetMovable(true)
	OctoToDo_MainFrame_Achievements:RegisterForDrag("LeftButton")
	OctoToDo_MainFrame_Achievements:SetScript("OnDragStart", function()
			OctoToDo_MainFrame_Achievements:SetAlpha(E.bgCa/2)
			OctoToDo_MainFrame_Achievements:StartMoving()
	end)
	OctoToDo_MainFrame_Achievements:SetScript("OnDragStop", function()
			OctoToDo_MainFrame_Achievements:SetAlpha(1)
			OctoToDo_MainFrame_Achievements:StopMovingOrSizing()
	end)
	OctoToDo_MainFrame_Achievements:RegisterForClicks("RightButtonUp")
	OctoToDo_MainFrame_Achievements:SetScript("OnClick", function(self) self:Hide() end)
	OctoToDo_MainFrame_Achievements.ScrollBox = CreateFrame("FRAME", nil, OctoToDo_MainFrame_Achievements, "WowScrollBoxList")
	OctoToDo_MainFrame_Achievements.ScrollBox:SetAllPoints()
	OctoToDo_MainFrame_Achievements.ScrollBox:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_Achievements.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_Achievements.ScrollBox:Layout()
	OctoToDo_MainFrame_Achievements.ScrollBar = CreateFrame("EventFrame", nil, OctoToDo_MainFrame_Achievements, "MinimalScrollBar")
	OctoToDo_MainFrame_Achievements.ScrollBar:SetPoint("TOPLEFT", OctoToDo_MainFrame_Achievements.ScrollBox, "TOPRIGHT", 6, 0)
	OctoToDo_MainFrame_Achievements.ScrollBar:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_Achievements.ScrollBox, "BOTTOMRIGHT", 6, 0)
	OctoToDo_MainFrame_Achievements.view = CreateScrollBoxListTreeListView()
	OctoToDo_MainFrame_Achievements.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_Achievements.view:SetElementInitializer("BackdropTemplate",
		function(...)
			self:OctoToDo_Frame_init(...)
	end)
	OctoToDo_MainFrame_Achievements.view:RegisterCallback(OctoToDo_MainFrame_Achievements.view.Event.OnAcquiredFrame, func_OnAcquired, OctoToDo_MainFrame_Achievements) -- ПОФИКСИТЬ
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame_Achievements.ScrollBox, OctoToDo_MainFrame_Achievements.ScrollBar, OctoToDo_MainFrame_Achievements.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame_Achievements.ScrollBox, OctoToDo_MainFrame_Achievements.ScrollBar) -- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
end
function OctoToDo_EventFrame_Achievements:Update()
	OctoToDo_MainFrame_Achievements.view:SetDataProvider(OctoToDo_EventFrame_Achievements.DataProvider, ScrollBoxConstants.RetainScrollPosition)
end
function OctoToDo_EventFrame_Achievements:func_CreateMyDataProvider()
	if OctoToDo_MainFrame_Achievements then
		OctoToDo_EventFrame_Achievements.DataProvider = CreateTreeDataProvider()
		local count = 0
		for categoryID, v in next, (OctoToDo_Achievements.AchievementToShow) do
			local total = GetCategoryNumAchievements(categoryID, true)
			if total then
				for i = 1, total do
					local AchievementID, name, points, completedAchi, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy, isStatistic = GetAchievementInfo(categoryID, i)
					if AchievementID then
						if completedAchi == false or (completedAchi == OctoToDo_Achievements.AchievementShowCompleted) then
							count = count + 1
							OctoToDo_EventFrame_Achievements.DataProvider:Insert({
									textLEFT = name,
									textRIGHT = E.func_achievementvivod(AchievementID),
									AchievementID = AchievementID,
									icon = icon,
							})
						end
					end
				end
			end
		end
		if count > 0 and count < MainFrameDefaultLines then
			OctoToDo_MainFrame_Achievements:SetSize(AddonLeftFrameWeight*3, AddonHeight*count)
		elseif count > MainFrameDefaultLines then
			OctoToDo_MainFrame_Achievements:SetSize(AddonLeftFrameWeight*3, AddonHeight*MainFrameDefaultLines)
		elseif count == 0 then
			OctoToDo_MainFrame_Achievements:SetSize(AddonLeftFrameWeight*3, AddonHeight*1)
		end
		OctoToDo_EventFrame_Achievements:Update()
	end
end
function OctoToDo_EventFrame_Achievements:func_Create_DDframe_Achievements()
	local dd_SECOND = CreateFrame("Button", "dd_SECOND", OctoToDo_MainFrame_Achievements, "SecureActionButtonTemplate, BackDropTemplate")
	local multiply = 2/3
	dd_SECOND:SetSize(SFDropDownWeight, AddonHeight)
	E:func_SetBackdrop(dd_SECOND)
	dd_SECOND.ExpandArrow = dd_SECOND:CreateTexture(nil, "ARTWORK")
	dd_SECOND.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	dd_SECOND.ExpandArrow:SetSize(AddonHeight, AddonHeight)
	dd_SECOND.ExpandArrow:SetPoint("RIGHT", -4, 0)
	dd_SECOND.text = dd_SECOND:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	dd_SECOND.text:SetAllPoints()
	dd_SECOND.text:SetFontObject(OctoFont11)
	dd_SECOND.text:SetJustifyV("MIDDLE")
	dd_SECOND.text:SetJustifyH("CENTER")
	dd_SECOND.text:SetTextColor(1, 1, 1, 1)
	dd_SECOND.text:SetText(ACHIEVEMENT_BUTTON)
	LibSFDropDown:SetMixin(dd_SECOND)
	dd_SECOND:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_Achievements, "TOPLEFT", 0, 0)
	dd_SECOND:ddSetDisplayMode(GlobalAddonName)
	dd_SECOND:ddSetOpenMenuUp(true)
	dd_SECOND:ddSetNoGlobalMouseEvent(true)
	dd_SECOND:ddHideWhenButtonHidden()
	dd_SECOND:RegisterForClicks("LeftButtonUp")
	dd_SECOND:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)
	local function selectFunctionAchievementToShow(menuButton, _, arg2, checked)
		OctoToDo_Achievements.AchievementToShow[menuButton.value] = checked or nil
		if arg2 == 2 then
			dd_SECOND:ddRefresh(arg2-1)
		end
		OctoToDo_EventFrame_Achievements:func_CreateMyDataProvider()
	end
	local function TEST_FUNC(menuButton, arg1)
		local categories = GetCategoryList()
		local cID = menuButton.value
		for i = 1, #categories do
			local categoryID = categories[i]
			local _, parentCategoryID = GetCategoryInfo(categoryID)
			if arg1 and cID == parentCategoryID and OctoToDo_Achievements.AchievementToShow[categoryID] == true then
				return E.func_Gradient(arg1.name)..arg1.vivod
			end
		end
		return arg1.name..arg1.vivod
	end
	dd_SECOND:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			local categories = GetCategoryList()
			for i = 1, #categories do
				local info = {}
				local categoryID = categories[i]
				local name, parentCategoryID = GetCategoryInfo(categoryID)
				local total, completed = GetCategoryNumAchievements(categoryID, true)
				local vivod = " ("..completed.."/"..total..")"
				if total == completed then
					vivod = " "..E.DONE
				else
					if completed == 0 then
						vivod = E.Red_Color..vivod.."|r"
					else
						vivod = E.Yellow_Color..vivod.."|r"
					end
				end
				if parentCategoryID == value or parentCategoryID == -1 and not value then
					info.fontObject = OctoFont11
					info.hasArrow = parentCategoryID == -1 and categoryID ~= 92
					info.keepShownOnClick = true
					info.notCheckable = false
					info.isNotRadio = true
					if parentCategoryID == -1 then
						info.text = TEST_FUNC
					else
						info.text = name..vivod
					end
					info.arg1 = {name = name, vivod = vivod}
					info.arg2 = level
					info.value = categoryID
					info.checked = OctoToDo_Achievements.AchievementToShow[categoryID]
					info.func = selectFunctionAchievementToShow
					tinsert(list, info)
				end
			end
			self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			if level == 1 then
				self:ddAddSeparator(level)
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = "Показывать завершенные"
				info.hasArrow = nil
				info.checked = OctoToDo_Achievements.AchievementShowCompleted
				info.func = function(_, _, _, checked)
					OctoToDo_Achievements.AchievementShowCompleted = checked
					OctoToDo_EventFrame_Achievements:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
			end
	end)
	dd_SECOND:ddSetMenuButtonHeight(16)
end
local MyEventsTable = {
	"ADDON_LOADED",
	"CONTENT_TRACKING_UPDATE",
	"PLAYER_REGEN_DISABLED",
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_Achievements, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_Achievements:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if OctoToDo_DB_Vars.AddonHeight then
			AddonHeight = OctoToDo_DB_Vars.AddonHeight
		end
		if OctoToDo_DB_Vars.AddonLeftFrameWeight then
			AddonLeftFrameWeight = OctoToDo_DB_Vars.AddonLeftFrameWeight
		end
		if OctoToDo_DB_Vars.AddonCentralFrameWeight then
			AddonCentralFrameWeight = OctoToDo_DB_Vars.AddonCentralFrameWeight
		end
		if OctoToDo_DB_Vars.MainFrameDefaultLines then
			MainFrameDefaultLines = OctoToDo_DB_Vars.MainFrameDefaultLines
		end
		if OctoToDo_DB_Vars.SFDropDownWeight then
			SFDropDownWeight = OctoToDo_DB_Vars.SFDropDownWeight
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		self:OctoToDo_Create_MainFrame_Achievements()
		self:func_CreateMyDataProvider()
		self:func_Create_DDframe_Achievements()
		E:func_CreateUtilsButton(OctoToDo_MainFrame_Achievements, "Achievements", AddonHeight, 0)
		E:func_CreateMinimapButton(GlobalAddonName, "Achievements", OctoToDo_Achievements, OctoToDo_MainFrame_Achievements, function() OctoToDo_EventFrame_Achievements:Update() end)
		OctoToDo_MainFrame_Achievements:SetScript("OnShow", function()
				OctoToDo_EventFrame_Achievements.func_CreateMyDataProvider()
		end)
	end
end
function OctoToDo_EventFrame_Achievements:CONTENT_TRACKING_UPDATE(type, AchievementID, isTracked)
	if type == 2 then -- Enum.ContentTrackingType
		self:Update()
	end
end
function OctoToDo_EventFrame_Achievements:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_Achievements and OctoToDo_MainFrame_Achievements:IsShown() then
		OctoToDo_MainFrame_Achievements:Hide()
	end
end