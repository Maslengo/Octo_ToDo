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
-- https://warcraft.wiki.gg/wiki/Making_scrollable_frames
----------------------------------------------------------------
local OctoToDo_EventFrame_AddonsManager = CreateFrame("FRAME")
OctoToDo_EventFrame_AddonsManager:Hide()
----------------------------------------------------------------
local AddonHeight = 20 --ADDON_BUTTON_HEIGHT -- Высота -- OctoToDo_DB_Vars.curHeight
local AddonLeftFrameWeight = 500 -- Ширина Левого -- OctoToDo_DB_Vars.curWidthTitle
local PhysicalScreenWidth, PhysicalScreenHeight = GetPhysicalScreenSize()
local NumberOfLines = math.floor((math.floor(PhysicalScreenHeight / AddonHeight))*.7)
-- дефолт 30
local MainFrameNumLines = 30 --MAX_ADDONS_DISPLAYED
----------------------------------------------------------------
local className, classFilename, classId = UnitClass("PLAYER")
local classColor = E.func_GetClassColor(classFilename)
local r, g, b = GetClassColor(classFilename)
----------------------------------------------------------------
-- local ADDON_ACTIONS_BLOCKED = {}
-- function AddonTooltip_ActionBlocked(addon)
--     ADDON_ACTIONS_BLOCKED[addon] = (ADDON_ACTIONS_BLOCKED[addon] or 0) + 1
-- end
----------------------------------------------------------------
-- local function PIZDALIZ()
-- 	local ScrollBox = CreateFrame("Frame", nil, UIParent, "WowScrollBoxList")
-- 	ScrollBox:SetPoint("CENTER")
-- 	ScrollBox:SetSize(300, 500)

-- 	local ScrollBar = CreateFrame("EventFrame", nil, UIParent, "MinimalScrollBar")
-- 	ScrollBar:SetPoint("TOPLEFT", ScrollBox, "TOPRIGHT")
-- 	ScrollBar:SetPoint("BOTTOMLEFT", ScrollBox, "BOTTOMRIGHT")

-- 	local DataProvider = CreateTreeDataProvider()
-- 	local ScrollView = CreateScrollBoxListTreeListView()
-- 	ScrollView:SetDataProvider(DataProvider)

-- 	ScrollUtil.InitScrollBoxListWithScrollBar(ScrollBox, ScrollBar, ScrollView)

-- 	-- The 'button' argument is the frame that our data will inhabit in our list
-- 	-- The 'node' argument will be a node table, as explained above
-- 	local function Initializer(button, node)
-- 		local data = node:GetData() -- get our data from the node with :GetData()
-- 		local text = data.ButtonText
-- 		button:SetText(text)
-- 		button:SetScript("OnClick", function()
-- 			node:ToggleCollapsed()
-- 		end)
-- 	end

-- 	-- The first argument here can either be a frame type or frame template. We're just passing the "UIPanelButtonTemplate" template here
-- 	ScrollView:SetElementInitializer("UIPanelButtonTemplate", Initializer)

-- 	local AddonList = {
-- 		ButtonText = "AddonList",
-- 	}
-- 	local GhostElement = DataProvider:Insert(AddonList)
-- 	for i = 1, C_AddOns.GetNumAddOns() do
-- 		local name, title, notes, loadable, reason, security, updateAvailable = C_AddOns.GetAddOnInfo(i)
-- 		GhostElement:Insert({ButtonText = name})
-- 	end
-- end
----------------------------------------------------------------
local function OnENTERTTOOLTIP(f)
	if not f.tooltip then
		return
	elseif #f.tooltip == 0 then
		return
	end
	GameTooltip:SetOwner(f, "ANCHOR_BOTTOMRIGHT", 0, 0)
	GameTooltip:AddLine(" ")
	for k, v in next, (f.tooltip) do
		GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
	end
	GameTooltip:AddLine(" ")
	GameTooltip:Show()
end
----------------------------------------------------------------
function E.UpdatePerformance()
	local enabled = C_AddOnProfiler.IsEnabled()
	if enabled then
		E.CollectAllAddons()
		UpdateAddOnCPUUsage() -- НЕ РАБОТАЕТ?
		UpdateAddOnMemoryUsage()
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ / CALLBACK
local function func_OnAcquired(owner, frame, data, new)
	if new then
		frame.first = CreateFrame("FRAME", nil, frame, "BackDropTemplate")
		frame.first:SetPropagateMouseClicks(false)
		frame.first:SetSize(AddonHeight, AddonHeight)
		frame.first:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.first.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.first.icon:SetAllPoints(frame.first)
		frame.DEP = CreateFrame("FRAME", nil, frame, "BackDropTemplate")
		frame.DEP:Hide()
		frame.DEP:SetPropagateMouseClicks(false)
		frame.DEP:SetSize(AddonHeight, AddonHeight)
		frame.DEP:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonHeight, 0)
		frame.DEP.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.DEP.icon:SetAllPoints(frame.DEP)
		frame.second = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
		frame.second:SetPropagateMouseClicks(false)
		frame.second:SetSize(AddonHeight, AddonHeight)
		frame.second:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonHeight, 0)
		frame.second.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.second.icon:SetAllPoints(frame.second)
		-- frame.second.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		frame.third = CreateFrame("BUTTON", nil, frame, "SecureActionButtonTemplate, BackDropTemplate")
		frame.third:SetPropagateMouseClicks(true)
		frame.third:SetSize(AddonHeight+AddonHeight+AddonLeftFrameWeight, AddonHeight)
		frame.third:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.third:SetScript("OnEnter", OnENTERTTOOLTIP)
		frame.third:SetScript("OnLeave", GameTooltip_Hide)
		frame.third.textLEFT = frame.third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.third.textLEFT:SetPoint("LEFT", frame, "LEFT", AddonHeight+AddonHeight+4, 0);
		frame.third.textLEFT:SetFontObject(OctoFont11)
		frame.third.textLEFT:SetJustifyV("MIDDLE")
		frame.third.textLEFT:SetJustifyH("LEFT")
		frame.third.textLEFT:SetTextColor(1, 1, 1, 1)
		frame.third.textRIGHT = frame.third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.third.textRIGHT:SetAllPoints()
		frame.third.textRIGHT:SetFontObject(OctoFont11)
		frame.third.textRIGHT:SetJustifyV("MIDDLE")
		frame.third.textRIGHT:SetJustifyH("RIGHT")
		frame.third.textRIGHT:SetTextColor(1, 1, 1, 1)
		-- frame.first.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		if not frame.isInitAddonButton then
			frame.isInitAddonButton = true
			frame.third:SetScript("OnClick", function(self)
					-- if OctoToDo_MainFrame_AddonsManager.IsDraging then
					--     print ("IsDraging")
					--     return
					-- end
					if OctoToDo_MainFrame_AddonsManager:IsDragging() then
						print ("IsDragging")
						return
					end
					local data = frame:GetElementData()
					E.func_ToggleAddon(data.addonindex, data.state)
					OctoToDo_EventFrame_AddonsManager:func_DataProvider()
			end)
		end
	end
end
----------------------------------------------------------------
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ + ГОВНО
local function OctoToDo_Frame_init(frame, data)
	frame.first.icon:SetTexture(data.firsticonTexture)
	frame.second.icon:SetTexture(data.icon)
	frame.third.textLEFT:SetText(data.textLEFT)
	frame.third.textRIGHT:SetText(data.textRIGHT)
	frame.third.tooltip = data.tooltipthird
	frame.DEP.icon:SetTexture(data.DEPiconTexture)
	-- frame.first.addonindex = data.addonindex
	-- frame.first.state = data.state
	if data.index % 2 == 0 then
		E:func_SetBackdrop(frame.third, nil, 0, 0)
	else
		E:func_SetBackdrop(frame.third, "|cff000000", .1, 0)
	end
end
----------------------------------------------------------------
function OctoToDo_EventFrame_AddonsManager:OctoToDo_Create_MainFrame_AddonsManager()
	local OctoToDo_MainFrame_AddonsManager = CreateFrame("BUTTON", "OctoToDo_MainFrame_AddonsManager", UIParent, "BackdropTemplate")
	tinsert(E.OctoTable_Frames, OctoToDo_MainFrame_AddonsManager)
	OctoToDo_MainFrame_AddonsManager:SetSize(AddonHeight+AddonHeight+AddonLeftFrameWeight, AddonHeight*MainFrameNumLines)
	OctoToDo_MainFrame_AddonsManager:Hide()
	OctoToDo_MainFrame_AddonsManager:SetDontSavePosition(true)
	OctoToDo_MainFrame_AddonsManager.ScrollBox = CreateFrame("FRAME", nil, OctoToDo_MainFrame_AddonsManager, "WowScrollBoxList")
	OctoToDo_MainFrame_AddonsManager.ScrollBox:SetAllPoints()
	OctoToDo_MainFrame_AddonsManager.ScrollBox:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_AddonsManager.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_AddonsManager.ScrollBar = CreateFrame("EventFrame", nil, OctoToDo_MainFrame_AddonsManager, "MinimalScrollBar")
	OctoToDo_MainFrame_AddonsManager.ScrollBar:SetPoint("TOPLEFT", OctoToDo_MainFrame_AddonsManager.ScrollBox, "TOPRIGHT", 6, 0)
	OctoToDo_MainFrame_AddonsManager.ScrollBar:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_AddonsManager.ScrollBox, "BOTTOMRIGHT", 6, 0)
	OctoToDo_MainFrame_AddonsManager.view = CreateScrollBoxListLinearView()
	OctoToDo_MainFrame_AddonsManager.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_AddonsManager.view:SetElementInitializer("BackdropTemplate", OctoToDo_Frame_init)
	OctoToDo_MainFrame_AddonsManager.view:RegisterCallback(OctoToDo_MainFrame_AddonsManager.view.Event.OnAcquiredFrame, func_OnAcquired, OctoToDo_MainFrame_AddonsManager)
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame_AddonsManager.ScrollBox, OctoToDo_MainFrame_AddonsManager.ScrollBar, OctoToDo_MainFrame_AddonsManager.view)
	-- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame_AddonsManager.ScrollBox, OctoToDo_MainFrame_AddonsManager.ScrollBar)
	OctoToDo_MainFrame_AddonsManager:SetClampedToScreen(false)
	OctoToDo_MainFrame_AddonsManager:SetFrameStrata("HIGH")
	OctoToDo_MainFrame_AddonsManager:SetPoint("CENTER")
	OctoToDo_MainFrame_AddonsManager:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	OctoToDo_MainFrame_AddonsManager:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoToDo_MainFrame_AddonsManager:SetBackdropBorderColor(0, 0, 0, 1)
	OctoToDo_MainFrame_AddonsManager:EnableMouse(true)
	OctoToDo_MainFrame_AddonsManager:SetMovable(true)
	OctoToDo_MainFrame_AddonsManager:RegisterForDrag("LeftButton")
	OctoToDo_MainFrame_AddonsManager:SetScript("OnDragStart", function()
			-- OctoToDo_MainFrame_AddonsManager.IsDraging = true
			OctoToDo_MainFrame_AddonsManager:SetAlpha(E.bgCa)
			OctoToDo_MainFrame_AddonsManager:StartMoving()
	end)
	OctoToDo_MainFrame_AddonsManager:SetScript("OnDragStop", function()
			OctoToDo_MainFrame_AddonsManager:SetAlpha(1)
			OctoToDo_MainFrame_AddonsManager:StopMovingOrSizing()
			-- OctoToDo_MainFrame_AddonsManager.IsDraging = false
	end)
	OctoToDo_MainFrame_AddonsManager:RegisterForClicks("RightButtonUp")
	OctoToDo_MainFrame_AddonsManager:SetScript("OnClick", function(self) self:Hide() end)
	----------------------------------------------------------------
	self:func_DataProvider()
	OctoToDo_EventFrame_AddonsManager:func_Create_AdditionalFrame()
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function OctoToDo_EventFrame_AddonsManager:func_DataProvider()
	-- индексдобавление(мой), название, индекс оригинальный (для функций)
	E.UpdatePerformance()
	local Provider = {}
	for i, v in ipairs(OctoToDo_AddonsManager.AddonList) do
		Provider[i] = Provider[i] or {}
		local tooltipthird = tooltipthird or {}
		Provider[i].index = i
		Provider[i].textLEFT =  v.colorAddon..v.name.."|r " -- .. v.vivod
		Provider[i].firsticonTexture = v.firsticonTexture
		Provider[i].DEPiconTexture = v.DEPiconTexture
		Provider[i].icon = v.iconTexture
		Provider[i].textRIGHT = v.colorAddon..v.textRIGHT.."|r"
		Provider[i].state = v.state
		Provider[i].addonindex = v.addonindex
		if v.Version ~= 0 then
			tooltipthird[#tooltipthird+1] = {E.func_texturefromIcon(v.iconTexture)..v.colorAddon..v.title.."|r", E.Gray_Color..v.Version.."|r"}
		else
			tooltipthird[#tooltipthird+1] = {E.func_texturefromIcon(v.iconTexture)..v.colorAddon..v.title.."|r"}
		end
		if v.Author then
			tooltipthird[#tooltipthird+1] = {" ", E.Gray_Color..v.Author.."|r"}
		end
		if v.memory and v.memory ~= 0 then
			tooltipthird[#tooltipthird+1] = {" ", " "}
			if v.memory > 1024 then
				tooltipthird[#tooltipthird+1] = {"Использование памяти: ".. E.classColorHexCurrent..E.func_CompactNumberFormat(v.memory/1024).."|r Мб"}
			else
				tooltipthird[#tooltipthird+1] = {"Использование памяти: ".. E.classColorHexCurrent..E.func_CompactNumberFormat(v.memory).."|r Кб"}
			end
		end
		tooltipthird[#tooltipthird+1] = {" ", " "}
		tooltipthird[#tooltipthird+1] = {"RecentAverageTime: "..E.classColorHexCurrent..v.RecentAverageTime.."|r".."%"}
		tooltipthird[#tooltipthird+1] = {"SessionAverageTime: "..E.classColorHexCurrent..v.SessionAverageTime.."|r".."%"}
		tooltipthird[#tooltipthird+1] = {"PeakTime: "..E.classColorHexCurrent..v.PeakTime.."|r".."%"}
		tooltipthird[#tooltipthird+1] = {"EncounterAverageTime: "..E.classColorHexCurrent..v.EncounterAverageTime.."|r".."%"}
		tooltipthird[#tooltipthird+1] = {"Ticksover5ms: "..E.classColorHexCurrent..v.Ticksover5ms.."|r"}
		tooltipthird[#tooltipthird+1] = {"Ticksover10ms: "..E.classColorHexCurrent..v.Ticksover10ms.."|r"}
		tooltipthird[#tooltipthird+1] = {"Ticksover50ms: "..E.classColorHexCurrent..v.Ticksover50ms.."|r"}
		tooltipthird[#tooltipthird+1] = {"Ticksover100ms: "..E.classColorHexCurrent..v.Ticksover100ms.."|r"}
		tooltipthird[#tooltipthird+1] = {"Ticksover500ms: "..E.classColorHexCurrent..v.Ticksover500ms.."|r"}
		tooltipthird[#tooltipthird+1] = {"C_AddOns.IsAddOnDefaultEnabled", tostring(v.defaultEnabled)}
		tooltipthird[#tooltipthird+1] = {"C_AddOns.DoesAddOnExist", tostring(v.exists)}
		tooltipthird[#tooltipthird+1] = {"C_AddOns.GetAddOnEnableState", tostring(v.state)}
		tooltipthird[#tooltipthird+1] = {" ", " "}
		tooltipthird[#tooltipthird+1] = {" ", " "}
		tooltipthird[#tooltipthird+1] = {"loadedOrLoading", tostring(v.loadedOrLoading)}
		tooltipthird[#tooltipthird+1] = {"enabled", tostring(v.enabled)}
		tooltipthird[#tooltipthird+1] = {"needReload", tostring(v.needReload)}
		tooltipthird[#tooltipthird+1] = {"vivod", tostring(v.vivod)}
		tooltipthird[#tooltipthird+1] = {ADDON_DEPENDENCIES, tostring(v.dep)}
		Provider[i].tooltipthird = tooltipthird
	end
	local DataProvider = CreateDataProvider(Provider)
	OctoToDo_MainFrame_AddonsManager:SetSize(AddonHeight+AddonHeight+AddonLeftFrameWeight, AddonHeight*MainFrameNumLines)
	OctoToDo_MainFrame_AddonsManager.ScrollBox:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
end
----------------------------------------------------------------
function OctoToDo_EventFrame_AddonsManager:func_Create_DDframe_AddonsManager()
	local OctoToDo_DD_AddonsManager = CreateFrame("Button", "OctoToDo_DD_AddonsManager", OctoToDo_MainFrame_AddonsManager, "SecureActionButtonTemplate, BackDropTemplate")
	local multiply = 2/3
	OctoToDo_DD_AddonsManager:SetSize(AddonLeftFrameWeight/4, AddonHeight)
	E:func_SetBackdrop(OctoToDo_DD_AddonsManager)
	OctoToDo_DD_AddonsManager.ExpandArrow = OctoToDo_DD_AddonsManager:CreateTexture(nil, "ARTWORK")
	OctoToDo_DD_AddonsManager.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	OctoToDo_DD_AddonsManager.ExpandArrow:SetSize(16*multiply, 16*multiply)
	OctoToDo_DD_AddonsManager.ExpandArrow:SetPoint("RIGHT", -4, 0)
	OctoToDo_DD_AddonsManager.text = OctoToDo_DD_AddonsManager:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	OctoToDo_DD_AddonsManager.text:SetAllPoints()
	OctoToDo_DD_AddonsManager.text:SetFontObject(OctoFont11)
	OctoToDo_DD_AddonsManager.text:SetJustifyV("MIDDLE")
	OctoToDo_DD_AddonsManager.text:SetJustifyH("CENTER")
	OctoToDo_DD_AddonsManager.text:SetTextColor(1, 1, 1, 1)
	OctoToDo_DD_AddonsManager.text:SetText(MAIN_MENU)
	LibSFDropDown:SetMixin(OctoToDo_DD_AddonsManager)
	OctoToDo_DD_AddonsManager:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_AddonsManager, "TOPLEFT", 0, 0)
	OctoToDo_DD_AddonsManager:ddSetDisplayMode(GlobalAddonName)
	OctoToDo_DD_AddonsManager:ddSetOpenMenuUp(true)
	OctoToDo_DD_AddonsManager:ddSetNoGlobalMouseEvent(true)
	OctoToDo_DD_AddonsManager:ddHideWhenButtonHidden()
	OctoToDo_DD_AddonsManager:RegisterForClicks("LeftButtonUp")
	OctoToDo_DD_AddonsManager:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)
	OctoToDo_DD_AddonsManager:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			----------------------------------------------------------------
			info.fontObject = OctoFont11
			info.keepShownOnClick = true
			info.notCheckable = true
			info.isNotRadio = true
			info.text = "Enable All Addons"
			info.hasArrow = nil
			info.func = function(_, _, _, checked)
				E.func_EnableAllAddons()
				OctoToDo_EventFrame_AddonsManager:func_DataProvider()
			end
			self:ddAddButton(info, level)
			----------------------------------------------------------------
			info.fontObject = OctoFont11
			info.keepShownOnClick = true
			info.notCheckable = true
			info.isNotRadio = true
			info.text = "Disable All Addons"
			info.hasArrow = nil
			info.func = function(_, _, _, checked)
				E.func_DisableAllAddons()
				OctoToDo_EventFrame_AddonsManager:func_DataProvider()
			end
			self:ddAddButton(info, level)
			----------------------------------------------------------------
			info.fontObject = OctoFont11
			info.keepShownOnClick = true
			info.notCheckable = true
			info.isNotRadio = true
			info.text = "List Addons"
			info.hasArrow = nil
			info.func = function(_, _, _, checked)
				E.func_ListAddons()
				OctoToDo_EventFrame_AddonsManager:func_DataProvider()
			end
			self:ddAddButton(info, level)
			----------------------------------------------------------------
			info.fontObject = OctoFont11
			info.keepShownOnClick = true
			info.notCheckable = true
			info.isNotRadio = true
			info.text = RELOADUI
			info.hasArrow = nil
			info.func = function(_, _, _, checked)
				ReloadUI()
				-- OctoToDo_EventFrame_AddonsManager:func_DataProvider()
			end
			self:ddAddButton(info, level)
			----------------------------------------------------------------
			info.fontObject = OctoFont11
			info.keepShownOnClick = true
			info.notCheckable = true
			info.isNotRadio = true
			info.text = "fpde"
			info.hasArrow = nil
			info.func = function(_, _, _, checked)
				fpde(OctoToDo_AddonsManager.AddonList)
				-- OctoToDo_EventFrame_AddonsManager:func_DataProvider()
			end
			self:ddAddButton(info, level)
			----------------------------------------------------------------
	end)
	OctoToDo_DD_AddonsManager:ddSetMenuButtonHeight(16)
end
----------------------------------------------------------------
function OctoToDo_EventFrame_AddonsManager:func_Create_AdditionalFrame()
	-- ENABLE_ALL_ADDONS - Включить все
	-- ADDON_LIST_ENABLE_CATEGORY - Включить все модификации
	-- ENABLE_ALL_SHADERS - Включить все шейдерные эффекты
	-- ADDON_LIST_ENABLE_DEPENDENCIES - Включить все зависимости
	-- ADDON_LIST_DISABLE_CATEGORY - Отключить все модификации
	-- DISABLE_ALL_ADDONS - Отключить все
	local frameONall = CreateFrame("Button", nil, OctoToDo_MainFrame_AddonsManager, "SecureActionButtonTemplate, BackDropTemplate")
	frameONall:SetPropagateMouseClicks(true)
	frameONall:SetSize(AddonLeftFrameWeight/5, AddonHeight)
	frameONall:SetPoint("TOPLEFT", OctoToDo_MainFrame_AddonsManager, "BOTTOMLEFT", 0, 0)
	E:func_SetBackdrop(frameONall)
	frameONall.text = frameONall:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frameONall.text:SetAllPoints()
	frameONall.text:SetFontObject(OctoFont11)
	frameONall.text:SetJustifyV("MIDDLE")
	frameONall.text:SetJustifyH("CENTER")
	frameONall.text:SetTextColor(1, 1, 1, 1)
	frameONall.text:SetText(ENABLE_ALL_ADDONS)
	frameONall:RegisterForClicks("LeftButtonUp")
	frameONall:EnableMouse(true)
	if not frameONall.frameONall then
		frameONall.frameONall = true
		frameONall:SetScript("OnClick", function(self)
				E.func_EnableAllAddons()
				OctoToDo_EventFrame_AddonsManager:func_DataProvider()
		end)
	end
	frameONall:SetScript("OnEnter", function(self)
			frameONall.text:SetText("|cff355C24"..ENABLE_ALL_ADDONS.."|r")
	end)
	frameONall:SetScript("OnLeave", function(self)
			frameONall.text:SetText(ENABLE_ALL_ADDONS)
	end)
	----------------------------------------------------------------
	local frameOFFall = CreateFrame("Button", nil, OctoToDo_MainFrame_AddonsManager, "SecureActionButtonTemplate, BackDropTemplate")
	frameOFFall:SetPropagateMouseClicks(true)
	frameOFFall:SetSize(AddonLeftFrameWeight/5, AddonHeight)
	frameOFFall:SetPoint("TOPLEFT", OctoToDo_MainFrame_AddonsManager, "BOTTOMLEFT", AddonLeftFrameWeight/5, 0)
	E:func_SetBackdrop(frameOFFall)
	frameOFFall.text = frameOFFall:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frameOFFall.text:SetAllPoints()
	frameOFFall.text:SetFontObject(OctoFont11)
	frameOFFall.text:SetJustifyV("MIDDLE")
	frameOFFall.text:SetJustifyH("CENTER")
	frameOFFall.text:SetTextColor(1, 1, 1, 1)
	frameOFFall.text:SetText(DISABLE_ALL_ADDONS)
	frameOFFall:RegisterForClicks("LeftButtonUp")
	frameOFFall:EnableMouse(true)
	if not frameOFFall.frameOFFall then
		frameOFFall.frameOFFall = true
		frameOFFall:SetScript("OnClick", function(self)
				E.func_DisableAllAddons()
				OctoToDo_EventFrame_AddonsManager:func_DataProvider()
		end)
		frameOFFall:SetScript("OnEnter", function(self)
				frameOFFall.text:SetText("|cffBA1525"..DISABLE_ALL_ADDONS.."|r")
		end)
		frameOFFall:SetScript("OnLeave", function(self)
				frameOFFall.text:SetText(DISABLE_ALL_ADDONS)
		end)
	end
	----------------------------------------------------------------
	local ReloadUIAM = CreateFrame("Button", nil, OctoToDo_MainFrame_AddonsManager, "SecureActionButtonTemplate, BackDropTemplate")
	ReloadUIAM:SetPropagateMouseClicks(true)
	ReloadUIAM:SetSize(AddonLeftFrameWeight/5, AddonHeight)
	ReloadUIAM:SetPoint("TOPRIGHT", OctoToDo_MainFrame_AddonsManager, "BOTTOMRIGHT", 0, 0)
	E:func_SetBackdrop(ReloadUIAM)
	ReloadUIAM.text = ReloadUIAM:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	ReloadUIAM.text:SetAllPoints()
	ReloadUIAM.text:SetFontObject(OctoFont11)
	ReloadUIAM.text:SetJustifyV("MIDDLE")
	ReloadUIAM.text:SetJustifyH("CENTER")
	ReloadUIAM.text:SetTextColor(1, 1, 1, 1)
	ReloadUIAM.text:SetText(RELOADUI)
	ReloadUIAM:RegisterForClicks("LeftButtonUp")
	ReloadUIAM:EnableMouse(true)
	if not ReloadUIAM.ReloadUIAM then
		ReloadUIAM.ReloadUIAM = true
		ReloadUIAM:SetScript("OnClick", function(self)
				ReloadUI()
		end)
	end
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_LOGIN",
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_AddonsManager, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_AddonsManager:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		-- PIZDALIZ()
		----------------------------------------------------------------
		-- if OctoToDo_DB_Vars then
		--     print (OctoToDo_DB_Vars.curWidthTitle)
		--     AddonHeight = OctoToDo_DB_Vars.curHeight
		--     AddonLeftFrameWeight = OctoToDo_DB_Vars.curWidthTitle*4
		-- end
		----------------------------------------------------------------
		if OctoToDo_AddonsManager == nil then OctoToDo_AddonsManager = {} end
		if OctoToDo_AddonsManager.profiles == nil then OctoToDo_AddonsManager.profiles = {} end
		if OctoToDo_AddonsManager.profiles.default == nil then
			E.func_SaveProfile("default")
		end
		----------------------------------------------------------------
		self:OctoToDo_Create_MainFrame_AddonsManager()
		self:func_Create_DDframe_AddonsManager()
		----------------------------------------------------------------
		E:func_CreateUtilsButton(OctoToDo_MainFrame_AddonsManager)
		E:func_CreateMinimapButton(GlobalAddonName, OctoToDo_AddonsManager, OctoToDo_MainFrame_AddonsManager)
		----------------------------------------------------------------
		if C_AddOnProfiler.IsEnabled() then
			C_Timer.NewTicker(2, function()
					if OctoToDo_MainFrame_AddonsManager:IsShown() then
						OctoToDo_EventFrame_AddonsManager:func_DataProvider()
					end
			end)
		end
	end
end
----------------------------------------------------------------
function OctoToDo_EventFrame_AddonsManager:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_AddonsManager and OctoToDo_MainFrame_AddonsManager:IsShown() then
		OctoToDo_MainFrame_AddonsManager:Hide()
	end
end
----------------------------------------------------------------
function OctoToDo_EventFrame_AddonsManager:PLAYER_LOGIN()
	OctoToDo_EventFrame_AddonsManager:func_DataProvider()
end
----------------------------------------------------------------