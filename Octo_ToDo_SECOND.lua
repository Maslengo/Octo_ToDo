local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonNotes = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Notes")
local AddonAuthor = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Author")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local GBI_version, GBI_build, GBI_date, GBI_tocversion, GBI_localizedVersion, GBI_buildType = GetBuildInfo()
if PTR_IssueReporter then PTR_IssueReporter:Hide() end
if WeeklyRewardExpirationWarningDialog then WeeklyRewardExpirationWarningDialog:Hide() end
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local lsfdd = LibStub("LibSFDropDown-1.4")
----------------------------------------------------------------
local SHOWADDON_SECOND = false
----------------------------------------------------------------
local Button = nil
local CF = nil
local Octo_ToDo_SECOND_Frame_Char_Frame = nil
local Octo_ToDo_SECOND_Frame_EventFrame = nil
local inspectScantip = nil
local Octo_ToDo_SECOND_Frame_Main_Frame = nil
local Octo_ToDo_SECOND_Frame_UPGRADERANKS_Frame = nil
local Octo_ToDo_SECOND_Frame_Close_Button = nil
local Octo_ToDo_SECOND_Frame_MarkOfHonor_Button = nil
local Octo_ToDo_SECOND_Frame_QuestFeast_Button = nil
local Octo_ToDo_SECOND_Frame_AbandonAllQuests_Button = nil
local Octo_ToDo_SECOND_Frame_Char_FrameDeleteButton = nil
----------------------------------------------------------------
local className, classFilename, classId = UnitClass("PLAYER")
local englishFaction, localizedFaction = UnitFactionGroup("PLAYER")
local Horde_Icon = E.Octo_Func.func_texturefromIcon(132485)--"|T132485:16:16:::64:64:4:60:4:60|t"
local Alliance_Icon = E.Octo_Func.func_texturefromIcon(132486)--"|T132486:16:16:::64:64:4:60:4:60|t"
local Kyrian_Icon = E.Octo_Func.func_texturefromIcon(3257748)--"|T3257748:16:16:::64:64:4:60:4:60|t"
local Necrolord_Icon = E.Octo_Func.func_texturefromIcon(3257749)--"|T3257749:16:16:::64:64:4:60:4:60|t"
local NightFae_Icon = E.Octo_Func.func_texturefromIcon(3257750)--"|T3257750:16:16:::64:64:4:60:4:60|t"
local Venthyr_Icon = E.Octo_Func.func_texturefromIcon(3257751)--"|T3257751:16:16:::64:64:4:60:4:60|t"
local WorldBoss_Icon = E.Octo_Func.func_texturefromIcon(3528312)--"|T3528312:16:16:::64:64:4:60:4:60|t"
local Rares_Icon = E.Octo_Func.func_texturefromIcon(135903)--"|T135903:16:16:::64:64:4:60:4:60|t"
local Unknown_Icon = E.Octo_Func.func_texturefromIcon(134400)--"|T134400:16:16:::64:64:4:60:4:60|t"
local Token_Icon = E.Octo_Func.func_texturefromIcon(1120721)--"|T1120721:16:16:::64:64:4:64:4:64|t"
local Money_Icon = E.Octo_Func.func_texturefromIcon(133784, 12)--"|T133784:12:12:::64:64:4:64:4:64|t"
-- local MailBox_Icon = "|T1418621:12:12:::64:64:4:64:4:64|t"
-- local MailBox_Icon = "|T".."Interface/AddOns/Octo_ToDo/Media/ElvUI/Mail0.tga"..":12:12:::64:64:4:64:4:64|t"
local MailBox_Icon = "|T1506457:12:12:::64:64:4:64:4:64|t"
local classColor = C_ClassColor.GetClassColor(classFilename)
local r, g, b = classColor:GetRGB()
-- local fontObject9 = CreateFont("OctoFont9")
-- fontObject9:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 9, "OUTLINE")
-- local fontObject10 = CreateFont("OctoFont10")
-- fontObject10:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 10, "OUTLINE")
-- local fontObject11 = CreateFont("OctoFont11")
-- fontObject11:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 11, "OUTLINE")
-- local fontObject12 = CreateFont("OctoFont12")
-- fontObject12:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 12, "OUTLINE")
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
-- local E.Octo_Globals.NONE = E.Octo_Globals.Gray_Color.."None|r"
-- local E.Octo_Globals.DONE = E.Octo_Globals.Green_Color.."Done|r"
local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
local regionalWeeklyStart = 1668981600
local edgeFile = "Interface\\Buttons\\WHITE8X8"
local bgFile = "Interface\\Buttons\\WHITE8X8"
local AddonTexture_SECOND = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\AddonTexture_SECOND.tga"
----------------------------------------------------------------
-- local menuBackdrop = {
-- 	bgFile = "Interface/ChatFrame/ChatFrameBackground",
-- 	edgeFile = "Interface/ChatFrame/ChatFrameBackground",
-- 	tile = true, edgeSize = 1 * E.Octo_Globals.scale, tileSize = 5 * E.Octo_Globals.scale,
-- }
-- lsfdd:CreateMenuStyle(GlobalAddonName, function(parent)
-- 	local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
-- 	f:SetBackdrop(menuBackdrop)
-- 	f:SetBackdropColor(.06, .06, .1, .9)
-- 	f:SetBackdropBorderColor(.5, .5, .5, .8)
-- 	return f
-- end)
-----------------------
local OctoTable_func_otrisovka_SECOND = {
}
local function Central_Frame_Mouse_OnEnter(self)
	-- local parent = self:GetParent():GetParent()["FrameLine"..self.index]
	local parent = Octo_ToDo_SECOND_Frame_Main_Frame["FrameLine"..self.index]
	parent:GetScript("OnEnter")(parent)
	if not self.tooltip then
		return
	end
	-- GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, -10)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 0)
	GameTooltip:AddLine(" ")
	for _, v in pairs(self.tooltip) do
		if v[2] ~= "0/0" then
			GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:Show()
end
local function Central_Frame_Mouse_OnLeave(self)
	-- local parent = self:GetParent():GetParent()["FrameLine"..self.index]
	local parent = Octo_ToDo_SECOND_Frame_Main_Frame["FrameLine"..self.index]
	parent:GetScript("OnLeave")(parent)
	GameTooltip:Hide()
end
local function Octo_ToDo_SECOND_OnLoad()
	if not Octo_ToDo_SECOND_Frame_EventFrame then
		Octo_ToDo_SECOND_Frame_EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
	end
	Octo_ToDo_SECOND_Frame_EventFrame:RegisterEvent("VARIABLES_LOADED")
	Octo_ToDo_SECOND_Frame_EventFrame:RegisterEvent("PLAYER_LOGIN")
	-- Octo_ToDo_SECOND_Frame_EventFrame:RegisterEvent("PLAYER_STARTED_MOVING")
	-- Octo_ToDo_SECOND_Frame_EventFrame:RegisterEvent("PLAYER_STOPPED_MOVING")
	Octo_ToDo_SECOND_Frame_EventFrame:SetScript("OnEvent", function(...)
			Octo_ToDo_SECOND_OnEvent(...)
	end)
end
local function O_otrisovka_SECOND()
	tinsert(OctoTable_func_otrisovka_SECOND,
		function(CharInfo, tooltip, CL, BG)
			local vivodCent, vivodLeft = "", ""
			CL:SetFontObject(OctoFont12)
			vivodLeft = Timer_ElementalStorm().. "Elemental Storm"
			vivodCent = CharInfo.classColorHex..CharInfo.Name.."|r"
			if CharInfo.Faction == "Horde" then
				BG:SetColorTexture(.5, 0, 0, E.Octo_Globals.BGALPHA*2)
			else
				BG:SetColorTexture(0, 0, .5, E.Octo_Globals.BGALPHA*2)
			end
			if CharInfo.hasMail then
				BG:SetColorTexture(1, 1, 1, E.Octo_Globals.BGALPHA)
				vivodCent = MailBox_Icon..vivodCent
			end
			return vivodCent.."|r", vivodLeft
	end)
	if Octo_ToDo_DB_Vars.config.AchievementToShow ~= 0 then
		local categoryID = Octo_ToDo_DB_Vars.config.AchievementToShow
		local total = GetCategoryNumAchievements(categoryID, true)
		if total then
			for i = 1, total do
				local AchievementID, name, points, completedAchi, _, _, _, _, _, icon = GetAchievementInfo(categoryID, i)
				if AchievementID then
					if completedAchi == false or (completedAchi == Octo_ToDo_DB_Vars.config.AchievementShowCompleted) then
						tinsert(OctoTable_func_otrisovka_SECOND,
							function(CharInfo, tooltip, CL, BG)
								local vivodCent, vivodLeft = "", ""
								vivodLeft = E.Octo_Func.func_texturefromIcon(icon)..name
								tooltip[#tooltip+1] = {" ", E.Octo_Globals.Yellow_Color.." "..points.."|r".." "..E.Octo_Globals.Gray_Color.." id: "..AchievementID.."|r"}
								vivodCent = E.Octo_Func.func_achievementvivod(AchievementID)
								local numCriteria = GetAchievementNumCriteria(AchievementID)
								if numCriteria ~= 1 then
									tooltip[#tooltip+1] = {E.Octo_Func.func_achievementdescription(AchievementID), " "}
									tooltip[#tooltip+1] = {" ", " "}
								end
								for i = 1, numCriteria do
									tooltip[#tooltip+1] = {E.Octo_Func.func_achievementcriteriaString(AchievementID, i), E.Octo_Func.func_achievementquantity(AchievementID, i)}
								end
								return vivodCent, vivodLeft
						end)
					end
				end
			end
		end
	end
end
local function Octo_ToDo_SECOND_CreateAltFrame()
	if not Octo_ToDo_SECOND_Frame_Main_Frame then
		-- Octo_ToDo_SECOND_Frame_Main_Frame = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID().."Octo_ToDo_SECOND_Frame_Main_FrameПИЗДА", UIParent, "BackdropTemplate")
		Octo_ToDo_SECOND_Frame_Main_Frame = CreateFrame("BUTTON", "Octo_ToDo_SECOND_Frame_Main_FramePIZDA", UIParent, "BackdropTemplate")
		Octo_ToDo_SECOND_Frame_Main_Frame:Hide()
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local ScrollFrame = CreateFrame("ScrollFrame", "ScrollFrame"..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_SECOND_Frame_Main_Frame)
	local ScrollBar = CreateFrame("EventFrame", nil, ScrollFrame, "MinimalScrollBar")
	ScrollBar:SetPoint("TOPLEFT", ScrollFrame, "TOPRIGHT", 6, 0)
	ScrollBar:SetPoint("BOTTOMLEFT", ScrollFrame, "BOTTOMRIGHT", 6, 0)
	local scrollChild = CreateFrame("Frame", nil, ScrollFrame)
	ScrollFrame:SetScrollChild(scrollChild)
	ScrollFrame:SetAllPoints()
	scrollChild:SetSize(1, 1)
	scrollChild:SetPoint("TOPRIGHT")
	-- ScrollFrame:SetClipsChildren(true)
	-- ScrollFrame это "содержимое" фрейм ивентов (база)
	-- ScrollBar что бы скрыть скроллбар
	-- scrollChild на что вешать (parent)
	ScrollUtil.InitScrollFrameWithScrollBar(ScrollFrame, ScrollBar)
	local OnMouseWheel = ScrollFrame:GetScript("OnMouseWheel")
	ScrollFrame:SetScript("OnMouseWheel", function(self, ...)
			if ScrollBar:IsShown() then
				OnMouseWheel(self, ...)
			end
	end)
	Octo_ToDo_SECOND_Frame_Main_Frame.scrollChild = scrollChild
	Octo_ToDo_SECOND_Frame_Main_Frame.ScrollBar = ScrollBar
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	Octo_ToDo_SECOND_Frame_Main_Frame:SetClampedToScreen(false)
	Octo_ToDo_SECOND_Frame_Main_Frame:SetFrameStrata("HIGH")
	Octo_ToDo_SECOND_Frame_Main_Frame:SetPoint("TOP", 0, -257*E.Octo_Globals.scale)
	Octo_ToDo_SECOND_Frame_Main_Frame:SetBackdrop({
			bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	Octo_ToDo_SECOND_Frame_Main_Frame:SetBackdropColor(E.Octo_Globals.bgCr, E.Octo_Globals.bgCg, E.Octo_Globals.bgCb, E.Octo_Globals.bgCa)
	Octo_ToDo_SECOND_Frame_Main_Frame:SetBackdropBorderColor(0, 0, 0, 1) -- бордер
	Octo_ToDo_SECOND_Frame_Main_Frame:SetScript("OnShow", function()
			Octo_ToDo_SECOND_AddDataToAltFrame()
	end)
	Octo_ToDo_SECOND_Frame_Main_Frame:EnableMouse(true)
	Octo_ToDo_SECOND_Frame_Main_Frame:SetMovable(true)
	Octo_ToDo_SECOND_Frame_Main_Frame:RegisterForDrag("LeftButton")
	Octo_ToDo_SECOND_Frame_Main_Frame:SetScript("OnDragStart", Octo_ToDo_SECOND_Frame_Main_Frame.StartMoving)
	Octo_ToDo_SECOND_Frame_Main_Frame:SetScript("OnDragStop", function() Octo_ToDo_SECOND_Frame_Main_Frame:StopMovingOrSizing() end)
	Octo_ToDo_SECOND_Frame_Main_Frame:RegisterForClicks("RightButtonUp")
	Octo_ToDo_SECOND_Frame_Main_Frame:SetScript("OnClick", function(self) self:Hide() end)
	if not Octo_ToDo_SECOND_Frame_Close_Button then
		Octo_ToDo_SECOND_Frame_Close_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_SECOND_Frame_Main_Frame, "BackDropTemplate")
		Octo_ToDo_SECOND_Frame_Close_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		Octo_ToDo_SECOND_Frame_Close_Button:SetPoint("BOTTOMRIGHT", Octo_ToDo_SECOND_Frame_Main_Frame, "TOPRIGHT", E.Octo_Globals.curHeight, 1)
		Octo_ToDo_SECOND_Frame_Close_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		Octo_ToDo_SECOND_Frame_Close_Button:SetBackdropBorderColor(1, 0, 0, 0)
		Octo_ToDo_SECOND_Frame_Close_Button:SetScript("OnEnter", function(self)
				-- self:SetBackdropBorderColor(1, 0, 0, 1)
				self.icon:SetVertexColor(1, 0, 0, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(CLOSE)
				GameTooltip:Show()
		end)
		Octo_ToDo_SECOND_Frame_Close_Button:SetScript("OnLeave", function(self)
				-- self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		Octo_ToDo_SECOND_Frame_Close_Button:SetScript("OnMouseDown", function(self)
				-- self:SetBackdropBorderColor(1, 0, 0, .5)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		Octo_ToDo_SECOND_Frame_Close_Button:SetScript("OnClick", function()
				Octo_ToDo_SECOND_Frame_Main_Frame:Hide()
		end)
		local t = Octo_ToDo_SECOND_Frame_Close_Button:CreateTexture(nil, "BACKGROUND")
		Octo_ToDo_SECOND_Frame_Close_Button.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\CloseTest.tga")
		----t:SetVertexColor(1, 1, 1, 1)
		t:SetAllPoints(Octo_ToDo_SECOND_Frame_Close_Button)
		Octo_ToDo_SECOND_Frame_Close_Button:SetScript("OnKeyDown", function(self, key)
				if key == GetBindingKey("TOGGLEGAMEMENU") then
					self:GetParent():Hide()
					self:SetPropagateKeyboardInput(false)
				else
					self:SetPropagateKeyboardInput(true)
				end
		end)
	end
	--
	if not dd then
		local dd = lsfdd:CreateStretchButtonOriginal(Octo_ToDo_SECOND_Frame_Main_Frame, 160, 22) -- lsfdd:CreateButton
		dd:SetPoint("BOTTOMLEFT", Octo_ToDo_SECOND_Frame_Main_Frame, "TOPLEFT", 0, 2)
		-- dd:ddSetSelectedValue(Octo_ToDo_DB_Vars.config.AchievementToShow)
		local function selectFunctionAchievementToShow(menuButton)
			-- dd:ddSetSelectedValue(menuButton.value)
			Octo_ToDo_DB_Vars.config.AchievementToShow = menuButton.value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end
		-- dd:SetText(OPTIONS)
		dd:SetText(ACHIEVEMENT_TITLE.." "..E.Octo_Globals.Green_Color..GetTotalAchievementPoints(false).."|r")
		dd:ddSetDisplayMode(GlobalAddonName)
		dd:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth(), self:GetHeight())
		end)
		dd:ddSetInitFunc(function(self, level, value)
				local info = {}
				local categories = GetCategoryList()
				local categoryID
				local name, parentCategoryID, total, completed
				-- if level == 1 then
				-- 	info.notCheckable = true
				-- 	info.text = ACHIEVEMENT_TITLE.." "..E.Octo_Globals.Green_Color..GetTotalAchievementPoints(false).."|r"
				-- 	self:ddAddButton(info, level)
				-- 	self:ddAddSeparator(level)
				-- end
				for i = 1, #categories do
					categoryID = categories[i]
					name, parentCategoryID = GetCategoryInfo(categoryID)
					total, completed = GetCategoryNumAchievements(categoryID, true)
					local vivod =  " ("..completed.."/"..total..")"
					if total == completed then
						vivod = " "..E.Octo_Globals.DONE
					else
						if completed == 0 then
							vivod = E.Octo_Globals.Red_Color..vivod.."|r"
						else
							vivod = E.Octo_Globals.Yellow_Color..vivod.."|r"
						end
					end
					if parentCategoryID == value or parentCategoryID == -1 and not value then
						info.fontObject = OctoFont11
						info.hasArrow = parentCategoryID == -1 and categoryID ~= 92
						info.keepShownOnClick = true
						info.notCheckable = false
						info.text = name ..vivod --.. E.Octo_Globals.Gray_Color.." id:"..categoryID.."|r"
						info.value = categoryID
						info.checked = Octo_ToDo_DB_Vars.config.AchievementToShow == categoryID
						info.func = selectFunctionAchievementToShow
						self:ddAddButton(info, level)
					end
				end
				if level == 1 then
					self:ddAddSeparator(level)
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
		end)
	end
	----------------------------------------------------------------
	local function FrameLine_OnEnter(self)
		self.BG:SetColorTexture(r, g, b, E.Octo_Globals.BGALPHA*2)
		Octo_ToDo_SECOND_Frame_Main_Frame:SetAlpha(1)
	end
	local function FrameLine_OnLeave(self)
		self.BG:SetColorTexture(0, 0, 0, 0)
	end
	for i = 1, #OctoTable_func_otrisovka_SECOND do -- БЭКГРАУНД
		local fname, f
		fname = "FrameLine"..i
		Octo_ToDo_SECOND_Frame_Main_Frame[fname] = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."FrameLine"..i, Octo_ToDo_SECOND_Frame_Main_Frame.scrollChild, "BackdropTemplate")
		f = Octo_ToDo_SECOND_Frame_Main_Frame[fname]
		f:SetHeight(E.Octo_Globals.curHeight)
		f:SetPoint("TOPLEFT", Octo_ToDo_SECOND_Frame_Main_Frame.scrollChild, "TOPLEFT", 0, -E.Octo_Globals.curHeight*(i-1))
		f:SetPoint("RIGHT")
		f:SetScript("OnEnter", FrameLine_OnEnter)
		f:SetScript("OnLeave", FrameLine_OnLeave)
		f:SetMouseClickEnabled(false)
		f.BG = f:CreateTexture(nil, "BACKGROUND")
		f.BG:SetHeight(E.Octo_Globals.curHeight)
		f.BG:SetAllPoints()
		fname = "TextLeft"..i
		Octo_ToDo_SECOND_Frame_Main_Frame[fname] = Octo_ToDo_SECOND_Frame_Main_Frame.scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		f = Octo_ToDo_SECOND_Frame_Main_Frame[fname]
		f:SetSize(E.Octo_Globals.curWidthTitleAchievement, E.Octo_Globals.curHeight)
		f:SetPoint("TOPLEFT", Octo_ToDo_SECOND_Frame_Main_Frame.scrollChild, "TOPLEFT", 6, -E.Octo_Globals.curHeight*(i-1))
		f:SetFontObject(OctoFont11)
		f:SetJustifyV("MIDDLE")
		f:SetJustifyH("LEFT")
		f:SetTextColor(1, 1, 1, 1)
	end
	Octo_ToDo_SECOND_AddDataToAltFrame()
	Octo_ToDo_SECOND_Frame_Main_Frame:Hide()
end
function Octo_ToDo_SECOND_AddDataToAltFrame()
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER")
	local ShowOnlyCurrentRealm = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm
	local LevelToShow = Octo_ToDo_DB_Vars.config.LevelToShow
	local itemLevelToShow = Octo_ToDo_DB_Vars.config.itemLevelToShow
	Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames = {}
	local sorted = {}
	for i, CharInfo in pairs(Octo_ToDo_DB_Levels) do
		if i == curGUID then
			local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
			local curCharGUID = CharInfo.GUID
			if not Octo_ToDo_SECOND_Frame_Main_Frame[curCharGUID] then
				Octo_ToDo_SECOND_Frame_Main_Frame[curCharGUID] = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."Octo_ToDo_SECOND_Frame_Main_Frame[curCharGUID]", Octo_ToDo_SECOND_Frame_Main_Frame.scrollChild, "BackdropTemplate")
				Octo_ToDo_SECOND_Frame_Char_Frame = Octo_ToDo_SECOND_Frame_Main_Frame[curCharGUID]
				Octo_ToDo_SECOND_Frame_Char_Frame:SetPoint("BOTTOM", 0, 0)
				Octo_ToDo_SECOND_Frame_Char_Frame.BG = Octo_ToDo_SECOND_Frame_Char_Frame:CreateTexture(nil, "BACKGROUND")
				Octo_ToDo_SECOND_Frame_Char_Frame.BG:Hide()
				Octo_ToDo_SECOND_Frame_Char_Frame.BG:SetPoint("TOPLEFT", 0, -E.Octo_Globals.curHeight) -- ФОН ЗАЛОГИНЕНОГО ПЕРСОНАЖА (рога - желтый)
				Octo_ToDo_SECOND_Frame_Char_Frame.BG:SetPoint("BOTTOMRIGHT", 0, 0)
				Octo_ToDo_SECOND_Frame_Char_Frame.BG:SetColorTexture(r, g, b, 1)
				for i = 1, #OctoTable_func_otrisovka_SECOND do
					CharInfo.GUID = curCharGUID
					local CF = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID().."CF"..i, Octo_ToDo_SECOND_Frame_Char_Frame)
					Octo_ToDo_SECOND_Frame_Char_Frame["CenterLines"..i] = CF
					CF.index = i
					CF:SetSize(E.Octo_Globals.curWidthCentral, E.Octo_Globals.curHeight)
					CF:SetPoint("TOP", Octo_ToDo_SECOND_Frame_Char_Frame, "TOP", 0, -E.Octo_Globals.curHeight*(i-1))
					CF:SetScript("OnEnter", Central_Frame_Mouse_OnEnter)
					CF:SetScript("OnLeave", Central_Frame_Mouse_OnLeave)
					-- CF:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
					-- CF:SetScript("OnClick", function(self)
					--         for k, v in pairs(self) do
					--             if k == "CL" then
					--                 for q, w in pairs(v) do
					--                    -- w = userdata???????
					--                 end
					--             end
					--         end
					-- end)
					CF:SetMouseClickEnabled(false)
					local CL = CF:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
					CL:SetAllPoints()
					CL:SetFontObject(OctoFont11)
					CL:SetJustifyV("MIDDLE")
					CL:SetJustifyH("CENTER")
					CL:SetTextColor(1, 1, 1, 1)
					Octo_ToDo_SECOND_Frame_Char_Frame["CenterLines"..i.."BG"] = Octo_ToDo_SECOND_Frame_Char_Frame:CreateTexture(nil, "BACKGROUND")
					Octo_ToDo_SECOND_Frame_Char_Frame["CenterLines"..i.."BG"]:SetAllPoints(Octo_ToDo_SECOND_Frame_Char_Frame["CenterLines"..i])
					Octo_ToDo_SECOND_Frame_Char_Frame["CenterLines"..i.."BG"]:SetColorTexture(r, g, b, 0)
					CF.CL = CL
				end
			else
				Octo_ToDo_SECOND_Frame_Char_Frame = Octo_ToDo_SECOND_Frame_Main_Frame[curCharGUID]
			end
			Octo_ToDo_SECOND_Frame_Char_Frame:SetSize(E.Octo_Globals.curWidthCentral, E.Octo_Globals.curHeight)
			if #Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames == 0 then
				Octo_ToDo_SECOND_Frame_Char_Frame:SetPoint("TOPRIGHT", 0, 0)
			else
				Octo_ToDo_SECOND_Frame_Char_Frame:SetPoint("TOPRIGHT", Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames[#Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames], "TOPLEFT", 0, 0)
			end
			Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames[#Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames + 1] = Octo_ToDo_SECOND_Frame_Char_Frame
			if curGUID == curCharGUID then
				Octo_ToDo_SECOND_Frame_Char_Frame.BG:Show()
				Octo_ToDo_SECOND_Frame_Char_Frame.BG:SetAlpha(E.Octo_Globals.BGALPHA)
			end
			for i = 1, #OctoTable_func_otrisovka_SECOND do
				local TEXTLEFT = Octo_ToDo_SECOND_Frame_Main_Frame["TextLeft"..i]
				local TEXTCENT = Octo_ToDo_SECOND_Frame_Char_Frame["CenterLines"..i]
				local BG = Octo_ToDo_SECOND_Frame_Char_Frame["CenterLines"..i.."BG"]
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
			local curAltFrameWidth = #Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames * E.Octo_Globals.curWidthCentral/2
			local width = curAltFrameWidth*2+E.Octo_Globals.curWidthTitleAchievement
			local height = E.Octo_Globals.curHeight*(#OctoTable_func_otrisovka_SECOND)
			Octo_ToDo_SECOND_Frame_Main_Frame.scrollChild:SetSize(width, height)
			if height > E.Octo_Globals.Addon_Height then
				height = E.Octo_Globals.Addon_Height
				Octo_ToDo_SECOND_Frame_Main_Frame.ScrollBar:Show()
			else
				Octo_ToDo_SECOND_Frame_Main_Frame.ScrollBar:Hide()
			end
			Octo_ToDo_SECOND_Frame_Main_Frame:SetSize(width, height) -- ТУТ БЫЛА ЗАЛУПА
		end
	end -- for
end
function Octo_ToDo_SECOND_OnEvent(self, event, ...)
	if event == "VARIABLES_LOADED" and not InCombatLockdown() then
		if Octo_ToDo_DB_Other == nil then Octo_ToDo_DB_Other = {} end
		if Octo_Achi_MAIN == nil then Octo_Achi_MAIN = {} end
		if Octo_ToDo_DB_Levels == nil then Octo_ToDo_DB_Levels = {} end
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
		-- O_otrisovka_SECOND()
		local MinimapName = GlobalAddonName.."Octo_ToDo_SECOND_Minimap"
		local ldb_icon = ldb:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = AddonTexture_SECOND,
				OnClick = function(_, button)
					if button == "LeftButton" then
						if not InCombatLockdown() then
							if Octo_ToDo_FIRST_Frame_Main_FramePIZDA and Octo_ToDo_FIRST_Frame_Main_FramePIZDA:IsShown() then
								Octo_ToDo_FIRST_Frame_Main_FramePIZDA:Hide()
							end
							-- if Octo_ToDo_SECOND_Frame_Main_FramePIZDA and Octo_ToDo_SECOND_Frame_Main_FramePIZDA:IsShown() then
							-- 	Octo_ToDo_SECOND_Frame_Main_FramePIZDA:Hide()
							-- end
							if Octo_ToDo_THIRD_Frame_Main_FramePIZDA and Octo_ToDo_THIRD_Frame_Main_FramePIZDA:IsShown() then
								Octo_ToDo_THIRD_Frame_Main_FramePIZDA:Hide()
							end
							Octo_ToDo_SECOND_Frame_Main_Frame:SetShown(not Octo_ToDo_SECOND_Frame_Main_Frame:IsShown())
							Octo_ToDo_SECOND_AddDataToAltFrame()
						end
					else
						if Octo_ToDo_FIRST_Frame_Main_FramePIZDA and Octo_ToDo_FIRST_Frame_Main_FramePIZDA:IsShown() then
							Octo_ToDo_FIRST_Frame_Main_FramePIZDA:Hide()
						end
						if Octo_ToDo_SECOND_Frame_Main_FramePIZDA and Octo_ToDo_SECOND_Frame_Main_FramePIZDA:IsShown() then
							Octo_ToDo_SECOND_Frame_Main_FramePIZDA:Hide()
						end
						if Octo_ToDo_THIRD_Frame_Main_FramePIZDA and Octo_ToDo_THIRD_Frame_Main_FramePIZDA:IsShown() then
							Octo_ToDo_THIRD_Frame_Main_FramePIZDA:Hide()
						end
						if SettingsPanel:IsVisible() and self:IsVisible() then
							HideUIPanel(SettingsPanel)
						else
							Settings.OpenToCategory(AddonTitle, true)
						end
					end
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					-- GameTooltip_SetTitle(GameTooltip, AddonTitle.." "..E.Octo_Globals.LightGray_Color..AddonVersion.."|r")
					GameTooltip_SetTitle(GameTooltip, E.Octo_Func.func_Gradient(GlobalAddonName.." Achievements", E.Octo_Globals.Green_Color, E.Octo_Globals.Addon_Right_Color).."|n".."ПКМ - Настройки")
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDo_DB_Vars.minimap_SECOND = Octo_ToDo_DB_Vars.minimap_SECOND or {}
		Octo_ToDo_DB_Vars.minimap_SECOND.minimapPos = Octo_ToDo_DB_Vars.minimap_SECOND.minimapPos or 284
		Octo_ToDo_DB_Vars.config.AddonVersion = tonumber(AddonVersion)
		ldbi:Register(MinimapName, ldb_icon, Octo_ToDo_DB_Vars.minimap_SECOND)
		ldbi:Show(MinimapName)
	end
	if event == "PLAYER_STARTED_MOVING" and not InCombatLockdown() then
		if Octo_ToDo_SECOND_Frame_Main_Frame and Octo_ToDo_SECOND_Frame_Main_Frame:IsShown() then Octo_ToDo_SECOND_Frame_Main_Frame:SetAlpha(E.Octo_Globals.BGALPHA*5) end
	end
	if event == "PLAYER_STOPPED_MOVING" then
		if Octo_ToDo_SECOND_Frame_Main_Frame then Octo_ToDo_SECOND_Frame_Main_Frame:SetAlpha(1) end
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
