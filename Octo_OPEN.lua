local AddonName, engine = ...
local AddonTitle = GetAddOnMetadata(AddonName, "Title")
local Version = GetAddOnMetadata(AddonName, "Version")
local Enable_Module = false

local scale = WorldFrame:GetWidth() / GetPhysicalScreenSize() / UIParent:GetScale()
local bgCr, bgCg, bgCb, bgCa = 14/255, 14/255, 14/255, 0.8 --0.1,0.1,0.1,1

local OPEN_Frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
local UnitLevel = UnitLevel("PLAYER")
local maxlevel = 70

function Octo_MAIL_DragonflyOnLoad()
	local Octo_OPEN_Frame = CreateFrame("Frame", nil)


	Octo_OPEN_Frame:RegisterEvent("PLAYER_LOGIN")
	-- Octo_OPEN_Frame:RegisterEvent("BAG_UPDATE")
	Octo_OPEN_Frame:RegisterEvent("PLAYER_STARTED_MOVING")
	Octo_OPEN_Frame:RegisterEvent("CHAT_MSG_LOOT")
	Octo_OPEN_Frame:RegisterEvent("QUEST_COMPLETE")
	Octo_OPEN_Frame:RegisterEvent("QUEST_FINISHED")
	Octo_OPEN_Frame:SetScript("OnEvent", Octo_MAIL_DragonflyOnEvent)
end

local white_list = {
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

local white_list70 = {
	[205423] = true,
}

local prof_white_list = {
	[192130] = true,
	[192131] = true,
	[192132] = true,
	[193891] = true,
	[193897] = true,
	[193898] = true,
	[193899] = true,
	[193900] = true,
	[193901] = true,
	[193902] = true,
	[193903] = true,
	[193904] = true,
	[193905] = true,
	[193907] = true,
	[193909] = true,
	[193910] = true,
	[193913] = true,
	[194039] = true,
	[194040] = true,
	[194041] = true,
	[194054] = true,
	[194055] = true,
	[194061] = true,
	[194062] = true,
	[194063] = true,
	[194064] = true,
	[194066] = true,
	[194067] = true,
	[194068] = true,
	[194076] = true,
	[194077] = true,
	[194078] = true,
	[194079] = true,
	[194080] = true,
	[194081] = true,
	[194337] = true,
	[194697] = true,
	[194698] = true,
	[194699] = true,
	[194700] = true,
	[194702] = true,
	[194703] = true,
	[194704] = true,
	[194708] = true,
	[198454] = true,
	[198510] = true,
	[198599] = true,
	[198606] = true,
	[198607] = true,
	[198608] = true,
	[198609] = true,
	[198610] = true,
	[198611] = true,
	[198612] = true,
	[198613] = true,
	[198653] = true,
	[198656] = true,
	[198658] = true,
	[198659] = true,
	[198660] = true,
	[198662] = true,
	[198663] = true,
	[198664] = true,
	[198667] = true,
	[198669] = true,
	[198670] = true,
	[198680] = true,
	[198682] = true,
	[198683] = true,
	[198684] = true,
	[198685] = true,
	[198686] = true,
	[198687] = true,
	[198690] = true,
	[198692] = true,
	[198693] = true,
	[198696] = true,
	[198697] = true,
	[198699] = true,
	[198702] = true,
	[198703] = true,
	[198704] = true,
	[198710] = true,
	[198711] = true,
	[198712] = true,
	[198789] = true,
	[198837] = true,
	[198841] = true,
	[198963] = true,
	[198964] = true,
	[198965] = true,
	[198966] = true,
	[198967] = true,
	[198968] = true,
	[198969] = true,
	[198970] = true,
	[198971] = true,
	[198972] = true,
	[198973] = true,
	[198974] = true,
	[198975] = true,
	[198976] = true,
	[198977] = true,
	[198978] = true,
	[199115] = true,
	[199122] = true,
	[199128] = true,
	[200677] = true,
	[200678] = true,
	[200972] = true,
	[200973] = true,
	[200974] = true,
	[200975] = true,
	[200976] = true,
	[200977] = true,
	[200978] = true,
	[200979] = true,
	[200980] = true,
	[200981] = true,
	[200982] = true,
	[201003] = true,
	[201004] = true,
	[201005] = true,
	[201006] = true,
	[201007] = true,
	[201008] = true,
	[201009] = true,
	[201010] = true,
	[201011] = true,
	[201012] = true,
	[201013] = true,
	[201014] = true,
	[201015] = true,
	[201016] = true,
	[201017] = true,
	[201018] = true,
	[201019] = true,
	[201020] = true,
	[201023] = true,
	[201268] = true,
	[201269] = true,
	[201270] = true,
	[201271] = true,
	[201272] = true,
	[201273] = true,
	[201274] = true,
	[201275] = true,
	[201276] = true,
	[201277] = true,
	[201278] = true,
	[201279] = true,
	[201280] = true,
	[201281] = true,
	[201282] = true,
	[201283] = true,
	[201284] = true,
	[201285] = true,
	[201286] = true,
	[201287] = true,
	[201288] = true,
	[201289] = true,
	[201300] = true,
	[201301] = true,
	[201700] = true,
	[201705] = true,
	[201706] = true,
	[201708] = true,
	[201709] = true,
	[201710] = true,
	[201711] = true,
	[201712] = true,
	[201713] = true,
	[201714] = true,
	[201715] = true,
	[201716] = true,
	[201717] = true,
	[201718] = true,
	[202011] = true,
	[202014] = true,
	[202016] = true,
	[204222] = true,
	[204224] = true,
	[204225] = true,
	[204226] = true,
	[204227] = true,
	[204228] = true,
	[204229] = true,
	[204230] = true,
	[204231] = true,
	[204232] = true,
	[204233] = true,
	[204987] = true,
	[205426] = true,
	[205433] = true,
	[205437] = true,
	[205444] = true,


	[205954] = true, --Червоточина
	[205213] = true,
	[205211] = true,
	[205212] = true,
	[206031] = true,
	[206034] = true,
	[206035] = true,
	[205216] = true,
	[205214] = true,
	[205219] = true,
	[206030] = true,
	[206019] = true,
	[206025] = true,
	[205001] = true,
	[204990] = true,
	[204999] = true,
	[204471] = true,
	[204475] = true,
	[204855] = true,
	[204470] = true,
	[204469] = true,
	[204853] = true,
	[204471] = true,
	[204850] = true,
	[205988] = true,
	[205987] = true,
	[205986] = true,
	[204986] = true,
	[204987] = true,
	[204988] = true,
	--ПРОФ ХЗ
	[204480] = true,
	--[204076] = true, --DrakesShadowflameCrestFragment RED
	--[204075] = true, --WhelplingsShadowflameCrestFragment BLUE
}

if UnitLevel == 70 then
	MergeTable(white_list, white_list70)
	MergeTable(white_list, prof_white_list)
end

local icon = 0
-- если пост клик и нет айтема, то хайдить (ну или при клике и если нет итема)
function TESTFUNC()
	--local countRED = GetItemCount(204076,true, true, true) --RED
	--local countBLUE = GetItemCount(204075,true, true, true) --BLUE
	for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		for slot=1, C_Container.GetContainerNumSlots(bag) do
			local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
			if containerInfo then
				local itemID = containerInfo.itemID
				local iconFileID = containerInfo.iconFileID
				local itemLink = C_Container.GetContainerItemLink(bag, slot)
				local isLocked = containerInfo.isLocked -- Добавить
				-----------------------
				if white_list[itemID] --[[and (countRED >= 15 or countBLUE >= 15)]] and not isLocked then
					icon = iconFileID
					MASLENGO_OPEN()
					OPEN_Frame:Show()
					break
				end
			end
		end
	end
end

function FUNC_Nazvanie(self, _, down)
	if InCombatLockdown() or down ~= GetCVarBool("ActionButtonUseKeyDown") then return end
	for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		for slot=1, C_Container.GetContainerNumSlots(bag) do
			local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
			if containerInfo then
				local itemID = containerInfo.itemID
				local iconFileID = containerInfo.iconFileID
				local isLocked = containerInfo.isLocked -- Добавить
				--local hyperlink = containerInfo.hyperlink
				local itemLink = C_Container.GetContainerItemLink(bag, slot)
				-----------------------
				if not white_list[itemID] and OPEN_Frame:IsShown() then
					OPEN_Frame:Hide()
				end
				if white_list[itemID] and not isLocked then
					print (iconFileID)
					self:SetAttribute("macrotext", "/use item:"..itemID)
					return
				end
			end
		end
	end
end

function MASLENGO_OPEN()
	OPEN_Frame:SetSize(64*scale, 64*scale)
	--OPEN_Frame:SetClampedToScreen(false)
	OPEN_Frame:SetFrameStrata("DIALOG")
	OPEN_Frame:EnableMouse(true)
	-- OPEN_Frame:SetMovable(true)
	-- OPEN_Frame:RegisterForDrag("RightButton")
	-- OPEN_Frame:SetScript("OnDragStart", OPEN_Frame.StartMoving)
	-- OPEN_Frame:SetScript("OnDragStop", function() OPEN_Frame:StopMovingOrSizing() end)
	OPEN_Frame:SetPoint("CENTER", -524, 524)
	OPEN_Frame:SetBackdrop({
			bgFile = "Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\Octo_ToDo_Dragonfly\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	OPEN_Frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	OPEN_Frame:SetBackdropBorderColor(0, 0, 0, 1)
	OPEN_Frame.Button:SetAllPoints()
	OPEN_Frame.Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	OPEN_Frame.Button:SetAttribute("unit", "player")
	OPEN_Frame.Button:SetAttribute("type", "macro")

	OPEN_Frame.Button:SetScript("PreClick", FUNC_Nazvanie)

	local t = OPEN_Frame.Button:CreateTexture(nil,"BACKGROUND")
	OPEN_Frame.Button.icon = t
	--t:SetTexture("Interface\\AddOns\\Octo_ToDo_Dragonfly\\Media\\ui_sigil_nightfae_OLD.tga")
	t:SetTexture(icon)
	t:SetVertexColor(1,1,1,1)
	t:SetAllPoints(OPEN_Frame.Button)
end



-- function MJMacroMixin:preClick(button, down)
--     self.mounts.sFlags.forceModifier = self.forceModifier
--     if InCombatLockdown() or down ~= GetCVarBool("ActionButtonUseKeyDown") then return end
--     self:SetAttribute("macrotext", macroFrame:getMacro())
-- end






function Octo_MAIL_DragonflyOnEvent(self, event, ...)
	if Enable_Module == true then
		if event == "PLAYER_LOGIN" then
			OPEN_Frame.Button = CreateFrame("BUTTON", nil, OPEN_Frame, "SecureActionButtonTemplate")
			self:RegisterEvent("BAG_UPDATE")
			TESTFUNC()
		elseif (event == "BAG_UPDATE" or event == "PLAYER_STARTED_MOVING" or event == "QUEST_COMPLETE" or event == "QUEST_FINISHED") and not InCombatLockdown() then
			TESTFUNC()
			-- if not OPEN_Frame:IsShown() then
			-- 	OPEN_Frame:Show()
			-- end
		elseif event == "CHAT_MSG_LOOT" and not InCombatLockdown()  then
			OPEN_Frame:Hide()
		end
	end
end
--комбат иввенты мана регент энейбел/дизейбл
Octo_MAIL_DragonflyOnLoad()