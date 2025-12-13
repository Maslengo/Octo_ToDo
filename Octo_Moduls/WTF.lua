local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
local funcName = GlobalAddonName.."WTF"
----------------------------------------------------------------
EventFrame[funcName] = function(self)
	----------------------------------------------------------------
	local defaultOptions = {
		Config_Auto_ChatClearing = false, -- Автоочистка чата

		Config_Auto_CinematicCanceler = false, -- Пропуск заставок
		Config_Auto_CinematicFastSkip = false, -- Быстрый пропуск заставок
		Config_Auto_Gossip = false, -- Автопропуск диалогов
		Config_Auto_InputDelete = false, -- Автоочистка ввода
		Config_Auto_OpenItems = false, -- Автооткрытие предметов
		Config_Auto_Repair = false, -- Авторемонт
		Config_Auto_Screenshot = false, -- Автоскриншоты
		Config_Auto_SellGrey = false, -- Автопродажа серых предметов
		Config_Auto_TurnQuests = false, -- Автосдача квестов
		Config_Hide_ActionStatusText = false, -- Скрыть текст статуса действий
		Config_Hide_BossBanner = false, -- Скрыть баннер босса
		Config_Hide_Bug = false, -- Скрыть баг-репортер
		Config_Hide_CheckListText = false, -- Скрыть текст чеклиста
		Config_Hide_CovenantChoiceToast = false, -- Скрыть тост выбора ковенанта
		Config_Hide_CovenantRenownToast = false, -- Скрыть тост ковенанта
		Config_Hide_ErrorMessages = false, -- Скрыть сообщения об ошибках
		Config_Hide_EventToastManagerFrame = false, -- Скрыть тосты событий
		Config_Hide_MainStatusTrackingBarContainer = false, -- Скрыть главную полосу отслеживания
		Config_Hide_MajorFactionsRenownToast = false, -- Скрыть тост репутации фракций
		Config_Hide_PrivateRaidBossEmoteFrameAnchor = false, -- Скрыть якорь эмоций
		Config_Hide_PTRReporter = false, -- Скрыть PTR репортер
		Config_Hide_PTRIssueReporter = false, -- Скрыть репортер проблем
		Config_Hide_PTRIssueReporterAlertFrame = false, -- Скрыть алерт репортера
		Config_Hide_PVPArenaTextString = false, -- Скрыть текст арены
		Config_Hide_RaidBossEmoteFrame = false, -- Скрыть эмоции боссов
		Config_Hide_RaidWarningFrame = false, -- Скрыть предупреждения рейда
		Config_Hide_SecondaryStatusTrackingBarContainer = false, -- Скрыть вторую полосу отслеживания
		Config_Hide_SplashFrame = false, -- Скрыть заставку
		Config_Hide_SubscriptionInterstitialFrame = false, -- Скрыть фрейм подписки
		Config_Hide_SubZoneTextFrame = false, -- Скрыть текст подзоны
		Config_Hide_SubZoneTextString = false, -- Скрыть строку подзоны
		Config_Hide_TalkingHeadFrame = false, -- Скрыть говорящую голову
		Config_Hide_UIWidgetTopCenterContainerFrame = false, -- Скрыть верхний центр виджетов
		Config_Hide_WeeklyRewardExpirationWarningDialog = false, -- Скрыть предупреждение о наградах
		Config_Hide_ZoneTextFrame = false, -- Скрыть текст зоны
		Config_Hide_ZoneTextString = false, -- Скрыть строку зоны
		SellFrame = false,
	}
	for k, v in next, (defaultOptions) do
		E.func_InitField(EventFrame.savedVars, k, v)
	end
	-- Настройки позиционного фрейма
	E.func_InitSubTable(EventFrame.savedVars, "PosFrame")
	local defaultOptions_posFrame = {
		Shown = false, -- Показывать фрейм
		point = "LEFT", -- Точка привязки
		relativePoint = "LEFT", -- Относительная точка
		xOfs = 208, -- Смещение по X
		yOfs = -149, -- Смещение по Y
	}
	for k, v in next, (defaultOptions_posFrame) do
		E.func_InitField(EventFrame.savedVars.PosFrame, k, v)
	end
	-- Настройки фрейма скорости
	E.func_InitSubTable(EventFrame.savedVars, "SpeedFrame")
	local defaultOptions_speedFrame = {
		Shown = false, -- Показывать фрейм
		point = "BOTTOM", -- Точка привязки
		relativePoint = "BOTTOM", -- Относительная точка
		xOfs = 129, -- Смещение по X
		yOfs = 67 -- Смещение по Y
	}
	for k, v in next, (defaultOptions_speedFrame) do
		E.func_InitField(EventFrame.savedVars.SpeedFrame, k, v)
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
}
----------------------------------------------------------------
E.func_RegisterEvents(EventFrame, MyEventsTable)
------------------------------------------------------------
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
	EventFrame[funcName](EventFrame)
end