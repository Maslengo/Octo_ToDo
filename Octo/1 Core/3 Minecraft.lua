local GlobalAddonName, E = ...
local showMinecraft = false
if showMinecraft then
	-- Создаем фрейм для событий и скрываем его
	local Octo_EventFrame_Minecraft = CreateFrame("FRAME")
	Octo_EventFrame_Minecraft:Hide()

	-- Локальные ссылки на часто используемые функции
	local string_format = string.format

	-- Константы
	local SIZE = 64
	local TEXTURE_PATH_FG = "interface/AddOns/"..GlobalAddonName.."/Media/MINECRAFT/44.tga"
	local TEXTURE_PATH_BG = "interface/AddOns/"..GlobalAddonName.."/Media/statusbar/02 Octo-Blank.tga"

	function Octo_EventFrame_Minecraft:CreateOcto_MinecraftFrameFG()
		local colorFG, colorBG = Octo_ToDo_DB_Minecraft.ColorFG, Octo_ToDo_DB_Minecraft.ColorBG

		local function CreateFrameWithTexture(name, parent, size, strata, texturePath, color, anchor, x, y)
			local frame = CreateFrame("BUTTON", name, parent)
			frame:SetSize(size, size)
			frame:SetFrameStrata(strata)
			if anchor then frame:SetPoint(anchor[1], anchor[2], anchor[3], x or 0, y or 0) end
			frame.texture = frame:CreateTexture(nil, "ARTWORK")
			frame.texture:SetAllPoints()
			frame.texture:SetTexture(texturePath)
			frame.texture:SetVertexColor(color.r, color.g, color.b, 1)
			return frame
		end

		local function CreateColorPickerFrame(parent, color, anchor, x, y, clickFunc)
			local frame = CreateFrame("BUTTON", nil, parent, "BackdropTemplate")
			frame:SetPoint("TOP", parent, anchor, x, y)
			frame:SetSize(32, 32)

			frame.swatchBg = frame:CreateTexture(nil, "BACKGROUND", nil, -3)
			frame.swatchBg:SetSize(28, 28)
			frame.swatchBg:SetPoint("CENTER")
			frame.swatchBg:SetColorTexture(HIGHLIGHT_FONT_COLOR:GetRGB())

			frame.innerBorder = frame:CreateTexture(nil, "BACKGROUND", nil, -2)
			frame.innerBorder:SetSize(24, 24)
			frame.innerBorder:SetPoint("CENTER")
			frame.innerBorder:SetColorTexture(BLACK_FONT_COLOR:GetRGB())

			frame.color = frame:CreateTexture(nil, "BACKGROUND", nil, -1)
			frame.color:SetSize(20, 20)
			frame.color:SetPoint("CENTER")
			frame.color:SetColorTexture(color.r, color.g, color.b)

			frame:SetScript("OnClick", clickFunc)
			frame:SetScript("OnEnter", function(self) self.swatchBg:SetVertexColor(NORMAL_FONT_COLOR:GetRGB()) end)
			frame:SetScript("OnLeave", function(self) self.swatchBg:SetVertexColor(HIGHLIGHT_FONT_COLOR:GetRGB()) end)
			return frame
		end

		local function CreateText(parent, point, relativePoint, x, y, justifyH)
			local text = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			text:SetPoint(point, parent, relativePoint, x, y)
			text:SetFontObject(OctoFont11)
			text:SetWordWrap(true)
			text:SetJustifyV("MIDDLE")
			text:SetJustifyH(justifyH)
			text:SetTextColor(1, 1, 1, 1)
			return text
		end

		local function UpdateColorDisplay(frame, color, text)
			frame.texture:SetVertexColor(color.r, color.g, color.b)
			text:SetText(string_format("r: %s\ng: %s\nb: %s\n \n%s",
					color.r, color.g, color.b, E.func_rgb2hexSTRING(color.r, color.g, color.b)))
		end

		local function ColorSwatch_OnClick(color, updateFunc)
			ColorPickerFrame:SetupColorPickerAndShow({
					r = color.r, g = color.g, b = color.b,
					swatchFunc = function()
						color.r, color.g, color.b = ColorPickerFrame:GetColorRGB()
						updateFunc()
					end,
					cancelFunc = function(prevValues)
						color.r, color.g, color.b = prevValues.r, prevValues.g, prevValues.b
						updateFunc()
					end
			})
		end

		-- Main Frame
		local Octo_MinecraftFrameFG = CreateFrameWithTexture("Octo_MinecraftFrameFG", UIParent, SIZE, "HIGH", TEXTURE_PATH_FG, colorFG, {"TOPLEFT", 300, -100})
		Octo_MinecraftFrameFG:SetDontSavePosition(true)
		Octo_MinecraftFrameFG:SetClampedToScreen(false)
		Octo_MinecraftFrameFG:EnableMouse(true)
		Octo_MinecraftFrameFG:SetMovable(true)
		Octo_MinecraftFrameFG:SetScript("OnMouseDown", function(_, button)
				if button == "LeftButton" then Octo_MinecraftFrameFG:SetAlpha(E.bgCa); Octo_MinecraftFrameFG:StartMoving() end
		end)
		Octo_MinecraftFrameFG:SetScript("OnMouseUp", function(_, button)
				if button == "LeftButton" then Octo_MinecraftFrameFG:SetAlpha(1); Octo_MinecraftFrameFG:StopMovingOrSizing() end
		end)
		Octo_MinecraftFrameFG:RegisterForClicks("RightButtonUp")
		Octo_MinecraftFrameFG:SetScript("OnClick", Octo_MinecraftFrameFG.Hide)
		Octo_MinecraftFrameFG.text = CreateText(Octo_MinecraftFrameFG, "RIGHT", "LEFT", 0, 0, "RIGHT")

		-- Background Frame
		local Octo_MinecraftFrameBG = CreateFrameWithTexture("Octo_MinecraftFrameBG", Octo_MinecraftFrameFG, SIZE, "LOW", TEXTURE_PATH_BG, colorBG, {"CENTER", 0, 0})
		Octo_MinecraftFrameBG.text = CreateText(Octo_MinecraftFrameBG, "LEFT", "RIGHT", 0, 0, "LEFT")

		-- Color Pickers
		local function UpdateFG() UpdateColorDisplay(Octo_MinecraftFrameFG, colorFG, Octo_MinecraftFrameFG.text) end
		local function UpdateBG() UpdateColorDisplay(Octo_MinecraftFrameBG, colorBG, Octo_MinecraftFrameBG.text) end

		CreateColorPickerFrame(Octo_MinecraftFrameFG, colorFG, "BOTTOM", -SIZE/4, -SIZE/2, function() ColorSwatch_OnClick(colorFG, UpdateFG) end)
		CreateColorPickerFrame(Octo_MinecraftFrameBG, colorBG, "BOTTOM", SIZE/4, -SIZE/2, function() ColorSwatch_OnClick(colorBG, UpdateBG) end)

		-- Initialization
		UpdateFG(); UpdateBG()
	end

	-- Регистрация событий
	local MyEventsTable = {"ADDON_LOADED", "PLAYER_LOGIN"}
	E.RegisterMyEventsToFrames(Octo_EventFrame_Minecraft, MyEventsTable, E.func_DebugPath())

	-- Обработчик события ADDON_LOADED
	function Octo_EventFrame_Minecraft:ADDON_LOADED(addonName)
		if addonName == GlobalAddonName then
			self:UnregisterEvent("ADDON_LOADED")
			self.ADDON_LOADED = nil
			OctpToDo_inspectScantip = CreateFrame("GameTooltip", "OctoScanningTooltipFIRST", nil, "GameTooltipTemplate")
			OctpToDo_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
		end
	end

	-- Обработчик события PLAYER_LOGIN
	function Octo_EventFrame_Minecraft:PLAYER_LOGIN()
		self:UnregisterEvent("PLAYER_LOGIN")
		self.PLAYER_LOGIN = nil
		self:CreateOcto_MinecraftFrameFG()
	end
end