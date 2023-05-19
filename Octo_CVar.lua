local AddonName, E = ...

tinsert(E.modules, function()
		if Octo_ToDo_DragonflyVars.config.CVar then
			local isElfUI = IsAddOnLoaded("ElvUI")
			if isElfUI == true and not InCombatLockdown() then
				C_Timer.After(1, function()
						-- print (C_Container.GetSortBagsRightToLeft()," Должен быть false")
						C_Container.SetSortBagsRightToLeft(false)
						-- print (C_Container.GetInsertItemsLeftToRight()," Должен быть true")
						C_Container.SetInsertItemsLeftToRight(false)
						--C_Container.SortBags() сортит как для дефолтного
				end)
			end
			if isElfUI == false and not InCombatLockdown() then
				C_Timer.After(1, function()
						-- print (C_Container.GetSortBagsRightToLeft()," Должен быть false")
						C_Container.SetSortBagsRightToLeft(false)
						-- print (C_Container.GetInsertItemsLeftToRight()," Должен быть true")
						C_Container.SetInsertItemsLeftToRight(false)
						C_Container.SortBags()
				end)
			end
			if not InCombatLockdown() then
				C_Timer.After(1, function()  -- need to wait a bitC_Timer.After(1, function()
						SetCVar("lastRenownForMajorFaction2503", 1)
						SetCVar("lastRenownForMajorFaction2507", 1)
						SetCVar("lastRenownForMajorFaction2510", 1)
						SetCVar("lastRenownForMajorFaction2511", 1)
						SetCVar("lastRenownForCovenant1", 40)
						SetCVar("lastRenownForCovenant2", 40)
						SetCVar("lastRenownForCovenant3", 40)
						SetCVar("lastRenownForCovenant4", 40)
						--local FontTTF= [[Interface\Addons\Octo_ToDo_Dragonfly\Media\font\01 Octo.TTF]]
						--     local FontTTF= [[Interface\AddOns\Octo_SharedMedia\font\01 Octo.TTF]]
						--     local FontSize = 9
						--     -- local FontOutline = nil
						--     local FontOutline = "OUTLINE"
						--     -- local FontOutline = "THICKOUTLINE"
						--     -- local FontOutline = "MONOCHROME"
						--     hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
						--         if ShouldShowName(frame) then
						--             if frame.optionTable.colorNameBySelection then
						--                 local FrameUnitName = GetUnitName(frame.unit),false
						--                 local class, classFileName = UnitClass(frame.unit)
						--                 local colors = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[classFileName or "PRIEST"]
						--                 local name = colors:WrapTextInColorCode(WA_Utf8Sub(FrameUnitName,5))
						--                 local iconID=GetRaidTargetIndex(frame.unit)
						--                 local icon = ""
						--                 -- if iconID == "1" then icon = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t"
						--                 --     elseif iconID == "2" then icon = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t"
						--                 --     elseif iconID == "3" then icon = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t"
						--                 --     elseif iconID == "4" then icon = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t"
						--                 --     elseif iconID == "5" then icon = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t"
						--                 --     elseif iconID == "6" then icon = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t"
						--                 --     elseif iconID == "7" then icon = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:0|t"
						--                 --     elseif iconID == "8" then icon = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t"
						--                 -- end
						--                 if iconID then
						--                     frame.name:SetText(name..icon)
						--                 else
						--                     frame.name:SetText(name)
						--                 end
						--                 frame.name:SetFont(FontTTF, FontSize, FontOutline)
						--                 frame.name:SetAlpha(0.8)
						--                 frame.healthBar:SetAlpha(0)
						--                 frame.healthBar.border:SetAlpha(0)
						--                 frame.castBar:SetAlpha(0)
						--                 --frame.castBar.border:SetAlpha(0)
						--             end
						--             -- if frame.optionTable.softTargetBorderColor and
						--             --     (UnitIsUnit(frame.displayedUnit, "softenemy") or UnitIsUnit(frame.displayedUnit, "softfriend")) then
						--             --         frame.optionTable.softTargetBorderColor:GetRGBA()
						--             -- end
						--         end
						--     end)
						-- --     hooksecurefunc("CompactUnitFrameDropDown_Initialize", function(frame)
						-- --         -- if ShouldShowName(frame) then
						-- --         print ("qwe")
						-- --             frame.name:SetAlpha(0.1)
						-- --             -- end
						-- -- end)
						--     -- hooksecurefunc("CompactUnitFrame_UpdateRoleIcon", function(frame)
						--     --     if ShouldShowName(frame) then
						--     --     end
						--     -- end)
						SetCVar("nameplateShowFriends", 0)--1 отображение френдли немплейта 1вкл 0 выкл (самая полоса с именем)
						SetCVar("nameplateOverlapV", 1.1) --если выключено наложение нейплейтов (интерфейс-имена-друг над другом включено), то эта переменная указывает расстояние между неймплейтами по вертикали
						-- SetCVar("gameTip", 120)
						SetCVar("combinedBags", 1)  --/console combinedBags 1
						SetCVar("displayFreeBagSlots", 1) --отображает кол-во свободного места
						SetCVar("expandBagBar", 0)
						SetCVar("AllowDangerousScripts", 1)
						SetCVar("alwaysShowActionBars", 1)
						SetCVar("cameraSmoothStyle", 0) --не выравнивать камеру в движении
						SetCVar("NamePlateClassificationScale", 1) --1.25
						SetCVar("nameplateGlobalScale", 1)
						SetCVar("nameplateLargerScale", 1.2) -- 1.2 DEF FOR IMPORTANT MONSTERS
						SetCVar("nameplateLargeTopInset", 0.1) --0.10 От края экрана
						SetCVar("nameplateMaxAlpha", 0.6) -- меняет прозрачность неймплейтов которые не являются текущей целью, хз может что еще меняет
						SetCVar("nameplateMinAlpha", 0.6)
						SetCVar("nameplateMaxDistance", 60) --60 --максимальная дальность отображения неймплейтов
						SetCVar("NamePlateMaximumClassificationScale", 1)
						SetCVar("nameplateMaxScale", 1)
						SetCVar("nameplateMaxScaleDistance", 10)

						SetCVar("nameplateMinAlphaDistance", 10)
						SetCVar("nameplateMinScale", 1)
						SetCVar("nameplateMotion", 1) --(0 Наложение) (1 Друг над другом)
						SetCVar("nameplateMotionSpeed", 0.025)
						SetCVar("nameplateOccludedAlphaMult", 0.4)
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
						SetCVar("nameplateShowOnlyNames", 0)  --1 убирает ХП бар (френдли и энеми) лишь ctrl+V
						SetCVar("nameplateShowSelf", 0) --- PIZDA
						SetCVar("nameplateTargetBehindMaxDistance", 30)
						--C_NamePlate.SetNamePlateFriendlySize(0.1, 0.1) --короткий ХП бар 50 100
						SetCVar("nameplateVerticalScale", 1)--0.1 мелкий 1 дефолт 2.7 большая
						SetCVar("NamePlateHorizontalScale", 1)-- 0.1 мелкий 1 дефотл 1.4 большая
						SetCVar("ShowClassColorInFriendlyNameplate", 1)
						SetCVar("ShowClassColorInNameplate", 1)
						SetCVar("spellActivationOverlayOpacity", 0) --интерфейс - бой - предупреждения
						SetCVar("timeMgrUseLocalTime", 1) --локал время
						--SetCVar("chatStyle", classic)
						--SetCVar("whisperMode", popout_and_inline)
						SetCVar("showToastWindow", 0)--1 окно уведомлений бнет
						SetCVar("guildMemberNotify", 0)--1 окно уведомлений бнет
						SetCVar("profanityFilter", 0) --выключает фильтр нецензурной речи
						--SetCVar("Sound_EnableMusic", 1)
						--SetCVar("Sound_EnableAmbience", 1)
						--SetCVar("Sound_EnableDialog", 1)
						--SetCVar("Sound_EnableSFX", 1)
						SetCVar("ffxDeath", 1) --во время смерти
						SetCVar("ffxGlow", 0) --мыло на экране
						SetCVar("ffxLingeringVenari", 1)
						SetCVar("ffxNether", 1) --во время атаки фей ласт фаза или инвиза
						SetCVar("ffxVenari", 1)
						SetCVar("autoLootDefault", 1) --автолут 1 вкл
						SetCVar("colorChatNamesByClass", 1)
						SetCVar("mapFade", 0) --прозрачность карты в движении
						SetCVar("showTamers", 0) --показывает петов на карте
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
						SetCVar("findYourselfAnywhere", 0)
						SetCVar("findYourselfMode", 0)
						SetCVar("WorldTextScale", 0.7111111111111111)
						SetCVar("floatingCombatTextCombatHealing", 0) --ТУТ
						SetCVar("floatingCombatTextCombatHealingAbsorbSelf", 0) --ТУТ
						SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 0) --ТУТ
						SetCVar("floatingCombatTextCombatDamage", 0) --ТУТ
						SetCVar("floatingCombatTextCombatDamageAllAutos", 0) --ТУТ
						SetCVar("floatingCombatTextCombatDamageDirectionalOffset", 0) --ТУТ
						SetCVar("floatingCombatTextCombatDamageDirectionalScale", 0) --ТУТ
						SetCVar("floatingCombatTextPetMeleeDamage", 0) --ТУТ
						SetCVar("floatingCombatTextPetSpellDamage", 0) --ТУТ
						SetCVar("floatingCombatTextCombatLogPeriodicSpells", 0) --ТУТ Отображение урона от периодически действующих эффектов, таких как "Кровопускание" и "Слово Тьмы:Болль"
						SetCVar("floatingCombatTextAllSpellMechanics", 0)
						SetCVar("floatingCombatTextAuras", 0)
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
						SetCVar("floatingCombatTextReactives", 0)
						SetCVar("floatingCombatTextRepChanges", 0)
						SetCVar("floatingCombatTextSpellMechanics", 0)
						SetCVar("floatingCombatTextSpellMechanicsOther", 0)
						SetCVar("enableFloatingCombatText", 0) --НЕ надо, отображение на экране дополнительных сообщений
						SetCVar("enablePetBattleFloatingCombatText", 0)
						SetCVar("xpBarText", 1)
						SetCVar("useUiScale", 1)
						SetCVar("uiScale", 0.7111111111111111)
						--SetCVar("uiScale", 0.71)
						SetCVar("showLootSpam", 1)
						SetCVar("ScriptErrors", 0)
						SetCVar("Sound_NumChannels", 64)
						SetCVar("Sound_MaxCacheSizeInBytes", 134217728)--67108864)
						SetCVar("cameraDistanceMaxZoomFactor", 2.6)
						SetCVar("doNotFlashLowHealthWarning", 1)
						SetCVar("StatusText", 0)
						SetCVar("StatusTextDisplay", "NONE") -- NONE
						SetCVar("scriptErrors", 0)
						SetCVar("scriptWarnings", 0)
						SetCVar("spellqueuewindow", 140)
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
				end)
			end
			print ("|cffFF0000CVAR LOADED|r")
		end
end)