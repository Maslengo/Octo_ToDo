local GlobalAddonName, E = ...
function E.func_IsAvailable(id, curType)
	if id and curType then
		if curType == "spell" and IsSpellKnown(id) then
			return true
		elseif curType == "item" and GetItemCount(id, false, false, false) > 0 then
			return true
		elseif curType == "toy" and PlayerHasToy(id) then
			return true
		else
			return false
		end
	end
end
function E.func_IsOnCD(id, curType)
	local id = id or nil
	local curType = curType or nil
	if id and curType then
		if curType == "spell" and GetSpellCooldown(id).startTime > 0 then
			return true
		elseif curType == "item" and select(2, GetItemCooldown(id)) > 0 then
			return true
		elseif curType == "toy" and select(2, GetItemCooldown(id)) > 0 then
			return true
		else
			return false
		end
	end
end
function E.func_UpdateButtonState(frame, id, curType)
	if E.func_IsAvailable(id, curType) == false then
		frame:SetBackdropBorderColor(0, 0, 0, .5)
		frame.icon:SetVertexColor(1, 1, 1, .5)
		frame.icon:SetDesaturated(true)
	else
		if E.func_IsOnCD(id, curType) == true then
			frame.icon:SetVertexColor(1, 0, 0, 1)
		else
			frame.icon:SetVertexColor(1, 1, 1, 1)
		end
	end
end
function E.func_CreateSpellButton(id, point, parent, rPoint, x, y, size, curType)
	if id and type(id) == "number" then
		local curType = curType or "spell"
		local frame = CreateFrame("BUTTON", nil, parent, "SecureActionButtonTemplate, OctoBackdropTemplate")
		frame:Hide()
		frame:SetPoint(point, parent, rPoint, x, y)
		frame:SetSize(size, size)
		local edgeAlpha = 1
		frame.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.icon:SetAllPoints()
		if curType == "item" or curType == "toy" then
			frame.icon:SetTexture(E.func_GetItemIcon(id))
		else
			frame.icon:SetTexture(E.func_GetSpellIcon(id))
		end
		frame.icon:SetTexCoord(.10, .90, .10, .90)
		frame:SetBackdrop(E.menuBackdrop)
		frame:SetBackdropColor(0, 0, 0, 0)
		frame:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
		frame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
		frame:SetAttribute("type", "macro")
		if not InCombatLockdown() then
			if curType == "item" or curType == "toy" then
				frame:SetAttribute("macrotext", "/use item:"..id)
			else
				frame:SetAttribute("macrotext", "/cast "..GetSpellName(id))
			end
		end
		if not frame.isInit then
			frame.isInit = true
			frame:HookScript("OnShow", function(self)
					self:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
					E.func_UpdateButtonState(self, id, curType)
			end)
			frame:SetScript("OnEnter", function(self)
					self:SetBackdropBorderColor(classR, classG, classB, edgeAlpha)
					E.func_UpdateButtonState(self, id, curType)
					E.func_Octo_TooltipFrame_OnEnter(frame)
					if curType == "item" or curType == "toy" then
						GameTooltip:AddDoubleLine(E.func_GetItemName(id), E.func_SecondsToClock(E.func_GetItemCooldown(id)))
					else
						GameTooltip:AddDoubleLine(E.func_GetSpellName(id), E.func_SecondsToClock(E.func_GetSpellCooldown(id)))
						GameTooltip:AddDoubleLine(E.func_GetSpellDescription(id))
					end
			end)
			frame:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
					E.func_UpdateButtonState(self, id, curType)
			end)
			frame:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, edgeAlpha)
					E.func_UpdateButtonState(self, id, curType)
			end)
			frame:SetScript("OnMouseUp", function(self)
					self:SetBackdropBorderColor(classR, classG, classB, edgeAlpha)
					E.func_UpdateButtonState(self, id, curType)
			end)
		end
	end
end
function E.func_countTable(t)
	if not t then
		return 0
	end
	local count = 0
	for _ in pairs(t) do
		count = count + 1
	end
	return count
end
local function xor16(a, b)
	local r = 0
	for i = 0, 15 do
		local bitA = a % 2
		local bitB = b % 2
		local bitR = (bitA + bitB) % 2
		r = r + bitR * 2^i
		a = math.floor(a/2)
		b = math.floor(b/2)
	end
	return r
end
local XOR_KEY = 0xABCD
function E.func_EncodeUInt16Array(arr)
	local packed = {}
	for i = 1, #arr do
		assert(arr[i] >= 0 and arr[i] <= 65535, "Value out of uint16 range")
		packed[i] = xor16(arr[i], XOR_KEY)
	end
	return packed
end
function E.func_DecodeUInt16Array(packed)
	local arr = {}
	for i = 1, #packed do
		arr[i] = xor16(packed[i], XOR_KEY)
	end
	return arr
end
function E.func_ResetOtrisovkaTables(categoryKey)
	E.OctoTables_DataOtrisovka[categoryKey].Currencies = {}
	E.OctoTables_DataOtrisovka[categoryKey].Items = {}
	E.OctoTables_DataOtrisovka[categoryKey].RaidsOrDungeons = {}
	E.OctoTables_DataOtrisovka[categoryKey].Reputations = {}
	E.OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {}
	E.OctoTables_DataOtrisovka[categoryKey].Additionally = {}
end
function E.func_GetLFGDungeonName(dID)
	for i = 1, GetNumRandomDungeons() do
		local dungeonID, name = GetLFGRandomDungeonInfo(i)
		if dungeonID == dID then
			return name
		end
	end
	return RETRIEVING_DATA
end
function E.func_GetAchievementCompletion(id)
	local name, _, _, completed, _, _, _, _, _, _, _, _, wasEarnedByMe, earnedBy = GetAchievementInfo(id)
	if completed then
		return E.DONE
	end
	local numCriteria = GetAchievementNumCriteria(id)
	if numCriteria == 0 then
		return E.COLOR_RED.."0 / 1".."|r"
	end
	if numCriteria == 1 then
		local _, _, completedCrit, quantity, reqQuantity = GetAchievementCriteriaInfo(id, 1, false)
		return quantity == 0 and (E.COLOR_RED..quantity.." / "..reqQuantity.."|r") or (quantity.." / "..reqQuantity)
	else
		local count = 0
		for i = 1, numCriteria do
			local _, _, completedCrit = GetAchievementCriteriaInfo(id, i, false)
			if completedCrit then
				count = count + 1
			end
		end
		return count == 0 and (E.COLOR_RED..count.." / "..numCriteria.."|r") or (count.." / "..numCriteria)
	end
end
function E.func_GetAchievementIcon(id)
	return select(10, GetAchievementInfo(id))
end
function E.func_GetMountIDFromItemID(itemID)
	return GetMountFromItem(itemID)
end
function E.ToggleVault()
	if WeeklyRewardsFrame and ToggleFrame then
		ToggleFrame(WeeklyRewardsFrame)
	else
		WeeklyRewards_ShowUI()
	end
end
function E.func_ColoredTime()
end