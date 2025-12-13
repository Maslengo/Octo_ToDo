local GlobalAddonName, ns = ...
E = _G.OctoEngine
local EventFrame = CreateFrame("FRAME")
----------------------------------------------------------------
local enable = false
if not enable then return end
local EventFrame = CreateFrame("FRAME")
-- Таблица событий для регистрации
local MyEventsTable = {
	"READY_CHECK", -- Проверка готовности
}
-- Регистрация событий
E.func_RegisterEvents(EventFrame, MyEventsTable)
-- Обработчик проверки готовности
function EventFrame:READY_CHECK()
	if InCombatLockdown() then return end
	PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
end
