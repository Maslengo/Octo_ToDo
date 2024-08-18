local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
local Enable_Module = true
	if E.Octo_Globals.isElvUI == true and Enable_Module == true then
	local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
	local MyPlugin = E:NewModule("Octo_ElvUI_DEV", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0");
	local EP = LibStub("LibElvUIPlugin-1.0")
	local addonName, addonTable = ...
	P["Octo_ElvUI_DEV"] = {
		["HideObjectiveTracker"] = false,
		["HideZoneText"] = false,
		["Covenant"] = false,
		["UIErrorsFrame"] = false,
		["RaidBossEmoteFrame"] = false,
		["CinematicCanceler"] = false,
		["TalkingHeadFrame"] = false,
		["BossBanner"] = false,
		["MajorFactionsRenownToast"] = true,
	}
	function MyPlugin:Update()
	----------------------------------------------------------------------------------------------------------------------------------
		local enabled = E.db.Octo_ElvUI_DEV.HideObjectiveTracker
		if enabled then
			ObjectiveTrackerFrame:Hide()
			else
			--print("ObjectiveTrackerFrame |cff4FFF79ВИДНЫ|r")
			-- ObjectiveTrackerFrame:Show()
		end
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
		local enabled = E.db.Octo_ElvUI_DEV.HideZoneText
		if enabled then
			ZoneTextFrame:UnregisterAllEvents()
			EventToastManagerFrame:UnregisterAllEvents()
			--Оставляет не кликабельный фрейм
			--[[EventToastManagerFrame.currentDisplayingToast:Hide()
			EventToastManagerFrame.currentDisplayingToast.BG1:Hide()
			EventToastManagerFrame.currentDisplayingToast.BG2:Hide()
			EventToastManagerFrame.currentDisplayingToast.Description:Hide()
			EventToastManagerFrame.currentDisplayingToast.PaddingFrame:Hide()
			EventToastManagerFrame.BlackBG:Hide()
			EventToastManagerFrame.GLine:Hide()
			EventToastManagerFrame.GLine2:Hide()
			EventToastManagerFrame.HideButton:Hide()
			EventToastManagerFrame.HideButton.Text:Hide()]]
		else
			-- ZoneTextFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
			-- ZoneTextFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
			-- ZoneTextFrame:RegisterEvent("ZONE_CHANGED")
			-- EventToastManagerFrame:RegisterAllEvents()
			--[[EventToastManagerFrame:Show()
			EventToastManagerFrame.currentDisplayingToast:Show()
			EventToastManagerFrame.currentDisplayingToast.BG1:Show()
			EventToastManagerFrame.currentDisplayingToast.BG2:Show()
			EventToastManagerFrame.currentDisplayingToast.Description:Show()
			EventToastManagerFrame.currentDisplayingToast.PaddingFrame:Show()
			EventToastManagerFrame.BlackBG:Hide()
			EventToastManagerFrame.GLine:Hide()
			EventToastManagerFrame.GLine2:Hide()]]
		end
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
		local enabled = E.db.Octo_ElvUI_DEV.Covenant
		if enabled then
			CovenantChoiceToast:UnregisterAllEvents()
			CovenantRenownToast:UnregisterAllEvents()
			--[[
			CovenantChoiceToast:Hide()
			CovenantChoiceToast.CovenantName:Hide()
			CovenantChoiceToast.GlowLineTopAdditive:Hide()
			CovenantChoiceToast.HeaderText:Hide()
			CovenantChoiceToast.Icon.Tex:Hide()
			CovenantChoiceToast.IconSwirlModelScene:Hide()
			CovenantChoiceToast.ToastBG:Hide()
			CovenantRenownToast:Hide()
			CovenantRenownToast.GlowLineTop:Hide()
			CovenantRenownToast.GlowLineTopAdditive:Hide()
			CovenantRenownToast.GlowLineTopBottom:Hide()
			CovenantRenownToast.Icon.Tex:Hide()
			CovenantRenownToast.IconSwirlModelScene:Hide()
			CovenantRenownToast.RewardDescription:Hide()
			CovenantRenownToast.RewardIcon:Hide()
			CovenantRenownToast.RewardIconMask:Hide()
			CovenantRenownToast.RewardIconMouseOver:Hide()
			CovenantRenownToast.RewardIconRing:Hide()
			CovenantRenownToast.Stars1:Hide()
			CovenantRenownToast.Stars2:Hide()
			CovenantRenownToast.ToastBG:Hide()]]
		else
			-- CovenantChoiceToast:RegisterAllEvents()
			-- CovenantRenownToast:RegisterAllEvents()
		end
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
		local enabled = E.db.Octo_ElvUI_DEV.UIErrorsFrame
		if enabled then
		UIErrorsFrame:Hide()
		else
		-- UIErrorsFrame:Show()
		end
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
		local enabled = E.db.Octo_ElvUI_DEV.RaidBossEmoteFrame
		if enabled then
		RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
		RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_WHISPER")
		RaidBossEmoteFrame:UnregisterEvent("CLEAR_BOSS_EMOTES")
		RaidBossEmoteFrame:UnregisterAllEvents()
		RaidBossEmoteFrame:Hide()
		RaidBossEmoteFrameSlot1:Hide()
		RaidBossEmoteFrameSlot2:Hide()
		ObjectiveTrackerBonusBannerFrame:Hide()
		ObjectiveTrackerBonusBannerFrame.BG1:Hide()
		ObjectiveTrackerBonusBannerFrame.BG2:Hide()
		ObjectiveTrackerBonusBannerFrame.Icon:Hide()
		ObjectiveTrackerBonusBannerFrame.Icon2:Hide()
		ObjectiveTrackerBonusBannerFrame.Icon3:Hide()
		ObjectiveTrackerBonusBannerFrame.BonusLabel:Hide()
		ObjectiveTrackerBonusBannerFrame.Title:Hide()
		ObjectiveTrackerBonusBannerFrame.TitleFlash:Hide()
		else
		-- RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
		-- RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_WHISPER")
		-- RaidBossEmoteFrame:RegisterEvent("CLEAR_BOSS_EMOTES")
		-- RaidBossEmoteFrame:RegisterAllEvents()
		-- RaidBossEmoteFrame:Show()
		-- RaidBossEmoteFrameSlot1:Show()
		-- RaidBossEmoteFrameSlot2:Show()
		-- ObjectiveTrackerBonusBannerFrame:Show()
		-- ObjectiveTrackerBonusBannerFrame.BG1:Show()
		-- ObjectiveTrackerBonusBannerFrame.BG2:Show()
		-- ObjectiveTrackerBonusBannerFrame.Icon:Show()
		-- ObjectiveTrackerBonusBannerFrame.Icon2:Show()
		-- ObjectiveTrackerBonusBannerFrame.Icon3:Show()
		-- ObjectiveTrackerBonusBannerFrame.BonusLabel:Show()
		-- ObjectiveTrackerBonusBannerFrame.Title:Show()
		-- ObjectiveTrackerBonusBannerFrame.TitleFlash:Show()
		end
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
		local enabled = E.db.Octo_ElvUI_DEV.CinematicCanceler
		if enabled then
			CinematicFrame:HookScript("OnShow", function(self, ...)
			if IsModifierKeyDown() then return end --если нажат модификатор, то запустится мувик
			print("|cFF00A3FFCinematic|r |cffFF4C4Fcanceled.|r")
			CinematicFrame_CancelCinematic()
			end)
			local omfpf = _G["MovieFrame_PlayMovie"] --запускает мувик?
			_G["MovieFrame_PlayMovie"] = function(...)
			if IsModifierKeyDown() then return omfpf(...) end
			print("|cFF00A3FFMovie|r |cffFF4C4Fcanceled.|r")
			GameMovieFinished() return true
			end
		end
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
		local enabled = E.db.Octo_ElvUI_DEV.TalkingHeadFrame
		if enabled then
			hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
				self:Hide()
			end)
		print("|cFF00A3FFTalking head frame|r |cffFF4C4Fcanceled.|r")
		end
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
		local enabled = E.db.Octo_ElvUI_DEV.BossBanner
		if enabled then
			BossBanner:UnregisterAllEvents()
			BossBanner:Hide()
		else
			-- BossBanner:RegisterAllEvents()
			-- BossBanner:Show()
		end
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
		local enabled = E.db.Octo_ElvUI_DEV.MajorFactionsRenownToast
		if enabled then
			if MajorFactionsRenownToast then
				print ("MajorFactionsRenownToast HIDE")
				MajorFactionsRenownToast:UnregisterAllEvents()
			end
			-- MajorFactionsRenownToast:Hide()
		else
			-- MajorFactionsRenownToast:RegisterAllEvents()
			--MajorFactionsRenownToast:Show()
		end
	----------------------------------------------------------------------------------------------------------------------------------
	end
	function MyPlugin:InsertOptions()
		E.Options.args.Octo_ElvUI_DEV = {
			order = 100,
			type = "group",
			name = "|cFF00A3FFOcto|r |cffFF4C4FDEV|r",
			args = {
	----------------------------------------------------------------------------------------------------------------------------------
				HideObjectiveTracker = {
					order = 1,
					type = "toggle",
					name = "Квесты",
					get = function(info)
						return E.db.Octo_ElvUI_DEV.HideObjectiveTracker
					end,
					set = function(info, value)
						E.db.Octo_ElvUI_DEV.HideObjectiveTracker = value
						MyPlugin:Update()
					end,
				},
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
				HideZoneText = {
					order = 2,
					type = "toggle",
					name = "Название зон",
					get = function(info)
						return E.db.Octo_ElvUI_DEV.HideZoneText
					end,
					set = function(info, value)
						E.db.Octo_ElvUI_DEV.HideZoneText = value
						MyPlugin:Update()
					end,
				},
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
				Covenant = {
					order = 3,
					type = "toggle",
					name = "Ковенант",
					get = function(info)
						return E.db.Octo_ElvUI_DEV.Covenant
					end,
					set = function(info, value)
						E.db.Octo_ElvUI_DEV.Covenant = value
						MyPlugin:Update()
					end,
				},
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
				UIErrorsFrame = {
					order = 4,
					type = "toggle",
					name = "Фрейм ошибок",
					get = function(info)
						return E.db.Octo_ElvUI_DEV.UIErrorsFrame
					end,
					set = function(info, value)
						E.db.Octo_ElvUI_DEV.UIErrorsFrame = value
						MyPlugin:Update()
					end,
				},
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
				RaidBossEmoteFrame = {
					order = 5,
					type = "toggle",
					name = "Фрейм РБ",
					get = function(info)
						return E.db.Octo_ElvUI_DEV.RaidBossEmoteFrame
					end,
					set = function(info, value)
						E.db.Octo_ElvUI_DEV.RaidBossEmoteFrame = value
						MyPlugin:Update()
					end,
				},
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
				CinematicCanceler = {
					order = 6,
					type = "toggle",
					name = "Синематики",
					get = function(info)
						return E.db.Octo_ElvUI_DEV.CinematicCanceler
					end,
					set = function(info, value)
						E.db.Octo_ElvUI_DEV.CinematicCanceler = value
						MyPlugin:Update()
					end,
				},
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
				TalkingHeadFrame = {
					order = 7,
					type = "toggle",
					name = "Говорящая голова",
					get = function(info)
						return E.db.Octo_ElvUI_DEV.TalkingHeadFrame
					end,
					set = function(info, value)
						E.db.Octo_ElvUI_DEV.TalkingHeadFrame = value
						MyPlugin:Update()
					end,
				},
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
				BossBanner = {
					order = 8,
					type = "toggle",
					name = "Близовский лут",
					get = function(info)
						return E.db.Octo_ElvUI_DEV.BossBanner
					end,
					set = function(info, value)
						E.db.Octo_ElvUI_DEV.BossBanner = value
						MyPlugin:Update()
					end,
				},
	----------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------
				MajorFactionsRenownToast = {
					order = 9,
					type = "toggle",
					name = "MajorFactionsRenownToast",
					get = function(info)
						return E.db.Octo_ElvUI_DEV.MajorFactionsRenownToast
					end,
					set = function(info, value)
						E.db.Octo_ElvUI_DEV.MajorFactionsRenownToast = value
						MyPlugin:Update()
					end,
				},
	----------------------------------------------------------------------------------------------------------------------------------
			},
		}
	end
	function MyPlugin:Initialize()
		EP:RegisterPlugin(addonName,MyPlugin.InsertOptions)
			MyPlugin:Update()
	end
	E:RegisterModule(MyPlugin:GetName())
end