local AddonName, E = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
E.modules = {}
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
-- TalkingHeadFrame
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.TalkingHeadFrame then
			hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
					self:Hide()
					print("|cFF00A3FFTalking head frame|r |cffFF4C4Fcanceled.|r")
			end)
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--HideObjectiveTracker
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.HideObjectiveTracker then
			ObjectiveTrackerFrame:Hide()
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--HideZoneText
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.HideZoneText then
			ZoneTextFrame:UnregisterAllEvents()
			EventToastManagerFrame:UnregisterAllEvents()
			if EventToastManagerFrame then
				EventToastManagerFrame:Hide()
			end
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--Covenant
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.Covenant then
			CovenantChoiceToast:UnregisterAllEvents()
			CovenantRenownToast:UnregisterAllEvents()
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--UIErrorsFrame
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.UIErrorsFrame then
			UIErrorsFrame:Hide()
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--RaidBossEmoteFrame
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.RaidBossEmoteFrame then
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_WHISPER")
			RaidBossEmoteFrame:UnregisterEvent("CLEAR_BOSS_EMOTES")
			RaidBossEmoteFrame:UnregisterAllEvents()
			RaidBossEmoteFrame:Hide()
			-- RaidBossEmoteFrameSlot1:Hide()
			-- RaidBossEmoteFrameSlot2:Hide()
			ObjectiveTrackerBonusBannerFrame:Hide()
			ObjectiveTrackerBonusBannerFrame.BG1:Hide()
			ObjectiveTrackerBonusBannerFrame.BG2:Hide()
			ObjectiveTrackerBonusBannerFrame.Icon:Hide()
			ObjectiveTrackerBonusBannerFrame.Icon2:Hide()
			ObjectiveTrackerBonusBannerFrame.Icon3:Hide()
			ObjectiveTrackerBonusBannerFrame.BonusLabel:Hide()
			ObjectiveTrackerBonusBannerFrame.Title:Hide()
			ObjectiveTrackerBonusBannerFrame.TitleFlash:Hide()
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--CinematicCanceler
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.CinematicCanceler then
			CinematicFrame:HookScript("OnShow", function(self, ...)
					if IsModifierKeyDown() then
 return end --если нажат модификатор, то запустится мувик
					print("|cFF00A3FFCinematic|r |cffFF4C4Fcanceled.|r")
					CinematicFrame_CancelCinematic()
			end)
			local omfpf = _G["MovieFrame_PlayMovie"] --запускает мувик?
			_G["MovieFrame_PlayMovie"] = function(...)
				if IsModifierKeyDown() then
 return omfpf(...) end
				print("|cFF00A3FFMovie|r |cffFF4C4Fcanceled.|r")
				GameMovieFinished() return true
			end
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--BossBanner
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.BossBanner then
			BossBanner:UnregisterAllEvents()
			BossBanner:Hide()
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--MajorFactionsRenownToast
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.MajorFactionsRenownToast then
			if MajorFactionsRenownToast then
				print("che za hooinya")
				-- MajorFactionsRenownToast:UnregisterAllEvents()
				-- MajorFactionsRenownToast:Hide()
				-- MajorFactionsRenownToast.ToastBG:Hide()
				-- MajorFactionsRenownToast.IconSwirlModelScene:Hide()
				MajorFactionsRenownToast.ToastBG:SetAlpha(0);
				MajorFactionsRenownToast.IconSwirlModelScene:SetAlpha(0);
				MajorFactionsRenownToast.Icon:SetAlpha(0);
				MajorFactionsRenownToast.RenownLabel:SetAlpha(0);
				MajorFactionsRenownToast.RewardIcon:SetAlpha(0);
				MajorFactionsRenownToast.RewardIconRing:SetAlpha(0);
				MajorFactionsRenownToast.RewardDescription:SetAlpha(0);
			end
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
local function func_Octo_LoadAddOn(AddonName)
	if select(5, GetAddOnInfo(AddonName)) == "DISABLED" then
		EnableAddOn(AddonName)
		LoadAddOn(AddonName)
	end
end
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--AnotherAddons
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.AnotherAddons then
			func_Octo_LoadAddOn("!BugGrabber")
			func_Octo_LoadAddOn("BugSack")
			func_Octo_LoadAddOn("AutoTurnIn")
			func_Octo_LoadAddOn("MountsJournal")
			func_Octo_LoadAddOn("MountsJournal_ElvUI_Skin")
			func_Octo_LoadAddOn("HidingBar")
			func_Octo_LoadAddOn("HidingBar_Options")
			func_Octo_LoadAddOn("WowheadQuickLink")
			func_Octo_LoadAddOn("Postal")
			func_Octo_LoadAddOn("TalentTreeTweaks")
			func_Octo_LoadAddOn("Simulationcraft")
			func_Octo_LoadAddOn("SpeedyAutoLoot")
			func_Octo_LoadAddOn("AdvancedInterfaceOptions")
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--CVAR
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.CVar then
			local isElfUI = IsAddOnLoaded("ElvUI")
			if isElfUI == true and not InCombatLockdown() then
				C_Timer.After(1, function()
						C_Container.SetSortBagsRightToLeft(false)
						C_Container.SetInsertItemsLeftToRight(false)
				end)
			end
			if isElfUI == false and not InCombatLockdown() then
				C_Timer.After(1, function()
						C_Container.SetSortBagsRightToLeft(false)
						C_Container.SetInsertItemsLeftToRight(false)
						C_Container.SortBags()
				end)
			end
			if not InCombatLockdown() then
				C_Timer.After(1, function()
						SetCVar("AutoPushSpellToActionBar", 0)
						SetCVar("AllowDangerousScripts", 1)
						SetCVar("alwaysShowActionBars", 1)
						SetCVar("autoLootDefault", 1) --автолут 1 вкл
						SetCVar("cameraDistanceMaxZoomFactor", 2.6)
						SetCVar("cameraSmoothStyle", 0) --не выравнивать камеру в движении
						SetCVar("colorChatNamesByClass", 1)
						SetCVar("combinedBags", 1)  --/console combinedBags 1
						SetCVar("displayFreeBagSlots", 1) --отображает кол-во свободного места
						SetCVar("doNotFlashLowHealthWarning", 1)
						SetCVar("enableFloatingCombatText", 0) --НЕ надо, отображение на экране дополнительных сообщений
						SetCVar("enablePetBattleFloatingCombatText", 0)
						SetCVar("expandBagBar", 0)
						SetCVar("ffxDeath", 1) --во время смерти
						SetCVar("ffxGlow", 0) --мыло на экране
						SetCVar("ffxLingeringVenari", 1)
						SetCVar("ffxNether", 1) --во время атаки фей ласт фаза или инвиза
						SetCVar("ffxVenari", 1)
						SetCVar("findYourselfAnywhere", 0)
						SetCVar("findYourselfMode", 0)
						SetCVar("floatingCombatTextAllSpellMechanics", 0)
						SetCVar("floatingCombatTextAuras", 0)
						SetCVar("floatingCombatTextCombatDamage", 0) --ТУТ
						SetCVar("floatingCombatTextCombatDamageAllAutos", 0) --ТУТ
						SetCVar("floatingCombatTextCombatDamageDirectionalOffset", 0) --ТУТ
						SetCVar("floatingCombatTextCombatDamageDirectionalScale", 0) --ТУТ
						SetCVar("floatingCombatTextCombatHealing", 0) --ТУТ
						SetCVar("floatingCombatTextCombatHealingAbsorbSelf", 0) --ТУТ
						SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 0) --ТУТ
						SetCVar("floatingCombatTextCombatLogPeriodicSpells", 0) --ТУТ Отображение урона от периодически действующих эффектов, таких как "Кровопускание" и "Слово Тьмы:Болль"
						SetCVar("floatingCombatTextCombatState", 0) --Проки по центру экрана
						SetCVar("floatingCombatTextComboPoints", 0)
						SetCVar("floatingCombatTextDamageReduction", 0)
						SetCVar("floatingCombatTextDodgeParryMiss", 0)
						SetCVar("floatingCombatTextEnergyGains", 0)
						SetCVar("floatingCombatTextFloatMode", 0)
						SetCVar("floatingCombatTextFriendlyHealers", 0)
						SetCVar("floatingCombatTextHonorGains", 0)
						SetCVar("floatingCombatTextLowManaHealth", 0)
						SetCVar("floatingCombatTextPeriodicEnergyGains", 0)
						SetCVar("floatingCombatTextPetMeleeDamage", 0) --ТУТ
						SetCVar("floatingCombatTextPetSpellDamage", 0) --ТУТ
						SetCVar("floatingCombatTextReactives", 0)
						SetCVar("floatingCombatTextRepChanges", 0)
						SetCVar("floatingCombatTextSpellMechanics", 0)
						SetCVar("floatingCombatTextSpellMechanicsOther", 0)
						SetCVar("guildMemberNotify", 0)--1 окно уведомлений бнет
						SetCVar("lastRenownForCovenant1", 40)
						SetCVar("lastRenownForCovenant2", 40)
						SetCVar("lastRenownForCovenant3", 40)
						SetCVar("lastRenownForCovenant4", 40)
						SetCVar("lastRenownForMajorFaction2503", 1)
						SetCVar("lastRenownForMajorFaction2507", 1)
						SetCVar("lastRenownForMajorFaction2510", 1)
						SetCVar("lastRenownForMajorFaction2511", 1)
						SetCVar("mapFade", 0) --прозрачность карты в движении
						SetCVar("NamePlateClassificationScale", 1) --1.25
						SetCVar("nameplateGlobalScale", 1)
						SetCVar("NamePlateHorizontalScale", 1)-- 0.1 мелкий 1 дефотл 1.4 большая
						SetCVar("nameplateLargerScale", 1.2) -- 1.2 DEF FOR IMPORTANT MONSTERS
						SetCVar("nameplateLargeTopInset", 0.1) --0.10 От края экрана
						SetCVar("nameplateMaxAlpha", 0.6) -- меняет прозрачность неймплейтов которые не являются текущей целью, хз может что еще меняет
						SetCVar("nameplateMaxDistance", 60) --60 --максимальная дальность отображения неймплейтов
						SetCVar("NamePlateMaximumClassificationScale", 1)
						SetCVar("nameplateMaxScale", 1)
						SetCVar("nameplateMaxScaleDistance", 10)
						SetCVar("nameplateMinAlpha", 0.6)
						SetCVar("nameplateMinAlphaDistance", 10)
						SetCVar("nameplateMinScale", 1)
						SetCVar("nameplateMotion", 1) --(0 Наложение) (1 Друг над другом)
						SetCVar("nameplateMotionSpeed", 0.025)
						SetCVar("nameplateOccludedAlphaMult", 0.4)
						SetCVar("nameplateOverlapV", 1.1) --если выключено наложение нейплейтов (интерфейс-имена-друг над другом включено), то эта переменная указывает расстояние между неймплейтами по вертикали
						SetCVar("NameplatePersonalHideDelayAlpha", 0.45)
						SetCVar("NameplatePersonalHideDelaySeconds", 3)
						SetCVar("NameplatePersonalShowInCombat", 1)
						SetCVar("nameplateResourceOnTarget", 0)
						SetCVar("nameplateSelectedAlpha", 1)
						SetCVar("nameplateSelectedScale", 1.2) --Размер таргета --масштабирование неймплейта, который является текущей целью
						SetCVar("nameplateSelfAlpha", 0.75)
						SetCVar("nameplateSelfScale", 1)
						SetCVar("nameplateShowAll", 1)
						SetCVar("nameplateShowDebuffsOnFriendly", 1)
						SetCVar("nameplateShowEnemyGuardians", 0)
						SetCVar("nameplateShowEnemyMinions", 0)
						SetCVar("nameplateShowEnemyPets", 0)
						SetCVar("nameplateShowEnemyTotems", 1)
						SetCVar("nameplateShowFriends", 0)--1 отображение френдли немплейта 1вкл 0 выкл (самая полоса с именем)
						SetCVar("nameplateShowOnlyNames", 0)  --1 убирает ХП бар (френдли и энеми) лишь ctrl+V
						SetCVar("nameplateShowSelf", 0) --- PIZDA
						SetCVar("nameplateTargetBehindMaxDistance", 30)
						SetCVar("nameplateVerticalScale", 1)--0.1 мелкий 1 дефолт 2.7 большая
						SetCVar("profanityFilter", 0) --выключает фильтр нецензурной речи
						SetCVar("ScriptErrors", 0)
						SetCVar("scriptErrors", 0)
						SetCVar("scriptWarnings", 0)
						SetCVar("ShowClassColorInFriendlyNameplate", 1)
						SetCVar("ShowClassColorInNameplate", 1)
						SetCVar("showLootSpam", 1)
						SetCVar("showTamers", 0) --показывает петов на карте
						SetCVar("showToastWindow", 0)--1 окно уведомлений бнет
						SetCVar("Sound_MaxCacheSizeInBytes", 134217728)--67108864)
						SetCVar("Sound_NumChannels", 64)
						SetCVar("spellActivationOverlayOpacity", 0) --интерфейс - бой - предупреждения
						SetCVar("spellqueuewindow", 140)
						SetCVar("StatusText", 0)
						SetCVar("StatusTextDisplay", "NONE") -- NONE
						SetCVar("timeMgrUseLocalTime", 1) --локал время
						SetCVar("uiScale", 0.7111111111111111)
						SetCVar("UnitNameEnemyGuardianName", 1)
						SetCVar("UnitNameEnemyMinionName", 1)
						SetCVar("UnitNameEnemyPetName", 0)
						SetCVar("UnitNameEnemyPlayerName", 1)
						SetCVar("UnitNameEnemyTotemName", 1)
						SetCVar("UnitNameForceHideMinus", 0)
						SetCVar("UnitNameFriendlyGuardianName", 1)
						SetCVar("UnitNameFriendlyMinionName", 1)
						SetCVar("UnitNameFriendlyPetName", 0)
						SetCVar("UnitNameFriendlyPlayerName", 1)
						SetCVar("UnitNameFriendlySpecialNPCName", 1)
						SetCVar("UnitNameFriendlyTotemName", 1)
						SetCVar("UnitNameGuildTitle", 0)
						SetCVar("UnitNameHostleNPC", 1)
						SetCVar("UnitNameInteractiveNPC", 1)
						SetCVar("UnitNameNPC", 1)
						SetCVar("UnitNameOwn", 0)
						SetCVar("UnitNamePlayerGuild", 0)
						SetCVar("UnitNamePlayerPVPTitle", 0)
						SetCVar("useUiScale", 1)
						SetCVar("WorldTextScale", 0.7111111111111111)
						SetCVar("xpBarText", 1)
						-- SetCVar("gameTip", 120)
						-- SetCVar("closedExtraAbilityTutorials", 1)
						-- SetCVar("covenantMissionTutorial", 1)
						-- SetCVar("lastGarrisonMissionTutorial", 8)
						-- SetCVar("lastVoidStorageTutorial", 3)
						-- SetCVar("orderHallMissionTutorial", 851970)
						-- SetCVar("shipyardMissionTutorialAreaBuff", 0)
						-- SetCVar("shipyardMissionTutorialBlocade", 1)
						-- SetCVar("shipyardMissionTutorialFirst", 1)
						-- SetCVar("showNPETutorials", 1)
						-- SetCVar("showTutorials", 0)
						-- SetCVar("soulbindsActivatedTutorial", 1)
						-- SetCVar("soulbindsLandingPageTutorial", 1)
						-- SetCVar("soulbindsViewedTutorial", 1)
						-- SetCVar("Sound_EnableMusic", 1)
						-- SetCVar("Sound_EnableAmbience", 1)
						-- SetCVar("Sound_EnableDialog", 1)
						-- SetCVar("Sound_EnableSFX", 1)
						-- SetCVar("chatStyle", classic)
						-- SetCVar("whisperMode", popout_and_inline)
						-- C_NamePlate.SetNamePlateFriendlySize(0.1, 0.1) --короткий ХП бар 50 100
				end)
			end
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--USABLEITEMS
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.UsableItems then
			local UnitLevel = UnitLevel("PLAYER")
			local scale = WorldFrame:GetWidth() / GetPhysicalScreenSize() / UIParent:GetScale()
			local bytetoB64 = {
				[0]="a", "b", "c", "d", "e", "f", "g", "h",
				"i", "j", "k", "l", "m", "n", "o", "p",
				"q", "r", "s", "t", "u", "v", "w", "x",
				"y", "z", "A", "B", "C", "D", "E", "F",
				"G", "H", "I", "J", "K", "L", "M", "N",
				"O", "P", "Q", "R", "S", "T", "U", "V",
				"W", "X", "Y", "Z", "0", "1", "2", "3",
				"4", "5", "6", "7", "8", "9", "(", ")"
			}
			function GenerateUniqueID()
				local s = {}
				for i=1, 11 do
					tinsert(s, bytetoB64[math.random(0, 63)])
				end
				return table.concat(s)
			end
			local white_list = {
				-- TEST
				206006, 5523,7973,21746,50160,54537,93724,111956,128313,136926,166297,168740,171209,171210,178040,178128,180085,180355,180592,180646,180647,180648,180649,180974,180976,180980,181372,181475,181476,181556,181557,181732,181733,181741,183699,183702,183703,184045,184046,184047,184048,184395,184522,184630,184631,184632,184633,184634,184635,184636,184637,184638,184639,184640,184641,184642,184643,184644,184645,184646,184647,184648,184843,184868,184869,185832,185972,185990,185991,185992,185993,186196,186531,186533,186650,186680,186688,186691,186693,186705,186706,186707,186708,186970,187028,187029,187278,187351,187354,187440,187543,187551,187569,187570,187571,187572,187573,187574,187575,187576,187577,187781,187787,189765,190178,190339,190610,190655,190656,191040,191139,191303,191701,192130,192131,192132,192892,192893,193891,193897,193898,193899,193900,193901,193902,193903,193904,193905,193907,193909,193910,193913,194039,194040,194041,194054,194055,194061,194062,194063,194064,194066,194067,194068,194072,194076,194077,194078,194079,194080,194081,194337,194697,194698,194699,194700,194702,194703,194704,194708,198395,198438,198454,198510,198599,198606,198607,198608,198609,198610,198611,198612,198613,198614,198656,198658,198659,198660,198662,198663,198664,198667,198669,198670,198680,198682,198683,198684,198685,198686,198687,198690,198692,198693,198696,198697,198699,198702,198703,198704,198710,198711,198712,198789,198791,198837,198841,198863,198864,198865,198866,198867,198868,198869,198963,198964,198965,198966,198967,198968,198969,198970,198971,198972,198973,198974,198975,198976,198977,198978,199115,199122,199128,199192,199197,199472,199473,199474,199475,200069,200070,200072,200073,200095,200156,200285,200287,200288,200289,200300,200452,200453,200454,200455,200468,200513,200515,200516,200609,200610,200611,200677,200678,200972,200973,200974,200975,200976,200977,200978,200979,200980,200981,200982,201003,201004,201005,201006,201007,201008,201009,201010,201011,201012,201013,201014,201015,201016,201017,201018,201019,201020,201023,201250,201268,201269,201270,201271,201272,201273,201274,201275,201276,201277,201278,201279,201280,201281,201282,201283,201284,201285,201286,201287,201288,201289,201300,201301,201326,201343,201352,201353,201439,201462,201700,201705,201706,201708,201709,201710,201711,201712,201713,201714,201715,201716,201717,201728,201754,201755,201756,201781,201782,201817,201921,201922,201923,201924,202011,202014,202016,202052,202054,202055,202056,202057,202058,202079,202080,202091,202092,202093,202094,202097,202098,202142,202171,202172,202371,202667,202668,202669,202670,203217,203220,203222,203224,203476,203681,203699,203700,203702,204222,204224,204225,204226,204227,204228,204229,204230,204231,204232,204233,204359,204378,204379,204380,204381,204383,204403,204469,204470,204471,204475,204480,204558,204559,204560,204573,204574,204575,204576,204577,204578,204579,204721,204722,204723,204724,204725,204726,204850,204853,204855,204911,204986,204987,204988,204990,205001,205211,205212,205213,205214,205216,205219,205226,205247,205248,205249,205250,205251,205253,205254,205288,205342,205346,205347,205348,205350,205351,205352,205353,205354,205355,205356,205357,205358,205365,205367,205368,205369,205370,205371,205372,205373,205374,205424,205425,205426,205427,205428,205429,205430,205431,205432,205433,205434,205435,205436,205437,205438,205439,205440,205441,205442,205443,205444,205445,205682,205964,205982,205983,205985,205986,205987,205988,205989,205991,205992,205998,206019,206025,206030,206031,206034,206035,206135,206136
			}
			local white_list_plus2 = {
				204717,
			}
			local white_list_plus15 = {
				204075,
				204076,
				204077,
				204078,
			}
			local white_list70 ={
				205423,
			}
			if UnitLevel == 70 then
				MergeTable(white_list, white_list70)
			end
			local UsableItems_Frame = CreateFrame("Button", AddonTitle..GenerateUniqueID(), UIParent, "SecureActionButtonTemplate,BackDropTemplate")
			UsableItems_Frame:Hide()
			UsableItems_Frame:SetSize(64*scale, 64*scale)
			UsableItems_Frame:SetPoint("TOPLEFT", 0, 0)
			UsableItems_Frame:SetBackdrop({ edgeFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 4})
			UsableItems_Frame:SetBackdropBorderColor(1, 1, 1, 1)
			UsableItems_Frame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
			UsableItems_Frame:SetAttribute("type", "macro")
			local texture = UsableItems_Frame:CreateTexture(nil, "BACKGROUND")
			UsableItems_Frame.icon = texture
			texture:SetAllPoints(UsableItems_Frame)
			texture:SetTexture(413587)
			local function UsableItemFrame_OnLoad()
				local EventFrame = CreateFrame("Frame", AddonTitle..GenerateUniqueID(), UIParent)
				EventFrame:Hide()
				EventFrame:RegisterEvent("PLAYER_LOGIN")
				EventFrame:RegisterEvent("BAG_UPDATE")
				EventFrame:SetScript("OnEvent", UsableItemFrame_OnEvent)
			end
			function UsableItemFrame_OnEvent(self, event)
				if event == "BAG_UPDATE" then
					UsableItemFrame()
				end
			end
			function UsableItemFrame()
				for _, itemID in ipairs(white_list) do
					UsableItems_Frame.itemID = itemID
					if GetItemCount(itemID) >= 1 then
						UsableItems_Frame:Show()
						UsableItems_Frame:SetAttribute("macrotext", "/use item:"..itemID)
						UsableItems_Frame.icon:SetTexture(select(10, GetItemInfo(itemID)) or 413587)
						local itemQuality = (select(3, GetItemInfo(itemID)))
						local r, g, b = GetItemQualityColor(itemQuality)
						UsableItems_Frame:SetBackdropBorderColor(r, g, b, 1)
						-- local color = CreateColor(r, g, b, 1);
						-- local name = color:WrapTextInColorCode(itemName)
						break
					elseif GetItemCount(itemID) == 0 then
						UsableItems_Frame:Hide()
						UsableItems_Frame.icon:SetTexture(413587)
					end
				end
			end
			E.UsableItems_Frame = UsableItems_Frame
			E.UsableItemFrame_OnLoad = UsableItemFrame_OnLoad
			E.UsableItemFrame = UsableItemFrame
			UsableItemFrame_OnLoad()
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--AUTO GOSSIP
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.TalkingHeadFrame then
			local Octo_AUTO_GOSSIP = CreateFrame("Frame", AddonTitle)
			Octo_AUTO_GOSSIP:RegisterEvent("GOSSIP_SHOW")
			Octo_AUTO_GOSSIP:SetScript("OnEvent", function(self, event, ...)
					if Octo_ToDo_DragonflyVars.config.AutoGossip and event == "GOSSIP_SHOW" then
						--https://wowpedia.fandom.com/wiki/Category:API_namespaces/C_GossipInfo
						local numQuests1 = C_GossipInfo.GetNumActiveQuests()
						local numQuests2 = C_GossipInfo.GetNumAvailableQuests()
						if numQuests1 > 0 or numQuests2 > 0 or InCombatLockdown() then
 							return
						end
						local UnitID = "TARGET"
						local guid = UnitGUID(UnitID)
						local First_Option = {
							[149626] = true,
							[167032] = true,
							[167298] = true,
							[167598] = true,
							[168441] = true,
							[171589] = true,
							[171787] = true,
							[171795] = true,
							[171821] = true,
							[184787] = true,
							[184795] = true,
							[184796] = true,
							[185894] = true,
							[187495] = true,
							[188868] = true,
							[189869] = true,
							[189895] = true,
							[192722] = true,
							[193127] = true,
							[194916] = true,
							[198927] = true,
							[199532] = true,
							[200987] = true,
							[204185] = true,
							[36939] = true,
							[37187] = true,
							[38995] = true,
							[4311] = true,
							[78423] = true,
							[78556] = true,
							[78563] = true,
							[80225] = true,
							[86775] = true,
							[91483] = true,
						}
						local Second_Option = {
							[201398] = true, -- 1 в городе
						}
						if guid and UnitGUID(UnitID):match("%a+") ~= "Player" then
							local info = C_GossipInfo.GetOptions()
							local targetNPCID = tonumber(UnitGUID(UnitID):match("-(%d+)-%x+$"), 10)
							for i, v in ipairs(info) do
								if
								v.name == "Выбрать временную линию." or
								v.name:find("Попробовать") or
								v.name:find("Кинуук") or
								v.name:find("Нужно добавить") or
								v.name:find("taste") or
								v.name:find("Задание") or
								v.name:find("cff0000FF")
								and not IsShiftKeyDown() then
									C_GossipInfo.SelectOption(v.gossipOptionID)
									StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
									print ("|cFF00A3FFAUTO_GOSSIP SELECT:|r |cff00FF00("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t|cFFFF5771"..v.name.."|r")
								end
								if First_Option[targetNPCID] and not IsShiftKeyDown() then
									C_GossipInfo.SelectOption(v.gossipOptionID)
									StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
									print ("|cFF00A3FFAUTO_GOSSIP SELECT:|r |cff00FF00("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t|cFFFF5771"..v.name.."|r")
								end
								if Second_Option[targetNPCID] and not IsShiftKeyDown() and i == 2 then
									C_GossipInfo.SelectOption(v.gossipOptionID)
									StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
									print ("|cFF00A3FFAUTO_GOSSIP SELECT:|r |cff00FF00("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t|cFFFF5771"..v.name.."|r")
								end
								if #info == 1 and not IsShiftKeyDown() then
									C_GossipInfo.SelectOption(v.gossipOptionID)
									StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
								end
							end
						end
					end
			end)
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
-- AUTO INPUT DELET
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.InputDelete then
			local TypeDeleteLine = gsub(DELETE_GOOD_ITEM, "[\r\n]", "@")
			local void, TypeDeleteLine = strsplit("@", TypeDeleteLine, 2)
			StaticPopupDialogs["DELETE_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
			StaticPopupDialogs["DELETE_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
			StaticPopupDialogs["DELETE_QUEST_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
			StaticPopupDialogs["DELETE_QUEST_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
			StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
			StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
			local easyDelFrame = CreateFrame("FRAME")
			easyDelFrame:RegisterEvent("DELETE_ITEM_CONFIRM")
			easyDelFrame:SetScript("OnEvent", function()
					if StaticPopup1EditBox:IsShown() then
						StaticPopup1EditBox:Hide()
						StaticPopup1Button1:Enable()
						local link = select(3, GetCursorInfo())
						local linkType, linkOptions, name = LinkUtil.ExtractLink(link)
						if linkType == "battlepet" then
							local speciesID, level, breedQuality = strsplit(":", linkOptions)
							local qualityColor = BAG_ITEM_QUALITY_COLORS[tonumber(breedQuality)]
							link = qualityColor:WrapTextInColorCode(name .. " |n" .. L["Level"] .. " " .. level .. L["Battle Pet"])
						end
						StaticPopup1Text:SetText(gsub(StaticPopup1Text:GetText(), gsub(TypeDeleteLine, "@", ""), "") .. "|n" .. link)
					else
						StaticPopup1:SetHeight(StaticPopup1:GetHeight() + 40)
						StaticPopup1EditBox:Hide()
						StaticPopup1Button1:Enable()
						local link = select(3, GetCursorInfo())
						local linkType, linkOptions, name = LinkUtil.ExtractLink(link)
						if linkType == "battlepet" then
							local speciesID, level, breedQuality = strsplit(":", linkOptions)
							local qualityColor = BAG_ITEM_QUALITY_COLORS[tonumber(breedQuality)]
							link = qualityColor:WrapTextInColorCode(name .. " |n" .. L["Level"] .. " " .. level .. L["Battle Pet"])
						end
						StaticPopup1Text:SetText(gsub(StaticPopup1Text:GetText(), gsub(TypeDeleteLine, "@", ""), "") .. "|n|n" .. link)
					end
			end)
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--ClearChat
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.ClearChat then
			C_Timer.After(1, function()
				ChatFrame1:Clear()
			end)
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--ShowOnlyCurrentRealm
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.ShowOnlyCurrentRealm then
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--LevelToShow
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.LevelToShow then
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
