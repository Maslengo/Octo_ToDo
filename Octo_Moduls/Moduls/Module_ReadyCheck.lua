local GlobalAddonName, ns = ...
E = _G.OctoEngine

local enable = false
if not enable then return end


local Octo_EventFrame_READY_CHECK = CreateFrame("FRAME")
Octo_EventFrame_READY_CHECK:Hide()





-- Таблица событий для регистрации
local MyEventsTable = {
	"READY_CHECK", -- Проверка готовности
}

-- Регистрация событий
E.func_RegisterMyEventsToFrames(Octo_EventFrame_READY_CHECK, MyEventsTable)
-- Обработчик проверки готовности
function Octo_EventFrame_READY_CHECK:READY_CHECK()
	if InCombatLockdown() then return end
	PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
end




