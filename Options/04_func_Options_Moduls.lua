local GlobalAddonName, E = ...
local L = E.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
-------------------------------------------------------------------------
function E.func_Options_Moduls(name, savedVars)
	local Options = {
		type = "group",
		childGroups = "tab",
		name = name,
		args = {
			-------------------------------------------------
			-- Вкладка: Основные модули
			-------------------------------------------------
			mainModulesTab = {
				type = "group",
				name = "Основные",
				order = E.func_GetOrder(),
				args = {
					["Header1"] = {
						type = "header",
						name = "",
						order = E.func_GetOrder(),
					},
					SpeedFrameShown = {
						type = "toggle",
						name = "SpeedFrame.Shown",
						get = function()
							return Octo_Moduls_DB.SpeedFrame.Shown
						end,
						set = function(_, value)
							Octo_Moduls_DB.SpeedFrame.Shown = value
							if Octo_MainFrame_SpeedFrame then
								Octo_MainFrame_SpeedFrame:SetShown(value)
							end
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					PosFrameShown = {
						type = "toggle",
						name = "PosFrame.Shown",
						get = function()
							return Octo_Moduls_DB.PosFrame.Shown
						end,
						set = function(_, value)
							Octo_Moduls_DB.PosFrame.Shown = value
							if Octo_MainFrame_PosFrame then
								Octo_MainFrame_PosFrame:SetShown(value)
							end
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					SellFrame = {
						type = "toggle",
						name = "SellFrame",
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
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					["Header2"] = {
						type = "header",
						name = "",
						order = E.func_GetOrder(),
					},
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
									AceConfigRegistry:NotifyChange(E.func_AddonNameForOptionsInit(GlobalAddonName))
							end)
							if C_Container and C_Container.SetSortBagsRightToLeft then
								C_Container.SetSortBagsRightToLeft(value)
							elseif SetSortBagsRightToLeft then
								SetSortBagsRightToLeft(value)
							end
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
				}
			},
			-------------------------------------------------
			-- Вкладка: Автоматизация
			-------------------------------------------------
			autoTab = {
				type = "group",
				name = "Автоматизация",
				order = E.func_GetOrder(),
				args = {
					Config_Auto_SellGrey = {
						type = "toggle",
						name = L["Auto Sell Grey"],
						get = function()
							return savedVars.Config_Auto_SellGrey
						end,
						set = function(_, value)
							savedVars.Config_Auto_SellGrey = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Auto_Repair = {
						type = "toggle",
						name = L["Auto Repair"],
						get = function()
							return savedVars.Config_Auto_Repair
						end,
						set = function(_, value)
							savedVars.Config_Auto_Repair = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Auto_InputDelete = {
						type = "toggle",
						name = L["Auto Input Delete"],
						get = function()
							return savedVars.Config_Auto_InputDelete
						end,
						set = function(_, value)
							savedVars.Config_Auto_InputDelete = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Auto_OpenItems = {
						type = "toggle",
						name = L["Auto Open Items"],
						get = function()
							return savedVars.Config_Auto_OpenItems
						end,
						set = function(_, value)
							savedVars.Config_Auto_OpenItems = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Auto_Gossip = {
						type = "toggle",
						name = L["Auto Gossip"],
						get = function()
							return savedVars.Config_Auto_Gossip
						end,
						set = function(_, value)
							savedVars.Config_Auto_Gossip = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Auto_TurnQuests = {
						type = "toggle",
						name = L["Auto Turn Quests"],
						get = function()
							return savedVars.Config_Auto_TurnQuests
						end,
						set = function(_, value)
							savedVars.Config_Auto_TurnQuests = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Auto_ChatClearing = {
						type = "toggle",
						name = L["Auto Clear Chat"],
						get = function()
							return savedVars.Config_Auto_ChatClearing
						end,
						set = function(_, value)
							savedVars.Config_Auto_ChatClearing = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Auto_Screenshot = {
						type = "toggle",
						name = L["Auto Screenshot"],
						get = function()
							return savedVars.Config_Auto_Screenshot
						end,
						set = function(_, value)
							savedVars.Config_Auto_Screenshot = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Auto_CinematicCanceler = {
						type = "toggle",
						name = L["Auto Cinematic Canceler"],
						get = function()
							return savedVars.Config_Auto_CinematicCanceler
						end,
						set = function(_, value)
							savedVars.Config_Auto_CinematicCanceler = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Auto_CinematicFastSkip = {
						type = "toggle",
						name = "Cinematic Fast Skip (ESC/Space/Enter)",
						get = function()
							return savedVars.Config_Auto_CinematicFastSkip
						end,
						set = function(_, value)
							savedVars.Config_Auto_CinematicFastSkip = value
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
				}
			},
			-------------------------------------------------
			-- Вкладка: Скрытие интерфейса
			-------------------------------------------------
			hideTab = {
				type = "group",
				name = "Скрытие",
				order = E.func_GetOrder(),
				args = {
					Config_Hide_CheckListText = {
						type = "toggle",
						name = HIDE..": CheckListText",
						get = function()
							return savedVars.Config_Hide_CheckListText
						end,
						set = function(_, value)
							savedVars.Config_Hide_CheckListText = value
							E.func_Config_Hide_CheckListText()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_SubscriptionInterstitialFrame = {
						type = "toggle",
						name = HIDE..": SubscriptionInterstitialFrame",
						get = function()
							return savedVars.Config_Hide_SubscriptionInterstitialFrame
						end,
						set = function(_, value)
							savedVars.Config_Hide_SubscriptionInterstitialFrame = value
							E.func_Config_Hide_SubscriptionInterstitialFrame()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_ActionStatusText = {
						type = "toggle",
						name = HIDE..": ActionStatusText",
						get = function()
							return savedVars.Config_Hide_ActionStatusText
						end,
						set = function(_, value)
							savedVars.Config_Hide_ActionStatusText = value
							E.func_Config_Hide_ActionStatusText()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_SecondaryStatusTrackingBarContainer = {
						type = "toggle",
						name = HIDE..": SecondaryStatusTrackingBarContainer",
						get = function()
							return savedVars.Config_Hide_SecondaryStatusTrackingBarContainer
						end,
						set = function(_, value)
							savedVars.Config_Hide_SecondaryStatusTrackingBarContainer = value
							E.func_Config_Hide_SecondaryStatusTrackingBarContainer()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_MainStatusTrackingBarContainer = {
						type = "toggle",
						name = "Полоска опыта",
						get = function()
							return savedVars.Config_Hide_MainStatusTrackingBarContainer
						end,
						set = function(_, value)
							savedVars.Config_Hide_MainStatusTrackingBarContainer = value
							E.func_Config_Hide_MainStatusTrackingBarContainer()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_WeeklyRewardExpirationWarningDialog = {
						type = "toggle",
						name = HIDE..": WeeklyRewardExpirationWarningDialog",
						get = function()
							return savedVars.Config_Hide_WeeklyRewardExpirationWarningDialog
						end,
						set = function(_, value)
							savedVars.Config_Hide_WeeklyRewardExpirationWarningDialog = value
							E.func_Config_Hide_WeeklyRewardExpirationWarningDialog()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_MajorFactionsRenownToast = {
						type = "toggle",
						name = HIDE..": MajorFactionsRenownToast",
						get = function()
							return savedVars.Config_Hide_MajorFactionsRenownToast
						end,
						set = function(_, value)
							savedVars.Config_Hide_MajorFactionsRenownToast = value
							E.func_Config_Hide_MajorFactionsRenownToast()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_UIWidgetTopCenterContainerFrame = {
						type = "toggle",
						name = HIDE..": UIWidgetTopCenterContainerFrame",
						get = function()
							return savedVars.Config_Hide_UIWidgetTopCenterContainerFrame
						end,
						set = function(_, value)
							savedVars.Config_Hide_UIWidgetTopCenterContainerFrame = value
							E.func_Config_Hide_UIWidgetTopCenterContainerFrame()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_BossBanner = {
						type = "toggle",
						name = HIDE..": BossBanner",
						get = function()
							return savedVars.Config_Hide_BossBanner
						end,
						set = function(_, value)
							savedVars.Config_Hide_BossBanner = value
							E.func_Config_Hide_BossBanner()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_RaidWarningFrame = {
						type = "toggle",
						name = HIDE..": RaidWarningFrame",
						get = function()
							return savedVars.Config_Hide_RaidWarningFrame
						end,
						set = function(_, value)
							savedVars.Config_Hide_RaidWarningFrame = value
							E.func_Config_Hide_RaidWarningFrame()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_RaidBossEmoteFrame = {
						type = "toggle",
						name = HIDE..": RaidBossEmoteFrame",
						get = function()
							return savedVars.Config_Hide_RaidBossEmoteFrame
						end,
						set = function(_, value)
							savedVars.Config_Hide_RaidBossEmoteFrame = value
							E.func_Config_Hide_RaidBossEmoteFrame()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_PrivateRaidBossEmoteFrameAnchor = {
						type = "toggle",
						name = HIDE..": PrivateRaidBossEmoteFrameAnchor",
						get = function()
							return savedVars.Config_Hide_PrivateRaidBossEmoteFrameAnchor
						end,
						set = function(_, value)
							savedVars.Config_Hide_PrivateRaidBossEmoteFrameAnchor = value
							E.func_Config_Hide_PrivateRaidBossEmoteFrameAnchor()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_SplashFrame = {
						type = "toggle",
						name = HIDE..": SplashFrame",
						get = function()
							return savedVars.Config_Hide_SplashFrame
						end,
						set = function(_, value)
							savedVars.Config_Hide_SplashFrame = value
							E.func_Config_Hide_SplashFrame()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_PTRReporter = {
						type = "toggle",
						name = HIDE..": PTRReporter",
						get = function()
							return savedVars.Config_Hide_PTRReporter
						end,
						set = function(_, value)
							savedVars.Config_Hide_PTRReporter = value
							E.func_Config_Hide_PTRReporter()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_PTRIssueReporter = {
						type = "toggle",
						name = HIDE..": PTRIssueReporter",
						get = function()
							return savedVars.Config_Hide_PTRIssueReporter
						end,
						set = function(_, value)
							savedVars.Config_Hide_PTRIssueReporter = value
							E.func_Config_Hide_PTRIssueReporter()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_PTRIssueReporterAlertFrame = {
						type = "toggle",
						name = HIDE..": PTRIssueReporterAlertFrame",
						get = function()
							return savedVars.Config_Hide_PTRIssueReporterAlertFrame
						end,
						set = function(_, value)
							savedVars.Config_Hide_PTRIssueReporterAlertFrame = value
							E.func_Config_Hide_PTRIssueReporterAlertFrame()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_Bug = {
						type = "toggle",
						name = HIDE..": Bug",
						get = function()
							return savedVars.Config_Hide_Bug
						end,
						set = function(_, value)
							savedVars.Config_Hide_Bug = value
							E.func_Config_Hide_Bug()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_CovenantRenownToast = {
						type = "toggle",
						name = HIDE..": CovenantRenownToast",
						get = function()
							return savedVars.Config_Hide_CovenantRenownToast
						end,
						set = function(_, value)
							savedVars.Config_Hide_CovenantRenownToast = value
							E.func_Config_Hide_CovenantRenownToast()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_CovenantChoiceToast = {
						type = "toggle",
						name = HIDE..": CovenantChoiceToast",
						get = function()
							return savedVars.Config_Hide_CovenantChoiceToast
						end,
						set = function(_, value)
							savedVars.Config_Hide_CovenantChoiceToast = value
							E.func_Config_Hide_CovenantChoiceToast()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_ZoneTextFrame = {
						type = "toggle",
						name = HIDE..": ZoneTextFrame",
						get = function()
							return savedVars.Config_Hide_ZoneTextFrame
						end,
						set = function(_, value)
							savedVars.Config_Hide_ZoneTextFrame = value
							E.func_Config_Hide_ZoneTextFrame()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_SubZoneTextFrame = {
						type = "toggle",
						name = HIDE..": SubZoneTextFrame",
						get = function()
							return savedVars.Config_Hide_SubZoneTextFrame
						end,
						set = function(_, value)
							savedVars.Config_Hide_SubZoneTextFrame = value
							E.func_Config_Hide_SubZoneTextFrame()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_PVPArenaTextString = {
						type = "toggle",
						name = HIDE..": PVPArenaTextString",
						get = function()
							return savedVars.Config_Hide_PVPArenaTextString
						end,
						set = function(_, value)
							savedVars.Config_Hide_PVPArenaTextString = value
							E.func_Config_Hide_PVPArenaTextString()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_ZoneTextString = {
						type = "toggle",
						name = HIDE..": ZoneTextString",
						get = function()
							return savedVars.Config_Hide_ZoneTextString
						end,
						set = function(_, value)
							savedVars.Config_Hide_ZoneTextString = value
							E.func_Config_Hide_ZoneTextString()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_SubZoneTextString = {
						type = "toggle",
						name = HIDE..": SubZoneTextString",
						get = function()
							return savedVars.Config_Hide_SubZoneTextString
						end,
						set = function(_, value)
							savedVars.Config_Hide_SubZoneTextString = value
							E.func_Config_Hide_SubZoneTextString()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_ErrorMessages = {
						type = "toggle",
						name = HIDE..": ErrorMessages",
						get = function()
							return savedVars.Config_Hide_ErrorMessages
						end,
						set = function(_, value)
							savedVars.Config_Hide_ErrorMessages = value
							E.func_Config_Hide_ErrorMessages()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_TalkingHeadFrame = {
						type = "toggle",
						name = HIDE..": TalkingHeadFrame",
						get = function()
							return savedVars.Config_Hide_TalkingHeadFrame
						end,
						set = function(_, value)
							savedVars.Config_Hide_TalkingHeadFrame = value
							E.func_Config_Hide_TalkingHeadFrame()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
					Config_Hide_EventToastManagerFrame = {
						type = "toggle",
						name = HIDE..": EventToastManagerFrame",
						get = function()
							return savedVars.Config_Hide_EventToastManagerFrame
						end,
						set = function(_, value)
							savedVars.Config_Hide_EventToastManagerFrame = value
							E.func_Config_Hide_EventToastManagerFrame()
						end,
						width = E.HALF_WIDTH,
						order = E.func_GetOrder(),
					},
				}
			},
		},
	}
	return Options
end