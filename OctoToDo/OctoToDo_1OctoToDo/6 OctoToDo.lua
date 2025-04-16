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
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
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
		frame.full = CreateFrame("FRAME", nil, frame, "BackDropTemplate")
		frame.full:SetPropagateMouseClicks(true)
		frame.full:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight)
		frame.full:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.full:SetPoint("RIGHT")
		E:func_SetBackdrop(frame.full, nil, 0, 0)
		-- frame.full:SetFrameLevel(frame:GetFrameLevel()-1)
		-- frame.full:SetFrameStrata("BACKGROUND")
		frame.full.texture = frame.full:CreateTexture(nil, "BACKGROUND")
		frame.full.texture:SetAllPoints()
		frame.full.texture:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\01 Octo Naowh.tga")
		frame.full.texture:SetVertexColor(1, 1, 1, 0)
		frame.full:SetScript("OnEnter", function(self) self.texture:SetVertexColor(1, 1, 1, .1) end)
		frame.full:SetScript("OnLeave", function(self) self.texture:SetVertexColor(1, 1, 1, 0) end)
		frame.full:SetPropagateMouseClicks(true)
		frame.full:SetPropagateMouseMotion(true)
		-- frame.first = CreateFrame("FRAME", nil, frame, "BackDropTemplate")
		-- frame.first:SetPropagateMouseClicks(false)
		-- frame.first:SetSize(AddonHeight, AddonHeight)
		-- frame.first:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.icon = frame:CreateTexture(nil, "BACKGROUND", nil, -2)
		frame.icon:SetPoint("TOPLEFT", 1, -1)
		frame.icon:SetSize(AddonHeight-2, AddonHeight-2)
		frame.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		------------------------------------------------
		frame.left = CreateFrame("FRAME", "frame.left", frame, "BackdropTemplate")
		frame.left:SetPropagateMouseClicks(true)
		frame.left:SetSize(AddonLeftFrameWeight, AddonHeight)
		frame.left:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		-- frame.left:SetFrameLevel(frame:GetFrameLevel()-1) -- ПОФИКСИТЬ -- https://warcraft.wiki.gg/wiki/API_Frame_CreateTexture --https://warcraft.wiki.gg/wiki/API_Frame_CreateMaskTexture
		frame.left.text = frame.left:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.left.text:SetPoint("LEFT", AddonHeight+1, 0)
		frame.left.text:SetPoint("RIGHT", 0, 0)
		frame.left.text:SetFontObject(OctoFont11)
		frame.left.text:SetWordWrap(false)
		frame.left.text:SetJustifyV("MIDDLE")
		frame.left.text:SetJustifyH("LEFT")
		frame.left.text:SetTextColor(1, 1, 1, 1)
		------------------------------------------------
		frame.cent  = setmetatable({}, {
				__index = function(self, key)
					local f = CreateFrame("FRAME", "frame"..key, frame, "BackdropTemplate")
					f:SetPropagateMouseClicks(true)
					f:SetSize(AddonCentralFrameWeight, AddonHeight)
					f:SetPoint("TOPLEFT", frame.left, "TOPLEFT", (AddonLeftFrameWeight-AddonCentralFrameWeight)+(AddonCentralFrameWeight*key), 0)
					f.text = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
					f.text:SetAllPoints()
					f.text:SetFontObject(OctoFont11)
					f.text:SetJustifyV("MIDDLE")
					f.text:SetJustifyH("CENTER")
					f.text:SetTextColor(1, 1, 1, 1)
					f:SetScript("OnEnter",     function()
							E.func_TooltipOnEnter(f, true, true)
					end)
					f:SetScript("OnLeave", GameTooltip_Hide)
					f:SetScript("OnHide", f.Hide)
					self[key] = f
					return f
		end})
		------------------------------------------------
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ (АПДЕЙТ)
local function OctoToDo_Frame_init(frame, data)
	if data.firsticonTexture then
		frame.icon:SetTexture(data.firsticonTexture)
	else
		frame.icon:SetTexture(E.Icon_Empty)
	end
	frame.left.text:SetText(data.left)
	-- if data.index % 2 == 0 then
	--     E:func_SetBackdrop(frame.left, nil, 0, 0)
	-- else
	--     E:func_SetBackdrop(frame.left, "|cff000000", E.bgCaOverlay, 0)
	-- end
	E:func_SetBackdrop(frame.left, data.BGcolor, E.bgCaOverlay, 0)
	for NumPlayers = 1, #data do
		frame.cent[NumPlayers].text:SetText(data[NumPlayers][1])
		frame.cent[NumPlayers].tooltip = data[NumPlayers][2]
		frame.cent[NumPlayers]:Show()
		if data[NumPlayers].currentChar then
			E:func_SetBackdrop(frame.cent[NumPlayers], E.classColorHexCurrent, E.bgCaOverlay, 0)
		else
			-- if data.index % 2 == 0 then
			--     E:func_SetBackdrop(frame.cent[NumPlayers], nil, 0, 0)
			-- else
			--     E:func_SetBackdrop(frame.cent[NumPlayers], "|cff000000", E.bgCaOverlay, 0)
			-- end
		end
		if data[NumPlayers][3] then
			E:func_SetBackdrop(frame.cent[NumPlayers], data[NumPlayers][3], E.bgCaOverlay, 0)
		else
			E:func_SetBackdrop(frame.cent[NumPlayers], nil, 0, 0)
		end
	end
end


function OctoToDo_EventFrame_OCTOMAIN:OctoToDo_Create_MainFrame_OCTOMAIN()
	OctoToDo_MainFrame_OCTOMAIN:SetPoint("CENTER", 0, 0)
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

	HorizontalScrollBar:SetScript("OnSizeChanged", function (self)
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
	OctoToDo_MainFrame_OCTOMAIN.view = CreateScrollBoxListLinearView()
	OctoToDo_MainFrame_OCTOMAIN.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_OCTOMAIN.view:SetElementInitializer("BackdropTemplate", OctoToDo_Frame_init)
	OctoToDo_MainFrame_OCTOMAIN.view:RegisterCallback(OctoToDo_MainFrame_OCTOMAIN.view.Event.OnAcquiredFrame, func_OnAcquired, OctoToDo_MainFrame_OCTOMAIN)
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame_OCTOMAIN.ScrollBox, OctoToDo_MainFrame_OCTOMAIN.ScrollBar, OctoToDo_MainFrame_OCTOMAIN.view)
	-- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame_OCTOMAIN.ScrollBox, OctoToDo_MainFrame_OCTOMAIN.ScrollBar)





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
	OctoToDo_MainFrame_OCTOMAIN:RegisterForDrag("LeftButton")

	OctoToDo_MainFrame_OCTOMAIN:SetScript("OnMouseDown", function()
			OctoToDo_MainFrame_OCTOMAIN:SetAlpha(E.bgCa)
			OctoToDo_MainFrame_OCTOMAIN:StartMoving()
	end)
	OctoToDo_MainFrame_OCTOMAIN:SetScript("OnMouseUp", function()
			OctoToDo_MainFrame_OCTOMAIN:SetAlpha(1)
			OctoToDo_MainFrame_OCTOMAIN:StopMovingOrSizing()
	end)
	-- OctoToDo_MainFrame_OCTOMAIN:SetScript("OnDragStart", function()
	-- 		OctoToDo_MainFrame_OCTOMAIN:SetAlpha(E.bgCa)
	-- 		OctoToDo_MainFrame_OCTOMAIN:StartMoving()
	-- end)
	-- OctoToDo_MainFrame_OCTOMAIN:SetScript("OnDragStop", function()
	-- 		OctoToDo_MainFrame_OCTOMAIN:SetAlpha(1)
	-- 		OctoToDo_MainFrame_OCTOMAIN:StopMovingOrSizing()
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
	self:func_CreateMyDataProvider()
end

function OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
	print ("func_CreateMyDataProvider")
	local NumPlayers = E.func_NumPlayers()
	if NumPlayers > 8 then
		NumPlayers = 8
	end
	local ShowOnlyCurrentServer = OctoToDo_DB_Vars.ShowOnlyCurrentServer
	local ShowOnlyCurrentBattleTag = OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
	local OctoTable_func_otrisovkaCENT, OctoTable_func_otrisovkaLEFT = E:func_Otrisovka()
	local CENT = {}
	for i, func in ipairs(OctoTable_func_otrisovkaCENT) do
		CENT[i] = CENT[i] or {}
		CENT[i].left = OctoTable_func_otrisovkaLEFT[i]()
		CENT[i].firsticonTexture = select(2, OctoTable_func_otrisovkaLEFT[i]())
		CENT[i].BGcolor = select(3, OctoTable_func_otrisovkaLEFT[i]())
		CENT[i].index = i
		for index, CharInfo in ipairs(E.sorted()) do
			CENT[i][index] = {func(CharInfo)}
			CENT[i][index].currentChar = CharInfo.GUID == E.curGUID
		end
	end
	local newcount = #OctoTable_func_otrisovkaCENT
	MainFrameDefaultLines = newcount
	if MainFrameDefaultLines > OctoToDo_DB_Vars.MainFrameDefaultLines then
		MainFrameDefaultLines = OctoToDo_DB_Vars.MainFrameDefaultLines
	end
	if MainFrameDefaultLines < 1 then MainFrameDefaultLines = 1 end
	local DataProvider = CreateDataProvider(CENT)
	OctoToDo_MainFrame_OCTOMAIN:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*NumPlayers, AddonHeight*MainFrameDefaultLines+AddonHeight)
	OctoToDo_MainFrame_OCTOMAIN.child:SetSize(AddonLeftFrameWeight+AddonCentralFrameWeight*E.func_NumPlayers(), AddonHeight*MainFrameDefaultLines+AddonHeight)
	OctoToDo_MainFrame_OCTOMAIN.ScrollBox:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
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
						-- OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
					end
			end)
		end
	else
		if E.DebugEvent then
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.Update(", E.Addon_Left_Color, E.Addon_Right_Color)..event_name..E.Addon_Right_Color..")|r")
		end
	end
end
function OctoToDo_EventFrame_OCTOMAIN:func_Create_DD_OCTOMAIN()
	local DD_OCTOMAIN = CreateFrame("Button", "DD_OCTOMAIN", OctoToDo_MainFrame_OCTOMAIN, "SecureActionButtonTemplate, BackDropTemplate")
	DD_OCTOMAIN:SetSize(SFDropDownWeight, AddonHeight)
	E:func_SetBackdrop(DD_OCTOMAIN)
	DD_OCTOMAIN.ExpandArrow = DD_OCTOMAIN:CreateTexture(nil, "ARTWORK")
	DD_OCTOMAIN.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DD_OCTOMAIN.ExpandArrow:SetSize(16, 16)
	DD_OCTOMAIN.ExpandArrow:SetPoint("RIGHT", -4, 0)
	DD_OCTOMAIN.text = DD_OCTOMAIN:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD_OCTOMAIN.text:SetAllPoints()
	DD_OCTOMAIN.text:SetFontObject(OctoFont11)
	DD_OCTOMAIN.text:SetJustifyV("MIDDLE")
	DD_OCTOMAIN.text:SetJustifyH("CENTER")
	DD_OCTOMAIN.text:SetTextColor(1, 1, 1, 1)
	DD_OCTOMAIN.text:SetText(E.classColorHexCurrent..L["Characters"].."|r")
	LibSFDropDown:SetMixin(DD_OCTOMAIN)
	DD_OCTOMAIN:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_OCTOMAIN, "TOPLEFT", 0, 0)
	DD_OCTOMAIN:ddSetDisplayMode(GlobalAddonName)
	DD_OCTOMAIN:ddSetNoGlobalMouseEvent(true)
	DD_OCTOMAIN:ddHideWhenButtonHidden()
	DD_OCTOMAIN:RegisterForClicks("LeftButtonUp")
	DD_OCTOMAIN:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
		end
	)
	local function selectFunctionisShownPLAYER(menuButton, _, _, checked)
		OctoToDo_DB_Levels[menuButton.value].isShownPLAYER = checked
		OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
	end
	local function func_remove_GUID(menuButton)
		OctoToDo_DB_Levels[menuButton.value] = nil
		OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
	end
	local function selectFunctionExpansion(menuButton, _, _, checked)
		OctoToDo_DB_Vars.ExpansionToShow[menuButton.value] = checked or nil
		-- DD_OCTOMAIN:SetText("EXP")
		OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
	end
	DD_OCTOMAIN:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			local count = 0
			local ShowOnlyCurrentServer = OctoToDo_DB_Vars.ShowOnlyCurrentServer
			local ShowOnlyCurrentBattleTag = OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
			if level == 1 then
				local BnetList = {}
				local OctoToDo_BatlleNets = {}
				for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
					if not BnetList[CharInfo.BattleTagLocal] then
						count = count + 1
						OctoToDo_BatlleNets[count] = CharInfo.BattleTagLocal
					end
					BnetList[CharInfo.BattleTagLocal] = true
				end
				sort(OctoToDo_BatlleNets)
				if count > 1 then
					for i, Bnets in ipairs(OctoToDo_BatlleNets) do
						local info = {}
						info.fontObject = OctoFont11
						info.hasArrow = true
						info.keepShownOnClick = true
						info.notCheckable = true
						local vivod = Bnets
						if Bnets == E.BattleTagLocal then
							vivod = E.classColorHexCurrent..Bnets.."|r"
						end
						if ShowOnlyCurrentBattleTag == true then
							if Bnets ~= E.BattleTagLocal then
								vivod = E.Gray_Color..vivod.."|r"
							end
						end
						info.text = vivod
						info.value = Bnets
						tinsert(list, info)
					end
				else
					local GUID, CharInfo = next(OctoToDo_DB_Levels)
					value = CharInfo.BattleTagLocal
				end
			end
			self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			if type(value) == "string" then
				local tbl_Players = {}
				for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
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
					if ShowOnlyCurrentBattleTag and (value ~= E.BattleTagLocal or ShowOnlyCurrentServer and Server ~= E.curServer)
					or not ShowOnlyCurrentBattleTag and ShowOnlyCurrentServer and Server ~= E.curServer
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
						local infoA = OctoToDo_DB_Levels[a]
						local infoB = OctoToDo_DB_Levels[b]
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
					local vivod = OctoToDo_DB_Levels[GUID].classColorHex..OctoToDo_DB_Levels[GUID].Name.."|r"
					if OctoToDo_DB_Levels[GUID].UnitLevel ~= E.currentMaxLevel then
						vivod = vivod.." "..E.Yellow_Color..OctoToDo_DB_Levels[GUID].UnitLevel.."|r"
					end
					info.text = vivod
					info.value = GUID
					info.func = selectFunctionisShownPLAYER
					info.checked = OctoToDo_DB_Levels[GUID].isShownPLAYER
					info.remove = func_remove_GUID
					info.removeDoNotHide = true
					info.icon = OctoToDo_DB_Levels[GUID].specIcon
					info.iconInfo = {tSizeX = 16, tSizeY = 16}
					tinsert(list, info)
				end
				self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			end
			if level == 1 then
				----------------
				self:ddAddSeparator(level)
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = false
				info.isNotRadio = true
				info.text = L["Only Current Server"]
				info.hasArrow = nil
				info.checked = OctoToDo_DB_Vars.ShowOnlyCurrentServer
				info.func = function(_, _, _, checked)
					OctoToDo_DB_Vars.ShowOnlyCurrentServer = checked
					OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				if count > 1 then
					info.fontObject = OctoFont11
					info.keepShownOnClick = false
					info.notCheckable = false
					info.isNotRadio = true
					info.text = L["Only Current BattleTag"]
					info.hasArrow = nil
					info.checked = OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
					info.func = function(_, _, _, checked)
						OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag = checked
						OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
					end
					self:ddAddButton(info, level)
				end
				----------------
				self:ddAddSeparator(level)
				----------------
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = "Show all"
				info.icon = false
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
						CharInfo.isShownPLAYER = true
					end
					OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = "Hide all"
				info.icon = false
				info.hasArrow = nil
				info.func = function(_, _, _, checked)
					for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
						CharInfo.isShownPLAYER = false
					end
					OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
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
				info.func = function(_, _, _, checked)
					for expansionID, v in ipairs(E.OctoTable_Expansions) do
						OctoToDo_DB_Vars.ExpansionToShow[expansionID] = true
					end
					OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
				end
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
					info.checked = OctoToDo_DB_Vars.ExpansionToShow[expansionID]
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
						OctoToDo_DB_Vars.ExpansionToShow[expansionID] = true
					end
					OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
				--------------------------------------------------
				info.keepShownOnClick = true
				info.notCheckable = true
				info.text = "Hide all"
				info.icon = false
				info.func = function(_, _, _, checked)
					for expansionID, v in ipairs(E.OctoTable_Expansions) do
						OctoToDo_DB_Vars.ExpansionToShow[expansionID] = false
					end
					OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
				end
				self:ddAddButton(info, level)
			end
		end
	)
	DD_OCTOMAIN:ddSetOpenMenuUp(true)
	DD_OCTOMAIN:ddSetMenuButtonHeight(16)
end
function OctoToDo_EventFrame_OCTOMAIN:func_Create_DD2_OCTOMAIN()
	local DD2_OCTOMAIN = CreateFrame("Button", "DD2_OCTOMAIN", OctoToDo_MainFrame_OCTOMAIN, "SecureActionButtonTemplate, BackDropTemplate")
	DD2_OCTOMAIN:SetSize(SFDropDownWeight, AddonHeight)
	E:func_SetBackdrop(DD2_OCTOMAIN)
	DD2_OCTOMAIN.ExpandArrow = DD2_OCTOMAIN:CreateTexture(nil, "ARTWORK")
	DD2_OCTOMAIN.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DD2_OCTOMAIN.ExpandArrow:SetSize(16, 16)
	DD2_OCTOMAIN.ExpandArrow:SetPoint("RIGHT", -4, 0)
	DD2_OCTOMAIN.text = DD2_OCTOMAIN:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD2_OCTOMAIN.text:SetAllPoints()
	DD2_OCTOMAIN.text:SetFontObject(OctoFont11)
	DD2_OCTOMAIN.text:SetJustifyV("MIDDLE")
	DD2_OCTOMAIN.text:SetJustifyH("CENTER")
	DD2_OCTOMAIN.text:SetTextColor(1, 1, 1, 1)
	DD2_OCTOMAIN.text:SetText(EXPANSION_FILTER_TEXT)
	LibSFDropDown:SetMixin(DD2_OCTOMAIN)
	DD2_OCTOMAIN:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_OCTOMAIN, "TOPLEFT", 0, AddonHeight)
	DD2_OCTOMAIN:ddSetDisplayMode(GlobalAddonName)
	DD2_OCTOMAIN:ddSetNoGlobalMouseEvent(true)
	-- DD2_OCTOMAIN:ddHideWhenButtonHidden()
	DD2_OCTOMAIN:RegisterForClicks("LeftButtonUp")
	DD2_OCTOMAIN:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)
	local function selectFunctionExpansion(menuButton, _, _, checked)
		OctoToDo_DB_Vars.ExpansionToShow[menuButton.value] = checked or nil
		DD2_OCTOMAIN:SetText("EXP")
		OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
	end
	DD2_OCTOMAIN:ddSetInitFunc(function(self, level, value)
			local info = {}
			info.fontObject = OctoFont11
			if not value then
				for expansionID, v in ipairs(E.OctoTable_Expansions) do
					info.isNotRadio = true
					info.notCheckable = false
					info.keepShownOnClick = true
					info.text = v.color..v.name.."|r"
					info.value = expansionID
					info.icon = v.icon
					info.checked = OctoToDo_DB_Vars.ExpansionToShow[expansionID]
					info.func = selectFunctionExpansion
					self:ddAddButton(info, level)
				end
			end
			--------------------------------------------------
			self:ddAddSeparator(level)
			info.keepShownOnClick = false
			info.notCheckable = true
			info.text = "Show all"
			info.icon = false
			info.func = function(_, _, _, checked)
				for expansionID, v in ipairs(E.OctoTable_Expansions) do
					OctoToDo_DB_Vars.ExpansionToShow[expansionID] = true
				end
				OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
			end
			self:ddAddButton(info, level)
			--------------------------------------------------
			info.keepShownOnClick = false
			info.notCheckable = true
			info.text = "Hide all"
			info.icon = false
			info.func = function(_, _, _, checked)
				for expansionID, v in ipairs(E.OctoTable_Expansions) do
					OctoToDo_DB_Vars.ExpansionToShow[expansionID] = false
				end
				OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
			end
			self:ddAddButton(info, level)
			--------------------------------------------------
	end)
	DD2_OCTOMAIN:ddSetOpenMenuUp(true)
	DD2_OCTOMAIN:ddSetMenuButtonHeight(16)
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
		-- E.AddonManager()
	end
end
function OctoToDo_EventFrame_OCTOMAIN:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
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
	self:func_Create_DD_OCTOMAIN()
	-- self:func_Create_DD2_OCTOMAIN()
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
	E:func_CreateUtilsButton(OctoToDo_MainFrame_OCTOMAIN, "Core", AddonHeight, AddonHeight)
	E:func_CreateMinimapButton(GlobalAddonName, "Core", OctoToDo_DB_Vars, OctoToDo_MainFrame_OCTOMAIN, function()
			OctoToDo_EventFrame_OCTOMAIN:func_CreateMyDataProvider()
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

