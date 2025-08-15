local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
local Octo_MainFrame_AddonsManager = CreateFrame("BUTTON", "Octo_MainFrame_AddonsManager", UIParent, "BackdropTemplate")
Octo_MainFrame_AddonsManager:Hide()
E:func_InitFrame(Octo_MainFrame_AddonsManager)
----------------------------------------------------------------
local LINE_HEIGHT = E.GLOBAL_LINE_HEIGHT
local LINE_WIDTH_LEFT = E.GLOBAL_LINE_WIDTH_LEFT
local LINE_WIDTH_RIGHT = E.GLOBAL_LINE_WIDTH_RIGHT
local Config_MainFrameDefaultLines = 30
local MainFrameTotalLines = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / LINE_HEIGHT))*.7)
if Config_MainFrameDefaultLines > MainFrameTotalLines then
	Config_MainFrameDefaultLines = MainFrameTotalLines
end
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
----------------------------------------------------------------
local ADDON_ACTIONS_BLOCKED = { }
local ALL_CHARACTERS = "All"
local addonCharacter = ALL_CHARACTERS
local function GetAddonCharacter()
	if addonCharacter == ALL_CHARACTERS then
		return nil
	end
	return addonCharacter
end
----------------------------------------------------------------
function EventFrame:AddDeps_RECURSION(i, groupNode)
	for _, depIndex in ipairs(Octo_AddonsTable_DB.depsByIndex[i]) do
		local secondABOBUS = groupNode:Insert({index = depIndex})
		if Octo_AddonsTable_DB.depsByIndex[depIndex] and not Octo_AddonsTable_DB.recycleByIndex[depIndex] then
			EventFrame:AddDeps_RECURSION(depIndex, secondABOBUS)
		end
	end
end
----------------------------------------------------------------
local function OnClick_Zero(frame)
	local parent = frame:GetParent() -- ЭТО ИНДЕКС?
	local node = parent:GetElementData()
	local index = node:GetData().index
	local name = E:func_GetAddonName(index)
	local IsCollapsed = node:IsCollapsed() or true -- IsCollapsed = IsOpen т.е. ОТКРЫТ
	if IsCollapsed ~= nil then
		node:ToggleCollapsed()
		EventFrame:Octo_Frame_init(parent, node)
		Octo_AddonsManager_DB.collapsedAddons[name] = node:IsCollapsed()
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function OnClick_third(frame, button)
	local parent = frame:GetParent()
	local node = parent:GetElementData()
	local index = parent:GetData().index
	local value = index
	if Octo_MainFrame_AddonsManager:IsDragging() then
		return
	end
	if button == "LeftButton" then
		E:func_ToggleAddon(index)
	elseif button == "MiddleButton" then
		E:func_LockAddon(index)
	elseif button == "RightButton" then
		DDFrame.index = index
		DDFrame:ddToggle(level, value, "cursor")
	end
	EventFrame:Octo_Frame_init(parent, node)
	E:AddonList_Update()
end
----------------------------------------------------------------
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
local func_OnAcquired do
	------------------------------------------------
	local function func_OnEnter(frame)
		E:func_OctoTooltip_OnEnter(frame)
	end
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
			local frameFULL = CreateFrame("Button", nil, Octo_MainFrame_AddonsManager)
			frameFULL:SetPropagateMouseClicks(true)
			frameFULL:SetPropagateMouseMotion(true)
			frameFULL:SetFrameLevel(frame:GetFrameLevel()+2)
			frameFULL:SetHighlightAtlas("auctionhouse-ui-row-highlight", "ADD")
			frameFULL.HighlightTexture = frameFULL:GetHighlightTexture()
			frameFULL.HighlightTexture:SetAlpha(.2)
			frameFULL:SetPoint("LEFT", frame)
			frameFULL:SetPoint("TOP", frame)
			frameFULL:SetPoint("BOTTOM", frame)
			frameFULL:SetPoint("RIGHT")
			------------------------------------------------
			frame.first = CreateFrame("BUTTON", nil, frame)
			frame.first:SetPropagateMouseClicks(false)
			frame.first:SetSize(LINE_HEIGHT, LINE_HEIGHT)
			frame.first:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
			frame.icon_firstSlot = frame:CreateTexture(nil, "BACKGROUND")
			frame.icon_firstSlot:SetAllPoints(frame.first)
			frame.first:SetScript("OnClick", OnClick_Zero)
			-- frame.icon_firstSlot:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
			------------------------------------------------
			frame.icon_secondSlot = frame:CreateTexture(nil, "BACKGROUND")
			frame.icon_secondSlot:SetPoint("TOPLEFT", LINE_HEIGHT+1, -1)
			frame.icon_secondSlot:SetSize(LINE_HEIGHT-2, LINE_HEIGHT-2)
			frame.icon_secondSlot:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
			frame.icon_secondSlot:SetTexture(E.Icon_Empty)
			------------------------------------------------
			frame.icon_third = frame:CreateTexture(nil, "BACKGROUND")
			frame.icon_third:SetPoint("TOPLEFT", LINE_HEIGHT+LINE_HEIGHT+1, -1)
			frame.icon_third:SetSize(LINE_HEIGHT-2, LINE_HEIGHT-2)
			frame.icon_third:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
			------------------------------------------------
			frame.third = CreateFrame("BUTTON", nil, frame)
			frame.third:SetPropagateMouseClicks(true)
			frame.third:SetSize(LINE_WIDTH_LEFT*3, LINE_HEIGHT)
			-- frame.third:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
			frame.third:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0) -- frame.third:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
			frame.third:SetScript("OnEnter", func_OnEnter)
			frame.third.textLEFT = frame.third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			frame.third.textLEFT:SetPoint("LEFT", frame, "LEFT", LINE_HEIGHT+LINE_HEIGHT+LINE_HEIGHT+2, 0)
			frame.third.textLEFT:SetFontObject(OctoFont11)
			frame.third.textLEFT:SetJustifyV("MIDDLE")
			frame.third.textLEFT:SetJustifyH("LEFT")
			frame.third.textLEFT:SetTextColor(1, 1, 1, 1)
			-- frame.third:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButton")
			frame.third:RegisterForClicks("AnyUp")
			frame.third:SetScript("OnClick", OnClick_third)
			frame.third.textRIGHT = frame.third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			-- frame.third.textRIGHT:SetAllPoints()
			frame.third.textRIGHT:SetPoint("RIGHT", frame, "RIGHT", -4, 0)
			frame.third.textRIGHT:SetFontObject(OctoFont11)
			frame.third.textRIGHT:SetJustifyV("MIDDLE")
			frame.third.textRIGHT:SetJustifyH("RIGHT")
			frame.third.textRIGHT:SetTextColor(1, 1, 1, 1)
			------------------------------------------------
		end
	end
end
----------------------------------------------------------------
function EventFrame:CollectAddonInfo(index)
	local name = E:func_GetAddonName(index)
	local title = E:func_GetAddonTitle(index)
	local notes = E:func_GetAddonNotes(index)
	local security = E:func_GetAddonSecurity(index)
	local character = GetAddonCharacter()
	local loadable = E:func_IsAddOnLoadable(index, character)
	local reason = E:func_GetAddonReason(index, character) or ""
	if E:func_IsAddonInstalled(index) then -- Исключаем отсутствующие аддоны
		local firsticonTexture = ""
		tooltipthird = {}
		local textRIGHT = " "
		local colorAddon = E.White_Color
		local Version = E:func_GetAddonVersion(index)
		local Author = E:func_GetAddonAuthor(index)
		local exists = E:func_DoesAddOnExist(index)
		local defaultEnabled = E:func_IsAddOnDefaultEnabled(index)
		local checkboxState = E:func_GetAddOnEnableState(index, character)
		local enabled = (E:func_GetAddOnEnableState(index, UnitName("player")) > Enum.AddOnEnableState.None)
		if (checkboxState == Enum.AddOnEnableState.Some ) then
			tooltipthird[#tooltipthird+1] = ENABLED_FOR_SOME
			-- else
			-- tooltipthird[#tooltipthird+1] = nil
		end
		if ( loadable or ( enabled and (reason == "DEP_DEMAND_LOADED" or reason == "DEMAND_LOADED") ) ) then
			colorAddon =E.White_Color --"|cffFFC600" -- E:func_rgb2hexDEV(1.0, 0.78, 0.0)
		elseif ( enabled and reason ~= "DEP_DISABLED" ) then
			colorAddon = "|cffFF1919"-- E:func_rgb2hexDEV(1.0, 0.1, 0.1)
		else
			colorAddon = "|cff7F7F7F"-- E:func_rgb2hexDEV(0.5, 0.5, 0.5)
		end
		local iconTexture = E:func_GetAddoniconTexture(index)
		local iconAtlas = E:func_GetAddoniconAtlas(index)
		if not iconTexture and not iconAtlas and Octo_AddonsManager_DB.config.showIconsQuestionMark then
			iconTexture = [[Interface\ICONS\INV_Misc_QuestionMark]]
		end
		local textLEFT = name
		if Octo_AddonsManager_DB.config.fullName and title then
			textLEFT = title
		end
		if Octo_AddonsManager_DB.config.showVersion and Version ~= "" and Version ~= 0 then
			textLEFT = textLEFT..E.Gray_Color.." ("..Version..")|r"
		end
		if Octo_AddonsManager_DB.config.showIndex then
			textLEFT = E.Debug_Color..index.."|r "..textLEFT
		end
		-- if iconTexture then
		-- textLEFT = CreateSimpleTextureMarkup(iconTexture, 20, 20) .. " " .. textLEFT
		-- elseif iconAtlas then
		-- textLEFT = CreateAtlasMarkup(iconAtlas, 20, 20) .. " " .. textLEFT
		-- end
		-- if ADDON_ACTIONS_BLOCKED[name] or (AddOnPerformance and AddOnPerformance:AddOnHasPerformanceWarning(name)) then
		-- textLEFT = textLEFT .. CreateSimpleTextureMarkup([[Interface\DialogFrame\DialogIcon-AlertNew-16]], 16, 16)
		-- end
		local Parent_Color = E.classColorHexCurrent
		local Child_Color = E.classColorHexCurrent
		if (security == BANNED_ADDON) then
			tooltipthird[#tooltipthird+1] = {ADDON_BANNED_TOOLTIP}
		else
			local entryTitle = title or name-- Используем title, если он есть, иначе name
			local entryText-- Текст для добавления в tooltipthird
			if Version and Version ~= 0 then
				entryText = {entryTitle, E.classColorHexCurrent .. Version .. "|r"}
			else
				entryText = {entryTitle}
			end
			tooltipthird[#tooltipthird + 1] = entryText
			-- if (Author and Author ~= "") then
			-- tooltipthird[#tooltipthird+1] = {"Author: "..E.classColorHexCurrent..Author.."|r"}
			-- end
			-- if (notes and notes ~= "") then
			-- tooltipthird[#tooltipthird+1] = {"Notes: "..E.classColorHexCurrent..notes.."|r"}
			-- end
			if (loadable and E:func_IsProfilerEnabled()) then
				local RecentAverageTime = E:func_GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.RecentAverageTime)
				local SessionAverageTime = E:func_GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.SessionAverageTime)
				local PeakTime = E:func_GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.PeakTime)
				local EncounterAverageTime = E:func_GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.EncounterAverageTime)
				-- tooltipthird[#tooltipthird+1] = {" ", " "}
				-- tooltipthird[#tooltipthird+1] = {"RecentAverageTime: "..E.classColorHexCurrent..RecentAverageTime.."|r".."%"}
				-- tooltipthird[#tooltipthird+1] = {"SessionAverageTime: "..E.classColorHexCurrent..SessionAverageTime.."|r".."%"}
				-- tooltipthird[#tooltipthird+1] = {"PeakTime: "..E.classColorHexCurrent..PeakTime.."|r".."%"}
				-- if EncounterAverageTime ~= "" then
				-- tooltipthird[#tooltipthird+1] = {"EncounterAverageTime: "..E.classColorHexCurrent..EncounterAverageTime.."|r".."%"}
				-- end
				-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 5ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver5Ms))
				-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 10ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver10Ms))
				-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 50ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver50Ms))
				-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 100ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver100Ms))
				-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 500ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver500Ms))
			end
			-- and IsMemoryUsageEnabled()
			-- if (loadable and security ~= SECURE_PROTECTED_ADDON and security ~= SECURE_ADDON) then
			-- local memory = GetAddOnMemoryUsage(index) or 0
			-- if memory > 1024 then
			-- tooltipthird[#tooltipthird+1] = {"Использование памяти: ".. E.classColorHexCurrent..E:func_CompactNumberFormat(memory/1024).."|r Мб"}
			-- else
			-- tooltipthird[#tooltipthird+1] = {"Использование памяти: ".. E.classColorHexCurrent..E:func_CompactNumberFormat(memory).."|r Кб"}
			-- end
			-- end
			-- tooltipthird[#tooltipthird+1] = {" ", " "}
			-- tooltipthird[#tooltipthird+1] = {E:func_AddonTooltipBuildDepsString(index, Parent_Color)}
			-- if Octo_AddonsTable_DB.depsByIndex[index] then
			-- tooltipthird[#tooltipthird+1] = {"Дочернии аддоны"}
			-- for _, depIndex in pairs(Octo_AddonsTable_DB.depsByIndex[index]) do
			-- tooltipthird[#tooltipthird+1] = {""..Child_Color..E:func_GetAddonName(depIndex).."|r"}
			-- end
			-- end
			if loadable then
				firsticonTexture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonONgreen"
			else
				firsticonTexture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonOFFblack"
			end
			local needReload = false
			if (enabled and not loadable) then
				needReload = true
				firsticonTexture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonOFFgreen"
			end
			if (not enabled and loadable) then
				needReload = true
				firsticonTexture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonOFFred"
			end
			if reason == "DEMAND_LOADED" or reason == "DEP_DEMAND_LOADED" then
				firsticonTexture = "Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\buttonOFFyellow"
			end
			-- if E:func_IsAddonVersionCheckEnabled() and E.interfaceVersion > interfaceVersion and enabled then
			-- colorAddon = "|cffFF0000"
			-- textRIGHT = ADDON_INTERFACE_VERSION.." ("..interfaceVersion..")"
			-- end
			local dep = E:func_AddonTooltipBuildDepsString(index)
			local depBOOLEN = false
			if dep then
				depBOOLEN = true
			end
		end
		local resonTEXT = ""
		if ( not loadable and reason ~= "" ) then
			resonTEXT = _G["ADDON_"..reason]
		else
			resonTEXT = ""
		end
		if Octo_AddonsManager_DB.lock.addons[name] then
			textLEFT = CreateSimpleTextureMarkup([[Interface\AddOns\Octo\Media\AddonsManager\lock]], LINE_HEIGHT, LINE_HEIGHT)..textLEFT
		end
		textRIGHT = colorAddon.. resonTEXT .."|r"
		return firsticonTexture, iconTexture, colorAddon..textLEFT.."|r", textRIGHT, tooltipthird, colorAddon
	end
end
----------------------------------------------------------------
local function UpdateExpandOrCollapseButtonState(button, isCollapsed)
	if (isCollapsed) then
		button:SetTexture("Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\zakrito")
		button:SetVertexColor(1, 0, 0, 1)
		-- button:SetTexture("Interface\\Buttons\\UI-PlusButton-Up")
	else
		button:SetTexture("Interface\\AddOns\\"..E.MainAddonName.."\\Media\\AddonsManager\\otkrito")
		button:SetVertexColor(1, 1, 1, 1)
		-- button:SetTexture("Interface\\Buttons\\UI-MinusButton-Up")
	end
end
local function CollapseOrExpand(button, isCollapsed, node, name)
end
local showExpandOrCollapseButton = true
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ + ГОВНО
-- ЭТО ФУНКЦИЯ АПДЕЙТА(ОТРИСОФКИ)
function EventFrame:Octo_Frame_init(frame, node)
	local data = node:GetData()
	local index = node:GetData().index
	local name = E:func_GetAddonName(index)
	local firsticonTexture = select(1, EventFrame:CollectAddonInfo(data.index))
	local iconTexture = select(2, EventFrame:CollectAddonInfo(data.index))
	local textLEFT = select(3, EventFrame:CollectAddonInfo(data.index))
	local textRIGHT = select(4, EventFrame:CollectAddonInfo(data.index))
	local tooltipthird = select(5, EventFrame:CollectAddonInfo(data.index))
	-- local colorAddon = select(6, EventFrame:CollectAddonInfo(data.index))
	frame.icon_secondSlot:SetTexture(firsticonTexture)
	if showExpandOrCollapseButton then
		local tbl = {}
		tbl = Octo_AddonsTable_DB.depsByIndex
		if tbl[data.index] then
			UpdateExpandOrCollapseButtonState(frame.icon_firstSlot, node:IsCollapsed(), node, name)
		else
			frame.icon_firstSlot:SetTexture(E.Icon_Empty)
		end
	else
		frame.first:Hide()
	end
	if Octo_AddonsManager_DB.config.showIcons then
		frame.third.textLEFT:SetPoint("LEFT", frame, "LEFT", LINE_HEIGHT+LINE_HEIGHT+LINE_HEIGHT+4, 0)
		frame.icon_third:SetTexture(iconTexture)
	else
		frame.third.textLEFT:SetPoint("LEFT", frame, "LEFT", LINE_HEIGHT+LINE_HEIGHT+4, 0)
		frame.icon_third:SetTexture(E.Icon_Empty)
	end
	frame.third.textLEFT:SetText(textLEFT)
	frame.third.textRIGHT:SetText(textRIGHT)
	frame.third.tooltip = tooltipthird
	-- E:func_SetBackdrop(frame.first, nil, 0, 0)
	-- E:func_SetBackdrop(frame.third, nil, 0, 0)
end
function EventFrame:Octo_Create_MainFrame_AddonsManager()
	Octo_MainFrame_AddonsManager:SetPoint("CENTER", 0, 0)
	-- Octo_MainFrame_AddonsManager:SetPoint("TOP", 0, -200)
	Octo_MainFrame_AddonsManager:SetSize(LINE_WIDTH_LEFT*3, LINE_HEIGHT*Config_MainFrameDefaultLines)
	Octo_MainFrame_AddonsManager:SetDontSavePosition(Octo_ToDo_DB_Vars.Config_DontSavePosition)
	Octo_MainFrame_AddonsManager:SetClampedToScreen(Octo_ToDo_DB_Vars.Config_ClampedToScreen)
	Octo_MainFrame_AddonsManager:SetFrameStrata("HIGH")
	Octo_MainFrame_AddonsManager:SetBackdrop(E.menuBackdrop)
	Octo_MainFrame_AddonsManager:SetBackdropColor(E.backgroundColorR, E.backgroundColorG, E.backgroundColorB, E.backgroundColorA)
	Octo_MainFrame_AddonsManager:SetBackdropBorderColor(0, 0, 0, 1)
	Octo_MainFrame_AddonsManager:EnableMouse(true)
	Octo_MainFrame_AddonsManager:SetMovable(true)
	Octo_MainFrame_AddonsManager:RegisterForDrag("LeftButton")
	Octo_MainFrame_AddonsManager:SetScript("OnDragStart", function()
			Octo_MainFrame_AddonsManager:SetAlpha(Octo_ToDo_DB_Vars.Config_AlphaOnDrag or E.backgroundColorA)
			Octo_MainFrame_AddonsManager:StartMoving()
	end)
	Octo_MainFrame_AddonsManager:SetScript("OnDragStop", function()
			Octo_MainFrame_AddonsManager:SetAlpha(1)
			Octo_MainFrame_AddonsManager:StopMovingOrSizing()
	end)
	Octo_MainFrame_AddonsManager.ScrollBox = CreateFrame("FRAME", nil, Octo_MainFrame_AddonsManager, "WowScrollBoxList")
	Octo_MainFrame_AddonsManager.ScrollBox:SetAllPoints()
	Octo_MainFrame_AddonsManager.ScrollBox:SetPropagateMouseClicks(true)
	Octo_MainFrame_AddonsManager.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	Octo_MainFrame_AddonsManager.ScrollBox:Layout()
	Octo_MainFrame_AddonsManager.ScrollBar = CreateFrame("EventFrame", nil, Octo_MainFrame_AddonsManager, "MinimalScrollBar")
	Octo_MainFrame_AddonsManager.ScrollBar:SetPoint("TOPLEFT", Octo_MainFrame_AddonsManager.ScrollBox, "TOPRIGHT", 6, 0)
	Octo_MainFrame_AddonsManager.ScrollBar:SetPoint("BOTTOMLEFT", Octo_MainFrame_AddonsManager.ScrollBox, "BOTTOMRIGHT", 6, 0)
	Octo_MainFrame_AddonsManager.view = CreateScrollBoxListTreeListView()
	Octo_MainFrame_AddonsManager.view:SetElementExtent(LINE_HEIGHT)
	Octo_MainFrame_AddonsManager.view:SetElementInitializer("BUTTON",
		function(...)
			self:Octo_Frame_init(...)
	end)
	Octo_MainFrame_AddonsManager.view:RegisterCallback(Octo_MainFrame_AddonsManager.view.Event.OnAcquiredFrame, func_OnAcquired, Octo_MainFrame_AddonsManager)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_AddonsManager.ScrollBox, Octo_MainFrame_AddonsManager.ScrollBar, Octo_MainFrame_AddonsManager.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_AddonsManager.ScrollBox, Octo_MainFrame_AddonsManager.ScrollBar) -- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	----------------------------------------------------------------
end
function E:AddonList_Update()
	if ( E:func_AddonList_HasAnyChanged() ) then
		frame_OkayButton.text:SetText(RELOADUI)
		EventFrame.shouldReload = true
	else
		frame_OkayButton.text:SetText(OKAY)
		EventFrame.shouldReload = false
	end
	Octo_MainFrame_AddonsManager.view:SetDataProvider(E.DataProvider, ScrollBoxConstants.RetainScrollPosition)
end
function E:CreateDataProvider_AddonsManage()
	E:func_UpdatePerformance()
	local DataProvider = CreateTreeDataProvider()
	E.DataProvider = DataProvider
	for index = 1, E:func_GetNumAddOns() do
		if not Octo_AddonsTable_DB.parentByIndex[index] or Octo_AddonsTable_DB.recycleByIndex[index] then
			local groupNode = DataProvider:Insert({index = index})
			-- childrenNodes[#childrenNodes]:SetCollapsed(true) -- БРАТЬ ПОСЛЕДНЮЮ НОДУ И КОЛЛАПСИТЬ (ВЕСЬ СПИСОК ПРИ ЗАГРУЗКЕ)
			if Octo_AddonsTable_DB.depsByIndex[index] then
				EventFrame:AddDeps_RECURSION(index, groupNode)
			end
		end
	end
	E:AddonList_Update()
end
function EventFrame:func_Create_AdditionalFrame()
	----------------------------------------------------------------
	local frame_EnableAll = CreateFrame("Button", "frame_EnableAll", Octo_MainFrame_AddonsManager)
	frame_EnableAll:SetPropagateMouseClicks(true)
	frame_EnableAll:SetSize(LINE_WIDTH_RIGHT, LINE_HEIGHT)
	frame_EnableAll:SetPoint("TOPLEFT", Octo_MainFrame_AddonsManager, "BOTTOMLEFT", 0, 0)
	frame_EnableAll.text = frame_EnableAll:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frame_EnableAll.text:SetAllPoints()
	frame_EnableAll.text:SetFontObject(OctoFont11)
	frame_EnableAll.text:SetJustifyV("MIDDLE")
	frame_EnableAll.text:SetJustifyH("CENTER")
	frame_EnableAll.text:SetTextColor(1, 1, 1, 1)
	frame_EnableAll.text:SetText(ENABLE_ALL_ADDONS)
	frame_EnableAll:EnableMouse(true)
	frame_EnableAll:RegisterForClicks("LeftButtonUp")
	frame_EnableAll:SetScript("OnClick", function(self)
			E:func_EnableAllAddOns()
			E:AddonList_Update()
	end)
	----------------------------------------------------------------
	local frame_DisableAll = CreateFrame("Button", "frame_DisableAll", Octo_MainFrame_AddonsManager)
	frame_DisableAll:SetPropagateMouseClicks(true)
	frame_DisableAll:SetSize(LINE_WIDTH_RIGHT, LINE_HEIGHT)
	frame_DisableAll:SetPoint("TOPLEFT", Octo_MainFrame_AddonsManager, "BOTTOMLEFT", LINE_WIDTH_RIGHT, 0)
	frame_DisableAll.text = frame_DisableAll:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frame_DisableAll.text:SetAllPoints()
	frame_DisableAll.text:SetFontObject(OctoFont11)
	frame_DisableAll.text:SetJustifyV("MIDDLE")
	frame_DisableAll.text:SetJustifyH("CENTER")
	frame_DisableAll.text:SetTextColor(1, 1, 1, 1)
	frame_DisableAll.text:SetText(DISABLE_ALL_ADDONS)
	frame_DisableAll:EnableMouse(true)
	frame_DisableAll:RegisterForClicks("LeftButtonUp")
	frame_DisableAll:SetScript("OnClick", function(self)
			E:func_DisableAllAddons()
			E:AddonList_Update()
	end)
	frame_DisableAll:SetScript("OnEnter", function(self)
			local DisableAllTooltip = {}
			local sorted = {}
			for name, value in pairs(Octo_AddonsManager_DB.lock.addons) do
				if value then
					tinsert(sorted, name)
				end
			end
			sort(sorted)
			for index, name in ipairs(sorted) do
				DisableAllTooltip[#DisableAllTooltip+1] = {E:func_texturefromIcon(E:func_GetAddoniconTexture(name))..E:func_GetAddonTitle(name), E:func_texturefromIcon([[Interface\AddOns\Octo\Media\AddonsManager\lock]])}
			end
			frame_DisableAll.tooltip = DisableAllTooltip
			E:func_OctoTooltip_OnEnter(self, false, false)
	end)
	----------------------------------------------------------------
	local frame_OkayButton = CreateFrame("Button", "frame_OkayButton", Octo_MainFrame_AddonsManager)
	frame_OkayButton:SetPropagateMouseClicks(true)
	frame_OkayButton:SetSize(LINE_WIDTH_RIGHT, LINE_HEIGHT)
	frame_OkayButton:SetPoint("TOPRIGHT", Octo_MainFrame_AddonsManager, "BOTTOMRIGHT", -LINE_WIDTH_RIGHT, 0)
	frame_OkayButton.text = frame_OkayButton:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frame_OkayButton.text:SetAllPoints()
	frame_OkayButton.text:SetFontObject(OctoFont11)
	frame_OkayButton.text:SetJustifyV("MIDDLE")
	frame_OkayButton.text:SetJustifyH("CENTER")
	frame_OkayButton.text:SetTextColor(1, 1, 1, 1)
	frame_OkayButton.text:SetText(RELOADUI)
	frame_OkayButton:EnableMouse(true)
	frame_OkayButton:RegisterForClicks("LeftButtonUp")
	frame_OkayButton:SetScript("OnClick", function(self)
			EventFrame:AddonList_OnOkay()
	end)
	----------------------------------------------------------------
	local frame_CancelButton = CreateFrame("Button", "frame_CancelButton", Octo_MainFrame_AddonsManager)
	frame_CancelButton:SetPropagateMouseClicks(true)
	frame_CancelButton:SetSize(LINE_WIDTH_RIGHT, LINE_HEIGHT)
	frame_CancelButton:SetPoint("TOPRIGHT", Octo_MainFrame_AddonsManager, "BOTTOMRIGHT", 0, 0)
	frame_CancelButton.text = frame_CancelButton:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frame_CancelButton.text:SetAllPoints()
	frame_CancelButton.text:SetFontObject(OctoFont11)
	frame_CancelButton.text:SetJustifyV("MIDDLE")
	frame_CancelButton.text:SetJustifyH("CENTER")
	frame_CancelButton.text:SetTextColor(1, 1, 1, 1)
	frame_CancelButton.text:SetText(CANCEL)
	frame_CancelButton:EnableMouse(true)
	frame_CancelButton:RegisterForClicks("LeftButtonUp")
	frame_CancelButton:SetScript("OnClick", function(self)
			EventFrame:AddonList_OnCancel()
	end)
	----------------------------------------------------------------
end
function EventFrame:AddonList_OnOkay()
	PlaySound(SOUNDKIT.GS_LOGIN_CHANGE_REALM_OK)
	self:AddonList_Hide(true)
	if ( EventFrame.shouldReload ) then
		ReloadUI()
	end
end
function EventFrame:AddonList_Hide(save)
	AddonList.save = save
end
function EventFrame:AddonList_OnCancel()
	PlaySound(SOUNDKIT.GS_LOGIN_CHANGE_REALM_CANCEL)
	self:AddonList_Hide(false)
end
----------------------------------------------------------------
----------------------------------------------------------------
function EventFrame:GetCycleByIndexSFMICT(iChild, iParent)
	if Octo_AddonsTable_DB.depsByIndex[iChild] then
		for _, depIndex in ipairs(Octo_AddonsTable_DB.depsByIndex[iChild]) do
			if depIndex == iParent then
				DEFAULT_CHAT_FRAME:AddMessage(E.Red_Color.."НАЙДЕН АБОБУС: |r".. iChild .." "..E:func_GetAddonName(iChild).." / "..iParent.." "..E:func_GetAddonName(iParent))
				return true
			end
		end
	end
end
-- ДОЛЖНА ВЫЗЫВАТЬСЯ 1 РАЗ
function EventFrame:CollectAllAddonsSFMICT()
	Octo_AddonsTable_DB = {}
	Octo_AddonsTable_DB.indexByName = {}
	for index = 1, E:func_GetNumAddOns() do
		local name = E:func_GetAddonName(index)
		Octo_AddonsTable_DB.indexByName[name] = index
	end
	Octo_AddonsTable_DB.depsByIndex = {}
	Octo_AddonsTable_DB.parentByIndex = {}
	Octo_AddonsTable_DB.recycleByIndex = {}
	for index = 1, E:func_GetNumAddOns() do
		local deps = E:func_GetAddOnDependenciesTable(index)
		for _, name in ipairs(deps) do
			if Octo_AddonsTable_DB.indexByName[name] then
				Octo_AddonsTable_DB.depsByIndex[Octo_AddonsTable_DB.indexByName[name]] = Octo_AddonsTable_DB.depsByIndex[Octo_AddonsTable_DB.indexByName[name]] or {}
				tinsert(Octo_AddonsTable_DB.depsByIndex[Octo_AddonsTable_DB.indexByName[name]], index)
				Octo_AddonsTable_DB.parentByIndex[index] = true
				if EventFrame:GetCycleByIndexSFMICT(index, Octo_AddonsTable_DB.indexByName[name]) then
					Octo_AddonsTable_DB.recycleByIndex[index] = true
					Octo_AddonsTable_DB.recycleByIndex[Octo_AddonsTable_DB.indexByName[name]] = true
				end
			end
		end
	end
end
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_REGEN_DISABLED",
}
E:func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	----------------------------------------------------------------
	self.startStatus = {}
	self.shouldReload = false
	self.outOfDate = E:func_IsAddonVersionCheckEnabled() and E:func_AddonList_HasOutOfDate()
	self.outOfDateIndexes = {}
	for i=1, E:func_GetNumAddOns() do
		self.startStatus[i] = (E:func_GetAddOnEnableState(i, UnitName("player")) > Enum.AddOnEnableState.None)
		if (E:func_GetAddonReason(i) == "INTERFACE_VERSION") then
			tinsert(self.outOfDateIndexes, i)
		end
	end
	addonCharacter = UnitGUID("player")
	if Octo_AddonsManager_DB.profiles.default == nil then
		E:func_SaveProfile("default") -- CHAT_DEFAULT
	end
	DEFAULT_CHAT_FRAME:AddMessage("/uam")
	self:CollectAllAddonsSFMICT()
	self:Octo_Create_MainFrame_AddonsManager()
	self:func_Create_AdditionalFrame()
	E:func_Create_DDframe_AddonsManager(Octo_MainFrame_AddonsManager, E.Yellow_Color, function() E:AddonList_Update() end)
	E:CreateDataProvider_AddonsManage()
	E:func_Create_DDframe_AddonsManager_DDMenu()
	--------------------------------------------------------------
	E:func_CreateMinimapButton(GlobalAddonName, "AddonsManager", Octo_AddonsManager_DB, Octo_MainFrame_AddonsManager, nil, "Octo_MainFrame_AddonsManager")
	Octo_MainFrame_AddonsManager:SetScript("OnShow", function()
			C_Timer.After(.1, function()
					E:AddonList_Update()
			end)
	end)
end
----------------------------------------------------------------
function EventFrame:PLAYER_REGEN_DISABLED()
	if Octo_MainFrame_AddonsManager and Octo_MainFrame_AddonsManager:IsShown() then
		Octo_MainFrame_AddonsManager:Hide()
	end
end