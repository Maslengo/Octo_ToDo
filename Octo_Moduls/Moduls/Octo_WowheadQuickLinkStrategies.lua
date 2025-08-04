local GlobalAddonName, ns = ...
E = _G.OctoEngine




local utf8lower = string.utf8lower
-- Octo_WowheadQuickLinkStrategies
local strategies = {
	wowhead = {},
	wowheadAzEs = {},
	wowheadTradingPostActivity = {},
	armory = {}
}
local tooltipStates = {}
local regions = {
	[1] = "us",
	[2] = "kr",
	[3] = "eu",
	[4] = "tw",
	[5] = "cn"
}
local output_preffix = ""

if E:func_IsRetail() == true then
	E.baseWowheadUrl = "wowhead.com/%s%s=%s"
end
if E:func_IsClassic() == true then
	E.baseWowheadUrl = "wowhead.com/classic/%s=%s%s"
end
if E:func_IsCataclysm() == true then
	E.baseWowheadUrl = "wowhead.com/cata/%s=%s%s"
end
if E:func_IsPTR() then
	E.baseWowheadUrl = E.interfaceVersion >= E.interfaceVersion_PTR and "wowhead.com/ptr-2/%s%s=%s" or "wowhead.com/ptr/%s%s=%s"
end

local function check_WTF()
	if Octo_ToDo_DB_Vars.Config_prefix == 1 then output_preffix = "ru/" -- Русский"
	elseif Octo_ToDo_DB_Vars.Config_prefix == 2 then output_preffix = "de/" -- Deutsch"
	elseif Octo_ToDo_DB_Vars.Config_prefix == 3 then output_preffix = "" -- English"
	elseif Octo_ToDo_DB_Vars.Config_prefix == 4 then output_preffix = "es/" -- Español"
	elseif Octo_ToDo_DB_Vars.Config_prefix == 5 then output_preffix = "fr/" -- Français"
	elseif Octo_ToDo_DB_Vars.Config_prefix == 6 then output_preffix = "it/" -- Italiano"
	elseif Octo_ToDo_DB_Vars.Config_prefix == 7 then output_preffix = "pt/" -- Português Brasileiro
	elseif Octo_ToDo_DB_Vars.Config_prefix == 8 then output_preffix = "ko/" -- 한국어"
	elseif Octo_ToDo_DB_Vars.Config_prefix == 9 then output_preffix = "cn/" -- 简体中文"
	end
end
function E.strategies.GetWowheadUrl(dataSources)
	check_WTF()
	for _, strategy in next, (strategies.wowhead) do
		local id, type = strategy(dataSources)
		if id and type then
			local typeStr
			if type == "npc" then
				typeStr = type:upper()
			else
				typeStr = type:sub(1, 1):upper() .. type:sub(2)
			end
			return "Wowhead " .. typeStr,
			string.format(E.baseWowheadUrl, output_preffix, type, id)
		end
	end
end
function E.strategies.GetWowheadAzEsUrl(dataSources)
	check_WTF()
	for _, strategy in next, (strategies.wowheadAzEs) do
		local id = strategy(dataSources)
		if id then
			return "Wowhead Azerite Essence",
			string.format(E.baseWowheadAzEsUrl, output_preffix, id)
		end
	end
end
function E.strategies.GetWowheadTradingPostActivityUrl(dataSources)
	check_WTF()
	for _, strategy in next, (strategies.wowheadTradingPostActivity) do
		local id = strategy(dataSources)
		if id then
			return "Wowhead Trading Post Activity",
			string.format(E.baseWowheadTradingPostActivityUrl, output_preffix, id)
		end
	end
end
function E.strategies.GetArmoryUrl(dataSources)
	if E:func_IsRetail() then
		for _, strategy in next, (strategies.armory) do
			local _, locale, realm, name = strategy(dataSources)
			if locale and realm and name then
				local LRI_name = select(2, LibStub("LibRealmInfo"):GetRealmInfo(realm))
				local LRI_englishName = select(10, LibStub("LibRealmInfo"):GetRealmInfo(realm))
				if realm == LRI_name then
					realm = LRI_englishName:gsub(" ", "-")
				end
				return "Armory", string.format(E.baseArmoryUrl, locale:utf8lower(), realm, name)
			end
		end
	end
end
function E.altStrategies.GetRaiderIoUrl(dataSources)
	if E:func_IsRetail() then
		for _, strategy in next, (strategies.armory) do
			local region, _, realm, name = strategy(dataSources)
			if region and realm and name then
				local LRI_name = select(2, LibStub("LibRealmInfo"):GetRealmInfo(realm))
				local LRI_englishName = select(10, LibStub("LibRealmInfo"):GetRealmInfo(realm))
				if realm == LRI_name then
					realm = LRI_englishName:gsub(" ", "-")
				end
				return "Raider.IO", string.format(E.baseRaiderIoUrl, region, realm, name)
			end
		end
	end
end
local function GetFromNameAndRealm(name, realm)
	if not realm or realm == "" then
		realm = GetRealmName()
	end
	-- if realm:find("'") then
	-- realm = realm:gsub("'", ""):lower()
	-- end
	-- realm = realm:gsub(" ", "-")
	-- local index = realm:find("%a%u")
	-- if index then
	-- realm = realm:sub(1, index) .. "-" .. realm:sub(index + 1)
	-- end
	local region = GetCurrentRegion()
	local locale = E.curLocaleLang
	local isEu = region == 3
	if isEu and locale == "enUS" then
		locale = "enGB"
	end
	locale = locale:sub(1, 2) .. "-" .. locale:sub(3)
	return regions[region], locale, GetRealmName(), name
end
function strategies.armory.GetArmoryFromTooltip(data)
	if not data.tooltip then
		return
	end
	local name, unit = data.tooltip:GetUnit()
	if not (unit and UnitIsPlayer(unit)) then
		return
	end
	return GetFromNameAndRealm(UnitFullName(unit))
end
function strategies.armory.GetArmoryFromLfgLeader(data)
	if not data.focus.resultID then
		return
	end
	local leader = C_LFGList.GetSearchResultInfo(data.focus.resultID).leaderName
	return GetFromNameAndRealm(strsplit("-", tostring(leader)))
end
function strategies.armory.GetArmoryFromLfgApplicant(data)
	if not data.focus.memberIdx or not data.focus:GetParent() or not data.focus:GetParent().applicantID then
		return
	end
	local applicant = select(1, C_LFGList.GetApplicantMemberInfo(data.focus:GetParent().applicantID, data.focus.memberIdx))
	return GetFromNameAndRealm(strsplit("-", applicant))
end
local function GetFromLink(link)
	if not link then
		return
	end
	local _, _, type, id = link:find("%|?H?(%a+):(%d+):")
	if type == "azessence" then
		return id
	end
	if type == "questie" then
		return id, "quest"
	end
	return id, type
end
function strategies.wowhead.GetHyperlinkFromTooltip()
	for _, tooltip in next, (tooltipStates) do
		if tooltip.hyperlink then
			return GetFromLink(tooltip.hyperlink)
		end
	end
end
function strategies.wowhead.GetAuraFromTooltip()
	for _, tooltip in next, (tooltipStates) do
		if tooltip.aura then
			return tooltip.aura, "spell"
		end
	end
end
function strategies.wowhead.GetAuraFromInstanceID(data)
	if not data.focus.auraInstanceID or not data.focus.unit then
		return
	end
	local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(data.focus.unit, data.focus.auraInstanceID)
	if not aura then
		return
	end
	return aura.spellId, "spell"
end
function strategies.wowhead.GetItemFromTooltip(data)
	if not data.tooltip then
		return
	end
	local _, link = data.tooltip:GetItem()
	return GetFromLink(link)
end
function strategies.wowhead.GetSpellFromTooltip(data)
	if not data.tooltip then
		return
	end
	return select(2, data.tooltip:GetSpell()), "spell"
end
function strategies.wowhead.GetAchievementFromFocus(data)
	if not data.focus.id or not (data.focus.DateCompleted or data.focus.dateCompleted) then
		return
	end
	return data.focus.id, "achievement"
end
function strategies.wowhead.GetKrowisAchievementFromFocus(data)
	if not data.focus.Achievement or not data.focus.Achievement.Id then
		return
	end
	return data.focus.Achievement.Id, "achievement"
end
function strategies.wowhead.GetQuestFromFocus(data)
	if not data.focus.questID then
		return
	end
	return data.focus.questID, "quest"
end
function strategies.wowhead.GetTrackerFromFocus(data)

	if not data.focus.GetParent then return end


	local parent = data.focus:GetParent()
	if not parent or not parent.parentModule then
		return
	end
	local name = parent.parentModule:GetName()
	if parent.poiQuestID then
		return parent.poiQuestID, "quest"
	end
	if name == "BonusObjectiveTracker" then
		return parent.id, "quest"
	end
	if name == "MonthlyActivitiesObjectiveTracker" then
		return
	end
	if name == "ProfessionsRecipeTracker" then
		return parent.id, "spell"
	end
	local focusName = data.focus:GetName()
	if name == "AchievementObjectiveTracker" or
	(data.focus.module and data.focus.module.friendlyName == "ACHIEVEMENT_TRACKER_MODULE") then
		return parent.id, "achievement"
	end
end
function strategies.wowhead.GetClassicQuestLog(data)
	if not E:func_IsRetail() or not data.focus.info or not data.focus.info.questID then
		return
	end
	return data.focus.info.questID, "quest"
end
function strategies.wowhead.GetNpcFromTooltip(data)
	if not data.tooltip then
		return
	end
	local _, unit = data.tooltip:GetUnit()
	if not unit then
		return
	end
	return select(6, strsplit("-", tostring(UnitGUID(unit)))), "npc"
end
function strategies.wowhead.GetMountFromFocus(data)
	if not data.focus.spellID then
		return
	end
	return data.focus.spellID, "spell"
end
function strategies.wowhead.GetLearntMountFromFocus(data)
	if not data.focus.mountID then
		return
	end
	return select(2, C_MountJournal.GetMountInfoByID(data.focus.mountID)), "spell"
end
function strategies.wowhead.GetBattlePetFromFocus(data)
	if not data.focus.petID and (not data.focus.GetParent or not data.focus:GetParent().petID) then return end
	local petId = data.focus.petID or data.focus:GetParent().petID
	local id
	if type(petId) == "string" then
		id = select(11, C_PetJournal.GetPetInfoByPetID(petId))
	else
		id = select(4, C_PetJournal.GetPetInfoBySpeciesID(petId))
	end
	return id, "npc"
end
function strategies.wowhead.GetBattlePetFromFloatingTooltip(data)
	if not data.focus.speciesID then
		return
	end
	return select(4, C_PetJournal.GetPetInfoBySpeciesID(data.focus.speciesID)), "npc"
end
function strategies.wowhead.GetBattlePetFromAuctionHouse(data)
	if not data.focus.itemKey and (not data.focus.GetRowData or not data.focus:GetRowData().itemKey) then
		return
	end
	local itemKey = data.focus.itemKey or data.focus:GetRowData().itemKey
	return select(4, C_PetJournal.GetPetInfoBySpeciesID(itemKey.battlePetSpeciesID)), "npc"
end
function strategies.wowhead.GetToyCollectionItemFromFocus(data)
	if not data.focus.itemID then
		return
	end
	return data.focus.itemID, "item"
end
function strategies.wowhead.GetTransmogCollectionItemFromFocus(data)
	if not data.focus.visualInfo or not WardrobeCollectionFrame.tooltipSourceIndex then
		return
	end
	local selectedAppearance = data.focus.visualInfo.visualID
	local selectedStyle = WardrobeCollectionFrame.tooltipSourceIndex
	return CollectionWardrobeUtil.GetSortedAppearanceSources(selectedAppearance)[selectedStyle].itemID, "item"
end
function strategies.wowhead.GetTransmogSetItemFromFocus(data)
	if not data.focus.sourceID or not WardrobeCollectionFrame.tooltipSourceIndex then
		return
	end
	local appearanceID = C_TransmogCollection.GetAppearanceInfoBySource(data.focus.sourceID).appearanceID
	local selectedStyle = WardrobeCollectionFrame.tooltipSourceIndex
	local appearanceSources = C_TransmogCollection.GetAppearanceSources(appearanceID)
	CollectionWardrobeUtil.SortSources(appearanceSources, appearanceID, data.focus.sourceID)
	return appearanceSources[selectedStyle].itemID, "item"
end
function strategies.wowhead.GetRecipeFromFocus(data)
	if not data.focus.tradeSkillInfo then
		return
	end
	return data.focus.tradeSkillInfo.recipeID, "spell"
end
function strategies.wowhead.GetRetailFactionFromFocus(data)
	if not E:func_IsRetail() or not data.focus or not data.focus.factionID then
		return
	end
	return data.focus.factionID, "faction"
end
function strategies.wowhead.GetClassicCataFactionFromFocus(data)
	if E:func_IsRetail() or not data.focus.index or not data.focus.standingText then
		return
	end
	return C_Reputation.GetFactionDataByID(data.focus.index).name, "faction"
end
function strategies.wowhead.GetRetailCurrencyInTabFromFocus(data)
	if not E:func_IsRetail() or not data.focus.elementData or not data.focus.elementData.currencyID then
		return
	end
	return data.focus.elementData.currencyID, "currency"
end
function strategies.wowhead.GetClassicCataCurrencyInTabFromFocus(data)
	if E:func_IsRetail() or (data.focus.isUnused == nil and (not data.focus:GetParent() or data.focus:GetParent().isUnused == nil)) then
		return
	end
	local index = data.focus.index or data.focus:GetParent().index
	local link = C_CurrencyInfo.GetCurrencyListLink(index)
	return GetFromLink(link)
end
function strategies.wowhead.GetCurrencyInVendorFromFocus(data)
	if not data.focus.itemLink then
		return
	end
	return GetFromLink(data.focus.itemLink)
end
function strategies.wowhead.GetCurrencyInVendorBottomFromFocus(data)
	if not data.focus.currencyID then
		return
	end
	return data.focus.currencyID, "currency"
end
function strategies.wowhead.GetConduitFromTree(data)
	if not data.focus.GetConduitID or data.focus:GetConduitID() == 0 then
		return
	end
	local conduitID = data.focus:GetConduitID()
	local conduitItemID = C_Soulbinds.GetConduitCollectionData(conduitID).conduitItemID
	return conduitItemID, "item"
end
function strategies.wowhead.GetConduitFromList(data)
	if not data.focus.conduitData then
		return
	end
	return data.focus.conduitData.conduitItemID, "item"
end
function strategies.wowheadAzEs.GetAzEsFromNeckList(data)
	if not data.focus.essenceID then
		return
	end
	return data.focus.essenceID
end
function strategies.wowheadAzEs.GetAzEsFromNeckSlot(data)
	if not data.focus.milestoneID then
		return
	end
	return C_AzeriteEssence.GetMilestoneEssence(data.focus.milestoneID)
end
function strategies.wowheadAzEs.GetAzEsHyperlinkFromTooltip()
	for _, tooltip in next, (tooltipStates) do
		if tooltip.hyperlink then
			local id, type = GetFromLink(tooltip.hyperlink)
			if id and not type then
				return id
			end
		end
	end
end
function strategies.wowheadTradingPostActivity.GetTradingPostActivity(data)
	if not E:func_IsRetail() or not (data.focus.activityName and data.focus.requirementsList) then
		return
	end
	return data.focus.id
end
function strategies.wowheadTradingPostActivity.GetTradingPostActivityFromTracker(data)
	local parent = data.focus:GetParent()
	if (parent and parent.parentModule and parent.parentModule:GetName() == "MonthlyActivitiesObjectiveTracker" and parent.id) then
		return parent.id
	end
end
function CheckFrameName2(name, data)
	if not name or not data.focus or not data.focus:GetName() then
		return false
	end
	return string.find(data.focus:GetName(), name)
end
local function HookTooltip(tooltip)
	tooltipStates[tooltip] = {}
	hooksecurefunc(tooltip, "SetHyperlink", function(tooltip, hyperlink)
			tooltipStates[tooltip].hyperlink = hyperlink
		end
	)
	if E:func_IsRetail() then
		hooksecurefunc(tooltip, "SetRecipeReagentItem", function(tooltip, recipeId, reagentIndex)
				if C_TradeSkillUI.GetRecipeReagentItemLink then
					tooltipStates[tooltip].hyperlink = C_TradeSkillUI.GetRecipeReagentItemLink(recipeId, reagentIndex)
				end
			end
		)
	end
	hooksecurefunc(tooltip, "SetUnitAura", function(tooltip, unit, index, filter)
			if E:func_IsRetail() then
				local aura = C_UnitAuras.GetAuraDataByIndex(unit, index, filter)
				if aura then
					tooltipStates[tooltip].aura = aura.spellId
				end
			else
				tooltipStates[tooltip].aura = select(10, UnitAura(unit, index, filter))
			end
		end
	)
	tooltip:HookScript("OnTooltipCleared", function(tooltip)
			tooltipStates[tooltip] = {}
		end
	)
end
local eventHookFrame = CreateFrame("Frame")
eventHookFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventHookFrame:SetScript("OnEvent", function(self, event, arg1)
		if event == "PLAYER_ENTERING_WORLD" then
			HookTooltip(GameTooltip)
			HookTooltip(ItemRefTooltip)
		end
	end
)