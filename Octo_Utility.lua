local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local isElvUI = IsAddOnLoaded("ElvUI")
local _, _, _, isRCLootCouncil = GetAddOnInfo("RCLootCouncil")
----------------------------------------------------------------------------------------------------------------------------------
local UnitLevel = UnitLevel("PLAYER")
local ignore_list_NPC = {
	--[206572] = true,
}
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
				Octo_Frame_Loot = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "SecureActionButtonTemplate, BackDropTemplate")
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
				Octo_Frame_RCLootCouncil = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "SecureActionButtonTemplate, BackDropTemplate")
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
			-- EventToastManagerFrame:HookScript("OnShow", function(self, ...)
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
func_Octo_LoadAddOn("Rarity")
func_Octo_LoadAddOn("Rarity_Options")
func_Octo_LoadAddOn("MountsJournal")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--StaticPopup1Button1
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.StaticPopup1Button1 then
			----------------------------------------------------------------------------------------------------------------------------------
			----------------------------------------------------------------------------------------------------------------------------------
			local function accept()
				if StaticPopup1Button1 then
					StaticPopup1Button1:Click()
				end
			end
			function Octo_OnLoad()
				local EventFrame = nil
				if not EventFrame then
					EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
				end
				EventFrame:RegisterEvent("EQUIP_BIND_CONFIRM")
				EventFrame:RegisterEvent("EQUIP_BIND_REFUNDABLE_CONFIRM")
				-- EventFrame:RegisterEvent("SPELL_CONFIRMATION_PROMPT") --block
				EventFrame:SetScript("OnEvent", function(...)
						Octo_OnEvent(...)
				end)
			end
			function Octo_OnEvent(self, event, ...)
				if (event == "EQUIP_BIND_CONFIRM" or event == "EQUIP_BIND_REFUNDABLE_CONFIRM") and not InCombatLockdown() then
					accept()
				end
			end
			Octo_OnLoad()
			-- /run local function accept() StaticPopup1Button1:Click() end
			-- StaticPopupDialogs["BID_AUCTION"].OnShow=accept
			-- StaticPopupDialogs["BUYOUT_AUCTION"].OnShow=accept
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--AnotherAddonsCasual
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.AnotherAddonsCasual then
			func_Octo_LoadAddOn("AstralKeys")
			-- func_Octo_LoadAddOn("AutoTurnIn")
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
			-- func_Octo_LoadAddOn("Pawn")
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
			func_Octo_LoadAddOn("Parrot")
			func_Octo_LoadAddOn("MRT")
			func_Octo_LoadAddOn("ExRT_Reminder")
			func_Octo_LoadAddOn("TalentTreeTweaks")
			func_Octo_LoadAddOn("RCLootCouncil")
			func_Octo_LoadAddOn("TrufiGCD")
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
	-- SetCVar("nameplateShowOnlyNames", 1)
	-- SetCVar("nameplateShowFriends", 1)
	-- SetCVar("nameplateVerticalScale", 1)
						-- SetCVar("nameplateShowOnlyNames", 0) --1 убирает ХП бар (френдли и энеми) лишь ctrl+V
						-- SetCVar("nameplateShowFriends", 0)--1 отображение френдли немплейта 1вкл 0 выкл (самая полоса с именем)
						-- SetCVar("nameplateVerticalScale", 1)--0.1 мелкий 1 дефолт 2.7 большая
--CVAR
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.CVar then
			C_Timer.After(1, function()
					-- SetCVar("nameplateShowOnlyNames", 1)
					-- SetCVar("nameplateShowFriends", 1)
					-- SetCVar("nameplateVerticalScale", 1)
					SetCVar("nameplateShowOnlyNames", 0) --1 убирает ХП бар (френдли и энеми) лишь ctrl+V
					SetCVar("nameplateShowFriends", 0)--1 отображение френдли немплейта 1вкл 0 выкл (самая полоса с именем)
					SetCVar("nameplateVerticalScale", 1)--0.1 мелкий 1 дефолт 2.7 большая
					SetCVar("nameplateMotion", 0) --(0 Наложение) (1 Друг над другом) stack
					--SetCVar("questPOI", 101)
					SetCVar("alwaysCompareItems", 0)
					SetCVar("rotateMinimap", 0)
					SetCVar("showBattlefieldMinimap", 0)
					SetCVar("displaySpellActivationOverlays", 1)
					SetCVar("raidFramesDisplayAggroHighlight", 1)
					SetCVar("raidFramesDisplayClassColor", 1)
					SetCVar("raidFramesDisplayDebuffs", 1)
					SetCVar("raidFramesDisplayIncomingHeals", 1)
					SetCVar("raidFramesDisplayOnlyDispellableDebuffs", 1)
					SetCVar("raidFramesDisplayPowerBars", 0)
					SetCVar("AutoPushSpellToActionBar", 0) -- Выставление спеллов на бар
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
					SetCVar("nameplateShowSelf", 0) --- PIZDA
					SetCVar("nameplateTargetBehindMaxDistance", 30)
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
					SetCVar("useUiScale", 1)
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
		-- local font, height, flags = aura_env.region.text:GetFont()
		-- local sr, sg, sb, sa = aura_env.region.text:GetShadowColor()
		-- local sx, sy = aura_env.region.text:GetShadowOffset()
		-- local function SetFont(obj, optSize)
		--     obj:SetFont(font, optSize, flags)
		--     -- obj:SetTextColor(1, 0, 0, 1)
		--     obj:SetShadowColor(sr, sg, sb, sa)
		--     obj:SetShadowOffset(sx, sy)
		-- end
		-- local function ModifyCVars()
		--     SetCVar("nameplateShowOnlyNames", 1)
		--     SetCVar("nameplateShowFriends", 1)
		--     SetCVar("nameplateVerticalScale", 1)
		-- end
		-- ModifyCVars()
		-- SetFont(SystemFont_NamePlateFixed, height)
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--USABLEITEMS
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.UsableItems then
			local classFilename = select(2, UnitClass("PLAYER"))
			-- https://www.wowhead.com/ru/item=205151/%D0%B8%D0%B7%D0%B2%D0%B8%D0%BB%D0%B8%D1%81%D0%BA#comments
			-- https://www.wowhead.com/ru/item=206009/ https://www.wowhead.com/ru/item=206010/ https://www.wowhead.com/ru/item=206014/
			-- https://www.wowhead.com/ru/item=206014/ https://www.wowhead.com/ru/item=206011/ https://www.wowhead.com/ru/item=206015/
			-- https://www.wowhead.com/ru/item=206015/ https://www.wowhead.com/ru/item=206012/ https://www.wowhead.com/ru/item=206016/
			-- https://www.wowhead.com/ru/item=206016/ https://www.wowhead.com/ru/item=206013/ https://www.wowhead.com/ru/item=206017/
			-- https://www.wowhead.com/ru/item=206017/ https://www.wowhead.com/ru/item=206021/ https://www.wowhead.com/ru/item=205151/
			if classFilename == "WARRIOR" or classFilename == "PALADIN" or classFilename == "DEATHKNIGHT" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_70, E.Octo_Table.white_list_Krokuun_Plate)
			end
			if classFilename == "HUNTER" or classFilename == "EVOKER" or classFilename == "SHAMAN" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_70, E.Octo_Table.white_list_Krokuun_ChainMail)
			end
			if classFilename == "DRUID" or classFilename == "MONK" or classFilename == "DEMONHUNTER" or classFilename == "ROGUE" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_70, E.Octo_Table.white_list_Krokuun_Leather)
			end
			if classFilename == "PRIEST" or classFilename == "MAGE" or classFilename == "WARLOCK" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_70, E.Octo_Table.white_list_Krokuun_Cloth)
			end
			if UnitLevel == 70 then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_70)
			end
			--ТОКЕНЫ
			if classFilename == "WARRIOR" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_WARRIOR)
			end
			if classFilename == "PALADIN" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_PALADIN)
			end
			if classFilename == "HUNTER" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_HUNTER)
			end
			if classFilename == "ROGUE" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_ROGUE)
			end
			if classFilename == "PRIEST" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_PRIEST)
			end
			if classFilename == "DEATHKNIGHT" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_DEATHKNIGHT)
			end
			if classFilename == "SHAMAN" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_SHAMAN)
			end
			if classFilename == "MAGE" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_MAGE)
			end
			if classFilename == "WARLOCK" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_WARLOCK)
			end
			if classFilename == "MONK" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_MONK)
			end
			if classFilename == "DRUID" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_DRUID)
			end
			if classFilename == "DEMONHUNTER" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_DEMONHUNTER)
			end
			if classFilename == "EVOKER" then
				E.Octo_Func.TableConcat(E.Octo_Table.white_list_ALL, E.Octo_Table.white_list_EVOKER)
			end
			local function UsableItems_Frame_OnEnter(self)
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 10)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(E.Octo_Func.func_itemName(self.itemid))
				GameTooltip:Show()
			end
			local function UsableItems_Frame_OnLeave(self)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
			end
			--local function UsableItems_Frame(itemID)
			if not UsableItems_Frame then
				UsableItems_Frame = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "SecureActionButtonTemplate, BackDropTemplate")
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
								if (classID == 15 and (subclassID == 2 or subclassID == 5 )) -- 2ПЕТЫ 5маунты
								or (classID == 8 and subclassID)
								-- or (classID == 15 and (subclassID == 4) and itemQuality == 4 and expacID ~= 7) -- 4сундуки эпик
								-- or (classID == 9) -- РЕЦЕПТЫ
								then
									local itemID = tonumber(strmatch(itemLink, "item:(%d+):"))
									local testtable = {{itemid = itemID, count = 1}, }
									E.Octo_Func.TableConcat (E.Octo_Table.white_list_ALL, testtable)
								end
							end
						end
					end
					for _, v in pairs(E.Octo_Table.white_list_ALL) do
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
							[200172] = true, -- test
							[200171] = true, -- test
							[200170] = true, -- test
							[199198] = true, -- test
						}
						local Second_Option = {
							[201398] = true,
							--[205089] = true,
						}
						if guid and UnitGUID(UnitID):match("%a+") ~= "Player" and not IsShiftKeyDown() then
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
								v.name:find("Можешь снова активировать этого голиафа?") or
								v.name:find("Начать испытание") or
								v.name:find("Я готов.") or
								v.name:find("Я готова.") or
								v.name:find("Эти цветы - от Киригосы.") or
								-- v.name:find("Начать копать") or
								v.name:find("cff0000FF")
								 --[[and not ignore_list_NPC[targetNPCID] then]] then
									C_GossipInfo.SelectOption(v.gossipOptionID)
									StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
									print (E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.."("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t"..v.name)
								elseif First_Option[targetNPCID] --[[and not ignore_list_NPC[targetNPCID] then]] then
									C_GossipInfo.SelectOption(v.gossipOptionID)
									StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
									print (E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.."("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t"..v.name)
								elseif Second_Option[targetNPCID] and i == 2 --[[and not ignore_list_NPC[targetNPCID] then]] then
									C_GossipInfo.SelectOption(v.gossipOptionID)
									StaticPopup_OnClick(StaticPopup1Button1:GetParent(), i)
									print (E.Octo_Func.func_Gradient("Auto Gossip Select", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Globals.Green_Color.."("..i..")|r |T"..v.icon..":16:16:::64:64:4:60:4:60|t"..v.name)
								elseif #info == 1 --[[and not ignore_list_NPC[targetNPCID] then]] then
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
				--for myBags = 0, 4 do
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
				[207002] = true,
				[111820] = true,
				--ТРИНЬКЕТЫ
				[167555] = true,
				[77530] = true,
				[154174] = true,
				[154176] = true,
				[154177] = true,
				[154172] = true,
				[154175] = true,
				[154173] = true,
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
				OctoFrame_SellConsumable:SetFrameStrata("LOW")
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
				OctoFrame_SellConsumable:SetScript("OnClick", function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								if containerInfo then
									local itemID = containerInfo.itemID
									local itemLink = C_Container.GetContainerItemLink(bag, slot)
									-- local _, _, _, _, _, _, classID = select(6, GetItemInfo(itemID))
									local classID = select(12, GetItemInfo(itemID))
									if itemID and classID == 0 then
										C_Container.UseContainerItem(bag, slot)
									end
								end
							end
						end
					end
				)
				OctoFrame_SellConsumable.icon = OctoFrame_SellConsumable:CreateTexture(nil, "ARTWORK")
				OctoFrame_SellConsumable.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ui_sigil_kyrian.tga")
				OctoFrame_SellConsumable.icon:SetAllPoints(OctoFrame_SellConsumable)
				OctoFrame_SellConsumable:Show()
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_SellOther then
					OctoFrame_SellOther = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_SellOther:Hide()
				end
				OctoFrame_SellOther:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
				OctoFrame_SellOther:SetFrameStrata("LOW")
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
				OctoFrame_SellOther:SetScript("OnClick", function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								if containerInfo then
									local itemID = containerInfo.itemID
									local itemLink = C_Container.GetContainerItemLink(bag, slot)
									local name, _, itemQuality, itemLevel, _, _, _, _, _, _, sellPrice = GetItemInfo(itemLink)
									local effectiveILvl = GetDetailedItemLevelInfo(itemID) or 0
									local baseILvl = tonumber(select(3, GetDetailedItemLevelInfo(itemID))) or 0
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
									if sellPrice and itemQuality then
										if not ignore_list[itemID] and sellPrice ~= 0 and itemQuality < 5 --[[and itemLevel < 150 and itemLevel ~= 0]] then --5 фиолет
											C_Container.UseContainerItem(bag, slot)
										end
									end
								end
							end
						end
					end
				)
				OctoFrame_SellOther.icon = OctoFrame_SellOther:CreateTexture(nil, "ARTWORK")
				OctoFrame_SellOther.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Sell.tga")
				OctoFrame_SellOther.icon:SetAllPoints(OctoFrame_SellOther)
				OctoFrame_SellOther:Show()
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_SellAll then
					OctoFrame_SellAll = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_SellAll:Hide()
				end
				OctoFrame_SellAll:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
				OctoFrame_SellAll:SetFrameStrata("LOW")
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
				OctoFrame_SellAll:SetScript("OnClick", function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								if containerInfo then
									local itemID = containerInfo.itemID
									-- local itemLink = C_Container.GetContainerItemLink(bag, slot)
									-- local name, _, itemQuality, itemLevel, _, _, _, _, _, _, sellPrice = GetItemInfo(itemLink)
									-- local effectiveILvl = GetDetailedItemLevelInfo(itemID) or 0
									-- local baseILvl = tonumber(select(3, GetDetailedItemLevelInfo(itemID))) or 0
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
										C_Container.UseContainerItem(bag, slot)
									end
								end
							end
						end
					end
				)
				OctoFrame_SellAll.icon = OctoFrame_SellAll:CreateTexture(nil, "ARTWORK")
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
				OctoFrame_FROMBANK:SetFrameStrata("LOW")
				OctoFrame_FROMBANK:SetPoint("CENTER", -500, 32)
				OctoFrame_FROMBANK:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_FROMBANK:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_FROMBANK:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_FROMBANK:RegisterForClicks("LeftButtonUp")
				OctoFrame_FROMBANK:SetScript("OnClick", function()
						for bag=REAGENTBANK_CONTAINER, BANK_CONTAINER do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local n = C_Container.GetContainerItemLink(bag, slot)
								if n then
									C_Container.UseContainerItem(bag, slot)
								end
							end
						end
						for bag=NUM_TOTAL_EQUIPPED_BAG_SLOTS+1, NUM_TOTAL_EQUIPPED_BAG_SLOTS+NUM_BANKBAGSLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local n = C_Container.GetContainerItemLink(bag, slot)
								if n then
									C_Container.UseContainerItem(bag, slot)
								end
							end
						end
					end
				)
				OctoFrame_FROMBANK.RightEdge:SetVertexColor(0, 1, 0)
				OctoFrame_FROMBANK.icon = OctoFrame_FROMBANK:CreateTexture(nil, "ARTWORK")
				OctoFrame_FROMBANK.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Arrow_RIGHT.tga")
				OctoFrame_FROMBANK.icon:SetAllPoints(OctoFrame_FROMBANK)
				OctoFrame_FROMBANK:Show()
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_TOBANK then
					OctoFrame_TOBANK = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_TOBANK:Hide()
				end
				OctoFrame_TOBANK:SetSize(64*E.Octo_Globals.scale, 64*E.Octo_Globals.scale)
				OctoFrame_TOBANK:SetFrameStrata("LOW")
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
				OctoFrame_TOBANK:SetScript("OnClick", function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local itemLink = C_Container.GetContainerItemLink(bag, slot)
								if itemLink then
									C_Container.UseContainerItem(bag, slot)
								end
							end
						end
					end
				)
				OctoFrame_TOBANK.LeftEdge:SetVertexColor(0, 1, 0)
				OctoFrame_TOBANK.icon = OctoFrame_TOBANK:CreateTexture(nil, "ARTWORK")
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
--AutoTurnQuests
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.AutoTurnQuests then
			-- print (AddonTitle.." ".."AutoTurnIn |CFFFF0000ВКЛЮЧЕН|r")
			local Octo_AutoTurnInFrame_EventFrame = nil
			function Octo_AutoTurnInOnLoad()
				if not Octo_AutoTurnInFrame_EventFrame then
					Octo_AutoTurnInFrame_EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
				end
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_DETAIL")
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_COMPLETE")
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_GREETING")
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("GOSSIP_SHOW")
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_PROGRESS")
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_LOG_UPDATE")
				Octo_AutoTurnInFrame_EventFrame:RegisterEvent("QUEST_ACCEPTED")
			end
			local function OnEvent(self, event, ...)
				if event == "QUEST_DETAIL" then
					if not IsShiftKeyDown() then
						-- print (AddonTitle.." "..event)
						if QuestIsFromAreaTrigger() then
							AcceptQuest()
						elseif QuestGetAutoAccept() then
							AcknowledgeAutoAcceptQuest()
						end
						AcceptQuest()
					end
				elseif event == "QUEST_COMPLETE" then
					if not IsShiftKeyDown() then
						-- print (AddonTitle.." "..event)
						if GetNumQuestChoices() <= 1 then
							GetQuestReward(1)
						else
							-- print ("ДОХЪУ")
						end
					end
				elseif event == "QUEST_GREETING" then -- Запускается при разговоре с NPC, который предлагает или принимает более одного квеста, т. е. имеет более одного активного или доступного квеста.
					if not IsShiftKeyDown() then
						-- print (AddonTitle.." "..event)
						-- turn in all completed quests
						for i = 1, GetNumActiveQuests() do
							local _, isComplete = GetActiveTitle(i)
							if isComplete and not C_QuestLog.IsWorldQuest(GetActiveQuestID(i)) then
								SelectActiveQuest(i)
							end
						end
						-- accept all available quests
						for i = 1, GetNumAvailableQuests() do
							local isTrivial, _, isRepeatable, _, questID = GetAvailableQuestInfo(i)
							--if (not isTrivial or isTrackingTrivialQuests()) and (not isRepeatable --[[or addon.db.profile.general.acceptRepeatables]]) then
							if (isTrivial and Octo_ToDoVars.config.TrivialQuests == false) and (isRepeatable and Octo_ToDoVars.config.RepeatableQuests == false) then
								return
							else
								SelectAvailableQuest(i)
							end
						end
					end
				elseif event == "GOSSIP_SHOW" then
					if not IsShiftKeyDown() --[[and not ignore_list_NPC[targetNPCID] then]] then
						-- turn in all completed quests
						if C_GossipInfo.GetActiveQuests() ~= 0 then
							for _, info in pairs(C_GossipInfo.GetActiveQuests()) do
								if info.isComplete and not C_QuestLog.IsWorldQuest(info.questID) then
									C_GossipInfo.SelectActiveQuest(info.questID)
								end
							end
						end
						-- accept all available quests
						if C_GossipInfo.GetAvailableQuests() ~= 0 then
							for _, info in pairs(C_GossipInfo.GetAvailableQuests()) do
								-- print (info.title, info.questLevel, info.repeatable, info.frequency, info.isIgnored, info.isLegendary)
								-- if (not info.isTrivial --[[or isTrackingTrivialQuests()]]) and (not info.repeatable --[[or addon.db.profile.general.acceptRepeatables]]) then
								if (info.isTrivial and Octo_ToDoVars.config.TrivialQuests == false) and (info.repeatable and Octo_ToDoVars.config.RepeatableQuests == false) then
									return
								else
									C_GossipInfo.SelectAvailableQuest(info.questID)
								end
							end
						end
					end
				elseif event == "QUEST_PROGRESS" then
					if not IsShiftKeyDown() then
						-- print (AddonTitle.." "..event)
						CompleteQuest()
						-- elseif event == "QUEST_LOG_UPDATE" then
						-- print (AddonTitle.." "..event)
						-- elseif event == "QUEST_ACCEPTED" then
						-- print (AddonTitle.." "..event)
					end
				end
			end
			Octo_AutoTurnInOnLoad()
			Octo_AutoTurnInFrame_EventFrame:SetScript("OnEvent", OnEvent) --for function
		end
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--AutoTurnQuests
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.SORTING then
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
		end
end)
