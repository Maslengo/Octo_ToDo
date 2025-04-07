local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
local OctoToDo_EventFrame_AddonsManager = CreateFrame("FRAME")
OctoToDo_EventFrame_AddonsManager:Hide()
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
local AddonHeight = 11 --ADDON_BUTTON_HEIGHT -- Высота -- OctoToDo_DB_Vars.curHeight
local curWidthTitle = 500 -- Ширина Левого -- OctoToDo_DB_Vars.curWidthTitle
local MainFrameNumLines = 60 --MAX_ADDONS_DISPLAYED
local totalNumAddOns = C_AddOns.GetNumAddOns()
if MainFrameNumLines > totalNumAddOns then
	MainFrameNumLines = totalNumAddOns
end
----------------------------------------------------------------
function E.AddDeps_RECURSION(i, groupNode)
	for _, depIndex in ipairs(E.depsByIndex[i]) do
		local secondABOBUS = groupNode:Insert({index = depIndex})
		if E.depsByIndex[depIndex] and not E.recycleByIndex[depIndex] then
			E.AddDeps_RECURSION(depIndex, secondABOBUS)
		end
	end
end
----------------------------------------------------------------
local function OnClick_Zero(frame)
	local parent = frame:GetParent() -- ЭТО ИНДЕКС?
	local node = parent:GetElementData()
	local index = node:GetData().index
	local name = C_AddOns.GetAddOnInfo(index)
	-- E:func_SetBackdrop(parent, "|cff00FF00", .1, 0)
	local IsCollapsed = node:IsCollapsed() or true -- IsCollapsed = IsOpen т.е. ОТКРЫТ
	if IsCollapsed ~= nil then
		node:ToggleCollapsed()
		OctoToDo_EventFrame_AddonsManager:OctoToDo_Frame_init(parent, node)
		OctoToDo_AddonsManager.collapsedAddons[name] = node:IsCollapsed()
	end
end

----------------------------------------------------------------

----------------------------------------------------------------
function OctoToDo_EventFrame_AddonsManager:createDDMenu()
	local DDFrame = CreateFrame("EventFrame", "DDFrame", UIParent)
	DDFrame:Hide()
	LibSFDropDown:SetMixin(DDFrame)
	DDFrame:ddSetDisplayMode(GlobalAddonName)
	DDFrame:ddSetInitFunc(function(self, level, value)
			local info = {}
			-- info.isTitle = true
			-- info.keepShownOnClick = true
			-- info.notCheckable = true -- TRUE убрать чекбокс
			-- info.isNotRadio = true -- TRUE круг, а не квадрат
			-- info.text = E.func_GetAddonTitle(value)
			-- info.hasArrow = nil
			-- info.func = nil
			-- self:ddAddButton(info, level)
			info.isTitle = false
			info.keepShownOnClick = false
			info.notCheckable = true -- TRUE убрать чекбокс
			info.isNotRadio = true -- TRUE круг, а не квадрат
			if OctoToDo_AddonsManager.lock.addons[E.func_GetAddonName(value)] then
				info.text = "Разблокировать"
			else
				info.text = "Заблокировать"
			end
			info.checked = OctoToDo_AddonsManager.lock.addons[E.func_GetAddonName(value)]
			info.func = function()
				E.func_LockAddon(value)
				E.AddonList_Update()
			end
			self:ddAddButton(info, level)
			-- info.isTitle = false
			-- info.keepShownOnClick = false
			-- info.notCheckable = true -- TRUE убрать чекбокс
			-- info.isNotRadio = true -- TRUE круг, а не квадрат
			-- info.text = CANCEL
			-- info.func = nil
			-- self:ddAddButton(info, level)
	end)
end
----------------------------------------------------------------
local function OnClick_third(frame, button)
	local parent = frame:GetParent()
	local node = parent:GetElementData()
	local addonIndex = parent:GetData().index
	local value = addonIndex
	if OctoToDo_MainFrame_AddonsManager:IsDragging() then
		return
	end
	if button == "LeftButton" then
		E.func_ToggleAddon(addonIndex)
	elseif button == "MiddleButton" then
		E.func_LockAddon(addonIndex)
	elseif button == "RightButton" then
		DDFrame:ddToggle(level, value, "cursor")
	end
	OctoToDo_EventFrame_AddonsManager:OctoToDo_Frame_init(parent, node)
	E.AddonList_Update()
end
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ / CALLBACK
function E.func_LockAddon(addonIndex)
	local name = C_AddOns.GetAddOnInfo(addonIndex)
	if OctoToDo_AddonsManager.lock.addons[name] then
		OctoToDo_AddonsManager.lock.addons[name] = false
	else
		OctoToDo_AddonsManager.lock.addons[name] = true
		-- C_AddOns.EnableAddOn(addonIndex)
	end
end
----------------------------------------------------------------
local function func_OnAcquired(owner, frame, data, new)
	if new then
		frame.zero = CreateFrame("BUTTON", nil, frame, "BackDropTemplate")
		frame.zero:SetPropagateMouseClicks(false)
		frame.zero:SetSize(AddonHeight, AddonHeight)
		frame.zero:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.zero.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.zero.icon:SetAllPoints(frame.zero)
		frame.zero:SetScript("OnClick", OnClick_Zero)
		-- frame.zero.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		frame.first = CreateFrame("FRAME", nil, frame, "BackDropTemplate")
		frame.first:SetPropagateMouseClicks(false)
		frame.first:SetSize(AddonHeight, AddonHeight)
		frame.first:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonHeight, 0)
		frame.first.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.first.icon:SetAllPoints(frame.first)
		frame.first.icon:SetTexture("Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonWHITE")
		-- frame.first.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		frame.second = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
		frame.second:SetPropagateMouseClicks(false)
		frame.second:SetSize(AddonHeight, AddonHeight)
		frame.second:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonHeight+AddonHeight, 0)
		frame.second.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.second.icon:SetAllPoints(frame.second)
		-- frame.second.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		frame.third = CreateFrame("BUTTON", nil, frame, "BackDropTemplate")
		frame.third:SetPropagateMouseClicks(true)
		frame.third:SetSize(AddonHeight+AddonHeight+curWidthTitle, AddonHeight)
		-- frame.third:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.third:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0) -- frame.third:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.third:SetScript("OnEnter", function()

			E.OnENTERTTOOLTIP(frame.third)
	end)
		frame.third:SetScript("OnLeave", GameTooltip_Hide)
		frame.third.textLEFT = frame.third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.third.textLEFT:SetPoint("LEFT", frame, "LEFT", AddonHeight+AddonHeight+AddonHeight+4, 0)
		frame.third.textLEFT:SetFontObject(OctoFont11)
		frame.third.textLEFT:SetJustifyV("MIDDLE")
		frame.third.textLEFT:SetJustifyH("LEFT")
		frame.third.textLEFT:SetTextColor(1, 1, 1, 1)
		-- frame.third:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButton")
		frame.third:RegisterForClicks("AnyUp")
		frame.third:SetScript("OnClick", OnClick_third)
		frame.third.textRIGHT = frame.third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.third.textRIGHT:SetAllPoints()
		frame.third.textRIGHT:SetFontObject(OctoFont11)
		frame.third.textRIGHT:SetJustifyV("MIDDLE")
		frame.third.textRIGHT:SetJustifyH("RIGHT")
		frame.third.textRIGHT:SetTextColor(1, 1, 1, 1)
	end
end

----------------------------------------------------------------


function OctoToDo_EventFrame_AddonsManager:CollectAddonInfo(addonIndex)
	local name, title, notes, _, _, security = C_AddOns.GetAddOnInfo(addonIndex)
	local character = GetAddonCharacter()
	local loadable, reason = C_AddOns.IsAddOnLoadable(addonIndex, character)
	if reason ~= "MISSING" then -- Исключаем отсутствующие аддоны
		local firsticonTexture = ""
		tooltipthird = {}
		local textRIGHT = " "
		local colorAddon = E.White_Color
		local Version = C_AddOns.GetAddOnMetadata(addonIndex, "Version") or 0
		local Author = C_AddOns.GetAddOnMetadata(addonIndex, "Author") or ""
		local exists = C_AddOns.DoesAddOnExist(name)
		-- local interfaceVersion = E.interfaceVersion
		-- if E.interfaceVersion >= 110105 then
		-- interfaceVersion = C_AddOns.GetAddOnInterfaceVersion(name)
		-- else
		-- interfaceVersion = 110105
		-- end
		local defaultEnabled = C_AddOns.IsAddOnDefaultEnabled(name)
		local checkboxState = C_AddOns.GetAddOnEnableState(addonIndex, character)
		local enabled = (C_AddOns.GetAddOnEnableState(addonIndex, UnitName("player")) > Enum.AddOnEnableState.None)
		if (checkboxState == Enum.AddOnEnableState.Some ) then
			tooltipthird[#tooltipthird+1] = ENABLED_FOR_SOME
			-- else
			-- tooltipthird[#tooltipthird+1] = nil
		end
		if ( loadable or ( enabled and (reason == "DEP_DEMAND_LOADED" or reason == "DEMAND_LOADED") ) ) then
			colorAddon = E.func_rgb2hexDEV(1.0, 0.78, 0.0)
			-- colorAddon = E.White_Color
		elseif ( enabled and reason ~= "DEP_DISABLED" ) then
			colorAddon = E.func_rgb2hexDEV(1.0, 0.1, 0.1)
		else
			colorAddon = E.func_rgb2hexDEV(0.5, 0.5, 0.5)
		end
		local iconTexture = C_AddOns.GetAddOnMetadata(addonIndex, "IconTexture")
		local iconAtlas = C_AddOns.GetAddOnMetadata(addonIndex, "IconAtlas")
		if not iconTexture and not iconAtlas and OctoToDo_AddonsManager.config.showIconsQuestionMark then
			iconTexture = [[Interface\ICONS\INV_Misc_QuestionMark]]
		end
		local textLEFT = name
		if OctoToDo_AddonsManager.config.fullName and title then
			textLEFT = title
		end
		if OctoToDo_AddonsManager.config.showVersion and Version ~= "" and Version ~= 0 then
			textLEFT = textLEFT..E.Gray_Color.." ("..Version..")|r"
		end
		if OctoToDo_AddonsManager.config.showIndex then
			textLEFT = E.Debug_Color..addonIndex.."|r "..textLEFT
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
		-- textRIGHT = E.func_Reason(reason)
		if (security == BANNED_ADDON) then
			tooltipthird[#tooltipthird+1] = {ADDON_BANNED_TOOLTIP}
		else
			if title then
				tooltipthird[#tooltipthird+1] = {title}
			else
				tooltipthird[#tooltipthird+1] = {name}
			end
			if (reason == "MISSING") then
				tooltipthird[#tooltipthird+1] = {E.classColorHexCurrent.."This addons is not installed!|r"}
			end
			if (Version and Version ~= 0) then
				tooltipthird[#tooltipthird+1] = {"Version: "..E.classColorHexCurrent..Version.."|r"} --.. " ("..interfaceVersion..")"}
			end
			if (Author and Author ~= "") then
				tooltipthird[#tooltipthird+1] = {"Author: "..E.classColorHexCurrent..Author.."|r"}
			end
			if (notes and notes ~= "") then
				tooltipthird[#tooltipthird+1] = {"Notes: "..E.classColorHexCurrent..notes.."|r"}
			end
			if (loadable and C_AddOnProfiler.IsEnabled()) then
				local RecentAverageTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.RecentAverageTime)
				local SessionAverageTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.SessionAverageTime)
				local PeakTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.PeakTime)
				local EncounterAverageTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.EncounterAverageTime)
				tooltipthird[#tooltipthird+1] = {" ", " "}
				tooltipthird[#tooltipthird+1] = {"RecentAverageTime: "..E.classColorHexCurrent..RecentAverageTime.."|r".."%"}
				tooltipthird[#tooltipthird+1] = {"SessionAverageTime: "..E.classColorHexCurrent..SessionAverageTime.."|r".."%"}
				tooltipthird[#tooltipthird+1] = {"PeakTime: "..E.classColorHexCurrent..PeakTime.."|r".."%"}
				if EncounterAverageTime ~= "" then
					tooltipthird[#tooltipthird+1] = {"EncounterAverageTime: "..E.classColorHexCurrent..EncounterAverageTime.."|r".."%"}
				end
				-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 5ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver5Ms))
				-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 10ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver10Ms))
				-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 50ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver50Ms))
				-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 100ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver100Ms))
				-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 500ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver500Ms))
			end
			-- and IsMemoryUsageEnabled()
			if (loadable and security ~= SECURE_PROTECTED_ADDON and security ~= SECURE_ADDON) then
				local memory = GetAddOnMemoryUsage(addonIndex) or 0
				if memory > 1024 then
					tooltipthird[#tooltipthird+1] = {"Использование памяти: ".. E.classColorHexCurrent..E.func_CompactNumberFormat(memory/1024).."|r Мб"}
				else
					tooltipthird[#tooltipthird+1] = {"Использование памяти: ".. E.classColorHexCurrent..E.func_CompactNumberFormat(memory).."|r Кб"}
				end
			end
			tooltipthird[#tooltipthird+1] = {" ", " "}
			tooltipthird[#tooltipthird+1] = {E.AddonTooltipBuildDepsString(addonIndex, Parent_Color)}
			if E.depsByIndex[addonIndex] then
				tooltipthird[#tooltipthird+1] = {"Дочернии аддоны"}
				for _, depIndex in pairs(E.depsByIndex[addonIndex]) do
					tooltipthird[#tooltipthird+1] = {" "..Child_Color..C_AddOns.GetAddOnInfo(depIndex).."|r"}
				end
			end
			if loadable then
				firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonONgreen"
			else
				firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonOFFblack"
			end
			local needReload = false
			if (enabled and not loadable) then
				needReload = true
				firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonOFFgreen"
			end
			if (not enabled and loadable) then
				needReload = true
				firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonOFFred"
			end
			if reason == "DEMAND_LOADED" or reason == "DEP_DEMAND_LOADED" then
				firsticonTexture = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\buttonOFFyellow"
			end
			-- if C_AddOns.IsAddonVersionCheckEnabled() and E.interfaceVersion > interfaceVersion and enabled then
			-- colorAddon = "|cffFF0000"
			-- textRIGHT = ADDON_INTERFACE_VERSION.." ("..interfaceVersion..")"
			-- end
			local dep = E.AddonTooltipBuildDepsString(addonIndex)
			local depBOOLEN = false
			if dep then
				depBOOLEN = true
			end
		end
		local resonTEXT = ""
		if ( not loadable and reason ) then
			resonTEXT = _G["ADDON_"..reason]
		else
			resonTEXT = ""
		end
		if OctoToDo_AddonsManager.lock.addons[name] then
			textLEFT = CreateSimpleTextureMarkup([[Interface\AddOns\OctoToDo\Media\SimpleAddonManager\lock]], AddonHeight, AddonHeight)..textLEFT
		end
		textRIGHT = colorAddon.. resonTEXT .."|r"
		return firsticonTexture, iconTexture, colorAddon..textLEFT.."|r", textRIGHT, tooltipthird, colorAddon
	end
end
----------------------------------------------------------------






local function UpdateExpandOrCollapseButtonState(button, isCollapsed)
	if (isCollapsed) then

		button:SetTexture("Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\zakrito")
		button:SetVertexColor(1, 0, 0, 1)
		-- button:SetTexture("Interface\\Buttons\\UI-PlusButton-Up")
	else

		button:SetTexture("Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\otkrito")
		button:SetVertexColor(1, 1, 1, 1)
		-- button:SetTexture("Interface\\Buttons\\UI-MinusButton-Up")
	end
end

local function CollapseOrExpand(button, isCollapsed, node, name)


end
local showExpandOrCollapseButton = true
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ + ГОВНО
-- ЭТО ФУНКЦИЯ АПДЕЙТА(ОТРИСОФКИ)
function OctoToDo_EventFrame_AddonsManager:OctoToDo_Frame_init(frame, node)
	local data = node:GetData()
	local index = node:GetData().index
	local name = C_AddOns.GetAddOnInfo(index)
	local firsticonTexture = select(1, OctoToDo_EventFrame_AddonsManager:CollectAddonInfo(data.index))
	local iconTexture = select(2, OctoToDo_EventFrame_AddonsManager:CollectAddonInfo(data.index))
	local textLEFT = select(3, OctoToDo_EventFrame_AddonsManager:CollectAddonInfo(data.index))
	local textRIGHT = select(4, OctoToDo_EventFrame_AddonsManager:CollectAddonInfo(data.index))
	local tooltipthird = select(5, OctoToDo_EventFrame_AddonsManager:CollectAddonInfo(data.index))
	-- local colorAddon = select(6, OctoToDo_EventFrame_AddonsManager:CollectAddonInfo(data.index))
	frame.first.icon:SetTexture(firsticonTexture)


	if (OctoToDo_AddonsManager.collapsedAddons[name] == true and E.IsAddonCollapsed(name) == true) then
		node:ToggleCollapsed()
		print ("ЗАКРЫЛ: "..name)
		OctoToDo_AddonsManager.collapsedAddons[name] = false
	end
	if showExpandOrCollapseButton then
		if E.depsByIndex[data.index] then
			UpdateExpandOrCollapseButtonState(frame.zero.icon, node:IsCollapsed(), node, name)
		else
			frame.zero.icon:SetTexture("Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\spacerEMPTY")
		end
	else
		frame.zero:Hide()
	end




	if OctoToDo_AddonsManager.config.showIcons then
		frame.third.textLEFT:SetPoint("LEFT", frame, "LEFT", AddonHeight+AddonHeight+AddonHeight+4, 0)
		frame.second.icon:SetTexture(iconTexture)
	else
		frame.third.textLEFT:SetPoint("LEFT", frame, "LEFT", AddonHeight+AddonHeight+4, 0)
		frame.second.icon:SetTexture(E.Icon_Empty)
	end
	frame.third.textLEFT:SetText(textLEFT)
	frame.third.textRIGHT:SetText(textRIGHT)
	frame.third.tooltip = tooltipthird
	E:func_SetBackdrop(frame.zero, nil, 0, 0)
	-- if data.index % 2 == 0 then
		E:func_SetBackdrop(frame.third, nil, 0, 0)
	-- else
	-- 	E:func_SetBackdrop(frame.third, "|cff000000", .1, 0)
	-- end
end
function E.UpdateDBdata()
	local AddonHeight = OctoToDo_AddonsManager.AddonHeight
	local MainFrameNumLines = OctoToDo_AddonsManager.MainFrameNumLines
	local curWidthTitle = OctoToDo_AddonsManager.curWidthTitle
	local MAXSIZE = math.floor((E.MonitorHeight-E.MonitorHeight/6 )/ AddonHeight )
	if MainFrameNumLines > MAXSIZE then
		MainFrameNumLines = MAXSIZE
	end
	-- MainFrameNumLines
	-- OctoToDo_MainFrame_AddonsManager.view
	OctoToDo_MainFrame_AddonsManager:SetSize(AddonHeight+AddonHeight+curWidthTitle, AddonHeight*MainFrameNumLines)
	frameEnableAll:SetSize(curWidthTitle/5, AddonHeight)
	frameDisableAll:SetSize(curWidthTitle/5, AddonHeight)
	frameCollapseAll:SetSize(curWidthTitle/5, AddonHeight)
	frameExpandAll:SetSize(curWidthTitle/5, AddonHeight)
	OkayButton:SetSize(curWidthTitle/5, AddonHeight)
	CancelButton:SetSize(curWidthTitle/5, AddonHeight)
	-- OctoToDo_MainFrame_AddonsManager.view.zero:SetSize(AddonHeight, AddonHeight)
	-- OctoToDo_MainFrame_AddonsManager.view.first:SetSize(AddonHeight, AddonHeight)
	-- OctoToDo_MainFrame_AddonsManager.view.second:SetSize(AddonHeight, AddonHeight)
	-- OctoToDo_MainFrame_AddonsManager.view.third:SetSize(AddonHeight+AddonHeight+curWidthTitle, AddonHeight)
	OctoToDo_MainFrame_AddonsManager.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_AddonsManager.ScrollBox:RecalculateDerivedExtent()
end
function OctoToDo_EventFrame_AddonsManager:OctoToDo_Create_MainFrame_AddonsManager()
	local OctoToDo_MainFrame_AddonsManager = CreateFrame("BUTTON", "OctoToDo_MainFrame_AddonsManager", UIParent, "BackdropTemplate")
	tinsert(E.OctoTable_Frames, OctoToDo_MainFrame_AddonsManager)
	OctoToDo_MainFrame_AddonsManager:SetSize(AddonHeight+AddonHeight+curWidthTitle, AddonHeight*MainFrameNumLines)
	OctoToDo_MainFrame_AddonsManager:Hide()
	OctoToDo_MainFrame_AddonsManager:SetDontSavePosition(true)
	OctoToDo_MainFrame_AddonsManager:SetClampedToScreen(false)
	OctoToDo_MainFrame_AddonsManager:SetFrameStrata("HIGH")
	OctoToDo_MainFrame_AddonsManager:SetPoint("CENTER", 0, 0)
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
	-- OctoToDo_MainFrame_AddonsManager:RegisterForClicks("RightButtonUp") -- ПОФИКСИТЬ (ДОБАВИТЬ ОПЦИЮ ЛОКА)
	-- OctoToDo_MainFrame_AddonsManager:SetScript("OnClick", function(self) self:Hide() end)
	OctoToDo_MainFrame_AddonsManager.ScrollBox = CreateFrame("FRAME", nil, OctoToDo_MainFrame_AddonsManager, "WowScrollBoxList")
	OctoToDo_MainFrame_AddonsManager.ScrollBox:SetAllPoints()
	OctoToDo_MainFrame_AddonsManager.ScrollBox:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_AddonsManager.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_AddonsManager.ScrollBox:Layout()
	OctoToDo_MainFrame_AddonsManager.ScrollBar = CreateFrame("EventFrame", nil, OctoToDo_MainFrame_AddonsManager, "MinimalScrollBar")
	OctoToDo_MainFrame_AddonsManager.ScrollBar:SetPoint("TOPLEFT", OctoToDo_MainFrame_AddonsManager.ScrollBox, "TOPRIGHT", 6, 0)
	OctoToDo_MainFrame_AddonsManager.ScrollBar:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_AddonsManager.ScrollBox, "BOTTOMRIGHT", 6, 0)
	OctoToDo_MainFrame_AddonsManager.view = CreateScrollBoxListTreeListView()
	OctoToDo_MainFrame_AddonsManager.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_AddonsManager.view:SetElementInitializer("BackdropTemplate",
		function(...)
			self:OctoToDo_Frame_init(...)
	end)
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
	----------------------------------------------------------------
end

function E.AddonList_Update()
	if ( E.AddonList_HasAnyChanged() ) then
		OkayButton.text:SetText(RELOADUI)
		OctoToDo_EventFrame_AddonsManager.shouldReload = true
	else
		OkayButton.text:SetText(OKAY)
		OctoToDo_EventFrame_AddonsManager.shouldReload = false
	end

	OctoToDo_MainFrame_AddonsManager.view:SetDataProvider(OctoToDo_EventFrame_AddonsManager.DataProvider, ScrollBoxConstants.RetainScrollPosition)
end
function OctoToDo_EventFrame_AddonsManager:CreateMyDataProvider()
	E.UpdatePerformance()
	local DataProvider = CreateTreeDataProvider()
	self.DataProvider = DataProvider
	-- local childrenNodes = DataProvider:GetChildrenNodes()
	for index = 1, C_AddOns.GetNumAddOns() do
		if not E.parentByIndex[index] or E.recycleByIndex[index] then
			local groupNode = DataProvider:Insert({index = index})
			-- childrenNodes[#childrenNodes]:SetCollapsed(true) -- БРАТЬ ПОСЛЕДНЮЮ НОДУ И КОЛЛАПСИТЬ (ВЕСЬ СПИСОК ПРИ ЗАГРУЗКЕ)
			if E.depsByIndex[index] then
				E.AddDeps_RECURSION(index, groupNode)
			end
		end
	end
	E.AddonList_Update()
end
function OctoToDo_EventFrame_AddonsManager:func_Create_AdditionalFrame()
	----------------------------------------------------------------
	local frameEnableAll = CreateFrame("Button", "frameEnableAll", OctoToDo_MainFrame_AddonsManager, "BackDropTemplate")
	frameEnableAll:SetPropagateMouseClicks(true)
	frameEnableAll:SetSize(curWidthTitle/5, AddonHeight)
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
	frameEnableAll:SetScript("OnClick", function(self)
			E.func_SetEnabledAll()
			E.AddonList_Update()
	end)
	----------------------------------------------------------------
	local frameDisableAll = CreateFrame("Button", "frameDisableAll", OctoToDo_MainFrame_AddonsManager, "BackDropTemplate")
	frameDisableAll:SetPropagateMouseClicks(true)
	frameDisableAll:SetSize(curWidthTitle/5, AddonHeight)
	frameDisableAll:SetPoint("TOPLEFT", OctoToDo_MainFrame_AddonsManager, "BOTTOMLEFT", curWidthTitle/5, 0)
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
	frameDisableAll:SetScript("OnClick", function(self)
			E.func_DisableAllAddons()
			E.AddonList_Update()
	end)
	----------------------------------------------------------------
	local frameCollapseAll = CreateFrame("Button", "frameCollapseAll", OctoToDo_MainFrame_AddonsManager, "BackDropTemplate")
	frameCollapseAll:SetPropagateMouseClicks(true)
	frameCollapseAll:SetSize(curWidthTitle/5, AddonHeight)
	frameCollapseAll:SetPoint("TOPLEFT", OctoToDo_MainFrame_AddonsManager, "BOTTOMLEFT", 0, -AddonHeight)
	E:func_SetBackdrop(frameCollapseAll)
	frameCollapseAll.text = frameCollapseAll:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frameCollapseAll.text:SetAllPoints()
	frameCollapseAll.text:SetFontObject(OctoFont11)
	frameCollapseAll.text:SetJustifyV("MIDDLE")
	frameCollapseAll.text:SetJustifyH("CENTER")
	frameCollapseAll.text:SetTextColor(1, 1, 1, 1)
	frameCollapseAll.text:SetText("Collapse ALL")
	frameCollapseAll:RegisterForClicks("LeftButtonUp")
	frameCollapseAll:EnableMouse(true)
	frameCollapseAll:SetScript("OnClick", function(self)
			for addonIndex, v in pairs(E.parentByIndex) do
				OctoToDo_AddonsManager.collapsedAddons[E.func_GetAddonName(addonIndex)] = true
			end
			E.AddonList_Update()
	end)
	----------------------------------------------------------------
	local frameExpandAll = CreateFrame("Button", "frameExpandAll", OctoToDo_MainFrame_AddonsManager, "BackDropTemplate")
	frameExpandAll:SetPropagateMouseClicks(true)
	frameExpandAll:SetSize(curWidthTitle/5, AddonHeight)
	frameExpandAll:SetPoint("TOPLEFT", OctoToDo_MainFrame_AddonsManager, "BOTTOMLEFT", curWidthTitle/5, -AddonHeight)
	E:func_SetBackdrop(frameExpandAll)
	frameExpandAll.text = frameExpandAll:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frameExpandAll.text:SetAllPoints()
	frameExpandAll.text:SetFontObject(OctoFont11)
	frameExpandAll.text:SetJustifyV("MIDDLE")
	frameExpandAll.text:SetJustifyH("CENTER")
	frameExpandAll.text:SetTextColor(1, 1, 1, 1)
	frameExpandAll.text:SetText("Expand ALL")
	frameExpandAll:RegisterForClicks("LeftButtonUp")
	frameExpandAll:EnableMouse(true)
	frameExpandAll:SetScript("OnClick", function(self)
			for addonIndex, v in pairs(E.parentByIndex) do
				OctoToDo_AddonsManager.collapsedAddons[E.func_GetAddonName(addonIndex)] = false
			end
			E.AddonList_Update()
	end)
	----------------------------------------------------------------
	local OkayButton = CreateFrame("Button", "OkayButton", OctoToDo_MainFrame_AddonsManager, "BackDropTemplate")
	OkayButton:SetPropagateMouseClicks(true)
	OkayButton:SetSize(curWidthTitle/5, AddonHeight)
	OkayButton:SetPoint("TOPRIGHT", OctoToDo_MainFrame_AddonsManager, "BOTTOMRIGHT", -curWidthTitle/5, 0)
	E:func_SetBackdrop(OkayButton)
	OkayButton.text = OkayButton:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	OkayButton.text:SetAllPoints()
	OkayButton.text:SetFontObject(OctoFont11)
	OkayButton.text:SetJustifyV("MIDDLE")
	OkayButton.text:SetJustifyH("CENTER")
	OkayButton.text:SetTextColor(1, 1, 1, 1)
	OkayButton.text:SetText(RELOADUI)
	OkayButton:RegisterForClicks("LeftButtonUp")
	OkayButton:EnableMouse(true)
	OkayButton:SetScript("OnClick", function(self)
			OctoToDo_EventFrame_AddonsManager:AddonList_OnOkay()
	end)
	----------------------------------------------------------------
	local CancelButton = CreateFrame("Button", "CancelButton", OctoToDo_MainFrame_AddonsManager, "BackDropTemplate")
	CancelButton:SetPropagateMouseClicks(true)
	CancelButton:SetSize(curWidthTitle/5, AddonHeight)
	CancelButton:SetPoint("TOPRIGHT", OctoToDo_MainFrame_AddonsManager, "BOTTOMRIGHT", 0, 0)
	E:func_SetBackdrop(CancelButton)
	CancelButton.text = CancelButton:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	CancelButton.text:SetAllPoints()
	CancelButton.text:SetFontObject(OctoFont11)
	CancelButton.text:SetJustifyV("MIDDLE")
	CancelButton.text:SetJustifyH("CENTER")
	CancelButton.text:SetTextColor(1, 1, 1, 1)
	CancelButton.text:SetText(CANCEL)
	CancelButton:RegisterForClicks("LeftButtonUp")
	CancelButton:EnableMouse(true)
	CancelButton:SetScript("OnClick", function(self)
			OctoToDo_EventFrame_AddonsManager:AddonList_OnCancel()
	end)
	----------------------------------------------------------------
end
function OctoToDo_EventFrame_AddonsManager:AddonList_OnOkay()
	PlaySound(SOUNDKIT.GS_LOGIN_CHANGE_REALM_OK)
	self:AddonList_Hide(true)
	if ( OctoToDo_EventFrame_AddonsManager.shouldReload ) then
		ReloadUI()
	end
end
function OctoToDo_EventFrame_AddonsManager:AddonList_Hide(save)
	AddonList.save = save
	-- HideUIPanel(OctoToDo_MainFrame_AddonsManager)
	if OctoToDo_MainFrame_AddonsManager and OctoToDo_MainFrame_AddonsManager:IsShown() then
		OctoToDo_MainFrame_AddonsManager:Hide()
	end
end
function OctoToDo_EventFrame_AddonsManager:AddonList_OnCancel()
	PlaySound(SOUNDKIT.GS_LOGIN_CHANGE_REALM_CANCEL)
	self:AddonList_Hide(false)
end
function E.CheckWTFinfo()
	if OctoToDo_AddonsManager == nil then OctoToDo_AddonsManager = {} end
	if OctoToDo_AddonsManager.collapsedAddons == nil then OctoToDo_AddonsManager.collapsedAddons = {} end
	if OctoToDo_AddonsManager.profiles == nil then OctoToDo_AddonsManager.profiles = {} end
	if OctoToDo_AddonsManager.config == nil then OctoToDo_AddonsManager.config = {} end
	if OctoToDo_AddonsManager.config.fullName == nil then OctoToDo_AddonsManager.config.fullName = false end
	if OctoToDo_AddonsManager.config.showIcons == nil then OctoToDo_AddonsManager.config.showIcons = false end
	if OctoToDo_AddonsManager.config.showIconsQuestionMark == nil then OctoToDo_AddonsManager.config.showIconsQuestionMark = true end
	if OctoToDo_AddonsManager.config.showVersion == nil then OctoToDo_AddonsManager.config.showVersion = false end
	if OctoToDo_AddonsManager.config.showIndex == nil then OctoToDo_AddonsManager.config.showIndex = false end
	if OctoToDo_AddonsManager.config.minimaphide == nil then OctoToDo_AddonsManager.config.minimaphide = false end
	if OctoToDo_AddonsManager.config.hookMenuButton == nil then OctoToDo_AddonsManager.config.hookMenuButton = false end
	if OctoToDo_AddonsManager.config.sortingCpu == nil then OctoToDo_AddonsManager.config.sortingCpu = false end
	if OctoToDo_AddonsManager.config.profilingcpuShowCurrent == nil then OctoToDo_AddonsManager.config.profilingcpuShowCurrent = true end
	if OctoToDo_AddonsManager.config.profilingcpuShowEncounter == nil then OctoToDo_AddonsManager.config.profilingcpuShowEncounter = true end
	if OctoToDo_AddonsManager.config.profilingcpuShowPeak == nil then OctoToDo_AddonsManager.config.profilingcpuShowPeak = true end
	if OctoToDo_AddonsManager.config.profilingcpuShowAverage == nil then OctoToDo_AddonsManager.config.profilingcpuShowAverage = true end
	if OctoToDo_AddonsManager.config.profilingcpuUpdate == nil then OctoToDo_AddonsManager.config.profilingcpuUpdate = 0 end
	if OctoToDo_AddonsManager.config.localizeCategoryName == nil then OctoToDo_AddonsManager.config.localizeCategoryName = true end
	if OctoToDo_AddonsManager.config.showVersions == nil then OctoToDo_AddonsManager.config.showVersions = true end
	if OctoToDo_AddonsManager.config.autofocusSearch == nil then OctoToDo_AddonsManager.config.autofocusSearch = true end
	if OctoToDo_AddonsManager.config.sorting == nil then OctoToDo_AddonsManager.config.sorting = "title" end
	if OctoToDo_AddonsManager.config.showSecureAddons == nil then OctoToDo_AddonsManager.config.showSecureAddons = true end
	if OctoToDo_AddonsManager.config.addonListStyle == nil then OctoToDo_AddonsManager.config.addonListStyle = "tree" end
	if OctoToDo_AddonsManager.config.showTocXCategory == nil then OctoToDo_AddonsManager.config.showTocXCategory = true end
	if OctoToDo_AddonsManager.config.showTocCategory == nil then OctoToDo_AddonsManager.config.showTocCategory = true end
	if OctoToDo_AddonsManager.config.showMemoryInBrokerTtp == nil then OctoToDo_AddonsManager.config.showMemoryInBrokerTtp = true end
	if OctoToDo_AddonsManager.isCategoryFrameVisible == nil then OctoToDo_AddonsManager.isCategoryFrameVisible = true end
	if OctoToDo_AddonsManager.lock == nil then OctoToDo_AddonsManager.lock = {} end
	if OctoToDo_AddonsManager.lock.addons == nil then OctoToDo_AddonsManager.lock.addons = {} end
	if OctoToDo_AddonsManager.lock.addons[E.GlobalAddonName] == nil then OctoToDo_AddonsManager.lock.addons[E.GlobalAddonName] = true end
	if OctoToDo_AddonsManager.AddonHeight == nil then OctoToDo_AddonsManager.AddonHeight = 20 end -- ВЫСОТА СТРОКИ
	AddonHeight = OctoToDo_AddonsManager.AddonHeight
	if OctoToDo_AddonsManager.MainFrameNumLines == nil then OctoToDo_AddonsManager.MainFrameNumLines = 30 end -- КОЛИЧЕСТВО СТРОК
	MainFrameNumLines = OctoToDo_AddonsManager.MainFrameNumLines
	if OctoToDo_AddonsManager.curWidthTitle == nil then OctoToDo_AddonsManager.curWidthTitle = 500 end -- ШИРИНА ФРЕЙМА АДДОНА
	curWidthTitle = OctoToDo_AddonsManager.curWidthTitle
end
----------------------------------------------------------------
function E:GetCycleByIndexSFMICT(iChild, iParent)
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
function OctoToDo_EventFrame_AddonsManager:CollectAllAddonsSFMICT()
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
				if E:GetCycleByIndexSFMICT(index, E.indexByName[name]) then
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
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_AddonsManager, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_AddonsManager:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		-- if OctoToDo_DB_Vars then
		-- print (OctoToDo_DB_Vars.curWidthTitle)
		-- AddonHeight = OctoToDo_DB_Vars.curHeight
		-- curWidthTitle = OctoToDo_DB_Vars.curWidthTitle*4
		-- end
		----------------------------------------------------------------
		E.CheckWTFinfo()
		self.startStatus = {}
		self.shouldReload = false
		self.outOfDate = C_AddOns.IsAddonVersionCheckEnabled() and AddonList_HasOutOfDate()
		self.outOfDateIndexes = {}
		for i=1, C_AddOns.GetNumAddOns() do
			self.startStatus[i] = (C_AddOns.GetAddOnEnableState(i, UnitName("player")) > Enum.AddOnEnableState.None)
			if (select(5, C_AddOns.GetAddOnInfo(i)) == "INTERFACE_VERSION") then
				tinsert(self.outOfDateIndexes, i)
			end
		end
		addonCharacter = UnitGUID("player")
		if OctoToDo_AddonsManager.profiles.default == nil then
			print ("NADO SOZDAT")
			E.func_SaveProfile("default")
		end
		print ("/uam")

		self:CollectAllAddonsSFMICT()
		self:OctoToDo_Create_MainFrame_AddonsManager()
		self:func_Create_AdditionalFrame()
		E:func_Create_DDframe_AddonsManager()
		self:CreateMyDataProvider()
		-- E.AddonList_Update()
		E:InitOptionsADDONS()
		self:createDDMenu()
		----------------------------------------------------------------
		E:func_CreateUtilsButton(OctoToDo_MainFrame_AddonsManager, GlobalAddonName)
		E:func_CreateMinimapButton(GlobalAddonName, OctoToDo_AddonsManager, OctoToDo_MainFrame_AddonsManager, nil, "OctoToDo_MainFrame_AddonsManager")
		OctoToDo_MainFrame_AddonsManager:SetScript("OnShow", function()
				C_Timer.After(0, function()
						E.AddonList_Update()
				end)
		end)
		----------------------------------------------------------------
	end
end
----------------------------------------------------------------
function OctoToDo_EventFrame_AddonsManager:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_AddonsManager and OctoToDo_MainFrame_AddonsManager:IsShown() then
		OctoToDo_MainFrame_AddonsManager:Hide()
	end
end
-- self.SearchBox:HookScript("OnTextChanged", AddonList_Update)