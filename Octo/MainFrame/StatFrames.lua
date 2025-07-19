local GlobalAddonName, E = ...

local Height = 20 -- Высота одной строки
local Weight = 200 -- Ширина левой панели

function E:UpdateStatFrames(frame)
	-- Обновляем текстовые поля
	local moneyText, timePlayedText, levelTimeText, resetText = E:FormatCharacterStats()
	frame.money.text:SetText(moneyText)
	frame.playTime.text:SetText(timePlayedText)
	frame.levelTime.text:SetText(levelTimeText)
	frame.reset.text:SetText(resetText)
end

-- Функция создания фреймов статистики
function E:CreateStatFrames(frame)
	local moneyText, timePlayedText, levelTimeText, resetText = E:FormatCharacterStats()
	-- Создаем фреймы для отображения статистики
	frame.money = E:func_CreateInfoFrame(moneyText, "TOPLEFT", frame, "BOTTOMLEFT", 0, -Height*0, Weight, Height, "LEFT")
	frame.playTime = E:func_CreateInfoFrame(timePlayedText, "TOPLEFT", frame, "BOTTOMLEFT", 0, -Height*1, Weight, Height, "LEFT")
	frame.levelTime = E:func_CreateInfoFrame(levelTimeText, "TOPLEFT", frame, "BOTTOMLEFT", 0, -Height*2, Weight, Height, "LEFT")
	frame.reset = E:func_CreateInfoFrame(resetText, "TOPLEFT", frame, "TOPLEFT", 0, 0, Weight, Height*2, "LEFT")
end

-- Функция для отображения статистики персонажей
function E:FormatCharacterStats()
	local totalMoney, realTotalTime, realLevelTime = 0, 0, 0

	-- Считаем общие деньги и время игры
	for GUID, CharInfo in pairs(Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData.BattleTag == E.BattleTag then
			if CharInfo.PlayerData.Money then
				totalMoney = totalMoney + CharInfo.PlayerData.Money
			end

			if CharInfo.PlayerData.realTotalTime then
				realTotalTime = realTotalTime + CharInfo.PlayerData.realTotalTime
			end

			if CharInfo.PlayerData.UnitLevel and (CharInfo.PlayerData.UnitLevel >= E.currentMaxLevel) then
				realLevelTime = realLevelTime + CharInfo.PlayerData.realLevelTime
			end
		end
	end

	-- Форматируем текст для отображения
	local moneyText = format("Money: %s%s|r %s",
		E.classColorHexCurrent,
		E:func_CompactNumberFormat(totalMoney/10000),
		E.curServerShort)

	local timePlayedText = format(TIME_PLAYED_TOTAL,
		E.classColorHexCurrent..E:func_SecondsToClock(realTotalTime).."|r")

	local levelTimeText = format("realLevelTime: %s%s|r",
		E.classColorHexCurrent,
		E:func_SecondsToClock(realLevelTime))

	-- Время до сброса еженедельных заданий
	local resetText = E:func_texturefromIcon(E.Icon_Empty).." "..E:func_SecondsToClock(E:func_GetWeeklyReset())..E.Gray_Color.." Weekly reset|r"


	return moneyText, timePlayedText, levelTimeText, resetText
end