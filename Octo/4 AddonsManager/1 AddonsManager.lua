local GlobalAddonName, E = ...
local enable = false
if enable then
	print (E.func_Gradient("1 AddonsManager: ")..VIDEO_OPTIONS_ENABLED)
	local Octo_EventFrame_AddonsManager = CreateFrame("FRAME")
	Octo_EventFrame_AddonsManager:Hide()
	local Octo_MainFrame_AddonsManager = CreateFrame("BUTTON", "Octo_MainFrame_AddonsManager", UIParent, "BackdropTemplate")
	Octo_MainFrame_AddonsManager:Hide()
	tinsert(UISpecialFrames, "Octo_MainFrame_AddonsManager")
	tinsert(E.OctoTable_Frames, Octo_MainFrame_AddonsManager)
	----------------------------------------------------------------
	local AddonHeight = 20 --Octo_ToDo_DB_Vars.AddonHeight --20
	local AddonLeftFrameWeight = 200
	local AddonCentralFrameWeight = 90
	local MainFrameDefaultLines = 30
	local MainFrameTotalLines = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / AddonHeight))*.7)
	if MainFrameDefaultLines > MainFrameTotalLines then
		MainFrameDefaultLines = MainFrameTotalLines
	end
	local SFDropDownWeight = 100
	local MaxNumCharacters = 10
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
	local addonCharacter = ALL_CHARACTERS
	local function GetAddonCharacter()
		if addonCharacter == ALL_CHARACTERS then
			return nil
		end
		return addonCharacter
	end
	----------------------------------------------------------------
	function E.AddDeps_RECURSION(i, groupNode)
		for _, depIndex in ipairs(Octo_AddonsTable.depsByIndex[i]) do
			local secondABOBUS = groupNode:Insert({index = depIndex})
			if Octo_AddonsTable.depsByIndex[depIndex] and not Octo_AddonsTable.recycleByIndex[depIndex] then
				E.AddDeps_RECURSION(depIndex, secondABOBUS)
			end
		end
	end
	----------------------------------------------------------------
	local function OnClick_Zero(frame)
		local parent = frame:GetParent() -- ЭТО ИНДЕКС?
		local node = parent:GetElementData()
		local index = node:GetData().index
		local name = E.func_GetAddonName(index)
		local IsCollapsed = node:IsCollapsed() or true -- IsCollapsed = IsOpen т.е. ОТКРЫТ
		if IsCollapsed ~= nil then
			node:ToggleCollapsed()
			Octo_EventFrame_AddonsManager:Octo_Frame_init(parent, node)
			Octo_AddonsManager_DB.collapsedAddons[name] = node:IsCollapsed()
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	function Octo_EventFrame_AddonsManager:createDDMenu()
		local DDFrame = CreateFrame("EventFrame", "DDFrame", UIParent)
		DDFrame:Hide()
		LibSFDropDown:SetMixin(DDFrame)
		DDFrame:ddSetDisplayMode(GlobalAddonName)
		DDFrame:ddSetInitFunc(function(self, level, value)
				local info = {}
				local index = DDFrame.index
				local addonName = E.func_GetAddonName(index)
				----------------------------------------------------------------
				if level == 1 then
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					-- info.keepShownOnClick = false
					-- info.notCheckable = true -- TRUE убрать чекбокс
					-- info.isNotRadio = true -- TRUE круг, а не квадрат
					-- info.text = ADD.." или Убрать"
					-- info.value = ADD
					-- info.hasArrow = true
					-- self:ddAddButton(info, level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = false
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					if Octo_AddonsManager_DB.lock.addons[E.func_GetAddonName(index)] then
						info.text = UNLOCK
					else
						info.text = LOCK
					end
					info.checked = Octo_AddonsManager_DB.lock.addons[E.func_GetAddonName(index)]
					info.hasArrow = nil
					info.func = function()
						-- E.func_LockAddon(index)
						E.func_lockAddonNEW(index)
						E.AddonList_Update()
					end
					self:ddAddButton(info, level)
					-- elseif value == ADD then
					----------------------------------------------------------------
					self:ddAddSeparator(level)
					----------------------------------------------------------------
					for profileName, v in pairs(Octo_AddonsManager_DB.profiles) do
						info.fontObject = OctoFont11
						info.keepShownOnClick = true
						info.notCheckable = false -- TRUE убрать чекбокс
						info.isNotRadio = true -- TRUE круг, а не квадрат
						info.hasArrow = nil
						info.text = profileName
						info.checked = v[E.func_GetAddonName(index)]
						info.func = function(_, _, _, checked)
							if v[E.func_GetAddonName(index)] == true then
								v[E.func_GetAddonName(index)] = false
							else
								v[E.func_GetAddonName(index)] = true
							end
						end
						self:ddAddButton(info, level)
					end
				end
				----------------------------------------------------------------
		end)
	end
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
			E.func_ToggleAddon(index)
		elseif button == "MiddleButton" then
			E.func_LockAddon(index)
		elseif button == "RightButton" then
			DDFrame.index = index
			DDFrame:ddToggle(level, value, "cursor")
		end
		Octo_EventFrame_AddonsManager:Octo_Frame_init(parent, node)
		E.AddonList_Update()
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
	local func_OnAcquired do
		------------------------------------------------
		local function func_OnClick(frame)
			--if Octo_MainFrame_Achievements:IsDragging() then
			--    return
			--end
			--local AchievementID = frame:GetData().AchievementID
			--ToggleAchievement(AchievementID)
		end
		------------------------------------------------
		local function func_OnEnter(frame)
			--frame.texture_1:SetAlpha(E.BGALPHA)
			--E.func_TooltipOnEnter(frame, false, false)
		end
		------------------------------------------------
		local function func_OnOnLeave(frame)
			--frame.texture_1:SetAlpha(0)
			--GameTooltip_Hide()
		end
		------------------------------------------------
		function func_OnAcquired(owner, frame, data, new)
			if new then
				------------------------------------------------
				frame.full = CreateFrame("FRAME", nil, frame)
				frame.full:SetSize(AddonLeftFrameWeight*3, AddonHeight)
				-- frame.full:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
				frame.full:SetPoint("RIGHT")
				frame.full.texture = frame.full:CreateTexture(nil, "BACKGROUND")
				frame.full.texture:SetAllPoints()
				frame.full.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
				local r, g, b = GetClassColor(E.classFilename)
				frame.full.texture:SetVertexColor(r, g, b, 0)
				frame.full:SetScript("OnEnter", function(self) self.texture:SetAlpha(E.BGALPHA) end)
				frame.full:SetScript("OnLeave", function(self) self.texture:SetAlpha(0) end)
				frame.full:SetPropagateMouseClicks(true)
				frame.full:SetPropagateMouseMotion(true)
				------------------------------------------------
				frame.first = CreateFrame("BUTTON", nil, frame)
				frame.first:SetPropagateMouseClicks(false)
				frame.first:SetSize(AddonHeight, AddonHeight)
				frame.first:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
				frame.icon_firstSlot = frame:CreateTexture(nil, "BACKGROUND")
				frame.icon_firstSlot:SetAllPoints(frame.first)
				frame.first:SetScript("OnClick", OnClick_Zero)
				-- frame.icon_firstSlot:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
				------------------------------------------------
				frame.icon_secondSlot = frame:CreateTexture(nil, "BACKGROUND")
				frame.icon_secondSlot:SetPoint("TOPLEFT", AddonHeight+1, -1)
				frame.icon_secondSlot:SetSize(AddonHeight-2, AddonHeight-2)
				frame.icon_secondSlot:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
				frame.icon_secondSlot:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\SimpleAddonManager\\buttonWHITE")
				------------------------------------------------
				frame.icon_third = frame:CreateTexture(nil, "BACKGROUND")
				frame.icon_third:SetPoint("TOPLEFT", AddonHeight+AddonHeight+1, -1)
				frame.icon_third:SetSize(AddonHeight-2, AddonHeight-2)
				frame.icon_third:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
				------------------------------------------------
				frame.third = CreateFrame("BUTTON", nil, frame)
				frame.third:SetPropagateMouseClicks(true)
				frame.third:SetSize(AddonLeftFrameWeight*3, AddonHeight)
				-- frame.third:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
				frame.third:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0) -- frame.third:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
				frame.third:SetScript("OnEnter", function()
						E.func_TooltipOnEnter(frame.third, true, true)
				end)
				frame.third:SetScript("OnLeave", GameTooltip_Hide)
				frame.third.textLEFT = frame.third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				frame.third.textLEFT:SetPoint("LEFT", frame, "LEFT", AddonHeight+AddonHeight+AddonHeight+2, 0)
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
				frame:SetScript("OnClick", func_OnClick)
				frame:SetScript("OnEnter", func_OnEnter)
				frame:SetScript("OnLeave", func_OnOnLeave)
				------------------------------------------------
			end
		end
	end






	----------------------------------------------------------------

	function Octo_EventFrame_AddonsManager:func_CollectTooltipOnEnter(index) -- ПОФИКСИТЬ



	end



	----------------------------------------------------------------
	function Octo_EventFrame_AddonsManager:CollectAddonInfo(index)
		local name = E.func_GetAddonName(index)
		local title = E.func_GetAddonTitle(index)
		local notes = E.func_GetAddonNotes(index)
		local security = E.func_GetAddonSecurity(index)
		local character = GetAddonCharacter()
		local loadable = E.func_IsAddOnLoadable(index, character)
		local reason = E.func_GetAddonReason(index, character) or ""
		if E.func_IsAddonInstalled(index) then -- Исключаем отсутствующие аддоны
			local firsticonTexture = ""
			tooltipthird = {}
			local textRIGHT = " "
			local colorAddon = E.White_Color
			local Version = E.func_GetAddonVersion(index)
			local Author = E.func_GetAddonAuthor(index)
			local exists = E.func_DoesAddOnExist(index)
			local defaultEnabled = E.func_IsAddOnDefaultEnabled(index)
			local checkboxState = E.func_GetAddOnEnableState(index, character)
			local enabled = (E.func_GetAddOnEnableState(index, UnitName("player")) > Enum.AddOnEnableState.None)
			if (checkboxState == Enum.AddOnEnableState.Some ) then
				tooltipthird[#tooltipthird+1] = ENABLED_FOR_SOME
				-- else
				-- tooltipthird[#tooltipthird+1] = nil
			end
			if ( loadable or ( enabled and (reason == "DEP_DEMAND_LOADED" or reason == "DEMAND_LOADED") ) ) then
				colorAddon =  E.White_Color --"|cffFFC600" -- E.func_rgb2hexDEV(1.0, 0.78, 0.0)
			elseif ( enabled and reason ~= "DEP_DISABLED" ) then
				colorAddon = "|cffFF1919"-- E.func_rgb2hexDEV(1.0, 0.1, 0.1)
			else
				colorAddon = "|cff7F7F7F"-- E.func_rgb2hexDEV(0.5, 0.5, 0.5)
			end
			local iconTexture = E.func_GetAddoniconTexture(index)
			local iconAtlas = E.func_GetAddoniconAtlas(index)
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
			-- textRIGHT = E.func_Reason(reason)
			if (security == BANNED_ADDON) then
				tooltipthird[#tooltipthird+1] = {ADDON_BANNED_TOOLTIP}
			else
				local entryTitle = title or name  -- Используем title, если он есть, иначе name
				local entryText  -- Текст для добавления в tooltipthird

				if Version and Version ~= 0 then
					entryText = {entryTitle, E.classColorHexCurrent .. Version .. "|r"}
				else
					entryText = {entryTitle}
				end

				tooltipthird[#tooltipthird + 1] = entryText

				-- if (Author and Author ~= "") then
				--     tooltipthird[#tooltipthird+1] = {"Author: "..E.classColorHexCurrent..Author.."|r"}
				-- end
				-- if (notes and notes ~= "") then
				--     tooltipthird[#tooltipthird+1] = {"Notes: "..E.classColorHexCurrent..notes.."|r"}
				-- end
				if (loadable and E.func_IsProfilerEnabled()) then
					local RecentAverageTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.RecentAverageTime)
					local SessionAverageTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.SessionAverageTime)
					local PeakTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.PeakTime)
					local EncounterAverageTime = E.GetAddonMetricPercent(name, Enum.AddOnProfilerMetric.EncounterAverageTime)
					-- tooltipthird[#tooltipthird+1] = {" ", " "}
					-- tooltipthird[#tooltipthird+1] = {"RecentAverageTime: "..E.classColorHexCurrent..RecentAverageTime.."|r".."%"}
					-- tooltipthird[#tooltipthird+1] = {"SessionAverageTime: "..E.classColorHexCurrent..SessionAverageTime.."|r".."%"}
					-- tooltipthird[#tooltipthird+1] = {"PeakTime: "..E.classColorHexCurrent..PeakTime.."|r".."%"}
					-- if EncounterAverageTime ~= "" then
					--     tooltipthird[#tooltipthird+1] = {"EncounterAverageTime: "..E.classColorHexCurrent..EncounterAverageTime.."|r".."%"}
					-- end
					-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 5ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver5Ms))
					-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 10ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver10Ms))
					-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 50ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver50Ms))
					-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 100ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver100Ms))
					-- AddLineIfNotEmpty(AddonTooltip, L["Ticks over 500ms: "], profiler:GetAddonMetricCount(name, Enum.AddOnProfilerMetric.CountTimeOver500Ms))
				end
				-- and IsMemoryUsageEnabled()
				-- if (loadable and security ~= SECURE_PROTECTED_ADDON and security ~= SECURE_ADDON) then
				--     local memory = GetAddOnMemoryUsage(index) or 0
				--     if memory > 1024 then
				--         tooltipthird[#tooltipthird+1] = {"Использование памяти: ".. E.classColorHexCurrent..E.func_CompactNumberFormat(memory/1024).."|r Мб"}
				--     else
				--         tooltipthird[#tooltipthird+1] = {"Использование памяти: ".. E.classColorHexCurrent..E.func_CompactNumberFormat(memory).."|r Кб"}
				--     end
				-- end
				-- tooltipthird[#tooltipthird+1] = {" ", " "}
				-- tooltipthird[#tooltipthird+1] = {E.AddonTooltipBuildDepsString(index, Parent_Color)}
				-- if Octo_AddonsTable.depsByIndex[index] then
				--     tooltipthird[#tooltipthird+1] = {"Дочернии аддоны"}
				--     for _, depIndex in pairs(Octo_AddonsTable.depsByIndex[index]) do
				--         tooltipthird[#tooltipthird+1] = {"    "..Child_Color..E.func_GetAddonName(depIndex).."|r"}
				--     end
				-- end
				if loadable then
					firsticonTexture = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\SimpleAddonManager\\buttonONgreen"
				else
					firsticonTexture = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\SimpleAddonManager\\buttonOFFblack"
				end
				local needReload = false
				if (enabled and not loadable) then
					needReload = true
					firsticonTexture = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\SimpleAddonManager\\buttonOFFgreen"
				end
				if (not enabled and loadable) then
					needReload = true
					firsticonTexture = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\SimpleAddonManager\\buttonOFFred"
				end
				if reason == "DEMAND_LOADED" or reason == "DEP_DEMAND_LOADED" then
					firsticonTexture = "Interface\\AddOns\\"..GlobalAddonName.."\\Media\\SimpleAddonManager\\buttonOFFyellow"
				end
				-- if E.func_IsAddonVersionCheckEnabled() and E.interfaceVersion > interfaceVersion and enabled then
				-- colorAddon = "|cffFF0000"
				-- textRIGHT = ADDON_INTERFACE_VERSION.." ("..interfaceVersion..")"
				-- end
				local dep = E.AddonTooltipBuildDepsString(index)
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
				textLEFT = CreateSimpleTextureMarkup([[Interface\AddOns\Octo\Media\SimpleAddonManager\lock]], AddonHeight, AddonHeight)..textLEFT
			end
			textRIGHT = colorAddon.. resonTEXT .."|r"
			return firsticonTexture, iconTexture, colorAddon..textLEFT.."|r", textRIGHT, tooltipthird, colorAddon
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
	local function CollapseOrExpand(button, isCollapsed, node, name)
	end
	local showExpandOrCollapseButton = true
	-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ + ГОВНО
	-- ЭТО ФУНКЦИЯ АПДЕЙТА(ОТРИСОФКИ)
	function Octo_EventFrame_AddonsManager:Octo_Frame_init(frame, node)
		local data = node:GetData()
		local index = node:GetData().index
		local name = E.func_GetAddonName(index)
		local firsticonTexture = select(1, Octo_EventFrame_AddonsManager:CollectAddonInfo(data.index))
		local iconTexture = select(2, Octo_EventFrame_AddonsManager:CollectAddonInfo(data.index))
		local textLEFT = select(3, Octo_EventFrame_AddonsManager:CollectAddonInfo(data.index))
		local textRIGHT = select(4, Octo_EventFrame_AddonsManager:CollectAddonInfo(data.index))
		local tooltipthird = select(5, Octo_EventFrame_AddonsManager:CollectAddonInfo(data.index))
		-- local colorAddon = select(6, Octo_EventFrame_AddonsManager:CollectAddonInfo(data.index))
		frame.icon_secondSlot:SetTexture(firsticonTexture)
		if showExpandOrCollapseButton then
			local tbl = {}
			tbl = Octo_AddonsTable.depsByIndex
			if tbl[data.index] then
				UpdateExpandOrCollapseButtonState(frame.icon_firstSlot, node:IsCollapsed(), node, name)
			else
				frame.icon_firstSlot:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\SimpleAddonManager\\spacerEMPTY")
			end
		else
			frame.first:Hide()
		end
		if Octo_AddonsManager_DB.config.showIcons then
			frame.third.textLEFT:SetPoint("LEFT", frame, "LEFT", AddonHeight+AddonHeight+AddonHeight+4, 0)
			frame.icon_third:SetTexture(iconTexture)
		else
			frame.third.textLEFT:SetPoint("LEFT", frame, "LEFT", AddonHeight+AddonHeight+4, 0)
			frame.icon_third:SetTexture(E.Icon_Empty)
		end
		frame.third.textLEFT:SetText(textLEFT)
		frame.third.textRIGHT:SetText(textRIGHT)
		frame.third.tooltip = tooltipthird
		-- E:func_SetBackdrop(frame.first, nil, 0, 0)
		-- E:func_SetBackdrop(frame.third, nil, 0, 0)
	end
	function Octo_EventFrame_AddonsManager:Octo_Create_MainFrame_AddonsManager()
		Octo_MainFrame_AddonsManager:SetPoint("CENTER", 0, 0)
		-- Octo_MainFrame_AddonsManager:SetPoint("TOP", 0, -200)

		Octo_MainFrame_AddonsManager:SetSize(AddonLeftFrameWeight*3, AddonHeight*MainFrameDefaultLines)
		Octo_MainFrame_AddonsManager:SetDontSavePosition(true)
		Octo_MainFrame_AddonsManager:SetClampedToScreen(false)
		Octo_MainFrame_AddonsManager:SetFrameStrata("HIGH")
		Octo_MainFrame_AddonsManager:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
		Octo_MainFrame_AddonsManager:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
		Octo_MainFrame_AddonsManager:SetBackdropBorderColor(0, 0, 0, 1)
		Octo_MainFrame_AddonsManager:EnableMouse(true)
		Octo_MainFrame_AddonsManager:SetMovable(true)
		Octo_MainFrame_AddonsManager:RegisterForDrag("LeftButton")
		Octo_MainFrame_AddonsManager:SetScript("OnDragStart", function()
				Octo_MainFrame_AddonsManager:SetAlpha(E.bgCa)
				Octo_MainFrame_AddonsManager:StartMoving()
		end)
		Octo_MainFrame_AddonsManager:SetScript("OnDragStop", function()
				Octo_MainFrame_AddonsManager:SetAlpha(1)
				Octo_MainFrame_AddonsManager:StopMovingOrSizing()
		end)
		-- Octo_MainFrame_AddonsManager:RegisterForClicks("RightButtonUp") -- ПОФИКСИТЬ (ДОБАВИТЬ ОПЦИЮ ЛОКА)
		-- Octo_MainFrame_AddonsManager:SetScript("OnClick", function(self) self:Hide() end)
		Octo_MainFrame_AddonsManager.ScrollBox = CreateFrame("FRAME", nil, Octo_MainFrame_AddonsManager, "WowScrollBoxList")
		Octo_MainFrame_AddonsManager.ScrollBox:SetAllPoints()
		Octo_MainFrame_AddonsManager.ScrollBox:SetPropagateMouseClicks(true)
		Octo_MainFrame_AddonsManager.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
		Octo_MainFrame_AddonsManager.ScrollBox:Layout()
		Octo_MainFrame_AddonsManager.ScrollBar = CreateFrame("EventFrame", nil, Octo_MainFrame_AddonsManager, "MinimalScrollBar")
		Octo_MainFrame_AddonsManager.ScrollBar:SetPoint("TOPLEFT", Octo_MainFrame_AddonsManager.ScrollBox, "TOPRIGHT", 6, 0)
		Octo_MainFrame_AddonsManager.ScrollBar:SetPoint("BOTTOMLEFT", Octo_MainFrame_AddonsManager.ScrollBox, "BOTTOMRIGHT", 6, 0)
		Octo_MainFrame_AddonsManager.view = CreateScrollBoxListTreeListView()
		Octo_MainFrame_AddonsManager.view:SetElementExtent(AddonHeight)
		Octo_MainFrame_AddonsManager.view:SetElementInitializer("BUTTON",
			function(...)
				self:Octo_Frame_init(...)
		end)
		Octo_MainFrame_AddonsManager.view:RegisterCallback(Octo_MainFrame_AddonsManager.view.Event.OnAcquiredFrame, func_OnAcquired, Octo_MainFrame_AddonsManager) -- ПОФИКСИТЬ
		ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_AddonsManager.ScrollBox, Octo_MainFrame_AddonsManager.ScrollBar, Octo_MainFrame_AddonsManager.view)
		ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_AddonsManager.ScrollBox, Octo_MainFrame_AddonsManager.ScrollBar) -- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
		----------------------------------------------------------------
	end
	function E.AddonList_Update()
		if ( E.AddonList_HasAnyChanged() ) then
			frame_OkayButton.text:SetText(RELOADUI)
			Octo_EventFrame_AddonsManager.shouldReload = true
		else
			frame_OkayButton.text:SetText(OKAY)
			Octo_EventFrame_AddonsManager.shouldReload = false
		end
		Octo_MainFrame_AddonsManager.view:SetDataProvider(E.DataProvider, ScrollBoxConstants.RetainScrollPosition)
	end
	function E.CreateMyDataProvider()
		E.UpdatePerformance()
		local DataProvider = CreateTreeDataProvider()
		E.DataProvider = DataProvider
		for index = 1, E.func_GetNumAddOns() do
			if not Octo_AddonsTable.parentByIndex[index] or Octo_AddonsTable.recycleByIndex[index] then
				local groupNode = DataProvider:Insert({index = index})
				-- childrenNodes[#childrenNodes]:SetCollapsed(true) -- БРАТЬ ПОСЛЕДНЮЮ НОДУ И КОЛЛАПСИТЬ (ВЕСЬ СПИСОК ПРИ ЗАГРУЗКЕ)
				if Octo_AddonsTable.depsByIndex[index] then
					E.AddDeps_RECURSION(index, groupNode)
				end
			end
		end
		E.AddonList_Update()
	end
	function Octo_EventFrame_AddonsManager:func_Create_AdditionalFrame()
		----------------------------------------------------------------
		local frame_EnableAll = CreateFrame("Button", "frame_EnableAll", Octo_MainFrame_AddonsManager)
		frame_EnableAll:SetPropagateMouseClicks(true)
		frame_EnableAll:SetSize(AddonCentralFrameWeight, AddonHeight)
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
				E.func_EnableAllAddOns()
				E.AddonList_Update()
		end)
		----------------------------------------------------------------
		local frame_DisableAll = CreateFrame("Button", "frame_DisableAll", Octo_MainFrame_AddonsManager)
		frame_DisableAll:SetPropagateMouseClicks(true)
		frame_DisableAll:SetSize(AddonCentralFrameWeight, AddonHeight)
		frame_DisableAll:SetPoint("TOPLEFT", Octo_MainFrame_AddonsManager, "BOTTOMLEFT", AddonCentralFrameWeight, 0)
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
				E.func_DisableAllAddons()
				E.AddonList_Update()
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
					DisableAllTooltip[#DisableAllTooltip+1] = {E.func_texturefromIcon(E.func_GetAddoniconTexture(name))..E.func_GetAddonTitle(name), E.func_texturefromIcon([[Interface\AddOns\Octo\Media\SimpleAddonManager\lock]])}
				end
				frame_DisableAll.tooltip = DisableAllTooltip
				E.func_TooltipOnEnter(self, false, false)
		end)
		frame_DisableAll:SetScript("OnLeave", GameTooltip_Hide)
		----------------------------------------------------------------
		local frame_OkayButton = CreateFrame("Button", "frame_OkayButton", Octo_MainFrame_AddonsManager)
		frame_OkayButton:SetPropagateMouseClicks(true)
		frame_OkayButton:SetSize(AddonCentralFrameWeight, AddonHeight)
		frame_OkayButton:SetPoint("TOPRIGHT", Octo_MainFrame_AddonsManager, "BOTTOMRIGHT", -AddonCentralFrameWeight, 0)
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
				Octo_EventFrame_AddonsManager:AddonList_OnOkay()
		end)
		----------------------------------------------------------------
		local frame_CancelButton = CreateFrame("Button", "frame_CancelButton", Octo_MainFrame_AddonsManager)
		frame_CancelButton:SetPropagateMouseClicks(true)
		frame_CancelButton:SetSize(AddonCentralFrameWeight, AddonHeight)
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
				Octo_EventFrame_AddonsManager:AddonList_OnCancel()
		end)
		----------------------------------------------------------------
	end
	function Octo_EventFrame_AddonsManager:AddonList_OnOkay()
		PlaySound(SOUNDKIT.GS_LOGIN_CHANGE_REALM_OK)
		self:AddonList_Hide(true)
		if ( Octo_EventFrame_AddonsManager.shouldReload ) then
			ReloadUI()
		end
	end
	function Octo_EventFrame_AddonsManager:AddonList_Hide(save)
		AddonList.save = save
	end
	function Octo_EventFrame_AddonsManager:AddonList_OnCancel()
		PlaySound(SOUNDKIT.GS_LOGIN_CHANGE_REALM_CANCEL)
		self:AddonList_Hide(false)
	end


	----------------------------------------------------------------
	function Octo_EventFrame_AddonsManager:func_Create_DDframe_AddonsManager()
		local DD_AddonsManager = CreateFrame("Button", "DD_AddonsManager", Octo_MainFrame_AddonsManager, "BackDropTemplate")
		DD_AddonsManager:SetSize(SFDropDownWeight, AddonHeight)
		E:func_SetBackdrop(DD_AddonsManager)
		DD_AddonsManager.ExpandArrow = DD_AddonsManager:CreateTexture(nil, "ARTWORK")
		DD_AddonsManager.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
		--DD_AddonsManager.ExpandArrow:SetSize(AddonHeight, AddonHeight)
		DD_AddonsManager.ExpandArrow:SetPoint("RIGHT", -4, 0)
		DD_AddonsManager.text = DD_AddonsManager:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		DD_AddonsManager.text:SetAllPoints()
		DD_AddonsManager.text:SetFontObject(OctoFont11)
		DD_AddonsManager.text:SetJustifyV("MIDDLE")
		DD_AddonsManager.text:SetJustifyH("CENTER")
		DD_AddonsManager.text:SetTextColor(1, 1, 1, 1)
		DD_AddonsManager.text:SetText(E.Yellow_Color..MAIN_MENU.."|r")
		LibSFDropDown:SetMixin(DD_AddonsManager)
		DD_AddonsManager:SetPoint("BOTTOMLEFT", Octo_MainFrame_AddonsManager, "TOPLEFT", 0, 0)
		DD_AddonsManager:ddSetDisplayMode(GlobalAddonName)
		DD_AddonsManager:ddSetOpenMenuUp(true)
		DD_AddonsManager:ddSetNoGlobalMouseEvent(true)
		DD_AddonsManager:ddHideWhenButtonHidden()
		DD_AddonsManager:RegisterForClicks("LeftButtonUp")
		DD_AddonsManager:SetScript("OnClick", function(self)
				self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
		end)
		DD_AddonsManager:ddSetInitFunc(function(self, level, value)
				local info, list = {}, {}
				self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
				if level == 1 then
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = false -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = L["fullName"]
					info.hasArrow = nil
					info.checked = Octo_AddonsManager_DB.config.fullName
					info.func = function(_, _, _, checked)
						Octo_AddonsManager_DB.config.fullName = checked
						E.AddonList_Update()
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = false -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = L["showIcons"]
					info.value = "showIcons"
					info.hasArrow = true
					info.checked = Octo_AddonsManager_DB.config.showIcons
					info.func = function(_, _, _, checked)
						Octo_AddonsManager_DB.config.showIcons = checked
						E.AddonList_Update()
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = false -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = L["showVersion"]
					info.hasArrow = nil
					info.checked = Octo_AddonsManager_DB.config.showVersion
					info.func = function(_, _, _, checked)
						Octo_AddonsManager_DB.config.showVersion = checked
						E.AddonList_Update()
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = false -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = E.Debug_Color..L["showIndex"].."|r"
					info.hasArrow = nil
					info.checked = Octo_AddonsManager_DB.config.showIndex
					info.func = function(_, _, _, checked)
						Octo_AddonsManager_DB.config.showIndex = checked
						E.AddonList_Update()
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = false -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = ADDON_FORCE_LOAD
					info.hasArrow = nil
					info.checked = not E.func_IsAddonVersionCheckEnabled()
					info.func = function(_, _, _, checked)
						E.compat.SetAddonVersionCheck(not checked)
						E.AddonList_Update()
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
					self:ddAddSeparator(level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = "ПРОФИЛИ"
					info.value = "ПРОФИЛИ"
					info.hasArrow = true
					self:ddAddButton(info, level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE
					info.value = CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE
					info.hasArrow = true
					self:ddAddButton(info, level)
					----------------------------------------------------------------
					self:ddAddSeparator(level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = ENABLE_ALL_ADDONS
					info.hasArrow = nil
					info.func = function(_, _, _, checked)
						E.func_EnableAllAddOns()
						E.AddonList_Update()
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = DISABLE_ALL_ADDONS
					info.hasArrow = nil
					info.func = function(_, _, _, checked)
						E.func_DisableAllAddons()
						E.AddonList_Update()
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
					self:ddAddSeparator(level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = E.Debug_Color..BINDING_HEADER_DEBUG.."|r"
					info.value = BINDING_HEADER_DEBUG
					info.hasArrow = true
					self:ddAddButton(info, level)
					----------------------------------------------------------------
				elseif value == BINDING_HEADER_DEBUG then
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = E.Debug_Color.."fpde(Octo_AddonsManager_DB)".."|r"
					info.hasArrow = nil
					info.func = function(_, _, _, checked)
						fpde(Octo_AddonsManager_DB)
						for k, v in ipairs(E.OctoTable_Frames) do
							if v:IsShown() then
								if k == 2 then
									-- ПОФИКСИТЬ
									v:Hide()
								end
							end
						end
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = false
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = E.Debug_Color..DELETE.." "..ALL.."|r"
					info.hasArrow = nil
					info.func = function(_, _, _, checked)
						Octo_AddonsManager_DB = {}
						ReloadUI()
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = E.Debug_Color..RELOADUI.."|r"
					info.hasArrow = nil
					info.func = function(_, _, _, checked)
						ReloadUI()
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
				elseif value == "showIcons" then
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = false -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = L["showIconsQuestionMark"]
					info.hasArrow = nil
					info.checked = Octo_AddonsManager_DB.config.showIconsQuestionMark
					info.func = function(_, _, _, checked)
						Octo_AddonsManager_DB.config.showIconsQuestionMark = checked
						E.AddonList_Update()
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
				elseif value == CREATE_NEW_COMPACT_UNIT_FRAME_PROFILE then
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = "Create"
					info.hasArrow = nil
					info.func = function() self:createProfile() end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = "|cffFFFFFFCopy current|r" -- ПОФИКСИТЬ
					info.hasArrow = nil
					info.func = function() self:createProfile(true) end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
				elseif value == "ПРОФИЛИ" then
					----------------------------------------------------------------
					for profileName, v in next, (Octo_AddonsManager_DB.profiles) do
						info.fontObject = OctoFont11
						info.keepShownOnClick = true
						info.notCheckable = true -- TRUE убрать чекбокс
						info.isNotRadio = true -- TRUE круг, а не квадрат
						info.text = profileName
						info.value = v
						info.hasArrow = true
						info.func = function()
							E.func_LoadProfile(profileName)
							E.AddonList_Update()
						end
						self:ddAddButton(info, level)
					end
					----------------------------------------------------------------
					self:ddAddSeparator(level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = true -- TRUE убрать чекбокс
					info.isNotRadio = true -- TRUE круг, а не квадрат
					info.text = E.Debug_Color..RELOADUI.."|r"
					info.hasArrow = nil
					info.func = function(_, _, _, checked)
						ReloadUI()
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
				elseif value then -- type(value) == "table"
					----------------------------------------------------------------
					for k, v in next, (value) do
						if v == true then
							info.fontObject = OctoFont11
							info.keepShownOnClick = true
							info.notCheckable = true -- TRUE убрать чекбокс
							info.isNotRadio = true -- TRUE круг, а не квадрат


							info.text = k


							info.hasArrow = nil
							info.func = function(_, _, _, checked)
								ReloadUI()
							end
							self:ddAddButton(info, level)
						end
					end
					----------------------------------------------------------------
				end
				----------------------------------------------------------------
				----------------------------------------------------------------
				----------------------------------------------------------------
		end)
		DD_AddonsManager:ddSetMenuButtonHeight(16)
	end
	----------------------------------------------------------------


	----------------------------------------------------------------
	function E:GetCycleByIndexSFMICT(iChild, iParent)
		if Octo_AddonsTable.depsByIndex[iChild] then
			for _, depIndex in ipairs(Octo_AddonsTable.depsByIndex[iChild]) do
				if depIndex == iParent then
					print (E.Red_Color.."НАЙДЕН АБОБУС: |r".. iChild .." "..E.func_GetAddonName(iChild).." / "..iParent.." "..E.func_GetAddonName(iParent))
					return true
				end
			end
		end
	end
	-- ДОЛЖНА ВЫЗЫВАТЬСЯ 1 РАЗ
	function Octo_EventFrame_AddonsManager:CollectAllAddonsSFMICT()
		Octo_AddonsTable = {}
		Octo_AddonsTable.indexByName = {}
		for index = 1, E.func_GetNumAddOns() do
			local name = E.func_GetAddonName(index)
			Octo_AddonsTable.indexByName[name] = index
		end
		Octo_AddonsTable.depsByIndex = {}
		Octo_AddonsTable.parentByIndex = {}
		Octo_AddonsTable.recycleByIndex = {}
		for index = 1, E.func_GetNumAddOns() do
			local deps = E.func_GetAddOnDependenciesTable(index)
			for _, name in ipairs(deps) do
				if Octo_AddonsTable.indexByName[name] then
					Octo_AddonsTable.depsByIndex[Octo_AddonsTable.indexByName[name]] = Octo_AddonsTable.depsByIndex[Octo_AddonsTable.indexByName[name]] or {}
					tinsert(Octo_AddonsTable.depsByIndex[Octo_AddonsTable.indexByName[name]], index)
					Octo_AddonsTable.parentByIndex[index] = true
					if E:GetCycleByIndexSFMICT(index, Octo_AddonsTable.indexByName[name]) then
						Octo_AddonsTable.recycleByIndex[index] = true
						Octo_AddonsTable.recycleByIndex[Octo_AddonsTable.indexByName[name]] = true
					end
				end
			end
		end
	end
	local MyEventsTable = {
		"ADDON_LOADED",
		"PLAYER_REGEN_DISABLED",
	}
	E.RegisterMyEventsToFrames(Octo_EventFrame_AddonsManager, MyEventsTable, E.func_DebugPath())
	function Octo_EventFrame_AddonsManager:ADDON_LOADED(addonName)
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
			self.startStatus = {}
			self.shouldReload = false
			self.outOfDate = E.func_IsAddonVersionCheckEnabled() and E.func_AddonList_HasOutOfDate()
			self.outOfDateIndexes = {}
			for i=1, E.func_GetNumAddOns() do
				self.startStatus[i] = (E.func_GetAddOnEnableState(i, UnitName("player")) > Enum.AddOnEnableState.None)
				if (E.func_GetAddonReason(i) == "INTERFACE_VERSION") then
					tinsert(self.outOfDateIndexes, i)
				end
			end
			addonCharacter = UnitGUID("player")
			if Octo_AddonsManager_DB.profiles.default == nil then
				E.func_SaveProfile("default") -- CHAT_DEFAULT
			end
			print ("/uam")
			self:CollectAllAddonsSFMICT()
			self:Octo_Create_MainFrame_AddonsManager()
			self:func_Create_AdditionalFrame()
			self:func_Create_DDframe_AddonsManager()
			E.CreateMyDataProvider()
			self:createDDMenu()
			----------------------------------------------------------------
			E:func_CreateUtilsButton(Octo_MainFrame_AddonsManager, "AddonsManager", AddonHeight, 0)
			E:func_CreateMinimapButton(GlobalAddonName, "AddonsManager", Octo_AddonsManager_DB, Octo_MainFrame_AddonsManager, nil, "Octo_MainFrame_AddonsManager")
			Octo_MainFrame_AddonsManager:SetScript("OnShow", function()
					C_Timer.After(.1, function()
							E.AddonList_Update()
					end)
			end)
			----------------------------------------------------------------
		end
	end
	----------------------------------------------------------------
	function Octo_EventFrame_AddonsManager:PLAYER_REGEN_DISABLED()
		if Octo_MainFrame_AddonsManager and Octo_MainFrame_AddonsManager:IsShown() then
			Octo_MainFrame_AddonsManager:Hide()
		end
	end
end