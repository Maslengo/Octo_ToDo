local AddonName, E = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
E.modules = {}
--------------------------------------------------------------------------------
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
			print ("|cffFF0000CVAR LOADED|r")
		end
end)