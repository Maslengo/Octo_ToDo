local AddonName, E = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
E.modules = {}
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
-- TalkingHeadFrame
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.TalkingHeadFrame then
			hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
					self:Hide()
					print(L["|cFF00A3FFTalking head frame|r |cffFF4C4Fcanceled.|r"])
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
				MajorFactionsRenownToast.ToastBG:SetAlpha(0)
				MajorFactionsRenownToast.IconSwirlModelScene:SetAlpha(0)
				MajorFactionsRenownToast.Icon:SetAlpha(0)
				MajorFactionsRenownToast.RenownLabel:SetAlpha(0)
				MajorFactionsRenownToast.RewardIcon:SetAlpha(0)
				MajorFactionsRenownToast.RewardIconRing:SetAlpha(0)
				MajorFactionsRenownToast.RewardDescription:SetAlpha(0)
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
			func_Octo_LoadAddOn("Pawn")
			func_Octo_LoadAddOn("Rarity")
			func_Octo_LoadAddOn("Rarity_Options")
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

						SetCVar("raidFramesDisplayAggroHighlight", 1)
						SetCVar("raidFramesDisplayClassColor", 1)
						SetCVar("raidFramesDisplayDebuffs", 1)
						SetCVar("raidFramesDisplayIncomingHeals",1)
						SetCVar("raidFramesDisplayOnlyDispellableDebuffs", 1)
						SetCVar("raidFramesDisplayPowerBars", 0)




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
						SetCVar("nameplateMotion", 0) --(0 Наложение) (1 Друг над другом) stack
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
				{itemid = 206006, count = 1},
				{itemid = 5523, count = 1},
				{itemid = 7973, count = 1},
				{itemid = 21746, count = 1},
				{itemid = 50160, count = 1},
				{itemid = 54537, count = 1},
				{itemid = 93724, count = 1},
				{itemid = 111956, count = 1},
				{itemid = 128313, count = 1},
				{itemid = 136926, count = 1},
				{itemid = 166297, count = 1},
				{itemid = 168740, count = 1},
				{itemid = 171209, count = 1},
				{itemid = 171210, count = 1},
				{itemid = 178040, count = 1},
				{itemid = 178128, count = 1},
				{itemid = 180085, count = 1},
				{itemid = 180355, count = 1},
				{itemid = 180592, count = 1},
				{itemid = 180646, count = 1},
				{itemid = 180647, count = 1},
				{itemid = 180648, count = 1},
				{itemid = 180649, count = 1},
				{itemid = 180974, count = 1},
				{itemid = 180976, count = 1},
				{itemid = 180980, count = 1},
				{itemid = 181372, count = 1},
				{itemid = 181475, count = 1},
				{itemid = 181476, count = 1},
				{itemid = 181556, count = 1},
				{itemid = 181557, count = 1},
				{itemid = 181732, count = 1},
				{itemid = 181733, count = 1},
				{itemid = 181741, count = 1},
				{itemid = 183699, count = 1},
				{itemid = 183702, count = 1},
				{itemid = 183703, count = 1},
				{itemid = 184045, count = 1},
				{itemid = 184046, count = 1},
				{itemid = 184047, count = 1},
				{itemid = 184048, count = 1},
				{itemid = 184395, count = 1},
				{itemid = 184522, count = 1},
				{itemid = 184630, count = 1},
				{itemid = 184631, count = 1},
				{itemid = 184632, count = 1},
				{itemid = 184633, count = 1},
				{itemid = 184634, count = 1},
				{itemid = 184635, count = 1},
				{itemid = 184636, count = 1},
				{itemid = 184637, count = 1},
				{itemid = 184638, count = 1},
				{itemid = 184639, count = 1},
				{itemid = 184640, count = 1},
				{itemid = 184641, count = 1},
				{itemid = 184642, count = 1},
				{itemid = 184643, count = 1},
				{itemid = 184644, count = 1},
				{itemid = 184645, count = 1},
				{itemid = 184646, count = 1},
				{itemid = 184647, count = 1},
				{itemid = 184648, count = 1},
				{itemid = 184843, count = 1},
				{itemid = 184868, count = 1},
				{itemid = 184869, count = 1},
				{itemid = 185832, count = 1},
				{itemid = 185972, count = 1},
				{itemid = 185990, count = 1},
				{itemid = 185991, count = 1},
				{itemid = 185992, count = 1},
				{itemid = 185993, count = 1},
				{itemid = 186196, count = 1},
				{itemid = 186531, count = 1},
				{itemid = 186533, count = 1},
				{itemid = 186650, count = 1},
				{itemid = 186680, count = 1},
				{itemid = 186688, count = 1},
				{itemid = 186691, count = 1},
				{itemid = 186693, count = 1},
				{itemid = 186705, count = 1},
				{itemid = 186706, count = 1},
				{itemid = 186707, count = 1},
				{itemid = 186708, count = 1},
				{itemid = 186970, count = 1},
				{itemid = 187028, count = 1},
				{itemid = 187029, count = 1},
				{itemid = 187278, count = 1},
				{itemid = 187351, count = 1},
				{itemid = 187354, count = 1},
				{itemid = 187440, count = 1},
				{itemid = 187543, count = 1},
				{itemid = 187551, count = 1},
				{itemid = 187569, count = 1},
				{itemid = 187570, count = 1},
				{itemid = 187571, count = 1},
				{itemid = 187572, count = 1},
				{itemid = 187573, count = 1},
				{itemid = 187574, count = 1},
				{itemid = 187575, count = 1},
				{itemid = 187576, count = 1},
				{itemid = 187577, count = 1},
				{itemid = 187781, count = 1},
				{itemid = 187787, count = 1},
				{itemid = 189765, count = 1},
				{itemid = 190178, count = 1},
				{itemid = 190339, count = 1},
				{itemid = 190610, count = 1},
				{itemid = 190655, count = 1},
				{itemid = 190656, count = 1},
				{itemid = 191040, count = 1},
				{itemid = 191139, count = 1},
				{itemid = 191303, count = 1},
				{itemid = 191701, count = 1},
				{itemid = 192130, count = 1},
				{itemid = 192131, count = 1},
				{itemid = 192132, count = 1},
				{itemid = 192892, count = 1},
				{itemid = 192893, count = 1},
				{itemid = 193891, count = 1},
				{itemid = 193897, count = 1},
				{itemid = 193898, count = 1},
				{itemid = 193899, count = 1},
				{itemid = 193900, count = 1},
				{itemid = 193901, count = 1},
				{itemid = 193902, count = 1},
				{itemid = 193903, count = 1},
				{itemid = 193904, count = 1},
				{itemid = 193905, count = 1},
				{itemid = 193907, count = 1},
				{itemid = 193909, count = 1},
				{itemid = 193910, count = 1},
				{itemid = 193913, count = 1},
				{itemid = 194039, count = 1},
				{itemid = 194040, count = 1},
				{itemid = 194041, count = 1},
				{itemid = 194054, count = 1},
				{itemid = 194055, count = 1},
				{itemid = 194061, count = 1},
				{itemid = 194062, count = 1},
				{itemid = 194063, count = 1},
				{itemid = 194064, count = 1},
				{itemid = 194066, count = 1},
				{itemid = 194067, count = 1},
				{itemid = 194068, count = 1},
				{itemid = 194072, count = 1},
				{itemid = 194076, count = 1},
				{itemid = 194077, count = 1},
				{itemid = 194078, count = 1},
				{itemid = 194079, count = 1},
				{itemid = 194080, count = 1},
				{itemid = 194081, count = 1},
				{itemid = 194337, count = 1},
				{itemid = 194697, count = 1},
				{itemid = 194698, count = 1},
				{itemid = 194699, count = 1},
				{itemid = 194700, count = 1},
				{itemid = 194702, count = 1},
				{itemid = 194703, count = 1},
				{itemid = 194704, count = 1},
				{itemid = 194708, count = 1},
				{itemid = 198395, count = 1},
				{itemid = 198438, count = 1},
				{itemid = 198454, count = 1},
				{itemid = 198510, count = 1},
				{itemid = 198599, count = 1},
				{itemid = 198606, count = 1},
				{itemid = 198607, count = 1},
				{itemid = 198608, count = 1},
				{itemid = 198609, count = 1},
				{itemid = 198610, count = 1},
				{itemid = 198611, count = 1},
				{itemid = 198612, count = 1},
				{itemid = 198613, count = 1},
				{itemid = 198614, count = 1},
				{itemid = 198656, count = 1},
				{itemid = 198658, count = 1},
				{itemid = 198659, count = 1},
				{itemid = 198660, count = 1},
				{itemid = 198662, count = 1},
				{itemid = 198663, count = 1},
				{itemid = 198664, count = 1},
				{itemid = 198667, count = 1},
				{itemid = 198669, count = 1},
				{itemid = 198670, count = 1},
				{itemid = 198680, count = 1},
				{itemid = 198682, count = 1},
				{itemid = 198683, count = 1},
				{itemid = 198684, count = 1},
				{itemid = 198685, count = 1},
				{itemid = 198686, count = 1},
				{itemid = 198687, count = 1},
				{itemid = 198690, count = 1},
				{itemid = 198692, count = 1},
				{itemid = 198693, count = 1},
				{itemid = 198696, count = 1},
				{itemid = 198697, count = 1},
				{itemid = 198699, count = 1},
				{itemid = 198702, count = 1},
				{itemid = 198703, count = 1},
				{itemid = 198704, count = 1},
				{itemid = 198710, count = 1},
				{itemid = 198711, count = 1},
				{itemid = 198712, count = 1},
				{itemid = 198789, count = 1},
				{itemid = 198791, count = 1},
				{itemid = 198837, count = 1},
				{itemid = 198841, count = 1},
				{itemid = 198863, count = 1},
				{itemid = 198864, count = 1},
				{itemid = 198865, count = 1},
				{itemid = 198866, count = 1},
				{itemid = 198867, count = 1},
				{itemid = 198868, count = 1},
				{itemid = 198869, count = 1},
				{itemid = 198963, count = 1},
				{itemid = 198964, count = 1},
				{itemid = 198965, count = 1},
				{itemid = 198966, count = 1},
				{itemid = 198967, count = 1},
				{itemid = 198968, count = 1},
				{itemid = 198969, count = 1},
				{itemid = 198970, count = 1},
				{itemid = 198971, count = 1},
				{itemid = 198972, count = 1},
				{itemid = 198973, count = 1},
				{itemid = 198974, count = 1},
				{itemid = 198975, count = 1},
				{itemid = 198976, count = 1},
				{itemid = 198977, count = 1},
				{itemid = 198978, count = 1},
				{itemid = 199115, count = 1},
				{itemid = 199122, count = 1},
				{itemid = 199128, count = 1},
				{itemid = 199192, count = 1},
				{itemid = 199197, count = 1},
				{itemid = 199472, count = 1},
				{itemid = 199473, count = 1},
				{itemid = 199474, count = 1},
				{itemid = 199475, count = 1},
				{itemid = 200069, count = 1},
				{itemid = 200070, count = 1},
				{itemid = 200072, count = 1},
				{itemid = 200073, count = 1},
				{itemid = 200095, count = 1},
				{itemid = 200156, count = 1},
				{itemid = 200285, count = 1},
				{itemid = 200287, count = 1},
				{itemid = 200288, count = 1},
				{itemid = 200289, count = 1},
				{itemid = 200300, count = 1},
				{itemid = 200452, count = 1},
				{itemid = 200453, count = 1},
				{itemid = 200454, count = 1},
				{itemid = 200455, count = 1},
				{itemid = 200468, count = 1},
				{itemid = 200513, count = 1},
				{itemid = 200515, count = 1},
				{itemid = 200516, count = 1},
				{itemid = 200609, count = 1},
				{itemid = 200610, count = 1},
				{itemid = 200611, count = 1},
				{itemid = 200677, count = 1},
				{itemid = 200678, count = 1},
				{itemid = 200972, count = 1},
				{itemid = 200973, count = 1},
				{itemid = 200974, count = 1},
				{itemid = 200975, count = 1},
				{itemid = 200976, count = 1},
				{itemid = 200977, count = 1},
				{itemid = 200978, count = 1},
				{itemid = 200979, count = 1},
				{itemid = 200980, count = 1},
				{itemid = 200981, count = 1},
				{itemid = 200982, count = 1},
				{itemid = 201003, count = 1},
				{itemid = 201004, count = 1},
				{itemid = 201005, count = 1},
				{itemid = 201006, count = 1},
				{itemid = 201007, count = 1},
				{itemid = 201008, count = 1},
				{itemid = 201009, count = 1},
				{itemid = 201010, count = 1},
				{itemid = 201011, count = 1},
				{itemid = 201012, count = 1},
				{itemid = 201013, count = 1},
				{itemid = 201014, count = 1},
				{itemid = 201015, count = 1},
				{itemid = 201016, count = 1},
				{itemid = 201017, count = 1},
				{itemid = 201018, count = 1},
				{itemid = 201019, count = 1},
				{itemid = 201020, count = 1},
				{itemid = 201023, count = 1},
				{itemid = 201250, count = 1},
				{itemid = 201268, count = 1},
				{itemid = 201269, count = 1},
				{itemid = 201270, count = 1},
				{itemid = 201271, count = 1},
				{itemid = 201272, count = 1},
				{itemid = 201273, count = 1},
				{itemid = 201274, count = 1},
				{itemid = 201275, count = 1},
				{itemid = 201276, count = 1},
				{itemid = 201277, count = 1},
				{itemid = 201278, count = 1},
				{itemid = 201279, count = 1},
				{itemid = 201280, count = 1},
				{itemid = 201281, count = 1},
				{itemid = 201282, count = 1},
				{itemid = 201283, count = 1},
				{itemid = 201284, count = 1},
				{itemid = 201285, count = 1},
				{itemid = 201286, count = 1},
				{itemid = 201287, count = 1},
				{itemid = 201288, count = 1},
				{itemid = 201289, count = 1},
				{itemid = 201300, count = 1},
				{itemid = 201301, count = 1},
				{itemid = 201326, count = 1},
				{itemid = 201343, count = 1},
				{itemid = 201352, count = 1},
				{itemid = 201353, count = 1},
				{itemid = 201439, count = 1},
				{itemid = 201462, count = 1},
				{itemid = 201700, count = 1},
				{itemid = 201705, count = 1},
				{itemid = 201706, count = 1},
				{itemid = 201708, count = 1},
				{itemid = 201709, count = 1},
				{itemid = 201710, count = 1},
				{itemid = 201711, count = 1},
				{itemid = 201712, count = 1},
				{itemid = 201713, count = 1},
				{itemid = 201714, count = 1},
				{itemid = 201715, count = 1},
				{itemid = 201716, count = 1},
				{itemid = 201717, count = 1},
				{itemid = 201728, count = 1},
				{itemid = 201754, count = 1},
				{itemid = 201755, count = 1},
				{itemid = 201756, count = 1},
				{itemid = 201781, count = 1},
				{itemid = 201782, count = 1},
				{itemid = 201817, count = 1},
				{itemid = 201921, count = 1},
				{itemid = 201922, count = 1},
				{itemid = 201923, count = 1},
				{itemid = 201924, count = 1},
				{itemid = 202011, count = 1},
				{itemid = 202014, count = 1},
				{itemid = 202016, count = 1},
				{itemid = 202052, count = 1},
				{itemid = 202054, count = 1},
				{itemid = 202055, count = 1},
				{itemid = 202056, count = 1},
				{itemid = 202057, count = 1},
				{itemid = 202058, count = 1},
				{itemid = 202079, count = 1},
				{itemid = 202080, count = 1},
				{itemid = 202091, count = 1},
				{itemid = 202092, count = 1},
				{itemid = 202093, count = 1},
				{itemid = 202094, count = 1},
				{itemid = 202097, count = 1},
				{itemid = 202098, count = 1},
				{itemid = 202142, count = 1},
				{itemid = 202171, count = 1},
				{itemid = 202172, count = 1},
				{itemid = 202371, count = 1},
				{itemid = 202667, count = 1},
				{itemid = 202668, count = 1},
				{itemid = 202669, count = 1},
				{itemid = 202670, count = 1},
				{itemid = 203217, count = 1},
				{itemid = 203220, count = 1},
				{itemid = 203222, count = 1},
				{itemid = 203224, count = 1},
				{itemid = 203476, count = 1},
				{itemid = 203681, count = 1},
				{itemid = 203699, count = 1},
				{itemid = 203700, count = 1},
				{itemid = 203702, count = 1},
				{itemid = 204222, count = 1},
				{itemid = 204224, count = 1},
				{itemid = 204225, count = 1},
				{itemid = 204226, count = 1},
				{itemid = 204227, count = 1},
				{itemid = 204228, count = 1},
				{itemid = 204229, count = 1},
				{itemid = 204230, count = 1},
				{itemid = 204231, count = 1},
				{itemid = 204232, count = 1},
				{itemid = 204233, count = 1},
				{itemid = 204359, count = 1},
				{itemid = 204378, count = 1},
				{itemid = 204379, count = 1},
				{itemid = 204380, count = 1},
				{itemid = 204381, count = 1},
				{itemid = 204383, count = 1},
				{itemid = 204403, count = 1},
				{itemid = 204469, count = 1},
				{itemid = 204470, count = 1},
				{itemid = 204471, count = 1},
				{itemid = 204475, count = 1},
				{itemid = 204480, count = 1},
				{itemid = 204558, count = 1},
				{itemid = 204559, count = 1},
				{itemid = 204560, count = 1},
				{itemid = 204573, count = 1},
				{itemid = 204574, count = 1},
				{itemid = 204575, count = 1},
				{itemid = 204576, count = 1},
				{itemid = 204577, count = 1},
				{itemid = 204578, count = 1},
				{itemid = 204579, count = 1},
				{itemid = 204721, count = 1},
				{itemid = 204722, count = 1},
				{itemid = 204723, count = 1},
				{itemid = 204724, count = 1},
				{itemid = 204725, count = 1},
				{itemid = 204726, count = 1},
				{itemid = 204850, count = 1},
				{itemid = 204853, count = 1},
				{itemid = 204855, count = 1},
				{itemid = 204911, count = 1},
				{itemid = 204986, count = 1},
				{itemid = 204987, count = 1},
				{itemid = 204988, count = 1},
				{itemid = 204990, count = 1},
				{itemid = 205001, count = 1},
				{itemid = 205211, count = 1},
				{itemid = 205212, count = 1},
				{itemid = 205213, count = 1},
				{itemid = 205214, count = 1},
				{itemid = 205216, count = 1},
				{itemid = 205219, count = 1},
				{itemid = 205226, count = 1},
				{itemid = 205247, count = 1},
				{itemid = 205248, count = 1},
				{itemid = 205249, count = 1},
				{itemid = 205250, count = 1},
				{itemid = 205251, count = 1},
				{itemid = 205253, count = 1},
				{itemid = 205254, count = 1},
				{itemid = 205288, count = 1},
				{itemid = 205342, count = 1},
				{itemid = 205346, count = 1},
				{itemid = 205347, count = 1},
				{itemid = 205348, count = 1},
				{itemid = 205350, count = 1},
				{itemid = 205351, count = 1},
				{itemid = 205352, count = 1},
				{itemid = 205353, count = 1},
				{itemid = 205354, count = 1},
				{itemid = 205355, count = 1},
				{itemid = 205356, count = 1},
				{itemid = 205357, count = 1},
				{itemid = 205358, count = 1},
				{itemid = 205365, count = 1},
				{itemid = 205367, count = 1},
				{itemid = 205368, count = 1},
				{itemid = 205369, count = 1},
				{itemid = 205370, count = 1},
				{itemid = 205371, count = 1},
				{itemid = 205372, count = 1},
				{itemid = 205373, count = 1},
				{itemid = 205374, count = 1},
				{itemid = 205424, count = 1},
				{itemid = 205425, count = 1},
				{itemid = 205426, count = 1},
				{itemid = 205427, count = 1},
				{itemid = 205428, count = 1},
				{itemid = 205429, count = 1},
				{itemid = 205430, count = 1},
				{itemid = 205431, count = 1},
				{itemid = 205432, count = 1},
				{itemid = 205433, count = 1},
				{itemid = 205434, count = 1},
				{itemid = 205435, count = 1},
				{itemid = 205436, count = 1},
				{itemid = 205437, count = 1},
				{itemid = 205438, count = 1},
				{itemid = 205439, count = 1},
				{itemid = 205440, count = 1},
				{itemid = 205441, count = 1},
				{itemid = 205442, count = 1},
				{itemid = 205443, count = 1},
				{itemid = 205444, count = 1},
				{itemid = 205445, count = 1},
				{itemid = 205682, count = 1},
				{itemid = 205964, count = 1},
				{itemid = 205983, count = 1},
				{itemid = 205985, count = 1},
				{itemid = 205986, count = 1},
				{itemid = 205987, count = 1},
				{itemid = 205988, count = 1},
				{itemid = 205989, count = 1},
				{itemid = 205991, count = 1},
				{itemid = 205992, count = 1},
				{itemid = 205998, count = 1},
				{itemid = 206019, count = 1},
				{itemid = 206025, count = 1},
				{itemid = 206030, count = 1},
				{itemid = 206031, count = 1},
				{itemid = 206034, count = 1},
				{itemid = 206035, count = 1},
				{itemid = 206135, count = 1},
				{itemid = 206136, count = 1},

				{itemid = 204717, count = 2}, --2

				{itemid = 204075, count = 15}, --15
				{itemid = 204076, count = 15}, --15
				{itemid = 204077, count = 15}, --15
				{itemid = 204078, count = 15}, --15

				{itemid = 204352, count = 50},
			}


			local white_list70 ={
				{itemid = 205423, count = 1},
				{itemid = 205966, count = 1},
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
				if not InCombatLockdown() then
					EventFrame:Hide()
					EventFrame:RegisterEvent("PLAYER_LOGIN")
					EventFrame:RegisterEvent("BAG_UPDATE")
					EventFrame:SetScript("OnEvent", UsableItemFrame_OnEvent)
				end
			end
			function UsableItemFrame_OnEvent(self, event)
				--local isGroup = IsInGroup(INSTANCE)
				if event == "BAG_UPDATE" and not InCombatLockdown() --[[and isGroup == false]] then
					UsableItemFrame()
				end
			end
			function UsableItemFrame()
				for _, v in pairs(white_list) do
					if GetItemCount(v.itemid) >= v.count then
						UsableItems_Frame:Show()
						UsableItems_Frame:SetAttribute("macrotext", "/use item:"..v.itemid)
						UsableItems_Frame.icon:SetTexture(select(10, GetItemInfo(v.itemid)) or 413587)
						local itemQuality = (select(3, GetItemInfo(v.itemid)) or 0)
						local r, g, b = GetItemQualityColor(itemQuality)
						UsableItems_Frame:SetBackdropBorderColor(r, g, b, 1)
						-- local color = CreateColor(r, g, b, 1)
						-- local name = color:WrapTextInColorCode(itemName)
						break
					elseif GetItemCount(v.itemid) <= (v.count-1) then
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
		if Octo_ToDo_DragonflyVars.config.AutoGossip then
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
							link = qualityColor:WrapTextInColorCode(name .. " |n" .. L["Level"] .. " " .. level .. " " .. L["Battle Pet"])
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
							link = qualityColor:WrapTextInColorCode(name .. " |n" .. L["Level"] .. " " .. level .. " " .. L["Battle Pet"])
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
--AutoSellGrey
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.AutoSellGrey then
		local function OnEvent(self, event)
			totalPrice = 0
			--for myBags = 0,4 do
			for myBags = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
				for bagSlots = 1, C_Container.GetContainerNumSlots(myBags) do
					CurrentItemLink = C_Container.GetContainerItemLink(myBags, bagSlots)
					if CurrentItemLink then
						_, _, itemRarity, _, _, _, _, _, _, _, itemSellPrice, classID, subclassID = GetItemInfo(CurrentItemLink)
						itemInfo = C_Container.GetContainerItemInfo(myBags, bagSlots)
						if itemRarity == 0 and itemSellPrice ~= 0 and classID ~= 2 and classID ~= 4 then
							totalPrice = totalPrice + (itemSellPrice * itemInfo.stackCount)
							C_Container.UseContainerItem(myBags, bagSlots)
							PickupMerchantItem()
						end
					end
				end
			end
			if totalPrice ~= 0 then
				print("|cFF00A3FFAutoSellGrey|r|cff00FF00 +".. GetCoinTextureString(totalPrice) .. "|r")
				--DEFAULT_CHAT_FRAME:AddMessage(AddonTitle .. L["Vendored gray items for: "]..GetCoinTextureString(totalPrice), 255, 255, 255)
			end
		end
		local f = CreateFrame("Frame")
		f:SetScript("OnEvent", OnEvent)
		f:RegisterEvent("MERCHANT_SHOW")
	end
end)
-- Consumable  0   Consumable  Enum.ItemConsumableSubclass
-- Container   1   Container
-- Weapon  2   Weapon  Enum.ItemWeaponSubclass
-- Gem 3   Gem Enum.ItemGemSubclass
-- Armor   4   Armor   Enum.ItemArmorSubclass
-- Reagent 5   Reagent Enum.ItemReagentSubclass    Obsolete
-- Projectile  6   Projectile      Obsolete
-- Tradegoods  7   Tradeskill
-- ItemEnhancement 8   Item Enhancement
-- Recipe  9   Recipe  Enum.ItemRecipeSubclass
-- CurrencyTokenObsolete   10  Money(OBSOLETE)
-- Quiver  11  Quiver      Obsolete
-- Questitem   12  Quest
-- Key 13  Key
-- PermanentObsolete   14  Permanent(OBSOLETE)
-- Miscellaneous   15  Miscellaneous   Enum.ItemMiscellaneousSubclass
-- Glyph   16  Glyph
-- Battlepet   17  Battle Pets Enum.BattlePetTypes
-- WoWToken    18  WoW Token
-- Profession  19  Profession  Enum.ItemProfessionSubclass Added in 10.0.0



----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--AutoRepair
tinsert(E.modules, function()
	if Octo_ToDo_DragonflyVars.config.AutoRepair then
		local function OnEvent(self, event)
			if (CanMerchantRepair()) then
				repairAllCost, canRepair = GetRepairAllCost()
				-- If merchant can repair and there is something to repair
				if (canRepair and repairAllCost > 0) then
					costTextureString = GetCoinTextureString(repairAllCost)
					-- Use Guild Bank
					guildRepairedItems = false
					if (IsInGuild() and CanGuildBankRepair()) then
						-- Checks if guild has enough money
						local amount = GetGuildBankWithdrawMoney()
						local guildBankMoney = GetGuildBankMoney()
						amount = amount == -1 and guildBankMoney or min(amount, guildBankMoney)
						if (amount >= repairAllCost) then
							RepairAllItems(true)
							guildRepairedItems = true
							print("|cFF00A3FFAutoRepair|r|cffFF4C4F -"..  costTextureString.."|r")
							--DEFAULT_CHAT_FRAME:AddMessage(AddonTitle .. L["Your items have been repaired using guild bank funds for: "]..costTextureString, 255, 255, 255)
						end
					end
					-- Use own funds
					if (repairAllCost <= GetMoney() and not guildRepairedItems) then
						RepairAllItems(false)
						print("|cFF00A3FFAutoRepair|r|cffFF4C4F -".. costTextureString.."|r")
						--DEFAULT_CHAT_FRAME:AddMessage(AddonTitle .. L["Your items have been repaired for: "]..costTextureString, 255, 255, 255)
					end
				end
			end
		end
		local f = CreateFrame("Frame")
		f:SetScript("OnEvent", OnEvent)
		f:RegisterEvent("MERCHANT_SHOW")
	end
end)

----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--Addon_curWidth
tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.Addon_curWidth then
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------