local GlobalAddonName, E = ...
local GBI_version, GBI_build, GBI_date, GBI_tocversion, GBI_localizedVersion, GBI_buildType = GetBuildInfo()
if PTR_IssueReporter then PTR_IssueReporter:Hide() end
if WeeklyRewardExpirationWarningDialog then WeeklyRewardExpirationWarningDialog:Hide() end
local LibOctopussy = LibStub("LibOctopussy-1.0")
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local SHOWADDON_SECOND = false
local Button = nil
local CF = nil
local OctoToDo_SECOND_MainFrame = nil
local OctoToDo_SECOND_CharFrame = nil
local Octo_ToDo_SECOND_Frame_EventFrame = nil
local Octo_ToDo_SECOND_Frame_UPGRADERANKS_Frame = nil
local OctoToDo_SECOND_CloseButton = nil
local Octo_ToDo_SECOND_Frame_MarkOfHonor_Button = nil
local Octo_ToDo_SECOND_Frame_QuestFeast_Button = nil
local Octo_ToDo_SECOND_Frame_AbandonAllQuests_Button = nil
local OctoToDo_SECOND_MainFrameDeleteButton = nil
local className, classFilename, classId = UnitClass("PLAYER")
local englishFaction, localizedFaction = UnitFactionGroup("PLAYER")
local classColor = LibOctopussy:func_GetClassColor(classFilename)
local r, g, b = GetClassColor(classFilename)
local classColorHexCurrent = LibOctopussy:func_rgb2hex(r, g, b)
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
local regionalWeeklyStart = 1668981600
local edgeFile = "Interface\\Buttons\\WHITE8X8"
local bgFile = "Interface\\Buttons\\WHITE8X8"
local OctoTable_func_otrisovka_SECOND = {
}
local function Central_Frame_Mouse_OnClick(self)
	local parent = OctoToDo_SECOND_MainFrame["FrameLine"..self.index]
	parent:GetScript("OnClick")(parent)
	if not self.tooltip then
		return
	end
	fpde(self)
	-- GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 0)
	-- GameTooltip:AddLine(" ")
	-- for _, v in next, (self.tooltip) do
	-- if v[2] ~= "0/0" then
	-- GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
	-- end
	-- end
	-- GameTooltip:AddLine(" ")
	-- GameTooltip:Show()
end
local function Central_Frame_Mouse_OnEnter(self)
	local parent = OctoToDo_SECOND_MainFrame["FrameLine"..self.index]
	parent:GetScript("OnEnter")(parent)
	if not self.tooltip then
		return
	end
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 0)
	GameTooltip:AddLine(" ")
	for _, v in next, (self.tooltip) do
		if v[2] ~= "0/0" then
			GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:Show()
end
local function Central_Frame_Mouse_OnLeave(self)
	local parent = OctoToDo_SECOND_MainFrame["FrameLine"..self.index]
	parent:GetScript("OnLeave")(parent)
	GameTooltip:Hide()
end
local function Octo_ToDo_SECOND_OnLoad()
	if not Octo_ToDo_SECOND_Frame_EventFrame then
		Octo_ToDo_SECOND_Frame_EventFrame = CreateFrame("FRAME", E.AddonTitle..LibOctopussy:func_GenerateUniqueID())
	end
	Octo_ToDo_SECOND_Frame_EventFrame:RegisterEvent("VARIABLES_LOADED")
	Octo_ToDo_SECOND_Frame_EventFrame:RegisterEvent("PLAYER_LOGIN")
	Octo_ToDo_SECOND_Frame_EventFrame:SetScript("OnEvent", function(...)
			Octo_ToDo_SECOND_OnEvent(...)
	end)
end
local function O_otrisovka_SECOND()
	tinsert(OctoTable_func_otrisovka_SECOND,
		function(CharInfo, tooltip, CL, BG)
			local vivodCent, vivodLeft = " ", " "
			CL:SetFontObject(OctoFont12)
			vivodLeft = classColorHexCurrent..ACHIEVEMENT_TITLE.."|r".." "..E.Green_Color..GetTotalAchievementPoints(false).."|r"
			-- vivodCent = CharInfo.classColorHex..CharInfo.Name.."|r"
			-- if CharInfo.Faction == "Horde" then
			--     BG:SetColorTexture(.5, 0, 0, E.BGALPHA*2)
			-- else
			--     BG:SetColorTexture(0, 0, .5, E.BGALPHA*2)
			-- end
			-- if CharInfo.hasMail then
			--     BG:SetColorTexture(1, 1, 1, E.BGALPHA)
			--     vivodCent = E.Icon_MailBox..vivodCent
			-- end
			return vivodCent, vivodLeft
	end)
	if Octo_ToDo_DB_Vars.config.AchievementToShow ~= nil then
		for categoryID, v in next, (Octo_ToDo_DB_Vars.config.AchievementToShow) do
			if v ~= false then
				local total = GetCategoryNumAchievements(categoryID, true)
				if total then
					for i = 1, total do
						local AchievementID, name, points, completedAchi, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy, isStatistic = GetAchievementInfo(categoryID, i)
						if AchievementID then
							if completedAchi == false or (completedAchi == Octo_ToDo_DB_Vars.config.AchievementShowCompleted) then
								tinsert(OctoTable_func_otrisovka_SECOND,
									function(CharInfo, tooltip, CL, BG)
										local vivodCent, vivodLeft = " ", " "
										vivodLeft = LibOctopussy:func_texturefromIcon(icon)
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
										vivodCent = LibOctopussy:func_achievementvivod(AchievementID)
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
												tooltip[#tooltip+1] = {LibOctopussy:func_achievementcriteriaString(AchievementID, i), LibOctopussy:func_achievementquantity(AchievementID, i)}
											end
										end
										BG:SetColorTexture(1, 0, 1, E.BGALPHA/2)
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
local function Octo_ToDo_SECOND_CreateAltFrame()
	if not OctoToDo_SECOND_MainFrame then
		OctoToDo_SECOND_MainFrame = CreateFrame("BUTTON", "OctoToDo_SECOND_MainFramePIZDA", UIParent, "BackdropTemplate")
		OctoToDo_SECOND_MainFrame:Hide()
	end
	local ScrollFrame = CreateFrame("ScrollFrame", "ScrollFrame"..LibOctopussy:func_GenerateUniqueID(), OctoToDo_SECOND_MainFrame)
	local ScrollBar = CreateFrame("EventFrame", nil, ScrollFrame, "MinimalScrollBar")
	ScrollBar:SetPoint("TOPLEFT", ScrollFrame, "TOPRIGHT", 6, 0)
	ScrollBar:SetPoint("BOTTOMLEFT", ScrollFrame, "BOTTOMRIGHT", 6, 0)
	local scrollChild = CreateFrame("Frame", nil, ScrollFrame)
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
			bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	OctoToDo_SECOND_MainFrame:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoToDo_SECOND_MainFrame:SetBackdropBorderColor(0, 0, 0, 1)
	OctoToDo_SECOND_MainFrame:SetScript("OnShow", function()
			Octo_ToDo_SECOND_AddDataToAltFrame()
	end)
	OctoToDo_SECOND_MainFrame:EnableMouse(true)
	OctoToDo_SECOND_MainFrame:SetMovable(true)
	OctoToDo_SECOND_MainFrame:RegisterForDrag("LeftButton")
	OctoToDo_SECOND_MainFrame:SetScript("OnDragStart", OctoToDo_SECOND_MainFrame.StartMoving)
	OctoToDo_SECOND_MainFrame:SetScript("OnDragStop", function() OctoToDo_SECOND_MainFrame:StopMovingOrSizing() end)
	OctoToDo_SECOND_MainFrame:RegisterForClicks("RightButtonUp")
	OctoToDo_SECOND_MainFrame:SetScript("OnClick", function(self) self:Hide() end)
	----------------------------------------------------------------
	if not OctoToDo_SECOND_CloseButton then
		OctoToDo_SECOND_CloseButton = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_SECOND_MainFrame, "BackDropTemplate")
		OctoToDo_SECOND_CloseButton:SetSize(E.curHeight, E.curHeight)
		OctoToDo_SECOND_CloseButton:SetPoint("BOTTOMRIGHT", OctoToDo_SECOND_MainFrame, "TOPRIGHT", (-E.curHeight)*0, 1)
		OctoToDo_SECOND_CloseButton:SetBackdrop({
				edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeSize = 1
		})
		OctoToDo_SECOND_CloseButton:SetBackdropBorderColor(1, 0, 0, 0)
		OctoToDo_SECOND_CloseButton:SetScript("OnEnter", function(self)
				self.icon:SetVertexColor(r, g, b, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
				GameTooltip:ClearLines()
				GameTooltip:AddLine(classColorHexCurrent..CLOSE.."|r")
				GameTooltip:Show()
		end)
		OctoToDo_SECOND_CloseButton:SetScript("OnLeave", function(self)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		OctoToDo_SECOND_CloseButton:SetScript("OnMouseDown", function(self)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoToDo_SECOND_CloseButton:SetScript("OnClick", function()
				OctoToDo_SECOND_MainFrame:Hide()
		end)
		local t = OctoToDo_SECOND_CloseButton:CreateTexture(nil, "BACKGROUND")
		OctoToDo_SECOND_CloseButton.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\CloseTest.tga")
		t:SetAllPoints(OctoToDo_SECOND_CloseButton)
		OctoToDo_SECOND_CloseButton:SetScript("OnKeyDown", function(self, key)
				if key == GetBindingKey("TOGGLEGAMEMENU") then
					self:GetParent():Hide()
					self:SetPropagateKeyboardInput(false)
				else
					self:SetPropagateKeyboardInput(true)
				end
		end)
	end
	----------------------------------------------------------------
	if not OctoToDo_SECOND_OptionsButton then
		OctoToDo_SECOND_OptionsButton = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_SECOND_MainFrame, "BackDropTemplate")
		OctoToDo_SECOND_OptionsButton:SetSize(E.curHeight, E.curHeight)
		OctoToDo_SECOND_OptionsButton:SetPoint("BOTTOMRIGHT", OctoToDo_SECOND_MainFrame, "TOPRIGHT", (-E.curHeight)*1, 1)
		OctoToDo_SECOND_OptionsButton:SetBackdrop({
				edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeSize = 1
		})
		OctoToDo_SECOND_OptionsButton:SetBackdropBorderColor(1, 0, 0, 0)
		OctoToDo_SECOND_OptionsButton:SetScript("OnEnter", function(self)
				self.icon:SetVertexColor(r, g, b, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
				GameTooltip:AddLine(classColorHexCurrent..OPTIONS.."|r")
				GameTooltip:Show()
		end)
		OctoToDo_SECOND_OptionsButton:SetScript("OnLeave", function(self)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:Hide()
		end)
		OctoToDo_SECOND_OptionsButton:SetScript("OnMouseDown", function(self)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoToDo_SECOND_OptionsButton:SetScript("OnClick", function()
				if OctoToDo_SECOND_MainFramePIZDA and OctoToDo_SECOND_MainFramePIZDA:IsShown() then
					OctoToDo_SECOND_MainFramePIZDA:Hide()
				end
				if SettingsPanel:IsVisible() and self:IsVisible() then
					HideUIPanel(SettingsPanel)
				else
					Settings.OpenToCategory(E.AddonTitle, true)
				end
		end)
		local t = OctoToDo_SECOND_OptionsButton:CreateTexture(nil, "BACKGROUND")
		OctoToDo_SECOND_OptionsButton.icon = t
		t:SetTexture(E.AddonTexture_1)
		t:SetAllPoints(OctoToDo_SECOND_OptionsButton)
	end
	----------------------------------------------------------------
	if not dd_SECOND then
		local dd_SECOND = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_SECOND_MainFrame, "SecureActionButtonTemplate, BackDropTemplate")
		local multiply = (1/3)*2
		dd_SECOND:SetSize(E.curWidthTitle*multiply, E.curHeight*multiply)
		dd_SECOND:SetBackdrop({
				bgFile = bgFile,
				edgeFile = edgeFile,
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
			Octo_ToDo_DB_Vars.config.AchievementToShow[menuButton.value] = checked or nil
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
				if arg1 and cID == parentCategoryID and Octo_ToDo_DB_Vars.config.AchievementToShow[categoryID] == true then
					return LibOctopussy:func_Gradient(arg1.name)..arg1.vivod
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
						vivod = " "..LibOctopussy:DONE()
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
						info.checked = Octo_ToDo_DB_Vars.config.AchievementToShow[categoryID]
						info.func = selectFunctionAchievementToShow
						tinsert(list, info)
						-- self:ddAddButton(info, level)
						----------------------------------------------------------------
					end
				end

				self:ddAddButton({list = list, listMaxSize = 12}, level)

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
					info.checked = Octo_ToDo_DB_Vars.config.AchievementShowCompleted
					info.func = function(_,_,_, checked)
						Octo_ToDo_DB_Vars.config.AchievementShowCompleted = checked
						StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
					end
					self:ddAddButton(info, level)
				end
				----------------------------------------------------------------
		end)
	end



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
		OctoToDo_SECOND_MainFrame[fname] = CreateFrame("Frame", E.AddonTitle..LibOctopussy:func_GenerateUniqueID().."FrameLine"..i, OctoToDo_SECOND_MainFrame.scrollChild, "BackdropTemplate")
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
		f.animation:SetDuration(.5)
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
	Octo_ToDo_SECOND_AddDataToAltFrame()
	OctoToDo_SECOND_MainFrame:Hide()
end
function Octo_ToDo_SECOND_AddDataToAltFrame()
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER")
	local ShowOnlyCurrentRealm = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm
	local LevelToShow = Octo_ToDo_DB_Vars.config.LevelToShow
	local LevelToShowMAX = Octo_ToDo_DB_Vars.config.LevelToShowMAX
	local itemLevelToShow = Octo_ToDo_DB_Vars.config.itemLevelToShow
	OctoToDo_SECOND_MainFrame.AllCharFrames = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Players) do
		if GUID == curGUID then
			local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
			local curCharGUID = CharInfo.GUID
			if not OctoToDo_SECOND_MainFrame[curCharGUID] then
				OctoToDo_SECOND_MainFrame[curCharGUID] = CreateFrame("Frame", E.AddonTitle..LibOctopussy:func_GenerateUniqueID().."OctoToDo_SECOND_MainFrame[curCharGUID]", OctoToDo_SECOND_MainFrame.scrollChild, "BackdropTemplate")
				OctoToDo_SECOND_CharFrame = OctoToDo_SECOND_MainFrame[curCharGUID]
				OctoToDo_SECOND_CharFrame:SetPoint("BOTTOM", 0, 0)
				OctoToDo_SECOND_CharFrame.BG = OctoToDo_SECOND_CharFrame:CreateTexture(nil, "BACKGROUND")
				OctoToDo_SECOND_CharFrame.BG:Hide()
				OctoToDo_SECOND_CharFrame.BG:SetPoint("TOPLEFT", 0, -E.curHeight)
				OctoToDo_SECOND_CharFrame.BG:SetPoint("BOTTOMRIGHT", 0, 0)
				OctoToDo_SECOND_CharFrame.BG:SetColorTexture(r, g, b, 0) -- ЦВЕТ ФОНА
				for i = 1, #OctoTable_func_otrisovka_SECOND do
					CharInfo.GUID = curCharGUID
					local CF = CreateFrame("Frame", E.AddonTitle..LibOctopussy:func_GenerateUniqueID().."CF"..i, OctoToDo_SECOND_CharFrame)
					OctoToDo_SECOND_CharFrame["CenterLines"..i] = CF
					CF.index = i
					CF:SetSize(E.curWidthCentral, E.curHeight)
					CF:SetPoint("TOP", OctoToDo_SECOND_CharFrame, "TOP", 0, -E.curHeight*(i-1))
					-- CF:SetScript("OnClick", Central_Frame_Mouse_OnClick)
					CF:SetScript("OnEnter", Central_Frame_Mouse_OnEnter)
					CF:SetScript("OnLeave", Central_Frame_Mouse_OnLeave)
					CF:SetMouseClickEnabled(false)
					local CL = CF:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
					CL:SetAllPoints()
					CL:SetFontObject(OctoFont11)
					CL:SetJustifyV("MIDDLE")
					CL:SetJustifyH("CENTER")
					CL:SetTextColor(1, 1, 1, 1)
					OctoToDo_SECOND_CharFrame["CenterLines"..i.."BG"] = OctoToDo_SECOND_CharFrame:CreateTexture(nil, "BACKGROUND")
					OctoToDo_SECOND_CharFrame["CenterLines"..i.."BG"]:SetAllPoints(OctoToDo_SECOND_CharFrame["CenterLines"..i])
					OctoToDo_SECOND_CharFrame["CenterLines"..i.."BG"]:SetColorTexture(0, 0, 0, 0)
					CF.CL = CL
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
local function main_frame_toggle()
	local button = LibDBIcon:GetMinimapButton(GlobalAddonName.."Octo_ToDo_SECOND_Minimap")
	if OctoToDo_SECOND_MainFrame:IsShown() then
		OctoToDo_SECOND_MainFrame:Hide()
	else
		OctoToDo_SECOND_MainFrame:Show()
		Octo_ToDo_SECOND_AddDataToAltFrame()
	end
end
function Octo_ToDo_SECOND_OnEvent(self, event, ...)
	if event == "VARIABLES_LOADED" and not InCombatLockdown() then
		if Octo_ToDo_DB_Other == nil then Octo_ToDo_DB_Other = {} end
		if Octo_Achi_MAIN == nil then Octo_Achi_MAIN = {} end
		if Octo_ToDo_DB_Players == nil then Octo_ToDo_DB_Players = {} end
		if Octo_ToDo_DB_Vars == nil then Octo_ToDo_DB_Vars = {} end
		if Octo_ToDo_DB_Vars.config == nil then Octo_ToDo_DB_Vars.config = {} end
		if Octo_ToDo_DB_Artifact == nil then Octo_ToDo_DB_Artifact = {} end
		if Octo_ToDo_DB_Other == nil then Octo_ToDo_DB_Other = {} end
		if Octo_ToDoTransmog == nil then Octo_ToDoTransmog = {} end
		SHOWADDON_SECOND = Octo_ToDo_DB_Vars.config.Achievements
		if SHOWADDON_SECOND == false then
			Octo_ToDo_SECOND_Frame_EventFrame:UnregisterAllEvents()
			return
		end
		local MinimapName = GlobalAddonName.."SECOND_Minimap"
		local ldb_icon = LibDataBroker:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = E.AddonTexture_2,
				OnClick = function(_, button)
					if button == "LeftButton" then
						if not InCombatLockdown() then
							main_frame_toggle()
						end
						if OctoToDo_FIRST_MainFramePIZDA and OctoToDo_FIRST_MainFramePIZDA:IsShown() then
							OctoToDo_FIRST_MainFramePIZDA:Hide()
						end
					else
						if OctoToDo_FIRST_MainFramePIZDA and OctoToDo_FIRST_MainFramePIZDA:IsShown() then
							OctoToDo_FIRST_MainFramePIZDA:Hide()
						end
						if OctoToDo_SECOND_MainFramePIZDA and OctoToDo_SECOND_MainFramePIZDA:IsShown() then
							OctoToDo_SECOND_MainFramePIZDA:Hide()
						end
						if SettingsPanel:IsVisible() and self:IsVisible() then
							HideUIPanel(SettingsPanel)
						else
							Settings.OpenToCategory(E.AddonTitle, true)
						end
					end
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, LibOctopussy:func_Gradient(GlobalAddonName.." Achievements", E.Green_Color, E.Addon_Right_Color).."|n".."ПКМ - Настройки")
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDo_DB_Vars.minimap_SECOND = Octo_ToDo_DB_Vars.minimap_SECOND or {}
		Octo_ToDo_DB_Vars.minimap_SECOND.minimapPos = Octo_ToDo_DB_Vars.minimap_SECOND.minimapPos or 284
		-- Octo_ToDo_DB_Vars.config.AddonVersion = tonumber(E.AddonVersion)
		LibDBIcon:Register(MinimapName, ldb_icon, Octo_ToDo_DB_Vars.minimap_SECOND)
		LibDBIcon:Show(MinimapName)
	end
	if event == "PLAYER_STARTED_MOVING" and not InCombatLockdown() then
		if OctoToDo_SECOND_MainFrame and OctoToDo_SECOND_MainFrame:IsShown() then OctoToDo_SECOND_MainFrame:SetAlpha(E.BGALPHA*5) end
	end
	if event == "PLAYER_STOPPED_MOVING" then
		if OctoToDo_SECOND_MainFrame then OctoToDo_SECOND_MainFrame:SetAlpha(1) end
	end
	if event == "PLAYER_LOGIN" and not InCombatLockdown() and SHOWADDON_SECOND == true then
		C_Timer.After(2, function()
				O_otrisovka_SECOND()
				Octo_ToDo_SECOND_CreateAltFrame()
				Octo_ToDo_SECOND_AddDataToAltFrame()
		end)
	end
end
Octo_ToDo_SECOND_OnLoad()