local GlobalAddonName = ...
local OctoToDo_EventFrame = CreateFrame("FRAME")
OctoToDo_EventFrame:Hide()
local E = OctoToDo_ToDO_E
----------------------------------------------------------------

local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")


local OctoToDo_SECOND_MainFrame = nil
local OctoToDo_SECOND_CharFrame = nil
local _, classFilename = UnitClass("PLAYER")
local r, g, b = GetClassColor(classFilename)
local classColorHexCurrent = E.func_rgb2hex(r, g, b)
local OctoTable_func_otrisovka_SECOND = {
}
local function Central_Frame_Mouse_OnEnter(frame)
	local parent = OctoToDo_SECOND_MainFrame["FrameLine"..frame.index]
	parent:GetScript("OnEnter")(parent)
	if not frame.tooltip then
		return
	end
	GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMRIGHT", 0, 0)
	GameTooltip:AddLine(" ")
	for _, v in next, (frame.tooltip) do
		if v[2] ~= "0/0" then
			GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:Show()
end
local function Central_Frame_Mouse_OnLeave(frame)
	local parent = OctoToDo_SECOND_MainFrame["FrameLine"..frame.index]
	parent:GetScript("OnLeave")(parent)
	GameTooltip:Hide()
end
function OctoToDo_EventFrame:O_otrisovka_SECOND()
	tinsert(OctoTable_func_otrisovka_SECOND, function(CharInfo, tooltip, CL, BG)
			local vivodCent, vivodLeft = " ", " "
			CL:SetFontObject(OctoFont12)
			vivodLeft = classColorHexCurrent..ACHIEVEMENT_TITLE.."|r".." "..E.Green_Color..GetTotalAchievementPoints(false).."|r"
			return vivodCent, vivodLeft
	end)
	if OctoToDo_Achievements.config.AchievementToShow ~= nil then
		for categoryID, v in next, (OctoToDo_Achievements.config.AchievementToShow) do
			local ACHr, ACHg, ACHb = E.func_hex2rgbNUMBER(E.func_GenerateUniqueColor()),E.func_hex2rgbNUMBER(E.func_GenerateUniqueColor()),E.func_hex2rgbNUMBER(E.func_GenerateUniqueColor())
			if v ~= false then
				local total = GetCategoryNumAchievements(categoryID, true)
				if total then
					for i = 1, total do
						local AchievementID, name, points, completedAchi, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy, isStatistic = GetAchievementInfo(categoryID, i)
						if AchievementID then
							if completedAchi == false or (completedAchi == OctoToDo_Achievements.config.AchievementShowCompleted) then
								tinsert(OctoTable_func_otrisovka_SECOND, function(CharInfo, tooltip, CL, BG)
										local vivodCent, vivodLeft = " ", " "
										vivodLeft = E.func_texturefromIcon(icon)
										if rewardText ~= nil and rewardText and rewardText ~= "" and rewardText ~= " " then
											vivodLeft = vivodLeft..E.Blue_Color.."*|r"
										end
										if name then
											vivodLeft = vivodLeft .. name
										end
										if points ~= 0 then
											tooltip[#tooltip+1] = {E.Yellow_Color..points.."|r".." "..E.Gray_Color.." id:"..AchievementID.."|r", " "}
										else
											tooltip[#tooltip+1] = {E.Gray_Color.." id:"..AchievementID.."|r", " "}
										end
										vivodCent = E.func_achievementvivod(AchievementID)
										local numCriteria = GetAchievementNumCriteria(AchievementID)
										if numCriteria ~= 1 then
											tooltip[#tooltip+1] = {description}
										end
										if rewardText and rewardText ~= "" and rewardText ~= " " then
											tooltip[#tooltip+1] = {E.Blue_Color..rewardText.."|r"}
										end
										if numCriteria >= 1 then
											tooltip[#tooltip+1] = {" ", " "}
											for i = 1, numCriteria do
												tooltip[#tooltip+1] = {E.func_achievementcriteriaString(AchievementID, i), E.func_achievementquantity(AchievementID, i)}
											end
										end
										BG:SetColorTexture(ACHr, ACHg, ACHb, E.BGALPHA*2)
										return vivodCent, vivodLeft
								end)
							end
						end
					end
				end
			end
		end
	end
end
function OctoToDo_EventFrame:OctoToDo_SECOND_CreateAltFrame()
	if not OctoToDo_SECOND_MainFrame then
		OctoToDo_SECOND_MainFrame = CreateFrame("BUTTON", "OctoToDo_SECOND_MainFrame", UIParent, "BackdropTemplate")
		OctoToDo_SECOND_MainFrame:Hide()
	end
	local ScrollFrame = CreateFrame("ScrollFrame", "ScrollFrame", OctoToDo_SECOND_MainFrame)
	local ScrollBar = CreateFrame("EventFrame", "ScrollBar", ScrollFrame, "MinimalScrollBar")
	ScrollBar:SetPoint("TOPLEFT", ScrollFrame, "TOPRIGHT", 6, 0)
	ScrollBar:SetPoint("BOTTOMLEFT", ScrollFrame, "BOTTOMRIGHT", 6, 0)
	local scrollChild = CreateFrame("Frame", "scrollChild", ScrollFrame)
	ScrollFrame:SetScrollChild(scrollChild)
	ScrollFrame:SetAllPoints()
	scrollChild:SetSize(1, 1)
	scrollChild:SetPoint("TOPRIGHT")
	ScrollUtil.InitScrollFrameWithScrollBar(ScrollFrame, ScrollBar)
	local OnMouseWheel = ScrollFrame:GetScript("OnMouseWheel")
	ScrollFrame:SetScript("OnMouseWheel", function(self, ...)
			if ScrollBar:IsShown() then
				OnMouseWheel(self, ...)
			end
	end)
	OctoToDo_SECOND_MainFrame.scrollChild = scrollChild
	OctoToDo_SECOND_MainFrame.ScrollBar = ScrollBar
	OctoToDo_SECOND_MainFrame:SetClampedToScreen(false)
	OctoToDo_SECOND_MainFrame:SetFrameStrata("HIGH")
	OctoToDo_SECOND_MainFrame:SetPoint("CENTER")
	OctoToDo_SECOND_MainFrame:SetBackdrop({
			bgFile = E.bgFile,
			edgeFile = E.edgeFile,
			edgeSize = 1,
	})
	OctoToDo_SECOND_MainFrame:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoToDo_SECOND_MainFrame:SetBackdropBorderColor(0, 0, 0, 1)
	OctoToDo_SECOND_MainFrame:SetScript("OnShow", function()
			self:OctoToDo_SECOND_AddDataToAltFrame()
	end)
	OctoToDo_SECOND_MainFrame:EnableMouse(true)
	OctoToDo_SECOND_MainFrame:SetMovable(true)
	OctoToDo_SECOND_MainFrame:RegisterForDrag("LeftButton")
	OctoToDo_SECOND_MainFrame:SetScript("OnDragStart", function()
			OctoToDo_SECOND_MainFrame:SetAlpha(E.bgCa/2)
			OctoToDo_SECOND_MainFrame:StartMoving()
	end)
	OctoToDo_SECOND_MainFrame:SetScript("OnDragStop", function()
			OctoToDo_SECOND_MainFrame:SetAlpha(1)
			OctoToDo_SECOND_MainFrame:StopMovingOrSizing()
	end)
	OctoToDo_SECOND_MainFrame:RegisterForClicks("RightButtonUp")
	OctoToDo_SECOND_MainFrame:SetScript("OnClick", function(self) self:Hide() end)
	----------------------------------------------------------------

	local dd_SECOND = CreateFrame("Button", "dd_SECOND", OctoToDo_SECOND_MainFrame, "SecureActionButtonTemplate, BackDropTemplate")
	local multiply = (1/3)*2
	dd_SECOND:SetSize(E.curWidthTitle*multiply, E.curHeight*multiply)
	dd_SECOND:SetBackdrop({
			bgFile = E.bgFile,
			edgeFile = E.edgeFile,
			edgeSize = 1
	})
	dd_SECOND:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	dd_SECOND:SetBackdropBorderColor(0, 0, 0, 1)
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
	dd_SECOND:SetPoint("BOTTOMLEFT", OctoToDo_SECOND_MainFrame, "TOPLEFT", 0, 1)
	dd_SECOND:ddSetDisplayMode(GlobalAddonName)
	dd_SECOND:ddSetOpenMenuUp(true)
	dd_SECOND:ddSetNoGlobalMouseEvent(true)
	dd_SECOND:ddHideWhenButtonHidden()
	dd_SECOND:RegisterForClicks("LeftButtonUp")
	dd_SECOND:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)
	local function selectFunctionAchievementToShow(menuButton, _, arg2, checked)
		OctoToDo_Achievements.config.AchievementToShow[menuButton.value] = checked or nil
		if arg2 == 2 then
			dd_SECOND:ddRefresh(arg2-1)
		end
	end
	local function TEST_FUNC(menuButton, arg1)
		local categories = GetCategoryList()
		local cID = menuButton.value
		for i = 1, #categories do
			local categoryID = categories[i]
			local _, parentCategoryID = GetCategoryInfo(categoryID)
			if arg1 and cID == parentCategoryID and OctoToDo_Achievements.config.AchievementToShow[categoryID] == true then
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
					info.checked = OctoToDo_Achievements.config.AchievementToShow[categoryID]
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
				info.checked = OctoToDo_Achievements.config.AchievementShowCompleted
				info.func = function(_,_,_, checked)
					OctoToDo_Achievements.config.AchievementShowCompleted = checked
					StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
				end
				self:ddAddButton(info, level)
			end
			----------------------------------------------------------------
	end)
	local function FrameLine_OnEnter(self)
		self.animation:SetFromAlpha(0)
		self.animation:SetToAlpha(1)
		self.group:Restart()
	end
	local function FrameLine_OnLeave(self)
		self.animation:SetFromAlpha(1)
		self.animation:SetToAlpha(0)
		self.group:Restart()
	end
	for i = 1, #OctoTable_func_otrisovka_SECOND do
		local fname, f
		fname = "FrameLine"..i
		OctoToDo_SECOND_MainFrame[fname] = CreateFrame("Frame", "FrameLine", OctoToDo_SECOND_MainFrame.scrollChild, "BackdropTemplate")
		f = OctoToDo_SECOND_MainFrame[fname]
		f:SetHeight(E.curHeight)
		f:SetPoint("TOPLEFT", OctoToDo_SECOND_MainFrame.scrollChild, "TOPLEFT", 0, -E.curHeight*(i-1))
		f:SetPoint("RIGHT")
		f:SetScript("OnEnter", FrameLine_OnEnter)
		f:SetScript("OnLeave", FrameLine_OnLeave)
		f:SetMouseClickEnabled(false)
		f.BG = f:CreateTexture(nil, "BACKGROUND")
		f.BG:SetHeight(E.curHeight)
		f.BG:SetAllPoints()
		f.BG:SetColorTexture(r, g, b, E.BGALPHA*2)
		f.BG:SetAlpha(0)
		f.group = f:CreateAnimationGroup()
		f.group:SetToFinalAlpha(true)
		f.animation = f.group:CreateAnimation("Alpha")
		f.animation:SetSmoothing("IN_OUT")
		f.animation:SetDuration(E.AnimationDuration)
		f.animation:SetTarget(f.BG)
		fname = "TextLeft"..i
		OctoToDo_SECOND_MainFrame[fname] = OctoToDo_SECOND_MainFrame.scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		f = OctoToDo_SECOND_MainFrame[fname]
		f:SetSize(E.curWidthTitle, E.curHeight)
		f:SetPoint("TOPLEFT", OctoToDo_SECOND_MainFrame.scrollChild, "TOPLEFT", 6, -E.curHeight*(i-1))
		f:SetFontObject(OctoFont11)
		f:SetJustifyV("MIDDLE")
		f:SetJustifyH("LEFT")
		f:SetTextColor(1, 1, 1, 1)
	end
	self:OctoToDo_SECOND_AddDataToAltFrame()
	OctoToDo_SECOND_MainFrame:Hide()
end
function OctoToDo_EventFrame:OctoToDo_SECOND_AddDataToAltFrame()
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER")
	local ShowOnlyCurrentRealm = OctoToDo_Achievements.config.ShowOnlyCurrentRealm
	local LevelToShow = OctoToDo_Achievements.config.LevelToShow
	local LevelToShowMAX = OctoToDo_Achievements.config.LevelToShowMAX
	local itemLevelToShow = OctoToDo_Achievements.config.itemLevelToShow
	OctoToDo_SECOND_MainFrame.AllCharFrames = {}
	for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
		if GUID == curGUID then
			local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
			local curCharGUID = CharInfo.GUID
			if not OctoToDo_SECOND_MainFrame[curCharGUID] then
				OctoToDo_SECOND_MainFrame[curCharGUID] = CreateFrame("Frame", "OctoToDo_SECOND_MainFrame[curCharGUID]", OctoToDo_SECOND_MainFrame.scrollChild, "BackdropTemplate")
				OctoToDo_SECOND_CharFrame = OctoToDo_SECOND_MainFrame[curCharGUID]
				OctoToDo_SECOND_CharFrame:SetPoint("BOTTOM", 0, 0)
				OctoToDo_SECOND_CharFrame.BG = OctoToDo_SECOND_CharFrame:CreateTexture(nil, "BACKGROUND")
				OctoToDo_SECOND_CharFrame.BG:Hide()
				OctoToDo_SECOND_CharFrame.BG:SetPoint("TOPLEFT", 0, -E.curHeight)
				OctoToDo_SECOND_CharFrame.BG:SetPoint("BOTTOMRIGHT", 0, 0)
				OctoToDo_SECOND_CharFrame.BG:SetColorTexture(r, g, b, 0) -- ЦВЕТ ФОНА
				for i = 1, #OctoTable_func_otrisovka_SECOND do
					CharInfo.GUID = curCharGUID
					local CentralFrame = CreateFrame("Frame", "CentralFrame", OctoToDo_SECOND_CharFrame)
					OctoToDo_SECOND_CharFrame["CenterLines"..i] = CentralFrame
					CentralFrame.index = i
					CentralFrame:SetSize(E.curWidthCentral, E.curHeight)
					CentralFrame:SetPoint("TOP", OctoToDo_SECOND_CharFrame, "TOP", 0, -E.curHeight*(i-1))
					CentralFrame:SetScript("OnEnter", Central_Frame_Mouse_OnEnter)
					CentralFrame:SetScript("OnLeave", Central_Frame_Mouse_OnLeave)
					CentralFrame:SetMouseClickEnabled(false)
					local CL = CentralFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
					CL:SetAllPoints()
					CL:SetFontObject(OctoFont11)
					CL:SetJustifyV("MIDDLE")
					CL:SetJustifyH("CENTER")
					CL:SetTextColor(1, 1, 1, 1)
					OctoToDo_SECOND_CharFrame["CenterLines"..i.."BG"] = OctoToDo_SECOND_CharFrame:CreateTexture(nil, "BACKGROUND")
					OctoToDo_SECOND_CharFrame["CenterLines"..i.."BG"]:SetAllPoints(OctoToDo_SECOND_CharFrame["CenterLines"..i])
					OctoToDo_SECOND_CharFrame["CenterLines"..i.."BG"]:SetColorTexture(0, 0, 0, 0)
					CentralFrame.CL = CL
				end
			else
				OctoToDo_SECOND_CharFrame = OctoToDo_SECOND_MainFrame[curCharGUID]
			end
			OctoToDo_SECOND_CharFrame:SetSize(E.curWidthCentral, E.curHeight)
			if #OctoToDo_SECOND_MainFrame.AllCharFrames == 0 then
				OctoToDo_SECOND_CharFrame:SetPoint("TOPRIGHT", 0, 0)
			else
				OctoToDo_SECOND_CharFrame:SetPoint("TOPRIGHT", OctoToDo_SECOND_MainFrame.AllCharFrames[#OctoToDo_SECOND_MainFrame.AllCharFrames], "TOPLEFT", 0, 0)
			end
			OctoToDo_SECOND_MainFrame.AllCharFrames[#OctoToDo_SECOND_MainFrame.AllCharFrames + 1] = OctoToDo_SECOND_CharFrame
			if curGUID == curCharGUID then
				OctoToDo_SECOND_CharFrame.BG:Show()
				OctoToDo_SECOND_CharFrame.BG:SetAlpha(E.BGALPHA*2)
			end
			for i = 1, #OctoTable_func_otrisovka_SECOND do
				local TEXTLEFT = OctoToDo_SECOND_MainFrame["TextLeft"..i]
				local TEXTCENT = OctoToDo_SECOND_CharFrame["CenterLines"..i]
				if TEXTLEFT and TEXTCENT then
					local BG = OctoToDo_SECOND_CharFrame["CenterLines"..i.."BG"]
					TEXTCENT.tooltip = {}
					local vivodCent = " "
					local vivodLeft = " "
					vivodCent, vivodLeft = OctoTable_func_otrisovka_SECOND[i](CharInfo, TEXTCENT.tooltip, TEXTCENT.CL, BG)
					TEXTLEFT:SetText(vivodLeft or "leftText")
					TEXTCENT.CL:SetText(vivodCent or "centText")
					if #TEXTCENT.tooltip == 0 or #TEXTCENT.tooltip[1] == 0 then
						TEXTCENT.tooltip = nil
					end
				end
			end
		end
		local curAltFrameWidth = #OctoToDo_SECOND_MainFrame.AllCharFrames * E.curWidthCentral/2
		local width = curAltFrameWidth*2+E.curWidthTitle
		local height = E.curHeight*(#OctoTable_func_otrisovka_SECOND)
		OctoToDo_SECOND_MainFrame.scrollChild:SetSize(width, height)
		if height > E.Addon_Height then
			height = E.Addon_Height
			OctoToDo_SECOND_MainFrame.ScrollBar:Show()
		else
			OctoToDo_SECOND_MainFrame.ScrollBar:Hide()
		end
		OctoToDo_SECOND_MainFrame:SetSize(width, height)
	end
end
function OctoToDo_EventFrame:main_frame_toggle()
	local button = LibDBIcon:GetMinimapButton(E.func_AddonTitle(GlobalAddonName))
	if SettingsPanel:IsVisible() then
		HideUIPanel(SettingsPanel)
	end
	if OctoToDo_SECOND_MainFrame:IsShown() then
		OctoToDo_SECOND_MainFrame:Hide()
	else
		OctoToDo_SECOND_MainFrame:Show()
		self:OctoToDo_SECOND_AddDataToAltFrame()
	end
end







OctoToDo_EventFrame:RegisterEvent("ADDON_LOADED")
OctoToDo_EventFrame:RegisterEvent("PLAYER_LOGIN")
OctoToDo_EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
OctoToDo_EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

function OctoToDo_EventFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------

		----------------------------------------------------------------
		if OctoToDo_Achievements == nil then
			OctoToDo_Achievements = {}
		end
		if OctoToDo_Achievements.config == nil then
			OctoToDo_Achievements.config = {}
		end
		if OctoToDo_Achievements.config.Achievements == nil then
			OctoToDo_Achievements.config.Achievements = true
		end
		if OctoToDo_Achievements.config.AchievementShowCompleted == nil then
			OctoToDo_Achievements.config.AchievementShowCompleted = true
		end
		if OctoToDo_Achievements.config.AchievementToShow == nil then
			OctoToDo_Achievements.config.AchievementToShow = {[92] = true}
		end
		if OctoToDo_Achievements.config.curWidthTitle == nil then
			OctoToDo_Achievements.config.curWidthTitle = 300
		end
		if OctoToDo_Achievements.config.curWidthTitle ~= nil then
			E.curWidthTitle = OctoToDo_Achievements.config.curWidthTitle
		end
		OctoToDo_Achievements.minimap_SECOND = OctoToDo_Achievements.minimap_SECOND or {}
		OctoToDo_Achievements.minimap_SECOND.minimapPos = OctoToDo_Achievements.minimap_SECOND.minimapPos or 284
		----------------------------------------------------------------
		local MinimapName = E.func_AddonTitle(GlobalAddonName)
		local ldb_icon = LibDataBroker:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = E.func_AddonIconTexture(GlobalAddonName),
				OnClick = function(_, button)
					if button == "LeftButton" then
						if not InCombatLockdown() then
							OctoToDo_EventFrame:main_frame_toggle()
						end
					else
						if SettingsPanel:IsVisible() and self:IsVisible() then
							HideUIPanel(SettingsPanel)
						else
							Settings.OpenToCategory(E.func_AddonTitle(GlobalAddonName), true)
						end
					end
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, E.func_AddonTitle(GlobalAddonName).."|n".."ПКМ - Настройки")
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		OctoToDo_Achievements.minimap = OctoToDo_Achievements.minimap or {}
		OctoToDo_Achievements.minimap.minimapPos = OctoToDo_Achievements.minimap.minimapPos or 244
		LibDBIcon:Register(MinimapName, ldb_icon, OctoToDo_Achievements.minimap)
		LibDBIcon:Show(MinimapName)
		----------------------------------------------------------------
	end
end

function OctoToDo_EventFrame:PLAYER_LOGIN()
	if not InCombatLockdown() then
		self:UnregisterEvent("PLAYER_LOGIN")
		self.PLAYER_LOGIN = nil
		----------------------------------------------------------------
		self:O_otrisovka_SECOND()
		self:OctoToDo_SECOND_CreateAltFrame()
		self:OctoToDo_SECOND_AddDataToAltFrame()
		E:func_CreateCloseButton(OctoToDo_SECOND_MainFrame)
		----------------------------------------------------------------
	end
end

function OctoToDo_EventFrame:PLAYER_REGEN_DISABLED()
	if OctoToDo_SECOND_MainFrame and OctoToDo_SECOND_MainFrame:IsShown() then
		OctoToDo_SECOND_MainFrame:Hide()
	end
end

