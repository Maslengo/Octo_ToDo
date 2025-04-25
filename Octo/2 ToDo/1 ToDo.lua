local GlobalAddonName, E = ...
local Octo_EventFrame_ToDo = CreateFrame("FRAME")
Octo_EventFrame_ToDo:Hide()
local Octo_MainFrame_ToDo = CreateFrame("BUTTON", "Octo_MainFrame_ToDo", UIParent, "BackdropTemplate")
Octo_MainFrame_ToDo:Hide()
tinsert(UISpecialFrames, "Octo_MainFrame_ToDo")
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
-- Shared constants and textures
local r, g, b = GetClassColor(E.classFilename)
local TEXTURE_PATH = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga"
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
-- E.func_LoadAddOn("AddonMrgl")
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
local function func_OnEnter1(frame)
	frame.texture:Show()
end
local function func_OnLeave1(frame)
	frame.texture:Hide()
end

local func_OnAcquiredLEFT = function(owner, frame, data, new)
	if not new then return end

	-- Frame setup
	frame:SetPropagateMouseClicks(true)
	frame:SetPropagateMouseMotion(true)

	-- Full texture background
	local frameFULL = CreateFrame("Frame", nil, Octo_MainFrame_ToDo)
	frameFULL:SetPropagateMouseClicks(true)
	frameFULL:SetPropagateMouseMotion(true)
	frameFULL:SetFrameLevel(frame:GetFrameLevel()+2)
	local texture = frameFULL:CreateTexture(nil, "BACKGROUND", nil, 3)
	texture:Hide()
	texture:SetAllPoints()
	texture:SetTexture(TEXTURE_PATH)
	texture:SetVertexColor(r, g, b, E.bgCaOverlay)
	frameFULL.texture = texture
	frameFULL:SetPoint("LEFT", frame)
	frameFULL:SetPoint("TOP", frame)
	frameFULL:SetPoint("BOTTOM", frame)
	frameFULL:SetPoint("RIGHT")

	frameFULL:SetScript("OnEnter", func_OnEnter1)
	frameFULL:SetScript("OnLeave", func_OnLeave1)

	-- Icon setup
	local icon = frame:CreateTexture(nil, "BACKGROUND")
	icon:SetSize(AddonHeight - 2, AddonHeight - 2)
	icon:SetPoint("TOPLEFT", 1, -1)
	icon:SetTexCoord(0.10, 0.90, 0.10, 0.90)
	frame.icon_1 = icon

	-- Left text
	local textLeft = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	textLeft:SetPoint("LEFT", 2 + AddonHeight, 0)
	textLeft:SetWidth(AddonLeftFrameWeight - 2 - AddonHeight)
	textLeft:SetFontObject(OctoFont11)
	textLeft:SetWordWrap(false)
	textLeft:SetJustifyV("MIDDLE")
	textLeft:SetJustifyH("LEFT")
	textLeft:SetTextColor(1, 1, 1, 1)
	frame.textLEFT = textLeft

	-- Event handlers
	frame:SetScript("OnEnter", function(self)
		if not self.textLEFT:IsTruncated() then return end
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint("CENTER", self)
		GameTooltip:SetText(E.func_texturefromIcon(self.icon_1:GetTexture())..self.textLEFT:GetText(), 1, 1, 1)
		GameTooltip:Show()
	end)

	frame:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)






end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
local func_OnAcquiredCENT do

	-- Event handlers
	local function func_OnEnter(frame)
		-- frame.texture_full:SetAlpha(E.bgCaOverlay)
	end

	local function func_OnLeave(frame)
		-- frame.texture_full:SetAlpha(0)
	end

	local function func_OnEnterSecond(frame)
		E.func_TooltipOnEnter(frame, true, true)
	end

	function func_OnAcquiredCENT(owner, frame, data, new)
		if not new then return end

		-- Frame setup
		frame:SetPropagateMouseClicks(true)

		-- Full texture background
		-- frame.texture_full = frame:CreateTexture(nil, "BACKGROUND", nil, 3)
		-- frame.texture_full:SetAllPoints()
		-- frame.texture_full:SetTexture(TEXTURE_PATH)
		-- frame.texture_full:SetVertexColor(r, g, b, 0)

		-- Secondary frames metatable
		frame.second = setmetatable({}, {
			__index = function(self, key)
				local f = CreateFrame("BUTTON", "frame"..key, frame)
				f:SetPropagateMouseClicks(true)
				f:SetPropagateMouseMotion(true)
				f:SetSize(AddonCentralFrameWeight, AddonHeight)
				f:SetHitRectInsets(1, 1, 0, 0)
				f:SetPoint("TOPLEFT", frame, "TOPLEFT", AddonCentralFrameWeight*(key-1), 0)
				f:RegisterForClicks("LeftButtonUp")

				-- Reputation texture
				f.ReputTexture = f:CreateTexture(nil, "BACKGROUND", nil, -2)
				f.ReputTexture:SetPoint("LEFT")
				f.ReputTexture:SetHeight(AddonHeight)
				f.ReputTexture:SetTexture(TEXTURE_PATH)

				-- Current character texture
				f.curCharTexture = f:CreateTexture(nil, "BACKGROUND", nil, -2)
				f.curCharTexture:SetAllPoints()
				f.curCharTexture:SetTexture(TEXTURE_PATH)
				f.curCharTexture:SetVertexColor(r, g, b, E.bgCaOverlay)
				f.curCharTexture:Hide()

				-- Center text
				f.textCENT = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				f.textCENT:SetAllPoints()
				f.textCENT:SetFontObject(OctoFont11)
				f.textCENT:SetWordWrap(false)
				f.textCENT:SetJustifyV("MIDDLE")
				f.textCENT:SetJustifyH("CENTER")
				f.textCENT:SetTextColor(1, 1, 1, 1)

				-- Event handlers
				f:SetScript("OnEnter", func_OnEnterSecond)
				f:SetScript("OnLeave", GameTooltip_Hide)
				f:SetScript("OnHide", f.Hide)

				f.curCharTexture:SetScript("OnHide", f.curCharTexture.Hide)

				-- self[key] = f
				rawset(self, key, f)
				return f
			end
		})

		-- Frame event handlers
		frame:SetScript("OnEnter", func_OnEnter)
		frame:SetScript("OnLeave", func_OnLeave)
	end
end
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ (АПДЕЙТ)




function Octo_EventFrame_ToDo:Octo_Frame_initLEFT(frame, node)
	local data = node:GetData()

	-- LEFT FRAME INITIALIZATION
	frame.textLEFT:SetText(data.textLEFT)

	-- Set icon for left frame
	local icon = data.headerIcon or (data.zxc and data.zxc.icon) or E.Icon_Empty
	frame.icon_1:SetTexture(icon)

end




function Octo_EventFrame_ToDo:Octo_Frame_initCENT(frame, node)
	local data = node:GetData()

	-- RIGHT FRAME INITIALIZATION
	if not data.zxc then return end

	-- Handle multiple characters case
	if data.totalPers > 1 then
		local current = frame.second[data.currentChar]
		current:Show()
		current.curCharTexture:Show()
		current.textCENT:SetText("")
		current.ReputTexture:Hide()
	end

	-- Process right frame data
	for i = 1, #data.zxc.FIRST do
		local secondFrame = frame.second[i]
		local frameData = data.zxc

		if frameData.textCENT[i] then
			local textCENT = frameData.textCENT[i]
			local FIRST = frameData.FIRST[i]
			local SECOND = frameData.SECOND[i]
			local r1, g1, b1 = E.func_hex2rgbNUMBER(frameData.color[i])

			secondFrame.textCENT:SetText(textCENT)
			secondFrame.ReputTexture:SetVertexColor(r1, g1, b1, 0.3)

			if FIRST == 0 then
				secondFrame.ReputTexture:SetWidth(0.1)
				secondFrame.ReputTexture:Hide()
			elseif FIRST == SECOND then
				secondFrame.ReputTexture:SetWidth(AddonCentralFrameWeight)
				secondFrame.ReputTexture:Show()
			elseif FIRST >= 1 then
				secondFrame.ReputTexture:SetWidth(AddonCentralFrameWeight/SECOND*FIRST)
				secondFrame.ReputTexture:Show()
			end
		else
			secondFrame.textCENT:SetText("")
			secondFrame.ReputTexture:SetVertexColor(0, 0, 0, 0)
		end

		secondFrame:Show()
		secondFrame.tooltip = frameData.tooltip[i]
	end
end


function Octo_EventFrame_ToDo:Octo_Create_MainFrame_ToDo()
	local frame = Octo_MainFrame_ToDo
	frame:SetPoint("CENTER", 0, 0)

	frame:SetScript("OnShow", function()
		self:func_CreateMyDataProvider()
		RequestRaidInfo()
	end)


	local NumPlayers = math.min(E.func_NumPlayers(), MaxNumCharacters)
	frame:SetSize(AddonLeftFrameWeight + AddonCentralFrameWeight * NumPlayers, AddonHeight * MainFrameDefaultLines)
	frame:SetDontSavePosition(true)
	frame:SetClampedToScreen(false)
	frame:SetFrameStrata("HIGH")

	-- Создание скролл-фрейма
	local barPanelScroll = CreateFrame("ScrollFrame", nil, frame)
	frame.barPanelScroll = barPanelScroll
	-- barPanelScroll:SetAllPoints()

	-- Настройка скроллинга
	local function OnHorizontalScroll(self, offset)
		local scrollRange = self:GetHorizontalScrollRange()
		self.hBar:SetScrollPercentage(scrollRange > 0 and offset / scrollRange or 0, ScrollBoxConstants.NoScrollInterpolation)
	end

	local function OnScrollRangeChanged(self, xrange)
		OnHorizontalScroll(self, self:GetHorizontalScroll())
		local width = self:GetWidth()
		self.hBar:SetVisibleExtentPercentage(width > 0 and width / (xrange + width) or 0)
		self.hBar:SetPanExtentPercentage(xrange > 0 and 30 / xrange or 0)
	end

	barPanelScroll:SetScript("OnHorizontalScroll", OnHorizontalScroll)
	barPanelScroll:SetScript("OnScrollRangeChanged", OnScrollRangeChanged)

	-- Горизонтальная полоса прокрутки
	local HorizontalScrollBar = CreateFrame("EventFrame", nil, frame, "OctoWowTrimHorizontalScrollBar")
	HorizontalScrollBar.Backplate = HorizontalScrollBar:GetRegions()
	HorizontalScrollBar.Backplate:Hide()

	local regions = {
		HorizontalScrollBar.Back.Texture,
		HorizontalScrollBar.Forward.Texture,
		HorizontalScrollBar.Track.Middle,
		HorizontalScrollBar.Track.Begin,
		HorizontalScrollBar.Track.End,
		HorizontalScrollBar.Track.Thumb.Middle,
		HorizontalScrollBar.Track.Thumb.Begin,
		HorizontalScrollBar.Track.Thumb.End
	}

	for _, region in ipairs(regions) do
		region:SetTexCoord(0, 0, 1, 0, 0, 1, 1, 1)
	end

	barPanelScroll.hBar = HorizontalScrollBar
	HorizontalScrollBar:SetPoint("TOPLEFT", barPanelScroll, "BOTTOMLEFT", 0, -6)
	HorizontalScrollBar:SetPoint("TOPRIGHT", barPanelScroll, "BOTTOMRIGHT")
	HorizontalScrollBar:RegisterCallback(HorizontalScrollBar.Event.OnScroll, function(_, scrollPercentage)
		barPanelScroll:SetHorizontalScroll(scrollPercentage * barPanelScroll:GetHorizontalScrollRange())
	end)
	HorizontalScrollBar:SetHideIfUnscrollable(true)

	-- Дочерний фрейм для содержимого
	local childCENT = CreateFrame("Frame")
	frame.childCENT = childCENT

	-- childCENT.texture = childCENT:CreateTexture(nil, "BACKGROUND")
	-- childCENT.texture:SetAllPoints()
	-- childCENT.texture:SetTexture(format("Interface\\Addons\\%s\\Media\\statusbar\\01 Octo Naowh.tga", GlobalAddonName))

	barPanelScroll:SetScrollChild(childCENT)

	-- Настройка ScrollBoxLEFT
	frame.ScrollBoxLEFT = CreateFrame("Frame", nil, frame, "WowScrollBoxList")
	frame.ScrollBoxLEFT:SetWidth(AddonLeftFrameWeight)
	frame.ScrollBoxLEFT:SetPoint("TOPLEFT", 0, -AddonHeight)
	frame.ScrollBoxLEFT:SetPoint("BOTTOMLEFT")
	frame.ScrollBoxLEFT:SetPropagateMouseClicks(true)
	frame.ScrollBoxLEFT:GetScrollTarget():SetPropagateMouseClicks(true)
	barPanelScroll:SetPoint("TOPLEFT", frame.ScrollBoxLEFT, "TOPRIGHT", 0, AddonHeight)
	barPanelScroll:SetPoint("BOTTOMRIGHT")


	frame.viewLEFT = CreateScrollBoxListTreeListView(0)
	frame.viewLEFT:SetElementExtent(AddonHeight)
	frame.viewLEFT:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initLEFT(...) end)
	frame.viewLEFT:RegisterCallback(frame.viewLEFT.Event.OnAcquiredFrame, func_OnAcquiredLEFT, frame)

	-- Настройка ScrollBoxCENT
	frame.ScrollBoxCENT = CreateFrame("Frame", nil, childCENT, "WowScrollBoxList")
	frame.ScrollBoxCENT:SetPoint("TOPLEFT", 0, -AddonHeight)
	frame.ScrollBoxCENT:SetPoint("BOTTOMRIGHT")
	frame.ScrollBoxCENT:SetPropagateMouseClicks(true)
	frame.ScrollBoxCENT:GetScrollTarget():SetPropagateMouseClicks(true)

	frame.ScrollBarCENT = CreateFrame("EventFrame", nil, frame, "MinimalScrollBar")
	frame.ScrollBarCENT:SetPoint("TOPLEFT", frame, "TOPRIGHT", 6, 0)
	frame.ScrollBarCENT:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 6, 0)

	frame.viewCENT = CreateScrollBoxListTreeListView(0)
	frame.viewCENT:SetElementExtent(AddonHeight)
	frame.viewCENT:SetElementInitializer("BUTTON", function(...) self:Octo_Frame_initCENT(...) end)
	frame.viewCENT:RegisterCallback(frame.viewCENT.Event.OnAcquiredFrame, func_OnAcquiredCENT, frame)




	ScrollUtil.InitScrollBoxListWithScrollBar(frame.ScrollBoxLEFT, frame.ScrollBarCENT, frame.viewLEFT)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(frame.ScrollBoxLEFT, frame.ScrollBarCENT)

	ScrollUtil.InitScrollBoxListWithScrollBar(frame.ScrollBoxCENT, frame.ScrollBarCENT, frame.viewCENT)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(frame.ScrollBoxCENT, frame.ScrollBarCENT)

	-- Настройка внешнего вида основного фрейма
	frame:SetBackdrop({
		bgFile = E.bgFile,
		edgeFile = E.edgeFile,
		edgeSize = 1,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})

	frame:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	frame:SetBackdropBorderColor(0, 0, 0, 1)
	frame:EnableMouse(true)
	frame:SetMovable(true)

	-- Обработчики перемещения фрейма
	frame:SetScript("OnMouseDown", function(_, button)
		if button == "LeftButton" then
			frame:SetAlpha(E.bgCa)
			frame:StartMoving()
		end
	end)

	frame:SetScript("OnMouseUp", function(_, button)
		if button == "LeftButton" then
			frame:SetAlpha(1)
			frame:StopMovingOrSizing()
		end
	end)

	frame:RegisterForClicks("RightButtonUp")
	frame:SetScript("OnClick", frame.Hide)

	-- Создание пула фреймов
	local function resetFunc(_, self)
		self:Hide()
		self:ClearAllPoints()
	end

	local function initFunc(self)
		self:SetSize(AddonCentralFrameWeight, AddonHeight)
		self.text = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		self.text:SetPoint("CENTER")
		self.text:SetFontObject(OctoFont11)
		self.text:SetJustifyV("MIDDLE")
		self.text:SetJustifyH("CENTER")
		self.text:SetTextColor(1, 1, 1, 1)
	end

	frame.pool = CreateFramePool("FRAME", childCENT, "BackdropTemplate", resetFunc, false, initFunc)
end

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------


function Octo_EventFrame_ToDo:func_CreateMyDataProvider()
	local NumPlayers = math.min(E.func_NumPlayers(), MaxNumCharacters)
	local DataProvider = CreateTreeDataProvider()
	local numlines = 0

	-- Находим индекс текущего персонажа
	local peLmennaya = E.sorted()
	local MyCharIndex
	for CharIndex, CharInfo in ipairs(peLmennaya) do
		if CharInfo.GUID == E.curGUID then
			MyCharIndex = CharIndex
			break
		end
	end

	local totalPers = #peLmennaya
	local commonNodeData = {
		currentChar = MyCharIndex,
		totalPers = totalPers
	}

	if Octo_ToDo_DB_Vars.Reputations then
		-- Обработка репутаций
		for index, tbl in ipairs(E.OctoTable_Reputations) do
			if Octo_ToDo_DB_Vars.ExpansionToShow[index] then
				numlines = numlines + 1
				local groupNodeFirst = DataProvider:Insert({
					textLEFT = tbl.header.name,
					headerIcon = tbl.header.icon,
					currentChar = MyCharIndex,
					totalPers = totalPers,
				})

				for _, v in ipairs(tbl) do
					local repInfo = E.OctoTable_ReputationsDB[v.id]
					local factionMatch = not Octo_ToDo_DB_Vars.OnlyCurrentFaction
									  or repInfo.side == E.curFaction
									  or repInfo.side == "-"

					if factionMatch then
						numlines = numlines + 1
						local zxc = {
							FIRST = {},
							SECOND = {},
							textCENT = {},
							color = {},
							standingTEXT = {},
							icon = repInfo.icon or E.Icon_Empty,
							tooltip = {}
						}

						for CharIndex, CharInfo in ipairs(peLmennaya) do
							local repData = CharInfo.MASLENGO.reputationFULL[v.id]
							zxc.FIRST[CharIndex] = repData.FIRST or 0
							zxc.SECOND[CharIndex] = repData.SECOND or 0
							zxc.textCENT[CharIndex] = repData.vivod or ""
							zxc.color[CharIndex] = repData.color or "000000"
							zxc.standingTEXT[CharIndex] = repData.standingTEXT or ""
						end

						groupNodeFirst:Insert({
							textLEFT = E.func_reputationName(v.id),
							zxc = zxc,
							currentChar = MyCharIndex,
							totalPers = totalPers,
						})
					end
				end
			end
		end
	else
		-- Альтернативный режим (не репутации)
		local OctoTable_func_otrisovkaCENT, OctoTable_func_otrisovkaLEFT = E:func_Otrisovka()

		for i, func in ipairs(OctoTable_func_otrisovkaCENT) do
			numlines = numlines + 1
			local zxc = {
				FIRST = {},
				SECOND = {},
				textCENT = {},
				color = {},
				icon = select(2, OctoTable_func_otrisovkaLEFT[i]()),
				tooltip = {}
			}

			for CharIndex, CharInfo in ipairs(peLmennaya) do
				zxc.FIRST[CharIndex] = 0
				zxc.SECOND[CharIndex] = 0
				zxc.textCENT[CharIndex], zxc.tooltip[CharIndex] = func(CharInfo)
				zxc.color[CharIndex] = E.Red_Color
			end

			DataProvider:Insert({
				textLEFT = OctoTable_func_otrisovkaLEFT[i](),
				zxc = zxc,
				currentChar = MyCharIndex,
				totalPers = totalPers,
			})
		end
	end

	-- Установка размера фрейма
	MainFrameDefaultLines = math.max(1, math.min(numlines, Octo_ToDo_DB_Vars.MainFrameDefaultLines or numlines))

	if Octo_MainFrame_ToDo then
		local width = AddonLeftFrameWeight + AddonCentralFrameWeight * NumPlayers
		local height = AddonHeight * MainFrameDefaultLines + AddonHeight

		Octo_MainFrame_ToDo:SetSize(width, height)
		Octo_MainFrame_ToDo.childCENT:SetSize(AddonCentralFrameWeight * E.func_NumPlayers(), height)
		Octo_MainFrame_ToDo.viewCENT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
		Octo_MainFrame_ToDo.viewLEFT:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)

	end

	-- Обновление фреймов персонажей
	Octo_MainFrame_ToDo.pool:ReleaseAll()

	for count, CharInfo in ipairs(peLmennaya) do
		local curCharFrame = Octo_MainFrame_ToDo.pool:Acquire()
		curCharFrame:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo.childCENT, "TOPLEFT",
							AddonCentralFrameWeight * (count - 1),
							-AddonHeight)

		curCharFrame.text:SetText(E.func_vivodCent(CharInfo))

		local color = CharInfo.Faction == "Horde" and "|cfff01e38" or "|cff0070DD"
		E:func_SetBackdrop(curCharFrame, color, E.bgCaOverlay * 2, 0)

		curCharFrame.tooltip = E.CreateTooltipPlayers(CharInfo)
		curCharFrame:SetScript("OnEnter", function()
			E.func_TooltipOnEnter(curCharFrame, true, true)
		end)
		curCharFrame:SetScript("OnLeave", GameTooltip_Hide)
		curCharFrame:Show()
	end
end


function E.Update(event_name)
	local isMainFrameVisible = Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown()

	if not E.DebugEvent then return end

	if isMainFrameVisible then
		if not E.updateScheduled then
			E.updateScheduled = true
			C_Timer.After(0.1, function()
				E.updateScheduled = false
				if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() and E.DebugEvent then
					DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.Update(", E.Green_Color, E.Yellow_Color)..event_name..E.Yellow_Color..")|r")
				end
			end)
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.Update(", E.Addon_Left_Color, E.Addon_Right_Color)..event_name..E.Addon_Right_Color..")|r")
	end
end


function Octo_EventFrame_ToDo:func_Create_DD_ToDo()
	local DD_ToDo = CreateFrame("Button", "DD_ToDo", Octo_MainFrame_ToDo, "SecureActionButtonTemplate, BackDropTemplate")
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
	DD_ToDo:SetPoint("BOTTOMLEFT", Octo_MainFrame_ToDo, "TOPLEFT", 0, 0)
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
		Octo_MainFrame_ToDo.ScrollBoxCENT:ScrollToOffset(0)
		Octo_MainFrame_ToDo.barPanelScroll:SetHorizontalScroll(0)
	end
	local function func_remove_GUID(menuButton)
		Octo_ToDo_DB_Levels[menuButton.value] = nil
		Octo_EventFrame_ToDo:func_CreateMyDataProvider()
		Octo_MainFrame_ToDo.ScrollBoxCENT:ScrollToOffset(0)
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
				info.keepShownOnClick = false
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
				info.keepShownOnClick = false
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
	if addonName ~= GlobalAddonName then return end

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
	if AddonMgrAddonList then
		tinsert(E.OctoTable_Frames, AddonMgrAddonList)
		AddonMgrAddonList:SetScale(.8)
		-- /run AddonMgrAddonList:SetScale(.8)
	end
	-- Load settings with defaults in a more concise way
	local db = Octo_ToDo_DB_Vars
	AddonHeight = db.AddonHeight or AddonHeight
	AddonLeftFrameWeight = db.AddonLeftFrameWeight or AddonLeftFrameWeight
	AddonCentralFrameWeight = db.AddonCentralFrameWeight or AddonCentralFrameWeight
	MainFrameDefaultLines = db.MainFrameDefaultLines or MainFrameDefaultLines
	SFDropDownWeight = db.SFDropDownWeight or SFDropDownWeight

	-- Calculate and set MaxNumCharacters
	local maxNum = math.floor((E.MonitorWidth - AddonLeftFrameWeight) / AddonCentralFrameWeight) - 1
	MaxNumCharacters = db.MaxNumCharacters and math.min(db.MaxNumCharacters, maxNum) or MaxNumCharacters



	local function ConcatAtStart()
		E.func_TableConcat(E.OctoTable_QuestID, E.OctoTable_QuestID_Paragon)
		for _, itemID in next, (E.OctoTable_itemID_ItemsUsable_Other) do
			E.OctoTable_itemID_ItemsUsable[itemID] = 1
		end
	end
	ConcatAtStart()



	-- Process modules
	for _, func in next, E.Modules do
		func()
	end
end


function Octo_EventFrame_ToDo:PLAYER_LOGIN()
	-- Cleanup event
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil

	-- Initialize systems
	self:LIBSHAREDSFMIC()
	C_WowTokenPublic.UpdateMarketPrice()

	-- Apply GameMenu scale
	GameMenuFrame:SetScale(Octo_ToDo_DB_Vars.GameMenuFrameScale or 1)

	-- Setup PlayerSpellsFrame if not exists
	if not PlayerSpellsFrame then
		self:SetupPlayerSpellsFrame()
	end

	-- Initialize main systems
	E:InitOptions()
	self:Octo_Create_MainFrame_ToDo()
	-- self:func_CreateMyDataProvider()
	E.PortalsFrame()
	self:func_Create_DD_ToDo()

	-- Calculate and display character statistics
	self:DisplayCharacterStats()

	-- Create UI elements
	E:func_CreateUtilsButton(Octo_MainFrame_ToDo, "ToDo", AddonHeight, 0)
	E:func_CreateMinimapButton(GlobalAddonName, "ToDo", Octo_ToDo_DB_Vars, Octo_MainFrame_ToDo, nil, "Octo_MainFrame_ToDo")

	-- Load assets after a delay
	C_Timer.After(0, function()
		self:LoadAssetsAsync()
	end)
end

-- Helper functions
function Octo_EventFrame_ToDo:SetupPlayerSpellsFrame()
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

function Octo_EventFrame_ToDo:DisplayCharacterStats()
	local totalMoney, totalReload, realTotalTime, TodayTimePlayedtotal, realLevelTime = 0, 0, 0, 0, 0

	for GUID, CharInfo in pairs(Octo_ToDo_DB_Levels) do
		totalReload = totalReload + (CharInfo.ReloadCount or 0)

		if CharInfo.curServer == E.curServer then
			totalMoney = totalMoney + CharInfo.Money
			realTotalTime = realTotalTime + CharInfo.realTotalTime
			TodayTimePlayedtotal = TodayTimePlayedtotal + CharInfo.TodayTimePlayed

			if CharInfo.UnitLevel >= E.currentMaxLevel then
				realLevelTime = realLevelTime + CharInfo.realLevelTime
			end
		end
	end

	-- Create info frames
	local moneyText = format("Money: %s%s|r %s", E.classColorHexCurrent, E.func_CompactNumberFormat(totalMoney/10000), E.curServerShort)
	E.func_CreateInfoFrame(moneyText, "TOPLEFT", Octo_MainFrame_ToDo, "BOTTOMLEFT", 0, -AddonHeight*0, AddonLeftFrameWeight, AddonHeight)

	local timePlayedText = format(TIME_PLAYED_TOTAL, E.classColorHexCurrent..E.func_SecondsToClock(realTotalTime).."|r")
	E.func_CreateInfoFrame(timePlayedText, "TOPLEFT", Octo_MainFrame_ToDo, "BOTTOMLEFT", 0, -AddonHeight*1, AddonLeftFrameWeight, AddonHeight)

	if realLevelTime ~= 0 then
		local levelTimeText = format("realLevelTime: %s%s|r", E.classColorHexCurrent, E.func_SecondsToClock(realLevelTime))
		E.func_CreateInfoFrame(levelTimeText, "TOPLEFT", Octo_MainFrame_ToDo, "BOTTOMLEFT", 0, -AddonHeight*2, AddonLeftFrameWeight, AddonHeight)
	end

	local reloadsText = format("Reloads: %s%s|r", E.classColorHexCurrent, totalReload)
	E.func_CreateInfoFrame(reloadsText, "TOPLEFT", Octo_MainFrame_ToDo, "BOTTOMLEFT", 0, -AddonHeight*2, AddonLeftFrameWeight, AddonHeight)
end

function Octo_EventFrame_ToDo:LoadAssetsAsync()
	local promise = LibThingsLoad:Items(E.OctoTable_itemID_ALL)
	promise:AddItems(E.PromiseItem)
	promise:AddSpells(E.PromiseSpell)
	promise:AddQuests(E.PromiseQuest)

	promise:Then(function()
		if Octo_MainFrame_ToDo:IsShown() then
			-- Octo_MainFrame_ToDo:Hide()
			-- Octo_MainFrame_ToDo:Show()
			Octo_EventFrame_ToDo:func_CreateMyDataProvider()
		end
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
-- Создаем таблицу для хранения slash команд
local slashCommands = {
	Octo = {
		commands = {"/octo"},
		handler = function(msg)
			if not InCombatLockdown() then
				Octo_EventFrame_ToDo:main_frame_toggle()
			end
		end
	},
	GSEARCH = {
		commands = {"/gsearch", "/gs"},
		handler = function(msg)
			local str = ""
			local color = E.classColorHexCurrent
			DEFAULT_CHAT_FRAME:AddMessage(color.."GSEARCH:|r "..msg)

			for i, n in pairs(_G) do
				if type(n) == "string" and n:find(msg) then
					str = str..color..i.."|r - "..n.."\n"
				end
			end

			local editBox = _G.editFrame.editFrame
			editBox:SetText(str)
			_G.editFrame:Show()
		end
	},
	RELOAD = {
		commands = {"/rl"},
		handler = E.ReloadUI
	},
	FRAMESTK = {
		commands = {"/fs"},
		handler = function(msg)
			if not E.IsAddOnLoaded("Blizzard_DebugTools") then
				E.LoadAddOn("Blizzard_DebugTools")
			end
			FrameStackTooltip_Toggle(msg == "true", true, true)
		end
	}
}

-- Регистрируем все slash команды
for name, data in pairs(slashCommands) do
	SlashCmdList[name] = data.handler
	for i, cmd in ipairs(data.commands) do
		_G["SLASH_"..name..i] = cmd
	end
end


function Octo_EventFrame_ToDo:PLAYER_REGEN_DISABLED()
	if Octo_MainFrame_ToDo and Octo_MainFrame_ToDo:IsShown() then
		Octo_MainFrame_ToDo:Hide()
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