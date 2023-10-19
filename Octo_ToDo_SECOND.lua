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
local scale = WorldFrame:GetWidth() / GetPhysicalScreenSize() / UIParent:GetScale()
local menuBackdrop = {
	bgFile = "Interface/ChatFrame/ChatFrameBackground",
	edgeFile = "Interface/ChatFrame/ChatFrameBackground",
	tile = true, edgeSize = 1 * scale, tileSize = 5 * scale,
}
lsfdd:CreateMenuStyle(GlobalAddonName, function(parent)
	local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
	f:SetBackdrop(menuBackdrop)
	f:SetBackdropColor(.06, .06, .1, .9)
	f:SetBackdropBorderColor(.5, .5, .5, .8)
	return f
end)
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
	-- TomTom:AddWaypoint(2023, 29.79/100, 62.22/100, {title = "Erezsra"}) --Erezsra
	-- TomTom:AddWaypoint(2023, 29.69/100, 60.22/100, {title = "Erezsra entrance"}) --Erezsra entrance
	-- TomTom:AddWaypoint(2023, 25.25/100, 65.27/100, {title = "Sayliasra"}) --Sayliasra
	-- TomTom:AddWaypoint(2023, 19.12/100, 82.96/100, {title = "Lucidra"}) --Lucidra
	-- TomTom:AddWaypoint(2023, 18.12/100, 53.88/100, {title = "Aiyelasra"}) --Aiyelasra
	-- TomTom:AddWaypoint(2023, 29.43/100, 41.38/100, {title = "Taelyasra"}) --Taelyasra
	-- TomTom:AddWaypoint(2023, 33.55/100, 53.22/100, {title = "Felyasra"}) --Felyasra
	--Сбрасывай бомбу!
	-- TomTom:AddWaypoint(108, 69.00/100, 75.00/100)
	-- TomTom:AddWaypoint(108, 71.00/100, 78.00/100)
	-- TomTom:AddWaypoint(108, 70.00/100, 79.00/100)
	-- TomTom:AddWaypoint(108, 66.00/100, 78.00/100)
	-- TomTom:AddWaypoint(108, 62.00/100, 80.00/100)
	-- TomTom:AddWaypoint(108, 62.00/100, 78.00/100)
	-- TomTom:AddWaypoint(108, 61.00/100, 75.00/100)
	-- TomTom:AddWaypoint(108, 62.00/100, 73.00/100)
	-- TomTom:AddWaypoint(108, 73.10/100, 83.03/100)
	-- TomTom:AddWaypoint(108, 73.69/100, 80.65/100)
	-- TomTom:AddWaypoint(108, 75.54/100, 80.06/100)
	-- TomTom:AddWaypoint(108, 75.22/100, 86.41/100)
	-- TomTom:AddWaypoint(108, 74.78/100, 88.52/100)
	-- TomTom:AddWaypoint(108, 72.49/100, 88.80/100)
	-- TomTom:AddWaypoint(108, 69.98/100, 74.77/100)
	-- TomTom:AddWaypoint(108, 75.98/100, 81.03/100)
	-- TomTom:AddWaypoint(108, 74.18/100, 83.90/100)
	-- TomTom:AddWaypoint(108, 68.58/100, 73.91/100)
	-- TomTom:AddWaypoint(108, 71.44/100, 81.93/100)
	-- TomTom:AddWaypoint(108, 73.10/100, 83.03/100)
	-- TomTom:AddWaypoint(108, 73.69/100, 80.65/100)
	-- TomTom:AddWaypoint(108, 74.74/100, 88.55/100)
	-- TomTom:AddWaypoint(108, 70.73/100, 84.61/100)
	-- TomTom:AddWaypoint(108, 67.94/100, 79.48/100)
	-- TomTom:AddWaypoint(108, 61.16/100, 79.58/100)
	-- TomTom:AddWaypoint(108, 60.74/100, 75.55/100)
	-- TomTom:AddWaypoint(108, 61.53/100, 73.39/100)
	--ТЫКВОВИН
	local Faction = UnitFactionGroup("PLAYER")
	if C_QuestLog.IsQuestFlaggedCompleted(12366) == false then
		TomTom:AddWaypoint(1, 46.94/100, 06.72/100, {title = E.Octo_Func.func_GetMapName(1)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12361) == false then
		TomTom:AddWaypoint(1, 51.54/100, 41.58/100, {title = E.Octo_Func.func_GetMapName(1)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12374) == false then
		TomTom:AddWaypoint(10, 49.51/100, 57.91/100, {title = E.Octo_Func.func_GetMapName(10)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29002) == false then
		TomTom:AddWaypoint(10, 56.21/100, 40.03/100, {title = E.Octo_Func.func_GetMapName(10)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29003) == false then
		TomTom:AddWaypoint(10, 62.51/100, 16.60/100, {title = E.Octo_Func.func_GetMapName(10)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12396) == false then
		TomTom:AddWaypoint(10, 67.34/100, 74.65/100, {title = E.Octo_Func.func_GetMapName(10)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12396) == false then
		TomTom:AddWaypoint(10, 67.34/100, 74.67/100, {title = E.Octo_Func.func_GetMapName(10)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12353) == false then
		TomTom:AddWaypoint(100, 23.40/100, 36.60/100, {title = E.Octo_Func.func_GetMapName(100)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12389) == false then
		TomTom:AddWaypoint(100, 26.90/100, 59.40/100, {title = E.Octo_Func.func_GetMapName(100)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12352) == false then
		TomTom:AddWaypoint(100, 54.20/100, 63.70/100, {title = E.Octo_Func.func_GetMapName(100)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12388) == false then
		TomTom:AddWaypoint(100, 56.80/100, 37.50/100, {title = E.Octo_Func.func_GetMapName(100)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12390) == false then
		TomTom:AddWaypoint(102, 30.62/100, 50.87/100, {title = E.Octo_Func.func_GetMapName(102)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12355) == false then
		TomTom:AddWaypoint(102, 41.90/100, 26.20/100, {title = E.Octo_Func.func_GetMapName(102)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12354) == false then
		TomTom:AddWaypoint(102, 67.20/100, 48.90/100, {title = E.Octo_Func.func_GetMapName(102)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12403) == false then
		TomTom:AddWaypoint(102, 78.45/100, 62.88/100, {title = E.Octo_Func.func_GetMapName(102)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12403) == false then
		TomTom:AddWaypoint(102, 78.45/100, 62.90/100, {title = E.Octo_Func.func_GetMapName(102)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12337) == false then
		TomTom:AddWaypoint(103, 59.24/100, 18.48/100, {title = E.Octo_Func.func_GetMapName(103)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12395) == false then
		TomTom:AddWaypoint(104, 30.27/100, 27.70/100, {title = E.Octo_Func.func_GetMapName(104)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12360) == false then
		TomTom:AddWaypoint(104, 37.01/100, 58.29/100, {title = E.Octo_Func.func_GetMapName(104)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12409) == false then
		TomTom:AddWaypoint(104, 56.37/100, 59.80/100, {title = E.Octo_Func.func_GetMapName(104)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12409) == false then
		TomTom:AddWaypoint(104, 56.40/100, 59.82/100, {title = E.Octo_Func.func_GetMapName(104)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12409) == false then
		TomTom:AddWaypoint(104, 61.00/100, 28.17/100, {title = E.Octo_Func.func_GetMapName(104)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12409) == false then
		TomTom:AddWaypoint(104, 61.00/100, 28.21/100, {title = E.Octo_Func.func_GetMapName(104)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12358) == false then
		TomTom:AddWaypoint(105, 35.80/100, 63.70/100, {title = E.Octo_Func.func_GetMapName(105)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12393) == false then
		TomTom:AddWaypoint(105, 53.43/100, 55.55/100, {title = E.Octo_Func.func_GetMapName(105)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12359) == false then
		TomTom:AddWaypoint(105, 61.10/100, 68.10/100, {title = E.Octo_Func.func_GetMapName(105)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12406) == false then
		TomTom:AddWaypoint(105, 62.90/100, 38.28/100, {title = E.Octo_Func.func_GetMapName(105)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12406) == false then
		TomTom:AddWaypoint(105, 62.90/100, 38.32/100, {title = E.Octo_Func.func_GetMapName(105)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12394) == false then
		TomTom:AddWaypoint(105, 76.22/100, 60.39/100, {title = E.Octo_Func.func_GetMapName(105)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12341) == false then
		TomTom:AddWaypoint(106, 55.69/100, 59.97/100, {title = E.Octo_Func.func_GetMapName(106)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12357) == false then
		TomTom:AddWaypoint(107, 54.19/100, 75.88/100, {title = E.Octo_Func.func_GetMapName(107)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12392) == false then
		TomTom:AddWaypoint(107, 56.68/100, 34.48/100, {title = E.Octo_Func.func_GetMapName(107)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12391) == false then
		TomTom:AddWaypoint(108, 48.74/100, 45.17/100, {title = E.Octo_Func.func_GetMapName(108)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12356) == false then
		TomTom:AddWaypoint(108, 56.60/100, 53.20/100, {title = E.Octo_Func.func_GetMapName(108)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12407) == false then
		TomTom:AddWaypoint(109, 32.00/100, 64.53/100, {title = E.Octo_Func.func_GetMapName(109)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12407) == false then
		TomTom:AddWaypoint(109, 32.00/100, 64.57/100, {title = E.Octo_Func.func_GetMapName(109)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12408) == false then
		TomTom:AddWaypoint(109, 43.31/100, 36.08/100, {title = E.Octo_Func.func_GetMapName(109)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12408) == false then
		TomTom:AddWaypoint(109, 43.31/100, 36.10/100, {title = E.Octo_Func.func_GetMapName(109)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12364) == false then
		TomTom:AddWaypoint(110, 38.00/100, 84.79/100, {title = E.Octo_Func.func_GetMapName(110)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12370) == false then
		TomTom:AddWaypoint(110, 67.59/100, 72.89/100, {title = E.Octo_Func.func_GetMapName(110)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12370) == false then
		TomTom:AddWaypoint(110, 70.35/100, 77.02/100, {title = E.Octo_Func.func_GetMapName(110)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12369) == false then
		TomTom:AddWaypoint(110, 79.43/100, 57.65/100, {title = E.Octo_Func.func_GetMapName(110)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12369) == false then
		TomTom:AddWaypoint(110, 83.12/100, 58.29/100, {title = E.Octo_Func.func_GetMapName(110)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12404) == false then
		TomTom:AddWaypoint(111, 28.20/100, 49.00/100, {title = E.Octo_Func.func_GetMapName(111)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12404) == false then
		TomTom:AddWaypoint(111, 28.20/100, 49.01/100, {title = E.Octo_Func.func_GetMapName(111)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12404) == false then
		TomTom:AddWaypoint(111, 56.30/100, 81.94/100, {title = E.Octo_Func.func_GetMapName(111)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12404) == false then
		TomTom:AddWaypoint(111, 56.30/100, 81.96/100, {title = E.Octo_Func.func_GetMapName(111)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13468) == false then
		TomTom:AddWaypoint(114, 41.71/100, 54.40/100, {title = E.Octo_Func.func_GetMapName(114)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13501) == false then
		TomTom:AddWaypoint(114, 49.75/100, 09.98/100, {title = E.Octo_Func.func_GetMapName(114)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13437) == false then
		TomTom:AddWaypoint(114, 57.07/100, 19.07/100, {title = E.Octo_Func.func_GetMapName(114)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13436) == false then
		TomTom:AddWaypoint(114, 58.52/100, 67.87/100, {title = E.Octo_Func.func_GetMapName(114)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13467) == false then
		TomTom:AddWaypoint(114, 76.66/100, 37.47/100, {title = E.Octo_Func.func_GetMapName(114)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13460) == false then
		TomTom:AddWaypoint(114, 78.45/100, 49.14/100, {title = E.Octo_Func.func_GetMapName(114)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13460) == false then
		TomTom:AddWaypoint(114, 78.45/100, 49.18/100, {title = E.Octo_Func.func_GetMapName(114)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13438) == false then
		TomTom:AddWaypoint(115, 28.95/100, 56.22/100, {title = E.Octo_Func.func_GetMapName(115)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13469) == false then
		TomTom:AddWaypoint(115, 37.83/100, 46.47/100, {title = E.Octo_Func.func_GetMapName(115)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13459) == false then
		TomTom:AddWaypoint(115, 48.11/100, 74.65/100, {title = E.Octo_Func.func_GetMapName(115)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13459) == false then
		TomTom:AddWaypoint(115, 48.11/100, 74.66/100, {title = E.Octo_Func.func_GetMapName(115)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13456) == false then
		TomTom:AddWaypoint(115, 60.15/100, 53.43/100, {title = E.Octo_Func.func_GetMapName(115)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13456) == false then
		TomTom:AddWaypoint(115, 60.15/100, 53.47/100, {title = E.Octo_Func.func_GetMapName(115)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13470) == false then
		TomTom:AddWaypoint(115, 76.82/100, 63.28/100, {title = E.Octo_Func.func_GetMapName(115)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13439) == false then
		TomTom:AddWaypoint(115, 77.28/100, 50.99/100, {title = E.Octo_Func.func_GetMapName(115)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12946) == false then
		TomTom:AddWaypoint(116, 20.89/100, 64.77/100, {title = E.Octo_Func.func_GetMapName(116)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12944) == false then
		TomTom:AddWaypoint(116, 31.94/100, 60.21/100, {title = E.Octo_Func.func_GetMapName(116)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12945) == false then
		TomTom:AddWaypoint(116, 59.64/100, 26.36/100, {title = E.Octo_Func.func_GetMapName(116)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12947) == false then
		TomTom:AddWaypoint(116, 65.36/100, 47.00/100, {title = E.Octo_Func.func_GetMapName(116)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(54710) == false and Faction == "Alliance" then
		TomTom:AddWaypoint(1161, 73.70/100, 12.19/100, {title = E.Octo_Func.func_GetMapName(1161)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(54709) == false and Faction == "Horde" then
		TomTom:AddWaypoint(1163, 49.82/100, 84.78/100, {title = E.Octo_Func.func_GetMapName(1163)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(54709) == false and Faction == "Horde" then
		TomTom:AddWaypoint(1164, 49.82/100, 84.78/100, {title = E.Octo_Func.func_GetMapName(1164)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(54709) == false and Faction == "Horde" then
		TomTom:AddWaypoint(1165, 50.01/100, 46.84/100, {title = E.Octo_Func.func_GetMapName(1165)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13452) == false then
		TomTom:AddWaypoint(117, 25.31/100, 59.12/100, {title = E.Octo_Func.func_GetMapName(117)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13452) == false then
		TomTom:AddWaypoint(117, 25.31/100, 59.16/100, {title = E.Octo_Func.func_GetMapName(117)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13434) == false then
		TomTom:AddWaypoint(117, 30.83/100, 42.05/100, {title = E.Octo_Func.func_GetMapName(117)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13464) == false then
		TomTom:AddWaypoint(117, 49.40/100, 10.80/100, {title = E.Octo_Func.func_GetMapName(117)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13465) == false then
		TomTom:AddWaypoint(117, 52.10/100, 66.20/100, {title = E.Octo_Func.func_GetMapName(117)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13433) == false then
		TomTom:AddWaypoint(117, 58.67/100, 63.16/100, {title = E.Octo_Func.func_GetMapName(117)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13435) == false then
		TomTom:AddWaypoint(117, 60.48/100, 15.91/100, {title = E.Octo_Func.func_GetMapName(117)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13466) == false then
		TomTom:AddWaypoint(117, 79.27/100, 30.63/100, {title = E.Octo_Func.func_GetMapName(117)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12950) == false then
		TomTom:AddWaypoint(119, 26.61/100, 59.18/100, {title = E.Octo_Func.func_GetMapName(119)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12950) == false then
		TomTom:AddWaypoint(119, 26.61/100, 59.22/100, {title = E.Octo_Func.func_GetMapName(119)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12333) == false then
		TomTom:AddWaypoint(12, 32.40/100, 26.50/100, {title = E.Octo_Func.func_GetMapName(12)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12334) == false then
		TomTom:AddWaypoint(12, 40.32/100, 08.91/100, {title = E.Octo_Func.func_GetMapName(12)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12331) == false then
		TomTom:AddWaypoint(12, 43.71/100, 10.23/100, {title = E.Octo_Func.func_GetMapName(12)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13448) == false then
		TomTom:AddWaypoint(120, 28.72/100, 74.28/100, {title = E.Octo_Func.func_GetMapName(120)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13462) == false then
		TomTom:AddWaypoint(120, 30.58/100, 36.93/100, {title = E.Octo_Func.func_GetMapName(120)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13462) == false then
		TomTom:AddWaypoint(120, 30.58/100, 36.95/100, {title = E.Octo_Func.func_GetMapName(120)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13548) == false then
		TomTom:AddWaypoint(120, 37.09/100, 49.51/100, {title = E.Octo_Func.func_GetMapName(120)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13461) == false then
		TomTom:AddWaypoint(120, 40.93/100, 85.94/100, {title = E.Octo_Func.func_GetMapName(120)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13461) == false then
		TomTom:AddWaypoint(120, 40.93/100, 85.96/100, {title = E.Octo_Func.func_GetMapName(120)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13471) == false then
		TomTom:AddWaypoint(120, 67.65/100, 50.69/100, {title = E.Octo_Func.func_GetMapName(120)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12941) == false then
		TomTom:AddWaypoint(121, 40.86/100, 66.02/100, {title = E.Octo_Func.func_GetMapName(121)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12941) == false then
		TomTom:AddWaypoint(121, 40.86/100, 66.06/100, {title = E.Octo_Func.func_GetMapName(121)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12940) == false then
		TomTom:AddWaypoint(121, 59.33/100, 57.19/100, {title = E.Octo_Func.func_GetMapName(121)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12940) == false then
		TomTom:AddWaypoint(121, 59.33/100, 57.23/100, {title = E.Octo_Func.func_GetMapName(121)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12286) == false then
		TomTom:AddWaypoint(1229, 43.74/100, 65.89/100, {title = E.Octo_Func.func_GetMapName(1229)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13472) == false then
		TomTom:AddWaypoint(125, 38.22/100, 59.59/100, {title = E.Octo_Func.func_GetMapName(125)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13472) == false then
		TomTom:AddWaypoint(125, 38.22/100, 59.65/100, {title = E.Octo_Func.func_GetMapName(125)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13473) == false then
		TomTom:AddWaypoint(125, 42.36/100, 63.13/100, {title = E.Octo_Func.func_GetMapName(125)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13463) == false then
		TomTom:AddWaypoint(125, 48.15/100, 41.27/100, {title = E.Octo_Func.func_GetMapName(125)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13463) == false then
		TomTom:AddWaypoint(125, 48.15/100, 41.35/100, {title = E.Octo_Func.func_GetMapName(125)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13474) == false then
		TomTom:AddWaypoint(125, 66.70/100, 30.00/100, {title = E.Octo_Func.func_GetMapName(125)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13472) == false then
		TomTom:AddWaypoint(126, 40.20/100, 59.49/100, {title = E.Octo_Func.func_GetMapName(126)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13472) == false then
		TomTom:AddWaypoint(126, 40.20/100, 59.51/100, {title = E.Octo_Func.func_GetMapName(126)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13473) == false then
		TomTom:AddWaypoint(127, 24.90/100, 37.50/100, {title = E.Octo_Func.func_GetMapName(127)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13472) == false then
		TomTom:AddWaypoint(127, 27.30/100, 41.69/100, {title = E.Octo_Func.func_GetMapName(127)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13472) == false then
		TomTom:AddWaypoint(127, 27.30/100, 41.71/100, {title = E.Octo_Func.func_GetMapName(127)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13463) == false then
		TomTom:AddWaypoint(127, 29.00/100, 32.39/100, {title = E.Octo_Func.func_GetMapName(127)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13463) == false then
		TomTom:AddWaypoint(127, 29.00/100, 32.41/100, {title = E.Octo_Func.func_GetMapName(127)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(13474) == false then
		TomTom:AddWaypoint(127, 30.70/100, 37.70/100, {title = E.Octo_Func.func_GetMapName(127)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28954) == false then
		TomTom:AddWaypoint(14, 38.25/100, 90.09/100, {title = E.Octo_Func.func_GetMapName(14)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28954) == false then
		TomTom:AddWaypoint(14, 40.06/100, 49.09/100, {title = E.Octo_Func.func_GetMapName(14)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12380) == false then
		TomTom:AddWaypoint(14, 69.02/100, 33.27/100, {title = E.Octo_Func.func_GetMapName(14)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12344) == false then
		TomTom:AddWaypoint(1431, 73.80/100, 44.25/100, {title = E.Octo_Func.func_GetMapName(1431)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12342) == false then
		TomTom:AddWaypoint(1433, 27.09/100, 44.92/100, {title = E.Octo_Func.func_GetMapName(1433)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28957) == false then
		TomTom:AddWaypoint(15, 18.35/100, 42.73/100, {title = E.Octo_Func.func_GetMapName(15)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28956) == false then
		TomTom:AddWaypoint(15, 20.87/100, 56.32/100, {title = E.Octo_Func.func_GetMapName(15)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28955) == false then
		TomTom:AddWaypoint(15, 65.85/100, 35.64/100, {title = E.Octo_Func.func_GetMapName(15)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28955) == false then
		TomTom:AddWaypoint(15, 65.85/100, 35.66/100, {title = E.Octo_Func.func_GetMapName(15)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29016) == false then
		TomTom:AddWaypoint(1527, 26.58/100, 07.22/100, {title = E.Octo_Func.func_GetMapName(1527)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29016) == false then
		TomTom:AddWaypoint(1527, 26.60/100, 07.26/100, {title = E.Octo_Func.func_GetMapName(1527)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29017) == false then
		TomTom:AddWaypoint(1527, 54.68/100, 29.99/100, {title = E.Octo_Func.func_GetMapName(1527)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29017) == false then
		TomTom:AddWaypoint(1527, 54.68/100, 33.01/100, {title = E.Octo_Func.func_GetMapName(1527)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28959) == false then
		TomTom:AddWaypoint(17, 40.47/100, 11.29/100, {title = E.Octo_Func.func_GetMapName(17)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28961) == false then
		TomTom:AddWaypoint(17, 44.34/100, 87.59/100, {title = E.Octo_Func.func_GetMapName(17)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28960) == false then
		TomTom:AddWaypoint(17, 60.69/100, 14.07/100, {title = E.Octo_Func.func_GetMapName(17)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12363) == false then
		TomTom:AddWaypoint(18, 60.95/100, 51.41/100, {title = E.Octo_Func.func_GetMapName(18)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29054) == false then
		TomTom:AddWaypoint(18, 61.50/100, 81.10/100, {title = E.Octo_Func.func_GetMapName(18)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29377) == false then
		TomTom:AddWaypoint(18, 62.12/100, 67.83/100, {title = E.Octo_Func.func_GetMapName(18)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29374) == false then
		TomTom:AddWaypoint(18, 62.13/100, 67.02/100, {title = E.Octo_Func.func_GetMapName(18)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12368) == false then
		TomTom:AddWaypoint(18, 62.19/100, 73.00/100, {title = E.Octo_Func.func_GetMapName(18)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29371) == false then
		TomTom:AddWaypoint(18, 62.40/100, 68.20/100, {title = E.Octo_Func.func_GetMapName(18)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29375) == false then
		TomTom:AddWaypoint(18, 62.43/100, 66.71/100, {title = E.Octo_Func.func_GetMapName(18)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29375) == false then
		TomTom:AddWaypoint(18, 66.60/100, 62.00/100, {title = E.Octo_Func.func_GetMapName(18)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28972) == false then
		TomTom:AddWaypoint(18, 82.98/100, 72.07/100, {title = E.Octo_Func.func_GetMapName(18)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29000) == false then
		TomTom:AddWaypoint(198, 18.63/100, 37.31/100, {title = E.Octo_Func.func_GetMapName(198)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29000) == false then
		TomTom:AddWaypoint(198, 18.63/100, 37.33/100, {title = E.Octo_Func.func_GetMapName(198)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29001) == false then
		TomTom:AddWaypoint(198, 42.68/100, 45.71/100, {title = E.Octo_Func.func_GetMapName(198)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29001) == false then
		TomTom:AddWaypoint(198, 42.68/100, 45.73/100, {title = E.Octo_Func.func_GetMapName(198)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28999) == false then
		TomTom:AddWaypoint(198, 63.05/100, 24.14/100, {title = E.Octo_Func.func_GetMapName(198)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28999) == false then
		TomTom:AddWaypoint(198, 63.05/100, 24.16/100, {title = E.Octo_Func.func_GetMapName(198)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29006) == false then
		TomTom:AddWaypoint(199, 39.02/100, 10.99/100, {title = E.Octo_Func.func_GetMapName(199)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29004) == false then
		TomTom:AddWaypoint(199, 39.29/100, 20.09/100, {title = E.Octo_Func.func_GetMapName(199)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29005) == false then
		TomTom:AddWaypoint(199, 40.70/100, 69.31/100, {title = E.Octo_Func.func_GetMapName(199)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29008) == false then
		TomTom:AddWaypoint(199, 49.04/100, 68.51/100, {title = E.Octo_Func.func_GetMapName(199)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29007) == false then
		TomTom:AddWaypoint(199, 65.60/100, 46.54/100, {title = E.Octo_Func.func_GetMapName(199)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28981) == false then
		TomTom:AddWaypoint(201, 60.68/100, 66.09/100, {title = E.Octo_Func.func_GetMapName(201)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28981) == false then
		TomTom:AddWaypoint(201, 60.68/100, 66.10/100, {title = E.Octo_Func.func_GetMapName(201)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75672) == false then
		TomTom:AddWaypoint(2022, 24.46/100, 82.10/100, {title = E.Octo_Func.func_GetMapName(2022)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75676) == false then
		TomTom:AddWaypoint(2022, 25.77/100, 55.18/100, {title = E.Octo_Func.func_GetMapName(2022)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(77698) == false then
		TomTom:AddWaypoint(2022, 43.10/100, 66.66/100, {title = E.Octo_Func.func_GetMapName(2022)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75679) == false then
		TomTom:AddWaypoint(2022, 46.43/100, 27.40/100, {title = E.Octo_Func.func_GetMapName(2022)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75673) == false then
		TomTom:AddWaypoint(2022, 47.67/100, 83.30/100, {title = E.Octo_Func.func_GetMapName(2022)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75678) == false then
		TomTom:AddWaypoint(2022, 53.91/100, 39.03/100, {title = E.Octo_Func.func_GetMapName(2022)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75674) == false then
		TomTom:AddWaypoint(2022, 58.03/100, 67.31/100, {title = E.Octo_Func.func_GetMapName(2022)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75675) == false then
		TomTom:AddWaypoint(2022, 65.22/100, 57.93/100, {title = E.Octo_Func.func_GetMapName(2022)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75677) == false then
		TomTom:AddWaypoint(2022, 76.06/100, 57.74/100, {title = E.Octo_Func.func_GetMapName(2022)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75683) == false then
		TomTom:AddWaypoint(2022, 76.21/100, 35.41/100, {title = E.Octo_Func.func_GetMapName(2022)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75681) == false and Faction == "Alliance" then
		TomTom:AddWaypoint(2022, 80.42/100, 27.88/100, {title = E.Octo_Func.func_GetMapName(2022)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75682) == false and Faction == "Horde" then
		TomTom:AddWaypoint(2022, 80.42/100, 27.88/100, {title = E.Octo_Func.func_GetMapName(2022)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75686) == false then
		TomTom:AddWaypoint(2023, 28.64/100, 60.56/100, {title = E.Octo_Func.func_GetMapName(2023)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75691) == false then
		TomTom:AddWaypoint(2023, 41.91/100, 60.44/100, {title = E.Octo_Func.func_GetMapName(2023)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75684) == false then -- 75681
		TomTom:AddWaypoint(2023, 46.22/100, 40.60/100, {title = E.Octo_Func.func_GetMapName(2023)}) -- 46224060 /way #2023 46.22 40.60
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75687) == false then
		TomTom:AddWaypoint(2023, 57.13/100, 76.70/100, {title = E.Octo_Func.func_GetMapName(2023)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75685) == false then
		TomTom:AddWaypoint(2023, 62.93/100, 40.56/100, {title = E.Octo_Func.func_GetMapName(2023)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75693) == false then
		TomTom:AddWaypoint(2023, 66.25/100, 24.53/100, {title = E.Octo_Func.func_GetMapName(2023)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75692) == false then
		TomTom:AddWaypoint(2023, 72.13/100, 80.39/100, {title = E.Octo_Func.func_GetMapName(2023)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75688) == false then
		TomTom:AddWaypoint(2023, 81.28/100, 59.21/100, {title = E.Octo_Func.func_GetMapName(2023)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75690) == false then
		TomTom:AddWaypoint(2023, 85.04/100, 26.04/100, {title = E.Octo_Func.func_GetMapName(2023)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75689) == false then
		TomTom:AddWaypoint(2023, 85.85/100, 35.36/100, {title = E.Octo_Func.func_GetMapName(2023)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75669) == false then
		TomTom:AddWaypoint(2024, 12.38/100, 49.36/100, {title = E.Octo_Func.func_GetMapName(2024)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75671) == false then
		TomTom:AddWaypoint(2024, 18.81/100, 24.55/100, {title = E.Octo_Func.func_GetMapName(2024)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75667) == false then
		TomTom:AddWaypoint(2024, 47.03/100, 40.26/100, {title = E.Octo_Func.func_GetMapName(2024)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75668) == false then
		TomTom:AddWaypoint(2024, 62.79/100, 57.74/100, {title = E.Octo_Func.func_GetMapName(2024)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75670) == false then
		TomTom:AddWaypoint(2024, 65.50/100, 16.25/100, {title = E.Octo_Func.func_GetMapName(2024)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75696) == false then
		TomTom:AddWaypoint(2025, 35.08/100, 79.20/100, {title = E.Octo_Func.func_GetMapName(2025)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75701) == false then
		TomTom:AddWaypoint(2025, 35.95/100, 58.41/100, {title = E.Octo_Func.func_GetMapName(2025)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75699) == false then
		TomTom:AddWaypoint(2025, 39.53/100, 59.22/100, {title = E.Octo_Func.func_GetMapName(2025)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75700) == false then
		TomTom:AddWaypoint(2025, 43.17/100, 59.40/100, {title = E.Octo_Func.func_GetMapName(2025)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75698) == false then
		TomTom:AddWaypoint(2025, 50.08/100, 42.73/100, {title = E.Octo_Func.func_GetMapName(2025)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75697) == false then
		TomTom:AddWaypoint(2025, 52.41/100, 69.81/100, {title = E.Octo_Func.func_GetMapName(2025)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75695) == false then
		TomTom:AddWaypoint(2025, 59.85/100, 82.69/100, {title = E.Octo_Func.func_GetMapName(2025)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28986) == false then
		TomTom:AddWaypoint(204, 60.00/100, 56.70/100, {title = E.Octo_Func.func_GetMapName(204)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28985) == false then
		TomTom:AddWaypoint(204, 61.89/100, 79.15/100, {title = E.Octo_Func.func_GetMapName(204)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28984) == false then
		TomTom:AddWaypoint(204, 94.86/100, 73.50/100, {title = E.Octo_Func.func_GetMapName(204)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28986) == false then
		TomTom:AddWaypoint(205, 18.41/100, 52.28/100, {title = E.Octo_Func.func_GetMapName(205)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28985) == false then
		TomTom:AddWaypoint(205, 20.00/100, 71.14/100, {title = E.Octo_Func.func_GetMapName(205)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28983) == false then
		TomTom:AddWaypoint(205, 45.02/100, 57.07/100, {title = E.Octo_Func.func_GetMapName(205)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28984) == false then
		TomTom:AddWaypoint(205, 47.70/100, 66.40/100, {title = E.Octo_Func.func_GetMapName(205)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28982) == false then
		TomTom:AddWaypoint(205, 51.56/100, 41.53/100, {title = E.Octo_Func.func_GetMapName(205)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28982) == false then
		TomTom:AddWaypoint(205, 51.56/100, 41.55/100, {title = E.Octo_Func.func_GetMapName(205)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28981) == false then
		TomTom:AddWaypoint(205, 68.26/100, 15.39/100, {title = E.Octo_Func.func_GetMapName(205)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28981) == false then
		TomTom:AddWaypoint(205, 68.26/100, 15.40/100, {title = E.Octo_Func.func_GetMapName(205)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29020) == false then
		TomTom:AddWaypoint(207, 47.36/100, 51.71/100, {title = E.Octo_Func.func_GetMapName(207)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29019) == false then
		TomTom:AddWaypoint(207, 51.19/100, 49.90/100, {title = E.Octo_Func.func_GetMapName(207)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28966) == false then
		TomTom:AddWaypoint(21, 44.30/100, 20.29/100, {title = E.Octo_Func.func_GetMapName(21)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12371) == false then
		TomTom:AddWaypoint(21, 46.45/100, 42.90/100, {title = E.Octo_Func.func_GetMapName(21)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28969) == false then
		TomTom:AddWaypoint(210, 35.04/100, 27.22/100, {title = E.Octo_Func.func_GetMapName(210)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12397) == false then
		TomTom:AddWaypoint(210, 40.91/100, 73.71/100, {title = E.Octo_Func.func_GetMapName(210)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12397) == false then
		TomTom:AddWaypoint(210, 40.91/100, 73.73/100, {title = E.Octo_Func.func_GetMapName(210)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75701) == false then
		TomTom:AddWaypoint(2112, 22.41/100, 39.85/100, {title = E.Octo_Func.func_GetMapName(2112)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75699) == false then
		TomTom:AddWaypoint(2112, 47.16/100, 45.45/100, {title = E.Octo_Func.func_GetMapName(2112)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75700) == false then
		TomTom:AddWaypoint(2112, 72.37/100, 46.67/100, {title = E.Octo_Func.func_GetMapName(2112)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75703) == false then
		TomTom:AddWaypoint(2133, 52.12/100, 26.45/100, {title = E.Octo_Func.func_GetMapName(2133)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75704) == false then
		TomTom:AddWaypoint(2133, 56.37/100, 56.35/100, {title = E.Octo_Func.func_GetMapName(2133)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(75702) == false then
		TomTom:AddWaypoint(2151, 33.85/100, 58.81/100, {title = E.Octo_Func.func_GetMapName(2151)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28988) == false then
		TomTom:AddWaypoint(22, 43.38/100, 84.37/100, {title = E.Octo_Func.func_GetMapName(22)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28987) == false then
		TomTom:AddWaypoint(22, 48.28/100, 63.65/100, {title = E.Octo_Func.func_GetMapName(22)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28969) == false then
		TomTom:AddWaypoint(224, 34.36/100, 51.92/100, {title = E.Octo_Func.func_GetMapName(224)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12397) == false then
		TomTom:AddWaypoint(224, 37.89/100, 79.92/100, {title = E.Octo_Func.func_GetMapName(224)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12397) == false then
		TomTom:AddWaypoint(224, 37.89/100, 79.94/100, {title = E.Octo_Func.func_GetMapName(224)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12382) == false then
		TomTom:AddWaypoint(224, 42.21/100, 33.59/100, {title = E.Octo_Func.func_GetMapName(224)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28964) == false then
		TomTom:AddWaypoint(224, 52.09/100, 43.10/100, {title = E.Octo_Func.func_GetMapName(224)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12402) == false then
		TomTom:AddWaypoint(23, 75.57/100, 52.30/100, {title = E.Octo_Func.func_GetMapName(23)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12402) == false then
		TomTom:AddWaypoint(23, 75.57/100, 52.32/100, {title = E.Octo_Func.func_GetMapName(23)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12402) == false then
		TomTom:AddWaypoint(24, 40.70/100, 90.35/100, {title = E.Octo_Func.func_GetMapName(24)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12402) == false then
		TomTom:AddWaypoint(24, 40.70/100, 90.37/100, {title = E.Octo_Func.func_GetMapName(24)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28979) == false then
		TomTom:AddWaypoint(241, 43.50/100, 57.27/100, {title = E.Octo_Func.func_GetMapName(241)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28974) == false then
		TomTom:AddWaypoint(241, 45.12/100, 76.81/100, {title = E.Octo_Func.func_GetMapName(241)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28978) == false then
		TomTom:AddWaypoint(241, 49.60/100, 30.36/100, {title = E.Octo_Func.func_GetMapName(241)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28973) == false then
		TomTom:AddWaypoint(241, 53.40/100, 42.84/100, {title = E.Octo_Func.func_GetMapName(241)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28977) == false then
		TomTom:AddWaypoint(241, 60.36/100, 58.25/100, {title = E.Octo_Func.func_GetMapName(241)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28975) == false and Faction == "Horde" then
		TomTom:AddWaypoint(241, 75.36/100, 54.92/100, {title = E.Octo_Func.func_GetMapName(241)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28976) == false then
		TomTom:AddWaypoint(241, 75.41/100, 16.53/100, {title = E.Octo_Func.func_GetMapName(241)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28980) == false then
		TomTom:AddWaypoint(241, 78.87/100, 77.80/100, {title = E.Octo_Func.func_GetMapName(241)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29016) == false then
		TomTom:AddWaypoint(249, 26.60/100, 07.25/100, {title = E.Octo_Func.func_GetMapName(249)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29016) == false then
		TomTom:AddWaypoint(249, 26.60/100, 07.27/100, {title = E.Octo_Func.func_GetMapName(249)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29017) == false then
		TomTom:AddWaypoint(249, 54.68/100, 29.99/100, {title = E.Octo_Func.func_GetMapName(249)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29017) == false then
		TomTom:AddWaypoint(249, 54.68/100, 33.01/100, {title = E.Octo_Func.func_GetMapName(249)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12376) == false then
		TomTom:AddWaypoint(25, 57.85/100, 47.27/100, {title = E.Octo_Func.func_GetMapName(25)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28962) == false then
		TomTom:AddWaypoint(25, 60.26/100, 63.74/100, {title = E.Octo_Func.func_GetMapName(25)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12351) == false then
		TomTom:AddWaypoint(26, 14.19/100, 44.60/100, {title = E.Octo_Func.func_GetMapName(26)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28971) == false then
		TomTom:AddWaypoint(26, 31.80/100, 57.87/100, {title = E.Octo_Func.func_GetMapName(26)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28970) == false then
		TomTom:AddWaypoint(26, 66.16/100, 44.43/100, {title = E.Octo_Func.func_GetMapName(26)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12387) == false then
		TomTom:AddWaypoint(26, 78.19/100, 81.47/100, {title = E.Octo_Func.func_GetMapName(26)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12332) == false then
		TomTom:AddWaypoint(27, 54.49/100, 50.76/100, {title = E.Octo_Func.func_GetMapName(27)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12335) == false then
		TomTom:AddWaypoint(27, 61.17/100, 27.46/100, {title = E.Octo_Func.func_GetMapName(27)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28965) == false then
		TomTom:AddWaypoint(32, 39.48/100, 66.01/100, {title = E.Octo_Func.func_GetMapName(32)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28965) == false then
		TomTom:AddWaypoint(32, 39.48/100, 66.03/100, {title = E.Octo_Func.func_GetMapName(32)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29374) == false then
		TomTom:AddWaypoint(37, 22.13/100, 33.96/100, {title = E.Octo_Func.func_GetMapName(37)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12336) == false then
		TomTom:AddWaypoint(37, 24.89/100, 40.13/100, {title = E.Octo_Func.func_GetMapName(37)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29144) == false then
		TomTom:AddWaypoint(37, 29.69/100, 44.42/100, {title = E.Octo_Func.func_GetMapName(37)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29020) == false then
		TomTom:AddWaypoint(37, 31.24/100, 12.27/100, {title = E.Octo_Func.func_GetMapName(37)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29371) == false then
		TomTom:AddWaypoint(37, 32.09/100, 50.59/100, {title = E.Octo_Func.func_GetMapName(37)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29054) == false then
		TomTom:AddWaypoint(37, 32.35/100, 50.88/100, {title = E.Octo_Func.func_GetMapName(37)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29377) == false then
		TomTom:AddWaypoint(37, 34.10/100, 47.40/100, {title = E.Octo_Func.func_GetMapName(37)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12286) == false then
		TomTom:AddWaypoint(37, 43.74/100, 65.89/100, {title = E.Octo_Func.func_GetMapName(37)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32026) == false then
		TomTom:AddWaypoint(371, 23.32/100, 60.72/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32026) == false then
		TomTom:AddWaypoint(371, 23.32/100, 60.74/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32028) == false then
		TomTom:AddWaypoint(371, 28.02/100, 47.38/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32050) == false then
		TomTom:AddWaypoint(371, 28.45/100, 13.27/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32021) == false then
		TomTom:AddWaypoint(371, 41.68/100, 23.13/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32021) == false then
		TomTom:AddWaypoint(371, 41.69/100, 23.15/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32049) == false then
		TomTom:AddWaypoint(371, 44.81/100, 84.37/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32027) == false then
		TomTom:AddWaypoint(371, 45.77/100, 43.60/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32027) == false then
		TomTom:AddWaypoint(371, 45.77/100, 43.61/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32029) == false then
		TomTom:AddWaypoint(371, 48.09/100, 34.62/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32029) == false then
		TomTom:AddWaypoint(371, 48.09/100, 34.63/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32032) == false then
		TomTom:AddWaypoint(371, 54.60/100, 63.33/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32032) == false then
		TomTom:AddWaypoint(371, 54.60/100, 63.34/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32031) == false then
		TomTom:AddWaypoint(371, 55.71/100, 24.40/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32031) == false then
		TomTom:AddWaypoint(371, 55.71/100, 24.41/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32033) == false then
		TomTom:AddWaypoint(371, 59.56/100, 83.24/100, {title = E.Octo_Func.func_GetMapName(371)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32046) == false then
		TomTom:AddWaypoint(376, 19.87/100, 55.78/100, {title = E.Octo_Func.func_GetMapName(376)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32046) == false then
		TomTom:AddWaypoint(376, 19.88/100, 55.77/100, {title = E.Octo_Func.func_GetMapName(376)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32026) == false then
		TomTom:AddWaypoint(376, 72.75/100, 10.31/100, {title = E.Octo_Func.func_GetMapName(376)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32026) == false then
		TomTom:AddWaypoint(376, 72.75/100, 10.33/100, {title = E.Octo_Func.func_GetMapName(376)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32048) == false then
		TomTom:AddWaypoint(376, 83.64/100, 20.13/100, {title = E.Octo_Func.func_GetMapName(376)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32048) == false then
		TomTom:AddWaypoint(376, 83.64/100, 20.15/100, {title = E.Octo_Func.func_GetMapName(376)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32042) == false then
		TomTom:AddWaypoint(379, 54.07/100, 82.81/100, {title = E.Octo_Func.func_GetMapName(379)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32037) == false then
		TomTom:AddWaypoint(379, 57.45/100, 59.94/100, {title = E.Octo_Func.func_GetMapName(379)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32037) == false then
		TomTom:AddWaypoint(379, 57.45/100, 59.95/100, {title = E.Octo_Func.func_GetMapName(379)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32051) == false then
		TomTom:AddWaypoint(379, 62.50/100, 29.00/100, {title = E.Octo_Func.func_GetMapName(379)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32051) == false then
		TomTom:AddWaypoint(379, 62.50/100, 29.01/100, {title = E.Octo_Func.func_GetMapName(379)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32040) == false then
		TomTom:AddWaypoint(379, 62.77/100, 80.50/100, {title = E.Octo_Func.func_GetMapName(379)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32041) == false then
		TomTom:AddWaypoint(379, 64.20/100, 61.27/100, {title = E.Octo_Func.func_GetMapName(379)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32041) == false then
		TomTom:AddWaypoint(379, 64.22/100, 61.28/100, {title = E.Octo_Func.func_GetMapName(379)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32039) == false then
		TomTom:AddWaypoint(379, 72.72/100, 92.29/100, {title = E.Octo_Func.func_GetMapName(379)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32039) == false then
		TomTom:AddWaypoint(379, 72.74/100, 92.27/100, {title = E.Octo_Func.func_GetMapName(379)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32043) == false then
		TomTom:AddWaypoint(388, 71.13/100, 57.77/100, {title = E.Octo_Func.func_GetMapName(388)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32043) == false then
		TomTom:AddWaypoint(388, 71.14/100, 57.79/100, {title = E.Octo_Func.func_GetMapName(388)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32044) == false then
		TomTom:AddWaypoint(390, 35.12/100, 77.81/100, {title = E.Octo_Func.func_GetMapName(390)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32044) == false then
		TomTom:AddWaypoint(390, 35.14/100, 77.76/100, {title = E.Octo_Func.func_GetMapName(390)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32022) == false then
		TomTom:AddWaypoint(390, 61.98/100, 16.26/100, {title = E.Octo_Func.func_GetMapName(390)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32052) == false then
		TomTom:AddWaypoint(390, 87.03/100, 69.00/100, {title = E.Octo_Func.func_GetMapName(390)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32022) == false then
		TomTom:AddWaypoint(392, 58.87/100, 78.36/100, {title = E.Octo_Func.func_GetMapName(392)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32052) == false then
		TomTom:AddWaypoint(393, 37.85/100, 65.90/100, {title = E.Octo_Func.func_GetMapName(393)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32020) == false then
		TomTom:AddWaypoint(418, 28.25/100, 50.74/100, {title = E.Octo_Func.func_GetMapName(418)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32034) == false then
		TomTom:AddWaypoint(418, 51.40/100, 77.28/100, {title = E.Octo_Func.func_GetMapName(418)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32034) == false then
		TomTom:AddWaypoint(418, 51.41/100, 77.30/100, {title = E.Octo_Func.func_GetMapName(418)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32047) == false then
		TomTom:AddWaypoint(418, 61.15/100, 25.04/100, {title = E.Octo_Func.func_GetMapName(418)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32036) == false then
		TomTom:AddWaypoint(418, 75.92/100, 06.86/100, {title = E.Octo_Func.func_GetMapName(418)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32036) == false then
		TomTom:AddWaypoint(418, 75.92/100, 06.88/100, {title = E.Octo_Func.func_GetMapName(418)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32023) == false then
		TomTom:AddWaypoint(422, 55.21/100, 71.19/100, {title = E.Octo_Func.func_GetMapName(422)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32023) == false then
		TomTom:AddWaypoint(422, 55.21/100, 71.21/100, {title = E.Octo_Func.func_GetMapName(422)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32024) == false then
		TomTom:AddWaypoint(422, 55.93/100, 32.27/100, {title = E.Octo_Func.func_GetMapName(422)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32024) == false then
		TomTom:AddWaypoint(422, 55.93/100, 32.29/100, {title = E.Octo_Func.func_GetMapName(422)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32026) == false then
		TomTom:AddWaypoint(433, 55.11/100, 72.23/100, {title = E.Octo_Func.func_GetMapName(433)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(32026) == false then
		TomTom:AddWaypoint(433, 55.11/100, 72.25/100, {title = E.Octo_Func.func_GetMapName(433)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12344) == false then
		TomTom:AddWaypoint(47, 73.80/100, 44.25/100, {title = E.Octo_Func.func_GetMapName(47)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12339) == false then
		TomTom:AddWaypoint(48, 35.54/100, 48.50/100, {title = E.Octo_Func.func_GetMapName(48)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28963) == false then
		TomTom:AddWaypoint(48, 83.03/100, 63.52/100, {title = E.Octo_Func.func_GetMapName(48)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12342) == false then
		TomTom:AddWaypoint(49, 26.46/100, 41.50/100, {title = E.Octo_Func.func_GetMapName(49)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12342) == false then
		TomTom:AddWaypoint(49, 26.46/100, 41.50/100, {title = E.Octo_Func.func_GetMapName(49)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12382) == false then
		TomTom:AddWaypoint(50, 37.38/100, 51.78/100, {title = E.Octo_Func.func_GetMapName(50)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28964) == false then
		TomTom:AddWaypoint(50, 53.16/100, 66.98/100, {title = E.Octo_Func.func_GetMapName(50)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28968) == false then
		TomTom:AddWaypoint(51, 28.93/100, 32.40/100, {title = E.Octo_Func.func_GetMapName(51)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12384) == false then
		TomTom:AddWaypoint(51, 46.88/100, 56.92/100, {title = E.Octo_Func.func_GetMapName(51)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28967) == false then
		TomTom:AddWaypoint(51, 71.65/100, 14.09/100, {title = E.Octo_Func.func_GetMapName(51)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28967) == false then
		TomTom:AddWaypoint(51, 71.65/100, 14.11/100, {title = E.Octo_Func.func_GetMapName(51)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12340) == false then
		TomTom:AddWaypoint(52, 52.91/100, 53.74/100, {title = E.Octo_Func.func_GetMapName(52)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(39657) == false and Faction == "Horde" then
		TomTom:AddWaypoint(525, 48.25/100, 64.35/100, {title = E.Octo_Func.func_GetMapName(525)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(39719) == false and Faction == "Horde" then
		TomTom:AddWaypoint(525, 48.50/100, 64.60/100, {title = E.Octo_Func.func_GetMapName(525)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(39657) == false and Faction == "Alliance" then
		TomTom:AddWaypoint(539, 30.01/100, 17.80/100, {title = E.Octo_Func.func_GetMapName(539)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(39719) == false and Faction == "Alliance" then
		TomTom:AddWaypoint(539, 30.25/100, 18.05/100, {title = E.Octo_Func.func_GetMapName(539)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12343) == false then
		TomTom:AddWaypoint(56, 10.83/100, 60.99/100, {title = E.Octo_Func.func_GetMapName(56)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28990) == false then
		TomTom:AddWaypoint(56, 26.07/100, 25.98/100, {title = E.Octo_Func.func_GetMapName(56)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28991) == false then
		TomTom:AddWaypoint(56, 58.21/100, 39.20/100, {title = E.Octo_Func.func_GetMapName(56)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12334) == false then
		TomTom:AddWaypoint(57, 34.16/100, 44.01/100, {title = E.Octo_Func.func_GetMapName(57)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12331) == false then
		TomTom:AddWaypoint(57, 55.36/100, 52.29/100, {title = E.Octo_Func.func_GetMapName(57)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(39657) == false and Faction == "Alliance" then
		TomTom:AddWaypoint(582, 43.51/100, 51.51/100, {title = E.Octo_Func.func_GetMapName(582)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(39719) == false and Faction == "Alliance" then
		TomTom:AddWaypoint(582, 44.40/100, 51.80/100, {title = E.Octo_Func.func_GetMapName(582)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(39657) == false and Faction == "Horde" then
		TomTom:AddWaypoint(590, 46.99/100, 37.59/100, {title = E.Octo_Func.func_GetMapName(590)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(39719) == false and Faction == "Horde" then
		TomTom:AddWaypoint(590, 47.90/100, 37.90/100, {title = E.Octo_Func.func_GetMapName(590)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28951) == false then
		TomTom:AddWaypoint(62, 50.79/100, 18.90/100, {title = E.Octo_Func.func_GetMapName(62)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(43056) == false and Faction == "Alliance" then
		TomTom:AddWaypoint(627, 41.47/100, 63.98/100, {title = E.Octo_Func.func_GetMapName(627)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(43259) == false and Faction == "Neutral" then
		TomTom:AddWaypoint(627, 47.29/100, 40.77/100, {title = E.Octo_Func.func_GetMapName(627)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(43055) == false and Faction == "Neutral" then
		TomTom:AddWaypoint(627, 47.96/100, 41.78/100, {title = E.Octo_Func.func_GetMapName(627)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(43057) == false and Faction == "Horde" then
		TomTom:AddWaypoint(627, 67.04/100, 29.41/100, {title = E.Octo_Func.func_GetMapName(627)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28989) == false then
		TomTom:AddWaypoint(63, 13.00/100, 34.10/100, {title = E.Octo_Func.func_GetMapName(63)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12345) == false then
		TomTom:AddWaypoint(63, 37.01/100, 49.26/100, {title = E.Octo_Func.func_GetMapName(63)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28958) == false then
		TomTom:AddWaypoint(63, 38.66/100, 42.34/100, {title = E.Octo_Func.func_GetMapName(63)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28953) == false then
		TomTom:AddWaypoint(63, 50.25/100, 67.27/100, {title = E.Octo_Func.func_GetMapName(63)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12377) == false then
		TomTom:AddWaypoint(63, 73.96/100, 60.60/100, {title = E.Octo_Func.func_GetMapName(63)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29013) == false then
		TomTom:AddWaypoint(65, 31.53/100, 60.66/100, {title = E.Octo_Func.func_GetMapName(65)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29012) == false then
		TomTom:AddWaypoint(65, 39.48/100, 32.81/100, {title = E.Octo_Func.func_GetMapName(65)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12347) == false and Faction == "Alliance" then
		TomTom:AddWaypoint(65, 40.53/100, 17.69/100, {title = E.Octo_Func.func_GetMapName(65)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12378) == false then
		TomTom:AddWaypoint(65, 50.37/100, 63.79/100, {title = E.Octo_Func.func_GetMapName(65)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29011) == false then
		TomTom:AddWaypoint(65, 59.04/100, 56.32/100, {title = E.Octo_Func.func_GetMapName(65)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29009) == false then
		TomTom:AddWaypoint(65, 66.50/100, 64.19/100, {title = E.Octo_Func.func_GetMapName(65)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29010) == false then
		TomTom:AddWaypoint(65, 71.02/100, 79.08/100, {title = E.Octo_Func.func_GetMapName(65)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12381) == false then
		TomTom:AddWaypoint(66, 24.07/100, 68.29/100, {title = E.Octo_Func.func_GetMapName(66)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28993) == false then
		TomTom:AddWaypoint(66, 56.72/100, 50.10/100, {title = E.Octo_Func.func_GetMapName(66)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28993) == false then
		TomTom:AddWaypoint(66, 56.72/100, 50.14/100, {title = E.Octo_Func.func_GetMapName(66)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12348) == false then
		TomTom:AddWaypoint(66, 66.33/100, 06.59/100, {title = E.Octo_Func.func_GetMapName(66)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28996) == false then
		TomTom:AddWaypoint(69, 41.45/100, 15.68/100, {title = E.Octo_Func.func_GetMapName(69)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12350) == false then
		TomTom:AddWaypoint(69, 46.33/100, 45.19/100, {title = E.Octo_Func.func_GetMapName(69)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28952) == false then
		TomTom:AddWaypoint(69, 51.07/100, 17.82/100, {title = E.Octo_Func.func_GetMapName(69)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28998) == false then
		TomTom:AddWaypoint(69, 51.97/100, 47.64/100, {title = E.Octo_Func.func_GetMapName(69)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12386) == false then
		TomTom:AddWaypoint(69, 74.83/100, 45.14/100, {title = E.Octo_Func.func_GetMapName(69)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12367) == false then
		TomTom:AddWaypoint(7, 39.70/100, 31.18/100, {title = E.Octo_Func.func_GetMapName(7)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12362) == false then
		TomTom:AddWaypoint(7, 46.79/100, 60.41/100, {title = E.Octo_Func.func_GetMapName(7)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12383) == false then
		TomTom:AddWaypoint(70, 36.78/100, 32.44/100, {title = E.Octo_Func.func_GetMapName(70)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12398) == false then
		TomTom:AddWaypoint(70, 41.85/100, 74.08/100, {title = E.Octo_Func.func_GetMapName(70)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12398) == false then
		TomTom:AddWaypoint(70, 41.86/100, 74.09/100, {title = E.Octo_Func.func_GetMapName(70)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12349) == false and Faction == "Alliance" then
		TomTom:AddWaypoint(70, 66.60/100, 45.28/100, {title = E.Octo_Func.func_GetMapName(70)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12399) == false then
		TomTom:AddWaypoint(71, 52.56/100, 27.09/100, {title = E.Octo_Func.func_GetMapName(71)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12399) == false then
		TomTom:AddWaypoint(71, 52.56/100, 27.10/100, {title = E.Octo_Func.func_GetMapName(71)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29014) == false then
		TomTom:AddWaypoint(71, 55.70/100, 60.95/100, {title = E.Octo_Func.func_GetMapName(71)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29014) == false then
		TomTom:AddWaypoint(71, 55.70/100, 60.97/100, {title = E.Octo_Func.func_GetMapName(71)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28992) == false then
		TomTom:AddWaypoint(76, 57.11/100, 50.17/100, {title = E.Octo_Func.func_GetMapName(76)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28994) == false then
		TomTom:AddWaypoint(77, 44.57/100, 28.97/100, {title = E.Octo_Func.func_GetMapName(77)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28994) == false then
		TomTom:AddWaypoint(77, 44.59/100, 29.01/100, {title = E.Octo_Func.func_GetMapName(77)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(28995) == false then
		TomTom:AddWaypoint(77, 61.86/100, 26.71/100, {title = E.Octo_Func.func_GetMapName(77)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29018) == false then
		TomTom:AddWaypoint(78, 55.26/100, 62.13/100, {title = E.Octo_Func.func_GetMapName(78)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29018) == false then
		TomTom:AddWaypoint(78, 55.26/100, 62.19/100, {title = E.Octo_Func.func_GetMapName(78)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12401) == false then
		TomTom:AddWaypoint(81, 55.47/100, 36.78/100, {title = E.Octo_Func.func_GetMapName(81)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12401) == false then
		TomTom:AddWaypoint(81, 55.47/100, 36.79/100, {title = E.Octo_Func.func_GetMapName(81)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12400) == false then
		TomTom:AddWaypoint(83, 59.83/100, 51.19/100, {title = E.Octo_Func.func_GetMapName(83)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12400) == false then
		TomTom:AddWaypoint(83, 59.83/100, 51.23/100, {title = E.Octo_Func.func_GetMapName(83)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29374) == false then
		TomTom:AddWaypoint(84, 55.00/100, 63.00/100, {title = E.Octo_Func.func_GetMapName(84)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12336) == false then
		TomTom:AddWaypoint(84, 60.51/100, 75.34/100, {title = E.Octo_Func.func_GetMapName(84)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29144) == false then
		TomTom:AddWaypoint(84, 70.10/100, 83.90/100, {title = E.Octo_Func.func_GetMapName(84)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29020) == false then
		TomTom:AddWaypoint(84, 73.19/100, 19.67/100, {title = E.Octo_Func.func_GetMapName(84)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29371) == false then
		TomTom:AddWaypoint(84, 74.88/100, 96.24/100, {title = E.Octo_Func.func_GetMapName(84)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29054) == false then
		TomTom:AddWaypoint(84, 75.41/100, 96.81/100, {title = E.Octo_Func.func_GetMapName(84)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29377) == false then
		TomTom:AddWaypoint(84, 78.91/100, 89.86/100, {title = E.Octo_Func.func_GetMapName(84)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29019) == false then
		TomTom:AddWaypoint(85, 50.84/100, 36.31/100, {title = E.Octo_Func.func_GetMapName(85)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12366) == false then
		TomTom:AddWaypoint(85, 53.93/100, 78.94/100, {title = E.Octo_Func.func_GetMapName(85)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(54709) == false and Faction == "Horde" then
		TomTom:AddWaypoint(862, 57.98/100, 44.68/100, {title = E.Octo_Func.func_GetMapName(862)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12335) == false then
		TomTom:AddWaypoint(87, 18.34/100, 50.94/100, {title = E.Octo_Func.func_GetMapName(87)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12367) == false then
		TomTom:AddWaypoint(88, 45.62/100, 64.93/100, {title = E.Octo_Func.func_GetMapName(88)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12334) == false then
		TomTom:AddWaypoint(89, 62.28/100, 33.15/100, {title = E.Octo_Func.func_GetMapName(89)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(54710) == false and Faction == "Alliance" then
		TomTom:AddWaypoint(895, 75.18/100, 22.72/100, {title = E.Octo_Func.func_GetMapName(895)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12368) == false then
		TomTom:AddWaypoint(90, 67.75/100, 37.42/100, {title = E.Octo_Func.func_GetMapName(90)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29054) == false then
		TomTom:AddWaypoint(90, 75.70/100, 33.00/100, {title = E.Octo_Func.func_GetMapName(90)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29371) == false then
		TomTom:AddWaypoint(90, 76.10/100, 53.20/100, {title = E.Octo_Func.func_GetMapName(90)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29375) == false then
		TomTom:AddWaypoint(90, 76.50/100, 33.01/100, {title = E.Octo_Func.func_GetMapName(90)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12365) == false then
		TomTom:AddWaypoint(94, 43.70/100, 71.03/100, {title = E.Octo_Func.func_GetMapName(94)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12364) == false then
		TomTom:AddWaypoint(94, 48.20/100, 47.88/100, {title = E.Octo_Func.func_GetMapName(94)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12370) == false then
		TomTom:AddWaypoint(94, 55.47/100, 44.95/100, {title = E.Octo_Func.func_GetMapName(94)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12369) == false then
		TomTom:AddWaypoint(94, 59.29/100, 41.37/100, {title = E.Octo_Func.func_GetMapName(94)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29020) == false then
		TomTom:AddWaypoint(947, 45.19/100, 48.49/100, {title = E.Octo_Func.func_GetMapName(947)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29019) == false then
		TomTom:AddWaypoint(947, 45.19/100, 48.51/100, {title = E.Octo_Func.func_GetMapName(947)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29020) == false then
		TomTom:AddWaypoint(948, 50.00/100, 29.00/100, {title = E.Octo_Func.func_GetMapName(948)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(29019) == false then
		TomTom:AddWaypoint(948, 50.00/100, 29.01/100, {title = E.Octo_Func.func_GetMapName(948)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12373) == false then
		TomTom:AddWaypoint(95, 48.68/100, 31.90/100, {title = E.Octo_Func.func_GetMapName(95)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12337) == false then
		TomTom:AddWaypoint(97, 30.32/100, 25.00/100, {title = E.Octo_Func.func_GetMapName(97)})
	end
	if C_QuestLog.IsQuestFlaggedCompleted(12333) == false then
		TomTom:AddWaypoint(97, 48.49/100, 49.05/100, {title = E.Octo_Func.func_GetMapName(97)})
	end
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
		local vivod = completed.."/"..total
		-- " ("..completed.."/"..total..")"
		if total == completed then
			vivod = E.Octo_Globals.DONE
		else
			if completed == 0 then
				vivod = E.Octo_Globals.Red_Color..vivod.."|r"
			else
				vivod = E.Octo_Globals.Yellow_Color..vivod.."|r"
			end
		end
		Octo_ToDo_Achievement[title] = Octo_ToDo_Achievement[title] or {}
		Octo_ToDo_Achievement[title].title = title
		Octo_ToDo_Achievement[title].categoryID = categoryID
		Octo_ToDo_Achievement[title].parentCategoryID = parentCategoryID
		Octo_ToDo_Achievement[title].vivod = vivod or ""
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
	-- for k, v in pairs(Octo_ToDo_Achievement) do
	-- 	if k == Octo_ToDoVars.config.AchievementToShow then
	-- 		for AchievementID, info in pairs(v.AchievementID) do
	-- 			if info.completed ~= true then
	-- 				tinsert(OctoTable_func_otrisovka_SECOND,
	-- 					function(CharInfo, tooltip, CL, BG)
	-- 						local vivodCent, vivodLeft = "", ""
	-- 						vivodLeft = info.icon..info.name.." "..info.points
	-- 						vivodCent = E.Octo_Func.func_achievementvivod(AchievementID)
	-- 						local numCriteria = GetAchievementNumCriteria(AchievementID)
	-- 						if numCriteria ~= 1 then
	-- 							tooltip[#tooltip+1] = {E.Octo_Func.func_achievementdescription(AchievementID), " "}
	-- 							tooltip[#tooltip+1] = {" ", " "}
	-- 						end
	-- 						for i = 1, numCriteria do
	-- 							tooltip[#tooltip+1] = {E.Octo_Func.func_achievementcriteriaString(AchievementID, i), E.Octo_Func.func_achievementquantity(AchievementID, i)}
	-- 						end
	-- 						return vivodCent, vivodLeft
	-- 				end)
	-- 			end
	-- 		end
	-- 	end
	-- end
	if Octo_ToDoVars.config.AchievementToShow ~= 0 then
		local categoryID = Octo_ToDoVars.config.AchievementToShow
		local total = GetCategoryNumAchievements(categoryID, true)
		if total then
			for i = 1, total do
				local AchievementID, name, points, completedAchi, _, _, _, _, _, icon = GetAchievementInfo(categoryID, i)
				if AchievementID then
					if completedAchi == false or (completedAchi == Octo_ToDoVars.config.AchievementShowCompleted) then
						tinsert(OctoTable_func_otrisovka_SECOND,
							function(CharInfo, tooltip, CL, BG)
								local vivodCent, vivodLeft = "", ""
								vivodLeft = E.Octo_Func.func_texturefromIcon(icon)..name..E.Octo_Globals.Yellow_Color.." id:"..AchievementID.."|r"
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
	--     Octo_ToDo_SECOND_Frame_Options_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_SECOND_Frame_Main_Frame, "BackDropTemplate")
	--     Octo_ToDo_SECOND_Frame_Options_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
	--     Octo_ToDo_SECOND_Frame_Options_Button:SetPoint("BOTTOMRIGHT", Octo_ToDo_SECOND_Frame_Main_Frame, "TOPRIGHT", (-E.Octo_Globals.curHeight)*1, 1)
	--     Octo_ToDo_SECOND_Frame_Options_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	--     Octo_ToDo_SECOND_Frame_Options_Button:SetBackdropBorderColor(1, 0, 0, 0)
	--     Octo_ToDo_SECOND_Frame_Options_Button:SetScript("OnEnter", function(self)
	--             self:SetBackdropBorderColor(1, 0, 0, 1)
	--             self.icon:SetVertexColor(1, 0, 0, 1)
	--             GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
	--             GameTooltip:AddLine(OPTIONS)
	--             GameTooltip:Show()
	--     end)
	--     Octo_ToDo_SECOND_Frame_Options_Button:SetScript("OnLeave", function(self)
	--             self:SetBackdropBorderColor(1, 0, 0, 0)
	--             self.icon:SetVertexColor(1, 1, 1, 1)
	--             GameTooltip:Hide()
	--     end)
	--     Octo_ToDo_SECOND_Frame_Options_Button:SetScript("OnMouseDown", function(self)
	--             self:SetBackdropBorderColor(1, 0, 0, .5)
	--             self.icon:SetVertexColor(1, 0, 0, .5)
	--     end)
	--     Octo_ToDo_SECOND_Frame_Options_Button:SetScript("OnClick", function()
	--             -- if Octo_ToDo_SECOND_Frame_Main_Frame and Octo_ToDo_SECOND_Frame_Main_Frame:IsShown() then
	--             --  Octo_ToDo_SECOND_Frame_Main_Frame:Hide()
	--             -- end
	--             if Octo_ToDo_FIRST_Frame_Main_FramePIZDA and Octo_ToDo_FIRST_Frame_Main_FramePIZDA:IsShown() then
	--                 Octo_ToDo_FIRST_Frame_Main_FramePIZDA:Hide()
	--             end
	--             if Octo_ToDo_SECOND_Frame_Main_FramePIZDA and Octo_ToDo_SECOND_Frame_Main_FramePIZDA:IsShown() then
	--                 Octo_ToDo_SECOND_Frame_Main_FramePIZDA:Hide()
	--             end
	--             if SettingsPanel:IsVisible() and self:IsVisible() then
	--                 HideUIPanel(SettingsPanel)
	--             else
	--                 Settings.OpenToCategory(AddonTitle, true)
	--             end
	--     end)
	--     local t = Octo_ToDo_SECOND_Frame_Options_Button:CreateTexture(nil, "BACKGROUND")
	--     Octo_ToDo_SECOND_Frame_Options_Button.icon = t
	--     t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\AddonTexture_SECOND.tga")
	--     ----t:SetVertexColor(1, 1, 1, 1)
	--     t:SetAllPoints(Octo_ToDo_SECOND_Frame_Options_Button)
	-- end
	local function scroll_OnEnter(self)
		self:SetAlpha(1)
	end
	local function scroll_OnLeave(self)
		self:SetAlpha(.2)
	end
	if not dd then
		local dd = lsfdd:CreateStretchButtonOriginal(Octo_ToDo_SECOND_Frame_Main_Frame, 160, 22) -- lsfdd:CreateButton
		-- dd:SetPoint("TOPLEFT", Octo_ToDo_SECOND_Frame_Main_Frame, "BOTTOMLEFT", -3, -2)
		dd:SetPoint("BOTTOMLEFT", Octo_ToDo_SECOND_Frame_Main_Frame, "TOPLEFT", 0, 2)
		-- dd:SetAlpha(.2)
		-- dd:HookScript("OnEnter", scroll_OnEnter)
		-- dd:HookScript("OnLeave", scroll_OnLeave)
		-- dd:ddSetSelectedValue(Octo_ToDoVars.config.AchievementToShow)
		local function selectFunctionAchievementToShow(menuButton)
			-- dd:ddSetSelectedValue(menuButton.value)
			Octo_ToDoVars.config.AchievementToShow = menuButton.value
			StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
		end
		-- dd:SetText(OPTIONS)
		dd:SetText(ACHIEVEMENT_TITLE.." "..E.Octo_Globals.Green_Color..GetTotalAchievementPoints(false).."|r")
		dd:ddSetDisplayMode(GlobalAddonName)
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
						info.hasArrow = parentCategoryID == -1 and categoryID ~= 92
						info.notCheckable = false
						info.text = name ..vivod --.. E.Octo_Globals.Gray_Color.." id:"..categoryID.."|r"
						info.value = categoryID
						info.checked = Octo_ToDoVars.config.AchievementToShow == categoryID
						info.func = selectFunctionAchievementToShow
						self:ddAddButton(info, level)
					end
				end
				if level == 1 then
					self:ddAddSeparator(level)
					info.notCheckable = false
					info.text = "Показывать завершенные"
					info.hasArrow = nil
					info.checked = Octo_ToDoVars.config.AchievementShowCompleted
					info.func = function(_,_,_, checked)
						Octo_ToDoVars.config.AchievementShowCompleted = checked
						StaticPopup_Show(GlobalAddonName.."GET_RELOAD")
					end
					self:ddAddButton(info, level)
				end
		end)
	end
	----------------------------------------------------------------
	if not Octo_ToDo_SECOND_Frame_TEST_Button then
		Octo_ToDo_SECOND_Frame_TEST_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID().."Octo_ToDo_SECOND_Frame_TEST_Button", Octo_ToDo_SECOND_Frame_Main_Frame, "BackDropTemplate")
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
					local CF = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID().."CF"..i, Octo_ToDo_SECOND_Frame_Char_Frame)
					Octo_ToDo_SECOND_Frame_Char_Frame["CenterLines"..i] = CF
					CF.index = i
					CF:SetSize(E.Octo_Globals.curWidth, E.Octo_Globals.curHeight)
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
		if Octo_Achi_MAIN == nil then Octo_Achi_MAIN = {} end
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
							--  Octo_ToDo_SECOND_Frame_Main_FramePIZDA:Hide()
							-- end
							Octo_ToDo_SECOND_Frame_Main_Frame:SetShown(not Octo_ToDo_SECOND_Frame_Main_Frame:IsShown())
							Collect_All_Pois()
							-- Collect_All_Achievement()
							-- Collect_NEW_Achievement()
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
