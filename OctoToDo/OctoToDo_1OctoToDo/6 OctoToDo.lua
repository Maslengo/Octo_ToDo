local GlobalAddonName, E = ...
local OctoToDo_EventFrame_OCTOMAIN = CreateFrame("FRAME")
OctoToDo_EventFrame_OCTOMAIN:Hide()
local OctoToDo_MainFrame_OCTOMAIN = CreateFrame("BUTTON", "OctoToDo_MainFrame_OCTOMAIN", UIParent, "BackdropTemplate")
OctoToDo_MainFrame_OCTOMAIN:Hide()
tinsert(E.OctoTable_Frames, OctoToDo_MainFrame_OCTOMAIN)
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
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")

----------------------------------------------------------------
----------------------------------------------------------------
-- E.func_LoadAddOn("OctoToDo_Achievements")
E.func_LoadAddOn("OctoToDo_AddonsManager")
-- E.func_LoadAddOn("OctoToDo_Minecraft")
E.func_LoadAddOn("OctoToDo_TrashCan")
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
function OctoToDo_EventFrame_OCTOMAIN:ConcatAtStart()
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
		frame.full = CreateFrame("FRAME", nil, frame)
		frame.full:SetPropagateMouseClicks(true)
		frame.full:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight)
		frame.full:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.full:SetPoint("RIGHT")
		frame.full.texture = frame.full:CreateTexture(nil, "BACKGROUND")
		frame.full.texture:SetAllPoints()
		frame.full.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
		frame.full.texture:SetVertexColor(1, 1, 1, 0)
		frame.full:SetScript("OnEnter", function(self) self.texture:SetVertexColor(1, 1, 1, .1) end)
		frame.full:SetScript("OnLeave", function(self) self.texture:SetVertexColor(1, 1, 1, 0) end)
		frame.full:SetPropagateMouseClicks(true)
		frame.full:SetPropagateMouseMotion(true)
		------------------------------------------------
		frame.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.icon:SetPoint("TOPLEFT", 1, -1)
		frame.icon:SetSize(AddonHeight-2, AddonHeight-2)
		frame.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		frame.left = CreateFrame("FRAME", nil, frame)
		frame.left:SetPropagateMouseClicks(true)
		frame.left:SetSize(AddonLeftFrameWeight, AddonHeight)
		frame.left:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		-- frame.left:SetPoint("RIGHT")
		frame.left.textLEFT = frame.left:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.left.textLEFT:SetPoint("LEFT", 2+AddonHeight, 0)
		frame.left.textLEFT:SetPoint("RIGHT", 0, 0)
		frame.left.textLEFT:SetFontObject(OctoFont11)
		frame.left.textLEFT:SetWordWrap(false)
		frame.left.textLEFT:SetJustifyV("MIDDLE")
		frame.left.textLEFT:SetJustifyH("LEFT")
		frame.left.textLEFT:SetTextColor(1, 1, 1, 1)
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
					-- f.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
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
function OctoToDo_EventFrame_OCTOMAIN:OctoToDo_Frame_init(frame, node)
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local data = node:GetData()
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	frame.left.textLEFT:SetText(data.textLEFT)
	frame.icon:SetTexture(data.headerIcon)
	if not data.zxc then
		for i, v in ipairs(frame.second) do
			frame.second[i]:Hide()
		end
	else
		if data.headerIcon then
			frame.icon:SetTexture(data.headerIcon)
			-- frame.icon:SetPoint("TOPLEFT", 1, -1)
			-- frame.left.textLEFT:SetPoint("LEFT", 2+AddonHeight, 0)
		elseif data.zxc.icon then
			frame.icon:SetTexture(data.zxc.icon)
			-- frame.icon:SetPoint("TOPLEFT", 1+AddonHeight, -1)
		else
			frame.icon:SetTexture(E.Icon_Empty)
			-- frame.icon:SetPoint("TOPLEFT", 1+AddonHeight, -1)
			-- frame.left.textLEFT:SetPoint("LEFT", 2+AddonHeight+AddonHeight, 0)
		end
		for i = 1, #data.zxc.textCENT do
			if data.zxc.textCENT[i] and data.zxc.textCENT[i] ~= "" then
				local textCENT = data.zxc.textCENT[i]
				local FIRST = data.zxc.FIRST[i]
				local SECOND = data.zxc.SECOND[i]
				local color = data.zxc.color[i]
				local r, g, b = E.func_hex2rgbNUMBER(color)
				frame.second[i].textCENT:SetText(color..textCENT.."|r")
				frame.second[i].texture:SetColorTexture(r, g, b, E.bgCaOverlay*3) -- SetVertexColor
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
				frame.second[i].texture:SetColorTexture(0, 0, 0, 0) -- SetVertexColor
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
function OctoToDo_EventFrame_OCTOMAIN:OctoToDo_Create_MainFrame_OCTOMAIN()
	OctoToDo_MainFrame_OCTOMAIN:SetPoint("CENTER", 0, 0)
	-- OctoToDo_MainFrame_OCTOMAIN:SetPoint("TOP", 0, -200)
	local NumPlayers = E.func_NumPlayers()
	if NumPlayers > 8 then
		NumPlayers = 8
	end
	OctoToDo_MainFrame_OCTOMAIN:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*NumPlayers, AddonHeight*MainFrameDefaultLines)
	OctoToDo_MainFrame_OCTOMAIN:SetDontSavePosition(true)
	OctoToDo_MainFrame_OCTOMAIN:SetClampedToScreen(false)
	OctoToDo_MainFrame_OCTOMAIN:SetFrameStrata("HIGH")
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local barPanelScroll = CreateFrame("scrollFrame", nil, OctoToDo_MainFrame_OCTOMAIN)
	barPanelScroll:SetPoint("TOPLEFT", OctoToDo_MainFrame_OCTOMAIN)
	barPanelScroll:SetPoint("BOTTOMRIGHT", OctoToDo_MainFrame_OCTOMAIN)
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
	local HorizontalScrollBar = CreateFrame("EventFrame", nil, OctoToDo_MainFrame_OCTOMAIN, "OctoWowTrimHorizontalScrollBar")
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
	OctoToDo_MainFrame_OCTOMAIN.child = CreateFrame("FRAME")
	OctoToDo_MainFrame_OCTOMAIN.child:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight*MainFrameDefaultLines)
	HorizontalScrollBar:SetScript("OnSizeChanged", function(self)
			self:SetShown(not WithinRangeExclusive(self:GetVisibleExtentPercentage(), MathUtil.Epsilon, 1 - MathUtil.Epsilon))
	end)
	-- OctoToDo_MainFrame_OCTOMAIN.child.texture = OctoToDo_MainFrame_OCTOMAIN.child:CreateTexture(nil, "BACKGROUND")
	-- OctoToDo_MainFrame_OCTOMAIN.child.texture:SetAllPoints()
	-- OctoToDo_MainFrame_OCTOMAIN.child.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
	barPanelScroll:SetScrollChild(OctoToDo_MainFrame_OCTOMAIN.child)
	OctoToDo_MainFrame_OCTOMAIN.ScrollBox = CreateFrame("FRAME", "ScrollBox", OctoToDo_MainFrame_OCTOMAIN.child, "WowScrollBoxList")
	OctoToDo_MainFrame_OCTOMAIN.ScrollBox:SetPoint("TOPLEFT", 0, -AddonHeight)
	OctoToDo_MainFrame_OCTOMAIN.ScrollBox:SetPoint("BOTTOMRIGHT")
	OctoToDo_MainFrame_OCTOMAIN.ScrollBox:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_OCTOMAIN.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	-- OctoToDo_MainFrame_OCTOMAIN.ScrollBox:SetHorizontal(true)
	OctoToDo_MainFrame_OCTOMAIN.ScrollBar = CreateFrame("EventFrame", "ScrollBar", OctoToDo_MainFrame_OCTOMAIN, "MinimalScrollBar")
	OctoToDo_MainFrame_OCTOMAIN.ScrollBar:SetPoint("TOPLEFT", OctoToDo_MainFrame_OCTOMAIN, "TOPRIGHT", 6, 0)
	OctoToDo_MainFrame_OCTOMAIN.ScrollBar:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_OCTOMAIN, "BOTTOMRIGHT", 6, 0)
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	OctoToDo_MainFrame_OCTOMAIN.view = CreateScrollBoxListTreeListView(0)
	OctoToDo_MainFrame_OCTOMAIN.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_OCTOMAIN.view:SetElementInitializer("Frame",
		function(...)
			self:OctoToDo_Frame_init(...)
	end)
	OctoToDo_MainFrame_OCTOMAIN.view:RegisterCallback(OctoToDo_MainFrame_OCTOMAIN.view.Event.OnAcquiredFrame, func_OnAcquired, OctoToDo_MainFrame_OCTOMAIN)
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame_OCTOMAIN.ScrollBox, OctoToDo_MainFrame_OCTOMAIN.ScrollBar, OctoToDo_MainFrame_OCTOMAIN.view)
	----------------------------------------------------------------
	-- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА/ЕСЛИ НЕНУЖНЫ
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame_OCTOMAIN.ScrollBox, OctoToDo_MainFrame_OCTOMAIN.ScrollBar)
	----------------------------------------------------------------
	OctoToDo_MainFrame_OCTOMAIN:SetBackdrop({
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
	OctoToDo_MainFrame_OCTOMAIN:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoToDo_MainFrame_OCTOMAIN:SetBackdropBorderColor(0, 0, 0, 1)
	OctoToDo_MainFrame_OCTOMAIN:EnableMouse(true)
	OctoToDo_MainFrame_OCTOMAIN:SetMovable(true)
	-- OctoToDo_MainFrame_OCTOMAIN:RegisterForDrag("LeftButton")
	OctoToDo_MainFrame_OCTOMAIN:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				OctoToDo_MainFrame_OCTOMAIN:SetAlpha(E.bgCa)
				OctoToDo_MainFrame_OCTOMAIN:StartMoving()
			end
	end)
	OctoToDo_MainFrame_OCTOMAIN:SetScript("OnMouseUp", function(self, button)
			if button == "LeftButton" then
				OctoToDo_MainFrame_OCTOMAIN:SetAlpha(1)
				OctoToDo_MainFrame_OCTOMAIN:StopMovingOrSizing()
			end
	end)
	-- OctoToDo_MainFrame_OCTOMAIN:SetScript("OnDragStart", function()
	--         OctoToDo_MainFrame_OCTOMAIN:SetAlpha(E.bgCa)
	--         OctoToDo_MainFrame_OCTOMAIN:StartMoving()
	-- end)
	-- OctoToDo_MainFrame_OCTOMAIN:SetScript("OnDragStop", function()
	--         OctoToDo_MainFrame_OCTOMAIN:SetAlpha(1)
	--         OctoToDo_MainFrame_OCTOMAIN:StopMovingOrSizing()
	-- end)
	OctoToDo_MainFrame_OCTOMAIN:RegisterForClicks("RightButtonUp")
	OctoToDo_MainFrame_OCTOMAIN:SetScript("OnClick", function(self) self:Hide() end)
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
	OctoToDo_MainFrame_OCTOMAIN.pool = CreateFramePool("FRAME", OctoToDo_MainFrame_OCTOMAIN.child, "BackdropTemplate", resetFunc, false, initFunc)
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
	if OctoToDo_DB_Vars.Reputations then
		for index, tbl in ipairs(E.OctoTable_Reputations) do
			if OctoToDo_DB_Vars.ExpansionToShow[index] then
				numlines = numlines + 1
				local groupNodeFirst = DataProvider:Insert({
						textLEFT = tbl.header.name,
						headerIcon = tbl.header.icon,
				})
				for _, v in ipairs(tbl) do
					if (OctoToDo_DB_Vars.OnlyCurrentFaction == true and (E.OctoTable_ReputationsDB[v.id].side == E.func_UnitFaction("PLAYER") or E.OctoTable_ReputationsDB[v.id].side == "-")) or not OctoToDo_DB_Vars.OnlyCurrentFaction then
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
	if MainFrameDefaultLines > OctoToDo_DB_Vars.MainFrameDefaultLines then
		MainFrameDefaultLines = OctoToDo_DB_Vars.MainFrameDefaultLines
	end
	if MainFrameDefaultLines < 1 then MainFrameDefaultLines = 1 end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	OctoToDo_MainFrame_OCTOMAIN:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*NumPlayers, AddonHeight*MainFrameDefaultLines+AddonHeight)
	OctoToDo_MainFrame_OCTOMAIN.child:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight*MainFrameDefaultLines+AddonHeight)
	OctoToDo_MainFrame_OCTOMAIN.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
	----------------------------------------------------------------
	--------------------------- POOL -------------------------------
	----------------------------------------------------------------
	OctoToDo_MainFrame_OCTOMAIN.pool:ReleaseAll()
	for count, CharInfo in next, (E.sorted()) do
		local curCharFrame = OctoToDo_MainFrame_OCTOMAIN.pool:Acquire()
		curCharFrame:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_OCTOMAIN.child, "TOPLEFT", (AddonLeftFrameWeight-AddonCentralFrameWeight)+(AddonCentralFrameWeight*count), -AddonHeight)
		curCharFrame.text:SetText(E.func_vivodCent(CharInfo))
		if CharInfo.Faction == "Horde" then
			E:func_SetBackdrop(curCharFrame, "|cfff01e38", E.bgCaOverlay*2, 0)
		else
			E:func_SetBackdrop(curCharFrame, "|cff0070DD", E.bgCaOverlay*2, 0)
		end
		-- curCharFrame:RegisterForClicks("RightButtonUp")
		-- curCharFrame:SetScript("OnClick", function() OctoToDo_MainFrame_OCTOMAIN:Hide() end)
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
	--OctoToDo_DB_Vars.DebugFunction
	local updateScheduled = false
	local isMainFrameVisible = OctoToDo_MainFrame_OCTOMAIN and OctoToDo_MainFrame_OCTOMAIN:IsShown()
	if isMainFrameVisible then
		if not updateScheduled then
			updateScheduled = true
			C_Timer.After(0.1, function()
					updateScheduled = false
					if OctoToDo_MainFrame_OCTOMAIN and OctoToDo_MainFrame_OCTOMAIN:IsShown() then
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

----------------------------------------------------------------
function OctoToDo_EventFrame_OCTOMAIN:func_CreateMineFrame()
	local pizda = false
	if pizda == true then
		local colorBtn =  CreateFrame("BUTTON", nil, UIParent, "BackdropTemplate")
		colorBtn:SetBackdrop({
				edgeFile = E.edgeFile,
				edgeSize = 1,
				insets = {left = 1, right = 1, top = 1, bottom = 1},
		})
		colorBtn:SetBackdropBorderColor(0, 0, 0, bbalpha)
		colorBtn:SetSize(32, 16)
		colorBtn:SetPoint("TOPLEFT", 50, -50)
		-- colorBtn:SetNormalTexture("Interface/ChatFrame/ChatFrameColorSwatch")
		colorBtn:SetNormalTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
		local colorTex = colorBtn:GetNormalTexture()
		colorTex:SetColorTexture(unpack(OctoToDo_DB_Vars.color))
		colorTex:ClearAllPoints()
		colorTex:SetPoint("TOPLEFT", 1, -1)
		colorTex:SetPoint("BOTTOMRIGHT", -1, 1)
		colorBtn.swatchFunc = function()
			colorTex:SetColorTexture(ColorPickerFrame:GetColorRGB())
			OctoToDo_DB_Vars.color = {ColorPickerFrame:GetColorRGB()}
			MineFrame.FG:SetVertexColor(ColorPickerFrame:GetColorRGB())
			-- self:setCursorSettings()
		end
		colorBtn.cancelFunc = function(color)
			OctoToDo_DB_Vars.color = {color.r, color.g, color.b, color.a}
			colorTex:SetColorTexture(color.r, color.g, color.b)
			MineFrame.FG:SetVertexColor(color.r, color.g, color.b, color.a)
			-- self:setCursorSettings()
		end
		colorBtn.hasOpacity = true
		colorBtn.opacityFunc = function()
			local a = ColorPickerFrame:GetColorAlpha()
			OctoToDo_DB_Vars.color[4] = a
			colorTex:SetAlpha(a)
		end
		colorBtn:SetScript("OnClick", function(btn)
				btn.r, btn.g, btn.b, btn.opacity = unpack(OctoToDo_DB_Vars.color)
				if OpenColorPicker then
					OpenColorPicker(btn)
				else
					ColorPickerFrame:SetupColorPickerAndShow(btn)
				end
		end)
		-- local r, g, b = E.func_hex2rgbNUMBER(E.Yellow_Color)
		colorBtn:SetScript("OnEnter", function(btn)
				btn:SetBackdropBorderColor(r, g, b, 1)
		end)
		colorBtn:SetScript("OnLeave", function(btn)
				btn:SetBackdropBorderColor(0, 0, 0, 1)
		end)
		local btnResetColor = CreateFrame("BUTTON", nil, UIParent, "UIPanelButtonTemplate")
		btnResetColor:SetSize(64, 24)
		btnResetColor:SetPoint("LEFT", colorBtn, "RIGHT", 3, 0)
		btnResetColor:SetText(RESET)
		btnResetColor:SetScript("OnClick", function()
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
				colorTex:SetColorTexture(1, 1, 1)
				colorTex:SetAlpha(1)
				MineFrame.FG:SetVertexColor(1,1,1,1)
				OctoToDo_DB_Vars.color = {1, 1, 1, 1}
				-- config:setCursorSettings()
		end)
		----
		local MineFrame = CreateFrame("Frame", "MineFrame", UIParent, "BackdropTemplate")
		MineFrame:SetPoint("TOPLEFT", 100, -100)
		MineFrame:SetSize(1256, 68)
		MineFrame:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
		MineFrame:SetBackdropColor(29/255, 42/255, 76/255, 1)
		MineFrame:SetBackdropBorderColor(0, 0, 0, 0)
		MineFrame.FG = MineFrame:CreateTexture(nil, "BACKGROUND", nil, 2)
		MineFrame.FG:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\MINECRAFT\\minecraft FG.tga")
		MineFrame.FG:SetAllPoints(MineFrame)
		MineFrame.FG:SetVertexColor(unpack(OctoToDo_DB_Vars.color))
		MineFrame.BG = MineFrame:CreateTexture(nil, "BACKGROUND", nil, 3)
		MineFrame.BG:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\MINECRAFT\\minecraft BG.tga")
		MineFrame.BG:SetAllPoints(MineFrame)
		-- MineFrame.BG:SetVertexColor(unpack(OctoToDo_DB_Vars.color))
	end
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
	E.RegisterMyEventsToFrames(OctoToDo_EventFrame_OCTOMAIN, MyEventsTable, E.func_DebugPath())
end
function OctoToDo_EventFrame_OCTOMAIN:ADDON_LOADED(addonName)
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
		self:ConcatAtStart()
		for i, func in next, (E.Modules) do
			func()
		end
	end
end
function OctoToDo_EventFrame_OCTOMAIN:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
	-- self:LIBSHAREDSFMIC()
	C_WowTokenPublic.UpdateMarketPrice()
	self:func_CreateMineFrame()
	GameMenuFrame:SetScale(OctoToDo_DB_Vars.GameMenuFrameScale or 1)
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
	self:OctoToDo_Create_MainFrame_OCTOMAIN()
	E.PortalsFrame()
	E.func_Create_DD_OCTOMAIN()
	----------------------------------------------------------------
	local totalMoney = 0
	local totalReload = 0
	local realTotalTime = 0
	local TodayTimePlayedtotal = 0
	local realLevelTime = 0
	for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
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
	-- E.func_CreateInfoFrame("Money: "..E.classColorHexCurrent..E.func_CompactNumberFormat(totalMoney/10000).."|r "..E.curServerShort, "TOPLEFT", OctoToDo_MainFrame_OCTOMAIN, "BOTTOMLEFT", -AddonHeight*0, 0, AddonLeftFrameWeight, AddonHeight)
	-- E.func_CreateInfoFrame("Reloads: "..E.classColorHexCurrent..totalReload.."|r", "TOPLEFT", OctoToDo_MainFrame_OCTOMAIN, "BOTTOMLEFT", 0, -AddonHeight*1, AddonLeftFrameWeight, AddonHeight)
	-- E.func_CreateInfoFrame("realTotalTime: "..E.classColorHexCurrent..E.func_SecondsToClock(realTotalTime).."|r", "TOPLEFT", OctoToDo_MainFrame_OCTOMAIN, "BOTTOMLEFT", 0, -AddonHeight*2, AddonLeftFrameWeight, AddonHeight)
	if realLevelTime ~= 0 then
		E.func_CreateInfoFrame("realLevelTime: "..E.classColorHexCurrent..E.func_SecondsToClock(realLevelTime).."|r", "TOPLEFT", OctoToDo_MainFrame_OCTOMAIN, "BOTTOMLEFT", 0, -AddonHeight*3, AddonLeftFrameWeight, AddonHeight)
	end
	E:func_CreateUtilsButton(OctoToDo_MainFrame_OCTOMAIN, "Core", AddonHeight, 0)
	E:func_CreateMinimapButton(GlobalAddonName, "Core", OctoToDo_DB_Vars, OctoToDo_MainFrame_OCTOMAIN, function()
			E.func_CreateMyDataProvider()
			RequestRaidInfo()
	end, "OctoToDo_MainFrame_OCTOMAIN")
	C_Timer.After(0, function()
			-- E.PromiseItem = {}
			-- E.PromiseSpell = {}
			-- E.PromiseQuest = {}
			local promise = LibThingsLoad:Items(E.OctoTable_itemID_ALL)
			promise:AddItems(E.PromiseItem)
			promise:AddSpells(E.PromiseSpell)
			promise:AddQuests(E.PromiseQuest)
			promise:Then(function()
					if OctoToDo_MainFrame_OCTOMAIN:IsShown() then
						OctoToDo_MainFrame_OCTOMAIN:Hide()
						OctoToDo_MainFrame_OCTOMAIN:Show()
					end
			end)
			-- promise:FailWithChecked(function(...) print (...) end)
	end)
end
function OctoToDo_EventFrame_OCTOMAIN:SHOW_SUBSCRIPTION_INTERSTITIAL()
	if not InCombatLockdown() then
		if SubscriptionInterstitialFrame then
			SubscriptionInterstitialFrame:SetScript("OnEvent", nil)
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Hide trash frames: ").."SubscriptionInterstitialFrame")
		end
	end
end
function OctoToDo_EventFrame_OCTOMAIN:READY_CHECK()
	if not InCombatLockdown() then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
	end
end
----------------------------------------------------------------
SLASH_Octo1, SLASH_Octo2, SLASH_Octo3, SLASH_Octo4 = "/Octo", "/OctoTWW", "/octo", "/o"
function SlashCmdList.Octo(msg)
	if not InCombatLockdown() then
		OctoToDo_EventFrame_OCTOMAIN:main_frame_toggle()
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
function OctoToDo_EventFrame_OCTOMAIN:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_OCTOMAIN and OctoToDo_MainFrame_OCTOMAIN:IsShown() then
		OctoToDo_MainFrame_OCTOMAIN:Hide()
	end
end
----------------------------------------------------------------




-- local parentFrame = UIParent
-- function OctoToDo_EventFrame_OCTOMAIN:LIBSHAREDSFMIC()
-- 	local background = LibSFDropDown:CreateMediaBackgroundModernButton(parentFrame, 120) -- BACKGROUND
-- 	background:SetPoint("TOPLEFT", 20, -20)
-- 	background:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("background"))
-- 	background:ddSetOnSelectedFunc(function(value)
-- 			local texture = LibSharedMedia:Fetch("background", value)
-- 			print(value, texture)
-- 			-- some code
-- 	end)
-- 	local border = LibSFDropDown:CreateMediaBorderModernButton(parentFrame, 120) -- BORDER
-- 	border:SetPoint("TOPLEFT", background, "BOTTOMLEFT", 0, -10)
-- 	border:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("border"))
-- 	border:ddSetOnSelectedFunc(function(value)
-- 			local texture = LibSharedMedia:Fetch("border", value)
-- 			print(value, texture)
-- 			-- some code
-- 	end)
-- 	local statusbar = LibSFDropDown:CreateMediaStatusbarModernButton(parentFrame, 120) -- STATUSBAR
-- 	statusbar:SetPoint("TOPLEFT", border, "BOTTOMLEFT", 0, -10)
-- 	statusbar:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("statusbar"))
-- 	statusbar:ddSetOnSelectedFunc(function(value)
-- 			local texture = LibSharedMedia:Fetch("statusbar", value)
-- 			print(value, texture)
-- 			-- some code
-- 	end)
-- 	local font = LibSFDropDown:CreateMediaFontModernButton(parentFrame, 120) -- FONT
-- 	font:SetPoint("TOPLEFT", statusbar, "BOTTOMLEFT", 0, -10)
-- 	font:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("font"))
-- 	font:ddSetOnSelectedFunc(function(value)
-- 			local selectedFont = LibSharedMedia:Fetch("font", value)
-- 			print(value, selectedFont)
-- 			-- some code
-- 	end)
-- 	local sound = LibSFDropDown:CreateMediaSoundModernButton(parentFrame, 120) -- SOUND
-- 	sound:SetPoint("TOPLEFT", font, "BOTTOMLEFT", 0, -10)
-- 	sound:ddSetSelectedValue(currentValue or LibSharedMedia:GetDefault("sound"))
-- 	sound:ddSetOnSelectedFunc(function(value)
-- 			local selectedSound = LibSharedMedia:Fetch("sound", value)
-- 			print(value, selectedSound)
-- 			-- some code
-- 	end)
-- end