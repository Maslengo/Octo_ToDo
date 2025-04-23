local GlobalAddonName, E = ...
local Octo_EventFrame_ToDo = CreateFrame("FRAME")
Octo_EventFrame_ToDo:Hide()
local Octo_MainFrame_ToDo = CreateFrame("BUTTON", "Octo_MainFrame_ToDo", UIParent, "BackdropTemplate")
Octo_MainFrame_ToDo:Hide()
local Octo_LeftFrame_ToDo = CreateFrame("BUTTON", "Octo_LeftFrame_ToDo", Octo_MainFrame_ToDo, "BackdropTemplate")
Octo_LeftFrame_ToDo:Hide()
tinsert(E.OctoTable_Frames, Octo_MainFrame_ToDo)
----------------------------------------------------------------
local AddonHeight = 20
local AddonLeftFrameWeight = 200
local AddonCentralFrameWeight = 90
local MainFrameDefaultLines = 30
local MainFrameTotalLines = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / AddonHeight))*.7)
if MainFrameDefaultLines > MainFrameTotalLines then
	MainFrameDefaultLines = MainFrameTotalLines
end
local SFDropDownWeight = 100
local MaxNumCharacters = 10
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
		local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
		f:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
		f:SetPoint("TOPLEFT", 8, -2)
		f:SetPoint("BOTTOMRIGHT", -8, 2)
		f:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
		f:SetBackdropBorderColor(0, 0, 0, 1)
		return f
end)
----------------------------------------------------------------
----------------------------------------------------------------
E.func_LoadAddOn("!BugGrabber")
E.func_LoadAddOn("BugSack")
E.func_LoadAddOn("HidingBar")
E.func_LoadAddOn("HidingBar_Options")
E.func_LoadAddOn("SpeedyAutoLoot")
-- E.func_LoadAddOn("MountsJournal")
-- E.func_LoadAddOn("SimpleAddonManager")
-- E.func_LoadAddOn("TalentTreeTweaks")
-- E.func_LoadAddOn("Plater")
-- E.func_LoadAddOn("MacroManager")
-- E.func_LoadAddOn("MacroManagerData")
-- E.func_LoadAddOn("SilverDragon")
-- E.func_LoadAddOn("SilverDragon_History")
-- E.func_LoadAddOn("SilverDragon_Overlay")
-- E.func_LoadAddOn("SilverDragon_RangeExtender")
-- E.func_LoadAddOn("TomTom")
-- E.func_LoadAddOn("Pawn")
-- E.func_LoadAddOn("MySlot")
-- E.func_LoadAddOn("QuestsChanged")
-- E.func_LoadAddOn("AdvancedInterfaceOptions")
----------------------------------------------------------------


function Octo_EventFrame_ToDo:ConcatAtStart()
	E.func_TableConcat(E.OctoTable_QuestID, E.OctoTable_QuestID_Paragon)
	for _, itemID in next, (E.OctoTable_itemID_ItemsUsable_Other) do
		E.OctoTable_itemID_ItemsUsable[itemID] = 1
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
local func_OnAcquired do
	------------------------------------------------
	local function func_OnClick(frame)
		--if Octo_MainFrame_ToDo:IsDragging() then
		--    return
		--end
		--local AchievementID = frame:GetData().AchievementID
		--ToggleAchievement(AchievementID)
	end
	------------------------------------------------
	local function func_OnEnter(frame)
		frame.texture_full:SetAlpha(E.bgCaOverlay)
	end
	------------------------------------------------
	local function func_OnLeave(frame)
		frame.texture_full:SetAlpha(0)
	end
	------------------------------------------------
	local function func_OnEnterSecond(frame)
		E.func_TooltipOnEnter(frame, true, true)
	end
	------------------------------------------------
	--local function func_OnLeaveSecond(frame)
	--    GameTooltip_Hide()
	--end
	------------------------------------------------
	--local function func_SecondShow(tbl)
	--    for k, v in next, (tbl) do
	--        v:Show()
	--    end
	--end
	--------------------------------------------------
	--local function func_SecondHide(tbl)
	--    for k, v in next, (tbl) do
	--        v:Hide()
	--    end
	--end
	------------------------------------------------
	function func_OnAcquired(owner, frame, data, new)
		if new then
			------------------------------------------------
			frame:SetPropagateMouseClicks(true)
			------------------------------------------------
			frame.texture_full = frame:CreateTexture(nil, "BACKGROUND", nil, 3)
			frame.texture_full:SetAllPoints()
			frame.texture_full:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
			local r, g, b = GetClassColor(E.classFilename)
			frame.texture_full:SetVertexColor(r, g, b, 0)
			------------------------------------------------
			frame.second = setmetatable({}, {
					__index = function(self, key)
						local f = CreateFrame("BUTTON", "frame"..key, frame)
						f:SetPropagateMouseClicks(true)
						f:SetPropagateMouseMotion(true)
						f:SetSize(AddonCentralFrameWeight, AddonHeight)
						f:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonCentralFrameWeight*key-AddonCentralFrameWeight, 0)
						f:RegisterForClicks("LeftButtonUp")
						f.ReputTexture = f:CreateTexture(nil, "BACKGROUND", nil, -2)
						f.ReputTexture:SetSize(AddonCentralFrameWeight, AddonHeight)
						f.ReputTexture:SetPoint("LEFT", f, "LEFT")
						f.ReputTexture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
						f.curCharTexture = f:CreateTexture(nil, "BACKGROUND", nil, -2)
						f.curCharTexture:SetSize(AddonCentralFrameWeight, AddonHeight)
						f.curCharTexture:SetPoint("LEFT", f, "LEFT")
						f.curCharTexture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
						f.curCharTexture:SetVertexColor(r, g, b, E.bgCaOverlay) -- BGALPHA
						f.curCharTexture:Hide()
						f.textCENT = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
						f.textCENT:SetPoint("LEFT")
						f.textCENT:SetPoint("RIGHT")
						f.textCENT:SetFontObject(OctoFont11)
						f.textCENT:SetWordWrap(false)
						f.textCENT:SetJustifyV("MIDDLE")
						f.textCENT:SetJustifyH("CENTER")
						f.textCENT:SetTextColor(1, 1, 1, 1)
						f:SetScript("OnEnter", func_OnEnterSecond)
						f:SetScript("OnLeave", GameTooltip_Hide)
						f:SetScript("OnHide", f.Hide)
						f.curCharTexture:SetScript("OnHide", f.curCharTexture.Hide)
						self[key] = f
						return f
			end})
			--frame.second.Show = func_SecondShow
			--frame.second.Hide = func_SecondHide
			------------------------------------------------
			frame:SetScript("OnClick", func_OnClick)
			frame:SetScript("OnEnter", func_OnEnter)
			frame:SetScript("OnLeave", func_OnLeave)
			------------------------------------------------
		end
	end
end
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ (АПДЕЙТ)


function Octo_EventFrame_ToDo:Octo_Frame_init(frame, node)
	local data = node:GetData()
	if data.totalPers > 1 then
		frame.second[data.currentChar]:Show()
		frame.second[data.currentChar].curCharTexture:Show()
		frame.second[data.currentChar].textCENT:SetText("")
		frame.second[data.currentChar].ReputTexture:Hide()
	end
	if data.zxc then
		for i = 1, #data.zxc.FIRST do
			if data.zxc.textCENT[i] then
				local textCENT = data.zxc.textCENT[i]
				local FIRST = data.zxc.FIRST[i]
				local SECOND = data.zxc.SECOND[i]
				local color = data.zxc.color[i]
				local r, g, b = E.func_hex2rgbNUMBER(color)
				frame.second[i].textCENT:SetText(textCENT)
				frame.second[i].ReputTexture:SetVertexColor(r, g, b, .3)
				if FIRST == 0 then
					frame.second[i].ReputTexture:SetWidth(.1)
					frame.second[i].ReputTexture:Hide()
				elseif FIRST == SECOND then
					frame.second[i].ReputTexture:SetWidth(AddonCentralFrameWeight)
					frame.second[i].ReputTexture:Show()
				elseif FIRST >= 1 then
					frame.second[i].ReputTexture:SetWidth((AddonCentralFrameWeight/SECOND)*FIRST)
					frame.second[i].ReputTexture:Show()
				end
			else
				frame.second[i].textCENT:SetText("")
				frame.second[i].ReputTexture:SetVertexColor(0, 0, 0, 0)
			end
			-- ТЕКУЩИЙ ПЕРСОНАЖ
			-- frame.second[i].curCharTexture:SetShown(i == data.currentChar)
			--if data.zxc.currentChar[i] and #data.zxc.currentChar > 1 then
			--    frame.second[i].curCharTexture:Show()
			--else
			--    frame.second[i].curCharTexture:Hide()
			--end
			frame.second[i]:Show()
			frame.second[i].tooltip = data.zxc.tooltip[i]
		end
	end
end


function Octo_EventFrame_ToDo:Octo_Create_MainFrame_ToDo()
	Octo_MainFrame_ToDo:SetPoint("CENTER", (AddonLeftFrameWeight/2), 0)
	-- Octo_MainFrame_ToDo:SetPoint("TOP", 0, -200)
	local NumPlayers = E.func_NumPlayers()
	if NumPlayers > MaxNumCharacters then
		NumPlayers = MaxNumCharacters
	end
	Octo_MainFrame_ToDo:SetSize(AddonCentralFrameWeight*NumPlayers, AddonHeight*MainFrameDefaultLines)
	Octo_MainFrame_ToDo:SetDontSavePosition(true)
	Octo_MainFrame_ToDo:SetClampedToScreen(false)
	Octo_MainFrame_ToDo:SetFrameStrata("HIGH")
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local barPanelScroll = CreateFrame("scrollFrame", nil, Octo_MainFrame_ToDo)
	Octo_MainFrame_ToDo.barPanelScroll = barPanelScroll
	barPanelScroll:SetPoint("TOPLEFT", Octo_MainFrame_ToDo)
	barPanelScroll:SetPoint("BOTTOMRIGHT", Octo_MainFrame_ToDo)
	barPanelScroll:SetScript("OnHorizontalScroll", function(self, offset)
			local scrollRange = self:GetHorizontalScrollRange()
			self.hBar:SetScrollPercentage(scrollRange > 0 and offset / scrollRange or 0, ScrollBoxConstants.NoScrollInterpolation)
	end)
	barPanelScroll:SetScript("OnScrollRangeChanged", function(self, xrange, yrange)
			self:GetScript("OnHorizontalScroll")(self, self:GetHorizontalScroll())
			local num = 30
			local width, height = self:GetSize()
			self.hBar:SetVisibleExtentPercentage(width > 0 and width / (xrange + width) or 0)
			self.hBar:SetPanExtentPercentage(xrange > 0 and num / xrange or 0)
	end)
	local HorizontalScrollBar = CreateFrame("EventFrame", nil, Octo_MainFrame_ToDo, "OctoWowTrimHorizontalScrollBar")
	--HorizontalScrollBar:Hide()
	HorizontalScrollBar.Backplate = HorizontalScrollBar:GetRegions()
	HorizontalScrollBar.Backplate:Hide()
	HorizontalScrollBar.Back.Texture:SetTexCoord(0, 0, 1, 0, 0, 1, 1, 1)
	HorizontalScrollBar.Forward.Texture:SetTexCoord(0, 0, 1, 0, 0, 1, 1, 1)
	HorizontalScrollBar.Track.Middle:SetTexCoord(0, 0, 1, 0, 0, 1, 1, 1)
	HorizontalScrollBar.Track.Begin:SetTexCoord(0, 0, 1, 0, 0, 1, 1, 1)
	HorizontalScrollBar.Track.End:SetTexCoord(0, 0, 1, 0, 0, 1, 1, 1)
	HorizontalScrollBar.Track.Thumb.Middle:SetTexCoord(0, 0, 1, 0, 0, 1, 1, 1)
	HorizontalScrollBar.Track.Thumb.Begin:SetTexCoord(0, 0, 1, 0, 0, 1, 1, 1)
	HorizontalScrollBar.Track.Thumb.End:SetTexCoord(0, 0, 1, 0, 0, 1, 1, 1)
	barPanelScroll.hBar = HorizontalScrollBar
	HorizontalScrollBar:SetPoint("TOPLEFT", barPanelScroll, "BOTTOMLEFT", 0, -6)
	HorizontalScrollBar:SetPoint("TOPRIGHT", barPanelScroll, "BOTTOMRIGHT", 0, 0)
	HorizontalScrollBar:RegisterCallback(HorizontalScrollBar.Event.OnScroll, function(scrollFrame, scrollPercentage)
			scrollFrame:SetHorizontalScroll(scrollPercentage * scrollFrame:GetHorizontalScrollRange())
	end, barPanelScroll)
	Octo_MainFrame_ToDo.child = CreateFrame("FRAME")
	Octo_MainFrame_ToDo.child:SetSize(AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight*MainFrameDefaultLines)
	HorizontalScrollBar:SetHideIfUnscrollable(true)
	--Octo_MainFrame_ToDo.child.texture = Octo_MainFrame_ToDo.child:CreateTexture(nil, "BACKGROUND")
	--Octo_MainFrame_ToDo.child.texture:SetAllPoints()
	--Octo_MainFrame_ToDo.child.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
	barPanelScroll:SetScrollChild(Octo_MainFrame_ToDo.child)
	Octo_MainFrame_ToDo.ScrollBox = CreateFrame("FRAME", "ScrollBox", Octo_MainFrame_ToDo.child, "WowScrollBoxList")
	Octo_MainFrame_ToDo.ScrollBox:SetPoint("TOPLEFT", 0, -AddonHeight)
	Octo_MainFrame_ToDo.ScrollBox:SetPoint("BOTTOMRIGHT")
	Octo_MainFrame_ToDo.ScrollBox:SetPropagateMouseClicks(true)
	Octo_MainFrame_ToDo.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	-- Octo_MainFrame_ToDo.ScrollBox:SetHorizontal(true)
	Octo_MainFrame_ToDo.ScrollBar = CreateFrame("EventFrame", "ScrollBar", Octo_MainFrame_ToDo, "MinimalScrollBar")
	Octo_MainFrame_ToDo.ScrollBar:SetPoint("TOPLEFT", Octo_MainFrame_ToDo, "TOPRIGHT", 6, 0)
	Octo_MainFrame_ToDo.ScrollBar:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo, "BOTTOMRIGHT", 6, 0)
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	Octo_MainFrame_ToDo.view = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_ToDo.view:SetElementExtent(AddonHeight)
	Octo_MainFrame_ToDo.view:SetElementInitializer("BUTTON",
		function(...)
			self:Octo_Frame_init(...)
	end)
	Octo_MainFrame_ToDo.view:RegisterCallback(Octo_MainFrame_ToDo.view.Event.OnAcquiredFrame, func_OnAcquired, Octo_MainFrame_ToDo)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_ToDo.ScrollBox, Octo_MainFrame_ToDo.ScrollBar, Octo_MainFrame_ToDo.view)
	----------------------------------------------------------------
	-- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА/ЕСЛИ НЕНУЖНЫ
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_ToDo.ScrollBox, Octo_MainFrame_ToDo.ScrollBar)
	----------------------------------------------------------------
	Octo_MainFrame_ToDo:SetBackdrop({
			bgFile = E.bgFile,
			edgeFile = E.edgeFile,
			edgeSize = 1,
			insets = {
				left = 0,
				right = 0,
				top = 0,
				bottom = 0,
			},
	})
	Octo_MainFrame_ToDo:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	Octo_MainFrame_ToDo:SetBackdropBorderColor(0, 0, 0, 1)
	Octo_MainFrame_ToDo:EnableMouse(true)
	Octo_MainFrame_ToDo:SetMovable(true)
	-- Octo_MainFrame_ToDo:RegisterForDrag("LeftButton")
	Octo_MainFrame_ToDo:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				Octo_MainFrame_ToDo:SetAlpha(E.bgCa)
				Octo_MainFrame_ToDo:StartMoving()
			end
	end)
	Octo_MainFrame_ToDo:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" then
				Octo_MainFrame_ToDo:SetAlpha(1)
				Octo_MainFrame_ToDo:StopMovingOrSizing()
			end
	end)
	Octo_MainFrame_ToDo:RegisterForClicks("RightButtonUp")
	Octo_MainFrame_ToDo:SetScript("OnClick", function(self) self:Hide() end)
	Octo_MainFrame_ToDo:SetScript("OnShow", function(self) Octo_LeftFrame_ToDo:Show() end)
	Octo_MainFrame_ToDo:SetScript("OnHide", function(self) Octo_LeftFrame_ToDo:Hide() end)
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local resetFunc = function(_, self)
		self:Hide()
		self:ClearAllPoints()
	end
	local initFunc = function(self)
		self:SetSize(AddonCentralFrameWeight, AddonHeight)
		self.text = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self.text:SetPoint("CENTER", self, "CENTER", 0, 0)
		self.text:SetFontObject(OctoFont11)
		self.text:SetJustifyV("MIDDLE")
		self.text:SetJustifyH("CENTER")
		self.text:SetTextColor(1, 1, 1, 1)
	end
	Octo_MainFrame_ToDo.pool = CreateFramePool("FRAME", Octo_MainFrame_ToDo.child, "BackdropTemplate", resetFunc, false, initFunc)
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local func_OnAcquired2 do
	------------------------------------------------
	local function func_OnClick(frame)
		--if Octo_LeftFrame_ToDo:IsDragging() then
		--    return
		--end
		--local AchievementID = frame:GetData().AchievementID
		--ToggleAchievement(AchievementID)
	end
	------------------------------------------------
	local function func_OnEnter(frame)
		frame.texture_full:SetAlpha(E.bgCaOverlay)
	end
	------------------------------------------------
	local function func_OnLeave(frame)
		frame.texture_full:SetAlpha(0)
	end
	------------------------------------------------
	function func_OnAcquired2(owner, frame, data, new)
		if new then
			------------------------------------------------
			frame:SetPropagateMouseClicks(true)
			------------------------------------------------
			frame.texture_full = frame:CreateTexture(nil, "BACKGROUND", nil, 3)
			frame.texture_full:SetAllPoints()
			frame.texture_full:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
			local r, g, b = GetClassColor(E.classFilename)
			frame.texture_full:SetVertexColor(r, g, b, 0)
			------------------------------------------------
			frame.icon_1 = frame:CreateTexture(nil, "BACKGROUND")
			frame.icon_1:SetSize(AddonHeight-2, AddonHeight-2)
			frame.icon_1:SetPoint("TOPLEFT", 1, -1)
			frame.icon_1:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
			------------------------------------------------
			frame.textLEFT = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			frame.textLEFT:SetPoint("LEFT", 2+AddonHeight, 0)
			frame.textLEFT:SetPoint("RIGHT", 0, 0)
			frame.textLEFT:SetFontObject(OctoFont11)
			frame.textLEFT:SetWordWrap(false)
			frame.textLEFT:SetJustifyV("MIDDLE")
			frame.textLEFT:SetJustifyH("LEFT")
			frame.textLEFT:SetTextColor(1, 1, 1, 1)
			------------------------------------------------
			frame:SetScript("OnClick", func_OnClick)
			frame:SetScript("OnEnter", func_OnEnter)
			frame:SetScript("OnLeave", func_OnLeave)
			------------------------------------------------
		end
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ (АПДЕЙТ)


function Octo_EventFrame_ToDo:Octo_Frame_init2(frame, node)
	local data = node:GetData()
	----------------------------------------------------------------
	frame.textLEFT:SetText(data.textLEFT)
	frame.icon_1:SetTexture(data.headerIcon)
	if not data.zxc then return end
	--if not data.zxc then
	--    for i, v in ipairs(frame.second) do
	--        frame.second[i]:Hide()
	--    end
	--else
	if data.headerIcon then
		frame.icon_1:SetTexture(data.headerIcon)
		-- frame.icon_1:SetPoint("TOPLEFT", 1, -1)
		-- frame.textLEFT:SetPoint("LEFT", 2+AddonHeight, 0)
	elseif data.zxc.icon then
		frame.icon_1:SetTexture(data.zxc.icon)
		-- frame.icon_1:SetPoint("TOPLEFT", 1+AddonHeight, -1)
		-- frame.textLEFT:SetPoint("LEFT", 2+AddonHeight+AddonHeight, 0)
	else
		frame.icon_1:SetTexture(E.Icon_Empty)
		-- frame.icon_1:SetPoint("TOPLEFT", 1+AddonHeight, -1)
		-- frame.textLEFT:SetPoint("LEFT", 2+AddonHeight+AddonHeight, 0)
	end
	--end
end


function Octo_EventFrame_ToDo:Octo_Create_LeftFrame_ToDo()
	Octo_LeftFrame_ToDo:SetPoint("BOTTOMRIGHT", Octo_MainFrame_ToDo, "BOTTOMLEFT", 1, 0)
	local NumPlayers = E.func_NumPlayers()
	if NumPlayers > MaxNumCharacters then
		NumPlayers = MaxNumCharacters
	end
	Octo_LeftFrame_ToDo:SetSize(AddonLeftFrameWeight, AddonHeight*MainFrameDefaultLines)
	Octo_LeftFrame_ToDo:SetFrameStrata("HIGH")
	Octo_LeftFrame_ToDo.ScrollBox = CreateFrame("FRAME", "ScrollBox", Octo_LeftFrame_ToDo, "WowScrollBoxList")
	Octo_LeftFrame_ToDo.ScrollBox:SetPoint("TOPLEFT", 0, -AddonHeight)
	Octo_LeftFrame_ToDo.ScrollBox:SetPoint("BOTTOMRIGHT")
	Octo_LeftFrame_ToDo.ScrollBox:SetPropagateMouseClicks(true)
	Octo_LeftFrame_ToDo.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	--Octo_LeftFrame_ToDo.ScrollBar = CreateFrame("EventFrame", "ScrollBar", Octo_LeftFrame_ToDo, "MinimalScrollBar")
	--Octo_LeftFrame_ToDo.ScrollBar:SetPoint("TOPLEFT", Octo_LeftFrame_ToDo, "TOPRIGHT", 6, 0)
	--Octo_LeftFrame_ToDo.ScrollBar:SetPoint("BOTTOMLEFT", Octo_LeftFrame_ToDo, "BOTTOMRIGHT", 6, 0)
	Octo_LeftFrame_ToDo.view = CreateScrollBoxListTreeListView(0)
	Octo_LeftFrame_ToDo.view:SetElementExtent(AddonHeight)
	Octo_LeftFrame_ToDo.view:SetElementInitializer("BUTTON",
		function(...)
			self:Octo_Frame_init2(...)
	end)
	Octo_LeftFrame_ToDo.view:RegisterCallback(Octo_LeftFrame_ToDo.view.Event.OnAcquiredFrame, func_OnAcquired2, Octo_LeftFrame_ToDo)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_LeftFrame_ToDo.ScrollBox, Octo_MainFrame_ToDo.ScrollBar, Octo_LeftFrame_ToDo.view)
	----------------------------------------------------------------
	-- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА/ЕСЛИ НЕНУЖНЫ
	--ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_LeftFrame_ToDo.ScrollBox, Octo_LeftFrame_ToDo.ScrollBar)
	Octo_LeftFrame_ToDo:SetBackdrop({
			bgFile = E.bgFile,
			edgeFile = E.edgeFile,
			edgeSize = 1,
			insets = {
				left = 0,
				right = 0,
				top = 0,
				bottom = 0,
			},
	})
	Octo_LeftFrame_ToDo:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	Octo_LeftFrame_ToDo:SetBackdropBorderColor(0, 0, 0, 1)
	----------------------------------------------------------------
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------


function Octo_EventFrame_ToDo:func_CreateMyDataProvider()
	local NumPlayers = E.func_NumPlayers()
	if NumPlayers > MaxNumCharacters then
		NumPlayers = MaxNumCharacters
	end
	local DataProvider = CreateTreeDataProvider()
	local numlines = 0
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local peLmennaya = E.sorted()
	local MyCharIndex
	for CharIndex, CharInfo in ipairs(peLmennaya) do
		if CharInfo.GUID == E.curGUID then
			MyCharIndex = CharIndex
			break
		end
	end
	if Octo_ToDo_DB_Vars.Reputations then
		for index, tbl in ipairs(E.OctoTable_Reputations) do
			if Octo_ToDo_DB_Vars.ExpansionToShow[index] then
				numlines = numlines + 1
				local Data = {
					textLEFT = tbl.header.name,
					headerIcon = tbl.header.icon,
					currentChar = MyCharIndex,
					totalPers = #peLmennaya,
				}
				local groupNodeFirst = DataProvider:Insert(Data)
				for _, v in ipairs(tbl) do
					if (Octo_ToDo_DB_Vars.OnlyCurrentFaction == true and (E.OctoTable_ReputationsDB[v.id].side == E.curFaction or E.OctoTable_ReputationsDB[v.id].side == "-")) or not Octo_ToDo_DB_Vars.OnlyCurrentFaction then
						numlines = numlines + 1
						local zxc = {}
						zxc.FIRST = {}
						zxc.SECOND = {}
						zxc.textCENT = {}
						zxc.color = {}
						zxc.standingTEXT = {}
						zxc.icon = E.OctoTable_ReputationsDB[v.id].icon or E.Icon_Empty
						zxc.tooltip = {}
						for CharIndex, CharInfo in ipairs(peLmennaya) do
							zxc.FIRST[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].FIRST or 0
							zxc.SECOND[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].SECOND or 0
							zxc.textCENT[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].vivod or ""
							zxc.color[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].color or "000000"
							zxc.standingTEXT[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].standingTEXT or ""
							-- zxc.currentChar[CharIndex] = CharInfo.GUID == E.curGUID
						end
						local groupNodeSecondary = groupNodeFirst:Insert({
								textLEFT = E.func_reputationName(v.id),
								zxc = zxc,
								currentChar = MyCharIndex,
								totalPers = #peLmennaya,
						})
					end
				end
			end
		end
	else
		local OctoTable_func_otrisovkaCENT, OctoTable_func_otrisovkaLEFT = E:func_Otrisovka()
		for i, func in ipairs(OctoTable_func_otrisovkaCENT) do
			numlines = numlines + 1
			local zxc = {}
			zxc.FIRST = {}
			zxc.SECOND = {}
			zxc.textCENT = {}
			zxc.color = {}
			-- zxc.standingTEXT = {}
			zxc.icon = {}
			zxc.icon = select(2, OctoTable_func_otrisovkaLEFT[i]())
			zxc.tooltip = {}
			for CharIndex, CharInfo in ipairs(peLmennaya) do
				zxc.FIRST[CharIndex] = 0
				zxc.SECOND[CharIndex] = 0
				zxc.textCENT[CharIndex], zxc.tooltip[CharIndex] = func(CharInfo)
				zxc.color[CharIndex] = E.Red_Color
				-- zxc.color[CharIndex] = select(3, OctoTable_func_otrisovkaLEFT[i]())
				zxc.currentChar = MyCharIndex
			end
			local groupNodeFirst = DataProvider:Insert({
					textLEFT = OctoTable_func_otrisovkaLEFT[i](),
					zxc = zxc,
					currentChar = MyCharIndex,
					totalPers = #peLmennaya,
			})
		end
	end
	MainFrameDefaultLines = numlines
	if MainFrameDefaultLines > Octo_ToDo_DB_Vars.MainFrameDefaultLines then
		MainFrameDefaultLines = Octo_ToDo_DB_Vars.MainFrameDefaultLines
	end
	if MainFrameDefaultLines < 1 then MainFrameDefaultLines = 1 end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_MainFrame_ToDo then
		Octo_MainFrame_ToDo:SetSize(AddonCentralFrameWeight*NumPlayers, AddonHeight*MainFrameDefaultLines+AddonHeight)
		Octo_MainFrame_ToDo.child:SetSize(AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight*MainFrameDefaultLines+AddonHeight)
		Octo_MainFrame_ToDo.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	end
	if Octo_LeftFrame_ToDo then
		Octo_LeftFrame_ToDo:SetSize(AddonLeftFrameWeight, AddonHeight*MainFrameDefaultLines+AddonHeight)
		Octo_LeftFrame_ToDo.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	end
	----------------------------------------------------------------
	--------------------------- POOL -------------------------------
	----------------------------------------------------------------
	Octo_MainFrame_ToDo.pool:ReleaseAll()
	for count, CharInfo in next, (peLmennaya) do
		local curCharFrame = Octo_MainFrame_ToDo.pool:Acquire()
		curCharFrame:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo.child, "TOPLEFT", AddonCentralFrameWeight*count-AddonCentralFrameWeight, -AddonHeight)
		curCharFrame.text:SetText(E.func_vivodCent(CharInfo))
		if CharInfo.Faction == "Horde" then
			E:func_SetBackdrop(curCharFrame, "|cfff01e38", E.bgCaOverlay*2, 0)
		else
			E:func_SetBackdrop(curCharFrame, "|cff0070DD", E.bgCaOverlay*2, 0)
		end
		-- curCharFrame:RegisterForClicks("RightButtonUp")
		-- curCharFrame:SetScript("OnClick", function() Octo_MainFrame_ToDo:Hide() end)
		curCharFrame:SetScript("OnEnter", function()
				E.func_TooltipOnEnter(curCharFrame, true, true)
		end)
		curCharFrame:SetScript("OnLeave", GameTooltip_Hide)
		curCharFrame.tooltip = E.CreateTooltipPlayers(CharInfo)
		curCharFrame:Show()
	end
	----------------------------------------------------------------
end
function E.Update(event_name)
	local updateScheduled = false
	local isMainFrameVisible = Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown()
	if isMainFrameVisible then
		if not updateScheduled then
			updateScheduled = true
			C_Timer.After(0.1, function()
					updateScheduled = false
					if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() then
						if E.DebugEvent then
							DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.Update(", E.Green_Color, E.Yellow_Color)..event_name..E.Yellow_Color..")|r")
						end
					end
			end)
		end
	else
		if E.DebugEvent then
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.Update(", E.Addon_Left_Color, E.Addon_Right_Color)..event_name..E.Addon_Right_Color..")|r")
		end
	end
end


function Octo_EventFrame_ToDo:func_Create_DD_ToDo()
	local DD_ToDo = CreateFrame("Button", "DD_ToDo", Octo_LeftFrame_ToDo, "SecureActionButtonTemplate, BackDropTemplate")
	DD_ToDo:SetSize(SFDropDownWeight, AddonHeight)
	E:func_SetBackdrop(DD_ToDo)
	DD_ToDo.ExpandArrow = DD_ToDo:CreateTexture(nil, "ARTWORK")
	DD_ToDo.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	--DD_ToDo.ExpandArrow:SetSize(AddonHeight, AddonHeight)
	DD_ToDo.ExpandArrow:SetPoint("RIGHT", -4, 0)
	DD_ToDo.text = DD_ToDo:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD_ToDo.text:SetAllPoints()
	DD_ToDo.text:SetFontObject(OctoFont11)
	DD_ToDo.text:SetJustifyV("MIDDLE")
	DD_ToDo.text:SetJustifyH("CENTER")
	DD_ToDo.text:SetTextColor(1, 1, 1, 1)
	DD_ToDo.text:SetText(E.Purple_Color..MAIN_MENU.."|r")
	LibSFDropDown:SetMixin(DD_ToDo)
	DD_ToDo:SetPoint("BOTTOMLEFT", Octo_LeftFrame_ToDo, "TOPLEFT", 0, 0)
	DD_ToDo:ddSetDisplayMode(GlobalAddonName)
	DD_ToDo:ddSetNoGlobalMouseEvent(true)
	DD_ToDo:ddHideWhenButtonHidden()
	DD_ToDo:RegisterForClicks("LeftButtonUp")
	DD_ToDo:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
		end
	)
	local function selectFunctionisShownPLAYER(menuButton, _, _, checked)
		Octo_ToDo_DB_Levels[menuButton.value].isShownPLAYER = checked
		Octo_EventFrame_ToDo:func_CreateMyDataProvider()
		Octo_MainFrame_ToDo.ScrollBox:ScrollToOffset(0)
		Octo_MainFrame_ToDo.barPanelScroll:SetHorizontalScroll(0)
	end
	local function func_remove_GUID(menuButton)
		Octo_ToDo_DB_Levels[menuButton.value] = nil
		Octo_EventFrame_ToDo:func_CreateMyDataProvider()
		Octo_MainFrame_ToDo.ScrollBox:ScrollToOffset(0)
	end
	local function selectFunctionExpansion(menuButton, _, _, checked)
		Octo_ToDo_DB_Vars.ExpansionToShow[menuButton.value] = checked or nil
		-- DD_ToDo:SetText("EXP")
		Octo_EventFrame_ToDo:func_CreateMyDataProvider()
	end
	DD_ToDo:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			local count = 0
			-- local ShowOnlyCurrentServer = Octo_ToDo_DB_Vars.ShowOnlyCurrentServer
			-- local ShowOnlyCurrentBattleTag = Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag
			-- local OnlyCurrentFaction = Octo_ToDo_DB_Vars.OnlyCurrentFaction
			-- local Reputations = Octo_ToDo_DB_Vars.Reputations
			if level == 1 then
				local BnetList = {}
				local Octo_BatlleNets = {}
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if not BnetList[CharInfo.BattleTagLocal] then
						count = count + 1
						Octo_BatlleNets[count] = CharInfo.BattleTagLocal
					end
					BnetList[CharInfo.BattleTagLocal] = true
				end
				sort(Octo_BatlleNets)
				if count > 1 then
					for i, Bnets in ipairs(Octo_BatlleNets) do
						local info = {}
						info.fontObject = OctoFont11
						info.hasArrow = true
						info.keepShownOnClick = true
						info.notCheckable = true
						local vivod = Bnets
						if Bnets == E.BattleTagLocal then
							vivod = E.classColorHexCurrent..Bnets.."|r"
						end
						if Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag == true then
							if Bnets ~= E.BattleTagLocal then
								vivod = E.Gray_Color..vivod.."|r"
							end
						end
						info.text = vivod
						info.value = Bnets
						tinsert(list, info)
					end
				else
					local GUID, CharInfo = next(Octo_ToDo_DB_Levels)
					value = CharInfo.BattleTagLocal
				end
			end
			self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			if type(value) == "string" then
				local tbl_Players = {}
				for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
					if CharInfo.BattleTagLocal == value or not value then
						tbl_Players[CharInfo.curServer] = tbl_Players[CharInfo.curServer] or {}
						tbl_Players[CharInfo.curServer][GUID] = tbl_Players[CharInfo.curServer][GUID] or {}
						tbl_Players[CharInfo.curServer][GUID] = CharInfo.classColorHex..CharInfo.Name.."|r"..CharInfo.UnitLevel
					end
				end
				for Server, v in next, (tbl_Players) do
					local info = {}
					info.fontObject = OctoFont11
					info.hasArrow = true
					info.keepShownOnClick = true
					info.notCheckable = true
					local vivod = Server
					if Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag and (value ~= E.BattleTagLocal or Octo_ToDo_DB_Vars.ShowOnlyCurrentServer and Server ~= E.curServer)
					or not Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag and Octo_ToDo_DB_Vars.ShowOnlyCurrentServer and Server ~= E.curServer
					then
						vivod = E.Gray_Color..vivod.."|r"
					elseif Server == E.curServer then
						vivod = E.classColorHexCurrent..vivod.."|r"
					end
					info.text = vivod
					info.value = v
					tinsert(list, info)
				end
				self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			elseif type(value) == "table" then
				local players_list = {}
				for GUID, names in next, (value) do
					tinsert(players_list, GUID)
				end
				sort(players_list, function(a, b)
						local infoA = Octo_ToDo_DB_Levels[a]
						local infoB = Octo_ToDo_DB_Levels[b]
						if infoA and infoB then
							return
							infoA.curServer > infoB.curServer or
							infoA.curServer == infoB.curServer and infoA.UnitLevel > infoB.UnitLevel or
							infoA.UnitLevel == infoB.UnitLevel and infoA.avgItemLevel > infoB.avgItemLevel or
							infoA.avgItemLevel == infoB.avgItemLevel and infoB.Name > infoA.Name
						end
					end
				)
				for _, GUID in next, (players_list) do
					local info = {}
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.isNotRadio = true
					local vivod = Octo_ToDo_DB_Levels[GUID].classColorHex..Octo_ToDo_DB_Levels[GUID].Name.."|r"
					if Octo_ToDo_DB_Levels[GUID].UnitLevel ~= E.currentMaxLevel then
						vivod = vivod.." "..E.Yellow_Color..Octo_ToDo_DB_Levels[GUID].UnitLevel.."|r"
					end
					info.text = vivod
					info.value = GUID
					info.func = selectFunctionisShownPLAYER
					info.checked = Octo_ToDo_DB_Levels[GUID].isShownPLAYER
					info.remove = func_remove_GUID
					info.removeDoNotHide = true
					info.icon = Octo_ToDo_DB_Levels[GUID].specIcon
					info.iconInfo = {tSizeX = 16, tSizeY = 16}
					tinsert(list, info)
				end
				self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			end
			if level == 1 then
				----------------
				self:ddAddSeparator(level)
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = L["Only Current Server"]
				info.hasArrow = nil
				info.checked = Octo_ToDo_DB_Vars.ShowOnlyCurrentServer
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.ShowOnlyCurrentServer = checked
					Octo_EventFrame_ToDo:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				if count > 1 then
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.notCheckable = false
					info.isNotRadio = true
					info.text = L["Only Current BattleTag"]
					info.hasArrow = nil
					info.checked = Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag
					info.func = function(_, _, _, checked)
						Octo_ToDo_DB_Vars.ShowOnlyCurrentBattleTag = checked
						Octo_EventFrame_ToDo:func_CreateMyDataProvider()
					end
					self:ddAddButton(info, level)
				end
				----------------
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				if E.curFaction == "Horde" then
					info.text = E.func_texturefromIcon(E.Icon_Horde)..L["Only Horde"]
				else
					info.text = E.func_texturefromIcon(E.Icon_Alliance)..L["Only Alliance"]
				end
				info.icon = false
				info.hasArrow = nil
				info.checked = Octo_ToDo_DB_Vars.OnlyCurrentFaction
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.OnlyCurrentFaction = checked
					Octo_EventFrame_ToDo:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				info.text = REPUTATION
				info.icon = false
				info.hasArrow = nil
				info.checked = Octo_ToDo_DB_Vars.Reputations
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.Reputations = checked
					Octo_EventFrame_ToDo:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				self:ddAddSeparator(level)
				----------------
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = "Show all"
				info.icon = false
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.isShownPLAYER = true
					end
					Octo_EventFrame_ToDo:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = "Hide all"
				info.icon = false
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						CharInfo.isShownPLAYER = false
					end
					Octo_EventFrame_ToDo:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				self:ddAddSeparator(level)
				----------------
			end
			if level == 1 then
				info.fontObject = OctoFont11
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = EXPANSION_FILTER_TEXT
				info.value = EXPANSION_FILTER_TEXT
				info.icon = false
				info.hasArrow = true
				info.func = nil
				-- info.func = function(_, _, _, checked)
				-- for expansionID, v in ipairs(E.OctoTable_Expansions) do
				-- Octo_ToDo_DB_Vars.ExpansionToShow[expansionID] = true
				-- end
				-- Octo_EventFrame_ToDo:func_CreateMyDataProvider()
				-- end
				self:ddAddButton(info, level)
			elseif value == EXPANSION_FILTER_TEXT then
				for expansionID, v in ipairs(E.OctoTable_Expansions) do
					info.fontObject = OctoFont11
					info.isNotRadio = true
					info.notCheckable = false
					info.keepShownOnClick = true
					info.text = v.color..v.name.."|r"
					info.value = expansionID
					info.icon = v.icon
					info.checked = Octo_ToDo_DB_Vars.ExpansionToShow[expansionID]
					info.func = selectFunctionExpansion
					self:ddAddButton(info, level)
				end
				----------------
				self:ddAddSeparator(level)
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = "Show all"
				info.icon = false
				info.func = function(_, _, _, checked)
					for expansionID, v in ipairs(E.OctoTable_Expansions) do
						Octo_ToDo_DB_Vars.ExpansionToShow[expansionID] = true
					end
					Octo_EventFrame_ToDo:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				--------------------------------------------------
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = "Hide all"
				info.icon = false
				info.func = function(_, _, _, checked)
					for expansionID, v in ipairs(E.OctoTable_Expansions) do
						Octo_ToDo_DB_Vars.ExpansionToShow[expansionID] = false
					end
					Octo_EventFrame_ToDo:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
			end
		end
	)
	DD_ToDo:ddSetOpenMenuUp(true)
	DD_ToDo:ddSetMenuButtonHeight(16)
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"PLAYER_LOGIN",
	"PLAYER_REGEN_DISABLED",
	"READY_CHECK",
	"SHOW_SUBSCRIPTION_INTERSTITIAL",
}
E.RegisterMyEventsToFrames(Octo_EventFrame_ToDo, MyEventsTable, E.func_DebugPath())


function Octo_EventFrame_ToDo:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if Octo_ToDo_DB_Vars.AddonHeight then
			AddonHeight = Octo_ToDo_DB_Vars.AddonHeight
		end
		if Octo_ToDo_DB_Vars.AddonLeftFrameWeight then
			AddonLeftFrameWeight = Octo_ToDo_DB_Vars.AddonLeftFrameWeight
		end
		if Octo_ToDo_DB_Vars.AddonCentralFrameWeight then
			AddonCentralFrameWeight = Octo_ToDo_DB_Vars.AddonCentralFrameWeight
		end
		if Octo_ToDo_DB_Vars.MainFrameDefaultLines then
			MainFrameDefaultLines = Octo_ToDo_DB_Vars.MainFrameDefaultLines
		end
		if Octo_ToDo_DB_Vars.SFDropDownWeight then
			SFDropDownWeight = Octo_ToDo_DB_Vars.SFDropDownWeight
		end
		local maxNum = math.floor((E.MonitorWidth-AddonLeftFrameWeight)/AddonCentralFrameWeight)-1
		if maxNum < Octo_ToDo_DB_Vars.MaxNumCharacters then
			Octo_ToDo_DB_Vars.MaxNumCharacters = maxNum
		end
		if Octo_ToDo_DB_Vars.MaxNumCharacters then
			MaxNumCharacters = Octo_ToDo_DB_Vars.MaxNumCharacters
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		self:ConcatAtStart()
		for i, func in next, (E.Modules) do
			func()
		end
	end
end


function Octo_EventFrame_ToDo:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
	-- C_CVar.RegisterCVar("addonProfilerEnabled", "1")
	-- C_CVar.SetCVar("addonProfilerEnabled", "1")
	self:LIBSHAREDSFMIC()
	C_WowTokenPublic.UpdateMarketPrice()
	GameMenuFrame:SetScale(Octo_ToDo_DB_Vars.GameMenuFrameScale or 1)
	if not PlayerSpellsFrame then
		E.func_LoadAddOn("Blizzard_PlayerSpells")
		PlayerSpellsFrame:HookScript("OnShow", function()
				PlayerSpellsFrame:SetScale(0.8)
		end)
		PlayerSpellsFrame:EnableMouse(true)
		PlayerSpellsFrame:SetMovable(true)
		PlayerSpellsFrame:RegisterForDrag("LeftButton")
		PlayerSpellsFrame:SetScript("OnDragStart", function()
				PlayerSpellsFrame:SetAlpha(E.bgCa)
				PlayerSpellsFrame:StartMoving()
		end)
		PlayerSpellsFrame:SetScript("OnDragStop", function()
				PlayerSpellsFrame:SetAlpha(1)
				PlayerSpellsFrame:StopMovingOrSizing()
		end)
	end
	----------------------------------------------------------------
	E:InitOptions()
	self:Octo_Create_MainFrame_ToDo()
	self:Octo_Create_LeftFrame_ToDo()
	self:func_CreateMyDataProvider()
	E.PortalsFrame()
	self:func_Create_DD_ToDo()
	----------------------------------------------------------------
	local totalMoney = 0
	local totalReload = 0
	local realTotalTime = 0
	local TodayTimePlayedtotal = 0
	local realLevelTime = 0
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.ReloadCount ~= nil then
			totalReload = totalReload + CharInfo.ReloadCount
		end
		if CharInfo.curServer == E.curServer then
			totalMoney = totalMoney + CharInfo.Money
			realTotalTime = realTotalTime + (CharInfo.realTotalTime)
			TodayTimePlayedtotal = TodayTimePlayedtotal + CharInfo.TodayTimePlayed
			if CharInfo.UnitLevel >= E.currentMaxLevel then
				realLevelTime = realLevelTime + CharInfo.realLevelTime
			end
		end
	end
	E.func_CreateInfoFrame("Money: "..E.classColorHexCurrent..E.func_CompactNumberFormat(totalMoney/10000).."|r "..E.curServerShort, "TOPLEFT", Octo_LeftFrame_ToDo, "BOTTOMLEFT", 0, -AddonHeight*0, AddonLeftFrameWeight, AddonHeight)
	E.func_CreateInfoFrame(string.format(TIME_PLAYED_TOTAL, E.classColorHexCurrent..(E.func_SecondsToClock(realTotalTime)).."|r"), "TOPLEFT", Octo_LeftFrame_ToDo, "BOTTOMLEFT", 0, -AddonHeight*1, AddonLeftFrameWeight, AddonHeight)
	if realLevelTime ~= 0 then
		E.func_CreateInfoFrame("realLevelTime: "..E.classColorHexCurrent..E.func_SecondsToClock(realLevelTime).."|r", "TOPLEFT", Octo_LeftFrame_ToDo, "BOTTOMLEFT", 0, -AddonHeight*2, AddonLeftFrameWeight, AddonHeight)
	end
	E.func_CreateInfoFrame("Reloads: "..E.classColorHexCurrent..totalReload.."|r", "TOPLEFT", Octo_LeftFrame_ToDo, "BOTTOMLEFT", 0, -AddonHeight*2, AddonLeftFrameWeight, AddonHeight)
	E:func_CreateUtilsButton(Octo_MainFrame_ToDo, "ToDo", AddonHeight, 0)
	E:func_CreateMinimapButton(GlobalAddonName, "ToDo", Octo_ToDo_DB_Vars, Octo_MainFrame_ToDo, function()
			Octo_EventFrame_ToDo:func_CreateMyDataProvider()
			RequestRaidInfo()
	end, "Octo_MainFrame_ToDo")
	C_Timer.After(0, function()
			-- E.PromiseItem = {}
			-- E.PromiseSpell = {}
			-- E.PromiseQuest = {}
			local promise = LibThingsLoad:Items(E.OctoTable_itemID_ALL)
			promise:AddItems(E.PromiseItem)
			promise:AddSpells(E.PromiseSpell)
			promise:AddQuests(E.PromiseQuest)
			promise:Then(function()
					if Octo_MainFrame_ToDo:IsShown() then
						Octo_MainFrame_ToDo:Hide()
						Octo_MainFrame_ToDo:Show()
					end
			end)
	end)
end


function Octo_EventFrame_ToDo:SHOW_SUBSCRIPTION_INTERSTITIAL()
	if not InCombatLockdown() then
		if SubscriptionInterstitialFrame then
			SubscriptionInterstitialFrame:SetScript("OnEvent", nil)
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Hide trash frames: ").."SubscriptionInterstitialFrame")
		end
	end
end


function Octo_EventFrame_ToDo:READY_CHECK()
	if not InCombatLockdown() then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
	end
end
----------------------------------------------------------------
SLASH_Octo1, SLASH_Octo2, SLASH_Octo3, SLASH_Octo4 = "/Octo", "/OctoTWW", "/octo", "/o"
function SlashCmdList.Octo(msg)
	if not InCombatLockdown() then
		Octo_EventFrame_ToDo:main_frame_toggle()
	end
end
local editFrame, editBox = _G["editFrame"], _G["editFrame"].editFrame
SLASH_GSEARCH1, SLASH_GSEARCH2 = "/gsearch", "/gs"
SlashCmdList.GSEARCH = function(msg)
	local str = ""
	local list = {}
	local color = E.classColorHexCurrent
	DEFAULT_CHAT_FRAME:AddMessage (color..("GSEARCH:|r ") .. msg)
	for i, n in next, (_G) do
		if type(n) == "string" and n:find(msg) then
			str = str..color..i.. "|r - ".. n .."\n"
		end
	end
	editBox:SetText(str)
	editFrame:Show()
end
SlashCmdList["RELOAD"] = E.ReloadUI()
SLASH_RELOAD1 = "/rl"
SLASH_FRAMESTK1 = "/fs"
SlashCmdList.FRAMESTK = function(msg)
	if not E.IsAddOnLoaded("Blizzard_DebugTools") then
		E.LoadAddOn("Blizzard_DebugTools")
	end
	local showHidden, showRegions, showAnchors = (msg == "true"), true, true
	FrameStackTooltip_Toggle(showHidden, showRegions, showAnchors)
end


function Octo_EventFrame_ToDo:PLAYER_REGEN_DISABLED()
	if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() then
		Octo_MainFrame_ToDo:Hide()
		Octo_LeftFrame_ToDo:Hide()
	end
end
----------------------------------------------------------------


function Octo_EventFrame_ToDo:LIBSHAREDSFMIC()
	-- local background = LibSFDropDown:CreateMediaBackgroundModernButton(UIParent, 120) -- BACKGROUND
	-- background:SetPoint("TOPLEFT", 20, -20)
	-- background:ddSetSelectedValue(Octo_ToDo_DB_Vars.interface.Octo_background or currentValue or LibSharedMedia:GetDefault("background"))
	-- background:ddSetOnSelectedFunc(function(value)
	-- 		local texture = LibSharedMedia:Fetch("background", value)
	-- 		Octo_ToDo_DB_Vars.interface.Octo_background = value
	-- end)
	-- local border = LibSFDropDown:CreateMediaBorderModernButton(UIParent, 120) -- BORDER
	-- border:SetPoint("TOPLEFT", background, "BOTTOMLEFT", 0, -10)
	-- border:ddSetSelectedValue(Octo_ToDo_DB_Vars.interface.Octo_border or currentValue or LibSharedMedia:GetDefault("border"))
	-- border:ddSetOnSelectedFunc(function(value)
	-- 		local texture = LibSharedMedia:Fetch("border", value)
	-- 		Octo_ToDo_DB_Vars.interface.Octo_border = value
	-- end)
	-- local statusbar = LibSFDropDown:CreateMediaStatusbarModernButton(UIParent, 120) -- STATUSBAR
	-- statusbar:SetPoint("TOPLEFT", border, "BOTTOMLEFT", 0, -10)
	-- statusbar:ddSetSelectedValue(Octo_ToDo_DB_Vars.interface.Octo_statusbar or currentValue or LibSharedMedia:GetDefault("statusbar"))
	-- statusbar:ddSetOnSelectedFunc(function(value)
	-- 		local texture = LibSharedMedia:Fetch("statusbar", value)
	-- 		Octo_ToDo_DB_Vars.interface.Octo_statusbar = value
	-- end)
	-- local font = LibSFDropDown:CreateMediaFontModernButton(UIParent, 120) -- FONT
	-- font:SetPoint("TOPLEFT", statusbar, "BOTTOMLEFT", 0, -10)
	-- font:ddSetSelectedValue(Octo_ToDo_DB_Vars.interface.Octo_font or currentValue or LibSharedMedia:GetDefault("font"))
	-- font:ddSetOnSelectedFunc(function(value)
	-- 		local selectedFont = LibSharedMedia:Fetch("font", value)
	-- 		Octo_ToDo_DB_Vars.interface.Octo_font = value
	-- end)
	-- local sound = LibSFDropDown:CreateMediaSoundModernButton(UIParent, 120) -- SOUND
	-- sound:SetPoint("TOPLEFT", font, "BOTTOMLEFT", 0, -10)
	-- sound:ddSetSelectedValue(Octo_ToDo_DB_Vars.interface.Octo_sound or currentValue or LibSharedMedia:GetDefault("sound"))
	-- sound:ddSetOnSelectedFunc(function(value)
	-- 		local selectedSound = LibSharedMedia:Fetch("sound", value)
	-- 		Octo_ToDo_DB_Vars.interface.Octo_sound = value
	-- end)
end