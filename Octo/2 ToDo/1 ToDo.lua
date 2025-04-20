local GlobalAddonName, E = ...
local Octo_EventFrame_OCTOMAIN = CreateFrame("FRAME")
Octo_EventFrame_OCTOMAIN:Hide()
local Octo_MainFrame_OCTOMAIN = CreateFrame("BUTTON", "Octo_MainFrame_OCTOMAIN", UIParent, "BackdropTemplate")
Octo_MainFrame_OCTOMAIN:Hide()
tinsert(E.OctoTable_Frames, Octo_MainFrame_OCTOMAIN)
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
-- E.func_LoadAddOn("Octo_Achievements_DB")
E.func_LoadAddOn("Octo_AddonsManager_DB")
-- E.func_LoadAddOn("Octo_Minecraft")
E.func_LoadAddOn("Octo_TrashCan_DB")
E.func_LoadAddOn("!BugGrabber")
E.func_LoadAddOn("BugSack")
-- E.func_LoadAddOn("MountsJournal")
E.func_LoadAddOn("HidingBar")
E.func_LoadAddOn("HidingBar_Options")
-- E.func_LoadAddOn("SpeedyAutoLoot")
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
function Octo_EventFrame_OCTOMAIN:ConcatAtStart()
	E.func_TableConcat(E.OctoTable_QuestID, E.OctoTable_QuestID_Paragon)
	for _, itemID in next, (E.OctoTable_itemID_ItemsUsable_Other) do
		E.OctoTable_itemID_ItemsUsable[itemID] = 1
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
local function func_OnAcquired(owner, frame, data, new)
	if new then
		------------------------------------------------
		frame.full = CreateFrame("FRAME", nil, frame)
		frame.full:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight)
		-- frame.full:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.full:SetPoint("RIGHT")
		frame.full.texture = frame.full:CreateTexture(nil, "BACKGROUND")
		frame.full.texture:SetAllPoints()
		frame.full.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
		local r, g, b = GetClassColor(E.classFilename)
		frame.full.texture:SetVertexColor(r, g, b, 0)
		frame.full:SetScript("OnEnter", function(self) self.texture:SetAlpha(E.BGALPHA) end)
		frame.full:SetScript("OnLeave", function(self) self.texture:SetAlpha(0) end)
		frame.full:SetPropagateMouseClicks(true)
		frame.full:SetPropagateMouseMotion(true)
		------------------------------------------------
		frame.icon_firstSlot = frame:CreateTexture(nil, "BACKGROUND")
		frame.icon_firstSlot:SetSize(AddonHeight-2, AddonHeight-2)
		frame.icon_firstSlot:SetPoint("TOPLEFT", 1, -1)
		frame.icon_firstSlot:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		------------------------------------------------
		frame.left = CreateFrame("FRAME", nil, frame)
		frame.left:SetSize(AddonLeftFrameWeight, AddonHeight)
		frame.left:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.left:SetPropagateMouseClicks(true)
		-- frame.left:SetPoint("RIGHT")
		------------------------------------------------
		frame.left.texture = frame.left:CreateTexture(nil, "BACKGROUND")
		frame.left.texture:SetAllPoints()
		frame.left.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
		frame.left.texture:SetVertexColor(1, 1, 1, 0)
		------------------------------------------------
		frame.left.textLEFT = frame.left:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.left.textLEFT:SetPoint("LEFT", 2+AddonHeight, 0)
		frame.left.textLEFT:SetPoint("RIGHT", 0, 0)
		frame.left.textLEFT:SetFontObject(OctoFont11)
		frame.left.textLEFT:SetWordWrap(false)
		frame.left.textLEFT:SetJustifyV("MIDDLE")
		frame.left.textLEFT:SetJustifyH("LEFT")
		frame.left.textLEFT:SetTextColor(1, 1, 1, 1)
		------------------------------------------------
		frame.second = setmetatable({}, {
				__index = function(self, key)
					local f = CreateFrame("BUTTON", "frame"..key, frame)
					f:SetPropagateMouseClicks(true)
					f:SetSize(AddonCentralFrameWeight, AddonHeight)
					f:SetPoint("TOPLEFT", frame, "TOPLEFT", (AddonLeftFrameWeight-AddonCentralFrameWeight)+AddonCentralFrameWeight*key, 0)
					f:RegisterForClicks("LeftButtonUp")
					f:SetScript("OnClick", OnClick_Second)
					f.texture = f:CreateTexture(nil, "BACKGROUND", nil, 2)
					f.texture:SetSize(AddonCentralFrameWeight, AddonHeight)
					f.texture:SetPoint("LEFT", f, "LEFT")
					f.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo.tga")
					f.textCENT = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
					f.textCENT:SetPoint("LEFT")
					f.textCENT:SetPoint("RIGHT")
					f.textCENT:SetFontObject(OctoFont11)
					f.textCENT:SetWordWrap(false)
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
function Octo_EventFrame_OCTOMAIN:Octo_Frame_init(frame, node)
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local data = node:GetData()
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	frame.left.textLEFT:SetText(data.textLEFT)
	-- print (data.expColor)
	-- if data.expColor then
	-- 	local r1, g1, b1 = E.func_hex2rgbNUMBER(data.expColor)
	-- 	frame.left.texture:SetVertexColor(r1, g1, b1, E.BGALPHA)
	-- else
	-- 	frame.left.texture:SetAlpha(0)
	-- end


	frame.icon_firstSlot:SetTexture(data.headerIcon)
	if not data.zxc then
		for i, v in ipairs(frame.second) do
			frame.second[i]:Hide()
		end
	else
		if data.headerIcon then
			frame.icon_firstSlot:SetTexture(data.headerIcon)
			-- frame.icon_firstSlot:SetPoint("TOPLEFT", 1, -1)
			-- frame.left.textLEFT:SetPoint("LEFT", 2+AddonHeight, 0)
		elseif data.zxc.icon then
			frame.icon_firstSlot:SetTexture(data.zxc.icon)
			-- frame.icon_firstSlot:SetPoint("TOPLEFT", 1+AddonHeight, -1)
			-- frame.left.textLEFT:SetPoint("LEFT", 2+AddonHeight+AddonHeight, 0)
		else
			frame.icon_firstSlot:SetTexture(E.Icon_Empty)
			-- frame.icon_firstSlot:SetPoint("TOPLEFT", 1+AddonHeight, -1)
			-- frame.left.textLEFT:SetPoint("LEFT", 2+AddonHeight+AddonHeight, 0)
		end
		for i = 1, #data.zxc.textCENT do
			if data.zxc.textCENT[i] and data.zxc.textCENT[i] ~= "" then
				local textCENT = data.zxc.textCENT[i]
				local FIRST = data.zxc.FIRST[i]
				local SECOND = data.zxc.SECOND[i]
				local color = data.zxc.color[i]
				local r, g, b = E.func_hex2rgbNUMBER(color)
				frame.second[i].textCENT:SetText(textCENT)
				frame.second[i].texture:SetVertexColor(r, g, b, E.BGALPHA)
				if FIRST == 0 then
					frame.second[i].texture:SetWidth(.1)
					frame.second[i].texture:Hide()
				elseif FIRST == SECOND then
					frame.second[i].texture:SetWidth(AddonCentralFrameWeight)
					frame.second[i].texture:Show()
				elseif FIRST >= 1 then
					frame.second[i].texture:SetWidth((AddonCentralFrameWeight/SECOND)*FIRST)
					frame.second[i].texture:Show()
				end
			else
				frame.second[i].textCENT:SetText("-")
				frame.second[i].texture:SetVertexColor(0, 0, 0, 0)
			end
			-- ТЕКУЩИЙ ПЕРСОНАЖ
			-- if data.zxc.currentChar[i] then
			--     E:func_SetBackdrop(frame.second[i], E.classColorHexCurrent, E.bgCaOverlay, 0)
			-- end
			frame.second[i]:Show()
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
end
function Octo_EventFrame_OCTOMAIN:Octo_Create_MainFrame_OCTOMAIN()
	-- Octo_MainFrame_OCTOMAIN:SetPoint("CENTER", 0, 0)
	Octo_MainFrame_OCTOMAIN:SetPoint("TOP", 0, -200)

	local NumPlayers = E.func_NumPlayers()
	if NumPlayers > 8 then
		NumPlayers = 8
	end
	Octo_MainFrame_OCTOMAIN:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*NumPlayers, AddonHeight*MainFrameDefaultLines)
	Octo_MainFrame_OCTOMAIN:SetDontSavePosition(true)
	Octo_MainFrame_OCTOMAIN:SetClampedToScreen(false)
	Octo_MainFrame_OCTOMAIN:SetFrameStrata("HIGH")
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local barPanelScroll = CreateFrame("scrollFrame", nil, Octo_MainFrame_OCTOMAIN)
	barPanelScroll:SetPoint("TOPLEFT", Octo_MainFrame_OCTOMAIN)
	barPanelScroll:SetPoint("BOTTOMRIGHT", Octo_MainFrame_OCTOMAIN)
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
	local HorizontalScrollBar = CreateFrame("EventFrame", nil, Octo_MainFrame_OCTOMAIN, "OctoWowTrimHorizontalScrollBar")
	HorizontalScrollBar:Hide()
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
	Octo_MainFrame_OCTOMAIN.child = CreateFrame("FRAME")
	Octo_MainFrame_OCTOMAIN.child:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight*MainFrameDefaultLines)
	HorizontalScrollBar:SetScript("OnSizeChanged", function(self)
			self:SetShown(not WithinRangeExclusive(self:GetVisibleExtentPercentage(), MathUtil.Epsilon, 1 - MathUtil.Epsilon))
	end)
	-- Octo_MainFrame_OCTOMAIN.child.texture = Octo_MainFrame_OCTOMAIN.child:CreateTexture(nil, "BACKGROUND")
	-- Octo_MainFrame_OCTOMAIN.child.texture:SetAllPoints()
	-- Octo_MainFrame_OCTOMAIN.child.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
	barPanelScroll:SetScrollChild(Octo_MainFrame_OCTOMAIN.child)
	Octo_MainFrame_OCTOMAIN.ScrollBox = CreateFrame("FRAME", "ScrollBox", Octo_MainFrame_OCTOMAIN.child, "WowScrollBoxList")
	Octo_MainFrame_OCTOMAIN.ScrollBox:SetPoint("TOPLEFT", 0, -AddonHeight)
	Octo_MainFrame_OCTOMAIN.ScrollBox:SetPoint("BOTTOMRIGHT")
	Octo_MainFrame_OCTOMAIN.ScrollBox:SetPropagateMouseClicks(true)
	Octo_MainFrame_OCTOMAIN.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	-- Octo_MainFrame_OCTOMAIN.ScrollBox:SetHorizontal(true)
	Octo_MainFrame_OCTOMAIN.ScrollBar = CreateFrame("EventFrame", "ScrollBar", Octo_MainFrame_OCTOMAIN, "MinimalScrollBar")
	Octo_MainFrame_OCTOMAIN.ScrollBar:SetPoint("TOPLEFT", Octo_MainFrame_OCTOMAIN, "TOPRIGHT", 6, 0)
	Octo_MainFrame_OCTOMAIN.ScrollBar:SetPoint("BOTTOMLEFT", Octo_MainFrame_OCTOMAIN, "BOTTOMRIGHT", 6, 0)
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	Octo_MainFrame_OCTOMAIN.view = CreateScrollBoxListTreeListView(0)
	Octo_MainFrame_OCTOMAIN.view:SetElementExtent(AddonHeight)
	Octo_MainFrame_OCTOMAIN.view:SetElementInitializer("Frame",
		function(...)
			self:Octo_Frame_init(...)
	end)
	Octo_MainFrame_OCTOMAIN.view:RegisterCallback(Octo_MainFrame_OCTOMAIN.view.Event.OnAcquiredFrame, func_OnAcquired, Octo_MainFrame_OCTOMAIN)
	ScrollUtil.InitScrollBoxListWithScrollBar(Octo_MainFrame_OCTOMAIN.ScrollBox, Octo_MainFrame_OCTOMAIN.ScrollBar, Octo_MainFrame_OCTOMAIN.view)
	----------------------------------------------------------------
	-- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА/ЕСЛИ НЕНУЖНЫ
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(Octo_MainFrame_OCTOMAIN.ScrollBox, Octo_MainFrame_OCTOMAIN.ScrollBar)
	----------------------------------------------------------------
	Octo_MainFrame_OCTOMAIN:SetBackdrop({
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
	Octo_MainFrame_OCTOMAIN:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	Octo_MainFrame_OCTOMAIN:SetBackdropBorderColor(0, 0, 0, 1)
	Octo_MainFrame_OCTOMAIN:EnableMouse(true)
	Octo_MainFrame_OCTOMAIN:SetMovable(true)
	-- Octo_MainFrame_OCTOMAIN:RegisterForDrag("LeftButton")
	Octo_MainFrame_OCTOMAIN:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				Octo_MainFrame_OCTOMAIN:SetAlpha(E.bgCa)
				Octo_MainFrame_OCTOMAIN:StartMoving()
			end
	end)
	Octo_MainFrame_OCTOMAIN:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" then
				Octo_MainFrame_OCTOMAIN:SetAlpha(1)
				Octo_MainFrame_OCTOMAIN:StopMovingOrSizing()
			end
	end)
	-- Octo_MainFrame_OCTOMAIN:SetScript("OnDragStart", function()
	--         Octo_MainFrame_OCTOMAIN:SetAlpha(E.bgCa)
	--         Octo_MainFrame_OCTOMAIN:StartMoving()
	-- end)
	-- Octo_MainFrame_OCTOMAIN:SetScript("OnDragStop", function()
	--         Octo_MainFrame_OCTOMAIN:SetAlpha(1)
	--         Octo_MainFrame_OCTOMAIN:StopMovingOrSizing()
	-- end)
	Octo_MainFrame_OCTOMAIN:RegisterForClicks("RightButtonUp")
	Octo_MainFrame_OCTOMAIN:SetScript("OnClick", function(self) self:Hide() end)
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
	Octo_MainFrame_OCTOMAIN.pool = CreateFramePool("FRAME", Octo_MainFrame_OCTOMAIN.child, "BackdropTemplate", resetFunc, false, initFunc)
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	E.func_CreateMyDataProvider()
end
function E.func_CreateMyDataProvider()
	local NumPlayers = E.func_NumPlayers()
	if NumPlayers > 8 then
		NumPlayers = 8
	end
	local DataProvider = CreateTreeDataProvider()
	local numlines = 0
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Reputations then
		for index, tbl in ipairs(E.OctoTable_Reputations) do
			if Octo_ToDo_DB_Vars.ExpansionToShow[index] then
				numlines = numlines + 1
				local groupNodeFirst = DataProvider:Insert({
						textLEFT = tbl.header.name,
						headerIcon = tbl.header.icon,
						expColor = E.OctoTable_Expansions[index].color,
				})
				for _, v in ipairs(tbl) do
					if (Octo_ToDo_DB_Vars.OnlyCurrentFaction == true and (E.OctoTable_ReputationsDB[v.id].side == E.func_UnitFaction("PLAYER") or E.OctoTable_ReputationsDB[v.id].side == "-")) or not Octo_ToDo_DB_Vars.OnlyCurrentFaction then
						numlines = numlines + 1
						local zxc = {}
						zxc.FIRST = {}
						zxc.SECOND = {}
						zxc.textCENT = {}
						zxc.color = {}
						zxc.standingTEXT = {}
						zxc.icon = E.OctoTable_ReputationsDB[v.id].icon or E.Icon_Empty
						zxc.currentChar = {}
						for CharIndex, CharInfo in ipairs(E.sorted()) do
							zxc.FIRST[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].FIRST or 0
							zxc.SECOND[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].SECOND or 0
							zxc.textCENT[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].vivod or ""
							zxc.color[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].color or ""
							zxc.standingTEXT[CharIndex] = CharInfo.MASLENGO.reputationFULL[v.id].standingTEXT or ""
							zxc.currentChar[CharIndex] = CharInfo.GUID == E.curGUID
						end
						local groupNodeSecondary = groupNodeFirst:Insert({
								textLEFT = E.func_reputationName(v.id),
								zxc = zxc,
								expColor = E.OctoTable_Expansions[index].color,
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
			zxc.currentChar = {}
			zxc.icon = select(2, OctoTable_func_otrisovkaLEFT[i]())
			for CharIndex, CharInfo in ipairs(E.sorted()) do
				zxc.FIRST[CharIndex] = 0
				zxc.SECOND[CharIndex] = 0
				zxc.textCENT[CharIndex] = func(CharInfo) or ""
				zxc.color[CharIndex] = E.Red_Color
				-- zxc.color[CharIndex] = select(3, OctoTable_func_otrisovkaLEFT[i]())
				zxc.currentChar[CharIndex] = CharInfo.GUID == E.curGUID
			end
			local groupNodeFirst = DataProvider:Insert({
					textLEFT = OctoTable_func_otrisovkaLEFT[i](),
					zxc = zxc,
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
	Octo_MainFrame_OCTOMAIN:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*NumPlayers, AddonHeight*MainFrameDefaultLines+AddonHeight)
	Octo_MainFrame_OCTOMAIN.child:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight*MainFrameDefaultLines+AddonHeight)
	Octo_MainFrame_OCTOMAIN.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	----------------------------------------------------------------
	--------------------------- POOL -------------------------------
	----------------------------------------------------------------
	Octo_MainFrame_OCTOMAIN.pool:ReleaseAll()
	for count, CharInfo in next, (E.sorted()) do
		local curCharFrame = Octo_MainFrame_OCTOMAIN.pool:Acquire()
		curCharFrame:SetPoint("BOTTOMLEFT", Octo_MainFrame_OCTOMAIN.child, "TOPLEFT", (AddonLeftFrameWeight-AddonCentralFrameWeight)+(AddonCentralFrameWeight*count), -AddonHeight)
		curCharFrame.text:SetText(E.func_vivodCent(CharInfo))
		if CharInfo.Faction == "Horde" then
			E:func_SetBackdrop(curCharFrame, "|cfff01e38", E.bgCaOverlay*2, 0)
		else
			E:func_SetBackdrop(curCharFrame, "|cff0070DD", E.bgCaOverlay*2, 0)
		end
		-- curCharFrame:RegisterForClicks("RightButtonUp")
		-- curCharFrame:SetScript("OnClick", function() Octo_MainFrame_OCTOMAIN:Hide() end)
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
	--Octo_ToDo_DB_Vars.DebugFunction
	local updateScheduled = false
	local isMainFrameVisible = Octo_MainFrame_OCTOMAIN and Octo_MainFrame_OCTOMAIN:IsShown()
	if isMainFrameVisible then
		if not updateScheduled then
			updateScheduled = true
			C_Timer.After(0.1, function()
					updateScheduled = false
					if Octo_MainFrame_OCTOMAIN and Octo_MainFrame_OCTOMAIN:IsShown() then
						if E.DebugEvent then
							DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.Update(", E.Green_Color, E.Yellow_Color)..event_name..E.Yellow_Color..")|r")
						end
						-- E.func_CreateMyDataProvider()
					end
			end)
		end
	else
		if E.DebugEvent then
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.Update(", E.Addon_Left_Color, E.Addon_Right_Color)..event_name..E.Addon_Right_Color..")|r")
		end
	end
end

function Octo_EventFrame_OCTOMAIN:func_Create_DD_ToDo()
	local DD_ToDo = CreateFrame("Button", "DD_ToDo", Octo_MainFrame_OCTOMAIN, "SecureActionButtonTemplate, BackDropTemplate")
	DD_ToDo:SetSize(SFDropDownWeight, AddonHeight)
	E:func_SetBackdrop(DD_ToDo)
	DD_ToDo.ExpandArrow = DD_ToDo:CreateTexture(nil, "ARTWORK")
	DD_ToDo.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DD_ToDo.ExpandArrow:SetSize(AddonHeight, AddonHeight)
	DD_ToDo.ExpandArrow:SetPoint("RIGHT", -4, 0)
	DD_ToDo.text = DD_ToDo:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD_ToDo.text:SetAllPoints()
	DD_ToDo.text:SetFontObject(OctoFont11)
	DD_ToDo.text:SetJustifyV("MIDDLE")
	DD_ToDo.text:SetJustifyH("CENTER")
	DD_ToDo.text:SetTextColor(1, 1, 1, 1)
	DD_ToDo.text:SetText(E.Purple_Color..MAIN_MENU.."|r")
	LibSFDropDown:SetMixin(DD_ToDo)
	DD_ToDo:SetPoint("BOTTOMLEFT", Octo_MainFrame_OCTOMAIN, "TOPLEFT", 0, 0)
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
		E.func_CreateMyDataProvider()
	end
	local function func_remove_GUID(menuButton)
		Octo_ToDo_DB_Levels[menuButton.value] = nil
		E.func_CreateMyDataProvider()
	end
	local function selectFunctionExpansion(menuButton, _, _, checked)
		Octo_ToDo_DB_Vars.ExpansionToShow[menuButton.value] = checked or nil
		-- DD_ToDo:SetText("EXP")
		E.func_CreateMyDataProvider()
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
					E.func_CreateMyDataProvider()
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
						E.func_CreateMyDataProvider()
					end
					self:ddAddButton(info, level)
				end
				----------------
				info.keepShownOnClick = true
				info.notCheckable = false
				info.isNotRadio = true
				if E.func_UnitFaction("PLAYER") == "Horde" then
					info.text = E.func_texturefromIcon(E.Icon_Horde)..L["Only Horde"]
				else
					info.text = E.func_texturefromIcon(E.Icon_Alliance)..L["Only Alliance"]
				end
				info.icon = false
				info.hasArrow = nil
				info.checked = Octo_ToDo_DB_Vars.OnlyCurrentFaction
				info.func = function(_, _, _, checked)
					Octo_ToDo_DB_Vars.OnlyCurrentFaction = checked
					E.func_CreateMyDataProvider()
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
					E.func_CreateMyDataProvider()
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
					E.func_CreateMyDataProvider()
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
					E.func_CreateMyDataProvider()
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
				--     for expansionID, v in ipairs(E.OctoTable_Expansions) do
				--         Octo_ToDo_DB_Vars.ExpansionToShow[expansionID] = true
				--     end
				--     E.func_CreateMyDataProvider()
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
					E.func_CreateMyDataProvider()
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
					E.func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
			end
		end
	)
	DD_ToDo:ddSetOpenMenuUp(true)
	DD_ToDo:ddSetMenuButtonHeight(16)
end
----------------------------------------------------------------
do
	local MyEventsTable = {
		"ADDON_LOADED",
		"PLAYER_LOGIN",
		"PLAYER_REGEN_DISABLED",
		"READY_CHECK",
		"SHOW_SUBSCRIPTION_INTERSTITIAL",
	}
	E.RegisterMyEventsToFrames(Octo_EventFrame_OCTOMAIN, MyEventsTable, E.func_DebugPath())
end
function Octo_EventFrame_OCTOMAIN:ADDON_LOADED(addonName)
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
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		self:ConcatAtStart()
		for i, func in next, (E.Modules) do
			func()
		end
	end
end
function Octo_EventFrame_OCTOMAIN:PLAYER_LOGIN()
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
	self:Octo_Create_MainFrame_OCTOMAIN()
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
	-- E.func_CreateInfoFrame("Money: "..E.classColorHexCurrent..E.func_CompactNumberFormat(totalMoney/10000).."|r "..E.curServerShort, "TOPLEFT", Octo_MainFrame_OCTOMAIN, "BOTTOMLEFT", -AddonHeight*0, 0, AddonLeftFrameWeight, AddonHeight)
	-- E.func_CreateInfoFrame("Reloads: "..E.classColorHexCurrent..totalReload.."|r", "TOPLEFT", Octo_MainFrame_OCTOMAIN, "BOTTOMLEFT", 0, -AddonHeight*1, AddonLeftFrameWeight, AddonHeight)
	-- E.func_CreateInfoFrame("realTotalTime: "..E.classColorHexCurrent..E.func_SecondsToClock(realTotalTime).."|r", "TOPLEFT", Octo_MainFrame_OCTOMAIN, "BOTTOMLEFT", 0, -AddonHeight*2, AddonLeftFrameWeight, AddonHeight)
	if realLevelTime ~= 0 then
		E.func_CreateInfoFrame("realLevelTime: "..E.classColorHexCurrent..E.func_SecondsToClock(realLevelTime).."|r", "TOPLEFT", Octo_MainFrame_OCTOMAIN, "BOTTOMLEFT", 0, -AddonHeight*3, AddonLeftFrameWeight, AddonHeight)
	end
	E:func_CreateUtilsButton(Octo_MainFrame_OCTOMAIN, "ToDo", AddonHeight, 0)
	E:func_CreateMinimapButton(GlobalAddonName, "ToDo", Octo_ToDo_DB_Vars, Octo_MainFrame_OCTOMAIN, function()
			E.func_CreateMyDataProvider()
			RequestRaidInfo()
	end, "Octo_MainFrame_OCTOMAIN")
	C_Timer.After(0, function()
			-- E.PromiseItem = {}
			-- E.PromiseSpell = {}
			-- E.PromiseQuest = {}
			local promise = LibThingsLoad:Items(E.OctoTable_itemID_ALL)
			promise:AddItems(E.PromiseItem)
			promise:AddSpells(E.PromiseSpell)
			promise:AddQuests(E.PromiseQuest)
			promise:Then(function()
					if Octo_MainFrame_OCTOMAIN:IsShown() then
						Octo_MainFrame_OCTOMAIN:Hide()
						Octo_MainFrame_OCTOMAIN:Show()
					end
			end)
			-- promise:FailWithChecked(function(...) print (...) end)
	end)
end
function Octo_EventFrame_OCTOMAIN:SHOW_SUBSCRIPTION_INTERSTITIAL()
	if not InCombatLockdown() then
		if SubscriptionInterstitialFrame then
			SubscriptionInterstitialFrame:SetScript("OnEvent", nil)
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Hide trash frames: ").."SubscriptionInterstitialFrame")
		end
	end
end
function Octo_EventFrame_OCTOMAIN:READY_CHECK()
	if not InCombatLockdown() then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
	end
end
----------------------------------------------------------------
SLASH_Octo1, SLASH_Octo2, SLASH_Octo3, SLASH_Octo4 = "/Octo", "/OctoTWW", "/octo", "/o"
function SlashCmdList.Octo(msg)
	if not InCombatLockdown() then
		Octo_EventFrame_OCTOMAIN:main_frame_toggle()
	end
end
local editFrame, editBox = _G["editFrame"], _G["editFrame"].editFrame
SLASH_GSEARCH1, SLASH_GSEARCH2 = "/gsearch", "/gs"
SlashCmdList.GSEARCH = function(msg)
	local str = ""
	local list = {}
	local color = E.classColorHexCurrent
	if E.classFilename == "PRIEST" then
		color = E.Class_Priest_Color_Alternative
	end
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
function Octo_EventFrame_OCTOMAIN:PLAYER_REGEN_DISABLED()
	if Octo_MainFrame_OCTOMAIN and Octo_MainFrame_OCTOMAIN:IsShown() then
		Octo_MainFrame_OCTOMAIN:Hide()
	end
end
----------------------------------------------------------------




local parentFrame = UIParent
function Octo_EventFrame_OCTOMAIN:LIBSHAREDSFMIC()
	local background = LibSFDropDown:CreateMediaBackgroundModernButton(parentFrame, 120) -- BACKGROUND
	background:SetPoint("TOPLEFT", 20, -20)
	background:ddSetSelectedValue(Octo_ToDo_DB_Vars.interface.Octo_background or currentValue or LibSharedMedia:GetDefault("background"))
	background:ddSetOnSelectedFunc(function(value)
			local texture = LibSharedMedia:Fetch("background", value)
			print(value, ">", texture)
			Octo_ToDo_DB_Vars.interface.Octo_background = value
			-- some code
	end)
	local border = LibSFDropDown:CreateMediaBorderModernButton(parentFrame, 120) -- BORDER
	border:SetPoint("TOPLEFT", background, "BOTTOMLEFT", 0, -10)
	border:ddSetSelectedValue(Octo_ToDo_DB_Vars.interface.Octo_border or currentValue or LibSharedMedia:GetDefault("border"))
	border:ddSetOnSelectedFunc(function(value)
			local texture = LibSharedMedia:Fetch("border", value)
			print(value, ">", texture)
			Octo_ToDo_DB_Vars.interface.Octo_border = value
			-- some code
	end)
	local statusbar = LibSFDropDown:CreateMediaStatusbarModernButton(parentFrame, 120) -- STATUSBAR
	statusbar:SetPoint("TOPLEFT", border, "BOTTOMLEFT", 0, -10)
	statusbar:ddSetSelectedValue(Octo_ToDo_DB_Vars.interface.Octo_statusbar or currentValue or LibSharedMedia:GetDefault("statusbar"))
	statusbar:ddSetOnSelectedFunc(function(value)
			local texture = LibSharedMedia:Fetch("statusbar", value)
			print(value, ">", texture)

			Octo_ToDo_DB_Vars.interface.Octo_statusbar = value
			-- some code
	end)
	local font = LibSFDropDown:CreateMediaFontModernButton(parentFrame, 120) -- FONT
	font:SetPoint("TOPLEFT", statusbar, "BOTTOMLEFT", 0, -10)
	font:ddSetSelectedValue(Octo_ToDo_DB_Vars.interface.Octo_font or currentValue or LibSharedMedia:GetDefault("font"))
	font:ddSetOnSelectedFunc(function(value)
			local selectedFont = LibSharedMedia:Fetch("font", value)
			print(value, ">", selectedFont)
			Octo_ToDo_DB_Vars.interface.Octo_font = value
			-- some code
	end)
	local sound = LibSFDropDown:CreateMediaSoundModernButton(parentFrame, 120) -- SOUND
	sound:SetPoint("TOPLEFT", font, "BOTTOMLEFT", 0, -10)
	sound:ddSetSelectedValue(Octo_ToDo_DB_Vars.interface.Octo_sound or currentValue or LibSharedMedia:GetDefault("sound"))
	sound:ddSetOnSelectedFunc(function(value)
			local selectedSound = LibSharedMedia:Fetch("sound", value)
			print(value, ">", selectedSound)
			Octo_ToDo_DB_Vars.interface.Octo_sound = value
			-- some code
	end)
end

