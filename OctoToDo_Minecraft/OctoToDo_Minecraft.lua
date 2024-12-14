local GlobalAddonName, ns = ...
local OctoToDo_EventFrame = CreateFrame("FRAME")
OctoToDo_EventFrame:Hide()
local E = OctoToDo_ToDO_E
----------------------------------------------------------------
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
----------------------------------------------------------------
local OctoToDo_EventFrame = CreateFrame("FRAME")
OctoToDo_EventFrame:Hide()
OctoToDo_EventFrame:RegisterEvent("ADDON_LOADED")
----------------------------------------------------------------
local texture_FG = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\minecraft.tga"
local texture_BG = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\minecraft BG.tga"
local MinecraftHeight = 68 -- Высота
local MinecraftRightSize = 1190 -- Ширина
local MinecraftLeftFrameSize = 140
local MinecraftTable = ns.OctoTable_MinecraftColors2
local MainFrameNumLines = #MinecraftTable or 20
if MainFrameNumLines > 20 then
	MainFrameNumLines = 20
end
----------------------------------------------------------------


function OctoToDo_EventFrame:main_frame_toggle()
	----------------------------------------------------------------
	OctoToDo_MainFrame:SetShown(not OctoToDo_MainFrame:IsShown())
	----------------------------------------------------------------
end



-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
local function DropDownMenuSearchButton_OnAcquired(owner, frame, data, new)
	if new then
		-- E:func_SetBackdrop(frame)
		frame.left = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
		frame.left:SetPropagateMouseClicks(true)
		frame.left:SetSize(MinecraftLeftFrameSize, MinecraftHeight)
		-- frame.left:SetSize(142, 34)
		frame.left:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.left.text = frame.left:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.left.text:SetAllPoints()
		frame.left.text:SetFontObject(OctoFont11)
		frame.left.text:SetJustifyV("MIDDLE")
		frame.left.text:SetJustifyH("CENTER")
		frame.left.text:SetTextColor(1, 1, 1, 1)

		frame.right = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
		frame.right:SetPropagateMouseClicks(true)
		frame.right:SetSize(MinecraftRightSize, MinecraftHeight)
		frame.right:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
		frame.right.FG = frame.right:CreateTexture(nil, "BACKGROUND", nil, 0)
		frame.right.FG:SetTexture(texture_FG)
		frame.right.FG:SetAllPoints(frame.right)
		frame.right.BG = frame.right:CreateTexture(nil, "BACKGROUND", nil, -1)
		frame.right.BG:SetTexture(texture_BG)
		frame.right.BG:SetAllPoints(frame.right)

		frame.right.text = frame.right:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.right.text:SetAllPoints()
		frame.right.text:SetFontObject(OctoFont11)
		frame.right.text:SetJustifyV("MIDDLE")
		frame.right.text:SetJustifyH("CENTER")
		frame.right.text:SetTextColor(1, 1, 1, 1)


	end
end

-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ
local function OctoToDo_Frame_init(frame, data)
	frame.left.text:SetText(data.name)
	local r, g, b, a = E.func_hex2rgbNUMBER(data.hex)
	frame.right.FG:SetVertexColor(r, g, b, 1)
	E:func_SetBackdrop(frame.left)
	E:func_SetBackdrop(frame.right, nil, 0)
end

function OctoToDo_EventFrame:OctoToDo_THIRD_CreateMainFrame()
	local OctoToDo_MainFrame = CreateFrame("BUTTON", "OctoToDo_MainFrame", UIParent, "BackdropTemplate")
	OctoToDo_MainFrame:SetSize(MinecraftRightSize+MinecraftLeftFrameSize, MinecraftHeight*MainFrameNumLines)
	OctoToDo_MainFrame:Hide()
	-- OctoToDo_MainFrame.ScrollFrame = CreateFrame("ScrollFrame", "ScrollFrame", OctoToDo_MainFrame)

	OctoToDo_MainFrame.ScrollBox = CreateFrame("FRAME", nil, OctoToDo_MainFrame, "WowScrollBoxList")
	OctoToDo_MainFrame.ScrollBox:SetAllPoints()
	OctoToDo_MainFrame.ScrollBox:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)

	-- OctoToDo_MainFrame.ScrollBox.ScrollTarget:SetPropagateMouseClicks(true)

	OctoToDo_MainFrame.ScrollBar = CreateFrame("EventFrame", nil, OctoToDo_MainFrame, "MinimalScrollBar")
	OctoToDo_MainFrame.ScrollBar:SetPoint("TOPLEFT", OctoToDo_MainFrame.ScrollBox, "TOPRIGHT", 6, 0)
	OctoToDo_MainFrame.ScrollBar:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame.ScrollBox, "BOTTOMRIGHT", 6, 0)

	OctoToDo_MainFrame.view = CreateScrollBoxListLinearView()
	OctoToDo_MainFrame.view:SetElementExtent(MinecraftHeight)
	OctoToDo_MainFrame.view:SetElementInitializer("BackdropTemplate", OctoToDo_Frame_init)
	OctoToDo_MainFrame.view:RegisterCallback(OctoToDo_MainFrame.view.Event.OnAcquiredFrame, DropDownMenuSearchButton_OnAcquired, OctoToDo_MainFrame)
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame.ScrollBox, OctoToDo_MainFrame.ScrollBar, OctoToDo_MainFrame.view)
	-- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame.ScrollBox, OctoToDo_MainFrame.ScrollBar)


	OctoToDo_MainFrame:HookScript("OnKeyDown", function(self, key)
			if key == GetBindingKey("TOGGLEGAMEMENU") then
				self:Hide()
				self:SetPropagateKeyboardInput(false)
			else
				self:SetPropagateKeyboardInput(true)
			end
	end)

	OctoToDo_MainFrame:SetClampedToScreen(false)
	OctoToDo_MainFrame:SetFrameStrata("HIGH")
	OctoToDo_MainFrame:SetPoint("CENTER")
	OctoToDo_MainFrame:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	OctoToDo_MainFrame:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoToDo_MainFrame:SetBackdropBorderColor(0, 1, 0, 1)
	OctoToDo_MainFrame:EnableMouse(true)
	OctoToDo_MainFrame:SetMovable(true)
	OctoToDo_MainFrame:RegisterForDrag("LeftButton")
	OctoToDo_MainFrame:SetScript("OnDragStart", function()
			OctoToDo_MainFrame:SetAlpha(E.bgCa/2)
			OctoToDo_MainFrame:StartMoving()
	end)
	OctoToDo_MainFrame:SetScript("OnDragStop", function()
			OctoToDo_MainFrame:SetAlpha(1)
			OctoToDo_MainFrame:StopMovingOrSizing()
	end)
	OctoToDo_MainFrame:RegisterForClicks("RightButtonUp")
	OctoToDo_MainFrame:SetScript("OnClick", function(self) self:Hide() end)
	----------------------------------------------------------------
	self:func_DataProvider()
end

function OctoToDo_EventFrame:func_DataProvider()
	local DataProvider = CreateDataProvider()
	for index, tbl in ipairs(MinecraftTable) do
		DataProvider:Insert({name = tbl.name, hex = tbl.hex})
	end
	OctoToDo_MainFrame.ScrollBox:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
end
----------------------------------------------------------------
OctoToDo_EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

function OctoToDo_EventFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		self:OctoToDo_THIRD_CreateMainFrame()
		-- self:OctoToDo_AddDataToAltFrame()
		----------------------------------------------------------------
		OctoToDo_Minecraft = OctoToDo_Minecraft or {}
		----------------------------------------------------------------
		local MinimapName = E.func_AddonTitle(GlobalAddonName)
		local ldb_icon = LibDataBroker:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = E.func_AddonIconTexture(GlobalAddonName),
				OnClick = function(_, button)
					if button == "LeftButton" then
						if not InCombatLockdown() then
							self:main_frame_toggle()
						end
					end
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, E.func_AddonTitle(GlobalAddonName))
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		OctoToDo_Minecraft.minimap = OctoToDo_Minecraft.minimap or {}
		OctoToDo_Minecraft.minimap.minimapPos = OctoToDo_Minecraft.minimap.minimapPos or 244
		LibDBIcon:Register(MinimapName, ldb_icon, OctoToDo_Minecraft.minimap)
		LibDBIcon:Show(MinimapName)
		----------------------------------------------------------------
	end
end