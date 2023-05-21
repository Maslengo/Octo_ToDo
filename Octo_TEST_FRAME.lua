local AddonName, E = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
E.modules = {}
--------------------------------------------------------------------------------
local bytetoB64 = {
	[0]="a", "b", "c", "d", "e", "f", "g", "h",
	"i", "j", "k", "l", "m", "n", "o", "p",
	"q", "r", "s", "t", "u", "v", "w", "x",
	"y", "z", "A", "B", "C", "D", "E", "F",
	"G", "H", "I", "J", "K", "L", "M", "N",
	"O", "P", "Q", "R", "S", "T", "U", "V",
	"W", "X", "Y", "Z", "0", "1", "2", "3",
	"4", "5", "6", "7", "8", "9", "(", ")"
}
function GenerateUniqueID()
	local s = {}
	for i=1, 11 do
		tinsert(s, bytetoB64[math.random(0, 63)])
	end
	return table.concat(s)
end
local white_list = {
	--[110560] = true, --TEST
	--DRAENOR
	[128313] = true,
	[111956] = true,
	[5523] = true,
	[205682] = true,
	[189765] = true,
	[194072] = true,
	[198395] = true,
	[198438] = true,
	[198863] = true,
	[198864] = true,
	[198865] = true,
	[198866] = true,
	[198867] = true,
	[198868] = true,
	[198869] = true,
	[199192] = true,
	[199197] = true,
	[199472] = true,
	[199473] = true,
	[199474] = true,
	[199475] = true,
	[200069] = true,
	[200070] = true,
	[200072] = true,
	[200073] = true,
	[200095] = true,
	[200285] = true,
	[200287] = true,
	[200288] = true,
	[200289] = true,
	[200300] = true,
	[200452] = true,
	[200453] = true,
	[200454] = true,
	[200455] = true,
	[200468] = true,
	[200513] = true,
	[200515] = true,
	[200516] = true,
	[200609] = true,
	[200610] = true,
	[200611] = true,
	[201326] = true,
	[201352] = true,
	[201439] = true,
	[201462] = true,
	[201728] = true,
	[201755] = true,
	[201756] = true,
	[201781] = true,
	[201782] = true,
	[201817] = true,
	[201921] = true,
	[201922] = true,
	[201923] = true,
	[201924] = true,
	[202052] = true,
	[202052] = true,
	[202079] = true,
	[202080] = true,
	[202091] = true,
	[202092] = true,
	[202093] = true,
	[202094] = true,
	[202097] = true,
	[202098] = true,
	[202142] = true,
	[202171] = true,
	[202171] = true,
	[202172] = true,
	[202371] = true,
	[202667] = true,
	[202668] = true,
	[202669] = true,
	[202670] = true,
	[203217] = true,
	[203220] = true,
	[203222] = true,
	[203224] = true,
	[203476] = true,
	[203681] = true,
	[203699] = true,
	[203700] = true,
	[203702] = true,
	[204359] = true,
	[204378] = true,
	[204379] = true,
	[204380] = true,
	[204381] = true,
	[204383] = true,
	[204558] = true,
	[204559] = true,
	[204560] = true,
	[204573] = true,
	[204574] = true,
	[204575] = true,
	[204576] = true,
	[204577] = true,
	[204578] = true,
	[204579] = true,
	[204721] = true,
	[204722] = true,
	[204723] = true,
	[204724] = true,
	[204725] = true,
	[204726] = true,
	-- [140192] = true, -- ХС тест
	-- [204072] = true,
	[205991] = true,
	[205342] = true,
	[205346] = true,
}
local function CreateFrameUsableItems_OnEnter(self)
	self.icon:SetVertexColor(1, 1, 1, 1)
end
local function CreateFrameUsableItems_OnLeave(self)
	local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
	self.icon:SetVertexColor(1, 1, 1, sufficiently and .1 or 1)
	GameTooltip:ClearLines()
	GameTooltip:Hide()
end
local function CreateFrameUsableItems_OnEvent(self,event)
	if event == "BAG_UPDATE" then
		local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
		self.icon:SetDesaturated(sufficiently)
		self.icon:SetAlpha(sufficiently and .1 or 1)
	elseif event == "PLAYER_REGEN_DISABLED" then
		self:SetParent(UIParent)
		self:ClearAllPoints()
		self:Hide()
	else
		self:SetParent(Main_Frame)
		self:SetPoint("TOPLEFT", Main_Frame, "TOPLEFT", -curHeight-1, self.Ypos)
		self:Show()
	end
end
local function CreateFrameUsableItems_OnMouseDown(self)
	local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
	self.icon:SetVertexColor(1, 0, 0, sufficiently and .1 or 1)
end
local function CreateFrameUsableItems_OnMouseUp(self)
	local sufficiently = GetItemCount(self.itemID, true, true, true) < self.count
	self.icon:SetVertexColor(1, 1, 1, sufficiently and .1 or 1)
end
local function CreateFrameUsableItems(itemID, count, Ypos, r, g, b)
	local Button = CreateFrame("Button", AddonTitle..GenerateUniqueID(), Main_Frame, "SecureActionButtonTemplate,BackDropTemplate")
	Button.itemID = itemID
	Button.Ypos = Ypos
	Button.count = count
	-- Button.r = r
	-- Button.g = g
	-- Button.b = b
	Button:SetSize(64, 64)
	Button:SetPoint("TOPLEFT", 0, 0)
	Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..AddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	Button:SetBackdropBorderColor(r, g, b, 0.2)
	Button:RegisterEvent("PLAYER_REGEN_DISABLED")
	Button:RegisterEvent("PLAYER_REGEN_ENABLED")
	Button:RegisterEvent("BAG_UPDATE")
	Button:HookScript("OnEvent", CreateFrameUsableItems_OnEvent)
	Button:HookScript("OnEnter", CreateFrameUsableItems_OnEnter)
	Button:HookScript("OnLeave", CreateFrameUsableItems_OnLeave)
	Button:HookScript("OnMouseDown", CreateFrameUsableItems_OnMouseDown)
	Button:HookScript("OnMouseUp", CreateFrameUsableItems_OnMouseUp)
	Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	Button:SetAttribute("type", "macro")
	Button:SetAttribute("macrotext", "/use item:"..itemID)
	local t = Button:CreateTexture(nil, "BACKGROUND")
	Button.icon = t
	t:SetTexture(select(10, GetItemInfo(itemID)))
	t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Button)
	Button:GetScript("OnEvent")(Button, "BAG_UPDATE")
	return Button
end
for k,v in ipairs(white_list) do
	print (k,v)
end
	-- ITEMID, count, Ypox, r, g, b
	--CreateFrameUsableItems(204075, 1)