local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
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
local OctoToDo_EventFrame_Octocraft = CreateFrame("FRAME")
OctoToDo_EventFrame_Octocraft:Hide()
OctoToDo_EventFrame_Octocraft:RegisterEvent("ADDON_LOADED")
OctoToDo_EventFrame_Octocraft:RegisterEvent("PLAYER_REGEN_DISABLED")
----------------------------------------------------------------
local AddonHeight = 68 -- Высота 27    --
local numIcons = 5
local AddonRightFrameWeight =  398 -- Ширина 54    -- AddonHeight * numIcons --
local OctocraftTable = ns.OctoTable_OctocraftGregTechCircuits
local PhysicalScreenWidth, PhysicalScreenHeight = GetPhysicalScreenSize()
local NumberOfLines = math.floor((math.floor(PhysicalScreenHeight / AddonHeight))*.7)
local OctocrafttextureBG = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Octocraft BG.tga"
local OctocrafttextureALL = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\Octocraft ALL.tga"
-- frame.cent.FG:SetTexCoord(0, 1, 0, 0.5)
-- frame.cent.BG:SetTexCoord(0, 1, 0.5, 1)
----------------------------------------------------------------
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
function OctoToDo_EventFrame_Octocraft:createBGframe(frame, index, color, text, type)
	frame.cent = CreateFrame("FRAME", nil, frame, "BackdropTemplate")
	frame.cent:SetPropagateMouseClicks(true)
	frame.cent:SetSize(AddonRightFrameWeight, AddonHeight)
	frame.cent:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, AddonHeight-(AddonHeight*index))

	for i = 1, numIcons do
		local r, g, b, a = E.func_hex2rgbNUMBER(color)
		if type[i] then
			frame.cent.FG = frame.cent:CreateTexture(nil, "BACKGROUND", nil, 2)
			frame.cent.FG:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\Circuits\\FG "..type[i]..".tga")
			frame.cent.FG:SetPoint("TOPLEFT", frame, "TOPLEFT", -AddonHeight+AddonHeight*i, AddonHeight-(AddonHeight*index))
			frame.cent.FG:SetVertexColor(r, g, b, 1)

			frame.cent.BG = frame.cent:CreateTexture(nil, "BACKGROUND", nil, 3)
			frame.cent.BG:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\Circuits\\BG "..type[i]..".tga")
			frame.cent.BG:SetPoint("TOPLEFT", frame, "TOPLEFT", -AddonHeight+AddonHeight*i, AddonHeight-(AddonHeight*index))
			frame.cent.BG:SetVertexColor(1, 1, 1, 1)

			frame.cent.TEXT = frame.cent:CreateTexture(nil, "BACKGROUND", nil, 4)
			frame.cent.TEXT:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\Tiers\\"..text[i]..".tga")
			frame.cent.TEXT:SetPoint("TOPLEFT", frame, "TOPLEFT", -AddonHeight+AddonHeight*i, AddonHeight-(AddonHeight*index))
			frame.cent.TEXT:SetVertexColor(1, 1, 1, 1)


			-- frame.cent.text = frame.cent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			-- frame.cent.text:SetPoint("TOPLEFT", frame, "TOPLEFT", -AddonHeight+AddonHeight*i, AddonHeight-(AddonHeight*index))
			-- frame.cent.text:SetFontObject(OctoFont22)
			-- frame.cent.text:SetJustifyV("MIDDLE")
			-- frame.cent.text:SetJustifyH("CENTER")
			-- frame.cent.text:SetTextColor(1, 1, 1, 1)
			-- frame.cent.text:SetText(text[i])
		end
	end
end


function OctoToDo_EventFrame_Octocraft:OctoToDo_Create_MainFrame_Octocraft()
	local OctoToDo_MainFrame_Octocraft = CreateFrame("BUTTON", "OctoToDo_MainFrame_Octocraft", UIParent, "BackdropTemplate")
	OctoToDo_MainFrame_Octocraft:SetSize(AddonHeight*numIcons, AddonHeight*12)
	OctoToDo_MainFrame_Octocraft:SetPoint("TOPLEFT", 100, -100)
	OctoToDo_MainFrame_Octocraft:Hide()
	OctoToDo_MainFrame_Octocraft:SetDontSavePosition(true)
	OctoToDo_MainFrame_Octocraft:SetClampedToScreen(false)
	OctoToDo_MainFrame_Octocraft:SetFrameStrata("HIGH")
	OctoToDo_MainFrame_Octocraft:SetPoint("CENTER")
	OctoToDo_MainFrame_Octocraft:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
	OctoToDo_MainFrame_Octocraft:SetBackdropColor(29/255, 42/255, 76/255, 1)
	OctoToDo_MainFrame_Octocraft:SetBackdropBorderColor(0, 0, 0, 0)
	OctoToDo_MainFrame_Octocraft:EnableMouse(true)
	OctoToDo_MainFrame_Octocraft:SetMovable(true)
	OctoToDo_MainFrame_Octocraft:RegisterForDrag("LeftButton")
	OctoToDo_MainFrame_Octocraft:SetScript("OnDragStart", function()
			OctoToDo_MainFrame_Octocraft:SetAlpha(E.bgCa/2)
			OctoToDo_MainFrame_Octocraft:StartMoving()
	end)
	OctoToDo_MainFrame_Octocraft:SetScript("OnDragStop", function()
			OctoToDo_MainFrame_Octocraft:SetAlpha(1)
			OctoToDo_MainFrame_Octocraft:StopMovingOrSizing()
	end)
	OctoToDo_MainFrame_Octocraft:RegisterForClicks("RightButtonUp")
	OctoToDo_MainFrame_Octocraft:SetScript("OnClick", function(self) self:Hide() end)

	for index, tbl in ipairs(OctocraftTable) do
		self:createBGframe(OctoToDo_MainFrame_Octocraft, index, tbl.color, tbl.text, tbl.type)
	end
	----------------------------------------------------------------
end
----------------------------------------------------------------
OctoToDo_EventFrame_Octocraft:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
function OctoToDo_EventFrame_Octocraft:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		----------------------------------------------------------------
		OctoToDo_Octocraft = OctoToDo_Octocraft or {}
		----------------------------------------------------------------
		self:OctoToDo_Create_MainFrame_Octocraft()
		-- OctoToDo_MainFrame_Octocraft:ClearAllPoints()
		-- OctoToDo_MainFrame_Octocraft:SetPoint("CENTER", UIParent)
		E:func_CreateUtilsButton(OctoToDo_MainFrame_Octocraft)
		----------------------------------------------------------------
		E:func_CreateMinimapButton(GlobalAddonName, OctoToDo_Octocraft, OctoToDo_MainFrame_Octocraft)
		----------------------------------------------------------------
	end
end

function OctoToDo_EventFrame_Octocraft:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_Octocraft and OctoToDo_MainFrame_Octocraft:IsShown() then
		OctoToDo_MainFrame_Octocraft:Hide()
	end
end