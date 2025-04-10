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
local TrackedFrame
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

function OctoToDo_EventFrame_OCTOREP:CreateTrackedFrame()
	if not TrackedFrame then
		TrackedFrame = CreateFrame("Frame", "TrackedFrame", UIParent, "BackdropTemplate")
	end
	-- TrackedFrame:Hide()
	TrackedFrame:SetBackdrop({
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	TrackedFrame:SetBackdropBorderColor(0, 0, 0, 1)
	TrackedFrame:SetPoint("TOP",0,-120)
	TrackedFrame:SetFrameStrata("HIGH")
	TrackedFrame:SetSize(curWidthTitle, AddonHeight)
	TrackedFrame.BG = TrackedFrame:CreateTexture()
	TrackedFrame.BG:SetAllPoints(TrackedFrame)
	TrackedFrame.BG:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
	TrackedFrame.BG:SetVertexColor(0,0,0,.5)
	TrackedFrame.texture = TrackedFrame:CreateTexture()
	TrackedFrame.texture:SetSize(curWidthTitle, AddonHeight)
	TrackedFrame.texture:SetVertexColor(1,0,0,1)
	TrackedFrame.texture:SetPoint("LEFT", TrackedFrame, "LEFT")
	TrackedFrame.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")

	TrackedFrame.textLEFT = TrackedFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TrackedFrame.textLEFT:SetPoint("LEFT", TrackedFrame, "LEFT", AddonHeight+2, 0)
	TrackedFrame.textLEFT:SetFontObject(OctoFont11)
	TrackedFrame.textLEFT:SetJustifyV("MIDDLE")
	TrackedFrame.textLEFT:SetJustifyH("LEFT")
	TrackedFrame.textLEFT:SetTextColor(1, 1, 1, 1)

	TrackedFrame.textRIGHT = TrackedFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	TrackedFrame.textRIGHT:SetPoint("RIGHT", TrackedFrame, "RIGHT", -4, 0)
	TrackedFrame.textRIGHT:SetFontObject(OctoFont11)
	TrackedFrame.textRIGHT:SetJustifyV("MIDDLE")
	TrackedFrame.textRIGHT:SetJustifyH("RIGHT")
	TrackedFrame.textRIGHT:SetTextColor(1, 1, 1, 1)

end



function OctoToDo_EventFrame_OCTOREP:TrackedFrame_OnEvent()
	local reputationID = OctoToDo_OCTOREP.TrackedRepID or 369
	if reputationID then


	-- frame.first.icon:SetTexture(E.OctoTable_FACTIONTABLE[reputationID].icon)
	TrackedFrame.textLEFT:SetText(E.func_reputationName(reputationID))
	TrackedFrame.textRIGHT:SetText(E.func_CheckReputationByRepID(reputationID))


		local FIRST = select(1, E.func_CheckRepCURSTANDING(reputationID))
		local SECOND = select(2, E.func_CheckRepCURSTANDING(reputationID))
		local color = E.func_GetReputationStandingColor(reputationID)
		TrackedFrame.texture:SetVertexColor(select(1, E.func_hex2rgbNUMBER(color)), select(2, E.func_hex2rgbNUMBER(color)), select(3, E.func_hex2rgbNUMBER(color)), .5)
		if FIRST == 0 then
			TrackedFrame.texture:SetWidth(.1)
		elseif FIRST == SECOND then
			TrackedFrame.texture:SetWidth((curWidthTitle/SECOND)*FIRST)
		elseif FIRST >= 1 then
			TrackedFrame.texture:SetWidth((curWidthTitle/SECOND)*FIRST)
		end
		E:func_SetBackdrop(TrackedFrame, nil, 0, 0)
	end
end








local function OnClick_Second(frame)
	if OctoToDo_MainFrame_OCTOREP:IsDragging() then
		return
	end
	local parent = frame:GetParent()
	local node = parent:GetElementData()
	local reputationID = parent:GetData().reputationID
	if reputationID then
		TrackedFrame:Show()
		-- TrackedFrame:SetShown(not TrackedFrame:IsShown()) -- TOGGLE
		OctoToDo_OCTOREP.TrackedRepID = reputationID
		OctoToDo_EventFrame_OCTOREP:TrackedFrame_OnEvent()
	end
end
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
		frame.second = CreateFrame("BUTTON", nil, frame, "BackDropTemplate")
		frame.second:SetPropagateMouseClicks(true)
		frame.second:SetSize(curWidthTitle, AddonHeight)
		-- frame.second:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.second:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0) -- frame.second:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.second:RegisterForClicks("LeftButtonUp")
		frame.second:SetScript("OnClick", OnClick_Second)
		frame.second:SetScript("OnEnter", function()
				E.func_TooltipOnEnter(frame.second, true, true)
		end)
		frame.second:SetScript("OnLeave", GameTooltip_Hide)
		frame.second.texture = frame.second:CreateTexture()
		frame.second.texture:SetSize(curWidthTitle, AddonHeight)
		frame.second.texture:SetPoint("LEFT", frame.second, "LEFT")
		frame.second.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
		frame.second.textLEFT = frame.second:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.second.textLEFT:SetPoint("LEFT", frame, "LEFT", AddonHeight+2, 0)
		frame.second.textLEFT:SetFontObject(OctoFont11)
		frame.second.textLEFT:SetJustifyV("MIDDLE")
		frame.second.textLEFT:SetJustifyH("LEFT")
		frame.second.textLEFT:SetTextColor(1, 1, 1, 1)
		frame.second.textRIGHT = frame.second:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.second.textRIGHT:SetPoint("RIGHT", frame, "RIGHT", -4, 0)
		frame.second.textRIGHT:SetFontObject(OctoFont11)
		frame.second.textRIGHT:SetJustifyV("MIDDLE")
		frame.second.textRIGHT:SetJustifyH("RIGHT")
		frame.second.textRIGHT:SetTextColor(1, 1, 1, 1)
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
	frame.second.textLEFT:SetText(E.func_reputationName(reputationID))
	frame.second.textRIGHT:SetText(E.func_CheckReputationByRepID(reputationID))
	local FIRST = select(1, E.func_CheckRepCURSTANDING(reputationID))
	local SECOND = select(2, E.func_CheckRepCURSTANDING(reputationID))
	local color = E.func_GetReputationStandingColor(reputationID)
	frame.second.texture:SetVertexColor(select(1, E.func_hex2rgbNUMBER(color)), select(2, E.func_hex2rgbNUMBER(color)), select(3, E.func_hex2rgbNUMBER(color)), .5)
	if FIRST == 0 then
		frame.second.texture:SetWidth(.1)
	elseif FIRST == SECOND then
		frame.second.texture:SetWidth((curWidthTitle/SECOND)*FIRST)
	elseif FIRST >= 1 then
		frame.second.texture:SetWidth((curWidthTitle/SECOND)*FIRST)
	end
	E:func_SetBackdrop(frame.second, nil, 0, 0)
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


function OctoToDo_EventFrame_OCTOREP:func_CheckWTF()
		if OctoToDo_OCTOREP == nil then OctoToDo_OCTOREP = {} end
		if OctoToDo_OCTOREP.TrackedRepID == nil then OctoToDo_OCTOREP.TrackedRepID = 369 end
end


local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_REGEN_DISABLED",
	"UPDATE_FACTION",
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_OCTOREP, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_OCTOREP:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		self.func_CheckWTF()
		----------------------------------------------------------------
		self:OctoToDo_Create_MainFrame_AddonsManager()
		self:func_CreateMyDataProvider()
		self:CreateTrackedFrame()
		----------------------------------------------------------------
		E:func_CreateUtilsButton(OctoToDo_MainFrame_OCTOREP, "OCTOREP")
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


function OctoToDo_EventFrame_OCTOREP:UPDATE_FACTION()
	if TrackedFrame:IsShown() then
		self:TrackedFrame_OnEvent()
	end
end

