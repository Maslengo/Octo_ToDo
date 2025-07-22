local GlobalAddonName, E = ...
----------------------------------------------------------------
-- Подключаем необходимые библиотеки
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo") -- Локализация
local LibDataBroker = LibStub("LibDataBroker-1.1") -- Для брокера данных
local LibDBIcon = LibStub("LibDBIcon-1.0") -- Для иконки на миникарте
local LibSharedMedia = LibStub("LibSharedMedia-3.0") -- Для медиа-ресурсов
local LibThingsLoad = LibStub("LibThingsLoad-1.0") -- Для асинхронной загрузки
local LibSFDropDown = LibStub("LibSFDropDown-1.5") -- Для выпадающих меню
local LibQTip = LibStub("LibQTip-1.0") -- Для тултипов
----------------------------------------------------------------
-- Создаем фреймы для работы аддона
local Octo_Event_TestFrame = CreateFrame("FRAME") -- Фрейм для обработки событий
Octo_Event_TestFrame:Hide()

-- Основной фрейм интерфейса аддона
local Octo_Main_TestFrame = CreateFrame("FRAME", "Octo_Main_TestFrame", UIParent, "BackdropTemplate")
Octo_Main_TestFrame:Hide()
Octo_Main_TestFrame:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		self:SetPoint("CENTER")
		self:SetSize(64, 64)
		self:EnableMouse(true)
		self:SetMovable(true)

		self.tex = self:CreateTexture()
		self.tex:SetAllPoints(self)
		self.tex:SetTexture("interface/icons/inv_mushroom_11")

		-- Обработчики перемещения фрейма
		self:SetScript("OnMouseDown", function(_, button)
				if button == "LeftButton" then
					self:SetAlpha(.5)
					self:StartMoving()
				end
		end)
		self:SetScript("OnMouseUp", function(_, button)
				if button == "LeftButton" then
					self:SetAlpha(1)
					self:StopMovingOrSizing()
				end
		end)
end)
Octo_Main_TestFrame:Show()
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function anchor_OnEnter(frame)
	local tooltip = LibQTip:Acquire("FooBarTooltip", 6, "LEFT", "CENTER", "RIGHT", "RIGHT", "RIGHT", "RIGHT")
	tooltip:Clear()
	frame.tooltip = tooltip
	-- size
	-- tooltip:SetCellMarginH(10) -- Отступ между столбцами (Не работает)
	-- size
	-- tooltip:SetCellMarginV(0) -- Отступ между строками

	tooltip:AddHeader("Anchor", " ", "Tooltip")
	tooltip:AddSeparator()
	-- tooltip:EnableScroll(true)
	-- tooltip:SetMaxHeight(20) -- Ограничение высоты в пикселях

	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData.CurrentRegionName == E.CurrentRegionName then
			if CharInfo.MASLENGO.professions then
				if CharInfo.MASLENGO.professions[2] then
					tooltip:AddLine(
						E:func_texturefromIcon(CharInfo.PlayerData.specIcon)..CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r",
						CharInfo.PlayerData.curServer,
						CharInfo.PlayerData.UnitLevel,
						E:func_ProfessionIcon(CharInfo.MASLENGO.professions[1].skillLine),
						E:func_ProfessionIcon(CharInfo.MASLENGO.professions[2].skillLine)
					)
				elseif CharInfo.MASLENGO.professions[1] then
					tooltip:AddLine(
						E:func_texturefromIcon(CharInfo.PlayerData.specIcon)..CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r",
						CharInfo.PlayerData.curServer,
						CharInfo.PlayerData.UnitLevel,
						" ",
						E:func_ProfessionIcon(CharInfo.MASLENGO.professions[1].skillLine)
					)
				end
			end
		end
	end
	-- tooltip:AddColumn("RIGHT") --"func_ProfessionIconCharInfoMASLENGOprofessionsskillLine" )
	tooltip:AddSeparator()
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.PlayerData.CurrentRegionName ~= E.CurrentRegionName then
			tooltip:AddLine(
				E:func_texturefromIcon(CharInfo.PlayerData.specIcon)..CharInfo.PlayerData.classColorHex..CharInfo.PlayerData.Name.."|r",
				CharInfo.PlayerData.curServer,
				CharInfo.PlayerData.UnitLevel

			)
		end
	end

	print ("GetFont:", tooltip:GetFont())
	print ("GetHeaderFont:", tooltip:GetHeaderFont())
	print ("GetLineCount:", tooltip:GetLineCount())
	print ("GetColumnCount:", tooltip:GetColumnCount())


	--lineNum, r, g, b, a
	tooltip:SetLineTextColor(1, 1, 0, 1, 1)

	-- colNum, r, g, b, a
	tooltip:SetColumnTextColor(2, 0, 1, 1, 1)

	-- lineNum, colNum, r, g, b, a
	tooltip:SetCellTextColor(3, 2, 0, 0, 1, 1)

	-- lineNum, r, g, b, a
	tooltip:SetLineColor(5, 1, 0, 0, 1)

	-- colNum, r, g, b, a
	tooltip:SetColumnColor(2, 1, 0, 0, .5)

	-- tooltip:Clear() -- Чистит тултип


	-- tooltip:SetScrollStep(1)
	-- will resize the tooltip to fit the screen and show a scrollbar if needed

	tooltip:SetPoint("RIGHT", frame, "LEFT")
	-- tooltip:SmartAnchorTo(frame)

	tooltip:UpdateScrolling(600)
	tooltip:SetAutoHideDelay(0.25, frame)
	tooltip:Show()

end

local function anchor_OnLeave(self)

	-- Release the tooltip
	LibQTip:Release(self.tooltip)
	self.tooltip = nil

end

-- Somewhere in the anchor initialization
Octo_Main_TestFrame:SetScript("OnEnter", anchor_OnEnter)
-- Octo_Main_TestFrame:SetScript("OnLeave", anchor_OnLeave)