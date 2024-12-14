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
local OctoToDo_EventFrame_Achievements = CreateFrame("FRAME")
OctoToDo_EventFrame_Achievements:Hide()
OctoToDo_EventFrame_Achievements:RegisterEvent("ADDON_LOADED")
OctoToDo_EventFrame_Achievements:RegisterEvent("PLAYER_REGEN_DISABLED")
----------------------------------------------------------------
local AddonHeight = 20 -- Высота
local AddonRightFrameWeight = 240/2 -- Ширина
local AddonLeftFrameWeight = 240
local PhysicalScreenWidth, PhysicalScreenHeight = GetPhysicalScreenSize()
local row = math.floor((math.floor(PhysicalScreenHeight / AddonHeight))*.7)
-- дефолт 20
local MainFrameNumLines = 30
if MainFrameNumLines > row then
	MainFrameNumLines = row
end
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ / CALLBACK
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
	local hexcolor = E.func_rgb2hex(data.r, data.g, data.b)
	frame.left.text:SetText(hexcolor..data.name.."|r")
	frame.right.text:SetText(data.righttext)
	E:func_SetBackdrop(frame.left, nil, 0)
	E:func_SetBackdrop(frame.right, hexcolor, E.bgCa/2)
end

function OctoToDo_EventFrame_Achievements:OctoToDo_THIRD_CreateMainFrame()
	local OctoToDo_MainFrame_Achievements = CreateFrame("BUTTON", "OctoToDo_MainFrame_Achievements", UIParent, "BackdropTemplate")
	OctoToDo_MainFrame_Achievements:SetSize(AddonRightFrameWeight+AddonLeftFrameWeight, AddonHeight*MainFrameNumLines)
	OctoToDo_MainFrame_Achievements:Hide()
	OctoToDo_MainFrame_Achievements.ScrollBox = CreateFrame("FRAME", nil, OctoToDo_MainFrame_Achievements, "WowScrollBoxList")
	OctoToDo_MainFrame_Achievements.ScrollBox:SetAllPoints()
	OctoToDo_MainFrame_Achievements.ScrollBox:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_Achievements.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_Achievements.ScrollBar = CreateFrame("EventFrame", nil, OctoToDo_MainFrame_Achievements, "MinimalScrollBar")
	OctoToDo_MainFrame_Achievements.ScrollBar:SetPoint("TOPLEFT", OctoToDo_MainFrame_Achievements.ScrollBox, "TOPRIGHT", 6, 0)
	OctoToDo_MainFrame_Achievements.ScrollBar:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_Achievements.ScrollBox, "BOTTOMRIGHT", 6, 0)
	OctoToDo_MainFrame_Achievements.view = CreateScrollBoxListLinearView()
	OctoToDo_MainFrame_Achievements.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_Achievements.view:SetElementInitializer("BackdropTemplate", OctoToDo_Frame_init)
	OctoToDo_MainFrame_Achievements.view:RegisterCallback(OctoToDo_MainFrame_Achievements.view.Event.OnAcquiredFrame, DropDownMenuSearchButton_OnAcquired, OctoToDo_MainFrame_Achievements)
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame_Achievements.ScrollBox, OctoToDo_MainFrame_Achievements.ScrollBar, OctoToDo_MainFrame_Achievements.view)
	-- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame_Achievements.ScrollBox, OctoToDo_MainFrame_Achievements.ScrollBar)
	OctoToDo_MainFrame_Achievements:SetClampedToScreen(false)
	OctoToDo_MainFrame_Achievements:SetFrameStrata("HIGH")
	OctoToDo_MainFrame_Achievements:SetPoint("CENTER")
	OctoToDo_MainFrame_Achievements:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	OctoToDo_MainFrame_Achievements:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoToDo_MainFrame_Achievements:SetBackdropBorderColor(0, 0, 0, 1)
	-- OctoToDo_MainFrame_Achievements:SetBackdropColor(0, 0, 0, 0)
	-- OctoToDo_MainFrame_Achievements:SetBackdropBorderColor(0, 0, 0, 0)
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
	----------------------------------------------------------------
	self:func_DataProvider()
end






function OctoToDo_EventFrame_Achievements:func_DataProvider()
	local DataProvider = CreateDataProvider()
	local count = 0
	for categoryID, v in next, (OctoToDo_Achievements.AchievementToShow) do
		local ACHr, ACHg, ACHb = E.func_hex2rgbNUMBER(E.func_GenerateUniqueColor()),E.func_hex2rgbNUMBER(E.func_GenerateUniqueColor()),E.func_hex2rgbNUMBER(E.func_GenerateUniqueColor())
		local total = GetCategoryNumAchievements(categoryID, true)
		if total then
			for i = 1, total do
				local AchievementID, name, points, completedAchi, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy, isStatistic = GetAchievementInfo(categoryID, i)
				if AchievementID then
					if completedAchi == false or (completedAchi == OctoToDo_Achievements.AchievementShowCompleted) then
						count = count + 1
						DataProvider:Insert({
								name = name,
								righttext = E.func_achievementvivod(AchievementID),
								r = ACHr,
								g = ACHg,
								b = ACHb,
						})
					end
				end
			end
		end
	end

	if count > 0 and count < MainFrameNumLines then
		OctoToDo_MainFrame_Achievements:SetSize(AddonRightFrameWeight+AddonLeftFrameWeight, AddonHeight*count)
	elseif count == 0 then
		OctoToDo_MainFrame_Achievements:SetSize(AddonRightFrameWeight+AddonLeftFrameWeight, AddonHeight*1)
	end
	-- local curHeight = count * AddonHeight
	-- curHeight = min(max(curHeight, AddonHeight), AddonHeight*MainFrameNumLines)

	-- OctoToDo_MainFrame_Achievements:SetSize(AddonRightFrameWeight+AddonLeftFrameWeight, curHeight)



	OctoToDo_MainFrame_Achievements.ScrollBox:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
end






function OctoToDo_EventFrame_Achievements:func_CreateDDframe()
	local dd_SECOND = CreateFrame("Button", "dd_SECOND", OctoToDo_MainFrame_Achievements, "SecureActionButtonTemplate, BackDropTemplate")
	local multiply = 2/3
	dd_SECOND:SetSize(AddonLeftFrameWeight/2, AddonHeight)
	-- dd_SECOND:SetBackdrop({
	--         bgFile = E.bgFile,
	--         edgeFile = E.edgeFile,
	--         edgeSize = 1
	-- })
	-- dd_SECOND:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	-- dd_SECOND:SetBackdropBorderColor(0, 0, 0, 1)
	E:func_SetBackdrop(dd_SECOND)
	dd_SECOND.ExpandArrow = dd_SECOND:CreateTexture(nil, "ARTWORK")
	dd_SECOND.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	dd_SECOND.ExpandArrow:SetSize(16*multiply, 16*multiply)
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
		OctoToDo_EventFrame_Achievements:func_DataProvider()
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
					----------------------------------------------------------------
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
					-- self:ddAddButton(info, level)
					----------------------------------------------------------------
				end
			end
			self:ddAddButton({list = list, listMaxSize = 20}, level)
			if level == 1 then
				----------------------------------------------------------------
				self:ddAddSeparator(level)
				----------------------------------------------------------------
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = "Показывать завершенные"
				info.hasArrow = nil
				info.checked = OctoToDo_Achievements.AchievementShowCompleted
				info.func = function(_,_,_, checked)
					OctoToDo_Achievements.AchievementShowCompleted = checked
					OctoToDo_EventFrame_Achievements:func_DataProvider()
				end
				self:ddAddButton(info, level)
			end
			----------------------------------------------------------------
	end)
	dd_SECOND:ddSetMenuButtonHeight(16)
end
----------------------------------------------------------------
OctoToDo_EventFrame_Achievements:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

function OctoToDo_EventFrame_Achievements:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		if OctoToDo_Achievements == nil then OctoToDo_Achievements = {} end
		if OctoToDo_Achievements.AchievementShowCompleted == nil then OctoToDo_Achievements.AchievementShowCompleted = true end
		if OctoToDo_Achievements.AchievementToShow == nil then OctoToDo_Achievements.AchievementToShow = {[92] = true} end
		----------------------------------------------------------------
		self:OctoToDo_THIRD_CreateMainFrame()
		self:func_CreateDDframe()
		----------------------------------------------------------------
		E:func_CreateUtilsButton(OctoToDo_MainFrame_Achievements)
		E:func_CreateMinimapButton(GlobalAddonName, OctoToDo_Achievements, OctoToDo_MainFrame_Achievements)
		----------------------------------------------------------------
	end
end

function OctoToDo_EventFrame_Achievements:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_Achievements and OctoToDo_MainFrame_Achievements:IsShown() then
		OctoToDo_MainFrame_Achievements:Hide()
	end
end

