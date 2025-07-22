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
local LibQTip = LibStub("LibQTip-2.0") -- Для тултипов
----------------------------------------------------------------
-- Создаем фреймы для работы аддона
local Octo_Event_UtilityFrames = CreateFrame("FRAME") -- Фрейм для обработки событий
Octo_Event_UtilityFrames:Hide()
----------------------------------------------------------------
-- Настройки размеров интерфейса
----------------------------------------------------------------
local AddonHeight = 20 -- Высота одной строки 
----------------------------------------------------------------     
-- Quest functions 
local GetInfo = GetInfo or C_QuestLog.GetInfo
local SetSelectedQuest = SetSelectedQuest or C_QuestLog.SetSelectedQuest
local SetAbandonQuest = SetAbandonQuest or C_QuestLog.SetAbandonQuest
local AbandonQuest = AbandonQuest or C_QuestLog.AbandonQuest 
local GetNumQuestLogEntries = GetNumQuestLogEntries or C_QuestLog.GetNumQuestLogEntries 
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- Helper function to create consistent buttons
local function CreateUtilButton(name, frame, xOffset, texture, func_onEnter, func_onClick)
	local button = CreateFrame("Button", nil, frame)
	button:SetSize(AddonHeight, AddonHeight)
	button:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", xOffset, 0)
	if func_onEnter then
		button:SetScript("OnEnter", function(self)
				button.tooltip = func_onEnter()
				E:func_TooltipOnEnter(button, {"BOTTOM", "TOP"})
		end)
		button:SetScript("OnLeave", function()
				button.tooltip = nil
		end)
	end
	if func_onClick then
		button:SetScript("OnClick", function()
				func_onClick()
				button.tooltip = nil
		end)
	end
	if texture then
		button.icon = button:CreateTexture(nil, "BACKGROUND")
		button.icon:SetTexture(texture)
		button.icon:SetAllPoints()
	end
	return button
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function Octo_Event_UtilityFrames:Octo_CloseButton(frame, addonIconTexture)
	local function func_onEnter()
		local tooltip = {}
		tooltip[#tooltip+1] = {" ", E.WOW_Artifact_Color..CLOSE.."|r", " "}
		return tooltip
	end
	local function func_onClick()
		frame:Hide()
	end
	-- Close Button
	CreateUtilButton(
		"Octo_CloseButton",
		frame,
		0,
		"Interface\\AddOns\\"..GlobalAddonName.."\\Media\\".."CloseTest.tga",
		func_onEnter,
		func_onClick
	)
end
----------------------------------------------------------------
function Octo_Event_UtilityFrames:Octo_OptionsButton(frame, addonIconTexture)
	local function func_onEnter()
		local tooltip = {}
		tooltip[#tooltip+1] = {E.WOW_Artifact_Color..OPTIONS.."|r"}
		return tooltip
	end
	local function func_onClick(frame)
		if frame and frame:IsShown() then
			frame:Hide()
		end
		if SettingsPanel:IsVisible() and frame:IsVisible() then
			HideUIPanel(SettingsPanel)
		else
			Settings.OpenToCategory(E:func_AddonTitle(E.GlobalAddonName), true)
		end
	end
	-- Options Button
	CreateUtilButton(
		"Octo_OptionsButton",
		frame,
		-AddonHeight,
		"Interface\\AddOns\\"..GlobalAddonName.."\\Media\\".."IconTexture\\"..addonIconTexture,
		func_onEnter,
		func_onClick
	)
end
----------------------------------------------------------------
function Octo_Event_UtilityFrames:Octo_AbandonButton(frame, addonIconTexture)
	local function func_onEnter()
		local tooltip = {}
		local numQuests = E:func_CurrentNumQuests()
		if numQuests > 0 then
			tooltip[#tooltip+1] = {E.WOW_Artifact_Color..L["Abandon All Quests"].."|r".." ("..numQuests..")"}
			tooltip[#tooltip+1] = {" ", " "}
			local list = {}
			for i = 1, GetNumQuestLogEntries() do
				local info = GetInfo(i)
				if info and info.questID ~= 0 and not info.isHeader and not info.isHidden then
					table.insert(list, info.questID)
				end
			end
			table.sort(list, E.func_Reverse_order)
			for _, questID in ipairs(list) do
				tooltip[#tooltip+1] = {E:func_questName(questID), E:func_CheckCompletedByQuestID(questID)}
			end
		else
			tooltip[#tooltip+1] = {E.classColorHexCurrent..L["No quests"].."|r"}
		end
		return tooltip
	end
	-- Abandon Button
	local function f_AbandonQuests()
		local numQuests = E:func_CurrentNumQuests()
		for i = 1, GetNumQuestLogEntries() do
			if numQuests ~= 0 then
				local info = GetInfo(i)
				if info and not info.isHeader and not info.isHidden then
					DEFAULT_CHAT_FRAME:AddMessage(E:func_Gradient(L["Abandon: "])..E:func_questName(info.questID))
					SetSelectedQuest(info.questID)
					SetAbandonQuest()
					AbandonQuest()
				end
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage(E:func_Gradient(L["Total"]).." "..E.Green_Color..numQuests.."|r")
	end
	StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
		text = E.WOW_Artifact_Color..L["Abandon All Quests"].."?|r",
		button1 = YES,
		button2 = NO,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function() C_Timer.After(1, f_AbandonQuests) end,
	}
	local function func_onClick()
		if E:func_CurrentNumQuests() > 0 then
			StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
		end
	end
	CreateUtilButton(
		"Octo_AbandonButton",
		frame,
		-AddonHeight*2,
		"Interface\\AddOns\\"..GlobalAddonName.."\\Media\\".."Arrow72.tga",
		func_onEnter,
		func_onClick
	)
end
----------------------------------------------------------------
function Octo_Event_UtilityFrames:Octo_EventsButton(frame, addonIconTexture)
	local function func_onEnter()
		local tooltip = {}
		local curdatetable = date("*t")
		local curdate = FormatShortDate(curdatetable.day, curdatetable.month, curdatetable.year)
		tooltip[#tooltip+1] = {E.WOW_Artifact_Color..L["Current Date"].."|r", E.WOW_Artifact_Color..curdate.."|r"}
		tooltip[#tooltip+1] = {" ", " "}
		local sorted = {}
		for k in pairs(E.Holiday) do
			table.insert(sorted, k)
		end
		table.sort(sorted, function(a, b)
				return E.Holiday[a].priority < E.Holiday[b].priority
		end)
		for _, eventID in ipairs(sorted) do
			local v = E.Holiday[eventID]
			local titleText = v.invitedBy..E:func_texturefromIconEVENT(v.iconTexture)
			local timeText = v.startTime.." - "..v.endTime
			if v.Active then
				titleText = titleText..E.Green_Color..v.title.."|r"..E.White_Color.." ("..v.ENDS..")|r"
				timeText = E.Green_Color..timeText.."|r"
			else
				titleText = titleText..E.Gray_Color..v.title.."|r"
				timeText = E.Gray_Color..timeText.."|r"
			end
			if E.DebugIDs then
				titleText = titleText..E.Gray_Color.." id:"..eventID.."|r"
			end
			tooltip[#tooltip+1] = {titleText, timeText}
		end
		if #sorted == 0 then
			tooltip[#tooltip+1] = {"No Data"}
		end
		tooltip[#tooltip+1] = {" ", " "}
		return tooltip
	end
	local function func_onClick()
		frame:Hide()
		if fpde then
			fpde(E.Holiday)
		end
	end
	-- Events Button
	CreateUtilButton(
		"Octo_EventsButton",
		frame,
		-AddonHeight*3,
		"Interface\\AddOns\\"..GlobalAddonName.."\\Media\\".."Arrow6.tga",
		func_onEnter,
		func_onClick
	)
end
----------------------------------------------------------------
function Octo_Event_UtilityFrames:Octo_FramerateFrame(frame, addonIconTexture)
	-- Framerate Frame
	local Octo_FramerateFrame = CreateFrame("Frame", nil, frame)
	Octo_FramerateFrame:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -AddonHeight*4, 0)
	Octo_FramerateFrame:SetSize(AddonHeight*2, AddonHeight)
	Octo_FramerateFrame:SetFrameStrata("HIGH")
	local text_fps = Octo_FramerateFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	text_fps:SetPoint("CENTER")
	text_fps:SetFontObject(OctoFont11)
	text_fps:SetJustifyH("CENTER")
	text_fps:SetTextColor(0.31, 1, 0.47, 1)
	Octo_FramerateFrame.text_fps = text_fps
	C_Timer.NewTicker(1, function()
			text_fps:SetText(math.floor(GetFramerate()))
	end)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E:func_CreateUtilsButton(frame, addonIconTexture)
	Octo_Event_UtilityFrames:Octo_CloseButton(frame, addonIconTexture)
	Octo_Event_UtilityFrames:Octo_OptionsButton(frame, addonIconTexture)
	Octo_Event_UtilityFrames:Octo_AbandonButton(frame, addonIconTexture)
	Octo_Event_UtilityFrames:Octo_EventsButton(frame, addonIconTexture)
	Octo_Event_UtilityFrames:Octo_FramerateFrame(frame, addonIconTexture)
end
----------------------------------------------------------------
-- Регистрация событий
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED", -- Загрузка аддона
	-- "PLAYER_LOGIN", -- Вход игрока
}
E:func_RegisterMyEventsToFrames(Octo_Event_UtilityFrames, MyEventsTable)
-- Обработчик события загрузки аддона
function Octo_Event_UtilityFrames:ADDON_LOADED(addonName)
	if addonName ~= GlobalAddonName then return end
	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	-- Создаем элементы интерфейса
	C_Timer.After(0, function()
		if Octo_MainFrame_ToDo then E:func_CreateUtilsButton(Octo_MainFrame_ToDo, "ToDo") end
		if Octo_MainFrame_Achievements then E:func_CreateUtilsButton(Octo_MainFrame_Achievements, "Achievements") end
		if Octo_MainFrame_AddonsManager then E:func_CreateUtilsButton(Octo_MainFrame_AddonsManager, "AddonsManager") end
		if Octo_MainFrame_QuestsChanged then E:func_CreateUtilsButton(Octo_MainFrame_QuestsChanged, "QuestsChanged") end
	end)
end