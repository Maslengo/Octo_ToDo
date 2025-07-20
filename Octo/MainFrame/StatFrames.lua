local GlobalAddonName, E = ...
local Height = 20 -- Высота одной строки
local Weight = 200 -- Ширина левой панели
local function Money_FrameOnEnter(frame)
	----------------------------------------------------------------
	local charsMoney = {}
	local totalMoney = 0
	----------------------------------------------------------------
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local PlayerColor = E.White_Color
			local ServerColor = E.White_Color
			if not Octo_ToDo_DB_Levels[GUID].PlayerData.isShownPLAYER then
				PlayerColor = E.Gray_Color
				ServerColor = E.Gray_Color
			else
				PlayerColor = CharInfo.PlayerData.classColorHex
			end
			local vivod = PlayerColor..E:func_texturefromIcon(CharInfo.PlayerData.specIcon).. CharInfo.PlayerData.Name.."|r"
			local curServ = ""
			if Octo_ToDo_DB_Levels[GUID].PlayerData.curServerShort ~= E.curServerShort then
				vivod = vivod.. ServerColor.. "-"..Octo_ToDo_DB_Levels[GUID].PlayerData.curServerShort.."|r"
			end
			if GUID == E.curGUID then
				vivod = vivod..E.Green_Color.."*|r"
			end
			if CharInfo.PlayerData.Money then
				totalMoney = totalMoney + CharInfo.PlayerData.Money
				tinsert(charsMoney, {Name = vivod, Money = CharInfo.PlayerData.Money})
			end
		end
	end
	----------------------------------------------------------------
	local tooltipMoney = {}
	table.sort(charsMoney, function(a, b) return a.Money > b.Money end)
	-- tooltipMoney[#tooltipMoney+1] = {" ", E:func_CompactNumberFormat(totalMoney/10000)}
	tooltipMoney[#tooltipMoney+1] = {" ", GetCoinTextureString(totalMoney)}
	tooltipMoney[#tooltipMoney+1] = {" ", " "}
	for i, v in ipairs(charsMoney) do
		-- tooltipMoney[#tooltipMoney+1] = {v.Name, E:func_CompactNumberFormat(v.Money/10000)}
		tooltipMoney[#tooltipMoney+1] = {v.Name, GetCoinTextureString(v.Money)}
	end
	frame.tooltip = tooltipMoney
	----------------------------------------------------------------
	E:func_TooltipOnEnter(frame)
	----------------------------------------------------------------
end
local function playTime_FrameOnEnter(frame)
	local charsplayTime = {}
	local totalplayTime = 0
	----------------------------------------------------------------
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			local PlayerColor = E.White_Color
			local ServerColor = E.White_Color
			if not Octo_ToDo_DB_Levels[GUID].PlayerData.isShownPLAYER then
				PlayerColor = E.Gray_Color
				ServerColor = E.Gray_Color
			else
				PlayerColor = CharInfo.PlayerData.classColorHex
			end
			local vivod = PlayerColor..E:func_texturefromIcon(CharInfo.PlayerData.specIcon).. CharInfo.PlayerData.Name.."|r"
			local curServ = ""
			if Octo_ToDo_DB_Levels[GUID].PlayerData.curServerShort ~= E.curServerShort then
				vivod = vivod.. ServerColor.. "-"..Octo_ToDo_DB_Levels[GUID].PlayerData.curServerShort.."|r"
			end
			if Octo_ToDo_DB_Levels[GUID].PlayerData.Name == E.curCharName then
				vivod = vivod..E.Green_Color.."*|r"
			end
			if CharInfo.PlayerData.realTotalTime then
				totalplayTime = totalplayTime + CharInfo.PlayerData.realTotalTime
				tinsert(charsplayTime, {Name = vivod, realTotalTime = CharInfo.PlayerData.realTotalTime})
			end
		end
	end
	----------------------------------------------------------------
	local tooltipplayTime = {}
	table.sort(charsplayTime, function(a, b) return a.realTotalTime > b.realTotalTime end)
	tooltipplayTime[#tooltipplayTime+1] = {" ", E:func_SecondsToClock(totalplayTime)}
	tooltipplayTime[#tooltipplayTime+1] = {" ", " "}
	for i, v in ipairs(charsplayTime) do
		tooltipplayTime[#tooltipplayTime+1] = {v.Name, E:func_SecondsToClock(v.realTotalTime)}
	end
	frame.tooltip = tooltipplayTime
	----------------------------------------------------------------
	E:func_TooltipOnEnter(frame)
	----------------------------------------------------------------
end
function E:UpdateStatFrames(frame)
	local moneyText, timePlayedText, resetText = E:FormatCharacterStats()
	frame.money.text:SetText(moneyText)
	frame.playTime.text:SetText(timePlayedText)
	frame.reset.text:SetText(resetText)
end
function E:func_CreateInfoFrame(text, point, parent, rPoint, x, y, sizeW, sizeH, JustifyH)
	local frame = CreateFrame("frame", nil, parent, "BackDropTemplate")
	frame:SetPoint(point, parent, rPoint, x, y)
	frame:SetSize(sizeW, sizeH)
	frame.text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frame.text:SetAllPoints()
	frame.text:SetFontObject(OctoFont11)
	frame.text:SetJustifyV("MIDDLE")
	frame.text:SetJustifyH(JustifyH)
	frame.text:SetTextColor(1, 1, 1, 1)
	return frame
end
-- Функция создания фреймов статистики
function E:CreateStatFrames(frame)
	local moneyText, timePlayedText, resetText = E:FormatCharacterStats()
	-- Создаем фреймы для отображения статистики
	frame.money = E:func_CreateInfoFrame(moneyText, "TOPLEFT", frame, "BOTTOMLEFT", 0, -Height*0, Weight, Height, "LEFT")
	frame.money:SetScript("OnEnter", function() Money_FrameOnEnter(frame.money) end)
	frame.money:SetScript("OnLeave", GameTooltip_Hide)
	frame.playTime = E:func_CreateInfoFrame(timePlayedText, "TOPLEFT", frame, "BOTTOMLEFT", 0, -Height*1, Weight, Height, "LEFT")
	frame.playTime:SetScript("OnEnter", function() playTime_FrameOnEnter(frame.playTime) end)
	frame.playTime:SetScript("OnLeave", GameTooltip_Hide)
	frame.reset = E:func_CreateInfoFrame(resetText, "TOPLEFT", frame, "TOPLEFT", 0, 0, Weight, Height*2, "LEFT")
end
-- Функция для отображения статистики персонажей
function E:FormatCharacterStats()
	local totalMoney, realTotalTime = 0, 0
	-- Считаем общие деньги и время игры
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			if CharInfo.PlayerData.Money then
				totalMoney = totalMoney + CharInfo.PlayerData.Money
			end
			if CharInfo.PlayerData.realTotalTime then
				realTotalTime = realTotalTime + CharInfo.PlayerData.realTotalTime
			end
		end
	end
	-- Форматируем текст для отображения
	local moneyText = MONEY..": ".. E.classColorHexCurrent..GetCoinTextureString(totalMoney).."|r"
	-- local moneyText = MONEY..": "..format(GOLD_AMOUNT_TEXTURE_STRING, E.classColorHexCurrent..E:func_CompactNumberFormat(totalMoney/10000).."|r")
	-- local moneyText = format("Money: %s%s|r", E.classColorHexCurrent, E:func_CompactNumberFormat(totalMoney/10000))
	local timePlayedText = format(TIME_PLAYED_TOTAL, E.classColorHexCurrent..E:func_SecondsToClock(realTotalTime).."|r")
	-- Время до сброса еженедельных заданий
	local resetText = E:func_texturefromIcon(E.Icon_Empty).." "..E:func_SecondsToClock(E:func_GetWeeklyReset())..E.Gray_Color.." Weekly reset|r"
	return moneyText, timePlayedText, resetText
end