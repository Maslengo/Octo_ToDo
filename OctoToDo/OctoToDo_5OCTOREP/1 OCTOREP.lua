local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
----------------------------------------------------------------
local OctoToDo_EventFrame_OCTOREP = CreateFrame("FRAME")
OctoToDo_EventFrame_OCTOREP:Hide()
----------------------------------------------------------------
local AddonHeight = 20 --ADDON_BUTTON_HEIGHT -- Высота -- OctoToDo_DB_Vars.curHeight
local curWidthTitle = 500 -- Ширина Левого -- OctoToDo_DB_Vars.curWidthTitle
local MainFrameNumLines = 40 --MAX_ADDONS_DISPLAYED
local totalNumAddOns = E.func_GetNumAddOns()
if MainFrameNumLines > totalNumAddOns then
	MainFrameNumLines = totalNumAddOns
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ / CALLBACK
----------------------------------------------------------------
local function func_OnAcquired(owner, frame, data, new)
	if new then
		frame.first = CreateFrame("BUTTON", nil, frame, "BackDropTemplate")
		frame.first:SetPropagateMouseClicks(false)
		frame.first:SetSize(AddonHeight, AddonHeight)
		frame.first:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.first.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.first.icon:SetAllPoints(frame.first)
		-- frame.first.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		frame.third = CreateFrame("BUTTON", nil, frame, "BackDropTemplate")
		frame.third:SetPropagateMouseClicks(true)
		frame.third:SetSize(curWidthTitle, AddonHeight)
		-- frame.third:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.third:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0) -- frame.third:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.third:SetScript("OnEnter", function()
				E.func_TooltipOnEnter(frame.third, true, true)
		end)
		frame.third:SetScript("OnLeave", GameTooltip_Hide)
		frame.third.texture = frame.third:CreateTexture()
		frame.third.texture:SetSize(curWidthTitle, AddonHeight)
		frame.third.texture:SetPoint("LEFT", frame.third, "LEFT")
		frame.third.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
		frame.third.textLEFT = frame.third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.third.textLEFT:SetPoint("LEFT", frame, "LEFT", AddonHeight+2, 0)
		frame.third.textLEFT:SetFontObject(OctoFont11)
		frame.third.textLEFT:SetJustifyV("MIDDLE")
		frame.third.textLEFT:SetJustifyH("LEFT")
		frame.third.textLEFT:SetTextColor(1, 1, 1, 1)
		frame.third.textRIGHT = frame.third:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.third.textRIGHT:SetPoint("RIGHT", frame, "RIGHT", -4, 0)
		frame.third.textRIGHT:SetFontObject(OctoFont11)
		frame.third.textRIGHT:SetJustifyV("MIDDLE")
		frame.third.textRIGHT:SetJustifyH("RIGHT")
		frame.third.textRIGHT:SetTextColor(1, 1, 1, 1)
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ + ГОВНО
-- ЭТО ФУНКЦИЯ АПДЕЙТА(ОТРИСОФКИ)
function OctoToDo_EventFrame_OCTOREP:OctoToDo_Frame_init(frame, node)
	local data = node:GetData()
	local reputationID = data.reputationID
	frame.first.icon:SetTexture(E.OctoTable_FACTIONTABLE[reputationID].icon)
	frame.third.textLEFT:SetText(E.func_reputationName(reputationID))
	frame.third.textRIGHT:SetText(E.func_CheckReputationByRepID(reputationID))
	local FIRST = select(1, E.func_CheckRepCURSTANDING(reputationID))
	local SECOND = select(2, E.func_CheckRepCURSTANDING(reputationID))
	local color = E.func_GetReputationStandingColor(reputationID)
	local r = select(1, E.func_hex2rgbNUMBER(color))
	local g = select(2, E.func_hex2rgbNUMBER(color))
	local b = select(3, E.func_hex2rgbNUMBER(color))
	frame.third.texture:SetVertexColor(r, g, b, .5)
	if FIRST == 0 then
		frame.third.texture:SetWidth(.1)
	elseif FIRST == SECOND then
		frame.third.texture:SetWidth((curWidthTitle/SECOND)*FIRST)
	elseif FIRST >= 1 then
		frame.third.texture:SetWidth((curWidthTitle/SECOND)*FIRST)
	end
end
function OctoToDo_EventFrame_OCTOREP:OctoToDo_Create_MainFrame_AddonsManager()
	local OctoToDo_MainFrame_OCTOREP = CreateFrame("BUTTON", "OctoToDo_MainFrame_OCTOREP", UIParent, "BackdropTemplate")
	tinsert(E.OctoTable_Frames, OctoToDo_MainFrame_OCTOREP)
	OctoToDo_MainFrame_OCTOREP:SetSize(curWidthTitle, AddonHeight*MainFrameNumLines)
	OctoToDo_MainFrame_OCTOREP:Hide()
	OctoToDo_MainFrame_OCTOREP:SetDontSavePosition(true)
	OctoToDo_MainFrame_OCTOREP:SetClampedToScreen(false)
	OctoToDo_MainFrame_OCTOREP:SetFrameStrata("HIGH")
	OctoToDo_MainFrame_OCTOREP:SetPoint("CENTER", 0, 0)
	OctoToDo_MainFrame_OCTOREP:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	OctoToDo_MainFrame_OCTOREP:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoToDo_MainFrame_OCTOREP:SetBackdropBorderColor(0, 0, 0, 1)
	OctoToDo_MainFrame_OCTOREP:EnableMouse(true)
	OctoToDo_MainFrame_OCTOREP:SetMovable(true)
	OctoToDo_MainFrame_OCTOREP:RegisterForDrag("LeftButton")
	OctoToDo_MainFrame_OCTOREP:SetScript("OnDragStart", function()
			OctoToDo_MainFrame_OCTOREP:SetAlpha(E.bgCa)
			OctoToDo_MainFrame_OCTOREP:StartMoving()
	end)
	OctoToDo_MainFrame_OCTOREP:SetScript("OnDragStop", function()
			OctoToDo_MainFrame_OCTOREP:SetAlpha(1)
			OctoToDo_MainFrame_OCTOREP:StopMovingOrSizing()
	end)
	OctoToDo_MainFrame_OCTOREP:RegisterForClicks("RightButtonUp") -- ПОФИКСИТЬ (ДОБАВИТЬ ОПЦИЮ ЛОКА)
	OctoToDo_MainFrame_OCTOREP:SetScript("OnClick", function(self) self:Hide() end)
	OctoToDo_MainFrame_OCTOREP.ScrollBox = CreateFrame("FRAME", nil, OctoToDo_MainFrame_OCTOREP, "WowScrollBoxList")
	OctoToDo_MainFrame_OCTOREP.ScrollBox:SetAllPoints()
	OctoToDo_MainFrame_OCTOREP.ScrollBox:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_OCTOREP.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_OCTOREP.ScrollBox:Layout()
	OctoToDo_MainFrame_OCTOREP.ScrollBar = CreateFrame("EventFrame", nil, OctoToDo_MainFrame_OCTOREP, "MinimalScrollBar")
	OctoToDo_MainFrame_OCTOREP.ScrollBar:SetPoint("TOPLEFT", OctoToDo_MainFrame_OCTOREP.ScrollBox, "TOPRIGHT", 6, 0)
	OctoToDo_MainFrame_OCTOREP.ScrollBar:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_OCTOREP.ScrollBox, "BOTTOMRIGHT", 6, 0)
	OctoToDo_MainFrame_OCTOREP.view = CreateScrollBoxListTreeListView()
	OctoToDo_MainFrame_OCTOREP.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_OCTOREP.view:SetElementInitializer("BackdropTemplate",
		function(...)
			self:OctoToDo_Frame_init(...)
	end)
	OctoToDo_MainFrame_OCTOREP.view:RegisterCallback(OctoToDo_MainFrame_OCTOREP.view.Event.OnAcquiredFrame, func_OnAcquired, OctoToDo_MainFrame_OCTOREP) -- ПОФИКСИТЬ
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame_OCTOREP.ScrollBox, OctoToDo_MainFrame_OCTOREP.ScrollBar, OctoToDo_MainFrame_OCTOREP.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame_OCTOREP.ScrollBox, OctoToDo_MainFrame_OCTOREP.ScrollBar) -- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	----------------------------------------------------------------
end
function OctoToDo_EventFrame_OCTOREP:func_CreateMyDataProvider()
	local DataProvider = CreateTreeDataProvider()
	C_Reputation.ExpandAllFactionHeaders()
	local list = {}
	-- for reputationHEADER, tbl in next, (OCTO_DB_reputations_test) do
	-- 	for reputationID, config in next, (tbl) do
	-- 		tinsert(list, reputationID)
	-- 	end
	-- end


	for reputationID, v in next, (E.OctoTable_FACTIONTABLE) do
		tinsert(list, reputationID)
	end




	sort(list, E.func_Reverse_order)
	for index, reputationID in ipairs(list) do
		local groupNode = DataProvider:Insert({reputationID = reputationID})
	end
	OctoToDo_MainFrame_OCTOREP.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
end
----------------------------------------------------------------
-- ДОЛЖНА ВЫЗЫВАТЬСЯ 1 РАЗ
function OctoToDo_EventFrame_OCTOREP:CollectAllAddonsSFMICT()
end
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_REGEN_DISABLED",
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_OCTOREP, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_OCTOREP:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		OctoToDo_OCTOREP = OctoToDo_OCTOREP or {}
		self:OctoToDo_Create_MainFrame_AddonsManager()
		self:func_CreateMyDataProvider()
		----------------------------------------------------------------
		E:func_CreateUtilsButton(OctoToDo_MainFrame_OCTOREP, GlobalAddonName)
		E:func_CreateMinimapButton(GlobalAddonName, "OCTOREP", OctoToDo_OCTOREP, OctoToDo_MainFrame_OCTOREP, nil, "OctoToDo_MainFrame_OCTOREP")
		----------------------------------------------------------------
	end
end
----------------------------------------------------------------
function OctoToDo_EventFrame_OCTOREP:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_OCTOREP and OctoToDo_MainFrame_OCTOREP:IsShown() then
		OctoToDo_MainFrame_OCTOREP:Hide()
	end
end