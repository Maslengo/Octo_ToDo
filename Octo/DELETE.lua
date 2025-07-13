if Octo_ToDo_DB_Vars.Hide_ActionStatusText then self:Hide_ActionStatusText() end
if Octo_ToDo_DB_Vars.Hide_BossBanner then self:Hide_BossBanner() end
if Octo_ToDo_DB_Vars.Hide_CheckListText then self:Hide_CheckListText() end
if Octo_ToDo_DB_Vars.Hide_Covenant then self:Hide_Covenant() end
if Octo_ToDo_DB_Vars.Hide_ErrorMessages then self:Hide_ErrorMessages() end
if Octo_ToDo_DB_Vars.Hide_EventToastManagerFrame then self:Hide_EventToastManagerFrame() end
if Octo_ToDo_DB_Vars.Hide_MainStatusTrackingBarContainer then self:Hide_MainStatusTrackingBarContainer() end
if Octo_ToDo_DB_Vars.Hide_MajorFactionsRenownToast then self:Hide_MajorFactionsRenownToast() end
if Octo_ToDo_DB_Vars.Hide_OrderHallCommandBar then self:Hide_OrderHallCommandBar() end
if Octo_ToDo_DB_Vars.Hide_PTRIssueReporterAlertFrame then self:Hide_PTRIssueReporterAlertFrame() end
if Octo_ToDo_DB_Vars.Hide_RaidWarningFrame then self:Hide_RaidWarningFrame() end
if Octo_ToDo_DB_Vars.Hide_SecondaryStatusTrackingBarContainer then self:Hide_SecondaryStatusTrackingBarContainer() end
if Octo_ToDo_DB_Vars.Hide_SplashFrame then self:Hide_SplashFrame() end
if Octo_ToDo_DB_Vars.Hide_SubscriptionInterstitialFrame then self:Hide_SubscriptionInterstitialFrame() end
if Octo_ToDo_DB_Vars.Hide_TalkingHeadFrame then self:Hide_TalkingHeadFrame() end
if Octo_ToDo_DB_Vars.Hide_UIWidgetTopCenterContainerFrame then self:Hide_UIWidgetTopCenterContainerFrame() end
if Octo_ToDo_DB_Vars.Hide_WeeklyRewardExpirationWarningDialog then self:Hide_WeeklyRewardExpirationWarningDialog() end
if Octo_ToDo_DB_Vars.Hide_ZoneTextFrame then self:Hide_ZoneTextFrame() end

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

CheckListText "Octo_EventFrame_HideFrames:Hide_CheckListText()"
SubscriptionInterstitialFrame "Octo_EventFrame_HideFrames:Hide_SubscriptionInterstitialFrame()"  -- НАДО ПОФИКСИТЬ(в другом файле работает)
ActionStatus.Text "Octo_EventFrame_HideFrames:Hide_ActionStatusText()"
SecondaryStatusTrackingBarContainer "Octo_EventFrame_HideFrames:Hide_SecondaryStatusTrackingBarContainer()" -- РЕПА??????
MainStatusTrackingBarContainer "Octo_EventFrame_HideFrames:Hide_MainStatusTrackingBarContainer()"
WeeklyRewardExpirationWarningDialog "Octo_EventFrame_HideFrames:Hide_WeeklyRewardExpirationWarningDialog()"
MajorFactionsRenownToast "Octo_EventFrame_HideFrames:Hide_MajorFactionsRenownToast()"
UIWidgetTopCenterContainerFrame "Octo_EventFrame_HideFrames:Hide_UIWidgetTopCenterContainerFrame()"
OrderHallCommandBar "Octo_EventFrame_HideFrames:Hide_OrderHallCommandBar()"
ErrorMassage "Octo_EventFrame_HideFrames:Hide_ErrorMessages()"
BossBanner "Octo_EventFrame_HideFrames:Hide_BossBanner()"
RaidWarningFrame, RaidBossEmoteFrame, PrivateRaidBossEmoteFrameAnchor "Octo_EventFrame_HideFrames:Hide_RaidWarningFrame()"
SplashFrame "Octo_EventFrame_HideFrames:Hide_SplashFrame()" -- при логине новый контент
PTR_Reporter, PTR_IssueReporter, PTRIssueReporterAlertFrame "Octo_EventFrame_HideFrames:Hide_PTRIssueReporterAlertFrame()"
TalkingHeadFrame "Octo_EventFrame_HideFrames:Hide_TalkingHeadFrame()"
EventToastManagerFrame "Octo_EventFrame_HideFrames:Hide_EventToastManagerFrame()"
CovenantChoiceToast, CovenantRenownToast "Octo_EventFrame_HideFrames:Hide_Covenant()"
ZoneTextFrame, SubZoneTextFrame, PVPArenaTextString, ZoneTextString, SubZoneTextString "Octo_EventFrame_HideFrames:Hide_ZoneTextFrame()"