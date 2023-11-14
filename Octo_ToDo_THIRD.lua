local GlobalAddonName, E =...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonNotes = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Notes")
local AddonAuthor = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Author")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local GBI_version, GBI_build, GBI_date, GBI_tocversion, GBI_localizedVersion, GBI_buildType = GetBuildInfo()
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local lsfdd = LibStub("LibSFDropDown-1.4")
local SHOWADDON_THIRD = false
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
local Button = nil
local CF = nil
local Octo_ToDo_THIRD_Frame_Char_Frame = nil
local Octo_ToDo_THIRD_Frame_EventFrame = nil
local inspectScantipTHIRD = nil
local Octo_ToDo_THIRD_Frame_Main_Frame = nil
local Octo_ToDo_THIRD_Frame_UPGRADERANKS_Frame = nil
local Octo_ToDo_THIRD_Frame_Close_Button = nil
local Octo_ToDo_THIRD_Frame_Options_Button = nil
local Octo_ToDo_THIRD_Frame_MarkOfHonor_Button = nil
local Octo_ToDo_THIRD_Frame_QuestFeast_Button = nil
local Octo_ToDo_THIRD_Frame_AbandonAllQuests_Button = nil
local Octo_ToDo_THIRD_Frame_Char_FrameDeleteButton = nil
local className, classFilename, classId = UnitClass("PLAYER")
local classColor = C_ClassColor.GetClassColor(classFilename)
local r, g, b = classColor:GetRGB()
local englishFaction, localizedFaction = UnitFactionGroup("PLAYER")
local classColorHexCurrent = E.Octo_Func.func_rgb2hex(r, g, b)
local Horde_Icon = E.Octo_Func.func_texturefromIcon(132485)
local Alliance_Icon = E.Octo_Func.func_texturefromIcon(132486)
local Kyrian_Icon = E.Octo_Func.func_texturefromIcon(3257748)
local Necrolord_Icon = E.Octo_Func.func_texturefromIcon(3257749)
local NightFae_Icon = E.Octo_Func.func_texturefromIcon(3257750)
local Venthyr_Icon = E.Octo_Func.func_texturefromIcon(3257751)
local WorldBoss_Icon = E.Octo_Func.func_texturefromIcon(3528312)
local Rares_Icon = E.Octo_Func.func_texturefromIcon(135903)
local Unknown_Icon = E.Octo_Func.func_texturefromIcon(134400)
local Token_Icon = E.Octo_Func.func_texturefromIcon(1120721)
local Money_Icon = E.Octo_Func.func_texturefromIcon(133784, 12)
local MailBox_Icon = E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/ElvUI/Mail0.tga")
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
local TotalTransAnima = 0
local TotalTransParacausalFlakes = 0
local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
local regionalWeeklyStart = 1668981600
local edgeFile = "Interface\\Buttons\\WHITE8X8"
local bgFile = "Interface\\Buttons\\WHITE8X8"
local AddonTexture_THIRD = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\AddonTexture_THIRD.tga"
local SHIRINA = E.Octo_Globals.curWidthCentral
local OctoTable_func_otrisovka_THIRD = {}
function Octo_ToDo_THIRD_OnLoad()
	if not Octo_ToDo_THIRD_Frame_EventFrame then
		Octo_ToDo_THIRD_Frame_EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
	end
	Octo_ToDo_THIRD_Frame_EventFrame:RegisterEvent("VARIABLES_LOADED")
	Octo_ToDo_THIRD_Frame_EventFrame:RegisterEvent("PLAYER_LOGIN")
	Octo_ToDo_THIRD_Frame_EventFrame:SetScript("OnEvent", function(...)
			Octo_ToDo_THIRD_OnEvent(...)
	end)
end
function O_otrisovka_THIRD()
	tinsert(OctoTable_func_otrisovka_THIRD,
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
	-- for k, v in pairs (E.Octo_Table.OctoTable_Expansions_Table) do
	-- 	tinsert(OctoTable_func_otrisovka_THIRD,
	-- 		function(CharInfo, tooltip, CL, BG)
	-- 			local vivodCent, vivodLeft = "", ""
	-- 			vivodLeft = v
	-- 			local color = E.Octo_Func.GenerateUnique_Color()
	-- 			vivodCent = "|cff"..tostringall(color)..color.."|r"
	-- 			return vivodCent, vivodLeft
	-- 	end)
	-- end
	if Octo_ToDo_DB_Vars.config.AchievementToShow ~= 0 then
		local categoryID = Octo_ToDo_DB_Vars.config.AchievementToShow
		local total = GetCategoryNumAchievements(categoryID, true)
		if total then
			for i = 1, total do
				local AchievementID, name, points, completedAchi, _, _, _, _, _, icon = GetAchievementInfo(categoryID, i)
				if AchievementID then
					if completedAchi == false or (completedAchi == Octo_ToDo_DB_Vars.config.AchievementShowCompleted) then
						tinsert(OctoTable_func_otrisovka_THIRD,
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
----------------------------------------------------------------
------------------------ BACKGROUND ----------------------------
----------------------------------------------------------------
local ObjectPool_BACKGROUND_THIRD = CreateFromMixins(ObjectPoolMixin)
do
	local function FrameLine_OnEnter(self)
		self.BG:SetColorTexture(r, g, b, E.Octo_Globals.BGALPHA*2)
		Octo_ToDo_THIRD_Frame_Main_Frame:SetAlpha(1)
	end
	local function FrameLine_OnLeave(self)
		self.BG:SetColorTexture(0, 0, 0, 0)
	end
	local function ObjectPool_BACKGROUND_THIRD_creationFunc()
		local f = CreateFrame("Frame", nil, Octo_ToDo_THIRD_Frame_Main_Frame.scrollChild, "BackdropTemplate")
		f:SetHeight(E.Octo_Globals.curHeight)
		f:SetScript("OnEnter", FrameLine_OnEnter)
		f:SetScript("OnLeave", FrameLine_OnLeave)
		f:SetMouseClickEnabled(false)
		f.BG = f:CreateTexture(nil, "BACKGROUND")
		f.BG:SetAllPoints()
		return f
	end
	local function ObjectPool_BACKGROUND_THIRD_resetterFunc(self, frame)
		frame:Hide()
		frame:ClearAllPoints()
	end
	ObjectPool_BACKGROUND_THIRD:OnLoad(ObjectPool_BACKGROUND_THIRD_creationFunc, ObjectPool_BACKGROUND_THIRD_resetterFunc)
	ObjectPool_BACKGROUND_THIRD:SetResetDisallowedIfNew(true)
end
----------------------------------------------------------------
------------------------ FontString ----------------------------
----------------------------------------------------------------
local ObjectPool_FontString_THIRD = CreateFromMixins(ObjectPoolMixin)
do
	local function ObjectPool_FontString_THIRD_creationFunc()
		local f = Octo_ToDo_THIRD_Frame_Main_Frame.scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		f:SetSize(E.Octo_Globals.curWidthTitle, E.Octo_Globals.curHeight)
		f:SetFontObject(OctoFont11)
		f:SetJustifyV("MIDDLE")
		f:SetJustifyH("LEFT")
		f:SetTextColor(1, 1, 1, 1)
		return f
	end
	local function ObjectPool_FontString_THIRD_resetterFunc(self, frame)
		frame:Hide()
		frame:ClearAllPoints()
	end
	ObjectPool_FontString_THIRD:OnLoad(ObjectPool_FontString_THIRD_creationFunc, ObjectPool_FontString_THIRD_resetterFunc)
	ObjectPool_FontString_THIRD:SetResetDisallowedIfNew(true)
end
local function AltFrame_Update_Lines()
	----------------------------------------------------------------
	-- РЕЛИЗЫ
	ObjectPool_BACKGROUND_THIRD:ReleaseAll()
	ObjectPool_FontString_THIRD:ReleaseAll()
	for i = 1, #OctoTable_func_otrisovka_THIRD do
		local fname, f
		fname = "FrameLine"..i
		Octo_ToDo_THIRD_Frame_Main_Frame[fname] = ObjectPool_BACKGROUND_THIRD:Acquire()
		f = Octo_ToDo_THIRD_Frame_Main_Frame[fname]
		f:Show()
		f:SetPoint("TOPLEFT", Octo_ToDo_THIRD_Frame_Main_Frame.scrollChild, "TOPLEFT", 0, -E.Octo_Globals.curHeight*(i-1))
		f:SetPoint("RIGHT")
		fname = "TextLeft"..i
		Octo_ToDo_THIRD_Frame_Main_Frame[fname] = ObjectPool_FontString_THIRD:Acquire()
		f = Octo_ToDo_THIRD_Frame_Main_Frame[fname]
		f:Show()
		f:SetPoint("TOPLEFT", Octo_ToDo_THIRD_Frame_Main_Frame.scrollChild, "TOPLEFT", 6, -E.Octo_Globals.curHeight*(i-1))
	end
	-- Octo_ToDo_THIRD_AddDataToAltFrame()
	----------------------------------------------------------------
end
function Octo_ToDo_THIRD_CreateAltFrame()
	if not Octo_ToDo_THIRD_Frame_Main_Frame then
		Octo_ToDo_THIRD_Frame_Main_Frame = CreateFrame("BUTTON", "Octo_ToDo_THIRD_Frame_Main_FramePIZDA", UIParent, "BackdropTemplate")
		Octo_ToDo_THIRD_Frame_Main_Frame:Hide()
	end
	local ScrollFrame = CreateFrame("ScrollFrame", "ScrollFrame"..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_THIRD_Frame_Main_Frame)
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
	Octo_ToDo_THIRD_Frame_Main_Frame.scrollChild = scrollChild
	Octo_ToDo_THIRD_Frame_Main_Frame.ScrollBar = ScrollBar
	Octo_ToDo_THIRD_Frame_Main_Frame:SetClampedToScreen(false)
	Octo_ToDo_THIRD_Frame_Main_Frame:SetFrameStrata("HIGH")
	Octo_ToDo_THIRD_Frame_Main_Frame:SetPoint("TOP", 0, -257*E.Octo_Globals.scale)
	Octo_ToDo_THIRD_Frame_Main_Frame:SetBackdrop({
			bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	Octo_ToDo_THIRD_Frame_Main_Frame:SetBackdropColor(E.Octo_Globals.bgCr, E.Octo_Globals.bgCg, E.Octo_Globals.bgCb, E.Octo_Globals.bgCa)
	Octo_ToDo_THIRD_Frame_Main_Frame:SetBackdropBorderColor(0, 0, 0, 1)
	Octo_ToDo_THIRD_Frame_Main_Frame:SetScript("OnShow", function()
			Octo_ToDo_THIRD_AddDataToAltFrame()
	end)
	Octo_ToDo_THIRD_Frame_Main_Frame:EnableMouse(true)
	Octo_ToDo_THIRD_Frame_Main_Frame:SetMovable(true)
	Octo_ToDo_THIRD_Frame_Main_Frame:RegisterForDrag("LeftButton")
	Octo_ToDo_THIRD_Frame_Main_Frame:SetScript("OnDragStart", Octo_ToDo_THIRD_Frame_Main_Frame.StartMoving)
	Octo_ToDo_THIRD_Frame_Main_Frame:SetScript("OnDragStop", function() Octo_ToDo_THIRD_Frame_Main_Frame:StopMovingOrSizing() end)
	Octo_ToDo_THIRD_Frame_Main_Frame:RegisterForClicks("RightButtonUp")
	Octo_ToDo_THIRD_Frame_Main_Frame:SetScript("OnClick", function(self) self:Hide() end)
	if not Octo_ToDo_THIRD_Frame_Close_Button then
		Octo_ToDo_THIRD_Frame_Close_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_THIRD_Frame_Main_Frame, "BackDropTemplate")
		Octo_ToDo_THIRD_Frame_Close_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		Octo_ToDo_THIRD_Frame_Close_Button:SetPoint("BOTTOMRIGHT", Octo_ToDo_THIRD_Frame_Main_Frame, "TOPRIGHT", E.Octo_Globals.curHeight, 1)
		Octo_ToDo_THIRD_Frame_Close_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		Octo_ToDo_THIRD_Frame_Close_Button:SetBackdropBorderColor(1, 0, 0, 0)
		Octo_ToDo_THIRD_Frame_Close_Button:SetScript("OnEnter", function(self)
				self.icon:SetVertexColor(1, 0, 0, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(CLOSE)
				GameTooltip:Show()
		end)
		Octo_ToDo_THIRD_Frame_Close_Button:SetScript("OnLeave", function(self)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		Octo_ToDo_THIRD_Frame_Close_Button:SetScript("OnMouseDown", function(self)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		Octo_ToDo_THIRD_Frame_Close_Button:SetScript("OnClick", function()
				Octo_ToDo_THIRD_Frame_Main_Frame:Hide()
		end)
		local t = Octo_ToDo_THIRD_Frame_Close_Button:CreateTexture(nil, "BACKGROUND")
		Octo_ToDo_THIRD_Frame_Close_Button.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\CloseTest.tga")
		t:SetAllPoints(Octo_ToDo_THIRD_Frame_Close_Button)
		Octo_ToDo_THIRD_Frame_Close_Button:SetScript("OnKeyDown", function(self, key)
				if key == GetBindingKey("TOGGLEGAMEMENU") then
					self:GetParent():Hide()
					self:SetPropagateKeyboardInput(false)
				else
					self:SetPropagateKeyboardInput(true)
				end
		end)
	end
	if not dd then
		local dd = lsfdd:CreateStretchButtonOriginal(Octo_ToDo_THIRD_Frame_Main_Frame, 160, 22)
		dd:SetPoint("BOTTOMLEFT", Octo_ToDo_THIRD_Frame_Main_Frame, "TOPLEFT", 0, 2)
		local function selectFunctionAchievementToShow(menuButton)
			Octo_ToDo_DB_Vars.config.AchievementToShow = menuButton.value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end
		dd:SetText(ACHIEVEMENT_TITLE.." "..E.Octo_Globals.Green_Color..GetTotalAchievementPoints(false).."|r")
		dd:ddSetDisplayMode(GlobalAddonName)
		dd:ddSetInitFunc(function(self, level, value)
				local info = {}
				local categories = GetCategoryList()
				local categoryID
				local name, parentCategoryID, total, completed
				for i = 1, #categories do
					categoryID = categories[i]
					name, parentCategoryID = GetCategoryInfo(categoryID)
					total, completed = GetCategoryNumAchievements(categoryID, true)
					local vivod = " ("..completed.."/"..total..")"
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
						info.text = name ..vivod
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
	AltFrame_Update_Lines()
	Octo_ToDo_THIRD_Frame_Main_Frame:Hide()
end
----------------------------------------------------------------
------------------------ CENTERLINES ---------------------------
----------------------------------------------------------------
local ObjectPool_CENTERLINES_THIRD = CreateFromMixins(ObjectPoolMixin)
do
	local function Central_Frame_Mouse_OnEnter(self)
		local parent = Octo_ToDo_THIRD_Frame_Main_Frame["FrameLine"..self.index]
		parent:GetScript("OnEnter")(parent)
		if not self.tooltip then
			return
		end
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
		local parent = Octo_ToDo_THIRD_Frame_Main_Frame["FrameLine"..self.index]
		parent:GetScript("OnLeave")(parent)
		GameTooltip:Hide()
	end
	local function ObjectPool_CENTERLINES_THIRD_creationFunc()
		-- print (Octo_ToDo_THIRD_Frame_Char_Frame, "OnShow")
		local CF = CreateFrame("Button", nil, Octo_ToDo_THIRD_Frame_Char_Frame)
		CF:SetSize(SHIRINA, E.Octo_Globals.curHeight)
		CF:SetScript("OnEnter", Central_Frame_Mouse_OnEnter)
		CF:SetScript("OnLeave", Central_Frame_Mouse_OnLeave)
		CF:SetMouseClickEnabled(false)
		local CL = CF:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		CL:SetAllPoints()
		CL:SetFontObject(OctoFont11)
		CL:SetJustifyV("MIDDLE")
		CL:SetJustifyH("CENTER")
		CL:SetTextColor(1, 1, 1, 1)
		CF.CL = CL
		return CF
	end
	local function ObjectPool_CENTERLINES_THIRD_resetterFunc(self, frame)
		frame:Hide()
		frame:ClearAllPoints()
	end
	ObjectPool_CENTERLINES_THIRD:OnLoad(ObjectPool_CENTERLINES_THIRD_creationFunc, ObjectPool_CENTERLINES_THIRD_resetterFunc)
	ObjectPool_CENTERLINES_THIRD:SetResetDisallowedIfNew(true)
end
----------------------------------------------------------------
------------------------ CENTERLINES_BACKGROUND ----------------
----------------------------------------------------------------
local ObjectPool_CENTERLINES_BACKGROUND_THIRD = CreateFromMixins(ObjectPoolMixin)
do
	local function ObjectPool_CENTERLINES_BACKGROUND_THIRD_creationFunc()
		local f = Octo_ToDo_THIRD_Frame_Char_Frame:CreateTexture(nil, "BACKGROUND")
		-- f:SetColorTexture(r, g, b, 0)
		return f
	end
	local function ObjectPool_CENTERLINES_BACKGROUND_THIRD_resetterFunc(self, frame)
		frame:Hide()
		frame:ClearAllPoints()
	end
	ObjectPool_CENTERLINES_BACKGROUND_THIRD:OnLoad(ObjectPool_CENTERLINES_BACKGROUND_THIRD_creationFunc, ObjectPool_CENTERLINES_BACKGROUND_THIRD_resetterFunc)
	ObjectPool_CENTERLINES_BACKGROUND_THIRD:SetResetDisallowedIfNew(true)
end
local function CreateCentralLines(Main_Frame, curCharGUID)
	Octo_ToDo_THIRD_Frame_Main_Frame[curCharGUID] = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."Octo_ToDo_THIRD_Frame_Main_Frame[curCharGUID]", Octo_ToDo_THIRD_Frame_Main_Frame.scrollChild, "BackdropTemplate")
	Octo_ToDo_THIRD_Frame_Char_Frame = Octo_ToDo_THIRD_Frame_Main_Frame[curCharGUID]
	Octo_ToDo_THIRD_Frame_Char_Frame:SetPoint("BOTTOM", 0, 0)
	Octo_ToDo_THIRD_Frame_Char_Frame.BG = Octo_ToDo_THIRD_Frame_Char_Frame:CreateTexture(nil, "BACKGROUND")
	Octo_ToDo_THIRD_Frame_Char_Frame.BG:Hide()
	Octo_ToDo_THIRD_Frame_Char_Frame.BG:SetPoint("TOPLEFT", 0, -E.Octo_Globals.curHeight)
	Octo_ToDo_THIRD_Frame_Char_Frame.BG:SetPoint("BOTTOMRIGHT", 0, 0)
	Octo_ToDo_THIRD_Frame_Char_Frame.BG:SetColorTexture(r, g, b, 1)
	for index = 1, #OctoTable_func_otrisovka_THIRD do
		-- ФРЕЙМ ЦЕНТАРЛЬНЫЙ
		local CF = ObjectPool_CENTERLINES_THIRD:Acquire()
		Octo_ToDo_THIRD_Frame_Char_Frame["CenterLines"..index] = CF
		CF:Show()
		CF.index = index
		CF:SetPoint("TOP", Octo_ToDo_THIRD_Frame_Char_Frame, "TOP", 0, -E.Octo_Globals.curHeight*(index-1))
		-- CENTERLINES_BACKGROUND
		Octo_ToDo_THIRD_Frame_Char_Frame["CenterLines"..index.."BG"] = ObjectPool_CENTERLINES_BACKGROUND_THIRD:Acquire()
		Octo_ToDo_THIRD_Frame_Char_Frame["CenterLines"..index.."BG"]:Show()
		Octo_ToDo_THIRD_Frame_Char_Frame["CenterLines"..index.."BG"]:SetAllPoints(Octo_ToDo_THIRD_Frame_Char_Frame["CenterLines"..index])
	end
end
function Octo_ToDo_THIRD_AddDataToAltFrame()
	print ("Octo_ToDo_THIRD_AddDataToAltFrame")
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER")
	local ShowOnlyCurrentRealm = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm
	local LevelToShow = Octo_ToDo_DB_Vars.config.LevelToShow
	local itemLevelToShow = Octo_ToDo_DB_Vars.config.itemLevelToShow
	Octo_ToDo_THIRD_Frame_Main_Frame.AllCharFrames = {}
	local sorted = {}
	for curCharGUID, CharInfo in pairs(Octo_ToDo_DB_Levels) do
		if ((ShowOnlyCurrentRealm == true and (CharInfo.curServer == GetRealmName())) and (CharInfo.avgItemLevel >= itemLevelToShow) and (CharInfo.UnitLevel >= Octo_ToDo_DB_Vars.config.LevelToShow) and (CharInfo.UnitLevel <= Octo_ToDo_DB_Vars.config.LevelToShowMAX))
			or (ShowOnlyCurrentRealm == false and (CharInfo.avgItemLevel >= itemLevelToShow) and (CharInfo.UnitLevel >= Octo_ToDo_DB_Vars.config.LevelToShow) and (CharInfo.UnitLevel <= Octo_ToDo_DB_Vars.config.LevelToShowMAX))
			or (curGUID == CharInfo.GUID) then
			sorted[#sorted+1] = CharInfo
		end
	end
	sort(sorted, function(a, b)
			if a and b then
				return
				a.curServer < b.curServer or a.curServer == b.curServer
				and
				a.UnitLevel < b.UnitLevel or a.UnitLevel == b.UnitLevel
				and
				a.avgItemLevel < b.avgItemLevel or a.avgItemLevel == b.avgItemLevel
				and
				b.Name < a.Name
			end
	end)
	----------------------------------------------------------------
	-- РЕЛИЗЫ
	ObjectPool_CENTERLINES_THIRD:ReleaseAll()
	ObjectPool_CENTERLINES_BACKGROUND_THIRD:ReleaseAll()
	for i, CharInfo in pairs(sorted) do
			local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
			local curCharGUID = CharInfo.GUID
			-- if not Octo_ToDo_THIRD_Frame_Main_Frame[curCharGUID] then
			CreateCentralLines(Octo_ToDo_THIRD_Frame_Main_Frame, curCharGUID)
			-- else
			-- 	Octo_ToDo_THIRD_Frame_Char_Frame = Octo_ToDo_THIRD_Frame_Main_Frame[curCharGUID]
			-- end
			Octo_ToDo_THIRD_Frame_Char_Frame:SetSize(SHIRINA, E.Octo_Globals.curHeight)
			if #Octo_ToDo_THIRD_Frame_Main_Frame.AllCharFrames == 0 then
				Octo_ToDo_THIRD_Frame_Char_Frame:SetPoint("TOPRIGHT", 0, 0)
			else
				Octo_ToDo_THIRD_Frame_Char_Frame:SetPoint("TOPRIGHT", Octo_ToDo_THIRD_Frame_Main_Frame.AllCharFrames[#Octo_ToDo_THIRD_Frame_Main_Frame.AllCharFrames], "TOPLEFT", 0, 0)
			end
			Octo_ToDo_THIRD_Frame_Main_Frame.AllCharFrames[#Octo_ToDo_THIRD_Frame_Main_Frame.AllCharFrames + 1] = Octo_ToDo_THIRD_Frame_Char_Frame
			if curGUID == curCharGUID then
				Octo_ToDo_THIRD_Frame_Char_Frame.BG:Show()
				Octo_ToDo_THIRD_Frame_Char_Frame.BG:SetAlpha(E.Octo_Globals.BGALPHA)
			end
			for i = 1, #OctoTable_func_otrisovka_THIRD do
				local TEXTLEFT = Octo_ToDo_THIRD_Frame_Main_Frame["TextLeft"..i]
				local TEXTCENT = Octo_ToDo_THIRD_Frame_Char_Frame["CenterLines"..i]
				local BG = Octo_ToDo_THIRD_Frame_Char_Frame["CenterLines"..i.."BG"]
				TEXTCENT.tooltip = {}
				local vivodCent = " "
				local vivodLeft = " "
				vivodCent, vivodLeft = OctoTable_func_otrisovka_THIRD[i](CharInfo, TEXTCENT.tooltip, TEXTCENT.CL, BG)
				TEXTLEFT:SetText(vivodLeft or "leftText")
				TEXTCENT.CL:SetText(vivodCent or "centText")
				if #TEXTCENT.tooltip == 0 or #TEXTCENT.tooltip[1] == 0 then
					TEXTCENT.tooltip = nil
				end
			end
			local curAltFrameWidth = #Octo_ToDo_THIRD_Frame_Main_Frame.AllCharFrames * SHIRINA/2
			local width = curAltFrameWidth*2+E.Octo_Globals.curWidthTitle
			local height = E.Octo_Globals.curHeight*(#OctoTable_func_otrisovka_THIRD)
			Octo_ToDo_THIRD_Frame_Main_Frame.scrollChild:SetSize(width, height)
			if height > E.Octo_Globals.Addon_Height then
				height = E.Octo_Globals.Addon_Height
				Octo_ToDo_THIRD_Frame_Main_Frame.ScrollBar:Show()
			else
				Octo_ToDo_THIRD_Frame_Main_Frame.ScrollBar:Hide()
			end
			Octo_ToDo_THIRD_Frame_Main_Frame:SetSize(width, height)
	end
end
function Octo_ToDo_THIRD_OnEvent(self, event, ...)
	if event == "VARIABLES_LOADED" and not InCombatLockdown() then
		SHOWADDON_THIRD = Octo_ToDo_DB_Vars.config.THIRD
		if SHOWADDON_THIRD == false then
			Octo_ToDo_THIRD_Frame_EventFrame:UnregisterAllEvents()
			return
		end
		local MinimapName = GlobalAddonName.."Octo_ToDo_THIRD_Minimap"
		local ldb_icon = ldb:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = AddonTexture_THIRD,
				OnClick = function(_, button)
					if button == "LeftButton" then
						if not InCombatLockdown() then
							if Octo_ToDo_FIRST_Frame_Main_FramePIZDA and Octo_ToDo_FIRST_Frame_Main_FramePIZDA:IsShown() then
								Octo_ToDo_FIRST_Frame_Main_FramePIZDA:Hide()
							end
							if Octo_ToDo_SECOND_Frame_Main_FramePIZDA and Octo_ToDo_SECOND_Frame_Main_FramePIZDA:IsShown() then
								Octo_ToDo_SECOND_Frame_Main_FramePIZDA:Hide()
							end
							Octo_ToDo_THIRD_Frame_Main_Frame:SetShown(not Octo_ToDo_THIRD_Frame_Main_Frame:IsShown())
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
					GameTooltip_SetTitle(GameTooltip, E.Octo_Func.func_Gradient(GlobalAddonName.." THIRD", "|cff"..tostringall(E.Octo_Func.GenerateUnique_Color()), "|cff"..tostringall(E.Octo_Func.GenerateUnique_Color()) ))
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDo_DB_Vars.minimap_THIRD = Octo_ToDo_DB_Vars.minimap_THIRD or {}
		Octo_ToDo_DB_Vars.minimap_THIRD.minimapPos = Octo_ToDo_DB_Vars.minimap_THIRD.minimapPos or 284
		Octo_ToDo_DB_Vars.config.AddonVersion = tonumber(AddonVersion)
		ldbi:Register(MinimapName, ldb_icon, Octo_ToDo_DB_Vars.minimap_THIRD)
		ldbi:Show(MinimapName)
	end
	if event == "PLAYER_LOGIN" and not InCombatLockdown() and SHOWADDON_THIRD == true then
		C_Timer.After(2, function()
				O_otrisovka_THIRD()
				Octo_ToDo_THIRD_CreateAltFrame()
		end)
	end
end
Octo_ToDo_THIRD_OnLoad()