local GlobalAddonName, E = ...

function E.LoadCVars()
	-- print(E.Green_Color.."Load CVars|r")

	-- Grouped CVars by functionality
	local cvars = {
		-- Performance and UI
		["addonProfilerEnabled"] = 0,
		["overrideScreenFlash"] = 1,
		["CameraReduceUnexpectedMovement"] = 0,
		["ShakeStrengthUI"] = 0,
		["motionSicknessLandscapeDarkening"] = 0,
		["motionSicknessFocalCircle"] = 0,
		["DisableAdvancedFlyingFullScreenEffects"] = 1,
		["DisableAdvancedFlyingVelocityVFX"] = 0,
		["enableMultiActionBars"] = E.isElvUI and 63 or 127,

		-- Combat text
		["spellActivationOverlayOpacity"] = E.isWeakAuras and 0 or 1,
		["floatingCombatTextCombatDamage"] = E.isWeakAuras and 0 or 1,
		["floatingCombatTextCombatDamageAllAutos"] = E.isWeakAuras and 0 or 1,
		["floatingCombatTextCombatDamageDirectionalOffset"] = E.isWeakAuras and 0 or 1,
		["floatingCombatTextCombatDamageDirectionalScale"] = E.isWeakAuras and 0 or 1,
		["floatingCombatTextCombatHealing"] = E.isWeakAuras and 0 or 1,
		["floatingCombatTextCombatHealingAbsorbSelf"] = E.isWeakAuras and 0 or 1,
		["floatingCombatTextCombatHealingAbsorbTarget"] = E.isWeakAuras and 0 or 1,
		["floatingCombatTextCombatLogPeriodicSpells"] = E.isWeakAuras and 0 or 1,
		["floatingCombatTextPetMeleeDamage"] = E.isWeakAuras and 0 or 1,
		["floatingCombatTextPetSpellDamage"] = E.isWeakAuras and 0 or 1,

		-- Nameplates
		["nameplateShowOnlyNames"] = 0,
		["nameplateShowFriends"] = 0,
		["nameplateVerticalScale"] = 1,
		["nameplateMotion"] = 1,
		["NamePlateClassificationScale"] = 1,
		["nameplateGlobalScale"] = 1,
		["NamePlateHorizontalScale"] = 1,
		["nameplateLargerScale"] = 1.2,
		["nameplateLargeTopInset"] = 0.1,
		["nameplateMaxAlpha"] = 0.6,
		["nameplateMaxDistance"] = 60,
		["NamePlateMaximumClassificationScale"] = 1,
		["nameplateMaxScale"] = 1,
		["nameplateMaxScaleDistance"] = 10,
		["nameplateMinAlpha"] = 0.6,
		["nameplateMinAlphaDistance"] = 10,
		["nameplateMinScale"] = 1,
		["nameplateMotionSpeed"] = 0.025,
		["nameplateOccludedAlphaMult"] = 0.4,
		["nameplateOverlapV"] = 1,
		["NameplatePersonalHideDelayAlpha"] = 0.45,
		["NameplatePersonalHideDelaySeconds"] = 3,
		["NameplatePersonalShowInCombat"] = 1,
		["nameplateResourceOnTarget"] = 0,
		["nameplateSelectedAlpha"] = 1,
		["nameplateSelectedScale"] = 1.2,
		["nameplateSelfAlpha"] = 0.75,
		["nameplateSelfScale"] = 1,
		["nameplateShowAll"] = 1,
		["nameplateShowDebuffsOnFriendly"] = 1,
		["nameplateShowEnemyGuardians"] = 0,
		["nameplateShowEnemyMinions"] = 0,
		["nameplateShowEnemyPets"] = 0,
		["nameplateShowEnemyTotems"] = 1,
		["nameplateShowSelf"] = 0,
		["nameplateTargetBehindMaxDistance"] = 30,

		-- UI Settings
		["countdownForCooldowns"] = E.isElvUI and 0 or 1,
		["StatusText"] = E.isElvUI and 0 or 1,
		["StatusTextDisplay"] = E.isElvUI and "NONE" or "BOTH",
		["alwaysCompareItems"] = 0,
		["rotateMinimap"] = 0,
		["showBattlefieldMinimap"] = 0,
		["displaySpellActivationOverlays"] = 1,
		["AutoPushSpellToActionBar"] = 0,
		["alwaysShowActionBars"] = 1,
		["autoLootDefault"] = 1,
		["cameraDistanceMaxZoomFactor"] = 2.6,
		["cameraSmoothStyle"] = 0,
		["colorChatNamesByClass"] = 1,
		["combinedBags"] = 1,
		["displayFreeBagSlots"] = 1,
		["doNotFlashLowHealthWarning"] = 1,
		["enableFloatingCombatText"] = 0,
		["enablePetBattleFloatingCombatText"] = 0,
		["expandBagBar"] = 0,
		["findYourselfAnywhere"] = 0,
		["findYourselfMode"] = 0,
		["mapFade"] = 0,
		["useUiScale"] = 1,
		["uiScale"] = 0.7111111111111111,
		["WorldTextScale"] = 0.7111111111111111,
		["ActionButtonUseKeyDown"] = 1,

		-- Visual Effects
		["ffxDeath"] = 1,
		["ffxGlow"] = 0,
		["ffxLingeringVenari"] = 1,
		["ffxNether"] = 1,
		["ffxVenari"] = 1,

		-- Social
		["profanityFilter"] = 0,
		["guildMemberNotify"] = 0,
		["showToastWindow"] = 0,

		-- Sound
		["Sound_MaxCacheSizeInBytes"] = 134217728,
		["Sound_NumChannels"] = 64,

		-- Gameplay
		["spellqueuewindow"] = 140,
		["LowLatencyMode"] = 2,
		["SoftTargetEnemy"] = 1,

		-- Tutorials
		["showTutorials"] = 0,
		["showNPETutorials"] = 0,
		["gameTip"] = 0,
		["interactKeyWarningTutorial"] = 0,

		-- Unit Names
		["ShowClassColorInFriendlyNameplate"] = 1,
		["ShowClassColorInNameplate"] = 1,
		["UnitNameEnemyGuardianName"] = 1,
		["UnitNameEnemyMinionName"] = 1,
		["UnitNameEnemyPetName"] = 0,
		["UnitNameEnemyPlayerName"] = 1,
		["UnitNameEnemyTotemName"] = 1,
		["UnitNameForceHideMinus"] = 0,
		["UnitNameFriendlyGuardianName"] = 1,
		["UnitNameFriendlyMinionName"] = 1,
		["UnitNameFriendlyPetName"] = 0,
		["UnitNameFriendlyPlayerName"] = 1,
		["UnitNameFriendlySpecialNPCName"] = 1,
		["UnitNameFriendlyTotemName"] = 1,
		["UnitNameGuildTitle"] = 0,
		["UnitNameHostleNPC"] = 1,
		["UnitNameInteractiveNPC"] = 1,
		["UnitNameNPC"] = 1,
		["UnitNameOwn"] = 0,
		["UnitNamePlayerGuild"] = 0,
		["UnitNamePlayerPVPTitle"] = 0,

		-- Raid Frames
		["raidFramesDisplayPowerBars"] = 1,
		["raidFramesDisplayOnlyHealerPowerBars"] = 1,
		["raidFramesDisplayAggroHighlight"] = 1,
		["raidFramesDisplayClassColor"] = 1,
		["raidFramesDisplayDebuffs"] = 1,
		["raidFramesDisplayIncomingHeals"] = 1,
		["raidFramesDisplayOnlyDispellableDebuffs"] = 1,

		-- 11.1.5 Features
		["cooldownViewerEnabled"] = 0,
		["CursorFreelookStartDelta"] = 0.001,
		["minimapTrackingShowAll"] = 1,
		["bankAutoDepositReagents"] = 1,
		["enablePings"] = 0,
		["pingMode"] = 0,
		["showPingsInChat"] = 0,
		["Sound_EnablePingSounds"] = 0,
		["Sound_PingVolume"] = 0,

		-- 11.1.7 Features
		["assistedCombatHighlight"] = 1,
	}

	-- Register and set all CVars
	C_CVar.RegisterCVar("addonProfilerEnabled", 0)
	for cvar, value in next, (cvars) do
		C_CVar.SetCVar(cvar, value)
	end
end

-- C_CVar.SetCVar("closedExtraAbilityTutorials", 1)
-- C_CVar.SetCVar("covenantMissionTutorial", 1)
-- C_CVar.SetCVar("soulbindsActivatedTutorial", 1)
-- C_CVar.SetCVar("soulbindsLandingPageTutorial", 1)
-- C_CVar.SetCVar("soulbindsViewedTutorial", 1)
-- C_CVar.SetCVar("Sound_EnableMusic", 1)
-- C_CVar.SetCVar("Sound_EnableAmbience", 1)
-- C_CVar.SetCVar("Sound_EnableDialog", 1)
-- C_CVar.SetCVar("Sound_EnableSFX", 1)
-- C_CVar.SetCVar("whisperMode", popout_and_inline)
-- C_NamePlate.SetNamePlateFriendlySize(0.1, 0.1) --короткий ХП бар 50 100