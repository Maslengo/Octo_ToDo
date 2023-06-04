local GlobalAddonName, engine = ...
local AddonTitle = GetAddOnMetadata(GlobalAddonName, "Title")
local Version = GetAddOnMetadata(GlobalAddonName, "Version")
print(AddonTitle.." v"..Version.." loaded")

local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local Octo_ToDo_DragonflyAltFrame, EventFrame = nil, nil
local ColorKyrianR, ColorKyrianG, ColorKyrianB, ColorKyrianA = 111/255, 168/255, 220/255, 1
local ColorNecrolordR, ColorNecrolordG, ColorNecrolordB, ColorNecrolordA = 147/255, 196/255, 125/255, 1
local ColorNightFaeR, ColorNightFaeG, ColorNightFaeB, ColorNightFaeA = 142/255, 124/255, 195/255 , 1
local ColorVenthyrR, ColorVenthyrG, ColorVenthyrB, ColorVenthyrA = 224/255, 102/255, 102/255, 1
local _, className, curClass = UnitClass("PLAYER")
local classColor = C_ClassColor.GetClassColor(className)
local r,g,b = classColor:GetRGB()
local curWidth, curHeight = 80, 20 --ширина 45, высота 45 24
local curWidthTitle = curWidth*1.5
local curFontTTF, curFontSize13, curFontOutline = [[Interface\Addons\Octo_ToDo_Dragonfly\Media\font\01 Octo.TTF]], 11, "OUTLINE"
local curFontSize11 = 11
local curFontTest1,curFontTest2,curFontTest3 = [[Interface\Addons\Octo_ToDo_Dragonfly\Media\font\01 Octo.TTF]], curFontSize11, curFontOutline
local TotalLines = 23
local grayR,grayG,grayB,grayA = 0.5,0.5,0.5,1
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
local CovenantNames ={[1] = "Kyrian",[2] = "Venthyr",[3] = "NightFae",[4] = "Necrolord",}
local TotalTransAnima = 0
local TotalMoney = 0
local curMoney = 0
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


local function tmstpDayReset(n)
	n = n or 1
	local thursdayReset = GetCurrentRegion() == 3 and thursdayResetDay0EU or thursdayResetDay0US
	local currTime = GetServerTime()
	return (math.ceil((currTime - thursdayReset)/(daytime*n))*daytime*n)+thursdayReset
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

function Octo_ToDo_DragonflyOnLoad()
    EventFrame = CreateFrame("FRAME", nil)
    EventFrame:RegisterEvent("VARIABLES_LOADED")
    EventFrame:RegisterEvent("COVENANT_CHOSEN")
    EventFrame:RegisterEvent("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
    EventFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
    EventFrame:RegisterEvent("PLAYER_LOGIN")
    EventFrame:RegisterEvent("PLAYER_MONEY")
    EventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")
    EventFrame:SetScript("OnEvent", function(...) Octo_ToDo_DragonflyOnEvent(...) end)
end

function Octo_ToDo_DragonflyCreateAltFrame()
    Octo_ToDo_DragonflyAltFrame = CreateFrame("BUTTON", nil, UIParent, "BackdropTemplate")
    Octo_ToDo_DragonflyAltFrame:SetClampedToScreen(true)
    Octo_ToDo_DragonflyAltFrame:SetFrameStrata("TOOLTIP")
    Octo_ToDo_DragonflyAltFrame:SetPoint("CENTER", 0, 0)
    Octo_ToDo_DragonflyAltFrame:SetBackdrop({
            bgFile = "Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\background\\Square_White.tga",
            edgeFile = "Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\border\\01 Octo.tga",
            edgeSize = 1,
    })
    Octo_ToDo_DragonflyAltFrame:SetBackdropColor(14/255, 14/255, 14/255, 0.80)
    Octo_ToDo_DragonflyAltFrame:SetScript("OnShow", function() Octo_ToDo_DragonflyAddDataToAltFrame()
    end)
    Octo_ToDo_DragonflyAltFrame:EnableMouse(true)
    Octo_ToDo_DragonflyAltFrame:SetMovable(true)
    Octo_ToDo_DragonflyAltFrame:RegisterForDrag("LeftButton")
    Octo_ToDo_DragonflyAltFrame:SetScript("OnDragStart", Octo_ToDo_DragonflyAltFrame.StartMoving)
    Octo_ToDo_DragonflyAltFrame:SetScript("OnDragStop", function() Octo_ToDo_DragonflyAltFrame:StopMovingOrSizing() end)
    Octo_ToDo_DragonflyAltFrame:RegisterForClicks("RightButtonUp")
    Octo_ToDo_DragonflyAltFrame:SetScript("OnClick", function(self) self:Hide() end)
    Octo_ToDo_DragonflyAltFrame:SetScript("OnKeyDown", function(self, key)
            if key == GetBindingKey("TOGGLEGAMEMENU") then
                self:Hide()
                self:SetPropagateKeyboardInput(false)
            else self:SetPropagateKeyboardInput(true)
            end
    end)
    Octo_ToDo_DragonflyAltFrame.CloseButton = CreateFrame("Button", nil, Octo_ToDo_DragonflyAltFrame, "BackDropTemplate")
    Octo_ToDo_DragonflyAltFrame.CloseButton:SetSize(curHeight, curHeight)
    Octo_ToDo_DragonflyAltFrame.CloseButton:SetPoint("TOPRIGHT", Octo_ToDo_DragonflyAltFrame, "TOPRIGHT", curHeight, 0)
    Octo_ToDo_DragonflyAltFrame.CloseButton:SetBackdrop({ edgeFile = "Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\border\\01 Octo.tga", edgeSize = 1})
    Octo_ToDo_DragonflyAltFrame.CloseButton:SetBackdropBorderColor(1, 0, 0, 0)
    Octo_ToDo_DragonflyAltFrame.CloseButton:SetScript("OnEnter", function(self)
            self:SetBackdropBorderColor(1, 0, 0, 1)
            self.icon:SetVertexColor(1,0,0,1)
    end)
    Octo_ToDo_DragonflyAltFrame.CloseButton:SetScript("OnLeave", function(self)
            self:SetBackdropBorderColor(1, 0, 0, 0)
            self.icon:SetVertexColor(1,1,1,1)
    end)
    Octo_ToDo_DragonflyAltFrame.CloseButton:SetScript("OnMouseDown", function(self)
            self:SetBackdropBorderColor(1, 0, 0, 0.5)
            self.icon:SetVertexColor(1,0,0,0.5)
    end)
    Octo_ToDo_DragonflyAltFrame.CloseButton:SetScript("OnClick", function()
            Octo_ToDo_DragonflyAltFrame:Hide()
    end)
    local t = Octo_ToDo_DragonflyAltFrame.CloseButton:CreateTexture(nil,"BACKGROUND")
    Octo_ToDo_DragonflyAltFrame.CloseButton.icon = t
    t:SetTexture("Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\close.tga")
    t:SetVertexColor(1,1,1,1)
    t:SetAllPoints(Octo_ToDo_DragonflyAltFrame.CloseButton)
    
    local toyID1 = 172924
    local PlayerHasToy = PlayerHasToy(toyID1)
    if PlayerHasToy == false then
        local itemName = GetItemInfo(toyID1)
        Octo_ToDo_DragonflyAltFrame.WormholeButton = CreateFrame("Button", nil, Octo_ToDo_DragonflyAltFrame, "SecureActionButtonTemplate") --"SecureActionButtonTemplate" "BackDropTemplate"
        Octo_ToDo_DragonflyAltFrame.WormholeButton:SetSize(curHeight, curHeight)
        Octo_ToDo_DragonflyAltFrame.WormholeButton:SetPoint("BOTTOMRIGHT", Octo_ToDo_DragonflyAltFrame, "BOTTOMRIGHT", curHeight, 0)
        Octo_ToDo_DragonflyAltFrame.WormholeButton:SetAttribute("type", "macro")
        Octo_ToDo_DragonflyAltFrame.WormholeButton:SetAttribute("macrotext",[[/use item:172924]])
        Octo_ToDo_DragonflyAltFrame.WormholeButton:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
                GameTooltip:ClearLines()
                GameTooltip:SetToyByItemID(172924)
                GameTooltip:Show()
                self.icon:SetVertexColor(1,1,1,1)
        end)
        Octo_ToDo_DragonflyAltFrame.WormholeButton:SetScript("OnLeave", function(self)
                GameTooltip:ClearLines()
                GameTooltip:Hide()
                self.icon:SetVertexColor(1,1,1,1)
        end)
        Octo_ToDo_DragonflyAltFrame.WormholeButton:HookScript("OnMouseDown", function(self)
                self.icon:SetVertexColor(1,1,1,0.5)
        end)
        local t = Octo_ToDo_DragonflyAltFrame.WormholeButton:CreateTexture(nil,"BACKGROUND")
        Octo_ToDo_DragonflyAltFrame.WormholeButton.icon = t
        t:SetTexture("Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\inv_engineering_90_wormholegenerator.tga")
        t:SetVertexColor(1,1,1,1)
        t:SetAllPoints(Octo_ToDo_DragonflyAltFrame.WormholeButton)
    end
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    local function FrameLine_OnEnter(self) self.BG:SetColorTexture(grayR,grayG,grayB,.4) end
    local function FrameLine_OnLeave(self) self.BG:SetColorTexture(0,0,0,0) end
    for i = 0, TotalLines do
        local fname, f
        if i ~= 0 then
            fname = "FrameLine"..i
            Octo_ToDo_DragonflyAltFrame[fname] = CreateFrame("Frame", nil, Octo_ToDo_DragonflyAltFrame)
            f = Octo_ToDo_DragonflyAltFrame[fname]
            f:SetHeight(curHeight)
            f:SetPoint("TOPLEFT", Octo_ToDo_DragonflyAltFrame, "TOPLEFT", 0, -curHeight*i)
            f:SetPoint("RIGHT")
            f:SetScript("OnEnter", FrameLine_OnEnter)
            f:SetScript("OnLeave", FrameLine_OnLeave)
            f:SetMouseClickEnabled(false)
            f.BG = f:CreateTexture(nil, "BACKGROUND")
            f.BG:SetHeight(curHeight)
            f.BG:SetAllPoints()
        end
        fname = "TextLeft"..i
        Octo_ToDo_DragonflyAltFrame[fname] = Octo_ToDo_DragonflyAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        f = Octo_ToDo_DragonflyAltFrame[fname]
        f:SetSize(curWidthTitle, curHeight)
        f:SetPoint("TOPLEFT", Octo_ToDo_DragonflyAltFrame, "TOPLEFT", 6, -curHeight*i)
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
        if i == 16 then f:SetText("|T629056:16:16:::64:64:4:60:4:60|t 3kREP") end
		if i == 17 then f:SetText("|T1603189:16:16:::64:64:4:60:4:60|t Feast") end 

		if i == 18 then f:SetText("|T3528312:16:16:::64:64:4:60:4:60|t WB") end
        if i == 19 then f:SetText(" ") end --Call1
        if i == 20 then f:SetText(" ") end --Call2
        if i == 21 then f:SetText(" ") end --Call3
        --if i == 22 then f:SetText("Line21") end
        if i == 23 then f:SetText(" ") end
    end
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Octo_ToDo_DragonflyAddDataToAltFrame()
    Octo_ToDo_DragonflyAltFrame:Hide()
end

function OctoQuestUpdate()
    local curActivCov = C_Covenants.GetActiveCovenantID()
    local UnitLevel = UnitLevel("PLAYER")
    --if curActivCov == 0 --[[or UnitLevel < 60]] then return end
    local curGUID = UnitGUID("PLAYER")
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    local questID_3kREP = 72068
    local maslengo_3kREP = ""
    --сделан
    if C_QuestLog.IsQuestFlaggedCompleted(questID_3kREP) == true then maslengo_3kREP = (DONE)
        --можно сдать
    elseif C_QuestLog.IsComplete(questID_3kREP) == true then maslengo_3kREP = " >>> МОЖНО СДАТЬ <<<"
        --не сделан и нет квеста
    elseif C_QuestLog.IsQuestFlaggedCompleted(questID_3kREP) == false and C_QuestLog.IsOnQuest(questID_3kREP) == false then maslengo_3kREP = (NONE)
        --есть кв и нельзя сдать
    elseif C_QuestLog.IsOnQuest(questID_3kREP) == true and C_QuestLog.IsComplete(questID_3kREP) == false then
        local objectives = C_QuestLog.GetQuestObjectives(questID_3kREP)
        if objectives == nil then return "" end
        local OBJF1 = "" local OBJR1 = "" local C1 = " |cFFFF5771" local R1 = "|r"
        local OBJF2 = "" local OBJR2 = "" local C2 = " |cFFFF5771" local R2 = "|r"
        local OBJF3 = "" local OBJR3 = "" local C3 = " |cFFFF5771" local R3 = "|r"
        local OBJF4 = "" local OBJR4 = "" local C4 = " |cFFFF5771" local R4 = "|r"
        local OBJF5 = "" local OBJR5 = "" local C5 = " |cFFFF5771" local R5 = "|r"
        if objectives[1] == nil then OBJF1 = "" OBJR1 = "" else if objectives[1].numFulfilled == objectives[1].numRequired then OBJF1 = "|cff4FFF79done|r" OBJR1 = "" else if objectives[1].numFulfilled >= 0 then OBJF1 = objectives[1].numFulfilled.."/" OBJR1 = objectives[1].numRequired end end end
        if OBJF1 == OBJR1 then C1 = "|cff4FFF79" end
        if objectives[2] == nil then OBJF2 = "" OBJR2 = "" else if objectives[2].numFulfilled == objectives[2].numRequired then OBJF2 = "|cff4FFF79done|r" OBJR2 = "" else if objectives[2].numFulfilled >= 0 then OBJF2 = objectives[2].numFulfilled.."/" OBJR2 = objectives[2].numRequired end end end
        if OBJF2 == OBJR2 then C2 = "|cff4FFF79" end
        if objectives[3] == nil then OBJF3 = "" OBJR3 = "" else if objectives[3].numFulfilled == objectives[3].numRequired then OBJF3 = "|cff4FFF79done|r" OBJR3 = "" else if objectives[3].numFulfilled >= 0 then OBJF3 = objectives[3].numFulfilled.."/" OBJR3 = objectives[3].numRequired end end end
        if OBJF3 == OBJR3 then C3 = "|cff4FFF79" end
        if objectives[4] == nil then OBJF4 = "" OBJR4 = "" else if objectives[4].numFulfilled == objectives[4].numRequired then OBJF4 = "|cff4FFF79done|r" OBJR4 = "" else if objectives[4].numFulfilled >= 0 then OBJF4 = objectives[4].numFulfilled.."/" OBJR4 = objectives[4].numRequired end end end
        if OBJF4 == OBJR4 then C4 = "|cff4FFF79" end
        if objectives[5] == nil then OBJF5 = "" OBJR5 = "" else if objectives[5].numFulfilled == objectives[5].numRequired then OBJF5 = "|cff4FFF79done|r" OBJR5 = "" else if objectives[5].numFulfilled >= 0 then OBJF5 = objectives[5].numFulfilled.."/" OBJR5 = objectives[5].numRequired end end end
        if OBJF5 == OBJR5 then C5 = "|cff4FFF79" end
        
        if objectives then
            if objectives[5] then
                maslengo_3kREP = "|cffFFFF00"..objectives[5].numFulfilled .. "/" .. objectives[5].numRequired.."|r"
            elseif objectives[4] then
                maslengo_3kREP = "|cffFFFF00"..objectives[4].numFulfilled .. "/" .. objectives[4].numRequired.."|r"
            elseif objectives[3] then
                maslengo_3kREP = "|cffFFFF00"..objectives[3].numFulfilled .. "/" .. objectives[3].numRequired.."|r"
            elseif objectives[2] then
                maslengo_3kREP = "|cffFFFF00"..objectives[2].numFulfilled .. "/" .. objectives[2].numRequired.."|r"
            elseif objectives[1] then
                maslengo_3kREP = "|cffFFFF00"..objectives[1].numFulfilled .. "/" .. objectives[1].numRequired.."|r"
            end
        end
    end
	
	
	
    --local questID_3kREP = 72068
	--local maslengo_3kREP = ""
	--if C_QuestLog.IsComplete(questID_3kREP) == true then maslengo_3kREP = 100 
	--elseif C_QuestLog.IsQuestFlaggedCompleted(questID_3kREP) == true then maslengo_Feast = true
	
	
	
	--end
    --local maslengo_3kREP = C_QuestLog.IsQuestFlaggedCompleted(questID_3kREP)
   -- if maslengo_3kREP == false and C_QuestLog.IsOnQuest(questID_3kREP) then
    --    local objectives = C_QuestLog.GetQuestObjectives(questID_3kREP)
   --     if objectives and objectives[2] then
   --         maslengo_3kREP = "|cffFFFF00"..objectives[2].numFulfilled .. "/" .. objectives[2].numRequired.."|r"
   --     end
   -- end
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    local questID_Feast = 70893
    local maslengo_Feast = ""
    --сделан
    if C_QuestLog.IsQuestFlaggedCompleted(questID_Feast) == true then maslengo_Feast = (DONE)
        --можно сдать
    elseif C_QuestLog.IsComplete(questID_Feast) == true then maslengo_Feast = " >>> МОЖНО СДАТЬ <<<"
        --не сделан и нет квеста
    elseif C_QuestLog.IsQuestFlaggedCompleted(questID_Feast) == false and C_QuestLog.IsOnQuest(questID_Feast) == false then maslengo_Feast = (NONE)
        --есть кв и нельзя сдать
    elseif C_QuestLog.IsOnQuest(questID_Feast) == true and C_QuestLog.IsComplete(questID_Feast) == false then
        local objectives = C_QuestLog.GetQuestObjectives(questID_Feast)
        if objectives == nil then return "" end
        local OBJF1 = "" local OBJR1 = "" local C1 = " |cFFFF5771" local R1 = "|r"
        local OBJF2 = "" local OBJR2 = "" local C2 = " |cFFFF5771" local R2 = "|r"
        local OBJF3 = "" local OBJR3 = "" local C3 = " |cFFFF5771" local R3 = "|r"
        local OBJF4 = "" local OBJR4 = "" local C4 = " |cFFFF5771" local R4 = "|r"
        local OBJF5 = "" local OBJR5 = "" local C5 = " |cFFFF5771" local R5 = "|r"
        if objectives[1] == nil then OBJF1 = "" OBJR1 = "" else if objectives[1].numFulfilled == objectives[1].numRequired then OBJF1 = "|cff4FFF79done|r" OBJR1 = "" else if objectives[1].numFulfilled >= 0 then OBJF1 = objectives[1].numFulfilled.."/" OBJR1 = objectives[1].numRequired end end end
        if OBJF1 == OBJR1 then C1 = "|cff4FFF79" end
        if objectives[2] == nil then OBJF2 = "" OBJR2 = "" else if objectives[2].numFulfilled == objectives[2].numRequired then OBJF2 = "|cff4FFF79done|r" OBJR2 = "" else if objectives[2].numFulfilled >= 0 then OBJF2 = objectives[2].numFulfilled.."/" OBJR2 = objectives[2].numRequired end end end
        if OBJF2 == OBJR2 then C2 = "|cff4FFF79" end
        if objectives[3] == nil then OBJF3 = "" OBJR3 = "" else if objectives[3].numFulfilled == objectives[3].numRequired then OBJF3 = "|cff4FFF79done|r" OBJR3 = "" else if objectives[3].numFulfilled >= 0 then OBJF3 = objectives[3].numFulfilled.."/" OBJR3 = objectives[3].numRequired end end end
        if OBJF3 == OBJR3 then C3 = "|cff4FFF79" end
        if objectives[4] == nil then OBJF4 = "" OBJR4 = "" else if objectives[4].numFulfilled == objectives[4].numRequired then OBJF4 = "|cff4FFF79done|r" OBJR4 = "" else if objectives[4].numFulfilled >= 0 then OBJF4 = objectives[4].numFulfilled.."/" OBJR4 = objectives[4].numRequired end end end
        if OBJF4 == OBJR4 then C4 = "|cff4FFF79" end
        if objectives[5] == nil then OBJF5 = "" OBJR5 = "" else if objectives[5].numFulfilled == objectives[5].numRequired then OBJF5 = "|cff4FFF79done|r" OBJR5 = "" else if objectives[5].numFulfilled >= 0 then OBJF5 = objectives[5].numFulfilled.."/" OBJR5 = objectives[5].numRequired end end end
        if OBJF5 == OBJR5 then C5 = "|cff4FFF79" end
        
        if objectives then
            if objectives[5] then
                maslengo_Feast = "|cffFFFF00"..objectives[5].numFulfilled .. "/" .. objectives[5].numRequired.."|r"
            elseif objectives[4] then
                maslengo_Feast = "|cffFFFF00"..objectives[4].numFulfilled .. "/" .. objectives[4].numRequired.."|r"
            elseif objectives[3] then
                maslengo_Feast = "|cffFFFF00"..objectives[3].numFulfilled .. "/" .. objectives[3].numRequired.."|r"
            elseif objectives[2] then
                maslengo_Feast = "|cffFFFF00"..objectives[2].numFulfilled .. "/" .. objectives[2].numRequired.."|r"
            elseif objectives[1] then
                maslengo_Feast = "|cffFFFF00"..objectives[1].numFulfilled .. "/" .. objectives[1].numRequired.."|r"
            end
        end
    end
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    local questIDWB = 65143
    local maslengoWB = C_QuestLog.IsQuestFlaggedCompleted(questIDWB)
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Octo_ToDo_DragonflyLevels[curGUID] = Octo_ToDo_DragonflyLevels[curGUID] or {}
    local collect = Octo_ToDo_DragonflyLevels[curGUID]
	collect.maslengo_3kREP = maslengo_3kREP
	collect.maslengo_Feast = maslengo_Feast
    collect.maslengoWB = maslengoWB
    
    
end

function OctoMoneyUpdate()
    --local curActivCov = C_Covenants.GetActiveCovenantID() --ВЫКЛ
    --local UnitLevel = UnitLevel("PLAYER") --ВЫКЛ
    --if curActivCov == 0 --[[or UnitLevel < 60]] then return end --ВЫКЛ
    local curGUID = UnitGUID("PLAYER")
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    local Money = GetMoney()/10000
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Octo_ToDo_DragonflyLevels[curGUID] = Octo_ToDo_DragonflyLevels[curGUID] or {}
    local collect = Octo_ToDo_DragonflyLevels[curGUID]
    collect.Money = Money
end

function OctoAllCurrency()
    --local curActivCov = C_Covenants.GetActiveCovenantID() --ВЫКЛ
    --local UnitLevel = UnitLevel("PLAYER") --ВЫКЛ
    --if curActivCov == 0 --[[or UnitLevel < 60]] then return end --ВЫКЛ
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
    Octo_ToDo_DragonflyLevels[curGUID] = Octo_ToDo_DragonflyLevels[curGUID] or {}
    local collect = Octo_ToDo_DragonflyLevels[curGUID]
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
    --if curActivCov == 0 --[[or UnitLevel < 60]] then return end --ВЫКЛ
    local curGUID = UnitGUID("PLAYER")
    ------------------------------------------------------------------------------------------------------------------------
    local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel()
    --local ilvlStr = format("|cff%s%.1f|r",avgItemLevelEquipped >= 213 and "00ff00" or avgItemLevelEquipped >= 200 and "ffff00" or "ff0000",avgItemLevelEquipped)
    local ilvlStr = avgItemLevelEquipped or 0
    ------------------------------------------------------------------------------------------------------------------------
    Octo_ToDo_DragonflyLevels[curGUID] = Octo_ToDo_DragonflyLevels[curGUID] or {}
    local collect = Octo_ToDo_DragonflyLevels[curGUID]
    collect.ilvlStr = ilvlStr or 0
end

function Octo_ToDo_DragonflyAddDataToAltFrame()
    local curGUID = UnitGUID("PLAYER")
    local otstyp = 7
    local UnitLevel = UnitLevel("PLAYER")
    Octo_ToDo_DragonflyAltFrame.AllCharFrames = {}
    local sorted = {}
    for curCharGUID, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
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
        if not Octo_ToDo_DragonflyAltFrame[curCharGUID] then
            Octo_ToDo_DragonflyAltFrame[curCharGUID] = CreateFrame("FRAME", nil, Octo_ToDo_DragonflyAltFrame)
            CurCharFrame = Octo_ToDo_DragonflyAltFrame[curCharGUID]
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
            CurCharFrame = Octo_ToDo_DragonflyAltFrame[curCharGUID]
        end
        ------------------------------------------------------------------------------------------------------------------------
        CharInfo.GUID = curCharGUID
        if CharInfo.Anima == nil then CharInfo.Anima = {NightFae = 0, Venthyr = 0, Necrolord = 0, Kyrian = 0} end
        CurCharFrame:SetSize(curWidth, curHeight)
        Octo_ToDo_DragonflyAltFrame:SetBackdropBorderColor(0, 0, 0, 1)
        Octo_ToDo_DragonflyAltFrame:SetBackdropColor(14/255, 14/255, 14/255, 0.80)
        if #Octo_ToDo_DragonflyAltFrame.AllCharFrames == 0 then CurCharFrame:SetPoint("TOPRIGHT", 0, 0)
        else CurCharFrame:SetPoint("TOPRIGHT", Octo_ToDo_DragonflyAltFrame.AllCharFrames[#Octo_ToDo_DragonflyAltFrame.AllCharFrames], "TOPLEFT", 0, 0) end
        Octo_ToDo_DragonflyAltFrame.AllCharFrames[#Octo_ToDo_DragonflyAltFrame.AllCharFrames + 1] = CurCharFrame
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
        --if curServer == CharInfo.curServer and CharInfo.Money ~= 0 then curMoney = CharInfo.Money end
        --------print (TotalMoney + curMoney, TotalMoney, curMoney, CharInfo.Name, CharInfo.curServer)

        --TotalMoney = TotalMoney + curMoney
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
                edgeFile = "Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\border\\01 Octo.tga", --Interface/Addons/Octo_ToDo_Dragonfly/Media/border/01 Octo.tga --Interface/Buttons/white8x8
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
        CurCharFrame.DeleteButton:SetScript("OnClick", function() Octo_ToDo_DragonflyDeleteChar(curCharGUID) end)
        local t = CurCharFrame.DeleteButton:CreateTexture(nil,"BACKGROUND")
        CurCharFrame.DeleteButton.icon = t
        t:SetTexture("Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\close.tga")
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
        CurCharFrame.CenterLines16:SetText(CharInfo.maslengo_3kREP or NONE)
        --16
        CurCharFrame.CenterLines17:SetText(CharInfo.maslengo_Faest or NONE)
        --17
        --[[CurCharFrame.CenterLines17:SetText("NO DATA")
        if CharInfo.maslengo_Feast == nil then
            CurCharFrame.CenterLines17:SetText("NO DATA")
        elseif CharInfo.maslengo_Feast then
            if type(CharInfo.questID_Feast) == "number" then --100
                if CharInfo.maslengo_Feast == 100 then
                    CurCharFrame.CenterLines17:SetText("Можно сдать") --true
                    CurCharFrame.CenterLines17:SetTextColor(0,69, 0,38, 1,00, 1) --AF61FF фиолетовый
                else
                    CurCharFrame.CenterLines17:SetText(CharInfo.maslengo_Feast.."%") --сейчас выполняется в %
                    CurCharFrame.CenterLines17:SetTextColor(1, 1, 0, 1) --желтый
                    CurCharFrame.CenterLines17:SetFont(curFontTTF, curFontSize13, curFontOutline)
                end
            else
                CurCharFrame.CenterLines17:SetText(DONE)
                CurCharFrame.CenterLines17:SetTextColor(0, 1, 0, 1)
            end
        else
            CurCharFrame.CenterLines17:SetText(NONE)
            CurCharFrame.CenterLines17:SetTextColor(1, 0, 0, 1)
        end]]
        
        
        --18
        CurCharFrame.CenterLines18:SetText(CharInfo.maslengoWB and DONE or NONE)
        if CharInfo.maslengoWB then CurCharFrame.CenterLines18:SetTextColor(0,1,0,1) else CurCharFrame.CenterLines18:SetTextColor(1,0,0,1) end
        
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
    
    Octo_ToDo_DragonflyAltFrame.TextLeft0:SetText("|T3528288:16:16:::64:64:4:60:4:60|t ".."|cff00A3FF"..CompactNumberFormat(TotalTransAnima).."|r") --Line0? TotalTransAnima
    Octo_ToDo_DragonflyAltFrame.TextLeft22:SetText("|T133784:16:16:::64:64:4:60:4:60|t ".."|cffFFF371"..curServerShort..": "..CompactNumberFormat(TotalMoney).."|r") --Line21 Money
    
    local curAltFrameWidth = #Octo_ToDo_DragonflyAltFrame.AllCharFrames * curWidth/2
    Octo_ToDo_DragonflyAltFrame:SetSize(curAltFrameWidth*2+curWidthTitle, curHeight*(TotalLines+1)) --Width ширина, Height высота pizda ПИЗДА
end



function Octo_ToDo_DragonflyDeleteChar(curGUID)
    Octo_ToDo_DragonflyLevels[curGUID] = nil
    for X, Y in pairs(Octo_ToDo_DragonflyAltFrame.AllCharFrames) do
        if Y == Octo_ToDo_DragonflyAltFrame[curGUID] then
            Octo_ToDo_DragonflyAltFrame.AllCharFrames[X].parent = nil
            Octo_ToDo_DragonflyAltFrame.AllCharFrames[X]:Hide()
            Octo_ToDo_DragonflyAltFrame.AllCharFrames[X] = nil
        end
    end
    Octo_ToDo_DragonflyAddDataToAltFrame()
end

function Octo_ToDo_DragonflyFrameUpdateValues()
    local curGUID = UnitGUID("PLAYER")
    local curCovID = C_Covenants.GetActiveCovenantID()
    local UnitLevel = UnitLevel("PLAYER")
    local curActivCov = C_Covenants.GetActiveCovenantID()
    --if curCovID ~= nil and curCovID ~= 0 --[[and UnitLevel >= 60]] then
    local collect = Octo_ToDo_DragonflyLevels[curGUID] or 0
    local curCovName = CovenantNames[curCovID] or 0
    local curCovLevel = C_CovenantSanctumUI.GetRenownLevel() or 0
    local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1813) or 0 --Запасенная анима
    local curAnimaAmount = currencyInfo.quantity or 0
    
    
    
    if not collect.NightFae or collect.NightFae == nil  then collect.NightFae = 0 end 
    if not collect.Venthyr then collect.Venthyr = 0 end
    if not collect.Necrolord then collect.Necrolord = 0 end
    if not collect.Kyrian then collect.Kyrian = 0 end
    if collect.Anima == nil then collect.Anima = {NightFae = 0, Venthyr = 0, Necrolord = 0, Kyrian = 0} or 0 end
    collect.classColor = classColor or {r = 0.5, g = 0.5, b = 0.5}
    collect.Name = curCharName --CharInfo.Name --classColor:WrapTextInColorCode(curCharName)
    collect.curServer = curServer --CharInfo.curServer --classColor:WrapTextInColorCode(curServer)
    collect.Class = curClass --CharInfo.Class
    collect.Active = curActivCov --CharInfo.Active
    collect.GUID = curGUID --CharInfo.GUID
    collect.Faction = UnitFactionGroup("PLAYER") --CharInfo.Faction
    collect.UnitLevel = UnitLevel --CharInfo.UnitLevel
    
    
    Octo_ToDo_DragonflyLevels[curGUID] = Octo_ToDo_DragonflyLevels[curGUID] or {}
    
    Octo_ToDo_DragonflyLevels[curGUID][curCovName] = curCovLevel or 0
    Octo_ToDo_DragonflyLevels[curGUID].Anima[curCovName] = curAnimaAmount or 0
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
	if CharInfo.maslengo_Feast == nil then CharInfo.maslengo_Feast = false end
	if CharInfo.maslengoWB == nil then CharInfo.maslengoWB = false end
	if (CharInfo.tmstp or 0) < GetServerTime() then
		CharInfo.tmstp = tmstpDayReset(7)
		CharInfo.maslengo_Feast = false
		CharInfo.maslengoWB = false
		CharInfo.maslengo_3kREP = false
	end
end

function Octo_ToDo_DragonflyOnEvent(self, event, ...)
	if event == "COVENANT_CHOSEN" then
		Octo_ToDo_DragonflyFrameUpdateValues()
		if Octo_ToDo_DragonflyAltFrame:IsShown() then Octo_ToDo_DragonflyAddDataToAltFrame() end
		C_Timer.After(1, function()
				Octo_ToDo_DragonflyFrameUpdateValues()
				if Octo_ToDo_DragonflyAltFrame:IsShown() then Octo_ToDo_DragonflyAddDataToAltFrame() end
		end)
		C_Timer.After(3, function()
				Octo_ToDo_DragonflyFrameUpdateValues()
				if Octo_ToDo_DragonflyAltFrame:IsShown() then Octo_ToDo_DragonflyAddDataToAltFrame() end
		end)
	--elseif event == "COVENANT_CALLINGS_UPDATED" then
	--Callings(...)
	if Octo_ToDo_DragonflyAltFrame and Octo_ToDo_DragonflyAltFrame:IsShown() then Octo_ToDo_DragonflyAddDataToAltFrame() end
	elseif event == "QUEST_LOG_UPDATE" then
		OctoQuestUpdate()
		if Octo_ToDo_DragonflyAltFrame and Octo_ToDo_DragonflyAltFrame:IsShown() then Octo_ToDo_DragonflyAddDataToAltFrame() end
	elseif event == "PLAYER_MONEY" then
		OctoMoneyUpdate()
		if Octo_ToDo_DragonflyAltFrame and Octo_ToDo_DragonflyAltFrame:IsShown() then Octo_ToDo_DragonflyAddDataToAltFrame() end
	elseif event == "COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED" then
		Octo_ToDo_DragonflyFrameUpdateValues()
		if Octo_ToDo_DragonflyAltFrame:IsShown() then Octo_ToDo_DragonflyAddDataToAltFrame() end
		C_Timer.After(1, function()
				Octo_ToDo_DragonflyFrameUpdateValues()
				Octo_ToDo_DragonflyAddDataToAltFrame()
				if Octo_ToDo_DragonflyAltFrame:IsShown() then Octo_ToDo_DragonflyAddDataToAltFrame() end
		end)
	elseif event == "CURRENCY_DISPLAY_UPDATE" then
		local currencyID = ...
		if currencyID == 1813 or currencyID == 2009 or currencyID == 1906 or currencyID == 1828 or currencyID == 1979 or currencyID == 1602 or currencyID == 1792 then
			Octo_ToDo_DragonflyFrameUpdateValues()
			OctoAllCurrency()
			if Octo_ToDo_DragonflyAltFrame:IsShown() then Octo_ToDo_DragonflyAddDataToAltFrame() end
		end
	elseif event == "VARIABLES_LOADED" then
		if Octo_ToDo_DragonflyLevels == nil then Octo_ToDo_DragonflyLevels = {} end
		if Octo_ToDo_DragonflyVars == nil then Octo_ToDo_DragonflyVars = {} end

		for k, CharInfo in pairs(Octo_ToDo_DragonflyLevels) do
			checkCharInfo(CharInfo)
		end
		--Octo_ToDo_DragonflyFrameUpdateValues()
		C_Timer.After(1, function()
				Octo_ToDo_DragonflyCreateAltFrame()
		end)
		local MinimapName = GlobalAddonName.."Minimap"
		local ldb_icon = ldb:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = 3528288,
				OnClick = function(_, button)
					Octo_ToDo_DragonflyAltFrame:SetShown(not Octo_ToDo_DragonflyAltFrame:IsShown())
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
		Octo_ToDo_DragonflyVars.omb = Octo_ToDo_DragonflyVars.omb or {}
		ldbi:Register(MinimapName, ldb_icon, Octo_ToDo_DragonflyVars.omb)
		ldbi:Show(MinimapName)
	elseif event == "UNIT_INVENTORY_CHANGED" then
		OctoilvlStr()
		Octo_ToDo_DragonflyFrameUpdateValues()
		if Octo_ToDo_DragonflyAltFrame and Octo_ToDo_DragonflyAltFrame:IsShown() then Octo_ToDo_DragonflyAddDataToAltFrame() end
	elseif event == "PLAYER_LOGIN" then
		Octo_ToDo_DragonflyFrameUpdateValues()
		self:RegisterEvent("QUEST_LOG_UPDATE")
		self:RegisterEvent("PLAYER_MONEY")
		--self:RegisterEvent("COVENANT_CALLINGS_UPDATED")
		OctoQuestUpdate()
		OctoMoneyUpdate()
		OctoAllCurrency()
		OctoilvlStr()
		--C_CovenantCallings.RequestCallings()
		--Callings()
	end
end

Octo_ToDo_DragonflyOnLoad()
Octo.SlashCommands["RC"] = function()
	Octo_ToDo_DragonflyAltFrame:SetShown()
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
--SetAtlas("Dragonfly-landingbutton-kyrian-highlight")