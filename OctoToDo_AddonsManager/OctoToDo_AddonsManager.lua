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
local OctoToDo_EventFrame_AddonsManager = CreateFrame("FRAME")
OctoToDo_EventFrame_AddonsManager:Hide()
----------------------------------------------------------------
local AddonHeight = 20 -- Высота -- OctoToDo_DB_Vars.curHeight
local AddonLeftFrameWeight = 500 -- Ширина Левого -- OctoToDo_DB_Vars.curWidthTitle
local PhysicalScreenWidth, PhysicalScreenHeight = GetPhysicalScreenSize()
local NumberOfLines = math.floor((math.floor(PhysicalScreenHeight / AddonHeight))*.7)
-- дефолт 30
local MainFrameNumLines = 30
if MainFrameNumLines > NumberOfLines then
	MainFrameNumLines = NumberOfLines
end
----------------------------------------------------------------
----------------------------------------------------------------
local ADDON_ACTIONS_BLOCKED = {}
function AddonTooltip_ActionBlocked(addon)
	ADDON_ACTIONS_BLOCKED[addon] = (ADDON_ACTIONS_BLOCKED[addon] or 0) + 1
end
----------------------------------------------------------------
local function OnENTERTTOOLTIP(f)
	if not f.tooltip then
		return
	elseif #f.tooltip == 0 then
		return
	end
	GameTooltip:SetOwner(f, "ANCHOR_BOTTOMRIGHT", 0, 0)
	for k, v in next, (f.tooltip) do
		GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
	end
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
		frame.first = CreateFrame("BUTTON", nil, frame, "SecureActionButtonTemplate, BackDropTemplate")
		frame.first:SetPropagateMouseClicks(true)
		frame.first:SetSize(AddonHeight, AddonHeight)
		frame.first:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonHeight*0, 0)
		frame.first.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.first.icon:SetAllPoints()
		-- frame.first.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		if not frame.isInit then
			frame.isInit = true
			frame.first.icon:SetScript("OnMouseUp", function(self)
					C_Timer.After(0.1, function()
							E.func_ToggleAddon(data.index)
							OctoToDo_EventFrame_AddonsManager:func_DataProvider()
					end)
			end)
		end
		frame.second = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
		frame.second:SetPropagateMouseClicks(true)
		frame.second:SetSize(AddonHeight, AddonHeight)
		frame.second:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonHeight*1, 0)
		frame.second.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.second.icon:SetAllPoints()
		-- frame.second.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%

		frame.third = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
		frame.third:SetPropagateMouseClicks(true)
		frame.third:SetSize(AddonLeftFrameWeight, AddonHeight)
		frame.third:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonHeight*2, 0)
		frame.third:SetScript("OnEnter", OnENTERTTOOLTIP)
		frame.third:SetScript("OnLeave", GameTooltip_Hide)
		frame.third.textLEFT = frame.third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.third.textLEFT:SetAllPoints()
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

	end
end
----------------------------------------------------------------
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ
local function OctoToDo_Frame_init(frame, data)
	frame.first.icon:SetTexture(data.firsticonTexture)
	frame.second.icon:SetTexture(data.icon)
	frame.third.textLEFT:SetText(data.textLEFT)
	frame.third.textRIGHT:SetText(data.textRIGHT)
	frame.third.tooltip = data.tooltipthird
	if data.index % 2 == 0 then
		E:func_SetBackdrop(frame.first, nil, 0, 0)
		E:func_SetBackdrop(frame.second, nil, 0, 0)
		E:func_SetBackdrop(frame.third, nil, 0, 0)
	else
		E:func_SetBackdrop(frame.first, "|cff000000", .1, 0)
		E:func_SetBackdrop(frame.second, "|cff000000", .1, 0)
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
	self:func_DataProvider()
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function OctoToDo_EventFrame_AddonsManager:func_DataProvider()
	local count = 0
	E.UpdatePerformance()
	local Provider = {}
	for i, v in ipairs(OctoToDo_AddonsManager.AddonList) do
		count = count + 1
		Provider[i] = Provider[i] or {}
		local tooltipthird = tooltipthird or {}
		Provider[i].index = i
		Provider[i].textLEFT = v.colorAddon..v.title.."|r"
		Provider[i].firsticonTexture = v.firsticonTexture
		Provider[i].icon = v.iconTexture
		Provider[i].textRIGHT = v.colorAddon..v.textRIGHT.."|r"
		if v.Version ~= "" then
			tooltipthird[#tooltipthird+1] = {v.colorAddon..v.title.."|r", v.colorAddon..v.Version.."|r"}
		else
			tooltipthird[#tooltipthird+1] = {v.colorAddon..v.title.."|r"}
		end
		if v.Author then
			tooltipthird[#tooltipthird+1] = {" ", v.colorAddon..v.Author.."|r"}
		end
		tooltipthird[#tooltipthird+1] = {" ", " "}


		if select(4, GetBuildInfo()) < v.AddonInterfaceVersion then
			tooltipthird[#tooltipthird+1] = {E.Red_Color..v.AddonInterfaceVersion.."|r"}
		end
		if v.memoryVivod ~= 0 then
			tooltipthird[#tooltipthird+1] = {string.format(ADDON_LIST_PERFORMANCE_MEMORY_KB, v.memoryVivod)}
		end
		Provider[i].tooltipthird = tooltipthird
	end
	MainFrameNumLines = count
	if OctoToDo_DB_Vars then
		if MainFrameNumLines > OctoToDo_DB_Vars.Addon_Height then
			MainFrameNumLines = OctoToDo_DB_Vars.Addon_Height
		end
	end
	if MainFrameNumLines < 1 then MainFrameNumLines = 1 end
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
		----------------------------------------------------------------
		-- if OctoToDo_DB_Vars then
		-- 	print (OctoToDo_DB_Vars.curWidthTitle)
		-- 	AddonHeight = OctoToDo_DB_Vars.curHeight
		-- 	AddonLeftFrameWeight = OctoToDo_DB_Vars.curWidthTitle*4
		-- end
		----------------------------------------------------------------
		if OctoToDo_AddonsManager == nil then OctoToDo_AddonsManager = {} end
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