local AddonName, engine = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
print(AddonTitle.." v"..Version.." loaded")
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local Octo_ToDo_ShadowlandsAltFrame, EventFrame = nil, nil
local ColorKyrianR, ColorKyrianG, ColorKyrianB, ColorKyrianA = 111/255, 168/255, 220/255, 1
local ColorNecrolordR, ColorNecrolordG, ColorNecrolordB, ColorNecrolordA = 147/255, 196/255, 125/255, 1
local ColorNightFaeR, ColorNightFaeG, ColorNightFaeB, ColorNightFaeA = 142/255, 124/255, 195/255 , 1
local ColorVenthyrR, ColorVenthyrG, ColorVenthyrB, ColorVenthyrA = 224/255, 102/255, 102/255, 1
local _, className, curClass = UnitClass("PLAYER")
local classColor = C_ClassColor.GetClassColor(className)
local r,g,b = classColor:GetRGB()
local curWidth, curHeight = 80, 20 --ширина 45, высота 45 24
local curWidthTitle = curWidth*1.5
local curFontTTF, curFontSize13, curFontOutline = [[Interface\Addons\Octo_ToDo_Shadowlands\Media\font\01 Octo.TTF]], 11, "OUTLINE"
local curFontSize11 = 11
local curFontTest1,curFontTest2,curFontTest3 = [[Interface\Addons\Octo_ToDo_Shadowlands\Media\font\01 Octo.TTF]], curFontSize11, curFontOutline
local TotalLines = 23
local grayR,grayG,grayB,grayA = 0.5,0.5,0.5,1
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
local CovenantNames ={[1] = "Kyrian",[2] = "Venthyr",[3] = "NightFae",[4] = "Necrolord",}
local TotalTransAnima = 0
local TotalMoney = 0
local Calltable = {}
local thursdayResetDay0EU = 1514358000
local thursdayResetDay0US = 1514300400
local daytime = 86400 --60 * 60 * 24
--end
-- 0 None
-- 1 Kyrian
-- 2 Venthyr
-- 3 NightFae
-- 4 Necrolord
local function calling_sort(a,b)
	return (C_TaskQuest.GetQuestTimeLeftSeconds(a.questID or 0) or 0) < (C_TaskQuest.GetQuestTimeLeftSeconds(b.questID or 0) or 0)
end
local CQuestID = {
	{60425, 60426, 60418, 60427}, --1 Призыв в Бастионе, A Calling in Bastion, Беды на родине, Troubles at Home
	{60430, 60429, 60420, 60431}, --2 Призыв в Малдраксусе, A Calling in Maldraxxus, Беды на родине, Troubles at Home
	{60424, 60423, 60419, 60422}, --3 Призыв Арденвельда, A Call to Ardenweald, Беды на родине, Troubles at Home
	{60434, 60433, 60421, 60432}, --4 Призыв Ревендрета, A Call to Revendreth, Беды на родине, Troubles at Home
	{62692, 62694, 62693, 62691}, --5 призыв в, A Calling in...
	{60454, 60455, 60452, 60456}, --6 Буря в Утробе, Storm the Maw
	{60377, 60376, 60374, 60375}, --7 Горы сталекости, Bonemetal Bonanza
	{60372, 60371, 60369, 60370}, --8 Добротная древесина, A Wealth of Wealdwood
	{60358, 60363, 60364, 60365}, --9 Захват золотника, Gildenite Grab
	{60439, 60440, 60438, 60441}, --10 Испытания Арденвельда, Challenges in Ardenweald
	{60442, 60443, 60437, 60444}, --11 Испытания Бастиона, Challenges in Bastion
	{60447, 60445, 60436, 60446}, --12 Испытания Малдраксуса, Challenges in Maldraxxus
	{60450, 60449, 60435, 60448}, --13 Испытания Ревендрета, Challenges in Revendreth
	{60380, 60379, 60373, 60378}, --14 Источник скорбной лозы, A Source of Sorrowvine
	{60465, 60464, 60462, 60463}, --15 Очарование анимы, Anima Appeal
	{60391, 60390, 60381, 60389}, --16 Помощь Арденвельду, Aiding Ardenweald
	{60392, 60393, 60384, 60394}, --17 Помощь Бастиону, Aiding Bastion
	{60395, 60396, 60383, 60397}, --18 Помощь Малдраксусу, Aiding Maldraxxus
	{60400, 60398, 60382, 60399}, --19 Помощь Ревендрету, Aiding Revendreth
	{60415, 60416, 60414, 60417}, --20 Редкие ресурсы, Rare Resources
	{60458, 60459, 60457, 60460}, --21 Сбор анимы, Anima Salvage
	{60404, 60405, 60387, 60406}, --22 Обучение в Бастионе, Training in Bastion, Обучение войск, Training Our Forces
	{60407, 60408, 60386, 60409}, --23 Обучение в Малдраксусе, Training in Maldraxxus, Обучение войск, Training Our Forces
	{60403, 60402, 60388, 60401}, --24 Обучение в Арденвельде, Training in Ardenweald, Обучение войск, Training Our Forces
	{60412, 60411, 60385, 60410}, --25 Обучение в Ревендрете, Training in Revendreth, Обучение войск, Training Our Forces
	--{61982, 61983, 61984, 61981}, --Наполнение резервуара, 1000 анимы
}
local function tmstpDayReset(n)
	n = n or 1
	local thursdayReset = GetCurrentRegion() == 3 and thursdayResetDay0EU or thursdayResetDay0US
	local currTime = GetServerTime()
	return (math.ceil((currTime - thursdayReset)/(daytime*n))*daytime*n)+thursdayReset
end
function Callings(calling) --нужно вызывать=()
	local curActivCov = C_Covenants.GetActiveCovenantID() --ВЫКЛ
	local UnitLevel = UnitLevel("PLAYER") --ВЫКЛ
	if curActivCov == 0 then return end --ВЫКЛ
	local curGUID = UnitGUID("PLAYER")
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Octo_ToDo_ShadowlandsLevels[curGUID] = Octo_ToDo_ShadowlandsLevels[curGUID] or {}
	local collect = Octo_ToDo_ShadowlandsLevels[curGUID]
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local unlocked = C_CovenantCallings.AreCallingsUnlocked()
	if unlocked then
		if calling then
			local activeCallings = {}
			for i = 1, Constants.Callings.MaxCallings  do
				activeCallings[i] = calling[i]
				local Call = collect["Call"..i]
				Call.obj = "|cff00ff00"..DONE.."|r"
				Call.tmstpEnd = tmstpDayReset()
			end
			--sort(activeCallings,calling_sort)
			for k, v in ipairs(activeCallings) do
				local currQ, maxQ = 0,0
				for objectiveIndex = 1, v.numObjectives do
					local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(v.questID, objectiveIndex, false)
					--print (v.icon)
					currQ = numFulfilled or 0
					maxQ = numRequired or 0
					if objectiveType == "progressbar" then
						currQ = finished and 100 or GetQuestProgressBarPercent(v.questID) or 0
						maxQ = 100
					end
					if not numRequired then
						currQ, maxQ = 0, 1
					end
				end
				local bountyStr = format("|cff%s%d/%d",currQ==maxQ and "00ff00" or "ff0000",currQ,maxQ)
				local QuestTimeLeft = C_TaskQuest.GetQuestTimeLeftSeconds(v.questID) or 0
				local Call
				if QuestTimeLeft < 86400 then
					Call = collect.Call1
				elseif QuestTimeLeft < 172800 then
					Call = collect.Call2
				else
					Call = collect.Call3
				end
				Call.questID = v.questID
				--"|T133784:12:12:::64:64:4:60:4:60|t"..
				Call.icon = v.icon
				local questTitle, factionID, capped, displayAsObjective = C_TaskQuest.GetQuestInfoByQuestID(v.questID)
				-- print (questTitle, factionID, capped, displayAsObjective)
				Call.obj = maxQ == 100 and currQ/maxQ.."%" or currQ.."/"..maxQ
				local IsOnQuest = C_QuestLog.IsOnQuest(v.questID)
				if IsOnQuest then
					if currQ == maxQ then
						Call.obj = "|cffAF61FFможно сдать|r" -- (0,69, 0,38, 1,00, 1) --AF61FF фиолетовый
					else
						Call.obj = "|cffffff00"..Call.obj.."|r" --yellow
					end
				else
					Call.obj = "|cff808080"..Call.obj.."|r" --gray
				end
			end
		end
	end
end
local function CompactNumberFormat(number)
	if not number then number = 0 end
	if number < 1000 then return (math.floor((number+0.5)-0.5)/10)*10
	elseif number < 1000000 then return (math.floor(number/100)/10) .."k"
	else return (math.floor(number/100000)/10) .."m"
	end
end
local WA_Utf8Sub = function(input, size)
	local output = ""
	if type(input) ~= "string" then return output end
	local i = 1
	while (size > 0) do
		local byte = input:byte(i)
		if not byte then return output end
		if byte < 128 then output = output .. input:sub(i, i)
			size = size - 1
		elseif byte < 192 then output = output .. input:sub(i, i)
		elseif byte < 244 then output = output .. input:sub(i, i)
			size = size - 1
		end i = i + 1
	end
	while (true) do
		local byte = input:byte(i)
		if byte and byte >= 128 and byte < 192 then output = output .. input:sub(i, i)
		else break end
		i = i + 1
	end
	return output
end
function Octo_ToDo_ShadowlandsOnLoad()
	EventFrame = CreateFrame("FRAME", nil)
	EventFrame:RegisterEvent("VARIABLES_LOADED")
	EventFrame:RegisterEvent("COVENANT_CHOSEN")
	EventFrame:RegisterEvent("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
	EventFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	EventFrame:RegisterEvent("PLAYER_LOGIN")
	EventFrame:RegisterEvent("PLAYER_MONEY")
	EventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")
	EventFrame:SetScript("OnEvent", function(...) Octo_ToDo_ShadowlandsOnEvent(...) end)
end
function Octo_ToDo_ShadowlandsCreateAltFrame()
	Octo_ToDo_ShadowlandsAltFrame = CreateFrame("BUTTON", nil, UIParent, "BackdropTemplate")
	Octo_ToDo_ShadowlandsAltFrame:SetClampedToScreen(true)
	Octo_ToDo_ShadowlandsAltFrame:SetFrameStrata("TOOLTIP")
	Octo_ToDo_ShadowlandsAltFrame:SetPoint("CENTER", 0, 0)
	Octo_ToDo_ShadowlandsAltFrame:SetBackdrop({
			bgFile = "Interface\\Addons\\Octo_ToDo_Shadowlands\\Media\\background\\Square_White.tga",
			edgeFile = "Interface\\Addons\\Octo_ToDo_Shadowlands\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	Octo_ToDo_ShadowlandsAltFrame:SetBackdropColor(14/255, 14/255, 14/255, 0.80)
	Octo_ToDo_ShadowlandsAltFrame:SetScript("OnShow", function() C_CovenantCallings.RequestCallings() Octo_ToDo_ShadowlandsAddDataToAltFrame()
	end)
	Octo_ToDo_ShadowlandsAltFrame:EnableMouse(true)
	Octo_ToDo_ShadowlandsAltFrame:SetMovable(true)
	Octo_ToDo_ShadowlandsAltFrame:RegisterForDrag("LeftButton")
	Octo_ToDo_ShadowlandsAltFrame:SetScript("OnDragStart", Octo_ToDo_ShadowlandsAltFrame.StartMoving)
	Octo_ToDo_ShadowlandsAltFrame:SetScript("OnDragStop", function() Octo_ToDo_ShadowlandsAltFrame:StopMovingOrSizing() end)
	Octo_ToDo_ShadowlandsAltFrame:RegisterForClicks("RightButtonUp")
	Octo_ToDo_ShadowlandsAltFrame:SetScript("OnClick", function(self) self:Hide() end)
	Octo_ToDo_ShadowlandsAltFrame:SetScript("OnKeyDown", function(self, key)
			if key == GetBindingKey("TOGGLEGAMEMENU") then
				self:Hide()
				self:SetPropagateKeyboardInput(false)
			else self:SetPropagateKeyboardInput(true)
			end
	end)
	Octo_ToDo_ShadowlandsAltFrame.CloseButton = CreateFrame("Button", nil, Octo_ToDo_ShadowlandsAltFrame, "BackDropTemplate")
	Octo_ToDo_ShadowlandsAltFrame.CloseButton:SetSize(curHeight, curHeight)
	Octo_ToDo_ShadowlandsAltFrame.CloseButton:SetPoint("TOPRIGHT", Octo_ToDo_ShadowlandsAltFrame, "TOPRIGHT", curHeight, 0)
	Octo_ToDo_ShadowlandsAltFrame.CloseButton:SetBackdrop({ edgeFile = "Interface\\Addons\\Octo_ToDo_Shadowlands\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Octo_ToDo_ShadowlandsAltFrame.CloseButton:SetBackdropBorderColor(1, 0, 0, 0)
	Octo_ToDo_ShadowlandsAltFrame.CloseButton:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1,0,0,1)
	end)
	Octo_ToDo_ShadowlandsAltFrame.CloseButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(1,1,1,1)
	end)
	Octo_ToDo_ShadowlandsAltFrame.CloseButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1,0,0,0.5)
	end)
	Octo_ToDo_ShadowlandsAltFrame.CloseButton:SetScript("OnClick", function()
			Octo_ToDo_ShadowlandsAltFrame:Hide()
	end)
	local t = Octo_ToDo_ShadowlandsAltFrame.CloseButton:CreateTexture(nil,"BACKGROUND")
	Octo_ToDo_ShadowlandsAltFrame.CloseButton.icon = t
	t:SetTexture("Interface\\Addons\\Octo_ToDo_Shadowlands\\Media\\close.tga")
	t:SetVertexColor(1,1,1,1)
	t:SetAllPoints(Octo_ToDo_ShadowlandsAltFrame.CloseButton)
	local toyID1 = 172924
	local PlayerHasToy = PlayerHasToy(toyID1)
	if PlayerHasToy == false then
		local itemName = GetItemInfo(toyID1)
		Octo_ToDo_ShadowlandsAltFrame.WormholeButton = CreateFrame("Button", nil, Octo_ToDo_ShadowlandsAltFrame, "SecureActionButtonTemplate") --"SecureActionButtonTemplate" "BackDropTemplate"
		Octo_ToDo_ShadowlandsAltFrame.WormholeButton:SetSize(curHeight, curHeight)
		Octo_ToDo_ShadowlandsAltFrame.WormholeButton:SetPoint("BOTTOMRIGHT", Octo_ToDo_ShadowlandsAltFrame, "BOTTOMRIGHT", curHeight, 0)
		Octo_ToDo_ShadowlandsAltFrame.WormholeButton:SetAttribute("type", "macro")
		Octo_ToDo_ShadowlandsAltFrame.WormholeButton:SetAttribute("macrotext",[[/use item:172924]])
		Octo_ToDo_ShadowlandsAltFrame.WormholeButton:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
				GameTooltip:ClearLines()
				GameTooltip:SetToyByItemID(172924)
				GameTooltip:Show()
				self.icon:SetVertexColor(1,1,1,1)
		end)
		Octo_ToDo_ShadowlandsAltFrame.WormholeButton:SetScript("OnLeave", function(self)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
				self.icon:SetVertexColor(1,1,1,1)
		end)
		Octo_ToDo_ShadowlandsAltFrame.WormholeButton:HookScript("OnMouseDown", function(self)
				self.icon:SetVertexColor(1,1,1,0.5)
		end)
		local t = Octo_ToDo_ShadowlandsAltFrame.WormholeButton:CreateTexture(nil,"BACKGROUND")
		Octo_ToDo_ShadowlandsAltFrame.WormholeButton.icon = t
		t:SetTexture("Interface\\Addons\\Octo_ToDo_Shadowlands\\Media\\inv_engineering_90_wormholegenerator.tga")
		t:SetVertexColor(1,1,1,1)
		t:SetAllPoints(Octo_ToDo_ShadowlandsAltFrame.WormholeButton)
	end
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local function FrameLine_OnEnter(self) self.BG:SetColorTexture(grayR,grayG,grayB,.4) end
	local function FrameLine_OnLeave(self) self.BG:SetColorTexture(0,0,0,0) end
	for i = 0, TotalLines do
		local fname, f
		if i ~= 0 then
			fname = "FrameLine"..i
			Octo_ToDo_ShadowlandsAltFrame[fname] = CreateFrame("Frame", nil, Octo_ToDo_ShadowlandsAltFrame)
			f = Octo_ToDo_ShadowlandsAltFrame[fname]
			f:SetHeight(curHeight)
			f:SetPoint("TOPLEFT", Octo_ToDo_ShadowlandsAltFrame, "TOPLEFT", 0, -curHeight*i)
			f:SetPoint("RIGHT")
			f:SetScript("OnEnter", FrameLine_OnEnter)
			f:SetScript("OnLeave", FrameLine_OnLeave)
			f:SetMouseClickEnabled(false)
			f.BG = f:CreateTexture(nil, "BACKGROUND")
			f.BG:SetHeight(curHeight)
			f.BG:SetAllPoints()
		end
		fname = "TextLeft"..i
		Octo_ToDo_ShadowlandsAltFrame[fname] = Octo_ToDo_ShadowlandsAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		f = Octo_ToDo_ShadowlandsAltFrame[fname]
		f:SetSize(curWidthTitle, curHeight)
		f:SetPoint("TOPLEFT", Octo_ToDo_ShadowlandsAltFrame, "TOPLEFT", 6, -curHeight*i)
		f:SetFont(curFontTTF, curFontSize11)
		f:SetJustifyV("MIDDLE")
		f:SetJustifyH("LEFT")
		f:SetTextColor(1,1,1,1)
		--if i == 0 then f:SetText("Line0") end
		if i == 1 or i == 5 then f:SetTextColor(ColorKyrianR, ColorKyrianG, ColorKyrianB, 1) end
		if i == 2 or i == 6 then f:SetTextColor(ColorNecrolordR, ColorNecrolordG, ColorNecrolordB, 1) end
		if i == 3 or i == 7 then f:SetTextColor(ColorNightFaeR, ColorNightFaeG, ColorNightFaeB, 1) end
		if i == 4 or i == 8 then f:SetTextColor(ColorVenthyrR, ColorVenthyrG, ColorVenthyrB, 1) end
		if i == 1 or i == 5 then f:SetText("|T3257748:16:16:::64:64:4:60:4:60|t Kyrian") end
		if i == 2 or i == 6 then f:SetText("|T3257749:16:16:::64:64:4:60:4:60|t Necrolord") end
		if i == 3 or i == 7 then f:SetText("|T3257750:16:16:::64:64:4:60:4:60|t Night Fae") end
		if i == 4 or i == 8 then f:SetText("|T3257751:16:16:::64:64:4:60:4:60|t Venthyr") end
		if i == 9 then f:SetText("|T4381149:16:16:::64:64:4:60:4:60|t |cffff8000Космический Ветер|r") end
		if i == 10 then f:SetText("|T4067362:16:16:::64:64:4:60:4:60|t |cffff8000Угли душ|r") end
		if i == 11 then f:SetText("|T3743738:16:16:::64:64:4:60:4:60|t |cffff8000Пепел душ|r") end
		if i == 12 then f:SetText("|T463447:16:16:::64:64:4:60:4:60|t |cffa335eeДоблесть|r") end
		if i == 13 then f:SetText("|T3950362:16:16:::64:64:4:60:4:60|t |cff0070ddШифры предвечных|r") end
		if i == 14 then f:SetText("|T1523630:16:16:::64:64:4:60:4:60|t |cffa335eeОчки завоевания|r") end
		if i == 15 then f:SetText("|T1455894:16:16:::64:64:4:60:4:60|t |cff0070ddЧесть|r") end
		if i == 16 then f:SetText("|T4074774:16:16:::64:64:4:60:4:60|t ZM") end
		if i == 17 then f:SetText("|T3528312:16:16:::64:64:4:60:4:60|t WB") end
		if i == 18 then f:SetText("|T3528288:16:16:::64:64:4:60:4:60|t 1000 anima") end
		if i == 19 then f:SetText(" ") end --Call1
		if i == 20 then f:SetText(" ") end --Call2
		if i == 21 then f:SetText(" ") end --Call3
		--if i == 22 then f:SetText("Line21") end
		if i == 23 then f:SetText(" ") end
	end
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Octo_ToDo_ShadowlandsAddDataToAltFrame()
	Octo_ToDo_ShadowlandsAltFrame:Hide()
end
function OctoQuestUpdate()
	local curActivCov = C_Covenants.GetActiveCovenantID()
	local UnitLevel = UnitLevel("PLAYER")
	--if curActivCov == 0 --[[or UnitLevel < 60]] then return end
	local curGUID = UnitGUID("PLAYER")
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local questIDWB = 65143
	local maslengoWB = C_QuestLog.IsQuestFlaggedCompleted(questIDWB)
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local questID = 66042
	local maslengoZM = ""
	if C_QuestLog.IsComplete(questID) == true then maslengoZM = 100 --100(можно сдать)
	elseif C_QuestLog.IsQuestFlaggedCompleted(questID) == true then maslengoZM = true --true(сделан)
	elseif C_QuestLog.IsQuestFlaggedCompleted(questID) == false and C_QuestLog.IsOnQuest(questID) == false then maslengoZM = false --false (не сделан и нет квеста)
	elseif C_QuestLog.IsComplete(questID) == false and C_QuestLog.IsOnQuest(questID) == true then
		maslengoZM = GetQuestProgressBarPercent(questID) --не сделан и есть квест
	end
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local questIDanima1k = 61982
	if curActivCov == 1 then questIDanima1k = 61982 --Кирии
	elseif curActivCov == 3 then questIDanima1k = 61984 --Ночной народец
	elseif curActivCov == 4 then questIDanima1k = 61983 --Некролорды
	elseif curActivCov == 2 then questIDanima1k = 61981 --Вентиры
	end
	local maslengoanima1k = C_QuestLog.IsQuestFlaggedCompleted(questIDanima1k)
	if maslengoanima1k == false and C_QuestLog.IsOnQuest(questIDanima1k) then
		local objectives = C_QuestLog.GetQuestObjectives(questIDanima1k)
		if objectives and objectives[1] then
			maslengoanima1k = "|cffFFFF00"..objectives[1].numFulfilled .. "/" .. objectives[1].numRequired.."|r"
		end
	end
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Octo_ToDo_ShadowlandsLevels[curGUID] = Octo_ToDo_ShadowlandsLevels[curGUID] or {}
	local collect = Octo_ToDo_ShadowlandsLevels[curGUID]
	collect.maslengoWB = maslengoWB
	collect.maslengoZM = maslengoZM
	collect.maslengoanima1k = maslengoanima1k
end
function OctoMoneyUpdate()
	local curActivCov = C_Covenants.GetActiveCovenantID() --ВЫКЛ
	local UnitLevel = UnitLevel("PLAYER") --ВЫКЛ
	if curActivCov == 0 --[[or UnitLevel < 60]] then return end --ВЫКЛ
	local curGUID = UnitGUID("PLAYER")
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local Money = GetMoney()/10000
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Octo_ToDo_ShadowlandsLevels[curGUID] = Octo_ToDo_ShadowlandsLevels[curGUID] or {}
	local collect = Octo_ToDo_ShadowlandsLevels[curGUID]
	collect.Money = Money
end
function OctoAllCurrency()
	local curActivCov = C_Covenants.GetActiveCovenantID() --ВЫКЛ
	local UnitLevel = UnitLevel("PLAYER") --ВЫКЛ
	if curActivCov == 0 --[[or UnitLevel < 60]] then return end --ВЫКЛ
	local curGUID = UnitGUID("PLAYER")
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local currencyInfoCosmicFlux = C_CurrencyInfo.GetCurrencyInfo(2009)--CenterLines8 Космический ветер - 2009
	local CosmicFlux = currencyInfoCosmicFlux.quantity
	local currencyInfoSoulCinders = C_CurrencyInfo.GetCurrencyInfo(1906)--CenterLines10 Угли душ - 1906
	local SoulCinders = currencyInfoSoulCinders.quantity
	local currencyInfoSoulAsh = C_CurrencyInfo.GetCurrencyInfo(1828)--CenterLines11 Пепел душ - 1828
	local SoulAsh = currencyInfoSoulAsh.quantity
	local currencyInfoValor = C_CurrencyInfo.GetCurrencyInfo(1191)--CenterLines12 Доблесть - 1191
	local Valor = currencyInfoValor.quantity
	local currencyInfoCyphersoftheFirstOnes = C_CurrencyInfo.GetCurrencyInfo(1979)--CenterLines13 Шифры предвечных - 1979
	local CyphersoftheFirstOnes = currencyInfoCyphersoftheFirstOnes.quantity
	local currencyInfoConquest = C_CurrencyInfo.GetCurrencyInfo(1602)--CenterLines14 Очки завоевания - 1602
	local Conquest = currencyInfoConquest.quantity
	local currencyInfoHonor = C_CurrencyInfo.GetCurrencyInfo(1792)--CenterLines15 Честь - 1792
	local Honor = currencyInfoHonor.quantity
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Octo_ToDo_ShadowlandsLevels[curGUID] = Octo_ToDo_ShadowlandsLevels[curGUID] or {}
	local collect = Octo_ToDo_ShadowlandsLevels[curGUID]
	collect.CosmicFlux = CosmicFlux
	collect.SoulCinders = SoulCinders
	collect.SoulAsh = SoulAsh
	collect.Valor = Valor
	collect.CyphersoftheFirstOnes = CyphersoftheFirstOnes
	collect.Conquest = Conquest
	collect.Honor = Honor
end
function OctoilvlStr()
	local curActivCov = C_Covenants.GetActiveCovenantID() --ВЫКЛ
	local UnitLevel = UnitLevel("PLAYER") --ВЫКЛ
	if curActivCov == 0 --[[or UnitLevel < 60]] then return end --ВЫКЛ
	local curGUID = UnitGUID("PLAYER")
	------------------------------------------------------------------------------------------------------------------------
	local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel()
	--local ilvlStr = format("|cff%s%.1f|r",avgItemLevelEquipped >= 213 and "00ff00" or avgItemLevelEquipped >= 200 and "ffff00" or "ff0000",avgItemLevelEquipped)
	local ilvlStr = avgItemLevelEquipped or 0
	------------------------------------------------------------------------------------------------------------------------
	Octo_ToDo_ShadowlandsLevels[curGUID] = Octo_ToDo_ShadowlandsLevels[curGUID] or {}
	local collect = Octo_ToDo_ShadowlandsLevels[curGUID]
	collect.ilvlStr = ilvlStr or 0
end
function Octo_ToDo_ShadowlandsAddDataToAltFrame()
	local curGUID = UnitGUID("PLAYER")
	local otstyp = 7
	local UnitLevel = UnitLevel("PLAYER")
	Octo_ToDo_ShadowlandsAltFrame.AllCharFrames = {}
	local sorted = {}
	for curCharGUID, CharInfo in pairs(Octo_ToDo_ShadowlandsLevels) do
		sorted[#sorted+1] = CharInfo
	end
	sort(sorted,function(a,b)
			--------print (a,b)
			return
			a.curServer < b.curServer or a.curServer == b.curServer
			and
			a.ilvlStr < b.ilvlStr or a.ilvlStr == b.ilvlStr
			and
			a.Name < b.Name
	end)
	TotalTransAnima = 0
	TotalMoney = 0
	for i, CharInfo in pairs(sorted) do
		local curCharGUID = CharInfo.GUID
		local curName = nil
		if CharInfo.Name == nil then curName = "UnLogged Char" else curName = CharInfo.Name end
		local CurCharFrame
		if not Octo_ToDo_ShadowlandsAltFrame[curCharGUID] then
			Octo_ToDo_ShadowlandsAltFrame[curCharGUID] = CreateFrame("FRAME", nil, Octo_ToDo_ShadowlandsAltFrame)
			CurCharFrame = Octo_ToDo_ShadowlandsAltFrame[curCharGUID]
			CurCharFrame:SetPoint("BOTTOM", 0, 0)
			CurCharFrame.BG = CurCharFrame:CreateTexture(nil,"BACKGROUND")
			CurCharFrame.BG:Hide()
			CurCharFrame.BG:SetPoint("TOPLEFT", 0, -curHeight) -- -1, 1
			CurCharFrame.BG:SetPoint("BOTTOMRIGHT", 0, 0) -- 1, -1
			CurCharFrame.BG:SetColorTexture(r,g,b,1)
			CurCharFrame.DeleteButton = CreateFrame("BUTTON", nil, CurCharFrame, "BackDropTemplate")
			CurCharFrame.UnitLevel = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			CurCharFrame.CharName = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			CurCharFrame.curServer = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			CurCharFrame.CharNameBG = CurCharFrame:CreateTexture(nil,"BACKGROUND")
			CurCharFrame.CharNameBG:SetAllPoints(CurCharFrame.CharName)
			if CharInfo.Faction == "Horde" then
				CurCharFrame.CharNameBG:SetColorTexture(1,0,0,0.1)
			else
				CurCharFrame.CharNameBG:SetColorTexture(0,0,1,0.2)
			end
			for i = 1, TotalLines do
				local CLname, CL
				CLname = "CenterLines"..i
				CurCharFrame[CLname] = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				CL = CurCharFrame[CLname]
				CL:SetSize(curWidth, curHeight) --Line1 Кирии
				CL:SetPoint("TOP", CurCharFrame, "TOP", 0, -curHeight*i)
				CL:SetFont(curFontTTF, curFontSize13, curFontOutline)
				CL:SetJustifyV("MIDDLE")
				CL:SetJustifyH("CENTER")
				CL:SetTextColor(1,1,1,1)
			end
			CurCharFrame.CenterLines1BG = CurCharFrame:CreateTexture(nil,"BACKGROUND")
			CurCharFrame.CenterLines1BG:SetAllPoints(CurCharFrame.CenterLines1)
			CurCharFrame.CenterLines1BG:SetColorTexture(ColorKyrianR,ColorKyrianG,ColorKyrianB,0.3)
			CurCharFrame.CenterLines2BG = CurCharFrame:CreateTexture(nil,"BACKGROUND")
			CurCharFrame.CenterLines2BG:SetAllPoints(CurCharFrame.CenterLines2)
			CurCharFrame.CenterLines2BG:SetColorTexture(ColorNecrolordR,ColorNecrolordG,ColorNecrolordB,0.3)
			CurCharFrame.CenterLines3BG = CurCharFrame:CreateTexture(nil,"BACKGROUND")
			CurCharFrame.CenterLines3BG:SetAllPoints(CurCharFrame.CenterLines3)
			CurCharFrame.CenterLines3BG:SetColorTexture(ColorNightFaeR,ColorNightFaeG,ColorNightFaeB,0.3)
			CurCharFrame.CenterLines4BG = CurCharFrame:CreateTexture(nil,"BACKGROUND")
			CurCharFrame.CenterLines4BG:SetAllPoints(CurCharFrame.CenterLines4)
			CurCharFrame.CenterLines4BG:SetColorTexture(ColorVenthyrR,ColorVenthyrG,ColorVenthyrB,0.3)
			CurCharFrame.CenterLines5BG = CurCharFrame:CreateTexture(nil,"BACKGROUND")
			CurCharFrame.CenterLines5BG:SetAllPoints(CurCharFrame.CenterLines5)
			CurCharFrame.CenterLines5BG:SetColorTexture(ColorKyrianR,ColorKyrianG,ColorKyrianB,0.3)
			CurCharFrame.CenterLines6BG = CurCharFrame:CreateTexture(nil,"BACKGROUND")
			CurCharFrame.CenterLines6BG:SetAllPoints(CurCharFrame.CenterLines6)
			CurCharFrame.CenterLines6BG:SetColorTexture(ColorNecrolordR,ColorNecrolordG,ColorNecrolordB,0.3)
			CurCharFrame.CenterLines7BG = CurCharFrame:CreateTexture(nil,"BACKGROUND")
			CurCharFrame.CenterLines7BG:SetAllPoints(CurCharFrame.CenterLines7)
			CurCharFrame.CenterLines7BG:SetColorTexture(ColorNightFaeR,ColorNightFaeG,ColorNightFaeB,0.3)
			CurCharFrame.CenterLines8BG = CurCharFrame:CreateTexture(nil,"BACKGROUND")
			CurCharFrame.CenterLines8BG:SetAllPoints(CurCharFrame.CenterLines8)
			CurCharFrame.CenterLines8BG:SetColorTexture(ColorVenthyrR,ColorVenthyrG,ColorVenthyrB,0.3)
		else
			CurCharFrame = Octo_ToDo_ShadowlandsAltFrame[curCharGUID]
		end
		------------------------------------------------------------------------------------------------------------------------
		CharInfo.GUID = curCharGUID
		if CharInfo.Anima == nil then CharInfo.Anima = {NightFae = 0, Venthyr = 0, Necrolord = 0, Kyrian = 0} end
		CurCharFrame:SetSize(curWidth, curHeight)
		Octo_ToDo_ShadowlandsAltFrame:SetBackdropBorderColor(0, 0, 0, 1)
		Octo_ToDo_ShadowlandsAltFrame:SetBackdropColor(14/255, 14/255, 14/255, 0.80)
		if #Octo_ToDo_ShadowlandsAltFrame.AllCharFrames == 0 then CurCharFrame:SetPoint("TOPRIGHT", 0, 0)
		else CurCharFrame:SetPoint("TOPRIGHT", Octo_ToDo_ShadowlandsAltFrame.AllCharFrames[#Octo_ToDo_ShadowlandsAltFrame.AllCharFrames], "TOPLEFT", 0, 0) end
		Octo_ToDo_ShadowlandsAltFrame.AllCharFrames[#Octo_ToDo_ShadowlandsAltFrame.AllCharFrames + 1] = CurCharFrame
		local curTranfAnima = 0
		local curAnimaKyrian = CharInfo.Anima.Kyrian or 0
		if curAnimaKyrian < 1000 then curAnimaKyrian = 0 else curAnimaKyrian = (math.floor((curAnimaKyrian)/1000))*1000 end
		local curAnimaNecrolord = CharInfo.Anima.Necrolord or 0
		if curAnimaNecrolord < 1000 then curAnimaNecrolord = 0 else curAnimaNecrolord = (math.floor((curAnimaNecrolord)/1000))*1000 end
		local curAnimaNightFae = CharInfo.Anima.NightFae or 0
		if curAnimaNightFae < 1000 then curAnimaNightFae = 0 else curAnimaNightFae = (math.floor((curAnimaNightFae)/1000))*1000 end
		local curAnimaVenthyr = CharInfo.Anima.Venthyr or 0
		if curAnimaVenthyr < 1000 then curAnimaVenthyr = 0 else curAnimaVenthyr = (math.floor((curAnimaVenthyr)/1000))*1000 end
		curTranfAnima = curAnimaKyrian + curAnimaNecrolord + curAnimaNightFae + curAnimaVenthyr
		--------print (CharInfo.Anima.Kyrian, math.ceil(CharInfo.Anima.Kyrian))
		TotalTransAnima = TotalTransAnima + curTranfAnima
		------------------------------------------------------------------------------------------------------------------------
		local curMoney = 0
		if curServer == CharInfo.curServer and CharInfo.Money ~= 0 then curMoney = CharInfo.Money end
		--------print (TotalMoney + curMoney, TotalMoney, curMoney, CharInfo.Name, CharInfo.curServer)
		TotalMoney = TotalMoney + curMoney
		------------------------------------------------------------------------------------------------------------------------
		local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
		------------------------------------------------------------------------------------------------------------------------
		CurCharFrame.UnitLevel:SetSize(curWidth, curHeight)
		CurCharFrame.UnitLevel:SetPoint("BOTTOM", CurCharFrame, "TOP", 0, -1)
		CurCharFrame.UnitLevel:SetFont(curFontTTF, curFontSize11)
		CurCharFrame.UnitLevel:SetText(" ")
		if CharInfo.UnitLevel < 60 then
			CurCharFrame.UnitLevel:SetText(classcolor:WrapTextInColorCode(CharInfo.UnitLevel))
		end
		CurCharFrame.UnitLevel:SetWordWrap(true) --true перенос, fasle одна строка
		CurCharFrame.UnitLevel:SetJustifyV("TOP")
		------------------------------------------------------------------------------------------------------------------------
		CurCharFrame.CharName:SetSize(curWidth, curHeight)
		CurCharFrame.CharName:SetPoint("TOP", CurCharFrame, "TOP", 0, 1)
		CurCharFrame.CharName:SetFont(curFontTTF, curFontSize11)
		CurCharFrame.CharName:SetText(classcolor:WrapTextInColorCode(CharInfo.Name))
		CurCharFrame.CharName:SetWordWrap(true) --true перенос, fasle одна строка
		CurCharFrame.CharName:SetJustifyV("TOP")
		------------------------------------------------------------------------------------------------------------------------
		CurCharFrame.curServer:SetSize(curWidth, curHeight)
		CurCharFrame.curServer:SetPoint("TOP", CurCharFrame, "TOP", 0, -10)
		CurCharFrame.curServer:SetFont(curFontTTF, 9)
		CurCharFrame.curServer:SetText(classcolor:WrapTextInColorCode(CharInfo.curServer))
		CurCharFrame.curServer:SetWordWrap(false) --true перенос, fasle одна строка
		CurCharFrame.curServer:SetJustifyV("TOP")
		------------------------------------------------------------------------------------------------------------------------
		CurCharFrame.DeleteButton:SetSize(16, 10)
		CurCharFrame.DeleteButton:SetPoint("TOP", CurCharFrame, "BOTTOM", 0, -4)
		CurCharFrame.DeleteButton:SetBackdrop({
				edgeFile = "Interface\\Addons\\Octo_ToDo_Shadowlands\\Media\\border\\01 Octo.tga", --Interface/Addons/Octo_ToDo_Shadowlands/Media/border/01 Octo.tga --Interface/Buttons/white8x8
				edgeSize = 1,
		})
		CurCharFrame.DeleteButton:SetBackdropBorderColor(1, 0, 0, 0)
		CurCharFrame.DeleteButton:SetScript("OnEnter", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 1)
				self.icon:SetVertexColor(1,0,0,1)
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
				GameTooltip:ClearLines()
				GameTooltip:SetText(DELETE)
				GameTooltip:Show()
		end)
		CurCharFrame.DeleteButton:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(1,1,1,1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		CurCharFrame.DeleteButton:SetScript("OnMouseDown", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 0.5)
				self.icon:SetVertexColor(1,0,0,0.5)
		end)
		CurCharFrame.DeleteButton:SetScript("OnClick", function() Octo_ToDo_ShadowlandsDeleteChar(curCharGUID) end)
		local t = CurCharFrame.DeleteButton:CreateTexture(nil,"BACKGROUND")
		CurCharFrame.DeleteButton.icon = t
		t:SetTexture("Interface\\Addons\\Octo_ToDo_Shadowlands\\Media\\close.tga")
		t:SetVertexColor(1,1,1,1)
		t:SetAllPoints(CurCharFrame.DeleteButton)
		------------------------------------------------------------------------------------------------------------------------
		if CLname == "CenterLines1" or CLname == "CenterLines5" then CL:SetTextColor(ColorKyrianR, ColorKyrianG, ColorKyrianB, 1) end
		if CLname == "CenterLines2" or CLname == "CenterLines6" then CL:SetTextColor(ColorNecrolordR, ColorNecrolordG, ColorNecrolordB, 1) end
		if CLname == "CenterLines3" or CLname == "CenterLines7" then CL:SetTextColor(ColorNightFaeR, ColorNightFaeG, ColorNightFaeB, 1) end
		if CLname == "CenterLines4" or CLname == "CenterLines8" then CL:SetTextColor(ColorVenthyrR, ColorVenthyrG, ColorVenthyrB, 1) end
		------------------------------------------------------------------------------------------------------------------------
		--1
		CurCharFrame.CenterLines1:SetText(CharInfo.Kyrian)
		CurCharFrame.CenterLines1:SetTextColor(ColorKyrianR, ColorKyrianG, ColorKyrianB, ColorKyrianA)
		--2
		CurCharFrame.CenterLines2:SetText(CharInfo.Necrolord)
		CurCharFrame.CenterLines2:SetTextColor(ColorNecrolordR, ColorNecrolordG, ColorNecrolordB, 1)
		--3
		CurCharFrame.CenterLines3:SetText(CharInfo.NightFae)
		CurCharFrame.CenterLines3:SetTextColor(ColorNightFaeR, ColorNightFaeG, ColorNightFaeB, 1)
		--4
		CurCharFrame.CenterLines4:SetText(CharInfo.Venthyr)
		CurCharFrame.CenterLines4:SetTextColor(ColorVenthyrR, ColorVenthyrG, ColorVenthyrB, 1)
		--5
		CurCharFrame.CenterLines5:SetText(CompactNumberFormat(CharInfo.Anima.Kyrian))
		CurCharFrame.CenterLines5:SetTextColor(ColorKyrianR, ColorKyrianG, ColorKyrianB, ColorKyrianA)
		--6
		CurCharFrame.CenterLines6:SetText(CompactNumberFormat(CharInfo.Anima.Necrolord))
		CurCharFrame.CenterLines6:SetTextColor(ColorNecrolordR, ColorNecrolordG, ColorNecrolordB, 1)
		--7
		CurCharFrame.CenterLines7:SetText(CompactNumberFormat(CharInfo.Anima.NightFae))
		CurCharFrame.CenterLines7:SetTextColor(ColorNightFaeR, ColorNightFaeG, ColorNightFaeB, 1)
		--8
		CurCharFrame.CenterLines8:SetText(CompactNumberFormat(CharInfo.Anima.Venthyr))
		CurCharFrame.CenterLines8:SetTextColor(ColorVenthyrR, ColorVenthyrG, ColorVenthyrB, 1)
		--9
		CurCharFrame.CenterLines9:SetText(CompactNumberFormat(CharInfo.CosmicFlux))
		if CharInfo.CosmicFlux == 0 or CharInfo.CosmicFlux == nil then CurCharFrame.CenterLines9:SetTextColor(grayR,grayG,grayB,grayA) end
		--10
		CurCharFrame.CenterLines10:SetText(CompactNumberFormat(CharInfo.SoulCinders))
		if CharInfo.SoulCinders == 0 or CharInfo.SoulCinders == nil then CurCharFrame.CenterLines10:SetTextColor(grayR,grayG,grayB,grayA) end
		--11
		CurCharFrame.CenterLines11:SetText(CompactNumberFormat(CharInfo.SoulAsh))
		if CharInfo.SoulAsh == 0 or CharInfo.SoulAsh == nil then CurCharFrame.CenterLines11:SetTextColor(grayR,grayG,grayB,grayA) end
		--12
		CurCharFrame.CenterLines12:SetText(CompactNumberFormat(CharInfo.Valor))
		if CharInfo.Valor == 0 or CharInfo.Valor == nil or CharInfo.Valor <= 499 then CurCharFrame.CenterLines12:SetTextColor(grayR,grayG,grayB,grayA) end
		--13
		CurCharFrame.CenterLines13:SetText(CompactNumberFormat(CharInfo.CyphersoftheFirstOnes))
		if CharInfo.CyphersoftheFirstOnes == 0 or CharInfo.CyphersoftheFirstOnes == nil then CurCharFrame.CenterLines13:SetTextColor(grayR,grayG,grayB,grayA) end
		--14
		CurCharFrame.CenterLines14:SetText(CompactNumberFormat(CharInfo.Conquest))
		if CharInfo.Conquest == 0 or CharInfo.Conquest == nil then CurCharFrame.CenterLines14:SetTextColor(grayR,grayG,grayB,grayA) end
		--15
		CurCharFrame.CenterLines15:SetText(CompactNumberFormat(CharInfo.Honor))
		if CharInfo.Honor == 0 or CharInfo.Honor == nil then CurCharFrame.CenterLines15:SetTextColor(grayR,grayG,grayB,grayA) end
		if (CharInfo.Honor) > 10000 then CurCharFrame.CenterLines15:SetTextColor(1,1,0,1) end
		--16
		--CurCharFrame.CenterLines16:SetText(CharInfo.maslengoZM)
		CurCharFrame.CenterLines16:SetText("NO DATA")
		if CharInfo.maslengoZM == nil then
			CurCharFrame.CenterLines16:SetText("NO DATA")
		elseif CharInfo.maslengoZM then
			if type(CharInfo.maslengoZM) == "number" then --100
				if CharInfo.maslengoZM == 100 then
					CurCharFrame.CenterLines16:SetText("Можно сдать") --true
					CurCharFrame.CenterLines16:SetTextColor(0,69, 0,38, 1,00, 1) --AF61FF фиолетовый
				else
					CurCharFrame.CenterLines16:SetText(CharInfo.maslengoZM.."%") --сейчас выполняется в %
					CurCharFrame.CenterLines16:SetTextColor(1, 1, 0, 1) --желтый
					CurCharFrame.CenterLines16:SetFont(curFontTTF, curFontSize13, curFontOutline)
				end
			else
				CurCharFrame.CenterLines16:SetText(DONE)
				CurCharFrame.CenterLines16:SetTextColor(0, 1, 0, 1)
			end
		else
			CurCharFrame.CenterLines16:SetText(NONE)
			CurCharFrame.CenterLines16:SetTextColor(1, 0, 0, 1)
		end
		--17
		CurCharFrame.CenterLines17:SetText(CharInfo.maslengoWB and DONE or NONE)
		if CharInfo.maslengoWB then CurCharFrame.CenterLines17:SetTextColor(0,1,0,1) else CurCharFrame.CenterLines17:SetTextColor(1,0,0,1) end
		--18
		CurCharFrame.CenterLines18:SetText(CharInfo.maslengoanima1k or NONE)
		if CharInfo.maslengoanima1k == true then CurCharFrame.CenterLines18:SetTextColor(0,1,0,1) CurCharFrame.CenterLines18:SetText(DONE) else CurCharFrame.CenterLines18:SetTextColor(1,0,0,1) end
		--Call1
		if (CharInfo.Call1.tmstpEnd or 0) < GetServerTime() then   --tmstpDayReset
			CharInfo.Call1.obj = CharInfo.Call2.obj
		end
		CurCharFrame.CenterLines19:SetText(CharInfo.Call1.obj or NONE)
		CurCharFrame.CenterLines19:SetTextColor(1,0,0,1)
		--Call2
		if (CharInfo.Call2.tmstpEnd or 0) < GetServerTime() then   --tmstpDayReset
			CharInfo.Call2.obj = CharInfo.Call3.obj
		end
		CurCharFrame.CenterLines20:SetText(CharInfo.Call2.obj or NONE)
		CurCharFrame.CenterLines20:SetTextColor(1,0,0,1)
		--Call3
		if (CharInfo.Call3.tmstpEnd or 0) < GetServerTime() then   --tmstpDayReset
			CharInfo.Call3.obj = "|cff808080-|r"
		end
		CurCharFrame.CenterLines21:SetText(CharInfo.Call3.obj or NONE)
		CurCharFrame.CenterLines21:SetTextColor(1,0,0,1)
		CurCharFrame.CenterLines22:SetText("|T133784:12:12:::64:64:4:60:4:60|t".."|cffFFF371"..CompactNumberFormat(CharInfo.Money).."|r") --0.949, 0.902, 0.6 icon = 133784 https://www.wowhead.com/icons/name:coin
		CurCharFrame.CenterLines23:SetText(format("|cff%s%.1f|r",CharInfo.ilvlStr >= 270 and "00ff00" or CharInfo.ilvlStr >= 252 and "ffff00" or "ff0000",CharInfo.ilvlStr))
		local RenownLevel80 = C_CovenantSanctumUI.GetRenownLevel(CharInfo.Active)
		if CharInfo.Money < 1000 then CurCharFrame.CenterLines22:SetText("|T133784:12:12:::64:64:4:60:4:60|t".."|cff909090"..CompactNumberFormat(CharInfo.Money).."|r") end
		------------------------------------------------------------------------------------------------------------------------
		if CharInfo.Kyrian < 60 then
			CurCharFrame.CenterLines1:SetTextColor(ColorKyrianR,ColorKyrianG,ColorKyrianB,ColorKyrianA)
			CurCharFrame.CenterLines1:SetText("|cffFF0000(|r"..CharInfo.Kyrian.."|cffFF0000)|r") end
		if CharInfo.Anima.Kyrian < 1000 then CurCharFrame.CenterLines5:SetTextColor(grayR,grayG,grayB,grayA) end
		if CharInfo.Kyrian == 0 then CurCharFrame.CenterLines1:SetTextColor(grayR,grayG,grayB,grayA) end
		if CharInfo.Anima.Kyrian == 0 then CurCharFrame.CenterLines5:SetTextColor(grayR,grayG,grayB,grayA) end
		------------------------------------------------------------------------------------------------------------------------
		if CharInfo.Necrolord < 60 then
			CurCharFrame.CenterLines2:SetTextColor(ColorNecrolordR,ColorNecrolordG,ColorNecrolordB,ColorNecrolordA)
			CurCharFrame.CenterLines2:SetText("|cffFF0000(|r"..CharInfo.Necrolord.."|cffFF0000)|r") end
		if CharInfo.Anima.Necrolord < 1000 then CurCharFrame.CenterLines6:SetTextColor(grayR,grayG,grayB,grayA) end
		if CharInfo.Necrolord == 0 then CurCharFrame.CenterLines2:SetTextColor(grayR,grayG,grayB,grayA) end
		if CharInfo.Anima.Necrolord == 0 then CurCharFrame.CenterLines6:SetTextColor(grayR,grayG,grayB,grayA) end
		------------------------------------------------------------------------------------------------------------------------
		if CharInfo.NightFae < 60 then
			CurCharFrame.CenterLines3:SetTextColor(ColorNightFaeR,ColorNightFaeG,ColorNightFaeB,ColorNightFaeA)
			CurCharFrame.CenterLines3:SetText("|cffFF0000(|r"..CharInfo.NightFae.."|cffFF0000)|r") end
		if CharInfo.Anima.NightFae < 1000 then CurCharFrame.CenterLines7:SetTextColor(grayR,grayG,grayB,grayA) end
		if CharInfo.NightFae == 0 then CurCharFrame.CenterLines3:SetTextColor(grayR,grayG,grayB,grayA) end
		if CharInfo.Anima.NightFae == 0 then CurCharFrame.CenterLines7:SetTextColor(grayR,grayG,grayB,grayA) end
		------------------------------------------------------------------------------------------------------------------------
		if CharInfo.Venthyr < 60 then
			CurCharFrame.CenterLines4:SetTextColor(ColorVenthyrR,ColorVenthyrG,ColorVenthyrB,ColorVenthyrA)
			CurCharFrame.CenterLines4:SetText("|cffFF0000(|r"..CharInfo.Venthyr.."|cffFF0000)|r") end
		if CharInfo.Anima.Venthyr < 1000 then CurCharFrame.CenterLines8:SetTextColor(grayR,grayG,grayB,grayA) end
		if CharInfo.Venthyr == 0 then CurCharFrame.CenterLines4:SetTextColor(grayR,grayG,grayB,grayA) end
		if CharInfo.Anima.Venthyr == 0 then CurCharFrame.CenterLines8:SetTextColor(grayR,grayG,grayB,grayA) end
		------------------------------------------------------------------------------------------------------------------------
		CurCharFrame.CenterLines1BG:SetShown(CharInfo.Active == 1)
		CurCharFrame.CenterLines2BG:SetShown(CharInfo.Active == 4)
		CurCharFrame.CenterLines3BG:SetShown(CharInfo.Active == 3)
		CurCharFrame.CenterLines4BG:SetShown(CharInfo.Active == 2)
		CurCharFrame.CenterLines5BG:SetShown(CharInfo.Active == 1)
		CurCharFrame.CenterLines6BG:SetShown(CharInfo.Active == 4)
		CurCharFrame.CenterLines7BG:SetShown(CharInfo.Active == 3)
		CurCharFrame.CenterLines8BG:SetShown(CharInfo.Active == 2)
		------------------------------------------------------------------------------------------------------------------------
		if curGUID == curCharGUID then
			--local leftarrow = (">>")--»» classColor:WrapTextInColorCode(">>")--»»
			--local rightarrow = ("<<")--«« classColor:WrapTextInColorCode("<<")--««
			CurCharFrame.BG:Show()
			CurCharFrame.BG:SetAlpha(0.3)
			--if CharInfo.Active == 1 then
			--    CurCharFrame.CenterLines1:SetText(leftarrow .. CurCharFrame.CenterLines1:GetText() .. rightarrow)
			--    CurCharFrame.CenterLines5:SetText(leftarrow .. CurCharFrame.CenterLines5:GetText() .. rightarrow)
			--elseif CharInfo.Active == 4 then
			--    CurCharFrame.CenterLines2:SetText(leftarrow .. CurCharFrame.CenterLines2:GetText() .. rightarrow)
			--    CurCharFrame.CenterLines6:SetText(leftarrow .. CurCharFrame.CenterLines6:GetText() .. rightarrow)
			--elseif CharInfo.Active == 3 then
			--    CurCharFrame.CenterLines3:SetText(leftarrow .. CurCharFrame.CenterLines3:GetText() .. rightarrow)
			--    CurCharFrame.CenterLines7:SetText(leftarrow .. CurCharFrame.CenterLines7:GetText() .. rightarrow)
			--elseif CharInfo.Active == 2 then
			--    CurCharFrame.CenterLines4:SetText(leftarrow .. CurCharFrame.CenterLines4:GetText() .. rightarrow)
			--    CurCharFrame.CenterLines8:SetText(leftarrow .. CurCharFrame.CenterLines8:GetText() .. rightarrow)
			--end
		end
	end --end для фора
	------------------------------------------------------------------------------------------------------------------------
	local curServerShort = GetRealmName()
	local text = (curServerShort):gsub("-", " "):gsub("'", " ")
	local a, b = strsplit(" ", text)
	if b then curServerShort = WA_Utf8Sub(a,1)..WA_Utf8Sub(b,1):upper() else curServerShort = WA_Utf8Sub(a,3):lower() end
	Octo_ToDo_ShadowlandsAltFrame.TextLeft0:SetText("|T3528288:16:16:::64:64:4:60:4:60|t ".."|cff00A3FF"..CompactNumberFormat(TotalTransAnima).."|r") --Line0? TotalTransAnima
	Octo_ToDo_ShadowlandsAltFrame.TextLeft22:SetText("|T133784:16:16:::64:64:4:60:4:60|t ".."|cffFFF371"..curServerShort..": "..CompactNumberFormat(TotalMoney).."|r") --Line21 Money
	local curAltFrameWidth = #Octo_ToDo_ShadowlandsAltFrame.AllCharFrames * curWidth/2
	Octo_ToDo_ShadowlandsAltFrame:SetSize(curAltFrameWidth*2+curWidthTitle, curHeight*(TotalLines+1)) --Width ширина, Height высота pizda ПИЗДА
end
function Octo_ToDo_ShadowlandsDeleteChar(curGUID)
	Octo_ToDo_ShadowlandsLevels[curGUID] = nil
	for X, Y in pairs(Octo_ToDo_ShadowlandsAltFrame.AllCharFrames) do
		if Y == Octo_ToDo_ShadowlandsAltFrame[curGUID] then
			Octo_ToDo_ShadowlandsAltFrame.AllCharFrames[X].parent = nil
			Octo_ToDo_ShadowlandsAltFrame.AllCharFrames[X]:Hide()
			Octo_ToDo_ShadowlandsAltFrame.AllCharFrames[X] = nil
		end
	end
	Octo_ToDo_ShadowlandsAddDataToAltFrame()
end
function Octo_ToDo_ShadowlandsFrameUpdateValues()
	local curGUID = UnitGUID("PLAYER")
	local curCovID = C_Covenants.GetActiveCovenantID()
	local UnitLevel = UnitLevel("PLAYER")
	local curActivCov = C_Covenants.GetActiveCovenantID()
	--if curCovID ~= nil and curCovID ~= 0 --[[and UnitLevel >= 60]] then
	local collect = Octo_ToDo_ShadowlandsLevels[curGUID] or 0
	local curCovName = CovenantNames[curCovID] or 0
	local curCovLevel = C_CovenantSanctumUI.GetRenownLevel() or 0
	local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1813) or 0 --Запасенная анима
	local curAnimaAmount = currencyInfo.quantity or 0
	if not collect.NightFae then collect.NightFae = 0 end
	if not collect.Venthyr then collect.Venthyr = 0 end
	if not collect.Necrolord then collect.Necrolord = 0 end
	if not collect.Kyrian then collect.Kyrian = 0 end
	if collect.Anima == nil then collect.Anima = {NightFae = 0, Venthyr = 0, Necrolord = 0, Kyrian = 0} or 0 end
	collect.classColor = classColor
	collect.Name = curCharName --CharInfo.Name --classColor:WrapTextInColorCode(curCharName)
	collect.curServer = curServer --CharInfo.curServer --classColor:WrapTextInColorCode(curServer)
	collect.Class = curClass --CharInfo.Class
	collect.Active = curActivCov --CharInfo.Active
	collect.GUID = curGUID --CharInfo.GUID
	collect.Faction = UnitFactionGroup("PLAYER") --CharInfo.Faction
	collect.UnitLevel = UnitLevel --CharInfo.UnitLevel
	Octo_ToDo_ShadowlandsLevels[curGUID] = Octo_ToDo_ShadowlandsLevels[curGUID] or {}
	Octo_ToDo_ShadowlandsLevels[curGUID][curCovName] = curCovLevel or 0
	Octo_ToDo_ShadowlandsLevels[curGUID].Anima[curCovName] = curAnimaAmount or 0
	--end
end
local function checkCharInfo(CharInfo)
	CharInfo.Name = CharInfo.Name or "NO DATA"
	CharInfo.curServer = CharInfo.curServer or ""
	CharInfo.ilvlStr = CharInfo.ilvlStr or 0
	CharInfo.Kyrian = CharInfo.Kyrian or 0
	CharInfo.Necrolord = CharInfo.Necrolord or 0
	CharInfo.NightFae = CharInfo.NightFae or 0
	CharInfo.Venthyr = CharInfo.Venthyr or 0
	CharInfo.Anima = CharInfo.Anima or {NightFae = 0, Venthyr = 0, Necrolord = 0, Kyrian = 0} or 0
	CharInfo.classColor = CharInfo.classColor or {r = 0.5, g = 0.5, b = 0.5}
	CharInfo.Class = CharInfo.Class or 1
	CharInfo.Faction = CharInfo.Faction or "Horde"
	CharInfo.Active = CharInfo.Active or 0
	CharInfo.UnitLevel = CharInfo.UnitLevel or 1
	CharInfo.SoulCinders = CharInfo.SoulCinders or 0
	CharInfo.SoulAsh = CharInfo.SoulAsh or 0
	CharInfo.Honor = CharInfo.Honor or 0
	CharInfo.CyphersoftheFirstOnes = CharInfo.CyphersoftheFirstOnes or 0
	CharInfo.Conquest = CharInfo.Conquest or 0
	CharInfo.CosmicFlux = CharInfo.CosmicFlux or 0
	CharInfo.Money = CharInfo.Money or 0
	CharInfo.Call1 = CharInfo.Call1 or {}
	CharInfo.Call2 = CharInfo.Call2 or {}
	CharInfo.Call3 = CharInfo.Call3 or {}
	if CharInfo.maslengoZM == nil then CharInfo.maslengoZM = false end
	if CharInfo.maslengoWB == nil then CharInfo.maslengoWB = false end
	if (CharInfo.tmstp or 0) < GetServerTime() then
		CharInfo.tmstp = tmstpDayReset(7)
		CharInfo.maslengoZM = false
		CharInfo.maslengoWB = false
		CharInfo.maslengoanima1k = false
	end
end
function Octo_ToDo_ShadowlandsOnEvent(self, event, ...)
	if event == "COVENANT_CHOSEN" then
		Octo_ToDo_ShadowlandsFrameUpdateValues()
		if Octo_ToDo_ShadowlandsAltFrame:IsShown() then Octo_ToDo_ShadowlandsAddDataToAltFrame() end
		C_Timer.After(1, function()
				Octo_ToDo_ShadowlandsFrameUpdateValues()
				if Octo_ToDo_ShadowlandsAltFrame:IsShown() then Octo_ToDo_ShadowlandsAddDataToAltFrame() end
		end)
		C_Timer.After(3, function()
				Octo_ToDo_ShadowlandsFrameUpdateValues()
				if Octo_ToDo_ShadowlandsAltFrame:IsShown() then Octo_ToDo_ShadowlandsAddDataToAltFrame() end
		end)
	elseif event == "COVENANT_CALLINGS_UPDATED" then
		Callings(...)
		if Octo_ToDo_ShadowlandsAltFrame and Octo_ToDo_ShadowlandsAltFrame:IsShown() then Octo_ToDo_ShadowlandsAddDataToAltFrame() end
	elseif event == "QUEST_LOG_UPDATE" then
		OctoQuestUpdate()
		if Octo_ToDo_ShadowlandsAltFrame and Octo_ToDo_ShadowlandsAltFrame:IsShown() then Octo_ToDo_ShadowlandsAddDataToAltFrame() end
	elseif event == "PLAYER_MONEY" then
		OctoMoneyUpdate()
		if Octo_ToDo_ShadowlandsAltFrame and Octo_ToDo_ShadowlandsAltFrame:IsShown() then Octo_ToDo_ShadowlandsAddDataToAltFrame() end
	elseif event == "COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED" then
		Octo_ToDo_ShadowlandsFrameUpdateValues()
		if Octo_ToDo_ShadowlandsAltFrame:IsShown() then Octo_ToDo_ShadowlandsAddDataToAltFrame() end
		C_Timer.After(1, function()
				Octo_ToDo_ShadowlandsFrameUpdateValues()
				Octo_ToDo_ShadowlandsAddDataToAltFrame()
				if Octo_ToDo_ShadowlandsAltFrame:IsShown() then Octo_ToDo_ShadowlandsAddDataToAltFrame() end
		end)
	elseif event == "CURRENCY_DISPLAY_UPDATE" then
		local currencyID = ...
		if currencyID == 1813 or currencyID == 2009 or currencyID == 1906 or currencyID == 1828 or currencyID == 1979 or currencyID == 1602 or currencyID == 1792 then
			Octo_ToDo_ShadowlandsFrameUpdateValues()
			OctoAllCurrency()
			if Octo_ToDo_ShadowlandsAltFrame:IsShown() then Octo_ToDo_ShadowlandsAddDataToAltFrame() end
		end
	elseif event == "VARIABLES_LOADED" then
		if Octo_ToDo_ShadowlandsLevels == nil then Octo_ToDo_ShadowlandsLevels = {} end
		if Octo_ToDo_ShadowlandsVars == nil then Octo_ToDo_ShadowlandsVars = {} end
		for k, CharInfo in pairs(Octo_ToDo_ShadowlandsLevels) do
			checkCharInfo(CharInfo)
		end
		Octo_ToDo_ShadowlandsFrameUpdateValues()
		C_Timer.After(1, function()
				Octo_ToDo_ShadowlandsCreateAltFrame()
		end)
		local MinimapName = AddonName.."Minimap"
		local ldb_icon = ldb:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = 3528288,
				OnClick = function(_, button)
					Octo_ToDo_ShadowlandsAltFrame:SetShown(not Octo_ToDo_ShadowlandsAltFrame:IsShown())
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, AddonTitle)
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDo_ShadowlandsVars.omb = Octo_ToDo_ShadowlandsVars.omb or {}
		ldbi:Register(MinimapName, ldb_icon, Octo_ToDo_ShadowlandsVars.omb)
		ldbi:Show(MinimapName)
	elseif event == "UNIT_INVENTORY_CHANGED" then
		OctoilvlStr()
		Octo_ToDo_ShadowlandsFrameUpdateValues()
		if Octo_ToDo_ShadowlandsAltFrame and Octo_ToDo_ShadowlandsAltFrame:IsShown() then Octo_ToDo_ShadowlandsAddDataToAltFrame() end
	elseif event == "PLAYER_LOGIN" then
		self:RegisterEvent("QUEST_LOG_UPDATE")
		self:RegisterEvent("PLAYER_MONEY")
		self:RegisterEvent("COVENANT_CALLINGS_UPDATED")
		OctoQuestUpdate()
		OctoMoneyUpdate()
		OctoAllCurrency()
		OctoilvlStr()
		C_CovenantCallings.RequestCallings()
		Callings()
	end
end
Octo_ToDo_ShadowlandsOnLoad()
Octo.SlashCommands["RC"] = function()
	Octo_ToDo_ShadowlandsAltFrame:SetShown()
end
Octo.SlashCommands["rc"] = Octo.SlashCommands["RC"]
-- SLASH_GSEARCH1 = "/gsearch"
-- SlashCmdList.GSEARCH = function(msg)
-- ------print("SEARCH:", msg)
-- for i, n in pairs(_G) do
-- if type(n) == "string" and n:find(msg) then
-- ------print(i, n)
-- end
-- end
-- end
local GOSSIP = CreateFrame("Frame", AddonTitle)
GOSSIP:RegisterEvent("GOSSIP_SHOW")
GOSSIP:SetScript("OnEvent", function(self, event, ...)
		if event == "GOSSIP_SHOW" then
			local UnitID = "TARGET"
			local guid = UnitGUID(UnitID)
			local FirstName = {
				[171787] = true,
				[171821] = true,
				[171795] = true,
				[171589] = true,
			}
			if guid then
				if UnitGUID(UnitID):match("%a+") ~= "Player" then
					local targetNPCID = tonumber(UnitGUID(UnitID):match("-(%d+)-%x+$"), 10)
					if FirstName[targetNPCID] and not IsShiftKeyDown() then
						C_GossipInfo.SelectOption(1)
						StaticPopup_OnClick(StaticPopup1Button1:GetParent(), 1)
					else
						return
					end
				end
			end
		end
end)
--local ColorKyrian = CreateColor(1,1,1,1)
--(KYRIAN_BLUE_COLOR:GetRGB())
--SetAtlas("shadowlands-landingbutton-kyrian-highlight")

