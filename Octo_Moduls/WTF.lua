local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
local funcName = GlobalAddonName.."WTF"
----------------------------------------------------------------
EventFrame[funcName] = function(self)
	----------------------------------------------------------------
	local defaultOptions = {
		Config_Auto_ChatClearing = false, -- Автоочистка чата
		Config_Auto_CinematicCanceler = true, -- Пропуск заставок
		Config_Auto_CinematicFastSkip = true, -- Быстрый пропуск заставок
		Config_Auto_Gossip = true, -- Автопропуск диалогов
		Config_Auto_InputDelete = true, -- Автоочистка ввода
		Config_Auto_OpenItems = true, -- Автооткрытие предметов
		Config_Auto_Repair = true, -- Авторемонт
		Config_Auto_Screenshot = true, -- Автоскриншоты
		Config_Auto_SellGrey = true, -- Автопродажа серых предметов
		Config_Auto_TurnQuests = true, -- Автосдача квестов
		Config_Hide_ActionStatusText = true, -- Скрыть текст статуса действий
		Config_Hide_BossBanner = true, -- Скрыть баннер босса
		Config_Hide_Bug = true, -- Скрыть баг-репортер
		Config_Hide_CheckListText = true, -- Скрыть текст чеклиста
		Config_Hide_CovenantChoiceToast = true, -- Скрыть тост выбора ковенанта
		Config_Hide_CovenantRenownToast = true, -- Скрыть тост ковенанта
		Config_Hide_ErrorMessages = true, -- Скрыть сообщения об ошибках
		Config_Hide_EventToastManagerFrame = true, -- Скрыть тосты событий
		Config_Hide_MainStatusTrackingBarContainer = true, -- Скрыть главную полосу отслеживания
		Config_Hide_MajorFactionsRenownToast = true, -- Скрыть тост репутации фракций
		Config_Hide_OrderHallCommandBar = true, -- Скрыть панель команд
		Config_Hide_PrivateRaidBossEmoteFrameAnchor = true, -- Скрыть якорь эмоций
		Config_Hide_PTRReporter = true, -- Скрыть PTR репортер
		Config_Hide_PTRIssueReporter = true, -- Скрыть репортер проблем
		Config_Hide_PTRIssueReporterAlertFrame = true, -- Скрыть алерт репортера
		Config_Hide_PVPArenaTextString = true, -- Скрыть текст арены
		Config_Hide_RaidBossEmoteFrame = true, -- Скрыть эмоции боссов
		Config_Hide_RaidWarningFrame = true, -- Скрыть предупреждения рейда
		Config_Hide_SecondaryStatusTrackingBarContainer = true, -- Скрыть вторую полосу отслеживания
		Config_Hide_SplashFrame = true, -- Скрыть заставку
		Config_Hide_SubscriptionInterstitialFrame = true, -- Скрыть фрейм подписки
		Config_Hide_SubZoneTextFrame = true, -- Скрыть текст подзоны
		Config_Hide_SubZoneTextString = true, -- Скрыть строку подзоны
		Config_Hide_TalkingHeadFrame = true, -- Скрыть говорящую голову
		Config_Hide_UIWidgetTopCenterContainerFrame = true, -- Скрыть верхний центр виджетов
		Config_Hide_WeeklyRewardExpirationWarningDialog = true, -- Скрыть предупреждение о наградах
		Config_Hide_ZoneTextFrame = true, -- Скрыть текст зоны
		Config_Hide_ZoneTextString = true, -- Скрыть строку зоны
	}
	for k, v in next, (defaultOptions) do
		E.func_InitField(EventFrame.savedVars, k, v)
	end
	-- Настройки позиционного фрейма
	E.func_InitSubTable(EventFrame.savedVars, "PosFrame")
	local defaultOptions_posFrame = {
		Shown = true, -- Показывать фрейм
		point = "BOTTOM", -- Точка привязки
		relativePoint = "BOTTOM", -- Относительная точка
		xOfs = 129, -- Смещение по X
		yOfs = 67, -- Смещение по Y
	}
	for k, v in next, (defaultOptions_posFrame) do
		E.func_InitField(EventFrame.savedVars.PosFrame, k, v)
	end
	-- Настройки фрейма скорости
	E.func_InitSubTable(EventFrame.savedVars, "SpeedFrame")
	local defaultOptions_speedFrame = {
		Shown = true, -- Показывать фрейм
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
E.func_RegisterMyEventsToFrames(EventFrame, MyEventsTable)
------------------------------------------------------------
function EventFrame:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	EventFrame.savedVars = E.func_GetSavedVars(GlobalAddonName)
	EventFrame[funcName](EventFrame)
end