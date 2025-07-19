local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function E:HideFrames()
	local index = 0
	local function GetOrder()
		index = index + 1
		return index
	end
	local HideFrames = {
		type = "group",
		childGroups = "tree",
		name = "HideFrames",
		args = {
			-------------------------------------------------
			Header1 = {
				type = "header",
				name = "",
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_CheckListText = {
				type = "toggle",
				name = L["Hide: CheckListText"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_CheckListText
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_CheckListText = value
					E:Hide_CheckListText()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_SubscriptionInterstitialFrame = {
				type = "toggle",
				-- name = Octo_ToDo_DB_Vars.Hide_SubscriptionInterstitialFrame and E.Green_Color..L["Hide: SubscriptionInterstitialFrame"].."|r" or E.Red_Color..L["Hide: SubscriptionInterstitialFrame"].."|r",
				name = E.Green_Color..L["Hide: SubscriptionInterstitialFrame"].."|r",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_SubscriptionInterstitialFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_SubscriptionInterstitialFrame = value
					E:Hide_SubscriptionInterstitialFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_ActionStatusText = {
				type = "toggle",
				name = L["Hide: ActionStatusText"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_ActionStatusText
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_ActionStatusText = value
					E:Hide_ActionStatusText()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_SecondaryStatusTrackingBarContainer = {
				type = "toggle",
				name = L["Hide: SecondaryStatusTrackingBarContainer"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_SecondaryStatusTrackingBarContainer
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_SecondaryStatusTrackingBarContainer = value
					E:Hide_SecondaryStatusTrackingBarContainer()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_MainStatusTrackingBarContainer = {
				type = "toggle",
				name = L["Hide: MainStatusTrackingBarContainer"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_MainStatusTrackingBarContainer
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_MainStatusTrackingBarContainer = value
					E:Hide_MainStatusTrackingBarContainer()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_WeeklyRewardExpirationWarningDialog = {
				type = "toggle",
				name = L["Hide: WeeklyRewardExpirationWarningDialog"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_WeeklyRewardExpirationWarningDialog
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_WeeklyRewardExpirationWarningDialog = value
					E:Hide_WeeklyRewardExpirationWarningDialog()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_MajorFactionsRenownToast = {
				type = "toggle",
				name = L["Hide: MajorFactionsRenownToast"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_MajorFactionsRenownToast
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_MajorFactionsRenownToast = value
					E:Hide_MajorFactionsRenownToast()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_UIWidgetTopCenterContainerFrame = {
				type = "toggle",
				name = L["Hide: UIWidgetTopCenterContainerFrame"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_UIWidgetTopCenterContainerFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_UIWidgetTopCenterContainerFrame = value
					E:Hide_UIWidgetTopCenterContainerFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_BossBanner = {
				type = "toggle",
				name = L["Hide: BossBanner"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_BossBanner
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_BossBanner = value
					E:Hide_BossBanner()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_RaidWarningFrame = {
				type = "toggle",
				name = L["Hide: RaidWarningFrame"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_RaidWarningFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_RaidWarningFrame = value
					E:Hide_RaidWarningFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_RaidBossEmoteFrame = {
				type = "toggle",
				name = L["Hide: RaidBossEmoteFrame"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_RaidBossEmoteFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_RaidBossEmoteFrame = value
					E:Hide_RaidBossEmoteFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_PrivateRaidBossEmoteFrameAnchor = {
				type = "toggle",
				name = L["Hide: PrivateRaidBossEmoteFrameAnchor"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_PrivateRaidBossEmoteFrameAnchor
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_PrivateRaidBossEmoteFrameAnchor = value
					E:Hide_PrivateRaidBossEmoteFrameAnchor()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_SplashFrame = {
				type = "toggle",
				name = L["Hide: SplashFrame"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_SplashFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_SplashFrame = value
					E:Hide_SplashFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_PTRReporter = {
				type = "toggle",
				name = L["Hide: PTRReporter"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_PTRReporter
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_PTRReporter = value
					E:Hide_PTRReporter()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_PTRIssueReporter = {
				type = "toggle",
				name = L["Hide: PTRIssueReporter"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_PTRIssueReporter
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_PTRIssueReporter = value
					E:Hide_PTRIssueReporter()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_PTRIssueReporterAlertFrame = {
				type = "toggle",
				name = L["Hide: PTRIssueReporterAlertFrame"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_PTRIssueReporterAlertFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_PTRIssueReporterAlertFrame = value
					E:Hide_PTRIssueReporterAlertFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_Bug = {
				type = "toggle",
				name = L["Hide: Bug"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_Bug
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_Bug = value
					E:Hide_Bug()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_CovenantRenownToast = {
				type = "toggle",
				name = L["Hide: CovenantRenownToast"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_CovenantRenownToast
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_CovenantRenownToast = value
					E:Hide_CovenantRenownToast()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_CovenantChoiceToast = {
				type = "toggle",
				name = L["Hide: CovenantChoiceToast"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_CovenantChoiceToast
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_CovenantChoiceToast = value
					E:Hide_CovenantChoiceToast()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_ZoneTextFrame = {
				type = "toggle",
				name = L["Hide: ZoneTextFrame"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_ZoneTextFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_ZoneTextFrame = value
					E:Hide_ZoneTextFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_SubZoneTextFrame = {
				type = "toggle",
				name = L["Hide: SubZoneTextFrame"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_SubZoneTextFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_SubZoneTextFrame = value
					E:Hide_SubZoneTextFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_PVPArenaTextString = {
				type = "toggle",
				name = L["Hide: PVPArenaTextString"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_PVPArenaTextString
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_PVPArenaTextString = value
					E:Hide_PVPArenaTextString()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_ZoneTextString = {
				type = "toggle",
				name = L["Hide: ZoneTextString"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_ZoneTextString
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_ZoneTextString = value
					E:Hide_ZoneTextString()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_SubZoneTextString = {
				type = "toggle",
				name = L["Hide: SubZoneTextString"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_SubZoneTextString
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_SubZoneTextString = value
					E:Hide_SubZoneTextString()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_OrderHallCommandBar = {
				type = "toggle",
				name = L["Hide: OrderHallCommandBar"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_OrderHallCommandBar
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_OrderHallCommandBar = value
					E:Hide_OrderHallCommandBar()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_ErrorMessages = {
				type = "toggle",
				name = L["Hide: ErrorMessages"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_ErrorMessages
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_ErrorMessages = value
					E:Hide_ErrorMessages()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_TalkingHeadFrame = {
				type = "toggle",
				name = L["Hide: TalkingHeadFrame"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_TalkingHeadFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_TalkingHeadFrame = value
					E:Hide_TalkingHeadFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Hide_EventToastManagerFrame = {
				type = "toggle",
				name = L["Hide: EventToastManagerFrame"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Hide_EventToastManagerFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Hide_EventToastManagerFrame = value
					E:Hide_EventToastManagerFrame()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			----------------------------------------------------------------
			----------------------------------------------------------------
			----------------------------------------------------------------
		},
	}
	return HideFrames
end











-- local GlobalAddonName, E = ...
-- local L = LibStub("AceLocale-3.0"):GetLocale("Octo")

-- function E.HideFrames()
-- 	local index = 0
-- 	local function GetOrder()
-- 		index = index + 1
-- 		return index
-- 	end

-- 	local function CreateToggleOption(name, dbKey, funcName)
-- 		return {
-- 			type = "toggle",
-- 			name = name:find("^Hide: ") and L[name] or name,
-- 			desc = "",
-- 			get = function() return Octo_ToDo_DB_Vars[dbKey] end,
-- 			set = function(_, value)
-- 				Octo_ToDo_DB_Vars[dbKey] = value
-- 				E[funcName]()
-- 			end,
-- 			width = E.FULL_WIDTH/2,
-- 			order = GetOrder(),
-- 		}
-- 	end

-- 	local toggleOptions = {
-- 		{name = "Hide: CheckListText", dbKey = "Hide_CheckListText", funcName = "Hide_CheckListText"},
-- 		{name = "Hide: SubscriptionInterstitialFrame", dbKey = "Hide_SubscriptionInterstitialFrame", funcName = "Hide_SubscriptionInterstitialFrame"},
-- 		{name = "Hide: ActionStatusText", dbKey = "Hide_ActionStatusText", funcName = "Hide_ActionStatusText"},
-- 		{name = "Hide: SecondaryStatusTrackingBarContainer", dbKey = "Hide_SecondaryStatusTrackingBarContainer", funcName = "Hide_SecondaryStatusTrackingBarContainer"},
-- 		{name = "Hide: MainStatusTrackingBarContainer", dbKey = "Hide_MainStatusTrackingBarContainer", funcName = "Hide_MainStatusTrackingBarContainer"},
-- 		{name = "Hide: WeeklyRewardExpirationWarningDialog", dbKey = "Hide_WeeklyRewardExpirationWarningDialog", funcName = "Hide_WeeklyRewardExpirationWarningDialog"},
-- 		{name = "Hide: MajorFactionsRenownToast", dbKey = "Hide_MajorFactionsRenownToast", funcName = "Hide_MajorFactionsRenownToast"},
-- 		{name = "Hide: UIWidgetTopCenterContainerFrame", dbKey = "Hide_UIWidgetTopCenterContainerFrame", funcName = "Hide_UIWidgetTopCenterContainerFrame"},
-- 		{name = "Hide: BossBanner", dbKey = "Hide_BossBanner", funcName = "Hide_BossBanner"},
-- 		{name = "Hide: RaidWarningFrame", dbKey = "Hide_RaidWarningFrame", funcName = "Hide_RaidWarningFrame"},
-- 		{name = "Hide: RaidBossEmoteFrame", dbKey = "Hide_RaidBossEmoteFrame", funcName = "Hide_RaidBossEmoteFrame"},
-- 		{name = "Hide: PrivateRaidBossEmoteFrameAnchor", dbKey = "Hide_PrivateRaidBossEmoteFrameAnchor", funcName = "Hide_PrivateRaidBossEmoteFrameAnchor"},
-- 		{name = "Hide: SplashFrame", dbKey = "Hide_SplashFrame", funcName = "Hide_SplashFrame"},
-- 		{name = "Hide: PTRReporter", dbKey = "Hide_PTRReporter", funcName = "Hide_PTRReporter"},
-- 		{name = "Hide: PTRIssueReporter", dbKey = "Hide_PTRIssueReporter", funcName = "Hide_PTRIssueReporter"},
-- 		{name = "Hide: PTRIssueReporterAlertFrame", dbKey = "Hide_PTRIssueReporterAlertFrame", funcName = "Hide_PTRIssueReporterAlertFrame"},
-- 		{name = "Hide: Bug", dbKey = "Hide_Bug", funcName = "Hide_Bug"},
-- 		{name = "Hide: CovenantRenownToast", dbKey = "Hide_CovenantRenownToast", funcName = "Hide_CovenantRenownToast"},
-- 		{name = "Hide: CovenantChoiceToast", dbKey = "Hide_CovenantChoiceToast", funcName = "Hide_CovenantChoiceToast"},
-- 		{name = "Hide: ZoneTextFrame", dbKey = "Hide_ZoneTextFrame", funcName = "Hide_ZoneTextFrame"},
-- 		{name = "Hide: SubZoneTextFrame", dbKey = "Hide_SubZoneTextFrame", funcName = "Hide_SubZoneTextFrame"},
-- 		{name = "Hide: PVPArenaTextString", dbKey = "Hide_PVPArenaTextString", funcName = "Hide_PVPArenaTextString"},
-- 		{name = "Hide: ZoneTextString", dbKey = "Hide_ZoneTextString", funcName = "Hide_ZoneTextString"},
-- 		{name = "Hide: SubZoneTextString", dbKey = "Hide_SubZoneTextString", funcName = "Hide_SubZoneTextString"},
-- 		{name = "Hide: OrderHallCommandBar", dbKey = "Hide_OrderHallCommandBar", funcName = "Hide_OrderHallCommandBar"},
-- 		{name = "Hide: ErrorMessages", dbKey = "Hide_ErrorMessages", funcName = "Hide_ErrorMessages"},
-- 		{name = "Hide: TalkingHeadFrame", dbKey = "Hide_TalkingHeadFrame", funcName = "Hide_TalkingHeadFrame"},
-- 		{name = "Hide: EventToastManagerFrame", dbKey = "Hide_EventToastManagerFrame", funcName = "Hide_EventToastManagerFrame"},
-- 	}

-- 	local args = {
-- 		Header1 = {
-- 			type = "header",
-- 			name = "",
-- 			order = GetOrder(),
-- 		},
-- 	}

-- 	for _, option in ipairs(toggleOptions) do
-- 		args[option.dbKey] = CreateToggleOption(option.name, option.dbKey, option.funcName)
-- 	end

-- 	local HideFrames = {
-- 		type = "group",
-- 		childGroups = "tree",
-- 		name = "HideFrames",
-- 		args = args,
-- 	}

-- 	return HideFrames
-- end