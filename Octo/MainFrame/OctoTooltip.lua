local GlobalAddonName, E = ...
local Octo_EventFrame_OCTOTOOLTIP = CreateFrame("FRAME")
Octo_EventFrame_OCTOTOOLTIP:Hide()
local OctoTooltip = CreateFrame("BUTTON", "OctoTooltip", UIParent, "BackdropTemplate")
OctoTooltip:Hide()
local INDENT = 440
local LINE_HEIGHT = 18
local LINE_WEIGHT = 256
local LINES_MAX = 20
local LINES_TOTAL = math.floor((math.floor(select(2, GetPhysicalScreenSize()) / LINE_HEIGHT))*.7)
if LINES_MAX > LINES_TOTAL then
	LINES_MAX = LINES_TOTAL
end
local r, g, b = GetClassColor(E.classFilename)
local total_widthTOOLTIP = 10
local function func_OnHideFirst(frame)
	frame.frameFULL:Hide()
end
local function func_OnShowFirst(frame)
	frame.frameFULL:Show()
end
local func_OnAcquired do
	function func_OnAcquired(owner, frame, data, new)
		if new then
			frame:SetPropagateMouseClicks(false)
			frame:SetPropagateMouseMotion(true)
			----------------
			local frameFULL = CreateFrame("Button", nil, OctoTooltip)
			frameFULL:SetPropagateMouseClicks(false)
			frameFULL:SetPropagateMouseMotion(true)
			frameFULL:SetFrameLevel(frame:GetFrameLevel()+2)
			frameFULL:SetHighlightAtlas("auctionhouse-ui-row-highlight", "ADD")
			frameFULL.HighlightTexture = frameFULL:GetHighlightTexture()
			frameFULL.HighlightTexture:SetAlpha(.2)
			frameFULL:SetPoint("LEFT", frame)
			frameFULL:SetPoint("TOP", frame)
			frameFULL:SetPoint("BOTTOM", frame)
			frameFULL:SetPoint("RIGHT")
			frame.frameFULL = frameFULL
			----------------
			local textureFULL = frameFULL:CreateTexture(nil, "BACKGROUND", nil, -3)
			textureFULL:Hide()
			textureFULL:SetAllPoints()
			textureFULL:SetTexture(E.TEXTURE_LEFT_PATH)
			textureFULL:SetVertexColor(r, g, b, E.bgCaOverlay)
			frame.textureFULL = textureFULL
			----------------
			-- Создаем метатаблицу для дочерних фреймов
			frame.pizda = setmetatable({}, {
					__index = function(self, key)
						if key then
							-- Создаем новый фрейм для каждого элемента
							local f = CreateFrame("BUTTON", "frame"..key, frame)
							f:SetPropagateMouseClicks(false)
							f:SetPropagateMouseMotion(true)
							f:SetHeight(LINE_HEIGHT)
							-- f:SetSize(LINE_WEIGHT, LINE_HEIGHT)
							-- f:SetHitRectInsets(1, 1, 1, 1) -- Коррекция области нажатия
							if key == 1 then
								f:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, 0)
							else
								local prevKey = key - 1
								local prevFrame = rawget(self, prevKey) or self[prevKey] -- Получаем предыдущий фрейм
								f:SetPoint("TOPLEFT", prevFrame, "TOPRIGHT", 0, 0)
							end
							f:RegisterForClicks("LeftButtonUp")
							-- Текст в центре
							f.text = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
							f.text:SetAllPoints()
							f.text:SetFontObject(OctoFont11)
							f.text:SetWordWrap(false)
							f.text:SetJustifyV("MIDDLE") -- TOP, MIDDLE, BOTTOM
							f.text:SetJustifyH("LEFT") -- LEFT, CENTER, RIGHT
							f.text:SetTextColor(1, 1, 1, 1)
							-- Обработчики событий
							-- f:SetScript("OnEnter", function() E:func_OctoTooltip_OnEnter(f) end)
							-- f:SetScript("OnHide", f.Hide)
							rawset(self, key, f)
							return f
						end
					end
			})
			frame:SetScript("OnHide", func_OnHideFirst)
			frame:SetScript("OnShow", func_OnShowFirst)
			----------------
			-- total_widthTOOLTIP = first_width + second_width + third_width
		end
	end
end
local countQWE = 0
function Octo_EventFrame_OCTOTOOLTIP:Octo_Frame_init(frame, node)
	countQWE = countQWE + 1
	local zxc = node:GetData()
	for i = 1, #zxc do
		local pizdaFrame = frame.pizda[i]
		local frameData = zxc
		if frameData[i] then
			frame.pizda[i].text:SetText(frameData[i])
		end
		if Octo_EventFrame_OCTOTOOLTIP.COLUMN_SIZES then
			frame.pizda[i]:SetWidth(Octo_EventFrame_OCTOTOOLTIP.COLUMN_SIZES[i])
		end
	end
	for i = #zxc + 1, #frame.pizda do
		frame.pizda[i].text:SetText()
	end
	-- if frameData.ShownGUID and frameData.ShownGUID == E.curGUID then
	--     frame.textureFULL:Show()
	-- else
	--     frame.textureFULL:Hide()
	-- end
end
local function GetTipAnchor(frame)
	local x, y = frame:GetCenter()
	if not x or not y then
		return "TOPLEFT", "BOTTOMLEFT"
	end
	local hhalf = (x > UIParent:GetWidth() * 2 / 3) and "RIGHT" or (x < UIParent:GetWidth() / 3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight() / 2) and "TOP" or "BOTTOM"
	return vhalf .. hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP") .. hhalf
end
function Octo_EventFrame_OCTOTOOLTIP:func_SmartAnchorTo(frame, point)
	if not frame then
		return error("Invalid frame provided.", 2)
	end
	OctoTooltip:ClearAllPoints()
	if point then
		local left, right = unpack(point)
		OctoTooltip:SetPoint(left, frame, right)
	else
		OctoTooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT")
		-- OctoTooltip:SetPoint(GetTipAnchor(frame))
	end
end
function Octo_EventFrame_OCTOTOOLTIP:Create_OctoTooltip()
	OctoTooltip:SetPropagateMouseClicks(false)
	OctoTooltip:SetPropagateMouseMotion(false)
	OctoTooltip:SetHitRectInsets(-1, -1, -1, -1) -- Коррекция области нажатия (-4 увеличение)

	OctoTooltip:SetScript("OnEnter", function()
		if Octo_EventFrame_OCTOTOOLTIP.ShowScroll then
			OctoTooltip:Show()
			OctoTooltip:SetPropagateMouseMotion(false)
		else
			OctoTooltip:SetPropagateMouseMotion(true)
		end
	end)
	OctoTooltip:SetScript("OnLeave", function()
		OctoTooltip:Hide()
	end)


	OctoTooltip:SetPoint("CENTER")
	OctoTooltip:SetSize(1, LINE_HEIGHT*1)
	OctoTooltip:SetClampedToScreen(true)
	OctoTooltip:SetFrameStrata("TOOLTIP")
	OctoTooltip:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	OctoTooltip:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, 1) -- E.bgCa
	OctoTooltip:SetBackdropBorderColor(r, g, b, 1)
	OctoTooltip.ScrollBox = CreateFrame("FRAME", nil, OctoTooltip, "WowScrollBoxList")
	OctoTooltip.ScrollBox:SetAllPoints()

	OctoTooltip.ScrollBox:SetPropagateMouseClicks(false)
	OctoTooltip.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(false)

	OctoTooltip.ScrollBox:SetPropagateMouseMotion(true)
	OctoTooltip.ScrollBox:GetScrollTarget():SetPropagateMouseMotion(true)


	OctoTooltip.ScrollBox:Layout()
	OctoTooltip.ScrollBar = CreateFrame("EventFrame", nil, OctoTooltip, "MinimalScrollBar")
	OctoTooltip.ScrollBar:SetPoint("TOPLEFT", OctoTooltip.ScrollBox, "TOPRIGHT", -15, -3)
	OctoTooltip.ScrollBar:SetPoint("BOTTOMLEFT", OctoTooltip.ScrollBox, "BOTTOMRIGHT", -15, 3)

	OctoTooltip.ScrollBar:SetPropagateMouseMotion(true)
	OctoTooltip.ScrollBar.Back:SetPropagateMouseMotion(true)
	OctoTooltip.ScrollBar.Forward:SetPropagateMouseMotion(true)
	OctoTooltip.ScrollBar.Track:SetPropagateMouseMotion(true)
	OctoTooltip.ScrollBar.Track.Thumb:SetPropagateMouseMotion(true)

	-- OctoTooltip:SetPropagateMouseClicks(false)
	-- OctoTooltip:SetPropagateMouseMotion(false)

	OctoTooltip.view = CreateScrollBoxListTreeListView()
	OctoTooltip.view:SetElementExtent(LINE_HEIGHT)
	OctoTooltip.view:SetElementInitializer("BUTTON",
		function(...)
			self:Octo_Frame_init(...)
	end)
	OctoTooltip.view:RegisterCallback(OctoTooltip.view.Event.OnAcquiredFrame, func_OnAcquired, OctoTooltip)
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoTooltip.ScrollBox, OctoTooltip.ScrollBar, OctoTooltip.view)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoTooltip.ScrollBox, OctoTooltip.ScrollBar)
end



local function func_hz(node)
	local zxc = node:GetData()
	local frames = OctoTooltip.view:GetFrames()
	if #frames == 0 then
		OctoTooltip.view:AcquireInternal(1, node)
		OctoTooltip.view:InvokeInitializers()
	end
	local shirina = {}
	local btn = frames[1]
	for i = 1, #zxc do
		btn.pizda[i].text:SetText(zxc[i])
		shirina[i] = btn.pizda[i].text:GetStringWidth()
	end
	return shirina
end

function Octo_EventFrame_OCTOTOOLTIP:func_OctoTooltip_CreateDataProvider(tbl)
	local lines = 0
	local columns = 0
	local DataProvider = CreateTreeDataProvider()
	local COLUMN_SIZES = {}
	for i, v in ipairs(tbl) do
		local zxc = {}
		for i, value in ipairs(v) do
			if value ~= nil then
				table.insert(zxc, value)
			end
		end
		if #zxc > 0 then
			local node = DataProvider:Insert(zxc)
			columns = #zxc

			for j, w in ipairs(func_hz(node)) do
				COLUMN_SIZES[j] = math.max(w, COLUMN_SIZES[j] or 0)
			end
		end
	end
	Octo_EventFrame_OCTOTOOLTIP.COLUMN_SIZES = COLUMN_SIZES
	local total_width = 4
	for i = 1, columns do
		total_width = total_width + Octo_EventFrame_OCTOTOOLTIP.COLUMN_SIZES[i]
	end
	lines = #tbl

	local ShowScroll = LINES_MAX < lines
	Octo_EventFrame_OCTOTOOLTIP.ShowScroll = ShowScroll
	if ShowScroll then
		total_width = total_width + 24
	end
	OctoTooltip.view:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)

	if lines > LINES_MAX then
		OctoTooltip:SetSize(total_width, LINE_HEIGHT*LINES_MAX)
	elseif lines == 0 then
		OctoTooltip:SetSize(total_width, LINE_HEIGHT*1)
	else
		OctoTooltip:SetSize(total_width, LINE_HEIGHT*lines)
	end

end
function E:func_OctoTooltip_OnEnter(frame, point)
	if not frame.tooltip or #frame.tooltip == 0 then return end
	Octo_EventFrame_OCTOTOOLTIP:func_SmartAnchorTo(frame, point)
	Octo_EventFrame_OCTOTOOLTIP:func_OctoTooltip_CreateDataProvider(frame.tooltip)
	OctoTooltip:Show()
	if not frame.initScripts then
		frame.initScripts = true
		frame:SetScript("OnLeave", function()
			if not Octo_EventFrame_OCTOTOOLTIP.ShowScroll or not OctoTooltip:IsMouseOver() then
				OctoTooltip:Hide()
			end
			-- if not Octo_EventFrame_OCTOTOOLTIP.ShowScroll and not OctoTooltip:IsMouseOver() then
			-- 	OctoTooltip:Hide()
			-- end
		end)
		frame:SetScript("OnHide", function()
				OctoTooltip:Hide()
		end)
	end

end
local function Create_MyTestButtonFrameONE()
	local MyTestButtonFrameONE = CreateFrame("Button", "MyTestButtonFrameONE", UIParent, "UIPanelButtonTemplate")
	MyTestButtonFrameONE:SetPoint("TOPLEFT", UIParent, 128, -64)
	MyTestButtonFrameONE:SetSize(100, 40)
	MyTestButtonFrameONE:SetText("ONE")
	MyTestButtonFrameONE:SetScript("OnEnter", function()
			E:func_OctoTooltip_OnEnter(MyTestButtonFrameONE)
	end)
	MyTestButtonFrameONE:EnableMouse(true)
	MyTestButtonFrameONE:SetMovable(true)
	MyTestButtonFrameONE:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				MyTestButtonFrameONE:SetAlpha(.5)
				MyTestButtonFrameONE:StartMoving()
			end
	end)
	MyTestButtonFrameONE:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				MyTestButtonFrameONE:SetAlpha(1)
				MyTestButtonFrameONE:StopMovingOrSizing()
			end
	end)
	local tooltip = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		local data = CharInfo.PlayerData
		tooltip[#tooltip+1] = {
			data.classColorHex..data.Name.."|r",
			data.specName,
			data.loginDay,
			data.curServerShort,
			data.raceID
		}
		-- tooltip.ShownGUID = GUID
	end
	MyTestButtonFrameONE.tooltip = tooltip
end
local function Create_MyTestButtonFrameTWO()
	local MyTestButtonFrameTWO = CreateFrame("Button", "MyTestButtonFrameTWO", UIParent, "UIPanelButtonTemplate")
	MyTestButtonFrameTWO:SetPoint("TOPLEFT", UIParent, 128, -128)
	MyTestButtonFrameTWO:SetSize(100, 40)
	MyTestButtonFrameTWO:SetText("TWO")
	MyTestButtonFrameTWO:SetScript("OnEnter", function()
			E:func_OctoTooltip_OnEnter(MyTestButtonFrameTWO)
	end)
	MyTestButtonFrameTWO:EnableMouse(true)
	MyTestButtonFrameTWO:SetMovable(true)
	MyTestButtonFrameTWO:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				MyTestButtonFrameTWO:SetAlpha(.5)
				MyTestButtonFrameTWO:StartMoving()
			end
	end)
	MyTestButtonFrameTWO:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				MyTestButtonFrameTWO:SetAlpha(1)
				MyTestButtonFrameTWO:StopMovingOrSizing()
			end
	end)
	local tooltip = {}
	for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		tooltip[#tooltip+1] = {CharInfo.PlayerData.Name.."|r", E:func_CompactNumberFormat(CharInfo.PlayerData.Money/10000)}
	end
	MyTestButtonFrameTWO.tooltip = tooltip
end
local MyEventsTable = {
	"ADDON_LOADED",
}
E:func_RegisterMyEventsToFrames(Octo_EventFrame_OCTOTOOLTIP, MyEventsTable)
function Octo_EventFrame_OCTOTOOLTIP:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		Create_MyTestButtonFrameONE()
		Create_MyTestButtonFrameTWO()
		self:Create_OctoTooltip()
	end
end