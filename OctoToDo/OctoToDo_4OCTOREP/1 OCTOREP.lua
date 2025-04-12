local GlobalAddonName, E = ...
local OctoToDo_EventFrame_OCTOREP = CreateFrame("FRAME")
OctoToDo_EventFrame_OCTOREP:Hide()
local OctoToDo_MainFrame_OCTOREP = CreateFrame("BUTTON", "OctoToDo_MainFrame_OCTOREP", UIParent, "BackdropTemplate")
OctoToDo_MainFrame_OCTOREP:Hide()
tinsert(E.OctoTable_Frames, OctoToDo_MainFrame_OCTOREP)
----------------------------------------------------------------
local AddonHeight = 20 -- Высота -- OctoToDo_DB_Vars.curHeight
local AddonLeftFrameWeight = 200 -- Ширина Левого -- OctoToDo_DB_Vars.AddonLeftFrameWeight
local AddonCentralFrameWeight = 90 -- Ширина Центрального -- OctoToDo_DB_Vars.AddonCentralFrameWeight
local MainFrameDefaultLines = 30
local MainFrameTotalLines = E.func_GetNumReps() -- math.floor((math.floor(select(2, GetPhysicalScreenSize()) / AddonHeight))*.7)
if MainFrameDefaultLines > MainFrameTotalLines then
	MainFrameDefaultLines = MainFrameTotalLines
end
local SFDropDownWeight = 100
----------------------------------------------------------------






local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
----------------------------------------------------------------
local sorted = {}
----------------------------------------------------------------


local function func_NumPlayers()
	local ShowOnlyCurrentServer = OctoToDo_DB_Vars.ShowOnlyCurrentServer
	local ShowOnlyCurrentBattleTag = OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
	local LevelToShow = OctoToDo_DB_Vars.LevelToShow
	local LevelToShowMAX = OctoToDo_DB_Vars.LevelToShowMAX
	local itemLevelToShow = OctoToDo_DB_Vars.itemLevelToShow
	sorted = {}
	for curCharGUID, CharInfo in next, (OctoToDo_DB_Levels) do
		if ShowOnlyCurrentBattleTag == true then
			if (ShowOnlyCurrentServer == true
				and (CharInfo.curServer == E.curServer)
				and (CharInfo.BattleTagLocal == E.BattleTagLocal)
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (ShowOnlyCurrentServer == false
				and (CharInfo.BattleTagLocal == E.BattleTagLocal)
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (E.curGUID == CharInfo.GUID) then
				sorted[#sorted+1] = CharInfo
			end
		else
			if ((ShowOnlyCurrentServer == true and (CharInfo.curServer == E.curServer))
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (ShowOnlyCurrentServer == false
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (E.curGUID == CharInfo.GUID) then
				sorted[#sorted+1] = CharInfo
			end
		end
	end
	return #sorted or 1
end
----------------------------------------------------------------
-- /dump C_Reputation.GetWatchedFactionData()
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function OnClick_Second(frame)
	if OctoToDo_MainFrame_OCTOREP:IsDragging() then
		return
	end
	local parent = frame:GetParent()
	local node = parent:GetElementData()
	local reputationID = parent:GetData().reputationID
	if reputationID then
		OctoToDo_OCTOREP.TrackedRepID = reputationID
	end
end
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ / CALLBACK
----------------------------------------------------------------
local function func_OnAcquired(owner, frame, data, new)
	if new then
		frame.first = CreateFrame("FRAME", nil, frame, "BackDropTemplate")
		frame.first:SetPropagateMouseClicks(false)
		frame.first:SetSize(AddonLeftFrameWeight, AddonHeight)
		frame.first:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.first.textLEFT = frame.first:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		-- frame.first.textLEFT:SetPoint("LEFT", frame, "LEFT", 2, 0)
		frame.first.textLEFT:SetPoint("LEFT", 2, 0)
		frame.first.textLEFT:SetPoint("RIGHT", 0, 0)
		frame.first.textLEFT:SetFontObject(OctoFont11)
		frame.first.textLEFT:SetWordWrap(false)
		frame.first.textLEFT:SetJustifyV("MIDDLE")
		frame.first.textLEFT:SetJustifyH("LEFT")
		frame.first.textLEFT:SetTextColor(1, 1, 1, 1)
		frame.second = setmetatable({}, {
				__index = function(self, key)
					local f = CreateFrame("BUTTON", "frame"..key, frame, "BackDropTemplate")
					f:SetPropagateMouseClicks(true)
					f:SetSize(AddonCentralFrameWeight, AddonHeight)
					f:SetPoint("TOPLEFT", frame, "TOPLEFT", (AddonLeftFrameWeight-AddonCentralFrameWeight)+AddonCentralFrameWeight*key, 0)
					f:RegisterForClicks("LeftButtonUp")
					f:SetScript("OnClick", OnClick_Second)
					f.texture = f:CreateTexture()
					f.texture:SetSize(AddonCentralFrameWeight, AddonHeight)
					f.texture:SetPoint("LEFT", f, "LEFT")
					f.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
					f.textCENT = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
					f.textCENT:SetPoint("CENTER", f, "CENTER", 0, 0)
					f.textCENT:SetFontObject(OctoFont11)
					f.textCENT:SetJustifyV("MIDDLE")
					f.textCENT:SetJustifyH("CENTER")
					f.textCENT:SetTextColor(1, 1, 1, 1)
					self[key] = f
					return f
		end})
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ (АПДЕЙТ)
function OctoToDo_EventFrame_OCTOREP:OctoToDo_Frame_init(frame, node)
	local data = node:GetData()




	E:func_SetBackdrop(frame.first, nil, 0, 0)
	frame.first.textLEFT:SetText(E.func_reputationName(data.reputationID))
	for i = 1, #data.zxc.vivod do
		if data.zxc.vivod[i] ~= "" then
			frame.second[i].textCENT:SetText(data.zxc.vivod[i])
			-- E:func_SetBackdrop(frame.second[i], "|cff00FF00", E.bgCaOverlay*2, 0)
		else
			frame.second[i].textCENT:SetText("")
			-- E:func_SetBackdrop(frame.second[i], nil, 0, 0)
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
end
function OctoToDo_EventFrame_OCTOREP:OctoToDo_Create_MainFrame_AddonsManager()
	OctoToDo_MainFrame_OCTOREP:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*func_NumPlayers(), AddonHeight*MainFrameDefaultLines)
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
			OctoToDo_MainFrame_OCTOREP:SetAlpha(E.bgCa/2)
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
	func_NumPlayers()
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local resetFunc = function(_, self) self:Hide() end
	local initFunc = function(self)
			self:SetSize(AddonCentralFrameWeight, AddonHeight)
			self.text = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			self.text:SetPoint("CENTER", self, "CENTER", 0, 0)
			self.text:SetFontObject(OctoFont11)
			self.text:SetJustifyV("MIDDLE")
			self.text:SetJustifyH("CENTER")
			self.text:SetTextColor(1, 1, 1, 1)
	end
	OctoToDo_MainFrame_OCTOREP.pool = CreateFramePool("FRAME", OctoToDo_MainFrame_OCTOREP, "BackdropTemplate", resetFunc, false, initFunc)
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	self:func_CreateMyDataProvider()
end
function OctoToDo_EventFrame_OCTOREP:func_CreateMyDataProvider()
	C_Reputation.ExpandAllFactionHeaders()
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local DataProvider = CreateTreeDataProvider()
	for reputationID, v in next, (E.OctoTable_FACTIONTABLE) do -- OctoTable_FACTIONTABLE
		local zxc = {}
		zxc.FIRST = {}
		zxc.SECOND = {}
		zxc.vivod = {}
		zxc.color = {}
		zxc.standingTEXT = {}
		for CharIndex, CharInfo in ipairs(sorted) do
			zxc.FIRST[CharIndex] = CharInfo.MASLENGO.reputationFULL[reputationID].FIRST or ""
			zxc.SECOND[CharIndex] = CharInfo.MASLENGO.reputationFULL[reputationID].SECOND or ""
			zxc.vivod[CharIndex] = CharInfo.MASLENGO.reputationFULL[reputationID].vivod or ""
			zxc.color[CharIndex] = CharInfo.MASLENGO.reputationFULL[reputationID].color or ""
			zxc.standingTEXT[CharIndex] = CharInfo.MASLENGO.reputationFULL[reputationID].standingTEXT or ""
		end
		local groupNode = DataProvider:Insert({
				reputationID = reputationID,
				zxc = zxc,

		})
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	OctoToDo_MainFrame_OCTOREP:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*func_NumPlayers(), AddonHeight*MainFrameDefaultLines)
	OctoToDo_MainFrame_OCTOREP.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	----------------------------------------------------------------
	--------------------------- POOL -------------------------------
	----------------------------------------------------------------
	OctoToDo_MainFrame_OCTOREP.pool:ReleaseAll()
	for count, CharInfo in next, (sorted) do
		local curCharFrame = OctoToDo_MainFrame_OCTOREP.pool:Acquire()
		curCharFrame:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_OCTOREP, "TOPLEFT", (AddonLeftFrameWeight-AddonCentralFrameWeight)+(AddonCentralFrameWeight*count), 0)
		curCharFrame.text:SetText(CharInfo.classColorHex .. CharInfo.Name .. "|r")
		if CharInfo.Faction == "Horde" then
			E:func_SetBackdrop(curCharFrame, "|cfff01e38", E.bgCaOverlay*2, 0)
		else
			E:func_SetBackdrop(curCharFrame, "|cff0070DD", E.bgCaOverlay*2, 0)
		end
		curCharFrame:Show()
	end
	----------------------------------------------------------------
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
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_OCTOREP, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_OCTOREP:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if OctoToDo_DB_Vars.AddonHeight then
			AddonHeight = OctoToDo_DB_Vars.AddonHeight
		end
		if OctoToDo_DB_Vars.AddonLeftFrameWeight then
			AddonLeftFrameWeight = OctoToDo_DB_Vars.AddonLeftFrameWeight
		end
		if OctoToDo_DB_Vars.AddonCentralFrameWeight then
			AddonCentralFrameWeight = OctoToDo_DB_Vars.AddonCentralFrameWeight
		end
		if OctoToDo_DB_Vars.MainFrameDefaultLines then
			MainFrameDefaultLines = OctoToDo_DB_Vars.MainFrameDefaultLines
		end
		if OctoToDo_DB_Vars.SFDropDownWeight then
			SFDropDownWeight = OctoToDo_DB_Vars.SFDropDownWeight
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		self:func_CheckWTF()
		----------------------------------------------------------------
		self:OctoToDo_Create_MainFrame_AddonsManager()
		self:func_CreateMyDataProvider()
		----------------------------------------------------------------
		E:func_CreateUtilsButton(OctoToDo_MainFrame_OCTOREP, "OCTOREP", AddonHeight, AddonHeight)
		E:func_CreateMinimapButton(GlobalAddonName, "OCTOREP", OctoToDo_OCTOREP, OctoToDo_MainFrame_OCTOREP, nil, "OctoToDo_MainFrame_OCTOREP")
		----------------------------------------------------------------
		OctoToDo_MainFrame_OCTOREP:SetScript("OnShow", function()
				OctoToDo_EventFrame_OCTOREP:func_CreateMyDataProvider() -- ПОФИКСИТЬ (HAS ANY CHANGE)
		end)
	end
end
----------------------------------------------------------------
function OctoToDo_EventFrame_OCTOREP:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_OCTOREP and OctoToDo_MainFrame_OCTOREP:IsShown() then
		OctoToDo_MainFrame_OCTOREP:Hide()
	end
end
