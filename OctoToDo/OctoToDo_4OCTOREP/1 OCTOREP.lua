local GlobalAddonName, E = ...
local OctoToDo_EventFrame_OCTOREP = CreateFrame("FRAME")
OctoToDo_EventFrame_OCTOREP:Hide()
local OctoToDo_MainFrame_OCTOREP = CreateFrame("BUTTON", "OctoToDo_MainFrame_OCTOREP", UIParent, "BackdropTemplate")
OctoToDo_MainFrame_OCTOREP:Hide()
tinsert(E.OctoTable_Frames, OctoToDo_MainFrame_OCTOREP)
----------------------------------------------------------------
local AddonHeight = 20
local AddonLeftFrameWeight = 200
local AddonCentralFrameWeight = 90
local MainFrameDefaultLines = 30
local MainFrameTotalLines = E.func_GetNumReps() -- math.floor((math.floor(select(2, GetPhysicalScreenSize()) / AddonHeight))*.7)
if MainFrameDefaultLines > MainFrameTotalLines then
	MainFrameDefaultLines = MainFrameTotalLines
end
local SFDropDownWeight = 100
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
----------------------------------------------------------------
----------------------------------------------------------------
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
		frame.full = CreateFrame("FRAME", nil, frame, "BackDropTemplate")
		frame.full:SetPropagateMouseClicks(true)
		frame.full:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight)
		frame.full:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		E:func_SetBackdrop(frame.full, nil, 0, 0)
		-- frame.full:SetFrameStrata("BACKGROUND")
		frame.full.texture = frame.full:CreateTexture(nil, "BACKGROUND", nil, 3)
		frame.full.texture:SetAllPoints()
		frame.full.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
		frame.full.texture:SetVertexColor(1, 1, 1, 0)
		frame.full.texture:HookScript("OnEnter", function() frame.full.texture:SetVertexColor(1, 1, 1, .1) end)
		frame.full.texture:HookScript("OnLeave", function() frame.full.texture:SetVertexColor(1, 1, 1, 0) end)
		frame.full.texture:SetPropagateMouseClicks(true)
		frame.first = CreateFrame("FRAME", nil, frame, "BackDropTemplate")
		frame.first:SetPropagateMouseClicks(true)
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
					f.texture = f:CreateTexture(nil, "BACKGROUND", nil, 2)
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

	if data.repHeader then
		frame.first.textLEFT:SetText(data.repHeader)
	else
		frame.first.textLEFT:SetText(E.func_reputationName(data.reputationID))
	end
	if not data.zxc then return end
	for i = 1, #data.zxc.vivod do
		if data.reputationID and data.zxc.vivod[i] ~= "" then
			local text = data.zxc.vivod[i]
			local FIRST = data.zxc.FIRST[i]
			local SECOND = data.zxc.SECOND[i]
			local color = data.zxc.color[i]
			frame.second[i].textCENT:SetText(text)
			local r, g, b = E.func_hex2rgbNUMBER(color)
			frame.second[i].texture:SetVertexColor(r, g, b, E.bgCaOverlay*3)
			if FIRST == 0 then
				frame.second[i].texture:SetWidth(.1)
			elseif FIRST == SECOND then
				frame.second[i].texture:SetWidth(AddonCentralFrameWeight)
			elseif FIRST >= 1 then
				frame.second[i].texture:SetWidth((AddonCentralFrameWeight/SECOND)*FIRST)
			end
		else
			frame.second[i].textCENT:SetText("")
			frame.second[i].texture:SetVertexColor(0, 0, 0, 0)
		end
		if data.zxc.currentChar[i] then
			E:func_SetBackdrop(frame.second[i], E.classColorHexCurrent, E.bgCaOverlay, 0)
		end
	end
end
function OctoToDo_EventFrame_OCTOREP:OctoToDo_Create_MainFrame_AddonsManager()
	OctoToDo_MainFrame_OCTOREP:SetPoint("CENTER", 0, 0)
	OctoToDo_MainFrame_OCTOREP:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight*MainFrameDefaultLines)
	OctoToDo_MainFrame_OCTOREP:SetDontSavePosition(true)
	OctoToDo_MainFrame_OCTOREP:SetClampedToScreen(false)
	OctoToDo_MainFrame_OCTOREP:SetFrameStrata("HIGH")
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
	OctoToDo_MainFrame_OCTOREP.view = CreateScrollBoxListTreeListView(0)
	OctoToDo_MainFrame_OCTOREP.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_OCTOREP.view:SetElementInitializer("BackdropTemplate",
		function(...)
			self:OctoToDo_Frame_init(...)
	end)
	OctoToDo_MainFrame_OCTOREP.view:RegisterCallback(OctoToDo_MainFrame_OCTOREP.view.Event.OnAcquiredFrame, func_OnAcquired, OctoToDo_MainFrame_OCTOREP) -- ПОФИКСИТЬ
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame_OCTOREP.ScrollBox, OctoToDo_MainFrame_OCTOREP.ScrollBar, OctoToDo_MainFrame_OCTOREP.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame_OCTOREP.ScrollBox, OctoToDo_MainFrame_OCTOREP.ScrollBar) -- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	E.func_NumPlayers()
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
-- ДОЛЖНА ВЫЗЫВАТЬСЯ 1 РАЗ
-- local reputationList = CollectRepList()


function OctoToDo_EventFrame_OCTOREP:func_CreateMyDataProvider()
	----------------------------------------------------------------
	local numlines = 0
	local DataProvider = CreateTreeDataProvider()


	for _, tbl in ipairs(E.OctoTable_Reputations) do
		numlines = numlines + 1
		local groupNodeFirst = DataProvider:Insert({
				repHeader = tbl.header,
		})
		for _, v in ipairs(tbl) do
			if OctoToDo_DB_Config.ReputationDB[v.id] == true then
				numlines = numlines + 1
				local zxc = {}
				zxc.FIRST = {}
				zxc.SECOND = {}
				zxc.vivod = {}
				zxc.color = {}
				zxc.standingTEXT = {}

				zxc.currentChar = {}

				for CharIndex, CharInfo in ipairs(E.sorted()) do
					zxc.FIRST[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].FIRST or ""
					zxc.SECOND[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].SECOND or ""
					zxc.vivod[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].vivod or ""
					zxc.color[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].color or ""
					zxc.standingTEXT[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].standingTEXT or ""

					zxc.currentChar[CharIndex] = CharInfo.GUID == E.curGUID
				end
				local groupNodeSecondary = groupNodeFirst:Insert({
						reputationID = v.id,
						zxc = zxc,
				})
			end
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	MainFrameDefaultLines = numlines
	if MainFrameDefaultLines > OctoToDo_DB_Vars.MainFrameDefaultLines then
		MainFrameDefaultLines = OctoToDo_DB_Vars.MainFrameDefaultLines
	end
	if MainFrameDefaultLines < 1 then MainFrameDefaultLines = 1 end
	OctoToDo_MainFrame_OCTOREP:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight*MainFrameDefaultLines)
	OctoToDo_MainFrame_OCTOREP.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	----------------------------------------------------------------
	--------------------------- POOL -------------------------------
	----------------------------------------------------------------
	OctoToDo_MainFrame_OCTOREP.pool:ReleaseAll()
	for count, CharInfo in next, (E.sorted()) do
		local curCharFrame = OctoToDo_MainFrame_OCTOREP.pool:Acquire()
		curCharFrame:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_OCTOREP, "TOPLEFT", (AddonLeftFrameWeight-AddonCentralFrameWeight)+(AddonCentralFrameWeight*count), 0)
		curCharFrame.text:SetText(E.func_vivodCent(CharInfo))
		if CharInfo.Faction == "Horde" then
			E:func_SetBackdrop(curCharFrame, "|cfff01e38", E.bgCaOverlay*2, 0)
		else
			E:func_SetBackdrop(curCharFrame, "|cff0070DD", E.bgCaOverlay*2, 0)
		end
		curCharFrame:SetScript("OnEnter", function()
				E.func_TooltipOnEnter(curCharFrame, true, true)
		end)
		curCharFrame:SetScript("OnLeave", GameTooltip_Hide)
		curCharFrame.tooltip = E.CreateTooltipPlayers(CharInfo)
		curCharFrame:Show()
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
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
		----------------------------------------------------------------
		self:OctoToDo_Create_MainFrame_AddonsManager()
		self:func_CreateMyDataProvider()
		----------------------------------------------------------------
		E:func_CreateUtilsButton(OctoToDo_MainFrame_OCTOREP, "OCTOREP", AddonHeight, AddonHeight)
		E:func_CreateMinimapButton(GlobalAddonName, "OCTOREP", OctoToDo_OCTOREP, OctoToDo_MainFrame_OCTOREP, nil, "OctoToDo_MainFrame_OCTOREP")
		----------------------------------------------------------------
		OctoToDo_MainFrame_OCTOREP:SetScript("OnShow", function()
				C_Timer.After(0, function()
						OctoToDo_EventFrame_OCTOREP:func_CreateMyDataProvider() -- ПОФИКСИТЬ (HAS ANY CHANGE)
				end)
		end)
	end
end
----------------------------------------------------------------
function OctoToDo_EventFrame_OCTOREP:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_OCTOREP and OctoToDo_MainFrame_OCTOREP:IsShown() then
		OctoToDo_MainFrame_OCTOREP:Hide()
	end
end