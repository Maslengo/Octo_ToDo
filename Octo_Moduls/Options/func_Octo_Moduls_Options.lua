local GlobalAddonName, ns = ...
E = _G.OctoEngine
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
-------------------------------------------------------------------------
function E.func_Octo_Moduls_Options(savedVars)
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local Options = {
		type = "group",
		childGroups = "tab",
		name = E.func_AddonNameForOptionsFunc(GlobalAddonName), -- BINDING_HEADER_DEBUG
		args = {
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			SpeedFrameShown = {
				type = "toggle",
				name = "SpeedFrame.Shown",
				desc = "",
				get = function()
					return Octo_Moduls_DB.SpeedFrame.Shown
				end,
				set = function(_, value)
					Octo_Moduls_DB.SpeedFrame.Shown = value
					if Octo_MainFrame_SpeedFrame then
						Octo_MainFrame_SpeedFrame:SetShown(value)
					end
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			PosFrameShown = {
				type = "toggle",
				name = "PosFrame.Shown",
				desc = "",
				get = function()
					return Octo_Moduls_DB.PosFrame.Shown
				end,
				set = function(_, value)
					Octo_Moduls_DB.PosFrame.Shown = value
					if Octo_MainFrame_PosFrame then
						Octo_MainFrame_PosFrame:SetShown(value)
					end
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			SellFrame = {
				type = "toggle",
				name = "SellFrame",
				desc = "",
				get = function()
					return Octo_Moduls_DB.SellFrame
				end,
				set = function(_, value)
					Octo_Moduls_DB.SellFrame = value
					if Octo_MainFrame_SellFrame1 then
						Octo_MainFrame_SellFrame1:SetShown(value)
					end
					if Octo_MainFrame_SellFrame2 then
						Octo_MainFrame_SellFrame2:SetShown(value)
					end
					if Octo_MainFrame_SellFrame3 then
						Octo_MainFrame_SellFrame3:SetShown(value)
					end
					if Octo_MainFrame_SellFrame4 then
						Octo_MainFrame_SellFrame4:SetShown(value)
					end
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Auto_SellGrey = {
				type = "toggle",
				name = L["Auto Sell Grey"], -- "AUTO "..SELL_ALL_JUNK_ITEMS_EXCLUDE_HEADER, --
				desc = "",
				get = function()
					return savedVars.Config_Auto_SellGrey
				end,
				set = function(_, value)
					savedVars.Config_Auto_SellGrey = value
				end,
				width = E.FULL_WIDTH/2, -- "full",
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Auto_Repair = {
				type = "toggle",
				name = L["Auto Repair"], -- "AUTO "..REPAIR_ALL_ITEMS, --
				desc = "",
				get = function()
					return savedVars.Config_Auto_Repair
				end,
				set = function(_, value)
					savedVars.Config_Auto_Repair = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Auto_InputDelete = {
				type = "toggle",
				name = L["Auto Input Delete"], -- "AUTO "..DELETE, --
				desc = "",
				get = function()
					return savedVars.Config_Auto_InputDelete
				end,
				set = function(_, value)
					savedVars.Config_Auto_InputDelete = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Auto_OpenItems = {
				type = "toggle",
				name = L["Auto Open Items"],
				desc = "",
				get = function()
					return savedVars.Config_Auto_OpenItems
				end,
				set = function(_, value)
					savedVars.Config_Auto_OpenItems = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Auto_Gossip = {
				type = "toggle",
				name = L["Auto Gossip"],
				desc = "",
				get = function()
					return savedVars.Config_Auto_Gossip
				end,
				set = function(_, value)
					savedVars.Config_Auto_Gossip = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Auto_TurnQuests = {
				type = "toggle",
				name = L["Auto Turn Quests"],
				desc = "",
				get = function()
					return savedVars.Config_Auto_TurnQuests
				end,
				set = function(_, value)
					savedVars.Config_Auto_TurnQuests = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Auto_ChatClearing = {
				type = "toggle",
				name = L["Auto Clear Chat"],
				desc = "",
				get = function()
					return savedVars.Config_Auto_ChatClearing
				end,
				set = function(_, value)
					savedVars.Config_Auto_ChatClearing = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Auto_Screenshot = {
				type = "toggle",
				name = L["Auto Screenshot"],
				desc = "",
				get = function()
					return savedVars.Config_Auto_Screenshot
				end,
				set = function(_, value)
					savedVars.Config_Auto_Screenshot = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Auto_CinematicCanceler = {
				type = "toggle",
				name = L["Auto Cinematic Canceler"],
				desc = "",
				get = function()
					return savedVars.Config_Auto_CinematicCanceler
				end,
				set = function(_, value)
					savedVars.Config_Auto_CinematicCanceler = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Auto_CinematicFastSkip = {
				type = "toggle",
				name = "Cinematic Fast Skip (ESC/Space/Enter)",
				desc = "",
				get = function()
					return savedVars.Config_Auto_CinematicFastSkip
				end,
				set = function(_, value)
					savedVars.Config_Auto_CinematicFastSkip = value
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_CheckListText = {
				type = "toggle",
				name = L["Hide: CheckListText"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_CheckListText
				end,
				set = function(_, value)
					savedVars.Config_Hide_CheckListText = value
					E.func_Config_Hide_CheckListText()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_SubscriptionInterstitialFrame = {
				type = "toggle",
				-- name = savedVars.Config_Hide_SubscriptionInterstitialFrame and E.Green_Color..L["Hide: SubscriptionInterstitialFrame"].."|r" or E.Red_Color..L["Hide: SubscriptionInterstitialFrame"].."|r",
				name = E.Green_Color..L["Hide: SubscriptionInterstitialFrame"].."|r",
				desc = "",
				get = function()
					return savedVars.Config_Hide_SubscriptionInterstitialFrame
				end,
				set = function(_, value)
					savedVars.Config_Hide_SubscriptionInterstitialFrame = value
					E.func_Config_Hide_SubscriptionInterstitialFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_ActionStatusText = {
				type = "toggle",
				name = L["Hide: ActionStatusText"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_ActionStatusText
				end,
				set = function(_, value)
					savedVars.Config_Hide_ActionStatusText = value
					E.func_Config_Hide_ActionStatusText()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_SecondaryStatusTrackingBarContainer = {
				type = "toggle",
				name = L["Hide: SecondaryStatusTrackingBarContainer"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_SecondaryStatusTrackingBarContainer
				end,
				set = function(_, value)
					savedVars.Config_Hide_SecondaryStatusTrackingBarContainer = value
					E.func_Config_Hide_SecondaryStatusTrackingBarContainer()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_MainStatusTrackingBarContainer = {
				type = "toggle",
				name = "Полоска опыта", -- L["Hide: MainStatusTrackingBarContainer"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_MainStatusTrackingBarContainer
				end,
				set = function(_, value)
					savedVars.Config_Hide_MainStatusTrackingBarContainer = value
					E.func_Config_Hide_MainStatusTrackingBarContainer()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_WeeklyRewardExpirationWarningDialog = {
				type = "toggle",
				name = L["Hide: WeeklyRewardExpirationWarningDialog"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_WeeklyRewardExpirationWarningDialog
				end,
				set = function(_, value)
					savedVars.Config_Hide_WeeklyRewardExpirationWarningDialog = value
					E.func_Config_Hide_WeeklyRewardExpirationWarningDialog()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_MajorFactionsRenownToast = {
				type = "toggle",
				name = L["Hide: MajorFactionsRenownToast"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_MajorFactionsRenownToast
				end,
				set = function(_, value)
					savedVars.Config_Hide_MajorFactionsRenownToast = value
					E.func_Config_Hide_MajorFactionsRenownToast()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_UIWidgetTopCenterContainerFrame = {
				type = "toggle",
				name = L["Hide: UIWidgetTopCenterContainerFrame"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_UIWidgetTopCenterContainerFrame
				end,
				set = function(_, value)
					savedVars.Config_Hide_UIWidgetTopCenterContainerFrame = value
					E.func_Config_Hide_UIWidgetTopCenterContainerFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_BossBanner = {
				type = "toggle",
				name = L["Hide: BossBanner"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_BossBanner
				end,
				set = function(_, value)
					savedVars.Config_Hide_BossBanner = value
					E.func_Config_Hide_BossBanner()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_RaidWarningFrame = {
				type = "toggle",
				name = L["Hide: RaidWarningFrame"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_RaidWarningFrame
				end,
				set = function(_, value)
					savedVars.Config_Hide_RaidWarningFrame = value
					E.func_Config_Hide_RaidWarningFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_RaidBossEmoteFrame = {
				type = "toggle",
				name = L["Hide: RaidBossEmoteFrame"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_RaidBossEmoteFrame
				end,
				set = function(_, value)
					savedVars.Config_Hide_RaidBossEmoteFrame = value
					E.func_Config_Hide_RaidBossEmoteFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_PrivateRaidBossEmoteFrameAnchor = {
				type = "toggle",
				name = L["Hide: PrivateRaidBossEmoteFrameAnchor"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_PrivateRaidBossEmoteFrameAnchor
				end,
				set = function(_, value)
					savedVars.Config_Hide_PrivateRaidBossEmoteFrameAnchor = value
					E.func_Config_Hide_PrivateRaidBossEmoteFrameAnchor()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_SplashFrame = {
				type = "toggle",
				name = L["Hide: SplashFrame"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_SplashFrame
				end,
				set = function(_, value)
					savedVars.Config_Hide_SplashFrame = value
					E.func_Config_Hide_SplashFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_PTRReporter = {
				type = "toggle",
				name = L["Hide: PTRReporter"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_PTRReporter
				end,
				set = function(_, value)
					savedVars.Config_Hide_PTRReporter = value
					E.func_Config_Hide_PTRReporter()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_PTRIssueReporter = {
				type = "toggle",
				name = L["Hide: PTRIssueReporter"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_PTRIssueReporter
				end,
				set = function(_, value)
					savedVars.Config_Hide_PTRIssueReporter = value
					E.func_Config_Hide_PTRIssueReporter()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_PTRIssueReporterAlertFrame = {
				type = "toggle",
				name = L["Hide: PTRIssueReporterAlertFrame"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_PTRIssueReporterAlertFrame
				end,
				set = function(_, value)
					savedVars.Config_Hide_PTRIssueReporterAlertFrame = value
					E.func_Config_Hide_PTRIssueReporterAlertFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_Bug = {
				type = "toggle",
				name = L["Hide: Bug"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_Bug
				end,
				set = function(_, value)
					savedVars.Config_Hide_Bug = value
					E.func_Config_Hide_Bug()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_CovenantRenownToast = {
				type = "toggle",
				name = L["Hide: CovenantRenownToast"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_CovenantRenownToast
				end,
				set = function(_, value)
					savedVars.Config_Hide_CovenantRenownToast = value
					E.func_Config_Hide_CovenantRenownToast()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_CovenantChoiceToast = {
				type = "toggle",
				name = L["Hide: CovenantChoiceToast"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_CovenantChoiceToast
				end,
				set = function(_, value)
					savedVars.Config_Hide_CovenantChoiceToast = value
					E.func_Config_Hide_CovenantChoiceToast()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_ZoneTextFrame = {
				type = "toggle",
				name = L["Hide: ZoneTextFrame"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_ZoneTextFrame
				end,
				set = function(_, value)
					savedVars.Config_Hide_ZoneTextFrame = value
					E.func_Config_Hide_ZoneTextFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_SubZoneTextFrame = {
				type = "toggle",
				name = L["Hide: SubZoneTextFrame"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_SubZoneTextFrame
				end,
				set = function(_, value)
					savedVars.Config_Hide_SubZoneTextFrame = value
					E.func_Config_Hide_SubZoneTextFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_PVPArenaTextString = {
				type = "toggle",
				name = L["Hide: PVPArenaTextString"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_PVPArenaTextString
				end,
				set = function(_, value)
					savedVars.Config_Hide_PVPArenaTextString = value
					E.func_Config_Hide_PVPArenaTextString()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_ZoneTextString = {
				type = "toggle",
				name = L["Hide: ZoneTextString"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_ZoneTextString
				end,
				set = function(_, value)
					savedVars.Config_Hide_ZoneTextString = value
					E.func_Config_Hide_ZoneTextString()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_SubZoneTextString = {
				type = "toggle",
				name = L["Hide: SubZoneTextString"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_SubZoneTextString
				end,
				set = function(_, value)
					savedVars.Config_Hide_SubZoneTextString = value
					E.func_Config_Hide_SubZoneTextString()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_ErrorMessages = {
				type = "toggle",
				name = L["Hide: ErrorMessages"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_ErrorMessages
				end,
				set = function(_, value)
					savedVars.Config_Hide_ErrorMessages = value
					E.func_Config_Hide_ErrorMessages()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_TalkingHeadFrame = {
				type = "toggle",
				name = L["Hide: TalkingHeadFrame"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_TalkingHeadFrame
				end,
				set = function(_, value)
					savedVars.Config_Hide_TalkingHeadFrame = value
					E.func_Config_Hide_TalkingHeadFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_EventToastManagerFrame = {
				type = "toggle",
				name = L["Hide: EventToastManagerFrame"],
				desc = "",
				get = function()
					return savedVars.Config_Hide_EventToastManagerFrame
				end,
				set = function(_, value)
					savedVars.Config_Hide_EventToastManagerFrame = value
					E.func_Config_Hide_EventToastManagerFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			["Header"..GetOrder()] = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			reverseCleanupBags = {
				type = "toggle",
				name = REVERSE_CLEAN_UP_BAGS_TEXT,
				desc = OPTION_TOOLTIP_REVERSE_CLEAN_UP_BAGS,
				get = function()
					if C_Container and C_Container.GetSortBagsRightToLeft then
						return C_Container.GetSortBagsRightToLeft()
					elseif GetInsertItemsRightToLeft then
						return GetInsertItemsRightToLeft()
					end
				end,
				set = function(_, value)
					C_Timer.After(0.5, function()
						-- AceConfigRegistry:NotifyChange("Cvars")
						AceConfigRegistry:NotifyChange(E.func_AddonNameForOptionsInit(GlobalAddonName))
					end)
					if C_Container and C_Container.SetSortBagsRightToLeft then
						C_Container.SetSortBagsRightToLeft(value)
					elseif SetSortBagsRightToLeft then
						SetSortBagsRightToLeft(value)
					end
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
			-------------------------------------------------
		},
	}
	-------------------------------------------------
	-------------------------------------------------
	-------------------------------------------------
	return Options
end