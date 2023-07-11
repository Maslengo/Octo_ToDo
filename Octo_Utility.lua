local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local function TableConcat(t1,t2)
	for i=1,#t2 do
		t1[#t1+1] = t2[i]
	end
	return t1
end
local isElvUI = IsAddOnLoaded("ElvUI")
local _, _, _, isRCLootCouncil = GetAddOnInfo("RCLootCouncil")
----------------------------------------------------------------------------------------------------------------------------------
local UnitLevel = UnitLevel("PLAYER")
----------------------------------------------------------------------------------------------------------------------------------
-- TalkingHeadFrame
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.TalkingHeadFrame then
			hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
					self:Hide()
					print(E.Octo_Func.func_Gradient("Talking Head Frame canceled", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color))
			end)
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--LootFrame
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.LootFrame then
			----------------------------------------------------------------------------------------------------------------------------------
			----------------------------------------------------------------------------------------------------------------------------------
			local OctoFrame_EventFrame = nil
			local Octo_Frame_Loot = nil
			local Octo_Frame_RCLootCouncil = nil

			if not OctoFrame_EventFrame then
				OctoFrame_EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
			end
			OctoFrame_EventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
			OctoFrame_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
			OctoFrame_EventFrame:RegisterEvent("ZONE_CHANGED")
			OctoFrame_EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
			if not InCombatLockdown() then
				OctoFrame_EventFrame:SetScript("OnEvent", function(...) Octo_Frame_OnEvent(...) end)
			end
			local normal_difficulty = 14
			local heroic_difficulty = 15
			local mythic_difficulty = 16
			local LFG_difficulty = 17
			-- https://wowpedia.fandom.com/wiki/DifficultyID
			--------------------------------------------------------------------------------
			if not Octo_Frame_Loot then
				Octo_Frame_Loot = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "SecureActionButtonTemplate,BackDropTemplate")
			end
			Octo_Frame_Loot:Hide()
			Octo_Frame_Loot:SetSize(24*E.Octo_Globals.scale, 24*E.Octo_Globals.scale)
			Octo_Frame_Loot:SetPoint("TOPLEFT", 64, 0)
			Octo_Frame_Loot:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
			Octo_Frame_Loot:SetBackdropBorderColor(0, 0, 0, 1)
			Octo_Frame_Loot:RegisterForClicks("LeftButtonUp")
			local texture = Octo_Frame_Loot:CreateTexture(nil, "BACKGROUND")
			Octo_Frame_Loot.icon = texture
			texture:SetAllPoints(Octo_Frame_Loot)
			texture:SetTexture(413587)
			Octo_Frame_Loot:Hide()
			Octo_Frame_Loot:SetScript("OnClick",
				function(_, button)
					GroupLootHistoryFrame:SetShown(not GroupLootHistoryFrame:IsShown())
			end)
			--if select(5, GetAddOnInfo("RCLootCouncil")) ~= "DISABLED" then
			--------------------------------------------------------------------------------
			if not Octo_Frame_RCLootCouncil then
				Octo_Frame_RCLootCouncil = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "SecureActionButtonTemplate,BackDropTemplate")
			end
			Octo_Frame_RCLootCouncil:Hide()
			Octo_Frame_RCLootCouncil:SetSize(24*E.Octo_Globals.scale, 24*E.Octo_Globals.scale)
			Octo_Frame_RCLootCouncil:SetPoint("TOPLEFT", 128, 0)
			Octo_Frame_RCLootCouncil:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
			Octo_Frame_RCLootCouncil:SetBackdropBorderColor(0, 0, 0, 1)
			Octo_Frame_RCLootCouncil:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
			local texture = Octo_Frame_RCLootCouncil:CreateTexture(nil, "BACKGROUND")
			Octo_Frame_RCLootCouncil.icon = texture
			texture:SetAllPoints(Octo_Frame_RCLootCouncil)
			texture:SetTexture(133785)
			Octo_Frame_RCLootCouncil:Hide()
			Octo_Frame_RCLootCouncil:SetAttribute("type", "macro")
			Octo_Frame_RCLootCouncil:SetAttribute("macrotext", "/rc open")
			--------------------------------------------------------------------------------
			function Octo_Frame_OnEvent(self, event, ...)
				if (event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA") and not InCombatLockdown() then
					local difficultyID = select(3, GetInstanceInfo()) or "|cffFF0000-|r"
					if difficultyID == 14 or difficultyID == 15 or difficultyID == 16 or difficultyID == 17 then
						if isRCLootCouncil and Octo_Frame_RCLootCouncil then
							Octo_Frame_RCLootCouncil:Show()
						end
						Octo_Frame_Loot:Show()
					end
					if (difficultyID ~= 14 and difficultyID ~= 15 and difficultyID ~= 16 and difficultyID ~= 17) then
						if isRCLootCouncil and Octo_Frame_RCLootCouncil then
							Octo_Frame_RCLootCouncil:Hide()
						end
						if Octo_Frame_Loot:IsShown() then
							Octo_Frame_Loot:Hide()
						end
					end
				end
			end
			if InCombatLockdown then
				if Octo_Frame_Loot and Octo_Frame_Loot:IsShown() then
					Octo_Frame_Loot:Hide()
				end
				if Octo_Frame_RCLootCouncil and Octo_Frame_RCLootCouncil:IsShown() then
					Octo_Frame_RCLootCouncil:Hide()
				end
			end
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--HideZoneText
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.HideZoneText then
			ZoneTextFrame:SetScript("OnShow", ZoneTextFrame.Hide);
			SubZoneTextFrame:SetScript("OnShow", SubZoneTextFrame.Hide);
			-- ZoneTextFrame:HookScript("OnShow", function(self, ...)
			-- ZoneTextFrame:UnregisterAllEvents()
			-- ZoneTextFrame:Hide()
			-- end)
			-- SubZoneTextFrame:HookScript("OnShow", function(self, ...)
			-- SubZoneTextFrame:UnregisterAllEvents()
			-- SubZoneTextFrame:Hide()
			-- end)
			PVPArenaTextString:HookScript("OnShow", function(self, ...)
					-- PVPArenaTextString:UnregisterAllEvents()
					PVPArenaTextString:Hide()
			end)
			ZoneTextString:HookScript("OnShow", function(self, ...)
					-- ZoneTextString:UnregisterAllEvents()
					ZoneTextString:Hide()
			end)
			SubZoneTextString:HookScript("OnShow", function(self, ...)
					-- SubZoneTextString:UnregisterAllEvents()
					SubZoneTextString:Hide()
			end)
			-- EventToastManagerFrame:HookScript("OnShow", function(self,...)
			-- EventToastManagerFrame:UnregisterAllEvents()
			-- EventToastManagerFrame:Hide()
			-- end)
			hooksecurefunc(EventToastManagerFrame, "Show", function()
					if not EventToastManagerFrame.HideButton:IsShown() then
						if EventToastManagerFrame.currentDisplayingToast then
							if IsInJailersTower() then
								-- Show floor summary
								local title = EventToastManagerFrame.currentDisplayingToast.Title:GetText() or nil
								if title and strfind(title, JAILERS_TOWER_SCENARIO_FLOOR) then
									-- Add right-click to close floor summary
									EventToastManagerFrame.currentDisplayingToast:SetScript("OnMouseDown", function(self, btn)
											if btn == "RightButton" then
												EventToastManagerFrame:CloseActiveToasts()
												return
											end
									end)
									return
								end
							end
							EventToastManagerFrame.currentDisplayingToast:OnAnimatedOut()
						end
					end
			end)
			-- func_Octo_LoadAddOn(Blizzard_MajorFactionRenownToast)
			--Blizzard_MajorFactionRenownToast.lua
			-- MajorFactionRenownToast.IconSwirlModelScene:Show()
			-- MajorFactionRenownToast.ToastBG:Show()
			-- MajorFactionRenownToast.RewardDescription:Show()
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--Covenant
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.Covenant then
			CovenantChoiceToast:UnregisterAllEvents()
			CovenantRenownToast:UnregisterAllEvents()
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--UIErrorsFrameScale
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.UIErrorsFrameScale then
			UIErrorsFrame:SetPoint("TOP", 0, -54)
			UIErrorsFrame:SetAlpha(0.7)
			--UIErrorsFrame:SetScale(.7111111111111111)
			-- UIErrorsFrame:Hide()
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--RaidBossEmoteFrame
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.RaidBossEmoteFrame then
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
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.CinematicCanceler then
			CinematicFrame:HookScript("OnShow", function(self, ...)
					if IsModifierKeyDown() then
					return end --если нажат модификатор, то запустится мувик
					print(E.Octo_Func.func_Gradient("Cinematic canceled", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color))
					CinematicFrame_CancelCinematic()
			end)
			local omfpf = _G["MovieFrame_PlayMovie"] --запускает мувик?
			_G["MovieFrame_PlayMovie"] = function(...)
				if IsModifierKeyDown() then
					return omfpf(...) end
				print(E.Octo_Func.func_Gradient("Movie canceled", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color))
				GameMovieFinished() return true
			end
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--BossBanner
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.BossBanner then
			BossBanner:HookScript("OnShow", function(self, ...)
					BossBanner:UnregisterEvent("ENCOUNTER_LOOT_RECEIVED")
					BossBanner:UnregisterEvent("BOSS_KILL")
					-- BossBanner:UnregisterAllEvents()
					-- BossBanner:Hide()
			end)
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
local function func_Octo_LoadAddOn(GlobalAddonName)
	if select(5, GetAddOnInfo(GlobalAddonName)) == "DISABLED" then
		EnableAddOn(GlobalAddonName)
		LoadAddOn(GlobalAddonName)
	end
end
func_Octo_LoadAddOn("!BugGrabber")
func_Octo_LoadAddOn("BugSack")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--AnotherAddonsCasual
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.AnotherAddonsCasual then
			func_Octo_LoadAddOn("AstralKeys")
			func_Octo_LoadAddOn("AutoTurnIn")
			func_Octo_LoadAddOn("MountsJournal")
			func_Octo_LoadAddOn("MountsJournal_ElvUI_Skin")
			func_Octo_LoadAddOn("HidingBar")
			func_Octo_LoadAddOn("HidingBar_Options")
			func_Octo_LoadAddOn("Postal")
			func_Octo_LoadAddOn("Simulationcraft")
			func_Octo_LoadAddOn("SpeedyAutoLoot")
			func_Octo_LoadAddOn("AdvancedInterfaceOptions")
			func_Octo_LoadAddOn("Pawn")
			func_Octo_LoadAddOn("Rarity")
			func_Octo_LoadAddOn("Rarity_Options")
			func_Octo_LoadAddOn("Plater")
			-- func_Octo_LoadAddOn("TalentTreeTweaks")
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
--AnotherAddonsRAID
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.AnotherAddonsRAID then
			func_Octo_LoadAddOn("AddOnSkins")
			func_Octo_LoadAddOn("BigWigs")
			func_Octo_LoadAddOn("BigWigs_Core")
			func_Octo_LoadAddOn("BigWigs_Plugins")
			func_Octo_LoadAddOn("BigWigs_Options")
			func_Octo_LoadAddOn("BigWigs_Aberrus")
			func_Octo_LoadAddOn("Details")
			func_Octo_LoadAddOn("ElvUI_Libraries")
			func_Octo_LoadAddOn("ElvUI")
			func_Octo_LoadAddOn("ElvUI_Options")
			func_Octo_LoadAddOn("OmniCC")
			func_Octo_LoadAddOn("OmniCC_Config")
			func_Octo_LoadAddOn("Pawn")
			func_Octo_LoadAddOn("Plater")
			func_Octo_LoadAddOn("SharedMedia")
			func_Octo_LoadAddOn("SharedMedia_Causese")
			func_Octo_LoadAddOn("SharedMedia_MyMedia")
			func_Octo_LoadAddOn("SharedMedia_Naowh")
			func_Octo_LoadAddOn("WeakAuras")
			func_Octo_LoadAddOn("WeakAurasArchive")
			func_Octo_LoadAddOn("WeakAurasModelPaths")
			func_Octo_LoadAddOn("WeakAurasOptions")
			func_Octo_LoadAddOn("WeakAurasTemplates")
			-- func_Octo_LoadAddOn("AdvancedInterfaceOptions")
			-- func_Octo_LoadAddOn("MRT")
			-- func_Octo_LoadAddOn("ExRT_Reminder")
			-- func_Octo_LoadAddOn("MountsJournal")
			-- func_Octo_LoadAddOn("OmniCD")
			-- func_Octo_LoadAddOn("Parrot")
			-- func_Octo_LoadAddOn("Postal")
			-- func_Octo_LoadAddOn("RCLootCouncil")
			-- func_Octo_LoadAddOn("Simulationcraft")
			-- func_Octo_LoadAddOn("TalentTreeTweaks")
			-- func_Octo_LoadAddOn("TrufiGCD")
			-- func_Octo_LoadAddOn("WagoAppCompanion")
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--CVAR
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.CVar then
			if isElvUI == true and not InCombatLockdown() then
				C_Timer.After(1, function()
						C_Container.SetSortBagsRightToLeft(false)
						C_Container.SetInsertItemsLeftToRight(false)
				end)
			end
			if isElvUI == false and not InCombatLockdown() then
				C_Timer.After(1, function()
						C_Container.SetSortBagsRightToLeft(false)
						C_Container.SetInsertItemsLeftToRight(false)
						C_Container.SortBags()
				end)
			end
			if InCombatLockdown() then print ("CAN't CVAR") end
			if not InCombatLockdown() then
				C_Timer.After(1, function()
						--SetCVar("questPOI", 101)
						SetCVar("alwaysCompareItems", 1)
						SetCVar("rotateMinimap", 0)
						SetCVar("showBattlefieldMinimap", 0)
						SetCVar("displaySpellActivationOverlays", 1)
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
						SetCVar("combinedBags", 1) --/console combinedBags 1
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
						SetCVar("floatingCombatTextCombatDamage", 1) --ТУТ
						SetCVar("floatingCombatTextCombatDamageAllAutos", 1) --ТУТ
						SetCVar("floatingCombatTextCombatDamageDirectionalOffset", 1) --ТУТ
						SetCVar("floatingCombatTextCombatDamageDirectionalScale", 1) --ТУТ
						SetCVar("floatingCombatTextCombatHealing", 1) --ТУТ
						SetCVar("floatingCombatTextCombatHealingAbsorbSelf", 1) --ТУТ
						SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 1) --ТУТ
						SetCVar("floatingCombatTextCombatLogPeriodicSpells", 1) --ТУТ Отображение урона от периодически действующих эффектов, таких как "Кровопускание" и "Слово Тьмы:Болль"
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
						SetCVar("floatingCombatTextPetMeleeDamage", 1) --ТУТ
						SetCVar("floatingCombatTextPetSpellDamage", 1) --ТУТ
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
						SetCVar("nameplateMotion", 1) --(0 Наложение) (1 Друг над другом) stack
						SetCVar("nameplateMotionSpeed", 0.025)
						SetCVar("nameplateOccludedAlphaMult", 0.4)
						SetCVar("nameplateOverlapV", 1) --если выключено наложение нейплейтов (интерфейс-имена-друг над другом включено), то эта переменная указывает расстояние между неймплейтами по вертикали
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
						SetCVar("nameplateShowOnlyNames", 1) --1 убирает ХП бар (френдли и энеми) лишь ctrl+V
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
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.UsableItems then
			local className, classFilename, classId = UnitClass("PLAYER")

			local function func_itemName(self)
				local itemName, _, itemQuality = GetItemInfo(self)
				if itemQuality then
					local r, g, b = GetItemQualityColor(itemQuality)
					local color = CreateColor(r, g, b, 1)
					local itemNameColored = color:WrapTextInColorCode(itemName)
					return itemNameColored or E.Octo_Globals.Red_Color..RETRIEVING_ITEM_INFO.."|r"
				end
				return itemName or E.Octo_Globals.Red_Color..RETRIEVING_ITEM_INFO.."|r"
			end
			local white_list = {
				-- https://www.wowhead.com/ru/item=205151/%D0%B8%D0%B7%D0%B2%D0%B8%D0%BB%D0%B8%D1%81%D0%BA#comments
				-- https://www.wowhead.com/ru/item=206009/ https://www.wowhead.com/ru/item=206010/ https://www.wowhead.com/ru/item=206014/
				-- https://www.wowhead.com/ru/item=206014/ https://www.wowhead.com/ru/item=206011/ https://www.wowhead.com/ru/item=206015/
				-- https://www.wowhead.com/ru/item=206015/ https://www.wowhead.com/ru/item=206012/ https://www.wowhead.com/ru/item=206016/
				-- https://www.wowhead.com/ru/item=206016/ https://www.wowhead.com/ru/item=206013/ https://www.wowhead.com/ru/item=206017/
				-- https://www.wowhead.com/ru/item=206017/ https://www.wowhead.com/ru/item=206021/ https://www.wowhead.com/ru/item=205151/
				{itemid = 157827, count = 1},
				{itemid = 111350, count = 1},
				{itemid = 202098, count = 1},
				{itemid = 202097, count = 1},
				{itemid = 202099, count = 1},
				{itemid = 202100, count = 1},
				{itemid = 202101, count = 1},
				{itemid = 114108, count = 1},
				{itemid = 201323, count = 1},
				{itemid = 204217, count = 1},
				{itemid = 128315, count = 1},
				{itemid = 180765, count = 1},
				{itemid = 186482, count = 1},
				{itemid = 181821, count = 1},
				{itemid = 182332, count = 1},
				{itemid = 186487, count = 1},
				{itemid = 186476, count = 1},
				{itemid = 186493, count = 1},
				{itemid = 186503, count = 1},
				{itemid = 186497, count = 1},
				{itemid = 186515, count = 1},
				{itemid = 186507, count = 1},
				{itemid = 111956, count = 1},
				{itemid = 114052, count = 1},
				{itemid = 114053, count = 1},
				{itemid = 117394, count = 1},
				{itemid = 128313, count = 1},
				{itemid = 130199, count = 1},
				{itemid = 136926, count = 1},
				{itemid = 139879, count = 1},
				{itemid = 141371, count = 1},
				{itemid = 141372, count = 1},
				{itemid = 147212, count = 1},
				{itemid = 147213, count = 1},
				{itemid = 147214, count = 1},
				{itemid = 147215, count = 1},
				{itemid = 147216, count = 1},
				{itemid = 147217, count = 1},
				{itemid = 147218, count = 1},
				{itemid = 147219, count = 1},
				{itemid = 147220, count = 1},
				{itemid = 147221, count = 1},
				{itemid = 147222, count = 1},
				{itemid = 147223, count = 1},
				{itemid = 147708, count = 1},
				{itemid = 147729, count = 1},
				{itemid = 152095, count = 1},
				{itemid = 152735, count = 1},
				{itemid = 152736, count = 1},
				{itemid = 152799, count = 1},
				{itemid = 153059, count = 1},
				{itemid = 153060, count = 1},
				{itemid = 153061, count = 1},
				{itemid = 153062, count = 1},
				{itemid = 153063, count = 1},
				{itemid = 153064, count = 1},
				{itemid = 153065, count = 1},
				{itemid = 153066, count = 1},
				{itemid = 153067, count = 1},
				{itemid = 153068, count = 1},
				{itemid = 153205, count = 1},
				{itemid = 153206, count = 1},
				{itemid = 153207, count = 1},
				{itemid = 153208, count = 1},
				{itemid = 153209, count = 1},
				{itemid = 153210, count = 1},
				{itemid = 153211, count = 1},
				{itemid = 153212, count = 1},
				{itemid = 153213, count = 1},
				{itemid = 153214, count = 1},
				{itemid = 153215, count = 1},
				{itemid = 153216, count = 1},
				{itemid = 156630, count = 1},
				{itemid = 166297, count = 1},
				{itemid = 168207, count = 1},
				{itemid = 168740, count = 1},
				{itemid = 170540, count = 1},
				{itemid = 171209, count = 1},
				{itemid = 171210, count = 1},
				{itemid = 174283, count = 1},
				{itemid = 174756, count = 6},
				{itemid = 174758, count = 6},
				{itemid = 174759, count = 6},
				{itemid = 174760, count = 6},
				{itemid = 174764, count = 6},
				{itemid = 175062, count = 1},
				{itemid = 176331, count = 1},
				{itemid = 176408, count = 1},
				{itemid = 176409, count = 1},
				{itemid = 176443, count = 1},
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
				{itemid = 182628, count = 1},
				{itemid = 182631, count = 1},
				{itemid = 182632, count = 1},
				{itemid = 182634, count = 1},
				{itemid = 182640, count = 1},
				{itemid = 183115, count = 1},
				{itemid = 183116, count = 1},
				{itemid = 183117, count = 1},
				{itemid = 183191, count = 1},
				{itemid = 183192, count = 1},
				{itemid = 183193, count = 1},
				{itemid = 183194, count = 1},
				{itemid = 183195, count = 1},
				{itemid = 183217, count = 1},
				{itemid = 183219, count = 1},
				{itemid = 183221, count = 1},
				{itemid = 183226, count = 1},
				{itemid = 183230, count = 1},
				{itemid = 183232, count = 1},
				{itemid = 183236, count = 1},
				{itemid = 183237, count = 1},
				{itemid = 183239, count = 1},
				{itemid = 183247, count = 1},
				{itemid = 183254, count = 1},
				{itemid = 183255, count = 1},
				{itemid = 183259, count = 1},
				{itemid = 183262, count = 1},
				{itemid = 183263, count = 1},
				{itemid = 183270, count = 1},
				{itemid = 183273, count = 1},
				{itemid = 183276, count = 1},
				{itemid = 183280, count = 1},
				{itemid = 183281, count = 1},
				{itemid = 183286, count = 1},
				{itemid = 183287, count = 1},
				{itemid = 183291, count = 1},
				{itemid = 183292, count = 1},
				{itemid = 183294, count = 1},
				{itemid = 183302, count = 1},
				{itemid = 183305, count = 1},
				{itemid = 183307, count = 1},
				{itemid = 183308, count = 1},
				{itemid = 183312, count = 1},
				{itemid = 183320, count = 1},
				{itemid = 183321, count = 1},
				{itemid = 183322, count = 1},
				{itemid = 183327, count = 1},
				{itemid = 183328, count = 1},
				{itemid = 183335, count = 1},
				{itemid = 183337, count = 1},
				{itemid = 183339, count = 1},
				{itemid = 183342, count = 1},
				{itemid = 183343, count = 1},
				{itemid = 183351, count = 1},
				{itemid = 183355, count = 1},
				{itemid = 183357, count = 1},
				{itemid = 183359, count = 1},
				{itemid = 183360, count = 1},
				{itemid = 183363, count = 1},
				{itemid = 183364, count = 1},
				{itemid = 183371, count = 1},
				{itemid = 183372, count = 1},
				{itemid = 183377, count = 1},
				{itemid = 183382, count = 1},
				{itemid = 183383, count = 1},
				{itemid = 183388, count = 1},
				{itemid = 183390, count = 1},
				{itemid = 183393, count = 1},
				{itemid = 183699, count = 1},
				{itemid = 183702, count = 1},
				{itemid = 183703, count = 1},
				{itemid = 184045, count = 1},
				{itemid = 184046, count = 1},
				{itemid = 184047, count = 1},
				{itemid = 184048, count = 1},
				{itemid = 184198, count = 1},
				{itemid = 184242, count = 1},
				{itemid = 184276, count = 1},
				{itemid = 184277, count = 1},
				{itemid = 184278, count = 1},
				{itemid = 184395, count = 1},
				{itemid = 184522, count = 1},
				{itemid = 184561, count = 1},
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
				{itemid = 184662, count = 1},
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
				-- {itemid = 186472, count = 1},
				{itemid = 186473, count = 1},
				{itemid = 186524, count = 1},
				{itemid = 186531, count = 1},
				{itemid = 186533, count = 1},
				{itemid = 186580, count = 1},
				{itemid = 186593, count = 1},
				{itemid = 186614, count = 1},
				{itemid = 186615, count = 1},
				{itemid = 186636, count = 1},
				{itemid = 186650, count = 1},
				{itemid = 186678, count = 1},
				{itemid = 186679, count = 1},
				{itemid = 186680, count = 1},
				{itemid = 186688, count = 1},
				{itemid = 186691, count = 1},
				{itemid = 186693, count = 1},
				{itemid = 186705, count = 1},
				{itemid = 186706, count = 1},
				{itemid = 186707, count = 1},
				{itemid = 186708, count = 1},
				{itemid = 186970, count = 1},
				{itemid = 186974, count = 1},
				{itemid = 187027, count = 1},
				{itemid = 187028, count = 1},
				{itemid = 187029, count = 1},
				{itemid = 187030, count = 1},
				{itemid = 187031, count = 1},
				{itemid = 187032, count = 1},
				{itemid = 187034, count = 1},
				{itemid = 187038, count = 1},
				{itemid = 187039, count = 1},
				{itemid = 187040, count = 1},
				{itemid = 187041, count = 1},
				{itemid = 187042, count = 1},
				{itemid = 187043, count = 1},
				{itemid = 187044, count = 1},
				{itemid = 187045, count = 1},
				{itemid = 187046, count = 1},
				{itemid = 187075, count = 1},
				{itemid = 187082, count = 1},
				{itemid = 187083, count = 1},
				{itemid = 187085, count = 1},
				{itemid = 187086, count = 1},
				{itemid = 187087, count = 1},
				{itemid = 187088, count = 1},
				{itemid = 187089, count = 1},
				{itemid = 187090, count = 1},
				{itemid = 187095, count = 1},
				{itemid = 187096, count = 1},
				{itemid = 187098, count = 1},
				{itemid = 187099, count = 1},
				{itemid = 187100, count = 1},
				{itemid = 187101, count = 1},
				{itemid = 187219, count = 6},
				{itemid = 187278, count = 1},
				{itemid = 187346, count = 1},
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
				{itemid = 187728, count = 10},
				{itemid = 187781, count = 1},
				{itemid = 187787, count = 1},
				{itemid = 187911, count = 1},
				{itemid = 188167, count = 1},
				{itemid = 188686, count = 1},
				{itemid = 188687, count = 1},
				{itemid = 188688, count = 1},
				{itemid = 188690, count = 1},
				{itemid = 188700, count = 1},
				{itemid = 188737, count = 1},
				{itemid = 188743, count = 1},
				{itemid = 188744, count = 1},
				{itemid = 188745, count = 1},
				{itemid = 188746, count = 1},
				{itemid = 188747, count = 1},
				{itemid = 188748, count = 1},
				{itemid = 188749, count = 1},
				{itemid = 188750, count = 1},
				{itemid = 188752, count = 1},
				{itemid = 188753, count = 1},
				{itemid = 189765, count = 1},
				{itemid = 190178, count = 1},
				{itemid = 188198, count = 1},
				-- {itemid = 190184, count = 1},
				{itemid = 190198, count = 5},
				{itemid = 190198, count = 5},
				{itemid = 190339, count = 1},
				{itemid = 190610, count = 1},
				{itemid = 190655, count = 1},
				{itemid = 190656, count = 1},
				{itemid = 190741, count = 1},
				{itemid = 190755, count = 1},
				{itemid = 190756, count = 1},
				{itemid = 190757, count = 1},
				{itemid = 190758, count = 1},
				{itemid = 190759, count = 1},
				{itemid = 190760, count = 1},
				{itemid = 190761, count = 1},
				{itemid = 190762, count = 1},
				{itemid = 190763, count = 1},
				{itemid = 190764, count = 1},
				{itemid = 190941, count = 1},
				{itemid = 191036, count = 1},
				{itemid = 191037, count = 1},
				{itemid = 191040, count = 1},
				{itemid = 191139, count = 1},
				{itemid = 191303, count = 1},
				{itemid = 191701, count = 1},
				{itemid = 192111, count = 1},
				{itemid = 192130, count = 1},
				{itemid = 192131, count = 1},
				{itemid = 192132, count = 1},
				{itemid = 192523, count = 1},
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
				{itemid = 194034, count = 1},
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
				{itemid = 194106, count = 1},
				{itemid = 194337, count = 1},
				{itemid = 194521, count = 1},
				{itemid = 194549, count = 1},
				{itemid = 194697, count = 1},
				{itemid = 194698, count = 1},
				{itemid = 194699, count = 1},
				{itemid = 194700, count = 1},
				{itemid = 194702, count = 1},
				{itemid = 194703, count = 1},
				{itemid = 194704, count = 1},
				{itemid = 194705, count = 1},
				{itemid = 194708, count = 1},
				{itemid = 194838, count = 1},
				{itemid = 196961, count = 1},
				{itemid = 196962, count = 1},
				{itemid = 196963, count = 1},
				{itemid = 196964, count = 1},
				{itemid = 196965, count = 1},
				{itemid = 196966, count = 1},
				{itemid = 196967, count = 1},
				{itemid = 196968, count = 1},
				{itemid = 196969, count = 1},
				{itemid = 196970, count = 1},
				{itemid = 196971, count = 1},
				{itemid = 196972, count = 1},
				{itemid = 196973, count = 1},
				{itemid = 196974, count = 1},
				{itemid = 196975, count = 1},
				{itemid = 196976, count = 1},
				{itemid = 196977, count = 1},
				{itemid = 196978, count = 1},
				{itemid = 196979, count = 1},
				{itemid = 196980, count = 1},
				{itemid = 196981, count = 1},
				{itemid = 196982, count = 1},
				{itemid = 196983, count = 1},
				{itemid = 196984, count = 1},
				{itemid = 196985, count = 1},
				{itemid = 196986, count = 1},
				{itemid = 196987, count = 1},
				{itemid = 196988, count = 1},
				{itemid = 196989, count = 1},
				{itemid = 196990, count = 1},
				{itemid = 196991, count = 1},
				{itemid = 196992, count = 1},
				{itemid = 196993, count = 1},
				{itemid = 196994, count = 1},
				{itemid = 196995, count = 1},
				{itemid = 196996, count = 1},
				{itemid = 196997, count = 1},
				{itemid = 196998, count = 1},
				{itemid = 196999, count = 1},
				{itemid = 197000, count = 1},
				{itemid = 197001, count = 1},
				{itemid = 197002, count = 1},
				{itemid = 197003, count = 1},
				{itemid = 197004, count = 1},
				{itemid = 197005, count = 1},
				{itemid = 197006, count = 1},
				{itemid = 197007, count = 1},
				{itemid = 197008, count = 1},
				{itemid = 197009, count = 1},
				{itemid = 197010, count = 1},
				{itemid = 197011, count = 1},
				{itemid = 197012, count = 1},
				{itemid = 197013, count = 1},
				{itemid = 197014, count = 1},
				{itemid = 197015, count = 1},
				{itemid = 197016, count = 1},
				{itemid = 197017, count = 1},
				{itemid = 197018, count = 1},
				{itemid = 197019, count = 1},
				{itemid = 197020, count = 1},
				{itemid = 197021, count = 1},
				{itemid = 197022, count = 1},
				{itemid = 197023, count = 1},
				{itemid = 197090, count = 1},
				{itemid = 197091, count = 1},
				{itemid = 197093, count = 1},
				{itemid = 197094, count = 1},
				{itemid = 197095, count = 1},
				{itemid = 197096, count = 1},
				{itemid = 197097, count = 1},
				{itemid = 197098, count = 1},
				{itemid = 197099, count = 1},
				{itemid = 197100, count = 1},
				{itemid = 197101, count = 1},
				{itemid = 197102, count = 1},
				{itemid = 197103, count = 1},
				{itemid = 197104, count = 1},
				{itemid = 197105, count = 1},
				{itemid = 197106, count = 1},
				{itemid = 197107, count = 1},
				{itemid = 197108, count = 1},
				{itemid = 197109, count = 1},
				{itemid = 197110, count = 1},
				{itemid = 197111, count = 1},
				{itemid = 197112, count = 1},
				{itemid = 197113, count = 1},
				{itemid = 197114, count = 1},
				{itemid = 197115, count = 1},
				{itemid = 197116, count = 1},
				{itemid = 197117, count = 1},
				{itemid = 197118, count = 1},
				{itemid = 197119, count = 1},
				{itemid = 197120, count = 1},
				{itemid = 197121, count = 1},
				{itemid = 197122, count = 1},
				{itemid = 197123, count = 1},
				{itemid = 197124, count = 1},
				{itemid = 197125, count = 1},
				{itemid = 197126, count = 1},
				{itemid = 197127, count = 1},
				{itemid = 197128, count = 1},
				{itemid = 197129, count = 1},
				{itemid = 197130, count = 1},
				{itemid = 197131, count = 1},
				{itemid = 197132, count = 1},
				{itemid = 197133, count = 1},
				{itemid = 197134, count = 1},
				{itemid = 197135, count = 1},
				{itemid = 197136, count = 1},
				{itemid = 197137, count = 1},
				{itemid = 197138, count = 1},
				{itemid = 197139, count = 1},
				{itemid = 197140, count = 1},
				{itemid = 197141, count = 1},
				{itemid = 197142, count = 1},
				{itemid = 197143, count = 1},
				{itemid = 197144, count = 1},
				{itemid = 197145, count = 1},
				{itemid = 197146, count = 1},
				{itemid = 197147, count = 1},
				{itemid = 197148, count = 1},
				{itemid = 197149, count = 1},
				{itemid = 197150, count = 1},
				{itemid = 197151, count = 1},
				{itemid = 197152, count = 1},
				{itemid = 197153, count = 1},
				{itemid = 197154, count = 1},
				{itemid = 197155, count = 1},
				{itemid = 197156, count = 1},
				{itemid = 197346, count = 1},
				{itemid = 197347, count = 1},
				{itemid = 197348, count = 1},
				{itemid = 197349, count = 1},
				{itemid = 197350, count = 1},
				{itemid = 197351, count = 1},
				{itemid = 197352, count = 1},
				{itemid = 197353, count = 1},
				{itemid = 197354, count = 1},
				{itemid = 197355, count = 1},
				{itemid = 197356, count = 1},
				{itemid = 197357, count = 1},
				{itemid = 197358, count = 1},
				{itemid = 197359, count = 1},
				{itemid = 197360, count = 1},
				{itemid = 197361, count = 1},
				{itemid = 197362, count = 1},
				{itemid = 197363, count = 1},
				{itemid = 197364, count = 1},
				{itemid = 197365, count = 1},
				{itemid = 197366, count = 1},
				{itemid = 197367, count = 1},
				{itemid = 197368, count = 1},
				{itemid = 197369, count = 1},
				{itemid = 197370, count = 1},
				{itemid = 197371, count = 1},
				{itemid = 197372, count = 1},
				{itemid = 197373, count = 1},
				{itemid = 197374, count = 1},
				{itemid = 197375, count = 1},
				{itemid = 197376, count = 1},
				{itemid = 197377, count = 1},
				{itemid = 197378, count = 1},
				{itemid = 197379, count = 1},
				{itemid = 197380, count = 1},
				{itemid = 197381, count = 1},
				{itemid = 197382, count = 1},
				{itemid = 197383, count = 1},
				{itemid = 197384, count = 1},
				{itemid = 197385, count = 1},
				{itemid = 197386, count = 1},
				{itemid = 197387, count = 1},
				{itemid = 197388, count = 1},
				{itemid = 197389, count = 1},
				{itemid = 197390, count = 1},
				{itemid = 197391, count = 1},
				{itemid = 197392, count = 1},
				{itemid = 197393, count = 1},
				{itemid = 197394, count = 1},
				{itemid = 197395, count = 1},
				{itemid = 197396, count = 1},
				{itemid = 197397, count = 1},
				{itemid = 197398, count = 1},
				{itemid = 197399, count = 1},
				{itemid = 197400, count = 1},
				{itemid = 197401, count = 1},
				{itemid = 197402, count = 1},
				{itemid = 197403, count = 1},
				{itemid = 197404, count = 1},
				{itemid = 197405, count = 1},
				{itemid = 197406, count = 1},
				{itemid = 197407, count = 1},
				{itemid = 197408, count = 1},
				{itemid = 197577, count = 1},
				{itemid = 197578, count = 1},
				{itemid = 197579, count = 1},
				{itemid = 197580, count = 1},
				{itemid = 197581, count = 1},
				{itemid = 197582, count = 1},
				{itemid = 197583, count = 1},
				{itemid = 197584, count = 1},
				{itemid = 197585, count = 1},
				{itemid = 197586, count = 1},
				{itemid = 197587, count = 1},
				{itemid = 197588, count = 1},
				{itemid = 197589, count = 1},
				{itemid = 197590, count = 1},
				{itemid = 197591, count = 1},
				{itemid = 197592, count = 1},
				{itemid = 197593, count = 1},
				{itemid = 197594, count = 1},
				{itemid = 197595, count = 1},
				{itemid = 197596, count = 1},
				{itemid = 197597, count = 1},
				{itemid = 197598, count = 1},
				{itemid = 197599, count = 1},
				{itemid = 197600, count = 1},
				{itemid = 197601, count = 1},
				{itemid = 197602, count = 1},
				{itemid = 197603, count = 1},
				{itemid = 197604, count = 1},
				{itemid = 197605, count = 1},
				{itemid = 197606, count = 1},
				{itemid = 197607, count = 1},
				{itemid = 197608, count = 1},
				{itemid = 197609, count = 1},
				{itemid = 197610, count = 1},
				{itemid = 197611, count = 1},
				{itemid = 197612, count = 1},
				{itemid = 197613, count = 1},
				{itemid = 197614, count = 1},
				{itemid = 197615, count = 1},
				{itemid = 197616, count = 1},
				{itemid = 197617, count = 1},
				{itemid = 197618, count = 1},
				{itemid = 197619, count = 1},
				{itemid = 197620, count = 1},
				{itemid = 197621, count = 1},
				{itemid = 197622, count = 1},
				{itemid = 197623, count = 1},
				{itemid = 197624, count = 1},
				{itemid = 197625, count = 1},
				{itemid = 197626, count = 1},
				{itemid = 197627, count = 1},
				{itemid = 197628, count = 1},
				{itemid = 197629, count = 1},
				{itemid = 197630, count = 1},
				{itemid = 197634, count = 1},
				{itemid = 197635, count = 1},
				{itemid = 197636, count = 1},
				{itemid = 198395, count = 1},
				{itemid = 198438, count = 1},
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
				{itemid = 198891, count = 1},
				{itemid = 198892, count = 1},
				{itemid = 198893, count = 1},
				{itemid = 198894, count = 1},
				{itemid = 198895, count = 1},
				{itemid = 198896, count = 1},
				{itemid = 198899, count = 1},
				{itemid = 198901, count = 1},
				{itemid = 198902, count = 1},
				{itemid = 198903, count = 1},
				{itemid = 198904, count = 1},
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
				{itemid = 201734, count = 1},
				{itemid = 201735, count = 1},
				{itemid = 201736, count = 1},
				{itemid = 201737, count = 1},
				{itemid = 201738, count = 1},
				{itemid = 201739, count = 1},
				{itemid = 201741, count = 1},
				{itemid = 201742, count = 1},
				{itemid = 201743, count = 1},
				{itemid = 201754, count = 1},
				{itemid = 201755, count = 1},
				{itemid = 201756, count = 1},
				{itemid = 201781, count = 1},
				{itemid = 201782, count = 1},
				{itemid = 201790, count = 1},
				{itemid = 201792, count = 1},
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
				{itemid = 202102, count = 1},
				{itemid = 202142, count = 1},
				{itemid = 202171, count = 1},
				{itemid = 202172, count = 1},
				{itemid = 202273, count = 1},
				{itemid = 202274, count = 1},
				{itemid = 202275, count = 1},
				{itemid = 202277, count = 1},
				{itemid = 202278, count = 1},
				{itemid = 202279, count = 1},
				{itemid = 202280, count = 1},
				{itemid = 202371, count = 1},
				{itemid = 202621, count = 1},
				{itemid = 202621, count = 1},
				{itemid = 202621, count = 1},
				{itemid = 202621, count = 1},
				{itemid = 202622, count = 1},
				{itemid = 202622, count = 1},
				{itemid = 202622, count = 1},
				{itemid = 202622, count = 1},
				{itemid = 202623, count = 1},
				{itemid = 202623, count = 1},
				{itemid = 202623, count = 1},
				{itemid = 202623, count = 1},
				{itemid = 202624, count = 1},
				{itemid = 202624, count = 1},
				{itemid = 202624, count = 1},
				{itemid = 202624, count = 1},
				{itemid = 202625, count = 1},
				{itemid = 202625, count = 1},
				{itemid = 202625, count = 1},
				{itemid = 202625, count = 1},
				{itemid = 202626, count = 1},
				{itemid = 202626, count = 1},
				{itemid = 202626, count = 1},
				{itemid = 202626, count = 1},
				{itemid = 202627, count = 1},
				{itemid = 202627, count = 1},
				{itemid = 202627, count = 1},
				{itemid = 202627, count = 1},
				{itemid = 202628, count = 1},
				{itemid = 202628, count = 1},
				{itemid = 202628, count = 1},
				{itemid = 202628, count = 1},
				{itemid = 202629, count = 1},
				{itemid = 202629, count = 1},
				{itemid = 202629, count = 1},
				{itemid = 202629, count = 1},
				{itemid = 202630, count = 1},
				{itemid = 202630, count = 1},
				{itemid = 202630, count = 1},
				{itemid = 202630, count = 1},
				{itemid = 202631, count = 1},
				{itemid = 202631, count = 1},
				{itemid = 202631, count = 1},
				{itemid = 202631, count = 1},
				{itemid = 202632, count = 1},
				{itemid = 202632, count = 1},
				{itemid = 202632, count = 1},
				{itemid = 202632, count = 1},
				{itemid = 202633, count = 1},
				{itemid = 202633, count = 1},
				{itemid = 202633, count = 1},
				{itemid = 202633, count = 1},
				{itemid = 202634, count = 1},
				{itemid = 202634, count = 1},
				{itemid = 202634, count = 1},
				{itemid = 202634, count = 1},
				{itemid = 202635, count = 1},
				{itemid = 202635, count = 1},
				{itemid = 202635, count = 1},
				{itemid = 202635, count = 1},
				{itemid = 202636, count = 1},
				{itemid = 202636, count = 1},
				{itemid = 202636, count = 1},
				{itemid = 202636, count = 1},
				{itemid = 202637, count = 1},
				{itemid = 202637, count = 1},
				{itemid = 202637, count = 1},
				{itemid = 202637, count = 1},
				{itemid = 202638, count = 1},
				{itemid = 202638, count = 1},
				{itemid = 202638, count = 1},
				{itemid = 202638, count = 1},
				{itemid = 202639, count = 1},
				{itemid = 202639, count = 1},
				{itemid = 202639, count = 1},
				{itemid = 202639, count = 1},
				{itemid = 202640, count = 1},
				{itemid = 202640, count = 1},
				{itemid = 202640, count = 1},
				{itemid = 202640, count = 1},
				{itemid = 202667, count = 1},
				{itemid = 202668, count = 1},
				{itemid = 202669, count = 1},
				{itemid = 202670, count = 1},
				{itemid = 203217, count = 1},
				{itemid = 203220, count = 1},
				{itemid = 203222, count = 1},
				{itemid = 203224, count = 1},
				{itemid = 203299, count = 1},
				{itemid = 203300, count = 1},
				{itemid = 203303, count = 1},
				{itemid = 203304, count = 1},
				{itemid = 203306, count = 1},
				{itemid = 203307, count = 1},
				{itemid = 203308, count = 1},
				{itemid = 203309, count = 1},
				{itemid = 203310, count = 1},
				{itemid = 203311, count = 1},
				{itemid = 203312, count = 1},
				{itemid = 203313, count = 1},
				{itemid = 203314, count = 1},
				{itemid = 203315, count = 1},
				{itemid = 203316, count = 1},
				{itemid = 203317, count = 1},
				{itemid = 203318, count = 1},
				{itemid = 203319, count = 1},
				{itemid = 203320, count = 1},
				{itemid = 203321, count = 1},
				{itemid = 203322, count = 1},
				{itemid = 203323, count = 1},
				{itemid = 203324, count = 1},
				{itemid = 203325, count = 1},
				{itemid = 203327, count = 1},
				{itemid = 203328, count = 1},
				{itemid = 203329, count = 1},
				{itemid = 203330, count = 1},
				{itemid = 203331, count = 1},
				{itemid = 203332, count = 1},
				{itemid = 203333, count = 1},
				{itemid = 203334, count = 1},
				{itemid = 203335, count = 1},
				{itemid = 203336, count = 1},
				{itemid = 203337, count = 1},
				{itemid = 203338, count = 1},
				{itemid = 203339, count = 1},
				{itemid = 203340, count = 1},
				{itemid = 203341, count = 1},
				{itemid = 203342, count = 1},
				{itemid = 203343, count = 1},
				{itemid = 203344, count = 1},
				{itemid = 203345, count = 1},
				{itemid = 203346, count = 1},
				{itemid = 203347, count = 1},
				{itemid = 203348, count = 1},
				{itemid = 203349, count = 1},
				{itemid = 203350, count = 1},
				{itemid = 203351, count = 1},
				{itemid = 203352, count = 1},
				{itemid = 203353, count = 1},
				{itemid = 203354, count = 1},
				{itemid = 203355, count = 1},
				{itemid = 203357, count = 1},
				{itemid = 203358, count = 1},
				{itemid = 203359, count = 1},
				{itemid = 203360, count = 1},
				{itemid = 203361, count = 1},
				{itemid = 203362, count = 1},
				{itemid = 203363, count = 1},
				{itemid = 203364, count = 1},
				{itemid = 203365, count = 1},
				{itemid = 203476, count = 1},
				{itemid = 203646, count = 1},
				{itemid = 203647, count = 1},
				{itemid = 203648, count = 1},
				{itemid = 203649, count = 1},
				{itemid = 203650, count = 1},
				{itemid = 203681, count = 1},
				{itemid = 203699, count = 1},
				{itemid = 203700, count = 1},
				{itemid = 203702, count = 1},
				{itemid = 204075, count = 15},
				{itemid = 204076, count = 15},
				{itemid = 204077, count = 15},
				{itemid = 204078, count = 15},
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
				{itemid = 204352, count = 50},
				{itemid = 204359, count = 1},
				{itemid = 204359, count = 1},
				{itemid = 204361, count = 1},
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
				{itemid = 204717, count = 2},
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
				{itemid = 205226, count = 1},
				{itemid = 205247, count = 1},
				{itemid = 205248, count = 1},
				{itemid = 205249, count = 1},
				{itemid = 205250, count = 1},
				{itemid = 205251, count = 1},
				{itemid = 205253, count = 1},
				{itemid = 205254, count = 1},
				{itemid = 205288, count = 1},
				{itemid = 205341, count = 1},
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
				{itemid = 205865, count = 1},
				{itemid = 205876, count = 1},
				{itemid = 205964, count = 1},
				{itemid = 205967, count = 1},
				{itemid = 205983, count = 1},
				{itemid = 205985, count = 1},
				{itemid = 205986, count = 1},
				{itemid = 205987, count = 1},
				{itemid = 205988, count = 1},
				{itemid = 205989, count = 1},
				{itemid = 205991, count = 1},
				{itemid = 205992, count = 1},
				{itemid = 205998, count = 1},
				{itemid = 206006, count = 1},
				{itemid = 206019, count = 1},
				{itemid = 206025, count = 1},
				{itemid = 206030, count = 1},
				{itemid = 206031, count = 1},
				{itemid = 206034, count = 1},
				{itemid = 206035, count = 1},
				{itemid = 206135, count = 1},
				{itemid = 206136, count = 1},
				{itemid = 206955, count = 1},
				{itemid = 21746, count = 1},
				{itemid = 50160, count = 1},
				{itemid = 54537, count = 1},
				{itemid = 5523, count = 1},
				{itemid = 5523, count = 1},
				{itemid = 5524, count = 1},
				{itemid = 7973, count = 1},
				{itemid = 92794, count = 1},
				{itemid = 93724, count = 1},
				{itemid = 122457, count = 1},
				{itemid = 201782, count = 1},
			}
			local white_list70 ={
				{itemid = 205423, count = 1},
				{itemid = 205966, count = 1},
			}
			local Krokuun_Plate ={
				{itemid = 153143, count = 1},
				{itemid = 153153, count = 1},
				{itemid = 152743, count = 1},
				{itemid = 153146, count = 1},
				{itemid = 153150, count = 1},
				{itemid = 153157, count = 1},
				{itemid = 153140, count = 1},
				{itemid = 153155, count = 1},
				-- ОСТРОВ
				{itemid = 203633, count = 1},
				{itemid = 203643, count = 1},
				{itemid = 203623, count = 1},
				{itemid = 203640, count = 1},
				{itemid = 203615, count = 1},
				{itemid = 203626, count = 1},
				{itemid = 203634, count = 1},
				{itemid = 203611, count = 1},
			}
			local Krokuun_ChainMail = {
				{itemid = 153138, count = 1},
				{itemid = 153158, count = 1},
				{itemid = 153149, count = 1},
				{itemid = 153152, count = 1},
				{itemid = 152741, count = 1},
				{itemid = 153147, count = 1},
				{itemid = 153137, count = 1},
				{itemid = 152744, count = 1},
				-- ОСТРОВ
				{itemid = 203631, count = 1},
				{itemid = 203644, count = 1},
				{itemid = 203620, count = 1},
				{itemid = 203639, count = 1},
				{itemid = 203617, count = 1},
				{itemid = 203628, count = 1},
				{itemid = 203636, count = 1},
				{itemid = 203613, count = 1},
			}
			local Krokuun_Leather = {
				{itemid = 153136, count = 1},
				{itemid = 152739, count = 1},
				{itemid = 152737, count = 1},
				{itemid = 153142, count = 1},
				{itemid = 153151, count = 1},
				{itemid = 153145, count = 1},
				{itemid = 153148, count = 1},
				{itemid = 153139, count = 1},
				-- ОСТРОВ
				{itemid = 203630, count = 1},
				{itemid = 203645, count = 1},
				{itemid = 203619, count = 1},
				{itemid = 203638, count = 1},
				{itemid = 203618, count = 1},
				{itemid = 203629, count = 1},
				{itemid = 203637, count = 1},
				{itemid = 203614, count = 1},
			}
			local Krokuun_Cloth = {
				{itemid = 152738, count = 1},
				{itemid = 152734, count = 1},
				{itemid = 153135, count = 1},
				{itemid = 152742, count = 1},
				{itemid = 153141, count = 1},
				{itemid = 153154, count = 1},
				{itemid = 153144, count = 1},
				{itemid = 153156, count = 1},
				-- ОСТРОВ
				{itemid = 203632, count = 1},
				{itemid = 203642, count = 1},
				{itemid = 203622, count = 1},
				{itemid = 203641, count = 1},
				{itemid = 203616, count = 1},
				{itemid = 203627, count = 1},
				{itemid = 203635, count = 1},
				{itemid = 203612, count = 1},
			}
			if classFilename == "WARRIOR" or classFilename == "PALADIN" or classFilename == "DEATHKNIGHT" then
				TableConcat(white_list70, Krokuun_Plate)
			end
			if classFilename == "HUNTER" or classFilename == "EVOKER" or classFilename == "SHAMAN" then
				TableConcat(white_list70, Krokuun_ChainMail)
			end
			if classFilename == "DRUID" or classFilename == "MONK" or classFilename == "DEMONHUNTER" or classFilename == "ROGUE" then
				TableConcat(white_list70, Krokuun_Leather)
			end
			if classFilename == "PRIEST" or classFilename == "MAGE" or classFilename == "WARLOCK" then
				TableConcat(white_list70, Krokuun_Cloth)
			end
			if UnitLevel == 70 then
				TableConcat(white_list, white_list70)
			end
			local function UsableItems_Frame_OnEnter(self)
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 10)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(func_itemName(self.itemid))
				GameTooltip:Show()
			end
			local function UsableItems_Frame_OnLeave(self)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
			end
			--local function UsableItems_Frame(itemID)
			if not UsableItems_Frame then
				UsableItems_Frame = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "SecureActionButtonTemplate,BackDropTemplate")
				UsableItems_Frame:Hide()
			end
			UsableItems_Frame:Hide()
			UsableItems_Frame:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
			UsableItems_Frame:SetPoint("TOPLEFT", 0, 0)
			UsableItems_Frame:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 4})
			UsableItems_Frame:SetBackdropBorderColor(1, 1, 1, 1)
			UsableItems_Frame:HookScript("OnEnter", UsableItems_Frame_OnEnter)
			UsableItems_Frame:HookScript("OnLeave", UsableItems_Frame_OnLeave)
			UsableItems_Frame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
			UsableItems_Frame:SetAttribute("type", "macro")
			local texture = UsableItems_Frame:CreateTexture(nil, "BACKGROUND")
			UsableItems_Frame.icon = texture
			texture:SetAllPoints(UsableItems_Frame)
			texture:SetTexture(413587)
			--end
			local function UsableItemFrame_OnLoad()
				if not EventFrame then
					EventFrame = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent)
					EventFrame:Hide()
				end
				if not InCombatLockdown() then
					EventFrame:Hide()
					EventFrame:RegisterEvent("PLAYER_LOGIN")
					EventFrame:RegisterEvent("BAG_UPDATE")
					EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
					EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
					EventFrame:SetScript("OnEvent", UsableItemFrame_OnEvent)
				end
			end
			function UsableItemFrame_OnEvent(self, event)
				--local isGroup = IsInGroup(INSTANCE)
				if event == "BAG_UPDATE" or event == "PLAYER_REGEN_ENABLED" and not InCombatLockdown() --[[and isGroup == false]] then
					UsableItemFrame()
				elseif event == "PLAYER_REGEN_DISABLED" then
					if UsableItems_Frame:IsShown() then
						UsableItems_Frame:Hide()
					end
				end
			end
			function UsableItemFrame()
				if not InCombatLockdown() and UsableItems_Frame then
					local testtable = {}
					for myBags = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
						for bagSlots = 1, C_Container.GetContainerNumSlots(myBags) do
							CurrentItemLink = C_Container.GetContainerItemLink(myBags, bagSlots)
							if CurrentItemLink then
								local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(CurrentItemLink)
								local itemInfo = C_Container.GetContainerItemInfo(myBags, bagSlots)
								if (classID == 15 and (subclassID == 2 or subclassID == 5 )) -- 2ПЕТЫ  5маунты
								or (classID == 8 and subclassID)
								-- or (classID == 15 and (subclassID == 4) and itemQuality == 4 and expacID ~= 7) -- 4сундуки эпик
								-- or (classID == 9) -- РЕЦЕПТЫ
								then
									local itemID = tonumber(strmatch(itemLink, "item:(%d+):"))
									local testtable = {{itemid = itemID, count = 1},}
									TableConcat (white_list, testtable)
								end
							end
						end
					end
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
							UsableItems_Frame.itemid = v.itemid
							break
						elseif GetItemCount(v.itemid) <= (v.count-1) and UsableItems_Frame:IsShown() then
							UsableItems_Frame:Hide()
							UsableItems_Frame.icon:SetTexture(413587)
						end
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
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.AutoGossip then
			if not Octo_AUTO_GOSSIP then
				Octo_AUTO_GOSSIP = CreateFrame("Frame", AddonTitle)
				Octo_AUTO_GOSSIP:Hide()
			end
			Octo_AUTO_GOSSIP:RegisterEvent("GOSSIP_SHOW")
			Octo_AUTO_GOSSIP:SetScript("OnEvent", function(self, event, ...)
					if Octo_ToDoVars.config.AutoGossip and event == "GOSSIP_SHOW" then
						--https://wowpedia.fandom.com/wiki/Category:API_namespaces/C_GossipInfo
						local numQuests1 = C_GossipInfo.GetNumActiveQuests()
						local numQuests2 = C_GossipInfo.GetNumAvailableQuests()
						if numQuests1 > 0 or numQuests2 > 0 --[[or InCombatLockdown()]] then
							return
						end
						local UnitID = "TARGET"
						local guid = UnitGUID(UnitID)
						local First_Option = {
							[168432] = true,
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
							[180162] = true,
							[161509] = true,
							[203011] = true,
						}
						local Second_Option = {
							[201398] = true,
							--[205089] = true,
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
								v.name:find("сказать") or
								v.name:find("Пропустить") or
								v.name:find("Указать на Ральфа мистеру Солнечноцветику.") or
								v.name:find("cff0000FF")
								and not IsShiftKeyDown() then
									C_GossipInfo.SelectOption(v.gossipOptionID)
									StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
									print (E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.."("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t"..v.name)
								elseif First_Option[targetNPCID] and not IsShiftKeyDown() then
									C_GossipInfo.SelectOption(v.gossipOptionID)
									StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
									print (E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.."("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t"..v.name)
								elseif Second_Option[targetNPCID] and not IsShiftKeyDown() and i == 2 then
									C_GossipInfo.SelectOption(v.gossipOptionID)
									StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
									print (E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.."("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t"..v.name)
								elseif #info == 1 and not IsShiftKeyDown() then
									C_GossipInfo.SelectOption(v.gossipOptionID)
									StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
									print (E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.."("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t"..v.name)
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
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.InputDelete then
			local TypeDeleteLine = gsub(DELETE_GOOD_ITEM, "[\r\n]", "@")
			local void, TypeDeleteLine = strsplit("@", TypeDeleteLine, 2)
			StaticPopupDialogs["DELETE_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
			StaticPopupDialogs["DELETE_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
			StaticPopupDialogs["DELETE_QUEST_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
			StaticPopupDialogs["DELETE_QUEST_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
			StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter
			StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave
			if not easyDelFrame then
				easyDelFrame = CreateFrame("FRAME")
				easyDelFrame:Hide()
			end
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
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.ClearChat then
			C_Timer.After(1, function()
					ChatFrame1:Clear()
			end)
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--AutoSellGrey
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.AutoSellGrey then
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
					-- print("|cFF00A3FFAutoSellGrey|r|cff00FF00 +".. GetCoinTextureString(totalPrice) .. "|r")
					-- DEFAULT_CHAT_FRAME:AddMessage(AddonTitle .. L["Vendored gray items for: "]..GetCoinTextureString(totalPrice), 255, 255, 255)
				end
			end
			if not AutoSellGreyFrame then
				AutoSellGreyFrame = CreateFrame("Frame")
				AutoSellGreyFrame:Hide()
			end
			AutoSellGreyFrame:SetScript("OnEvent", OnEvent)
			AutoSellGreyFrame:RegisterEvent("MERCHANT_SHOW")
		end
end)
-- Consumable 0 Consumable Enum.ItemConsumableSubclass
-- Container 1 Container
-- Weapon 2 Weapon Enum.ItemWeaponSubclass
-- Gem 3 Gem Enum.ItemGemSubclass
-- Armor 4 Armor Enum.ItemArmorSubclass
-- Reagent 5 Reagent Enum.ItemReagentSubclass Obsolete
-- Projectile 6 Projectile Obsolete
-- Tradegoods 7 Tradeskill
-- ItemEnhancement 8 Item Enhancement
-- Recipe 9 Recipe Enum.ItemRecipeSubclass
-- CurrencyTokenObsolete 10 Money(OBSOLETE)
-- Quiver 11 Quiver Obsolete
-- Questitem 12 Quest
-- Key 13 Key
-- PermanentObsolete 14 Permanent(OBSOLETE)
-- Miscellaneous 15 Miscellaneous Enum.ItemMiscellaneousSubclass
-- Glyph 16 Glyph
-- Battlepet 17 Battle Pets Enum.BattlePetTypes
-- WoWToken 18 WoW Token
-- Profession 19 Profession Enum.ItemProfessionSubclass Added in 10.0.0
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--AutoRepair
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.AutoRepair then
			local function OnEvent(self, event)
				if (CanMerchantRepair()) then
					repairAllCost, canRepair = GetRepairAllCost()
					local money = GetMoney()
					local locale = GetLocale()
					if canRepair and repairAllCost > money then
						print ("|cFFFF5771"..L["We need more gold"].."|r "..GetCoinTextureString((repairAllCost-money)))
						if locale ~= "ruRU" then
							PlaySoundFile("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\sound\\Memes\\WeNeedMoreGold_ENG.ogg", "Master")
						else
							PlaySoundFile("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\sound\\Memes\\WeNeedMoreGold_RU.ogg", "Master")
						end
						-- If merchant can repair and there is something to repair
					else if (canRepair and repairAllCost > 0) then
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
									-- print("|cFF00A3FFAutoRepair|r|cffFF4C4F -".. costTextureString.."|r")
									-- DEFAULT_CHAT_FRAME:AddMessage(AddonTitle .. L["Your items have been repaired using guild bank funds for: "]..costTextureString, 255, 255, 255)
								end
							end
							-- Use own funds
							if (repairAllCost <= money and not guildRepairedItems) then
								RepairAllItems(false)
								-- print("|cFF00A3FFAutoRepair|r|cffFF4C4F -".. costTextureString.."|r")
								-- DEFAULT_CHAT_FRAME:AddMessage(AddonTitle .. L["Your items have been repaired for: "]..costTextureString, 255, 255, 255)
							end
						end
					end
				end
			end
			if not AutoRepairFrame then
				AutoRepairFrame = CreateFrame("Frame")
				AutoRepairFrame:Hide()
			end
			AutoRepairFrame:SetScript("OnEvent", OnEvent)
			AutoRepairFrame:RegisterEvent("MERCHANT_SHOW")
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--HideErrorMessages
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.HideErrorMessages then
			local OrigErrHandler = UIErrorsFrame:GetScript("OnEvent")
			UIErrorsFrame:SetScript("OnEvent", function (self, event, id, err, ...)
					if event == "UI_ERROR_MESSAGE" then
						if err == ERR_INV_FULL or
						err == ERR_QUEST_LOG_FULL or
						err == ERR_RAID_GROUP_ONLY or
						err == ERR_PARTY_LFG_BOOT_LIMIT or
						err == ERR_PARTY_LFG_BOOT_DUNGEON_COMPLETE or
						err == ERR_PARTY_LFG_BOOT_IN_COMBAT or
						err == ERR_PARTY_LFG_BOOT_IN_PROGRESS or
						err == ERR_PARTY_LFG_BOOT_LOOT_ROLLS or
						err == ERR_PARTY_LFG_TELEPORT_IN_COMBAT or
						err == ERR_PET_SPELL_DEAD or
						err == ERR_PLAYER_DEAD or
						err == SPELL_FAILED_TARGET_NO_POCKETS or
						err == ERR_ALREADY_PICKPOCKETED or
						err:find(format(ERR_PARTY_LFG_BOOT_NOT_ELIGIBLE_S, ".+")) then
							return OrigErrHandler(self, event, id, err, ...)
						end
					elseif event == "UI_INFO_MESSAGE"then
						return OrigErrHandler(self, event, id, err, ...)
					end
			end)
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--SellFrame
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.SellFrame then
			local bgCr, bgCg, bgCb, bgCa = 14/255, 14/255, 14/255, 0.8
			local OctoFrame_Events = nil
			local OctoFrame_SellOther = nil
			local OctoFrame_SellConsumable = nil
			local OctoFrame_foundLevelTooltip = nil
			local OctoFrame_FROMBANK = nil
			local OctoFrame_TOBANK = nil
			local ignore_list = {
				[49040] = true,
				[81055] = true,
				[109076] = true,
				[166751] = true,
				[180653] = true,
				[191251] = true,
				[193201] = true,
				[203703] = true,
				[204075] = true,
				[204076] = true,
				[204077] = true,
				[204078] = true,
				[204193] = true,
				[204194] = true,
				[204195] = true,
				[204196] = true,
				[204985] = true,
				[205982] = true,
			}
			local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel()
			local ilvlStr = avgItemLevelEquipped or 0
			function Octo_Trade_OnLoad()
				if not OctoFrame_Events then
					OctoFrame_Events = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID())
					OctoFrame_Events:Hide()
				end
				OctoFrame_Events:RegisterEvent("Trade_SHOW")
				OctoFrame_Events:RegisterEvent("SECURE_TRANSFER_CANCEL")
				OctoFrame_Events:RegisterEvent("MERCHANT_SHOW")
				OctoFrame_Events:RegisterEvent("MERCHANT_CLOSED")
				OctoFrame_Events:RegisterEvent("BANKFRAME_OPENED")
				OctoFrame_Events:RegisterEvent("BANKFRAME_CLOSED")
				OctoFrame_Events:RegisterEvent("PLAYER_STARTED_MOVING")
				OctoFrame_Events:RegisterEvent("MAIL_SHOW")
				OctoFrame_Events:SetScript("OnEvent", Octo_Trade_OnEvent)
			end
			function MASLENGO_Trade()
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_SellConsumable then
					OctoFrame_SellConsumable = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_SellConsumable:Hide()
				end
				OctoFrame_SellConsumable:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
				OctoFrame_SellConsumable:SetFrameStrata("HIGH")
				OctoFrame_SellConsumable:EnableMouse(true)
				OctoFrame_SellConsumable:SetMovable(true)
				OctoFrame_SellConsumable:RegisterForDrag("RightButton")
				OctoFrame_SellConsumable:SetScript("OnDragStart", OctoFrame_SellConsumable.StartMoving)
				OctoFrame_SellConsumable:SetScript("OnDragStop", function() OctoFrame_SellConsumable:StopMovingOrSizing() end)
				OctoFrame_SellConsumable:SetPoint("CENTER", -551, 65)
				OctoFrame_SellConsumable:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_SellConsumable:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_SellConsumable:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_SellConsumable:RegisterForClicks("LeftButtonUp")
				OctoFrame_SellConsumable:SetScript("OnClick",function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								if containerInfo then
									local itemID = containerInfo.itemID
									local itemLink = C_Container.GetContainerItemLink(bag, slot)
									-- local _, _, _, _, _, _, classID = select(6, GetItemInfo(itemID))
									local classID = select(12, GetItemInfo(itemID))
									if itemID and classID == 0 then
										C_Container.UseContainerItem(bag,slot)
									end
								end
							end
						end
					end
				)
				OctoFrame_SellConsumable.icon = OctoFrame_SellConsumable:CreateTexture(nil,"ARTWORK")
				OctoFrame_SellConsumable.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ui_sigil_kyrian.tga")
				OctoFrame_SellConsumable.icon:SetAllPoints(OctoFrame_SellConsumable)
				OctoFrame_SellConsumable:Show()
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_SellOther then
					OctoFrame_SellOther = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_SellOther:Hide()
				end
				OctoFrame_SellOther:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
				OctoFrame_SellOther:SetFrameStrata("HIGH")
				OctoFrame_SellOther:EnableMouse(true)
				OctoFrame_SellOther:SetMovable(true)
				OctoFrame_SellOther:RegisterForDrag("RightButton")
				OctoFrame_SellOther:SetScript("OnDragStart", OctoFrame_SellOther.StartMoving)
				OctoFrame_SellOther:SetScript("OnDragStop", function() OctoFrame_SellOther:StopMovingOrSizing() end)
				OctoFrame_SellOther:SetPoint("CENTER", -551, 0)
				OctoFrame_SellOther:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_SellOther:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_SellOther:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_SellOther:RegisterForClicks("LeftButtonUp")
				OctoFrame_SellOther:SetScript("OnClick",function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								if containerInfo then
									local itemID = containerInfo.itemID
									local itemLink = C_Container.GetContainerItemLink(bag, slot)
									local name, _, itemQuality, itemLevel, _, _, _,_, _, _, sellPrice = GetItemInfo(itemLink)
									local effectiveILvl = GetDetailedItemLevelInfo(itemID) or 0
									local baseILvl = tonumber(select(3,GetDetailedItemLevelInfo(itemID))) or 0
									local ItemTooltip = _G["OctoScanningTooltip"] or
									CreateFrame("GameTooltip", "OctoScanningTooltip", WorldFrame, "GameTooltipTemplate")
									ItemTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
									ItemTooltip:ClearLines()
									ItemTooltip:SetHyperlink(itemLink)
									local enchant = ""
									local emptySockets = 0
									for i = 1, ItemTooltip:NumLines() do
										if not OctoFrame_foundLevelTooltip then
											OctoFrame_foundLevelTooltip = _G["OctoScanningTooltipTextLeft" .. i]:GetText():match(ITEM_LEVEL:gsub("%%d", "(%%d+)"))
										end
										if OctoFrame_foundLevelTooltip then
											itemLevel = tonumber(OctoFrame_foundLevelTooltip) or 0
										end
									end
									if not ignore_list[itemID] and sellPrice ~= 0 and itemQuality < 5 then
										C_Container.UseContainerItem(bag,slot)
									end
								end
							end
						end
					end
				)
				OctoFrame_SellOther.icon = OctoFrame_SellOther:CreateTexture(nil,"ARTWORK")
				OctoFrame_SellOther.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Sell.tga")
				OctoFrame_SellOther.icon:SetAllPoints(OctoFrame_SellOther)
				OctoFrame_SellOther:Show()
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_SellAll then
					OctoFrame_SellAll = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_SellAll:Hide()
				end
				OctoFrame_SellAll:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
				OctoFrame_SellAll:SetFrameStrata("HIGH")
				OctoFrame_SellAll:EnableMouse(true)
				OctoFrame_SellAll:SetMovable(true)
				OctoFrame_SellAll:RegisterForDrag("RightButton")
				OctoFrame_SellAll:SetScript("OnDragStart", OctoFrame_SellAll.StartMoving)
				OctoFrame_SellAll:SetScript("OnDragStop", function() OctoFrame_SellAll:StopMovingOrSizing() end)
				OctoFrame_SellAll:SetPoint("CENTER", -551, -65)
				OctoFrame_SellAll:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_SellAll:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_SellAll:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_SellAll:RegisterForClicks("LeftButtonUp")
				OctoFrame_SellAll:SetScript("OnClick",function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								if containerInfo then
									local itemID = containerInfo.itemID
									-- local itemLink = C_Container.GetContainerItemLink(bag, slot)
									-- local name, _, itemQuality, itemLevel, _, _, _,_, _, _, sellPrice = GetItemInfo(itemLink)
									-- local effectiveILvl = GetDetailedItemLevelInfo(itemID) or 0
									-- local baseILvl = tonumber(select(3,GetDetailedItemLevelInfo(itemID))) or 0
									-- local ItemTooltip = _G["OctoScanningTooltip"] or
									-- CreateFrame("GameTooltip", "OctoScanningTooltip", WorldFrame, "GameTooltipTemplate")
									-- ItemTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
									-- ItemTooltip:ClearLines()
									-- ItemTooltip:SetHyperlink(itemLink)
									-- local enchant = ""
									-- local emptySockets = 0
									-- for i = 1, ItemTooltip:NumLines() do
									-- if not OctoFrame_foundLevelTooltip then
									-- OctoFrame_foundLevelTooltip = _G["OctoScanningTooltipTextLeft" .. i]:GetText():match(ITEM_LEVEL:gsub("%%d", "(%%d+)"))
									-- end
									-- if OctoFrame_foundLevelTooltip then
									-- itemLevel = tonumber(OctoFrame_foundLevelTooltip) or 0
									-- end
									-- end
									if itemID then
										C_Container.UseContainerItem(bag,slot)
									end
								end
							end
						end
					end
				)
				OctoFrame_SellAll.icon = OctoFrame_SellAll:CreateTexture(nil,"ARTWORK")
				OctoFrame_SellAll.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\SellAll.tga")
				OctoFrame_SellAll.icon:SetAllPoints(OctoFrame_SellAll)
				OctoFrame_SellAll:Show()
				----------------------------------------------------------------------------------------------------------------------------------
			end
			local function MASLENGO_BANK()
				if not OctoFrame_FROMBANK then
					OctoFrame_FROMBANK = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_FROMBANK:Hide()
				end
				OctoFrame_FROMBANK:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
				OctoFrame_FROMBANK:SetFrameStrata("HIGH")
				OctoFrame_FROMBANK:SetPoint("CENTER", -500, 32)
				OctoFrame_FROMBANK:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_FROMBANK:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_FROMBANK:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_FROMBANK:RegisterForClicks("LeftButtonUp")
				OctoFrame_FROMBANK:SetScript("OnClick",function()
						for bag=REAGENTBANK_CONTAINER, BANK_CONTAINER do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local n = C_Container.GetContainerItemLink(bag,slot)
								if n then
									C_Container.UseContainerItem(bag,slot)
								end
							end
						end
						for bag=NUM_TOTAL_EQUIPPED_BAG_SLOTS+1, NUM_TOTAL_EQUIPPED_BAG_SLOTS+NUM_BANKBAGSLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local n = C_Container.GetContainerItemLink(bag,slot)
								if n then
									C_Container.UseContainerItem(bag,slot)
								end
							end
						end
					end
				)
				OctoFrame_FROMBANK.RightEdge:SetVertexColor(0, 1, 0)
				OctoFrame_FROMBANK.icon = OctoFrame_FROMBANK:CreateTexture(nil,"ARTWORK")
				OctoFrame_FROMBANK.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Arrow_RIGHT.tga")
				OctoFrame_FROMBANK.icon:SetAllPoints(OctoFrame_FROMBANK)
				OctoFrame_FROMBANK:Show()
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_TOBANK then
					OctoFrame_TOBANK = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_TOBANK:Hide()
				end
				OctoFrame_TOBANK:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
				OctoFrame_TOBANK:SetFrameStrata("HIGH")
				OctoFrame_TOBANK:SetPoint("CENTER", -500, -32)
				OctoFrame_TOBANK:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_TOBANK:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_TOBANK:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_TOBANK:RegisterForClicks("LeftButtonUp")
				OctoFrame_TOBANK:RegisterForClicks("LeftButtonUp")
				OctoFrame_TOBANK:SetScript("OnClick",function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local itemLink = C_Container.GetContainerItemLink(bag,slot)
								if itemLink then
									C_Container.UseContainerItem(bag,slot)
								end
							end
						end
					end
				)
				OctoFrame_TOBANK.LeftEdge:SetVertexColor(0, 1, 0)
				OctoFrame_TOBANK.icon = OctoFrame_TOBANK:CreateTexture(nil,"ARTWORK")
				OctoFrame_TOBANK.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Arrow_LEFT.tga")
				OctoFrame_TOBANK.icon:SetAllPoints(OctoFrame_TOBANK)
				OctoFrame_TOBANK:Show()
				----------------------------------------------------------------------------------------------------------------------------------
			end
			function Octo_Trade_OnEvent(self, event, ...)
				if event == "MERCHANT_SHOW" and not InCombatLockdown() then
					MASLENGO_Trade()
				elseif event == "Trade_SHOW" and not InCombatLockdown() then
					MASLENGO_Trade()
				elseif event == "SECURE_TRANSFER_CANCEL" or event == "MERCHANT_CLOSED" or event == "PLAYER_STARTED_MOVING" then
					if OctoFrame_SellConsumable then
						OctoFrame_SellConsumable:Hide()
					end
					if OctoFrame_SellOther then
						OctoFrame_SellOther:Hide()
					end
					if OctoFrame_SellAll then
						OctoFrame_SellAll:Hide()
					end
				elseif event == "BANKFRAME_OPENED" and not InCombatLockdown() then
					MASLENGO_BANK()
				elseif event == "BANKFRAME_CLOSED" or event == "PLAYER_STARTED_MOVING" then
					if OctoFrame_FROMBANK then
						OctoFrame_FROMBANK:Hide()
					end
					if OctoFrame_TOBANK then
						OctoFrame_TOBANK:Hide()
					end
				elseif event == "MAIL_SHOW" then
					MASLENGO_Trade()
				end
			end
			Octo_Trade_OnLoad()
		end
end)
-- GlobalFadePersist
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.GlobalFadePersist then
			--------------------------------------------------------------------------------
			C_Timer.After(1, function()
					if isElvUI then
						local E, L, V, P, G = unpack(ElvUI) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
						local GFP = E:NewModule('ElvUI_GlobalFadePersist', 'AceHook-3.0', 'AceEvent-3.0') --Create a plugin within ElvUI and adopt AceHook-3.0, AceEvent-3.0 and AceTimer-3.0. We can make use of these later.
						local EP = LibStub("LibElvUIPlugin-1.0") --We can use this to automatically insert our GUI tables when ElvUI_Config is loaded.
						local AB = E:GetModule("ActionBars")
						function FadeParent_OnEvent(self, event)
							if UnitInVehicle("player") and (event == 'UNIT_ENTERED_VEHICLE' or 'UNIT_ENTERING_VEHICLE') then
								self.mouseLock = true
								E:UIFrameFadeIn(self, 0.2, self:GetAlpha(), 1)
							else
								self.mouseLock = false
								E:UIFrameFadeOut(self, 0.2, self:GetAlpha(), 1 - AB.db.globalFadeAlpha)
							end
						end
						function GFP:Initialize()
							--Register plugin so options are properly inserted when config is loaded
							EP:RegisterPlugin(GFP:GetName())
							-- Register vehicle and player death events to fadeParent for easy checking
							AB.fadeParent:RegisterEvent("UNIT_ENTERING_VEHICLE")
							AB.fadeParent:RegisterEvent("UNIT_ENTERED_VEHICLE")
							AB.fadeParent:RegisterEvent("UNIT_EXITING_VEHICLE")
							AB.fadeParent:RegisterEvent("UNIT_EXITED_VEHICLE")
							AB.fadeParent:RegisterEvent("PLAYER_DEAD")
							-- Unregister events we no longer care about (more efficient)
							AB.fadeParent:UnregisterEvent("PLAYER_REGEN_DISABLED")
							AB.fadeParent:UnregisterEvent("PLAYER_REGEN_ENABLED")
							AB.fadeParent:UnregisterEvent("PLAYER_TARGET_CHANGED")
							AB.fadeParent:UnregisterEvent("UNIT_SPELLCAST_START", "player")
							AB.fadeParent:UnregisterEvent("UNIT_SPELLCAST_STOP", "player")
							AB.fadeParent:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
							AB.fadeParent:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
							AB.fadeParent:UnregisterEvent("UNIT_HEALTH", "player")
							AB.fadeParent:UnregisterEvent("PLAYER_FOCUS_CHANGED")
							-- Finally, override the default script for this event in ElvUI
							AB.fadeParent:SetScript("OnEvent", FadeParent_OnEvent)
						end
						E:RegisterModule(GFP:GetName())
					end
			end)
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

