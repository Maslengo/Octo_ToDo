if Octo_ToDo_DB_Vars.Config_Hide_ActionStatusText then self:Config_Hide_ActionStatusText() end
if Octo_ToDo_DB_Vars.Config_Hide_BossBanner then self:Config_Hide_BossBanner() end
if Octo_ToDo_DB_Vars.Config_Hide_CheckListText then self:Config_Hide_CheckListText() end
if Octo_ToDo_DB_Vars.Hide_Covenant then self:Hide_Covenant() end
if Octo_ToDo_DB_Vars.Config_Hide_ErrorMessages then self:Config_Hide_ErrorMessages() end
if Octo_ToDo_DB_Vars.Config_Hide_EventToastManagerFrame then self:Config_Hide_EventToastManagerFrame() end
if Octo_ToDo_DB_Vars.Config_Hide_MainStatusTrackingBarContainer then self:Config_Hide_MainStatusTrackingBarContainer() end
if Octo_ToDo_DB_Vars.Config_Hide_MajorFactionsRenownToast then self:Config_Hide_MajorFactionsRenownToast() end
if Octo_ToDo_DB_Vars.Config_Hide_OrderHallCommandBar then self:Config_Hide_OrderHallCommandBar() end
if Octo_ToDo_DB_Vars.Config_Hide_PTRIssueReporterAlertFrame then self:Config_Hide_PTRIssueReporterAlertFrame() end
if Octo_ToDo_DB_Vars.Config_Hide_RaidWarningFrame then self:Config_Hide_RaidWarningFrame() end
if Octo_ToDo_DB_Vars.Config_Hide_SecondaryStatusTrackingBarContainer then self:Config_Hide_SecondaryStatusTrackingBarContainer() end
if Octo_ToDo_DB_Vars.Config_Hide_SplashFrame then self:Config_Hide_SplashFrame() end
if Octo_ToDo_DB_Vars.Config_Hide_SubscriptionInterstitialFrame then self:Config_Hide_SubscriptionInterstitialFrame() end
if Octo_ToDo_DB_Vars.Config_Hide_TalkingHeadFrame then self:Config_Hide_TalkingHeadFrame() end
if Octo_ToDo_DB_Vars.Config_Hide_UIWidgetTopCenterContainerFrame then self:Config_Hide_UIWidgetTopCenterContainerFrame() end
if Octo_ToDo_DB_Vars.Config_Hide_WeeklyRewardExpirationWarningDialog then self:Config_Hide_WeeklyRewardExpirationWarningDialog() end
if Octo_ToDo_DB_Vars.Config_Hide_ZoneTextFrame then self:Config_Hide_ZoneTextFrame() end
L["Hide: ActionStatusText"] = true
L["Hide: BossBanner"] = true
L["Hide: CheckListText"] = true
L["Hide: Covenant"] = true
L["Hide: ErrorMessages"] = true
L["Hide: EventToastManagerFrame"] = true
L["Hide: MainStatusTrackingBarContainer"] = true
L["Hide: MajorFactionsRenownToast"] = true
L["Hide: OrderHallCommandBar"] = true
L["Hide: PTRIssueReporterAlertFrame"] = true
L["Hide: RaidWarningFrame"] = true
L["Hide: SecondaryStatusTrackingBarContainer"] = true
L["Hide: SplashFrame"] = true
L["Hide: SubscriptionInterstitialFrame"] = true
L["Hide: TalkingHeadFrame"] = true
L["Hide: UIWidgetTopCenterContainerFrame"] = true
L["Hide: WeeklyRewardExpirationWarningDialog"] = true
L["Hide: ZoneTextFrame"] = true
CheckListText "EventFrame:Config_Hide_CheckListText()"
SubscriptionInterstitialFrame "EventFrame:Config_Hide_SubscriptionInterstitialFrame()" -- НАДО ПОФИКСИТЬ(в другом файле работает)
ActionStatus.Text "EventFrame:Config_Hide_ActionStatusText()"
SecondaryStatusTrackingBarContainer "EventFrame:Config_Hide_SecondaryStatusTrackingBarContainer()" -- РЕПА??????
MainStatusTrackingBarContainer "EventFrame:Config_Hide_MainStatusTrackingBarContainer()"
WeeklyRewardExpirationWarningDialog "EventFrame:Config_Hide_WeeklyRewardExpirationWarningDialog()"
MajorFactionsRenownToast "EventFrame:Config_Hide_MajorFactionsRenownToast()"
UIWidgetTopCenterContainerFrame "EventFrame:Config_Hide_UIWidgetTopCenterContainerFrame()"
OrderHallCommandBar "EventFrame:Config_Hide_OrderHallCommandBar()"
ErrorMassage "EventFrame:Config_Hide_ErrorMessages()"
BossBanner "EventFrame:Config_Hide_BossBanner()"
RaidWarningFrame, RaidBossEmoteFrame, PrivateRaidBossEmoteFrameAnchor "EventFrame:Config_Hide_RaidWarningFrame()"
SplashFrame "EventFrame:Config_Hide_SplashFrame()" -- при логине новый контент
PTR_Reporter, PTR_IssueReporter, PTRIssueReporterAlertFrame "EventFrame:Config_Hide_PTRIssueReporterAlertFrame()"
TalkingHeadFrame "EventFrame:Config_Hide_TalkingHeadFrame()"
EventToastManagerFrame "EventFrame:Config_Hide_EventToastManagerFrame()"
CovenantChoiceToast, CovenantRenownToast "EventFrame:Hide_Covenant()"
ZoneTextFrame, SubZoneTextFrame, PVPArenaTextString, ZoneTextString, SubZoneTextString "EventFrame:Config_Hide_ZoneTextFrame()"