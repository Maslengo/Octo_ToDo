local GlobalAddonName, ns = ...
E = _G.OctoEngine
----------------------------------------------------------------
local OCTOexpansionID = 6
----------------------------------------------------------------
----------------------------------------------------------------
local function func_TextCenter(GUID)
	return Octo_ToDo_DB_Levels.PlayerData.Name
end
----------------------------------------------------------------
local function func_tooltipCENT(GUID)
	return
end
local zxc = {
	-- Статичные данные
	TextLeft = "Название задачи",
	ColorLeft = "FF00FF", -- HEX цвет
	TextCenter = {"Значение 1", "Значение 2"}, -- Данные для каждой колонки
	ColorCenter = {"FF0000", "00FF00"}, -- Цвета для каждой колонки
	-- Данные для генерации тултипа (не сам тултип)
	myType = {
		typeQ = "currency", -- Тип данных
		ID = 1234, -- ID валюты/предмета и т.д.
		iANIMA = true, -- Доп. параметры
		kCovenant = 1
	},
	-- Технические данные
	currentCharacterIndex = 1,
	totalColumns = 2
}
E.tbl_Otrisovka = {}
E.tbl_Otrisovka.TextLeft = E.func_GetItemName(44791)
E.tbl_Otrisovka.TextCenter = (function(itemID) return E.func_GetItemName(itemID) end)
E.tbl_Otrisovka.tooltipCENT = "tooltipCENT"
local function func_TextLeft(i)
	return E.tbl_Otrisovka.TextLeft[i]
end
-- в датапровайдер передавать данные, которые будут рассчитываться в инициализации
-- (а акваууеред это для вешанья ивентов и создания фнутренних элементов фреймов)
-- тултип вешаются в асквареде(сама функция он энтер) + нужны данные для формирования
-- для OctoTooltip сделать иконки во фреймпуллах
----------------------------------------------------------------
local OctoTable_Otrisovka_TestFrame = {}
if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
	table.insert(OctoTable_Otrisovka_TestFrame, function(CharInfo)
			----------------------------------------------------------------
			local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
			----------------------------------------------------------------
			return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
			----------------------------------------------------------------
	end)
end
----------------------------------------------------------------
E.OctoTable_Otrisovka_TestFrame = OctoTable_Otrisovka_TestFrame