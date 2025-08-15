print("!|T3586268:0|t |cFF00A3FFOcto|r |cffFF4C4FRenownChecker|r: loaded")
local AddonName, AddonSpace = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local AddonTitleEvent = CreateFrame("Frame", AddonTitle)
AddonTitleEvent:RegisterEvent("GOSSIP_SHOW")
AddonTitleEvent:SetScript("OnEvent", function(self, event, ...)
		if event == "GOSSIP_SHOW" then
			local UnitID = "TARGET"
			local guid = UnitGUID(UnitID)
			local FirstName = {
				[171787] = true,
				[171821] = true,
				[171795] = true,
				[171589] = true,
			}
			if guid then
				if UnitGUID(UnitID):match("%a+") ~= "Player" then
					local targetNPCID = tonumber(UnitGUID(UnitID):match("-(%d+)-%x+$"), 10)
					if FirstName[targetNPCID] and not IsShiftKeyDown() then
						C_GossipInfo.SelectOption(1)
						StaticPopup_OnClick(StaticPopup1Button1:GetParent(), 1)
					else
						return
					end
				end
			end
		end
end)
SLASH_GSEARCH1 = "/gsearch"
SlashCmdList.GSEARCH = function(msg)
	print("SEARCH:", msg)
	for i, n in pairs(_G) do
		if type(n) == "string" and n:find(msg) then
			print(i, n)
		end
	end
end
local LibStub = LibStub
local ldb = LibStub("LibDataBroker-1.1")
local ldbi = LibStub("LibDBIcon-1.0")
local OctoRenownAltFrame = nil
local EventFrame = nil
local OctoRenownVersion = 1
local color = "|cff000000"
--local ColorKyrian = CreateColor(1,1,1,1)
--(KYRIAN_BLUE_COLOR:GetRGB())
local ColorKyrianR = 111/255
local ColorKyrianG = 168/255
local ColorKyrianB = 220/255
local ColorKyrianA = 1
local ColorKyrian = ColorKyrianR, ColorKyrianG, ColorKyrianB, ColorKyrianA
local ColorNecrolordR = 147/255
local ColorNecrolordG = 196/255
local ColorNecrolordB = 125/255
local ColorNecrolordA = 1
local ColorNecrolord = ColorNecrolordR, ColorNecrolordG, ColorNecrolordB, ColorNecrolordA
local ColorNightFaeR = 142/255
local ColorNightFaeG = 124/255
local ColorNightFaeB = 195/255
local ColorNightFaeA = 1
local ColorNightFae = ColorNightFaeR, ColorNightFaeG, ColorNightFaeB, ColorNightFaeA
local ColorVenthyrR = 224/255
local ColorVenthyrG = 102/255
local ColorVenthyrB = 102/255
local ColorVenthyrA = 1
local ColorVenthyr = ColorVenthyrR, ColorVenthyrG, ColorVenthyrB, ColorVenthyrA
local _, className, curClass = UnitClass("PLAYER")
local classColor = C_ClassColor.GetClassColor(className)
local r,g,b = classColor:GetRGB()
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
local CovenantNames =
{
	[1] = "Kyrian",
	[2] = "Venthyr",
	[3] = "NightFae",
	[4] = "Necrolord",
}
--local allTextParts = {}
--local allFrames = {}
local curWidth, curHeight = 80, 24 --ширина 45, высота 45
local curWidthTitle = curWidth*1.2
local textSizeVERYBIG22 = 22
local textSize13 = 13
local curFont = {[[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], textSizeVERYBIG22, "OUTLINE"}
local valuesRecentlyUpdated = false
--local OctoRenownSizes = {Full = {Width = 200, Height = 250}, Compact = {Width = 200, Height = 125}}
local TotalTransAnima = 0
local TotalMoney = 0
local function CompactNumberFormat(number)
	if number < 1000 then return (math.floor((number+0.5)-0.5)/10)*10
	elseif number < 1000000 then return (math.floor(number/100)/10) .."k"
	else return (math.floor(number/100000)/10) .."m"
	end
end
local WA_Utf8Sub = function(input, size)
	local output = ""
	if type(input) ~= "string" then
		return output
	end
	local i = 1
	while (size > 0) do
		local byte = input:byte(i)
		if not byte then
			return output
		end
		if byte < 128 then
			output = output .. input:sub(i, i)
			size = size - 1
		elseif byte < 192 then
			output = output .. input:sub(i, i)
		elseif byte < 244 then
			output = output .. input:sub(i, i)
			size = size - 1
		end
		i = i + 1
	end
	while (true) do
		local byte = input:byte(i)
		if byte and byte >= 128 and byte < 192 then
			output = output .. input:sub(i, i)
		else
			break
		end
		i = i + 1
	end
	return output
end
function OctoRenownOnLoad()
	EventFrame = CreateFrame("FRAME", nil)
	EventFrame:RegisterEvent("VARIABLES_LOADED")
	EventFrame:RegisterEvent("COVENANT_CHOSEN")
	EventFrame:RegisterEvent("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
	EventFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	EventFrame:RegisterEvent("PLAYER_LOGIN")
	EventFrame:RegisterEvent("PLAYER_MONEY")
	EventFrame:SetScript("OnEvent", function(...) OctoRenownOnEvent(...) end)
end
function OctoRenownCreateAltFrame()
	local curGUID = UnitGUID("PLAYER")
	local curActivCov = C_Covenants.GetActiveCovenantID()
	local UnitLevel = UnitLevel("PLAYER")
	if curActivCov > 0 and UnitLevel >= 60 then --до крейт фрейма
		OctoRenownLevels[curGUID] = OctoRenownLevels[curGUID] or {}
		local curState = OctoRenownLevels[curGUID]
		if not curState.NightFae then curState.NightFae = 0 end
		if not curState.Venthyr then curState.Venthyr = 0 end
		if not curState.Necrolord then curState.Necrolord = 0 end
		if not curState.Kyrian then curState.Kyrian = 0 end
		if curState.Anima == nil then curState.Anima = {NightFae = 0, Venthyr = 0, Necrolord = 0, Kyrian = 0} end
		---------------------------------------------------------------------------------------------------------
		local covenantID = C_Covenants.GetActiveCovenantID()
		----------------------------------------------------------------------------------------------------------
		--local text = (curServer):gsub("-", " "):gsub("'", " ")
		--local a, b = strsplit(" ", text)
		--if b then curServer = WA_Utf8Sub(a,1)..WA_Utf8Sub(b,1):lower() else curServer = WA_Utf8Sub(a,5):lower() end
		curState.Name = classColor:WrapTextInColorCode(curCharName).."\n"..classColor:WrapTextInColorCode(curServer)
		curState.curServer = curServer
		curState.Class = curClass
		curState.Active = curActivCov
		curState.GUID = curGUID
		curState.Faction = UnitFactionGroup("PLAYER")
		curState.UnitLevel = UnitLevel
	end
	OctoRenownAltFrame = CreateFrame("BUTTON", nil, UIParent, "BackdropTemplate") --GameTooltipTemplate --BackdropTemplate
	OctoRenownAltFrame:SetClampedToScreen(true)
	OctoRenownAltFrame:SetFrameStrata("TOOLTIP")
	OctoRenownAltFrame:SetPoint("CENTER", 0, 0)
	OctoRenownAltFrame:SetBackdrop({
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			edgeSize = 12,
			insets = { left = 1, right = 1, top = 1, bottom = 1 },
	})
	OctoRenownAltFrame:SetBackdropColor(23/255, 23/255, 23/255, 0.80)
	OctoRenownAltFrame:SetScript("OnShow", function() OctoRenownAddDataToAltFrame(); end)
	OctoRenownAltFrame:EnableMouse(true)
	OctoRenownAltFrame:SetMovable(true)
	OctoRenownAltFrame:RegisterForDrag("LeftButton")
	OctoRenownAltFrame:SetScript("OnDragStart", OctoRenownAltFrame.StartMoving)
	OctoRenownAltFrame:SetScript("OnDragStop", function() OctoRenownAltFrame:StopMovingOrSizing() end)
	OctoRenownAltFrame:RegisterForClicks("RightButtonUp")
	OctoRenownAltFrame:SetScript("OnClick", function(self) self:Hide() end)
	OctoRenownAltFrame:SetScript("OnKeyDown", function(self, key)
			if key == GetBindingKey("TOGGLEGAMEMENU") then
				self:Hide()
				self:SetPropagateKeyboardInput(false)
			else
				self:SetPropagateKeyboardInput(true)
			end
	end)
	----------------------------------------------------------------------------------------------------------------------------------------
	OctoRenownAltFrame.CloseButton = CreateFrame("Button", nil, OctoRenownAltFrame, "BackDropTemplate")
	OctoRenownAltFrame.CloseButton:SetSize(curHeight, curHeight)
	OctoRenownAltFrame.CloseButton:SetPoint("TOPRIGHT", OctoRenownAltFrame, "TOPRIGHT", curHeight, 0)
	OctoRenownAltFrame.CloseButton:SetBackdrop({
			edgeFile = "Interface/Buttons/white8x8",
			edgeSize = 1,
	})
	OctoRenownAltFrame.CloseButton:SetBackdropBorderColor(1, 0, 0, 0)
	OctoRenownAltFrame.CloseButton:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 1)
			self.icon:SetVertexColor(1,0,0,1)
	end)
	OctoRenownAltFrame.CloseButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0)
			self.icon:SetVertexColor(1,1,1,1)
	end)
	OctoRenownAltFrame.CloseButton:SetScript("OnMouseDown", function(self)
			self:SetBackdropBorderColor(1, 0, 0, 0.5)
			self.icon:SetVertexColor(1,0,0,0.5)
	end)
	OctoRenownAltFrame.CloseButton:SetScript("OnClick", function() OctoRenownAltFrame:Hide() end)
	local t = OctoRenownAltFrame.CloseButton:CreateTexture(nil,"BACKGROUND")
	OctoRenownAltFrame.CloseButton.icon = t
	t:SetTexture("Interface\\Addons\\Octo_RenownChecker\\Media\\close.tga")
	t:SetVertexColor(1,1,1,1)
	t:SetAllPoints(OctoRenownAltFrame.CloseButton)
	----------------------------------------------------------------------------------------------------------------------------------------
	local toyID1 = 172924
	local PlayerHasToy = PlayerHasToy(toyID1)
	if PlayerHasToy == false then
		local itemName = GetItemInfo(toyID1)
		print (itemName)
		OctoRenownAltFrame.WormholeButton = CreateFrame("Button", "toyID1Button", nil, "SecureActionButtonTemplate") --"SecureActionButtonTemplate" "BackDropTemplate"
		OctoRenownAltFrame.WormholeButton:SetSize(curHeight, curHeight)
		OctoRenownAltFrame.WormholeButton:SetAlpha(0.5)
		OctoRenownAltFrame.WormholeButton:SetPoint("BOTTOMRIGHT", OctoRenownAltFrame, "BOTTOMRIGHT", curHeight, 0)
		OctoRenownAltFrame.WormholeButton:RegisterForClicks("LeftButtonDown")
		OctoRenownAltFrame.WormholeButton:SetAttribute("type", "macro")
		OctoRenownAltFrame.WormholeButton:SetAttribute("macrotext",[[/use item:172924]])
		--OctoRenownAltFrame.WormholeButton:SetBackdrop({
		--        edgeFile = "Interface/Buttons/white8x8",
		--        edgeSize = 1,
		--})
		--OctoRenownAltFrame.WormholeButton:SetBackdropBorderColor(0, 1, 0, 0)
		OctoRenownAltFrame.WormholeButton:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
				GameTooltip:ClearLines()
				GameTooltip:SetToyByItemID(172924)
				GameTooltip:Show()
				--:SetBackdropBorderColor(0, 1, 0, 1)
				self.icon:SetVertexColor(1,1,1,1)
				OctoRenownAltFrame.WormholeButton:SetAlpha(1)
		end)
		OctoRenownAltFrame.WormholeButton:SetScript("OnLeave", function(self)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
				--self:SetBackdropBorderColor(0, 1, 0, 0)
				self.icon:SetVertexColor(1,1,1,1)
				OctoRenownAltFrame.WormholeButton:SetAlpha(0.5)
		end)
		OctoRenownAltFrame.WormholeButton:SetScript("OnMouseDown", function(self)
				--self:SetBackdropBorderColor(0, 1, 0, 0.5)
				self.icon:SetVertexColor(1,1,1,0.5)
		end)
		OctoRenownAltFrame.WormholeButton:SetScript("OnClick", function() end)
		local t = OctoRenownAltFrame.WormholeButton:CreateTexture(nil,"BACKGROUND")
		OctoRenownAltFrame.WormholeButton.icon = t
		t:SetTexture("Interface\\Addons\\Octo_RenownChecker\\Media\\inv_engineering_90_wormholegenerator.tga")
		t:SetVertexColor(1,1,1,1)
		t:SetAllPoints(OctoRenownAltFrame.WormholeButton)
	end
	----------------------------------------------------------------------------------------------------------------------------------------
	OctoRenownAltFrame.line1 = OctoRenownAltFrame:CreateTexture(nil, "BACKGROUND")
	OctoRenownAltFrame.line1:SetHeight(curHeight)
	OctoRenownAltFrame.line1:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 0, -curHeight*1)
	OctoRenownAltFrame.line1:SetPoint("RIGHT")
	OctoRenownAltFrame.line1:SetColorTexture(ColorKyrianR,ColorKyrianG,ColorKyrianB,0.06)
	OctoRenownAltFrame.line2 = OctoRenownAltFrame:CreateTexture(nil, "BACKGROUND")
	OctoRenownAltFrame.line2:SetHeight(curHeight)
	OctoRenownAltFrame.line2:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 0, -curHeight*2)
	OctoRenownAltFrame.line2:SetPoint("RIGHT")
	OctoRenownAltFrame.line2:SetColorTexture(ColorNecrolordR,ColorNecrolordG,ColorNecrolordB,0.06)
	OctoRenownAltFrame.line3 = OctoRenownAltFrame:CreateTexture(nil, "BACKGROUND")
	OctoRenownAltFrame.line3:SetHeight(curHeight)
	OctoRenownAltFrame.line3:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 0, -curHeight*3)
	OctoRenownAltFrame.line3:SetPoint("RIGHT")
	OctoRenownAltFrame.line3:SetColorTexture(ColorNightFaeR,ColorNightFaeG,ColorNightFaeB,0.06)
	OctoRenownAltFrame.line4 = OctoRenownAltFrame:CreateTexture(nil, "BACKGROUND")
	OctoRenownAltFrame.line4:SetHeight(curHeight)
	OctoRenownAltFrame.line4:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 0, -curHeight*4)
	OctoRenownAltFrame.line4:SetPoint("RIGHT")
	OctoRenownAltFrame.line4:SetColorTexture(ColorVenthyrR,ColorVenthyrG,ColorVenthyrB,0.06)
	OctoRenownAltFrame.line5 = OctoRenownAltFrame:CreateTexture(nil, "BACKGROUND")
	OctoRenownAltFrame.line5:SetHeight(curHeight)
	OctoRenownAltFrame.line5:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 0, -curHeight*5)
	OctoRenownAltFrame.line5:SetPoint("RIGHT")
	OctoRenownAltFrame.line5:SetColorTexture(ColorKyrianR,ColorKyrianG,ColorKyrianB,0.06)
	OctoRenownAltFrame.line6 = OctoRenownAltFrame:CreateTexture(nil, "BACKGROUND")
	OctoRenownAltFrame.line6:SetHeight(curHeight)
	OctoRenownAltFrame.line6:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 0, -curHeight*6)
	OctoRenownAltFrame.line6:SetPoint("RIGHT")
	OctoRenownAltFrame.line6:SetColorTexture(ColorNecrolordR,ColorNecrolordG,ColorNecrolordB,0.06)
	OctoRenownAltFrame.line7 = OctoRenownAltFrame:CreateTexture(nil, "BACKGROUND")
	OctoRenownAltFrame.line7:SetHeight(curHeight)
	OctoRenownAltFrame.line7:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 0, -curHeight*7)
	OctoRenownAltFrame.line7:SetPoint("RIGHT")
	OctoRenownAltFrame.line7:SetColorTexture(ColorNightFaeR,ColorNightFaeG,ColorNightFaeB,0.06)
	OctoRenownAltFrame.line8 = OctoRenownAltFrame:CreateTexture(nil, "BACKGROUND")
	OctoRenownAltFrame.line8:SetHeight(curHeight)
	OctoRenownAltFrame.line8:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 0, -curHeight*8)
	OctoRenownAltFrame.line8:SetPoint("RIGHT")
	OctoRenownAltFrame.line8:SetColorTexture(ColorVenthyrR,ColorVenthyrG,ColorVenthyrB,0.06)
	OctoRenownAltFrame.line9 = OctoRenownAltFrame:CreateTexture(nil, "BACKGROUND")
	OctoRenownAltFrame.line9:SetHeight(curHeight)
	OctoRenownAltFrame.line9:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 0, -curHeight*9)
	OctoRenownAltFrame.line9:SetPoint("RIGHT")
	OctoRenownAltFrame.line9:SetColorTexture(0.2,0.2,0.2,0.5)
	OctoRenownAltFrame.line10 = OctoRenownAltFrame:CreateTexture(nil, "BACKGROUND")
	OctoRenownAltFrame.line10:SetHeight(curHeight)
	OctoRenownAltFrame.line10:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 0, -curHeight*10)
	OctoRenownAltFrame.line10:SetPoint("RIGHT")
	OctoRenownAltFrame.line10:SetColorTexture(0.2,0.2,0.2,0.5)
	OctoRenownAltFrame.line11 = OctoRenownAltFrame:CreateTexture(nil, "BACKGROUND")
	OctoRenownAltFrame.line11:SetHeight(curHeight)
	OctoRenownAltFrame.line11:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 0, -curHeight*11)
	OctoRenownAltFrame.line11:SetPoint("RIGHT")
	OctoRenownAltFrame.line11:SetColorTexture(255/255,243/255,113/255,0.1)
	OctoRenownAltFrame.LEFTTEXTTEST0 = OctoRenownAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	OctoRenownAltFrame.LEFTTEXTTEST0:SetSize(curWidthTitle, curHeight)
	OctoRenownAltFrame.LEFTTEXTTEST0:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 6, 0)
	OctoRenownAltFrame.LEFTTEXTTEST0:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 13)
	OctoRenownAltFrame.LEFTTEXTTEST0:SetJustifyV("MIDDLE")
	OctoRenownAltFrame.LEFTTEXTTEST0:SetJustifyH("LEFT")
	OctoRenownAltFrame.LEFTTEXTTEST1 = OctoRenownAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	OctoRenownAltFrame.LEFTTEXTTEST1:SetSize(curWidthTitle, curHeight)
	OctoRenownAltFrame.LEFTTEXTTEST1:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 6, -curHeight*1)
	OctoRenownAltFrame.LEFTTEXTTEST1:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 13)
	OctoRenownAltFrame.LEFTTEXTTEST1:SetText("|T3257748:16:16:::64:64:4:60:4:60|t Kyrian") --Kyrian 3257748
	OctoRenownAltFrame.LEFTTEXTTEST1:SetTextColor(ColorKyrianR, ColorKyrianG, ColorKyrianB, ColorKyrianA)
	OctoRenownAltFrame.LEFTTEXTTEST1:SetJustifyV("MIDDLE")
	OctoRenownAltFrame.LEFTTEXTTEST1:SetJustifyH("LEFT")
	OctoRenownAltFrame.LEFTTEXTTEST2 = OctoRenownAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	OctoRenownAltFrame.LEFTTEXTTEST2:SetSize(curWidthTitle, curHeight)
	OctoRenownAltFrame.LEFTTEXTTEST2:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 6, -curHeight*2)
	OctoRenownAltFrame.LEFTTEXTTEST2:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 13)
	OctoRenownAltFrame.LEFTTEXTTEST2:SetText("|T3257749:16:16:::64:64:4:60:4:60|t Necrolord") --Necrolord 3257749
	OctoRenownAltFrame.LEFTTEXTTEST2:SetTextColor(ColorNecrolordR, ColorNecrolordG, ColorNecrolordB, ColorNecrolordA)
	OctoRenownAltFrame.LEFTTEXTTEST2:SetJustifyV("MIDDLE")
	OctoRenownAltFrame.LEFTTEXTTEST2:SetJustifyH("LEFT")
	OctoRenownAltFrame.LEFTTEXTTEST3 = OctoRenownAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	OctoRenownAltFrame.LEFTTEXTTEST3:SetSize(curWidthTitle, curHeight)
	OctoRenownAltFrame.LEFTTEXTTEST3:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 6, -curHeight*3)
	OctoRenownAltFrame.LEFTTEXTTEST3:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 13)
	OctoRenownAltFrame.LEFTTEXTTEST3:SetText("|T3257750:16:16:::64:64:4:60:4:60|t Night Fae") --Night Fae 3257750
	OctoRenownAltFrame.LEFTTEXTTEST3:SetTextColor(ColorNightFaeR, ColorNightFaeG, ColorNightFaeB, ColorNightFaeA)
	OctoRenownAltFrame.LEFTTEXTTEST3:SetJustifyV("MIDDLE")
	OctoRenownAltFrame.LEFTTEXTTEST3:SetJustifyH("LEFT")
	OctoRenownAltFrame.LEFTTEXTTEST4 = OctoRenownAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	OctoRenownAltFrame.LEFTTEXTTEST4:SetSize(curWidthTitle, curHeight)
	OctoRenownAltFrame.LEFTTEXTTEST4:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 6, -curHeight*4)
	OctoRenownAltFrame.LEFTTEXTTEST4:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 13)
	OctoRenownAltFrame.LEFTTEXTTEST4:SetText("|T3257751:16:16:::64:64:4:60:4:60|t Venthyr") --Venthyr 3257751
	OctoRenownAltFrame.LEFTTEXTTEST4:SetTextColor(ColorVenthyrR, ColorVenthyrG, ColorVenthyrB, ColorVenthyrA)
	OctoRenownAltFrame.LEFTTEXTTEST4:SetJustifyV("MIDDLE")
	OctoRenownAltFrame.LEFTTEXTTEST4:SetJustifyH("LEFT")
	-- OctoRenownAltFrame.LEFTTEXTTEST5 = OctoRenownAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	-- OctoRenownAltFrame.LEFTTEXTTEST5:SetSize(curWidthTitle, curHeight)
	-- OctoRenownAltFrame.LEFTTEXTTEST5:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 6, -curHeight*5)
	-- OctoRenownAltFrame.LEFTTEXTTEST5:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 13)
	-- OctoRenownAltFrame.LEFTTEXTTEST5:SetText("|T3257748:16:16:::64:64:4:60:4:60|t anima") --Kyrian 3257748
	-- OctoRenownAltFrame.LEFTTEXTTEST5:SetJustifyV("MIDDLE")
	-- OctoRenownAltFrame.LEFTTEXTTEST5:SetJustifyH("LEFT")
	-- OctoRenownAltFrame.LEFTTEXTTEST6 = OctoRenownAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	-- OctoRenownAltFrame.LEFTTEXTTEST6:SetSize(curWidthTitle, curHeight)
	-- OctoRenownAltFrame.LEFTTEXTTEST6:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 6, -curHeight*6)
	-- OctoRenownAltFrame.LEFTTEXTTEST6:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 13)
	-- OctoRenownAltFrame.LEFTTEXTTEST6:SetText("|T3257749:16:16:::64:64:4:60:4:60|t anima") --Necrolord 3257749
	-- OctoRenownAltFrame.LEFTTEXTTEST6:SetJustifyV("MIDDLE")
	-- OctoRenownAltFrame.LEFTTEXTTEST6:SetJustifyH("LEFT")
	-- OctoRenownAltFrame.LEFTTEXTTEST7 = OctoRenownAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	-- OctoRenownAltFrame.LEFTTEXTTEST7:SetSize(curWidthTitle, curHeight)
	-- OctoRenownAltFrame.LEFTTEXTTEST7:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 6, -curHeight*7)
	-- OctoRenownAltFrame.LEFTTEXTTEST7:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 13)
	-- OctoRenownAltFrame.LEFTTEXTTEST7:SetText("|T3257750:16:16:::64:64:4:60:4:60|t anima") --Night Fae 3257750
	-- OctoRenownAltFrame.LEFTTEXTTEST7:SetJustifyV("MIDDLE")
	-- OctoRenownAltFrame.LEFTTEXTTEST7:SetJustifyH("LEFT")
	-- OctoRenownAltFrame.LEFTTEXTTEST8 = OctoRenownAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	-- OctoRenownAltFrame.LEFTTEXTTEST8:SetSize(curWidthTitle, curHeight)
	-- OctoRenownAltFrame.LEFTTEXTTEST8:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 6, -curHeight*8)
	-- OctoRenownAltFrame.LEFTTEXTTEST8:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 13)
	-- OctoRenownAltFrame.LEFTTEXTTEST8:SetText("|T3257751:16:16:::64:64:4:60:4:60|t anima") --Venthyr 3257751
	-- OctoRenownAltFrame.LEFTTEXTTEST8:SetJustifyV("MIDDLE")
	-- OctoRenownAltFrame.LEFTTEXTTEST8:SetJustifyH("LEFT")
	OctoRenownAltFrame.LEFTTEXTTEST9 = OctoRenownAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	OctoRenownAltFrame.LEFTTEXTTEST9:SetSize(curWidthTitle, curHeight)
	OctoRenownAltFrame.LEFTTEXTTEST9:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 6, -curHeight*9)
	OctoRenownAltFrame.LEFTTEXTTEST9:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 13)
	OctoRenownAltFrame.LEFTTEXTTEST9:SetText("|T4074774:16:16:::64:64:4:60:4:60|t ZM")
	OctoRenownAltFrame.LEFTTEXTTEST9:SetJustifyV("MIDDLE")
	OctoRenownAltFrame.LEFTTEXTTEST9:SetJustifyH("LEFT")
	OctoRenownAltFrame.LEFTTEXTTEST10 = OctoRenownAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	OctoRenownAltFrame.LEFTTEXTTEST10:SetSize(curWidthTitle, curHeight)
	OctoRenownAltFrame.LEFTTEXTTEST10:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 6, -curHeight*10)
	OctoRenownAltFrame.LEFTTEXTTEST10:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 13)
	OctoRenownAltFrame.LEFTTEXTTEST10:SetText("|T3528312:16:16:::64:64:4:60:4:60|t WB")
	OctoRenownAltFrame.LEFTTEXTTEST10:SetJustifyV("MIDDLE")
	OctoRenownAltFrame.LEFTTEXTTEST10:SetJustifyH("LEFT")
	OctoRenownAltFrame.LEFTTEXTTEST11 = OctoRenownAltFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	OctoRenownAltFrame.LEFTTEXTTEST11:SetSize(curWidthTitle, curHeight)
	OctoRenownAltFrame.LEFTTEXTTEST11:SetPoint("TOPLEFT", OctoRenownAltFrame, "TOPLEFT", 6, -curHeight*11)
	OctoRenownAltFrame.LEFTTEXTTEST11:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 11)
	OctoRenownAltFrame.LEFTTEXTTEST11:SetJustifyV("MIDDLE")
	OctoRenownAltFrame.LEFTTEXTTEST11:SetJustifyH("LEFT")
	OctoRenownAddDataToAltFrame()
	OctoRenownAltFrame:Hide()
end
function OctoQuestUpdate()
	local curActivCov = C_Covenants.GetActiveCovenantID()
	local UnitLevel = UnitLevel("PLAYER")
	if curActivCov == 0 or UnitLevel < 60 then return end
	local curGUID = UnitGUID("PLAYER")
	----------------------------------------------------------------------------------------------------------
	local questIDWB = 65143
	local maslengoWB = C_QuestLog.IsQuestFlaggedCompleted(questIDWB)
	----------------------------------------------------------------------------------------------------------
	local questID = 66042
	local maslengoZM = ""
	if C_QuestLog.IsComplete(questID) == true then maslengoZM = 100 --100(можно сдать)
	elseif C_QuestLog.IsQuestFlaggedCompleted(questID) == true then maslengoZM = true --true(сделан)
	elseif C_QuestLog.IsQuestFlaggedCompleted(questID) == false and C_QuestLog.IsOnQuest(questID) == false then maslengoZM = false --false (не сделан и нет квеста)
	elseif C_QuestLog.IsComplete(questID) == false then
		maslengoZM = GetQuestProgressBarPercent(questID) --не сделан и есть квест
	end
	---------------------------------------------------------------------------------------------------------
	local questIDKUST = 65282
	local maslengoSH = C_QuestLog.IsQuestFlaggedCompleted(questIDKUST)
	----------------------------------------------------------------------------------------------------------
	OctoRenownLevels[curGUID] = OctoRenownLevels[curGUID] or {}
	local curState = OctoRenownLevels[curGUID]
	curState.maslengoWB = maslengoWB
	curState.maslengoZM = maslengoZM
	curState.maslengoSH = maslengoSH
end
function OctoMoneyUpdate()
	local curActivCov = C_Covenants.GetActiveCovenantID()
	local UnitLevel = UnitLevel("PLAYER")
	if curActivCov == 0 or UnitLevel < 60 then return end
	local curGUID = UnitGUID("PLAYER")
	local Money = GetMoney()/10000
	----------------------------------------------------------------------------------------------------------
	OctoRenownLevels[curGUID] = OctoRenownLevels[curGUID] or {}
	local curState = OctoRenownLevels[curGUID]
	curState.Money = Money
end
function OctoRenownAddDataToAltFrame()
	local curGUID = UnitGUID("PLAYER")
	local otstyp = 7
	local covenantID = C_Covenants.GetActiveCovenantID()
	local UnitLevel = UnitLevel("PLAYER")
	local curActivCov = C_Covenants.GetActiveCovenantID()
	OctoRenownAltFrame.AllCharFrames = {}
	local sorted = {}
	for curCharGUID, CharInfo in pairs(OctoRenownLevels) do
		sorted[#sorted+1] = CharInfo
	end
	sort(sorted,function(a,b)
			return a.curServer < b.curServer or a.curServer == b.curServer and a.Name < b.Name
	end)
	TotalTransAnima = 0
	TotalMoney = 0
	for i, CharInfo in pairs(sorted) do
		local curCharGUID = CharInfo.GUID
		local curName = nil
		if CharInfo.Name == nil then curName = "UnLogged Char" else curName = CharInfo.Name end
		local CurCharFrame
		if not OctoRenownAltFrame[curCharGUID] then
			OctoRenownAltFrame[curCharGUID] = CreateFrame("FRAME", nil, OctoRenownAltFrame)
			CurCharFrame = OctoRenownAltFrame[curCharGUID]
			CurCharFrame:SetPoint("BOTTOM", 0, 0)
			CurCharFrame.BG = CurCharFrame:CreateTexture(nil,"BACKGROUND")
			CurCharFrame.BG:Hide()
			--CurCharFrame.BG:SetAllPoints()
			CurCharFrame.BG:SetPoint("TOPLEFT", 0, -curHeight) -- -1, 1
			CurCharFrame.BG:SetPoint("BOTTOMRIGHT", 0, 0) -- 1, -1
			CurCharFrame.BG:SetColorTexture(r,g,b,0.2)
			CurCharFrame.DeleteButton = CreateFrame("BUTTON", nil, CurCharFrame, "BackDropTemplate")
			CurCharFrame.CharName = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			CurCharFrame.CharNameBG = CurCharFrame:CreateTexture(nil,"BACKGROUND")
			CurCharFrame.CharNameBG:SetAllPoints(CurCharFrame.CharName)
			if CharInfo.Faction == "Horde" then
				CurCharFrame.CharNameBG:SetColorTexture(1,0,0,0.1)
			else
				CurCharFrame.CharNameBG:SetColorTexture(0,0,1,0.2)
			end
			--CurCharFrame.curServer = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			CurCharFrame.KyrianLevel = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			CurCharFrame.NecrolordLevel = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			CurCharFrame.NightFaeLevel = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			CurCharFrame.VenthyrLevel = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			CurCharFrame.KyrianAnima = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			CurCharFrame.NecrolordAnima = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			CurCharFrame.NightFaeAnima = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			CurCharFrame.VenthyrAnima = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall") --8
			CurCharFrame.ZM = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			CurCharFrame.WB = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			CurCharFrame.SH = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			CurCharFrame.Money = CurCharFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		else
			CurCharFrame = OctoRenownAltFrame[curCharGUID]
		end
		CharInfo.GUID = curCharGUID
		if CharInfo.Anima == nil then CharInfo.Anima = {NightFae = 0, Venthyr = 0, Necrolord = 0, Kyrian = 0} end
		CurCharFrame:SetSize(curWidth, curHeight)
		OctoRenownAltFrame:SetBackdropBorderColor(0, 0, 0, 1)
		OctoRenownAltFrame:SetBackdropColor(23/255, 23/255, 23/255, 0.80)
		if #OctoRenownAltFrame.AllCharFrames == 0 then CurCharFrame:SetPoint("TOPRIGHT", 0, 0)
		else CurCharFrame:SetPoint("TOPRIGHT", OctoRenownAltFrame.AllCharFrames[#OctoRenownAltFrame.AllCharFrames], "TOPLEFT", 0, 0) end
		OctoRenownAltFrame.AllCharFrames[#OctoRenownAltFrame.AllCharFrames + 1] = CurCharFrame
		local curAnima = {Kyrian = 0, Necrolord = 0, NightFae = 0, Venthyr = 0,}
		local curTranfAnima = 0
		if CharInfo.Kyrian ~= 0 then curAnima.Kyrian = CharInfo.Anima.Kyrian end
		if CharInfo.Necrolord ~= 0 then curAnima.Necrolord = CharInfo.Anima.Necrolord end
		if CharInfo.NightFae ~= 0 then curAnima.NightFae = CharInfo.Anima.NightFae end
		if CharInfo.Venthyr ~= 0 then curAnima.Venthyr = CharInfo.Anima.Venthyr end
		curTranfAnima = (curAnima.Kyrian) + (curAnima.Necrolord) + (curAnima.NightFae) + (curAnima.Venthyr)
		TotalTransAnima = TotalTransAnima + curTranfAnima
		local curMoney = 0
		if CharInfo.Money ~= 0 and curServer == CharInfo.curServer then curMoney = CharInfo.Money end
		--print(curServer)
		TotalMoney = TotalMoney + curMoney
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		CurCharFrame.CharName:SetSize(curWidth, curHeight)
		CurCharFrame.CharName:SetPoint("TOP", CurCharFrame, "TOP", 0, -2)
		CurCharFrame.CharName:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 10)
		CurCharFrame.CharName:SetText(CharInfo.Name)
		CurCharFrame.CharName:SetWordWrap(true) --true перенос, fasle одна строка
		CurCharFrame.CharName:SetJustifyV("TOP")
		--CurCharFrame.CharName:SetJustifyH("CENTER")
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		--CurCharFrame.curServer:SetSize(curWidth, curHeight)
		--CurCharFrame.curServer:SetPoint("TOP", CurCharFrame, "TOP", 0, -12)
		--CurCharFrame.curServer:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 10)
		--CurCharFrame.curServer:SetText(classColor:WrapTextInColorCode(CharInfo.curServer))
		--CurCharFrame.curServer:SetWordWrap(false) --true перенос, fasle одна строка
		--CurCharFrame.curServer:SetJustifyV("TOP")
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		CurCharFrame.DeleteButton:SetSize(16, 10)
		CurCharFrame.DeleteButton:SetPoint("TOP", CurCharFrame, "BOTTOM", 0, -4)
		CurCharFrame.DeleteButton:SetBackdrop({
				edgeFile = "Interface/Buttons/white8x8",
				edgeSize = 1,
		})
		CurCharFrame.DeleteButton:SetBackdropBorderColor(1, 0, 0, 0)
		CurCharFrame.DeleteButton:SetScript("OnEnter", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 1)
				self.icon:SetVertexColor(1,0,0,1)
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
				GameTooltip:ClearLines()
				GameTooltip:SetText(DELETE)
				GameTooltip:Show()
		end)
		CurCharFrame.DeleteButton:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(1,1,1,1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		CurCharFrame.DeleteButton:SetScript("OnMouseDown", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 0.5)
				self.icon:SetVertexColor(1,0,0,0.5)
		end)
		CurCharFrame.DeleteButton:SetScript("OnClick", function() OctoRenownCheckerDeleteChar(curCharGUID) end)
		local t = CurCharFrame.DeleteButton:CreateTexture(nil,"BACKGROUND")
		CurCharFrame.DeleteButton.icon = t
		t:SetTexture("Interface\\Addons\\Octo_RenownChecker\\Media\\close.tga")
		t:SetVertexColor(1,1,1,1)
		t:SetAllPoints(CurCharFrame.DeleteButton)
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		CurCharFrame.KyrianLevel:SetSize(curWidth, curHeight)
		CurCharFrame.KyrianLevel:SetPoint("TOP", CurCharFrame, "TOP", 0, -curHeight*1)
		CurCharFrame.KyrianLevel:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], textSize13, "OUTLINE")
		CurCharFrame.KyrianLevel:SetText(CharInfo.Kyrian)
		CurCharFrame.KyrianLevel:SetTextColor(ColorKyrianR, ColorKyrianG, ColorKyrianB, ColorKyrianA)
		CurCharFrame.KyrianLevel:SetJustifyV("MIDDLE")
		CurCharFrame.KyrianLevel:SetJustifyH("CENTER")
		CurCharFrame.NecrolordLevel:SetSize(curWidth, curHeight)
		CurCharFrame.NecrolordLevel:SetPoint("TOP", CurCharFrame, "TOP", 0, -curHeight*2)
		CurCharFrame.NecrolordLevel:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], textSize13, "OUTLINE")
		CurCharFrame.NecrolordLevel:SetText(CharInfo.Necrolord)
		CurCharFrame.NecrolordLevel:SetTextColor(ColorNecrolordR, ColorNecrolordG, ColorNecrolordB, ColorNecrolordA)
		CurCharFrame.NecrolordLevel:SetJustifyV("MIDDLE")
		CurCharFrame.NecrolordLevel:SetJustifyH("CENTER")
		CurCharFrame.NightFaeLevel:SetSize(curWidth, curHeight)
		CurCharFrame.NightFaeLevel:SetPoint("TOP", CurCharFrame, "TOP", 0, -curHeight*3)
		CurCharFrame.NightFaeLevel:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], textSize13, "OUTLINE")
		CurCharFrame.NightFaeLevel:SetText(CharInfo.NightFae)
		CurCharFrame.NightFaeLevel:SetTextColor(ColorNightFaeR, ColorNightFaeG, ColorNightFaeB, ColorNightFaeA)
		CurCharFrame.NightFaeLevel:SetJustifyV("MIDDLE")
		CurCharFrame.NightFaeLevel:SetJustifyH("CENTER")
		CurCharFrame.VenthyrLevel:SetSize(curWidth, curHeight)
		CurCharFrame.VenthyrLevel:SetPoint("TOP", CurCharFrame, "TOP", 0, -curHeight*4)
		CurCharFrame.VenthyrLevel:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], textSize13, "OUTLINE")
		CurCharFrame.VenthyrLevel:SetText(CharInfo.Venthyr)
		CurCharFrame.VenthyrLevel:SetTextColor(ColorVenthyrR, ColorVenthyrG, ColorVenthyrB, ColorVenthyrA)
		CurCharFrame.VenthyrLevel:SetJustifyV("MIDDLE")
		CurCharFrame.VenthyrLevel:SetJustifyH("CENTER")
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		CurCharFrame.KyrianAnima:SetSize(curWidth, curHeight)
		CurCharFrame.KyrianAnima:SetPoint("TOP", CurCharFrame, "TOP", 0, -curHeight*5)
		CurCharFrame.KyrianAnima:SetText(CompactNumberFormat(CharInfo.Anima.Kyrian))
		CurCharFrame.KyrianAnima:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], textSize13, "OUTLINE")
		CurCharFrame.KyrianAnima:SetTextColor(ColorKyrianR, ColorKyrianG, ColorKyrianB, ColorKyrianA)
		CurCharFrame.KyrianAnima:SetJustifyV("MIDDLE")
		CurCharFrame.KyrianAnima:SetJustifyH("CENTER")
		CurCharFrame.NecrolordAnima:SetSize(curWidth, curHeight)
		CurCharFrame.NecrolordAnima:SetPoint("TOP", CurCharFrame, "TOP", 0, -curHeight*6)
		CurCharFrame.NecrolordAnima:SetText(CompactNumberFormat(CharInfo.Anima.Necrolord))
		CurCharFrame.NecrolordAnima:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], textSize13, "OUTLINE")
		CurCharFrame.NecrolordAnima:SetTextColor(ColorNecrolordR, ColorNecrolordG, ColorNecrolordB, ColorNecrolordA)
		CurCharFrame.NecrolordAnima:SetJustifyV("MIDDLE")
		CurCharFrame.NecrolordAnima:SetJustifyH("CENTER")
		CurCharFrame.NightFaeAnima:SetSize(curWidth, curHeight)
		CurCharFrame.NightFaeAnima:SetPoint("TOP", CurCharFrame, "TOP", 0, -curHeight*7)
		CurCharFrame.NightFaeAnima:SetText(CompactNumberFormat(CharInfo.Anima.NightFae))
		CurCharFrame.NightFaeAnima:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], textSize13, "OUTLINE")
		CurCharFrame.NightFaeAnima:SetTextColor(ColorNightFaeR, ColorNightFaeG, ColorNightFaeB, ColorNightFaeA)
		CurCharFrame.NightFaeAnima:SetJustifyV("MIDDLE")
		CurCharFrame.NightFaeAnima:SetJustifyH("CENTER")
		CurCharFrame.VenthyrAnima:SetSize(curWidth, curHeight)
		CurCharFrame.VenthyrAnima:SetPoint("TOP", CurCharFrame, "TOP", 0, -curHeight*8)
		CurCharFrame.VenthyrAnima:SetText(CompactNumberFormat(CharInfo.Anima.Venthyr))
		CurCharFrame.VenthyrAnima:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], textSize13, "OUTLINE")
		CurCharFrame.VenthyrAnima:SetTextColor(ColorVenthyrR, ColorVenthyrG, ColorVenthyrB, ColorVenthyrA)
		CurCharFrame.VenthyrAnima:SetJustifyV("MIDDLE")
		CurCharFrame.VenthyrAnima:SetJustifyH("CENTER")
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		CurCharFrame.ZM:SetSize(curWidth, curHeight)
		CurCharFrame.ZM:SetPoint("TOP", CurCharFrame, "TOP", 0, -curHeight*9)
		CurCharFrame.ZM:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 11, "OUTLINE")
		CurCharFrame.ZM:SetTextColor(ColorVenthyrR, ColorVenthyrG, ColorVenthyrB, ColorVenthyrA)
		CurCharFrame.ZM:SetText(CharInfo.maslengoZM)
		if CharInfo.maslengoZM == nil then
			CurCharFrame.ZM:SetText("NO DATA")
		elseif CharInfo.maslengoZM then
			if type(CharInfo.maslengoZM) == "number" then --100
				if CharInfo.maslengoZM == 100 then
					CurCharFrame.ZM:SetText("Можно сдать") --true
					CurCharFrame.ZM:SetTextColor(1, 0.93, 0.43, 1) --желтый
				else
					CurCharFrame.ZM:SetText(CharInfo.maslengoZM.."%") --сейчас выполняется в %
					CurCharFrame.ZM:SetTextColor(1, 0, 0, 1) --красный
					CurCharFrame.ZM:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 13, "OUTLINE")
				end
			else
				CurCharFrame.ZM:SetText(DONE)
				CurCharFrame.ZM:SetTextColor(0, 1, 0, 1)
			end
		else
			CurCharFrame.ZM:SetText(NONE)
			CurCharFrame.ZM:SetTextColor(1, 0, 0, 1)
		end
		CurCharFrame.ZM:SetJustifyV("MIDDLE")
		CurCharFrame.ZM:SetJustifyH("CENTER")
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		CurCharFrame.WB:SetSize(curWidth, curHeight)
		CurCharFrame.WB:SetPoint("TOP", CurCharFrame, "TOP", 0, -curHeight*10)
		CurCharFrame.WB:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 11, "OUTLINE")
		CurCharFrame.WB:SetText(CharInfo.maslengoWB and DONE or NONE)
		if CharInfo.maslengoWB then CurCharFrame.WB:SetTextColor(0,1,0,1) else CurCharFrame.WB:SetTextColor(1,0,0,1) end
		CurCharFrame.WB:SetJustifyV("MIDDLE")
		CurCharFrame.WB:SetJustifyH("CENTER")
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		CurCharFrame.Money:SetSize(curWidth, curHeight)
		CurCharFrame.Money:SetPoint("TOP", CurCharFrame, "TOP", 0, -curHeight*11)
		CurCharFrame.Money:SetFont([[Interface\Addons\Octo_RenownChecker\Media\Expressway.ttf]], 11, "OUTLINE")
		CurCharFrame.Money:SetText("|T133784:12:12:::64:64:4:60:4:60|t".."|cffFFF371"..CompactNumberFormat(CharInfo.Money).."|r") --0.949, 0.902, 0.6 icon = 133784 https://www.wowhead.com/icons/name:coin
		CurCharFrame.Money:SetTextColor(0,1,0,1)
		CurCharFrame.Money:SetJustifyV("MIDDLE")
		CurCharFrame.Money:SetJustifyH("CENTER")
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		local RenownLevel80 = C_CovenantSanctumUI.GetRenownLevel(curActivCov)
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		if CharInfo.Kyrian == 80 then --[[CurCharFrame.KyrianLevel:SetText(" ")]] end
		if CharInfo.Kyrian < 60 then CurCharFrame.KyrianLevel:SetTextColor(ColorKyrianR,ColorKyrianG,ColorKyrianB,ColorKyrianA)
			CurCharFrame.KyrianLevel:SetText("|cffFF0000(|r"..CharInfo.Kyrian.."|cffFF0000)|r") end
		if curAnima.Kyrian < 1 then CurCharFrame.KyrianAnima:SetTextColor(ColorKyrianR/1.5,ColorKyrianG/1.5,ColorKyrianB/1.5,ColorKyrianA) end
		if CharInfo.Kyrian == 0 then CurCharFrame.KyrianLevel:SetTextColor(0.8,0.8,0.8,0.5) CurCharFrame.KyrianLevel:SetText(NONE) end
		if CharInfo.Anima.Kyrian == 0 then CurCharFrame.KyrianAnima:SetTextColor(0.8,0.8,0.8,0.5) CurCharFrame.KyrianAnima:SetText(NONE) end
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		if CharInfo.Necrolord == 80 then --[[CurCharFrame.NecrolordLevel:SetText(" ")]] end
		if CharInfo.Necrolord < 60 then CurCharFrame.NecrolordLevel:SetTextColor(ColorNecrolordR,ColorNecrolordG,ColorNecrolordB,ColorNecrolordA)
			CurCharFrame.NecrolordLevel:SetText("|cffFF0000(|r"..CharInfo.Necrolord.."|cffFF0000)|r") end
		if curAnima.Necrolord < 1 then CurCharFrame.NecrolordAnima:SetTextColor(ColorNecrolordR/1.5,ColorNecrolordG/1.5,ColorNecrolordB/1.5,ColorNecrolordA) end
		if CharInfo.Necrolord == 0 then CurCharFrame.NecrolordLevel:SetTextColor(0.8,0.8,0.8,0.5) CurCharFrame.NecrolordLevel:SetText(NONE) end
		if CharInfo.Anima.Necrolord == 0 then CurCharFrame.NecrolordAnima:SetTextColor(0.8,0.8,0.8,0.5) CurCharFrame.NecrolordAnima:SetText(NONE) end
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		if CharInfo.NightFae == 80 then --[[CurCharFrame.NightFaeLevel:SetText(" ")]] end
		if CharInfo.NightFae < 60 then CurCharFrame.NightFaeLevel:SetTextColor(ColorNightFaeR,ColorNightFaeG,ColorNightFaeB,ColorNightFaeA)
			CurCharFrame.NightFaeLevel:SetText("|cffFF0000(|r"..CharInfo.NightFae.."|cffFF0000)|r") end
		if curAnima.NightFae < 1 then CurCharFrame.NightFaeAnima:SetTextColor(ColorNightFaeR/1.5,ColorNightFaeG/1.5,ColorNightFaeB/1.5,ColorNightFaeA) end
		if CharInfo.NightFae == 0 then CurCharFrame.NightFaeLevel:SetTextColor(0.8,0.8,0.8,0.5) CurCharFrame.NightFaeLevel:SetText(NONE) end
		if CharInfo.Anima.NightFae == 0 then CurCharFrame.NightFaeAnima:SetTextColor(0.8,0.8,0.8,0.5) CurCharFrame.NightFaeAnima:SetText(NONE) end
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		if CharInfo.Venthyr == 80 then --[[CurCharFrame.VenthyrLevel:SetText(" ")]] end
		if CharInfo.Venthyr < 60 then CurCharFrame.VenthyrLevel:SetTextColor(ColorVenthyrR,ColorVenthyrG,ColorVenthyrB,ColorVenthyrA)
			CurCharFrame.VenthyrLevel:SetText("|cffFF0000(|r"..CharInfo.Venthyr.."|cffFF0000)|r") end
		if curAnima.Venthyr < 1 then CurCharFrame.VenthyrAnima:SetTextColor(ColorVenthyrR/1.5,ColorVenthyrG/1.5,ColorVenthyrB/1.5,ColorVenthyrA) end
		if CharInfo.Venthyr == 0 then CurCharFrame.VenthyrLevel:SetTextColor(0.8,0.8,0.8,0.5) CurCharFrame.VenthyrLevel:SetText(NONE) end
		if CharInfo.Anima.Venthyr == 0 then CurCharFrame.VenthyrAnima:SetTextColor(0.8,0.8,0.8,0.5) CurCharFrame.VenthyrAnima:SetText("0") end
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		if curGUID == curCharGUID then
			--local leftarrow = classColor:WrapTextInColorCode(">>")--»»
			-- rightarrow = classColor:WrapTextInColorCode("<<")--««
			local leftarrow = (">>")--»»
			local rightarrow = ("<<")--««
			CurCharFrame.BG:Show()
			if curActivCov == 1 then
				--if RenownLevel80 == 80 then
				--CurCharFrame.KyrianLevel:SetText("Kyrian")
				--else
				CurCharFrame.KyrianLevel:SetText(leftarrow .. CurCharFrame.KyrianLevel:GetText() .. rightarrow)
				CurCharFrame.KyrianAnima:SetText(leftarrow .. CurCharFrame.KyrianAnima:GetText() .. rightarrow)
				--end
			elseif curActivCov == 4 then
				--if RenownLevel80 == 80 then
				--CurCharFrame.NecrolordLevel:SetText("Necrolord")
				--else
				CurCharFrame.NecrolordLevel:SetText(leftarrow .. CurCharFrame.NecrolordLevel:GetText() .. rightarrow)
				CurCharFrame.NecrolordAnima:SetText(leftarrow .. CurCharFrame.NecrolordAnima:GetText() .. rightarrow)
				--end
			elseif curActivCov == 3 then
				--if RenownLevel80 == 80 then
				--CurCharFrame.NightFaeLevel:SetText("Night Fae")
				--else
				CurCharFrame.NightFaeLevel:SetText(leftarrow .. CurCharFrame.NightFaeLevel:GetText() .. rightarrow)
				CurCharFrame.NightFaeAnima:SetText(leftarrow .. CurCharFrame.NightFaeAnima:GetText() .. rightarrow)
				--end
			elseif curActivCov == 2 then
				--if RenownLevel80 == 80 then
				--CurCharFrame.VenthyrLevel:SetText("Venthyr")
				--else
				CurCharFrame.VenthyrLevel:SetText(leftarrow .. CurCharFrame.VenthyrLevel:GetText() .. rightarrow)
				CurCharFrame.VenthyrAnima:SetText(leftarrow .. CurCharFrame.VenthyrAnima:GetText() .. rightarrow)
				--end
			end
		end
	end --end для фора
	local curServerShort = GetRealmName()
	local text = (curServerShort):gsub("-", " "):gsub("'", " ")
	local a, b = strsplit(" ", text)
	if b then curServerShort = WA_Utf8Sub(a,1)..WA_Utf8Sub(b,1):upper() else curServerShort = WA_Utf8Sub(a,3):lower() end
	OctoRenownAltFrame.LEFTTEXTTEST0:SetText("|T3528288:16:16:::64:64:4:60:4:60|t ".."|cff00A3FF"..CompactNumberFormat(TotalTransAnima).."|r")
	OctoRenownAltFrame.LEFTTEXTTEST11:SetText("|T133784:16:16:::64:64:4:60:4:60|t ".."|cffFFF371"..curServerShort..": "..CompactNumberFormat(TotalMoney).."|r")
	local curAltFrameWidth = #OctoRenownAltFrame.AllCharFrames * curWidth/2
	OctoRenownAltFrame:SetSize(curAltFrameWidth*2+curWidthTitle, curHeight*(11+1)) --Width ширина, Height высота
end
function OctoRenownCheckerDeleteChar(curGUID)
	OctoRenownLevels[curGUID] = nil
	for X, Y in pairs(OctoRenownAltFrame.AllCharFrames) do
		if Y == OctoRenownAltFrame[curGUID] then
			OctoRenownAltFrame.AllCharFrames[X].parent = nil
			OctoRenownAltFrame.AllCharFrames[X]:Hide()
			OctoRenownAltFrame.AllCharFrames[X] = nil
		end
	end
	OctoRenownAddDataToAltFrame()
end
function OctoRenownFrameUpdateValues()
	local curGUID = UnitGUID("PLAYER")
	if valuesRecentlyUpdated == false then
		valuesRecentlyUpdated = true
		C_Timer.After(2, function()
				valuesRecentlyUpdated = false
		end)
		C_Timer.After(1, function()
				local curCovID = C_Covenants.GetActiveCovenantID()
				local UnitLevel = UnitLevel("PLAYER")
				if curCovID ~= nil and curCovID ~= 0 and UnitLevel >= 60 then
					local curCovName = CovenantNames[curCovID]
					local curCovLevel = C_CovenantSanctumUI.GetRenownLevel()
					local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1813)
					local curAnimaAmount = currencyInfo.quantity--string.format("%.1fk", (currencyInfo.quantity / 1000))
					if OctoRenownLevels == nil then OctoRenownLevels = {} end
					if OctoRenownLevels[curGUID] == nil then OctoRenownLevels[curGUID] = {NightFae = 0, Venthyr = 0, Necrolord = 0, Kyrian = 0,} end
					if OctoRenownLevels[curGUID].Anima == nil then OctoRenownLevels[curGUID].Anima = {NightFae = 0, Venthyr = 0, Necrolord = 0, Kyrian = 0} end
					OctoRenownLevels[curGUID][curCovName] = curCovLevel
					OctoRenownLevels[curGUID].Anima[curCovName] = curAnimaAmount
				end
		end)
	end
end
function OctoRenownOnEvent(self, event, ...)
	if event == "COVENANT_CHOSEN" then
		OctoRenownFrameUpdateValues()
		if OctoRenownAltFrame:IsShown() then OctoRenownAddDataToAltFrame() end
		C_Timer.After(1, function()
				OctoRenownFrameUpdateValues()
				if OctoRenownAltFrame:IsShown() then OctoRenownAddDataToAltFrame() end
		end)
		C_Timer.After(3, function()
				OctoRenownFrameUpdateValues()
				if OctoRenownAltFrame:IsShown() then OctoRenownAddDataToAltFrame() end
		end)
	elseif event == "QUEST_LOG_UPDATE" then
		OctoQuestUpdate()
		if OctoRenownAltFrame and OctoRenownAltFrame:IsShown() then OctoRenownAddDataToAltFrame() end
	elseif event == "PLAYER_MONEY" then
		OctoMoneyUpdate()
		if OctoRenownAltFrame and OctoRenownAltFrame:IsShown() then OctoRenownAddDataToAltFrame() end
	elseif event == "COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED" then
		OctoRenownFrameUpdateValues()
		if OctoRenownAltFrame:IsShown() then OctoRenownAddDataToAltFrame() end
		C_Timer.After(1, function()
				OctoRenownFrameUpdateValues()
				if OctoRenownAltFrame:IsShown() then OctoRenownAddDataToAltFrame() end
		end)
	elseif event == "CURRENCY_DISPLAY_UPDATE" then
		if ... == 1813 then
			OctoRenownFrameUpdateValues()
			if OctoRenownAltFrame:IsShown() then OctoRenownAddDataToAltFrame() end
		end
	elseif event == "VARIABLES_LOADED" then
		if OctoRenownLevels == nil then OctoRenownLevels = {} end
		if OctoRenownVars == nil then OctoRenownVars = {} OctoRenownVars.Position = {"CENTER", nil, nil, 0, 0} end
		if OctoRenownVars.Size == nil then OctoRenownVars.Size = "Full" end
		OctoRenownFrameUpdateValues()
		C_Timer.After(1, function()
				OctoRenownCreateAltFrame()
		end)
		local MinimapName = "AnimaCheckerMinimap"
		local ldb_icon = ldb:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = 3528288,
				OnClick = function(_, button)
					OctoRenownAltFrame:SetShown(not OctoRenownAltFrame:IsShown())
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, AddonTitle)
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		OctoRenownVars.omb = OctoRenownVars.omb or {}
		ldbi:Register(MinimapName, ldb_icon, OctoRenownVars.omb)
		ldbi:Show(MinimapName)
	elseif event == "PLAYER_LOGIN" then
		self:RegisterEvent("QUEST_LOG_UPDATE")
		self:RegisterEvent("PLAYER_MONEY")
		OctoQuestUpdate()
		OctoMoneyUpdate()
	end
end
OctoRenownOnLoad()
Octo.SlashCommands["RC"] = function()
	OctoRenownAltFrame:SetShown()
end
Octo.SlashCommands["rc"] = Octo.SlashCommands["RC"]