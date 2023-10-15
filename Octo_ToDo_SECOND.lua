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
--------------------------------
local SHOWADDON = false
--------------------------------
local Button = nil
local CF = nil
local Octo_ToDo_SECOND_Frame_Char_Frame = nil
local Octo_ToDo_SECOND_Frame_EventFrame = nil
local inspectScantip = nil
local Octo_ToDo_SECOND_Frame_Main_Frame = nil
local Octo_ToDo_SECOND_Frame_UPGRADERANKS_Frame = nil
local Octo_ToDo_SECOND_Frame_Close_Button = nil
local Octo_ToDo_SECOND_Frame_Options_Button = nil
local Octo_ToDo_SECOND_Frame_MarkOfHonor_Button = nil
local Octo_ToDo_SECOND_Frame_QuestFeast_Button = nil
local Octo_ToDo_SECOND_Frame_AbandonAllQuests_Button = nil
local Octo_ToDo_SECOND_Frame_Char_FrameDeleteButton = nil
--------------------------------
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
local fontObject9 = CreateFont("OctoFont9")
fontObject9:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 9, "OUTLINE")
local fontObject10 = CreateFont("OctoFont10")
fontObject10:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 10, "OUTLINE")
local fontObject11 = CreateFont("OctoFont11")
fontObject11:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 11, "OUTLINE")
local fontObject12 = CreateFont("OctoFont12")
fontObject12:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 12, "OUTLINE")
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
-- local E.Octo_Globals.NONE = E.Octo_Globals.Gray_Color.."None|r"
-- local E.Octo_Globals.DONE = E.Octo_Globals.Green_Color.."Done|r"
local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
local regionalWeeklyStart = 1668981600
local bgCr, bgCg, bgCb, bgCa = 14/255, 14/255, 14/255, 0.8
local edgeFile = "Interface\\Buttons\\WHITE8X8"
local bgFile = "Interface\\Buttons\\WHITE8X8"
local AddonTexture_SECOND = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\AddonTexture_SECOND.tga"
--------------------------------
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
local function func_Octo_ToDo_SECOND_Frame_TEST_Button()
	-- -- Берегов Пробуждения
	-- TomTom:AddWaypoint(2022, 74.16/100, 57.18/100)
	-- TomTom:AddWaypoint(2022, 60.71/100, 66.97/100)
	-- TomTom:AddWaypoint(2022, 51.60/100, 20.05/100)
	-- TomTom:AddWaypoint(2022, 26.18/100, 56.33/100)
	-- TomTom:AddWaypoint(2022, 24.41/100, 53.38/100)
	-- TomTom:AddWaypoint(2022, 28.79/100, 72.46/100)
	-- TomTom:AddWaypoint(2022, 27.88/100, 68.34/100)
	-- TomTom:AddWaypoint(2022, 24.06/100, 69.19/100)
	-- -- равнин Он'ары
	-- TomTom:AddWaypoint(2023, 67.03/100, 43.70/100)
	-- TomTom:AddWaypoint(2023, 43.51/100, 56.54/100)
	-- TomTom:AddWaypoint(2023, 38.64/100, 66.71/100)
	-- TomTom:AddWaypoint(2023, 24.73/100, 65.82/100)
	-- TomTom:AddWaypoint(2023, 32.26/100, 51.41/100)
	-- -- Лазурного Простора
	-- TomTom:AddWaypoint(2024, 7.99/100, 45.61/100)
	-- TomTom:AddWaypoint(2024, 60.32/100, 49.76/100)
	-- TomTom:AddWaypoint(2024, 56.74/100, 70.30/100)
	-- TomTom:AddWaypoint(2024, 66.42/100, 61.02/100)
	-- TomTom:AddWaypoint(2024, 77.44/100, 31.08/100)
	-- -- Тальдразуса
	-- TomTom:AddWaypoint(2025, 60.05/100, 84.91/100)
	-- TomTom:AddWaypoint(2112, 57.00/100, 81.47/100)
	-- TomTom:AddWaypoint(2025, 42.78/100, 70.41/100)
	-- TomTom:AddWaypoint(2025, 58.41/100, 67.77/100)
	-- TomTom:AddWaypoint(2025, 58.14/100, 58.09/100)
	-- TomTom:AddWaypoint(2025, 52.36/100, 38.69/100)
	-- TomTom:AddWaypoint(2025, 62.38/100, 15.87/100)
	-- -- Заралека
	-- TomTom:AddWaypoint(2133, 47.38/100, 48.55/100)
	-- TomTom:AddWaypoint(2133, 43.28/100, 23.72/100)
	-- TomTom:AddWaypoint(2133, 61.25/100, 71.81/100)
	-- TomTom:AddWaypoint(2022, 39.75/100, 55.03/100)-- Mammoth-Tamer Tavok
	-- TomTom:AddWaypoint(2022, 33.28/100, 72.19/100)-- Burning Ascent Tame Magmammoth
	-- TomTom:AddWaypoint(2022, 23.63/100, 71.49/100)-- Dragonbane Keep Tame Magmammoth
	-- TomTom:AddWaypoint(2022, 37.20/100, 44.51/100)-- Smoldering Perch Tame Magmammoth
	-- TomTom:AddWaypoint(2022, 66.29/100, 24.56/100)-- Scalecracker Keep Tame Magmammoth
	-- TomTom:AddWaypoint(2023, 29.79/100, 62.22/100,{title = "Erezsra"}) --Erezsra
	-- TomTom:AddWaypoint(2023, 29.69/100, 60.22/100,{title = "Erezsra entrance"}) --Erezsra entrance
	-- TomTom:AddWaypoint(2023, 25.25/100, 65.27/100,{title = "Sayliasra"}) --Sayliasra
	-- TomTom:AddWaypoint(2023, 19.12/100, 82.96/100,{title = "Lucidra"}) --Lucidra
	-- TomTom:AddWaypoint(2023, 18.12/100, 53.88/100,{title = "Aiyelasra"}) --Aiyelasra
	-- TomTom:AddWaypoint(2023, 29.43/100, 41.38/100,{title = "Taelyasra"}) --Taelyasra
	-- TomTom:AddWaypoint(2023, 33.55/100, 53.22/100,{title = "Felyasra"}) --Felyasra
	--Сбрасывай бомбу!
	TomTom:AddWaypoint(108, 69.00/100, 75.00/100)
	TomTom:AddWaypoint(108, 71.00/100, 78.00/100)
	TomTom:AddWaypoint(108, 70.00/100, 79.00/100)
	TomTom:AddWaypoint(108, 66.00/100, 78.00/100)
	TomTom:AddWaypoint(108, 62.00/100, 80.00/100)
	TomTom:AddWaypoint(108, 62.00/100, 78.00/100)
	TomTom:AddWaypoint(108, 61.00/100, 75.00/100)
	TomTom:AddWaypoint(108, 62.00/100, 73.00/100)
	TomTom:AddWaypoint(108, 73.10/100, 83.03/100)
	TomTom:AddWaypoint(108, 73.69/100, 80.65/100)
	TomTom:AddWaypoint(108, 75.54/100, 80.06/100)
	TomTom:AddWaypoint(108, 75.22/100, 86.41/100)
	TomTom:AddWaypoint(108, 74.78/100, 88.52/100)
	TomTom:AddWaypoint(108, 72.49/100, 88.80/100)
	TomTom:AddWaypoint(108, 69.98/100, 74.77/100)
	TomTom:AddWaypoint(108, 75.98/100, 81.03/100)
	TomTom:AddWaypoint(108, 74.18/100, 83.90/100)
	TomTom:AddWaypoint(108, 68.58/100, 73.91/100)
	TomTom:AddWaypoint(108, 71.44/100, 81.93/100)
	TomTom:AddWaypoint(108, 73.10/100, 83.03/100)
	TomTom:AddWaypoint(108, 73.69/100, 80.65/100)
	TomTom:AddWaypoint(108, 74.74/100, 88.55/100)
	TomTom:AddWaypoint(108, 70.73/100, 84.61/100)
	TomTom:AddWaypoint(108, 67.94/100, 79.48/100)
	TomTom:AddWaypoint(108, 61.16/100, 79.58/100)
	TomTom:AddWaypoint(108, 60.74/100, 75.55/100)
	TomTom:AddWaypoint(108, 61.53/100, 73.39/100)
end
function Collect_All_Pois()
	if Octo_ToDoVars.config.Octo_debug_Function_SECOND == true then
		ChatFrame1.AddMessage(E.Octo_Globals.Function_Color.."Collect_All_Pois()".."|r")
	end
	Octo_ToDo_SmartCollectNEW.Pois = {}
	local DF_MAP_LIST = {
		2022,
		2023,
		2024,
		2025,
	}
	for _, mapID in ipairs(DF_MAP_LIST) do
		local pois = C_AreaPoiInfo.GetAreaPOIForMap(mapID)
		if #pois ~= 0 then
			for i=1, #pois do
				local poiData = C_AreaPoiInfo.GetAreaPOIInfo(mapID, pois[i])
				-- if poiData and type(poiData.atlasName) == "string" then
				-- if poiData and type(poiData.atlasName) == "string" and (poiData.atlasName:find("^ElementalStorm") or poiData.atlasName == "racing") then
				if poiData and type(poiData.atlasName) == "string" and (poiData.atlasName:find("^ElementalStorm")) then
					Octo_ToDo_SmartCollectNEW.Pois[i] = Octo_ToDo_SmartCollectNEW.Pois[i] or {}
					Octo_ToDo_SmartCollectNEW.Pois[i].mapID = mapID
					Octo_ToDo_SmartCollectNEW.Pois[i].atlasName = poiData.atlasName
					Octo_ToDo_SmartCollectNEW.Pois[i].name = poiData.name
					Octo_ToDo_SmartCollectNEW.Pois[i].description = poiData.description
				end
			end
		end
	end
end
function Collect_NEW_Achievement()
	if Octo_ToDoVars.config.Octo_debug_Function_SECOND == true then
		ChatFrame1.AddMessage(E.Octo_Globals.Function_Color.."Collect_NEW_Achievement()".."|r")
	end
	----------------------------------------------------------------
	-- Octo_ToDo_Achievement = {} -- ЧИСТКА
	----------------------------------------------------------------
	for k, categoryID in ipairs(GetCategoryList()) do
		local total, completed, incompleted = GetCategoryNumAchievements(categoryID, true)
		local title, parentCategoryID = GetCategoryInfo(categoryID)
		local pizda = completed.."/"..total
		-- " ("..completed.."/"..total..")"
		if total == completed then
				pizda = E.Octo_Globals.DONE
		else
			if completed == 0 then
				pizda = E.Octo_Globals.Red_Color..pizda.."|r"
			else
				pizda = E.Octo_Globals.Yellow_Color..pizda.."|r"
			end
		end
		Octo_ToDo_Achievement[title] = Octo_ToDo_Achievement[title] or {}
		Octo_ToDo_Achievement[title].title = title
		Octo_ToDo_Achievement[title].categoryID = categoryID
		Octo_ToDo_Achievement[title].parentCategoryID = parentCategoryID
		Octo_ToDo_Achievement[title].pizda = pizda or ""

		for i=1, total do
			local AchievementID, name, points, completedAchi, _, _, _, _, _, icon = GetAchievementInfo(categoryID, i)
			if AchievementID then
				Octo_ToDo_Achievement[title].AchievementID = Octo_ToDo_Achievement[title].AchievementID or {}
				Octo_ToDo_Achievement[title].AchievementID[AchievementID] = Octo_ToDo_Achievement[title].AchievementID[AchievementID] or {}
				Octo_ToDo_Achievement[title].AchievementID[AchievementID].name = E.Octo_Func.func_achievementName(AchievementID)
				Octo_ToDo_Achievement[title].AchievementID[AchievementID].completed = completedAchi
				Octo_ToDo_Achievement[title].AchievementID[AchievementID].icon = E.Octo_Func.func_texturefromIcon(icon)
				Octo_ToDo_Achievement[title].AchievementID[AchievementID].points = points
			end
		end
	end
end
function Octo_ToDo_SECOND_OnLoad()
	if not Octo_ToDo_SECOND_Frame_EventFrame then
		Octo_ToDo_SECOND_Frame_EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
	end
	Octo_ToDo_SECOND_Frame_EventFrame:RegisterEvent("VARIABLES_LOADED")
	Octo_ToDo_SECOND_Frame_EventFrame:RegisterEvent("PLAYER_LOGIN")
	Octo_ToDo_SECOND_Frame_EventFrame:RegisterEvent("PLAYER_STARTED_MOVING")
	Octo_ToDo_SECOND_Frame_EventFrame:RegisterEvent("PLAYER_STOPPED_MOVING")
	Octo_ToDo_SECOND_Frame_EventFrame:SetScript("OnEvent", function(...)
			Octo_ToDo_SECOND_OnEvent(...)
	end)
end
function O_otrisovka_SECOND()
	tinsert(OctoTable_func_otrisovka_SECOND,
		function(CharInfo, tooltip, CL, BG)
			local vivodCent, vivodLeft = "", ""
			vivodLeft = Timer_ElementalStorm()
			vivodCent = CharInfo.classColorHex..CharInfo.Name
			if CharInfo.Faction == "Horde" then
				BG:SetColorTexture(.5, 0, 0, E.Octo_Globals.BGALPHA)
			else
				BG:SetColorTexture(0, 0, .5, E.Octo_Globals.BGALPHA)
			end
			if CharInfo.hasMail then
				BG:SetColorTexture(1, 1, 1, E.Octo_Globals.BGALPHA)
				vivodCent = MailBox_Icon..vivodCent
			end
			return vivodCent.."|r", vivodLeft
	end)












			for k, v in pairs(Octo_ToDo_Achievement) do
				if k == Octo_ToDoVars.config.AchievementToShow then
					for AchievementID, info in pairs(v.AchievementID) do
						if info.completed ~= true then
							tinsert(OctoTable_func_otrisovka_SECOND,
								function(CharInfo, tooltip, CL, BG)
									local vivodCent, vivodLeft = "", ""
									vivodLeft = info.icon..info.name.." "..info.points
									vivodCent = E.Octo_Func.func_achievementvivod(AchievementID)
										local numCriteria = GetAchievementNumCriteria(AchievementID)
										if numCriteria ~= 1 then
											tooltip[#tooltip+1] = {E.Octo_Func.func_achievementdescription(AchievementID), " "}
											tooltip[#tooltip+1] = {" ", " "}
										end
										for i = 1, numCriteria do
											tooltip[#tooltip+1] = {E.Octo_Func.func_achievementcriteriaString(AchievementID,i), E.Octo_Func.func_achievementquantity(AchievementID,i)}
										end
									return vivodCent, vivodLeft
							end)
						end
					end
				end
			end











end
function Octo_ToDo_SECOND_CreateAltFrame()
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
	Octo_ToDo_SECOND_Frame_Main_Frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
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
	-- if not Octo_ToDo_SECOND_Frame_Options_Button then
	-- 	Octo_ToDo_SECOND_Frame_Options_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_SECOND_Frame_Main_Frame, "BackDropTemplate")
	-- 	Octo_ToDo_SECOND_Frame_Options_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
	-- 	Octo_ToDo_SECOND_Frame_Options_Button:SetPoint("BOTTOMRIGHT", Octo_ToDo_SECOND_Frame_Main_Frame, "TOPRIGHT", (-E.Octo_Globals.curHeight)*1, 1)
	-- 	Octo_ToDo_SECOND_Frame_Options_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	-- 	Octo_ToDo_SECOND_Frame_Options_Button:SetBackdropBorderColor(1, 0, 0, 0)
	-- 	Octo_ToDo_SECOND_Frame_Options_Button:SetScript("OnEnter", function(self)
	-- 			self:SetBackdropBorderColor(1, 0, 0, 1)
	-- 			self.icon:SetVertexColor(1, 0, 0, 1)
	-- 			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
	-- 			GameTooltip:AddLine(OPTIONS)
	-- 			GameTooltip:Show()
	-- 	end)
	-- 	Octo_ToDo_SECOND_Frame_Options_Button:SetScript("OnLeave", function(self)
	-- 			self:SetBackdropBorderColor(1, 0, 0, 0)
	-- 			self.icon:SetVertexColor(1, 1, 1, 1)
	-- 			GameTooltip:Hide()
	-- 	end)
	-- 	Octo_ToDo_SECOND_Frame_Options_Button:SetScript("OnMouseDown", function(self)
	-- 			self:SetBackdropBorderColor(1, 0, 0, .5)
	-- 			self.icon:SetVertexColor(1, 0, 0, .5)
	-- 	end)
	-- 	Octo_ToDo_SECOND_Frame_Options_Button:SetScript("OnClick", function()
	-- 			-- if Octo_ToDo_SECOND_Frame_Main_Frame and Octo_ToDo_SECOND_Frame_Main_Frame:IsShown() then
	-- 			--     Octo_ToDo_SECOND_Frame_Main_Frame:Hide()
	-- 			-- end
	-- 			if Octo_ToDo_FIRST_Frame_Main_FramePIZDA and Octo_ToDo_FIRST_Frame_Main_FramePIZDA:IsShown() then
	-- 				Octo_ToDo_FIRST_Frame_Main_FramePIZDA:Hide()
	-- 			end
	-- 			if Octo_ToDo_SECOND_Frame_Main_FramePIZDA and Octo_ToDo_SECOND_Frame_Main_FramePIZDA:IsShown() then
	-- 				Octo_ToDo_SECOND_Frame_Main_FramePIZDA:Hide()
	-- 			end
	-- 			if SettingsPanel:IsVisible() and self:IsVisible() then
	-- 				HideUIPanel(SettingsPanel)
	-- 			else
	-- 				Settings.OpenToCategory(AddonTitle, true)
	-- 			end
	-- 	end)
	-- 	local t = Octo_ToDo_SECOND_Frame_Options_Button:CreateTexture(nil, "BACKGROUND")
	-- 	Octo_ToDo_SECOND_Frame_Options_Button.icon = t
	-- 	t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\AddonTexture_SECOND.tga")
	-- 	----t:SetVertexColor(1, 1, 1, 1)
	-- 	t:SetAllPoints(Octo_ToDo_SECOND_Frame_Options_Button)
	-- end
	local function scroll_OnEnter(self)
		self:SetAlpha(1)
	end
	local function scroll_OnLeave(self)
		self:SetAlpha(.2)
	end
	if not Octo_scroll then
		Octo_scroll = lsfdd:CreateButton(Octo_ToDo_SECOND_Frame_Main_Frame, 160, 22)
		Octo_scroll:SetPoint("TOPLEFT", Octo_ToDo_SECOND_Frame_Main_Frame, "BOTTOMLEFT", -3, -2)
		Octo_scroll:SetAlpha(.2)
		Octo_scroll:HookScript("OnEnter", scroll_OnEnter)
		-- Octo_scroll:HookScript("OnLeave", scroll_OnLeave)
		Octo_scroll:ddSetSelectedValue(Octo_ToDoVars.config.AchievementToShow)
		local function selectFunctionAchievement(menuButton)
			Octo_scroll:ddSetSelectedValue(menuButton.value)
			Octo_ToDoVars.config.AchievementToShow = menuButton.value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end
		Octo_scroll:ddInitialize(function(self, level, value)
				local info = {}
				for k, v in pairs(Octo_ToDo_Achievement) do
					info.text = k.." "..v.pizda -- v
					info.value = k
					info.func = selectFunctionAchievement
					-- info.hasArrow = true
					self:ddAddButton(info, level)
				end
		end)
	end
	----------------------------------------------------------------
	if not Octo_ToDo_SECOND_Frame_TEST_Button then
		Octo_ToDo_SECOND_Frame_TEST_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_SECOND_Frame_Main_Frame, "BackDropTemplate")
		Octo_ToDo_SECOND_Frame_TEST_Button:Hide()
		Octo_ToDo_SECOND_Frame_TEST_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		Octo_ToDo_SECOND_Frame_TEST_Button:SetPoint("BOTTOMLEFT", Octo_ToDo_SECOND_Frame_Main_Frame, "BOTTOMRIGHT", 20, 0)
		Octo_ToDo_SECOND_Frame_TEST_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		Octo_ToDo_SECOND_Frame_TEST_Button:SetBackdropBorderColor(1, 0, 0, 0)
		Octo_ToDo_SECOND_Frame_TEST_Button:SetScript("OnEnter", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 1)
				self.icon:SetVertexColor(1, 0, 0, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:AddLine("TomTom")
				GameTooltip:Show()
		end)
		Octo_ToDo_SECOND_Frame_TEST_Button:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		Octo_ToDo_SECOND_Frame_TEST_Button:SetScript("OnMouseDown", function(self)
				TomTom.waydb:ResetProfile()
				TomTom:ReloadWaypoints()
				self:SetBackdropBorderColor(1, 0, 0, .5)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		Octo_ToDo_SECOND_Frame_TEST_Button:SetScript("OnMouseDown", function(self)
				func_Octo_ToDo_SECOND_Frame_TEST_Button()
		end)
	end
	local t = Octo_ToDo_SECOND_Frame_TEST_Button:CreateTexture(nil, "BACKGROUND")
	Octo_ToDo_SECOND_Frame_TEST_Button.icon = t
	-- t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\AddonTexture_SECOND.tga")
	t:SetTexture(236701)
	if select(4, GetAddOnInfo("TomTom")) == true then
		t:SetTexture("Interface\\AddOns\\TomTom\\Images\\StaticArrow.tga")
	end
	t:SetAllPoints(Octo_ToDo_SECOND_Frame_TEST_Button)
	if E.Octo_Globals.isTomTom == true then
		Octo_ToDo_SECOND_Frame_TEST_Button:Show()
	end
	----------------------------------------------------------------
	local function FrameLine_OnEnter(self)
		self.BG:SetColorTexture(r, g, b, E.Octo_Globals.BGALPHA)
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
	local ShowOnlyCurrentRealm = Octo_ToDoVars.config.ShowOnlyCurrentRealm
	local LevelToShow = Octo_ToDoVars.config.LevelToShow
	local itemLevelToShow = Octo_ToDoVars.config.itemLevelToShow
	Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames = {}
	local sorted = {}
	for k, CharInfo in pairs(Octo_ToDoLevels) do
		if k == curGUID then
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
					local CF = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."CF"..i, Octo_ToDo_SECOND_Frame_Char_Frame)
					Octo_ToDo_SECOND_Frame_Char_Frame["CenterLines"..i] = CF
					CF.index = i
					CF:SetSize(E.Octo_Globals.curWidth, E.Octo_Globals.curHeight)
					CF:SetPoint("TOP", Octo_ToDo_SECOND_Frame_Char_Frame, "TOP", 0, -E.Octo_Globals.curHeight*(i-1))
					CF:SetScript("OnEnter", Central_Frame_Mouse_OnEnter)
					CF:SetScript("OnLeave", Central_Frame_Mouse_OnLeave)
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
			Octo_ToDo_SECOND_Frame_Char_Frame:SetSize(E.Octo_Globals.curWidth, E.Octo_Globals.curHeight)
			if #Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames == 0 then
				Octo_ToDo_SECOND_Frame_Char_Frame:SetPoint("TOPRIGHT", 0, 0)
			else
				Octo_ToDo_SECOND_Frame_Char_Frame:SetPoint("TOPRIGHT", Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames[#Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames], "TOPLEFT", 0, 0)
			end
			Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames[#Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames + 1] = Octo_ToDo_SECOND_Frame_Char_Frame
			Octo_ToDo_SECOND_Frame_Char_Frame.BG:Show()
			Octo_ToDo_SECOND_Frame_Char_Frame.BG:SetAlpha(E.Octo_Globals.BGALPHA)
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
			local curAltFrameWidth = #Octo_ToDo_SECOND_Frame_Main_Frame.AllCharFrames * E.Octo_Globals.curWidth/2
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
		if Octo_ToDo_SmartCollectNEW == nil then Octo_ToDo_SmartCollectNEW = {} end
		if Octo_ToDo_Achievement == nil then Octo_ToDo_Achievement = {} end
		if Octo_ToDoLevels == nil then Octo_ToDoLevels = {} end
		if Octo_ToDoVars == nil then Octo_ToDoVars = {} end
		if Octo_ToDoVars.config == nil then Octo_ToDoVars.config = {} end
		if Octo_ToDoArtifact == nil then Octo_ToDoArtifact = {} end
		if Octo_ToDoOther == nil then Octo_ToDoOther = {} end
		if Octo_ToDoTransmog == nil then Octo_ToDoTransmog = {} end
		SHOWADDON = Octo_ToDoVars.config.Achievements
		if SHOWADDON == false then
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
							--     Octo_ToDo_SECOND_Frame_Main_FramePIZDA:Hide()
							-- end
							Octo_ToDo_SECOND_Frame_Main_Frame:SetShown(not Octo_ToDo_SECOND_Frame_Main_Frame:IsShown())
							Collect_All_Pois()
							-- Collect_All_Achievement()
							Collect_NEW_Achievement()
							Octo_ToDo_SECOND_AddDataToAltFrame()
						end
					else
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
					GameTooltip_SetTitle(GameTooltip, E.Octo_Func.func_Gradient(GlobalAddonName.." Achievements", E.Octo_Globals.Green_Color, E.Octo_Globals.Addon_Right_Color).."|n".."Подлагивает")
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDoVars.minimap_SECOND = Octo_ToDoVars.minimap_SECOND or {}
		Octo_ToDoVars.minimap_SECOND.minimapPos = Octo_ToDoVars.minimap_SECOND.minimapPos or 284
		Octo_ToDoVars.config.AddonVersion = tonumber(AddonVersion)
		ldbi:Register(MinimapName, ldb_icon, Octo_ToDoVars.minimap_SECOND)
		ldbi:Show(MinimapName)
	end
	if event == "PLAYER_STARTED_MOVING" and not InCombatLockdown() then
		if Octo_ToDo_SECOND_Frame_Main_Frame and Octo_ToDo_SECOND_Frame_Main_Frame:IsShown() then Octo_ToDo_SECOND_Frame_Main_Frame:SetAlpha(E.Octo_Globals.BGALPHA*5) end
	end
	if event == "PLAYER_STOPPED_MOVING" then
		if Octo_ToDo_SECOND_Frame_Main_Frame then Octo_ToDo_SECOND_Frame_Main_Frame:SetAlpha(1) end
	end
	if event == "PLAYER_LOGIN" and not InCombatLockdown() and SHOWADDON == true then
		C_Timer.After(2, function()
				O_otrisovka_SECOND()
				Octo_ToDo_SECOND_CreateAltFrame()
				Octo_ToDo_SECOND_AddDataToAltFrame()
		end)
	end
end
Octo_ToDo_SECOND_OnLoad()
