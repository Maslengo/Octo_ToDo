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
local myEventFrame = CreateFrame("FRAME")
myEventFrame:Hide()
----------------------------------------------------------------
local AddonHeight = 20 --ADDON_BUTTON_HEIGHT -- Высота -- OctoToDo_DB_Vars.curHeight
local AddonLeftFrameWeight = 500 -- Ширина Левого -- OctoToDo_DB_Vars.curWidthTitle
local MainFrameNumLines = 30 --MAX_ADDONS_DISPLAYED
----------------------------------------------------------------
----------------------------------------------------------------
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

function E.RECURSION(i, firstABOBUS)
	for _, depIndex in ipairs(E.depsByIndex[i]) do
		local secondABOBUS = firstABOBUS:Insert({index = depIndex})
		if E.depsByIndex[depIndex] and not E.recycleByIndex[depIndex] then
			E.RECURSION(depIndex, secondABOBUS)
		end
	end
end
----------------------------------------------------------------
local function OnClick_Zero(frame, button)
	local parent = frame:GetParent()
	local node = parent:GetElementData()
	node:ToggleCollapsed()
	myEventFrame:OctoToDo_Frame_init(parent, node)
end
----------------------------------------------------------------
local function OnClick_third(frame, button)
	local parent = frame:GetParent()
	local node = parent:GetElementData()
	local index = parent:GetData().index
	if OctoToDo_MainFrame_AddonsManager:IsDragging() then
		return
	end
	E.func_ToggleAddon(index)
	if E.depsByIndex[index] and IsModifierKeyDown() then
		if IsControlKeyDown() then
			for i, depIndex in ipairs(E.depsByIndex[index]) do
				E.DisableAddOn(depIndex)
			end
			myEventFrame:OctoToDo_Frame_init(parent, node)
			myEventFrame:AddonList_Update()
		elseif IsShiftKeyDown() then
			for i, depIndex in ipairs(E.depsByIndex[index]) do
				E.EnableAddOn(depIndex)
			end
			myEventFrame:OctoToDo_Frame_init(parent, node)
			myEventFrame:AddonList_Update()
		elseif IsAltKeyDown() then
			for i, depIndex in ipairs(E.depsByIndex[index]) do
				E.func_ToggleAddon(depIndex)
			end
			myEventFrame:OctoToDo_Frame_init(parent, node)
			myEventFrame:AddonList_Update()
		end
	end
	myEventFrame:OctoToDo_Frame_init(parent, node)
end
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ / CALLBACK
local function func_OnAcquired(owner, frame, data, new)
	if new then
		frame.zero = CreateFrame("BUTTON", nil, frame, "BackDropTemplate")
		frame.zero:SetPropagateMouseClicks(false)
		frame.zero:SetSize(AddonHeight, AddonHeight)
		frame.zero:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.zero.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.zero.icon:SetAllPoints(frame.zero)
		frame.zero:SetScript("OnClick", OnClick_Zero)
		frame.first = CreateFrame("FRAME", nil, frame, "BackDropTemplate")
		frame.first:SetPropagateMouseClicks(false)
		frame.first:SetSize(AddonHeight, AddonHeight)
		frame.first:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonHeight, 0)
		frame.first.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.first.icon:SetAllPoints(frame.first)
		frame.second = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
		frame.second:SetPropagateMouseClicks(false)
		frame.second:SetSize(AddonHeight, AddonHeight)
		frame.second:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonHeight+AddonHeight, 0)
		frame.second.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.second.icon:SetAllPoints(frame.second)
		frame.third = CreateFrame("BUTTON", nil, frame, "BackDropTemplate")
		frame.third:SetPropagateMouseClicks(true)
		frame.third:SetSize(AddonHeight+AddonHeight+AddonLeftFrameWeight, AddonHeight)
		frame.third:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0) -- frame.third:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.third:SetScript("OnEnter", OnENTERTTOOLTIP)
		frame.third:SetScript("OnLeave", GameTooltip_Hide)
		frame.third.textLEFT = frame.third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.third.textLEFT:SetPoint("LEFT", frame, "LEFT", AddonHeight+AddonHeight+AddonHeight+4, 0);
		frame.third.textLEFT:SetFontObject(OctoFont11)
		frame.third.textLEFT:SetJustifyV("MIDDLE")
		frame.third.textLEFT:SetJustifyH("LEFT")
		frame.third.textLEFT:SetTextColor(1, 1, 1, 1)
		frame.third:SetScript("OnClick", OnClick_third)
		frame.third.textRIGHT = frame.third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.third.textRIGHT:SetAllPoints()
		frame.third.textRIGHT:SetFontObject(OctoFont11)
		frame.third.textRIGHT:SetJustifyV("MIDDLE")
		frame.third.textRIGHT:SetJustifyH("RIGHT")
		frame.third.textRIGHT:SetTextColor(1, 1, 1, 1)
	end
end
-- function myEventFrame:AddonTooltip_AddAddonMetric(tooltip, addon, label, metric, warningOnly)
-- 	local text, warning = AddonList:GetAddonMetricPercent(addon, label, metric);
-- 	if warning or not warningOnly then
-- 		GameTooltip_AddColoredLine(tooltip, text, WHITE_FONT_COLOR);
-- 	end
-- end

function myEventFrame:vivod_CollectAllAddons(index)
	-- local interfaceVersion = select(4, GetBuildInfo()) or 1
	local name, title, notes, loadable, reason, security, updateAvailable = C_AddOns.GetAddOnInfo(index)
	if reason ~= "MISSING" then -- Исключаем отсутствующие аддоны
		local firsticonTexture = ""
		local loadedOrLoading = E.IsAddOnLoaded(index) -- and "|cff00ff00ВКЛ|r" or "|cffff0000ВЫКЛ|r" -- STATUS
		local textRIGHT = ""
		local textLEFT = name
		local colorAddon = E.White_Color
		local iconTexture = C_AddOns.GetAddOnMetadata(index, "IconTexture")
		local iconAtlas = C_AddOns.GetAddOnMetadata(index, "IconAtlas")
		local Version = C_AddOns.GetAddOnMetadata(index, "Version") or 0
		local Author = C_AddOns.GetAddOnMetadata(index, "Author") or ""
		local RecentAverageTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.RecentAverageTime)
		local SessionAverageTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.SessionAverageTime)
		local PeakTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.PeakTime)
		local EncounterAverageTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.EncounterAverageTime)

		local state = C_AddOns.GetAddOnEnableState(name)
		local exists = C_AddOns.DoesAddOnExist(name)
		local defaultEnabled = C_AddOns.IsAddOnDefaultEnabled(name)
		local memory = GetAddOnMemoryUsage(index) or 0
		local enabled = (C_AddOns.GetAddOnEnableState(index, UnitName("player")) > Enum.AddOnEnableState.None);
		local needReload = false
		textRIGHT = E.func_Reason(reason)
		if E.IsAddOnLoaded(index) then
			if SessionAverageTime ~= "0.00" then
				textRIGHT = SessionAverageTime.."%" .. " ~ ".. PeakTime.."%"
			else
				textRIGHT = PeakTime.."%"
			end
		else
			textRIGHT = ADDON_DISABLED
			colorAddon = E.Gray_Color
		end
		if loadedOrLoading then
			firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonONgreen"
		else
			firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonOFFblack"
		end
		if (enabled and not loadedOrLoading) then
			needReload = true
			textRIGHT = "Будет включено"
			colorAddon = "|cff".."355C24"
			firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonOFFgreen"
		end
		if (not enabled and loadedOrLoading) then
			needReload = true
			textRIGHT =  "Будет отключено"
			colorAddon = "|cff".."BA1525"
			firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonOFFred"
		end
		if reason == "DEP_DISABLED" then
			textRIGHT = ADDON_DEP_DISABLED
			colorAddon = E.Red_Color
		end
		if reason == "DEMAND_LOADED" or reason == "DEP_DEMAND_LOADED" then
			textRIGHT = ADDON_DEMAND_LOADED
			colorAddon = "|cff".."6E720E"
			firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonOFFyellow"
		end

		local dep = E.AddonTooltipBuildDepsString(index)
		local depBOOLEN = false
		if dep then
			depBOOLEN = true
		end
		tooltipthird = {}
		if Version ~= 0 then
			tooltipthird[#tooltipthird+1] = {E.func_texturefromIcon(iconTexture)..colorAddon..title.."|r", E.Gray_Color..Version.."|r"}
		else
			tooltipthird[#tooltipthird+1] = {E.func_texturefromIcon(iconTexture)..colorAddon..title.."|r"}
		end
		if Author then
			tooltipthird[#tooltipthird+1] = {" ", E.Gray_Color..Author.."|r"}
		end
		if memory and memory ~= 0 then
			tooltipthird[#tooltipthird+1] = {" ", " "}
			if memory > 1024 then
				tooltipthird[#tooltipthird+1] = {"Использование памяти: ".. E.classColorHexCurrent..E.func_CompactNumberFormat(memory/1024).."|r Мб"}
			else
				tooltipthird[#tooltipthird+1] = {"Использование памяти: ".. E.classColorHexCurrent..E.func_CompactNumberFormat(memory).."|r Кб"}
			end
		end
		tooltipthird[#tooltipthird+1] = {" ", " "}
		tooltipthird[#tooltipthird+1] = {"RecentAverageTime: "..E.classColorHexCurrent..RecentAverageTime.."|r".."%"}
		tooltipthird[#tooltipthird+1] = {"SessionAverageTime: "..E.classColorHexCurrent..SessionAverageTime.."|r".."%"}
		tooltipthird[#tooltipthird+1] = {"PeakTime: "..E.classColorHexCurrent..PeakTime.."|r".."%"}
		tooltipthird[#tooltipthird+1] = {"EncounterAverageTime: "..E.classColorHexCurrent..EncounterAverageTime.."|r".."%"}
		tooltipthird[#tooltipthird+1] = {"C_AddOns.IsAddOnDefaultEnabled", tostring(defaultEnabled)}
		tooltipthird[#tooltipthird+1] = {"C_AddOns.DoesAddOnExist", tostring(exists)}
		tooltipthird[#tooltipthird+1] = {"C_AddOns.GetAddOnEnableState", tostring(state)}
		tooltipthird[#tooltipthird+1] = {" ", " "}
		tooltipthird[#tooltipthird+1] = {"loadedOrLoading", tostring(loadedOrLoading)}
		tooltipthird[#tooltipthird+1] = {"enabled", tostring(enabled)}
		tooltipthird[#tooltipthird+1] = {"needReload", tostring(needReload)}
		tooltipthird[#tooltipthird+1] = {"vivod", tostring(E.func_Reason(reason))}
		tooltipthird[#tooltipthird+1] = {ADDON_DEPENDENCIES, tostring(dep)}

		textLEFT = colorAddon..textLEFT.."|r"
		textRIGHT = colorAddon..textRIGHT.."|r"
		return firsticonTexture, iconTexture, textLEFT, textRIGHT, tooltipthird
	end
end






-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ + ГОВНО
-- ЭТО ФУНКЦИЯ АПДЕЙТА(ОТРИСОФКИ)
function myEventFrame:OctoToDo_Frame_init(frame, node)

	local data = node:GetData()

	local firstIcon = select(1, myEventFrame:vivod_CollectAllAddons(data.index))
	local iconTexture = select(2, myEventFrame:vivod_CollectAllAddons(data.index))
	local textLEFT = select(3, myEventFrame:vivod_CollectAllAddons(data.index))
	local textRIGHT = select(4, myEventFrame:vivod_CollectAllAddons(data.index))
	local tooltipthird = select(5, myEventFrame:vivod_CollectAllAddons(data.index))
	frame.first.icon:SetTexture(firstIcon)
	frame.second.icon:SetTexture(iconTexture)
	frame.third.textLEFT:SetText(textLEFT)
	frame.third.textRIGHT:SetText(textRIGHT)
	frame.third.tooltip = tooltipthird

	E:func_SetBackdrop(frame.zero, "|cff000000", .1, 0)
	if E.depsByIndex[data.index] then
		frame.zero.icon:SetTexture("Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\zakrito")
	else
		frame.zero.icon:SetTexture("Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\spacerEMPTY")
	end
	if data.index % 2 == 0 then
		E:func_SetBackdrop(frame.third, nil, 0, 0)
	else
		E:func_SetBackdrop(frame.third, "|cff000000", .1, 0)
	end
end
function myEventFrame:OctoToDo_Create_MainFrame_AddonsManager()
	local OctoToDo_MainFrame_AddonsManager = CreateFrame("BUTTON", "OctoToDo_MainFrame_AddonsManager", UIParent, "BackdropTemplate")
	tinsert(E.OctoTable_Frames, OctoToDo_MainFrame_AddonsManager)
	OctoToDo_MainFrame_AddonsManager:SetSize(AddonHeight+AddonHeight+AddonLeftFrameWeight, AddonHeight*MainFrameNumLines)
	OctoToDo_MainFrame_AddonsManager:Hide()
	OctoToDo_MainFrame_AddonsManager:SetDontSavePosition(true)
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
			OctoToDo_MainFrame_AddonsManager:SetAlpha(E.bgCa)
			OctoToDo_MainFrame_AddonsManager:StartMoving()
	end)
	OctoToDo_MainFrame_AddonsManager:SetScript("OnDragStop", function()
			OctoToDo_MainFrame_AddonsManager:SetAlpha(1)
			OctoToDo_MainFrame_AddonsManager:StopMovingOrSizing()
	end)
	OctoToDo_MainFrame_AddonsManager:RegisterForClicks("RightButtonUp")
	OctoToDo_MainFrame_AddonsManager:SetScript("OnClick", function(self) self:Hide() end)
	OctoToDo_MainFrame_AddonsManager.ScrollBox = CreateFrame("FRAME", nil, OctoToDo_MainFrame_AddonsManager, "WowScrollBoxList")
	OctoToDo_MainFrame_AddonsManager.ScrollBox:SetAllPoints()
	OctoToDo_MainFrame_AddonsManager.ScrollBox:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_AddonsManager.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_AddonsManager.ScrollBar = CreateFrame("EventFrame", nil, OctoToDo_MainFrame_AddonsManager, "MinimalScrollBar")
	OctoToDo_MainFrame_AddonsManager.ScrollBar:SetPoint("TOPLEFT", OctoToDo_MainFrame_AddonsManager.ScrollBox, "TOPRIGHT", 6, 0)
	OctoToDo_MainFrame_AddonsManager.ScrollBar:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_AddonsManager.ScrollBox, "BOTTOMRIGHT", 6, 0)
	OctoToDo_MainFrame_AddonsManager.view = CreateScrollBoxListTreeListView()
	OctoToDo_MainFrame_AddonsManager.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_AddonsManager.view:SetElementInitializer("BackdropTemplate",
		function(...)
			self:OctoToDo_Frame_init(...)
	end)
	-- OctoToDo_MainFrame_AddonsManager.view:SetElementInitializer("UIPanelButtonTemplate", Initializer) -- ПОФИКСИТЬ
	OctoToDo_MainFrame_AddonsManager.view:RegisterCallback(OctoToDo_MainFrame_AddonsManager.view.Event.OnAcquiredFrame, func_OnAcquired, OctoToDo_MainFrame_AddonsManager) -- ПОФИКСИТЬ
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame_AddonsManager.ScrollBox, OctoToDo_MainFrame_AddonsManager.ScrollBar, OctoToDo_MainFrame_AddonsManager.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame_AddonsManager.ScrollBox, OctoToDo_MainFrame_AddonsManager.ScrollBar) -- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	OctoToDo_MainFrame_AddonsManager:RegisterForDrag("LeftButton")
	OctoToDo_MainFrame_AddonsManager:SetScript("OnDragStart", function()
			OctoToDo_MainFrame_AddonsManager:SetAlpha(E.bgCa)
			OctoToDo_MainFrame_AddonsManager:StartMoving()
	end)
	OctoToDo_MainFrame_AddonsManager:SetScript("OnDragStop", function()
			OctoToDo_MainFrame_AddonsManager:SetAlpha(1)
			OctoToDo_MainFrame_AddonsManager:StopMovingOrSizing()
	end)
	OctoToDo_MainFrame_AddonsManager:RegisterForClicks("RightButtonUp")
	OctoToDo_MainFrame_AddonsManager:SetScript("OnClick", function(self) self:Hide() end)

	----------------------------------------------------------------
	self:func_Create_AdditionalFrame()
end



function myEventFrame:UpdatePerformance()
	local enabled = C_AddOnProfiler.IsEnabled()
	if enabled then
		UpdateAddOnMemoryUsage()
		-- UpdateAddOnCPUUsage() -- НЕ РАБОТАЕТ?
	end
end
function myEventFrame:AddonList_Update()
	OctoToDo_MainFrame_AddonsManager.view:SetDataProvider(self.DataProvider, ScrollBoxConstants.RetainScrollPosition)
end
function myEventFrame:CreateMyDataProvider()
	self:UpdatePerformance()
	local DataProvider = CreateTreeDataProvider()
	self.DataProvider = DataProvider
	-- local childrenNodes = DataProvider:GetChildrenNodes()
	for index = 1, C_AddOns.GetNumAddOns() do
		if not E.parentByIndex[index] or E.recycleByIndex[index] then
			local abubusTABLE = {index = index}
			local firstABOBUS = DataProvider:Insert(abubusTABLE)
			-- childrenNodes[#childrenNodes]:SetCollapsed(true) -- БРАТЬ ПОСЛЕДНЮЮ НОДУ И КОЛЛАПСИТЬ (ВЕСЬ СПИСОК ПРИ ЗАГРУЗКЕ)
			if E.depsByIndex[index] then
				E.RECURSION(index, firstABOBUS)
			end
		end
	end
	self:AddonList_Update()
end
----------------------------------------------------------------
----------------------------------------------------------------
function myEventFrame:func_Create_DDframe_AddonsManager()
	local OctoToDo_DD_AddonsManager = CreateFrame("Button", "OctoToDo_DD_AddonsManager", OctoToDo_MainFrame_AddonsManager, "BackDropTemplate")
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
				myEventFrame:AddonList_Update()
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
				myEventFrame:AddonList_Update()
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
				fpde(OctoToDo_AddonsManager)
			end
			self:ddAddButton(info, level)
			----------------------------------------------------------------
	end)
	OctoToDo_DD_AddonsManager:ddSetMenuButtonHeight(16)
end
----------------------------------------------------------------
function myEventFrame:func_Create_AdditionalFrame()
	local frameEnableAll = CreateFrame("Button", nil, OctoToDo_MainFrame_AddonsManager, "BackDropTemplate")
	frameEnableAll:SetPropagateMouseClicks(true)
	frameEnableAll:SetSize(AddonLeftFrameWeight/5, AddonHeight)
	frameEnableAll:SetPoint("TOPLEFT", OctoToDo_MainFrame_AddonsManager, "BOTTOMLEFT", 0, 0)
	E:func_SetBackdrop(frameEnableAll)
	frameEnableAll.text = frameEnableAll:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frameEnableAll.text:SetAllPoints()
	frameEnableAll.text:SetFontObject(OctoFont11)
	frameEnableAll.text:SetJustifyV("MIDDLE")
	frameEnableAll.text:SetJustifyH("CENTER")
	frameEnableAll.text:SetTextColor(1, 1, 1, 1)
	frameEnableAll.text:SetText(ENABLE_ALL_ADDONS)
	frameEnableAll:RegisterForClicks("LeftButtonUp")
	frameEnableAll:EnableMouse(true)
	if not frameEnableAll.frameEnableAll then
		frameEnableAll.frameEnableAll = true
		frameEnableAll:SetScript("OnClick", function(self)
				E.func_EnableAllAddons()
				myEventFrame:AddonList_Update()
		end)
	end
	frameEnableAll:SetScript("OnEnter", function(self)
			frameEnableAll.text:SetText("|cff355C24"..ENABLE_ALL_ADDONS.."|r")
	end)
	frameEnableAll:SetScript("OnLeave", function(self)
			frameEnableAll.text:SetText(ENABLE_ALL_ADDONS)
	end)
	----------------------------------------------------------------
	local frameDisableAll = CreateFrame("Button", nil, OctoToDo_MainFrame_AddonsManager, "BackDropTemplate")
	frameDisableAll:SetPropagateMouseClicks(true)
	frameDisableAll:SetSize(AddonLeftFrameWeight/5, AddonHeight)
	frameDisableAll:SetPoint("TOPLEFT", OctoToDo_MainFrame_AddonsManager, "BOTTOMLEFT", AddonLeftFrameWeight/5, 0)
	E:func_SetBackdrop(frameDisableAll)
	frameDisableAll.text = frameDisableAll:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frameDisableAll.text:SetAllPoints()
	frameDisableAll.text:SetFontObject(OctoFont11)
	frameDisableAll.text:SetJustifyV("MIDDLE")
	frameDisableAll.text:SetJustifyH("CENTER")
	frameDisableAll.text:SetTextColor(1, 1, 1, 1)
	frameDisableAll.text:SetText(DISABLE_ALL_ADDONS)
	frameDisableAll:RegisterForClicks("LeftButtonUp")
	frameDisableAll:EnableMouse(true)
	if not frameDisableAll.frameDisableAll then
		frameDisableAll.frameDisableAll = true
		frameDisableAll:SetScript("OnClick", function(self)
				E.func_DisableAllAddons()
				myEventFrame:AddonList_Update()
		end)
		frameDisableAll:SetScript("OnEnter", function(self)
				frameDisableAll.text:SetText("|cffBA1525"..DISABLE_ALL_ADDONS.."|r")
		end)
		frameDisableAll:SetScript("OnLeave", function(self)
				frameDisableAll.text:SetText(DISABLE_ALL_ADDONS)
		end)
	end
	----------------------------------------------------------------
	local ReloadUIAM = CreateFrame("Button", nil, OctoToDo_MainFrame_AddonsManager, "BackDropTemplate")
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






function E.GetCycleByIndex(iChild, iParent)
	if E.depsByIndex[iChild] then
		for _, depIndex in ipairs(E.depsByIndex[iChild]) do
			if depIndex == iParent then
				print (E.Red_Color.."НАЙДЕН АБОБУС: |r".. iChild .." "..C_AddOns.GetAddOnInfo(iChild).." / "..iParent.." "..C_AddOns.GetAddOnInfo(iParent))
				return true
			end
		end
	end
end
-- ДОЛЖНА ВЫЗЫВАТЬСЯ 1 РАЗ
function myEventFrame:CollectAllAddons()
	E.indexByName = {}
	for index = 1, C_AddOns.GetNumAddOns() do
		local name = C_AddOns.GetAddOnInfo(index)
		E.indexByName[name] = index
	end
	E.depsByIndex = {}
	E.parentByIndex = {}
	E.recycleByIndex = {}
	for index = 1, C_AddOns.GetNumAddOns() do
		local deps = {C_AddOns.GetAddOnDependencies(index)}
		for _, name in ipairs(deps) do
			if E.indexByName[name] then
				E.depsByIndex[E.indexByName[name]] = E.depsByIndex[E.indexByName[name]] or {}
				tinsert(E.depsByIndex[E.indexByName[name]], index)
				E.parentByIndex[index] = true
				if E.GetCycleByIndex(index, E.indexByName[name]) then
					E.recycleByIndex[index] = true
					E.recycleByIndex[E.indexByName[name]] = true
				end
			end
		end
	end
end


local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_LOGIN",
}
E.RegisterMyEventsToFrames(myEventFrame, MyEventsTable, E.func_DebugPath())
-- function E.AddonManager()
function myEventFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
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
		myEventFrame:CollectAllAddons()
		self:OctoToDo_Create_MainFrame_AddonsManager()
		self:func_Create_DDframe_AddonsManager()
		myEventFrame:CreateMyDataProvider()
		----------------------------------------------------------------
		E:func_CreateUtilsButton(OctoToDo_MainFrame_AddonsManager)
		E:func_CreateMinimapButton(GlobalAddonName, OctoToDo_AddonsManager, OctoToDo_MainFrame_AddonsManager, nil, "OctoToDo_MainFrame_AddonsManager")
		----------------------------------------------------------------
		C_Timer.NewTicker(2, function()
				if OctoToDo_MainFrame_AddonsManager and OctoToDo_MainFrame_AddonsManager:IsShown() then
					myEventFrame:AddonList_Update()
				end
		end)
	end
end
----------------------------------------------------------------
function myEventFrame:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_AddonsManager and OctoToDo_MainFrame_AddonsManager:IsShown() then
		OctoToDo_MainFrame_AddonsManager:Hide()
	end
end
