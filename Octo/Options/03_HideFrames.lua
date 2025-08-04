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
			Config_Hide_CheckListText = {
				type = "toggle",
				name = L["Hide: CheckListText"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Config_Hide_CheckListText
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_CheckListText = value
					E:Config_Hide_CheckListText()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_SubscriptionInterstitialFrame = {
				type = "toggle",
				-- name = Octo_ToDo_DB_Vars.Config_Hide_SubscriptionInterstitialFrame and E.Green_Color..L["Hide: SubscriptionInterstitialFrame"].."|r" or E.Red_Color..L["Hide: SubscriptionInterstitialFrame"].."|r",
				name = E.Green_Color..L["Hide: SubscriptionInterstitialFrame"].."|r",
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Config_Hide_SubscriptionInterstitialFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_SubscriptionInterstitialFrame = value
					E:Config_Hide_SubscriptionInterstitialFrame()
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
					return Octo_ToDo_DB_Vars.Config_Hide_ActionStatusText
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_ActionStatusText = value
					E:Config_Hide_ActionStatusText()
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
					return Octo_ToDo_DB_Vars.Config_Hide_SecondaryStatusTrackingBarContainer
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_SecondaryStatusTrackingBarContainer = value
					E:Config_Hide_SecondaryStatusTrackingBarContainer()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_MainStatusTrackingBarContainer = {
				type = "toggle",
				name = L["Hide: MainStatusTrackingBarContainer"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Config_Hide_MainStatusTrackingBarContainer
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_MainStatusTrackingBarContainer = value
					E:Config_Hide_MainStatusTrackingBarContainer()
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
					return Octo_ToDo_DB_Vars.Config_Hide_WeeklyRewardExpirationWarningDialog
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_WeeklyRewardExpirationWarningDialog = value
					E:Config_Hide_WeeklyRewardExpirationWarningDialog()
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
					return Octo_ToDo_DB_Vars.Config_Hide_MajorFactionsRenownToast
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_MajorFactionsRenownToast = value
					E:Config_Hide_MajorFactionsRenownToast()
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
					return Octo_ToDo_DB_Vars.Config_Hide_UIWidgetTopCenterContainerFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_UIWidgetTopCenterContainerFrame = value
					E:Config_Hide_UIWidgetTopCenterContainerFrame()
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
					return Octo_ToDo_DB_Vars.Config_Hide_BossBanner
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_BossBanner = value
					E:Config_Hide_BossBanner()
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
					return Octo_ToDo_DB_Vars.Config_Hide_RaidWarningFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_RaidWarningFrame = value
					E:Config_Hide_RaidWarningFrame()
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
					return Octo_ToDo_DB_Vars.Config_Hide_RaidBossEmoteFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_RaidBossEmoteFrame = value
					E:Config_Hide_RaidBossEmoteFrame()
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
					return Octo_ToDo_DB_Vars.Config_Hide_PrivateRaidBossEmoteFrameAnchor
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_PrivateRaidBossEmoteFrameAnchor = value
					E:Config_Hide_PrivateRaidBossEmoteFrameAnchor()
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
					return Octo_ToDo_DB_Vars.Config_Hide_SplashFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_SplashFrame = value
					E:Config_Hide_SplashFrame()
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
					return Octo_ToDo_DB_Vars.Config_Hide_PTRReporter
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_PTRReporter = value
					E:Config_Hide_PTRReporter()
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
					return Octo_ToDo_DB_Vars.Config_Hide_PTRIssueReporter
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_PTRIssueReporter = value
					E:Config_Hide_PTRIssueReporter()
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
					return Octo_ToDo_DB_Vars.Config_Hide_PTRIssueReporterAlertFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_PTRIssueReporterAlertFrame = value
					E:Config_Hide_PTRIssueReporterAlertFrame()
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
					return Octo_ToDo_DB_Vars.Config_Hide_Bug
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_Bug = value
					E:Config_Hide_Bug()
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
					return Octo_ToDo_DB_Vars.Config_Hide_CovenantRenownToast
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_CovenantRenownToast = value
					E:Config_Hide_CovenantRenownToast()
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
					return Octo_ToDo_DB_Vars.Config_Hide_CovenantChoiceToast
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_CovenantChoiceToast = value
					E:Config_Hide_CovenantChoiceToast()
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
					return Octo_ToDo_DB_Vars.Config_Hide_ZoneTextFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_ZoneTextFrame = value
					E:Config_Hide_ZoneTextFrame()
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
					return Octo_ToDo_DB_Vars.Config_Hide_SubZoneTextFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_SubZoneTextFrame = value
					E:Config_Hide_SubZoneTextFrame()
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
					return Octo_ToDo_DB_Vars.Config_Hide_PVPArenaTextString
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_PVPArenaTextString = value
					E:Config_Hide_PVPArenaTextString()
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
					return Octo_ToDo_DB_Vars.Config_Hide_ZoneTextString
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_ZoneTextString = value
					E:Config_Hide_ZoneTextString()
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
					return Octo_ToDo_DB_Vars.Config_Hide_SubZoneTextString
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_SubZoneTextString = value
					E:Config_Hide_SubZoneTextString()
				end,
				width = E.FULL_WIDTH/2,
				order = GetOrder(),
			},
			-------------------------------------------------
			Config_Hide_OrderHallCommandBar = {
				type = "toggle",
				name = L["Hide: OrderHallCommandBar"],
				desc = "",
				get = function()
					return Octo_ToDo_DB_Vars.Config_Hide_OrderHallCommandBar
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_OrderHallCommandBar = value
					E:Config_Hide_OrderHallCommandBar()
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
					return Octo_ToDo_DB_Vars.Config_Hide_ErrorMessages
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_ErrorMessages = value
					E:Config_Hide_ErrorMessages()
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
					return Octo_ToDo_DB_Vars.Config_Hide_TalkingHeadFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_TalkingHeadFrame = value
					E:Config_Hide_TalkingHeadFrame()
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
					return Octo_ToDo_DB_Vars.Config_Hide_EventToastManagerFrame
				end,
				set = function(_, value)
					Octo_ToDo_DB_Vars.Config_Hide_EventToastManagerFrame = value
					E:Config_Hide_EventToastManagerFrame()
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
-- 		{name = "Hide: CheckListText", dbKey = "Config_Hide_CheckListText", funcName = "Config_Hide_CheckListText"},
-- 		{name = "Hide: SubscriptionInterstitialFrame", dbKey = "Config_Hide_SubscriptionInterstitialFrame", funcName = "Config_Hide_SubscriptionInterstitialFrame"},
-- 		{name = "Hide: ActionStatusText", dbKey = "Config_Hide_ActionStatusText", funcName = "Config_Hide_ActionStatusText"},
-- 		{name = "Hide: SecondaryStatusTrackingBarContainer", dbKey = "Config_Hide_SecondaryStatusTrackingBarContainer", funcName = "Config_Hide_SecondaryStatusTrackingBarContainer"},
-- 		{name = "Hide: MainStatusTrackingBarContainer", dbKey = "Config_Hide_MainStatusTrackingBarContainer", funcName = "Config_Hide_MainStatusTrackingBarContainer"},
-- 		{name = "Hide: WeeklyRewardExpirationWarningDialog", dbKey = "Config_Hide_WeeklyRewardExpirationWarningDialog", funcName = "Config_Hide_WeeklyRewardExpirationWarningDialog"},
-- 		{name = "Hide: MajorFactionsRenownToast", dbKey = "Config_Hide_MajorFactionsRenownToast", funcName = "Config_Hide_MajorFactionsRenownToast"},
-- 		{name = "Hide: UIWidgetTopCenterContainerFrame", dbKey = "Config_Hide_UIWidgetTopCenterContainerFrame", funcName = "Config_Hide_UIWidgetTopCenterContainerFrame"},
-- 		{name = "Hide: BossBanner", dbKey = "Config_Hide_BossBanner", funcName = "Config_Hide_BossBanner"},
-- 		{name = "Hide: RaidWarningFrame", dbKey = "Config_Hide_RaidWarningFrame", funcName = "Config_Hide_RaidWarningFrame"},
-- 		{name = "Hide: RaidBossEmoteFrame", dbKey = "Config_Hide_RaidBossEmoteFrame", funcName = "Config_Hide_RaidBossEmoteFrame"},
-- 		{name = "Hide: PrivateRaidBossEmoteFrameAnchor", dbKey = "Config_Hide_PrivateRaidBossEmoteFrameAnchor", funcName = "Config_Hide_PrivateRaidBossEmoteFrameAnchor"},
-- 		{name = "Hide: SplashFrame", dbKey = "Config_Hide_SplashFrame", funcName = "Config_Hide_SplashFrame"},
-- 		{name = "Hide: PTRReporter", dbKey = "Config_Hide_PTRReporter", funcName = "Config_Hide_PTRReporter"},
-- 		{name = "Hide: PTRIssueReporter", dbKey = "Config_Hide_PTRIssueReporter", funcName = "Config_Hide_PTRIssueReporter"},
-- 		{name = "Hide: PTRIssueReporterAlertFrame", dbKey = "Config_Hide_PTRIssueReporterAlertFrame", funcName = "Config_Hide_PTRIssueReporterAlertFrame"},
-- 		{name = "Hide: Bug", dbKey = "Config_Hide_Bug", funcName = "Config_Hide_Bug"},
-- 		{name = "Hide: CovenantRenownToast", dbKey = "Config_Hide_CovenantRenownToast", funcName = "Config_Hide_CovenantRenownToast"},
-- 		{name = "Hide: CovenantChoiceToast", dbKey = "Config_Hide_CovenantChoiceToast", funcName = "Config_Hide_CovenantChoiceToast"},
-- 		{name = "Hide: ZoneTextFrame", dbKey = "Config_Hide_ZoneTextFrame", funcName = "Config_Hide_ZoneTextFrame"},
-- 		{name = "Hide: SubZoneTextFrame", dbKey = "Config_Hide_SubZoneTextFrame", funcName = "Config_Hide_SubZoneTextFrame"},
-- 		{name = "Hide: PVPArenaTextString", dbKey = "Config_Hide_PVPArenaTextString", funcName = "Config_Hide_PVPArenaTextString"},
-- 		{name = "Hide: ZoneTextString", dbKey = "Config_Hide_ZoneTextString", funcName = "Config_Hide_ZoneTextString"},
-- 		{name = "Hide: SubZoneTextString", dbKey = "Config_Hide_SubZoneTextString", funcName = "Config_Hide_SubZoneTextString"},
-- 		{name = "Hide: OrderHallCommandBar", dbKey = "Config_Hide_OrderHallCommandBar", funcName = "Config_Hide_OrderHallCommandBar"},
-- 		{name = "Hide: ErrorMessages", dbKey = "Config_Hide_ErrorMessages", funcName = "Config_Hide_ErrorMessages"},
-- 		{name = "Hide: TalkingHeadFrame", dbKey = "Config_Hide_TalkingHeadFrame", funcName = "Config_Hide_TalkingHeadFrame"},
-- 		{name = "Hide: EventToastManagerFrame", dbKey = "Config_Hide_EventToastManagerFrame", funcName = "Config_Hide_EventToastManagerFrame"},
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