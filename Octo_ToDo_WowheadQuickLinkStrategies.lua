local GlobalAddonName, E = ...
local strategies = {
	wowhead = {},
	wowheadAzEs = {},
	wowheadTradingPostActivity = {},
	armory = {}
}
local tooltipStates = {}
local output_preffix = ""
local function check_WTF()
	if Octo_ToDo_DB_Vars.config.prefix == 1 then output_preffix = "ru." -- Русский"
	elseif Octo_ToDo_DB_Vars.config.prefix == 2 then output_preffix = "de." -- Deutsch"
	elseif Octo_ToDo_DB_Vars.config.prefix == 3 then output_preffix = "" -- English"
	elseif Octo_ToDo_DB_Vars.config.prefix == 4 then output_preffix = "es." -- Español"
	elseif Octo_ToDo_DB_Vars.config.prefix == 5 then output_preffix = "fr." -- Français"
	elseif Octo_ToDo_DB_Vars.config.prefix == 6 then output_preffix = "it." -- Italiano"
	elseif Octo_ToDo_DB_Vars.config.prefix == 7 then output_preffix = "pt." -- Português Brasileiro
	elseif Octo_ToDo_DB_Vars.config.prefix == 8 then output_preffix = "ko." -- 한국어"
	elseif Octo_ToDo_DB_Vars.config.prefix == 9 then output_preffix = "cn." -- 简体中文"
	end
end
function E.Octo_Globals.strategies.GetWowheadUrl(dataSources)
	check_WTF()
	for _, strategy in pairs(strategies.wowhead) do
		local id, type = strategy(dataSources)
		if id and type then
			local typeStr
			if type == "npc" then
				typeStr = type:upper()
			else
				typeStr = type:sub(1, 1):upper() .. type:sub(2)
			end
			return "Wowhead " .. typeStr,
			string.format(E.Octo_Globals.baseWowheadUrl, output_preffix, type, id)
		end
	end
end
function E.Octo_Globals.strategies.GetWowheadAzEsUrl(dataSources)
	check_WTF()
	for _, strategy in pairs(strategies.wowheadAzEs) do
		local id = strategy(dataSources)
		if id then
			return "Wowhead Azerite Essence",
			string.format(E.Octo_Globals.baseWowheadAzEsUrl, output_preffix, id)
		end
	end
end
function E.Octo_Globals.strategies.GetWowheadTradingPostActivityUrl(dataSources)
	check_WTF()
	for _, strategy in pairs(strategies.wowheadTradingPostActivity) do
		local id = strategy(dataSources)
		if id then
			return "Wowhead Trading Post Activity",
			string.format(E.Octo_Globals.baseWowheadTradingPostActivityUrl, output_preffix, id)
		end
	end
end
function E.Octo_Globals.strategies.GetArmoryUrl(dataSources)
	for _, strategy in pairs(strategies.armory) do
		local _, locale, realm, name = strategy(dataSources)
		if locale and realm and name then
			-- if realm == "СвежевательДуш" then realm = "Soulflayer"
			-- elseif realm == "Свежеватель-Душ" then realm = "Soulflayer"
			-- elseif realm == "СвежевательДуш" then realm = "Soulflayer"
			-- elseif realm == "Ревущий-фьорд" then realm = "howling-fjord"
			-- elseif realm == "Гордунни" then realm = "Gordunni"
			-- elseif realm == "ВечнаяПесня" then realm = "Eversong"
			-- elseif realm == "Вечная-Песня" then realm = "Eversong"
			-- elseif realm == "Ясеневыйлес" then realm = "ashenvale"
			-- elseif realm == "Подземье" then realm = "deepholm"
			-- elseif realm == "Термоштепсель" then realm = "thermaplugg"
			-- end
			if realm == "Гордунни" then realm = "Gordunni"
			elseif realm == "Король-лич" then realm = "Lich-King"
			elseif realm == "СвежевательДуш" then realm = "Soulflayer"
			elseif realm == "СтражСмерти" then realm = "Deathguard"
			elseif realm == "Подземье" then realm = "Deepholm"
			elseif realm == "Седогрив" then realm = "Greymane"
			elseif realm == "Галакронд" then realm = "Galakrond"
			elseif realm == "Ревущий-фьорд" then realm = "Howling-Fjord"
			elseif realm == "Разувий" then realm = "Razuvious"
			elseif realm == "ТкачСмерти" then realm = "Deathweaver"
			elseif realm == "Дракономор" then realm = "Fordragon"
			elseif realm == "Борейскаятундра" then realm = "Borean-Tundra"
			elseif realm == "Азурегос" then realm = "Azuregos"
			elseif realm == "Ясеневыйлес" then realm = "Ashenvale"
			elseif realm == "ПиратскаяБухта" then realm = "Booty-Bay"
			elseif realm == "ВечнаяПесня" then realm = "Eversong"
			elseif realm == "Термоштепсель" then realm = "Thermaplugg"
			elseif realm == "Гром" then realm = "Grom"
			elseif realm == "Голдринн" then realm = "Goldrinn"
			elseif realm == "ЧерныйШрам" then realm = "Blackscar"
			elseif realm == "Хроми" then realm = "Chromie"
			elseif realm == "Пламегор" then realm = "Flamegor"
			elseif realm == "Змейталак" then realm = "Wyrmthalak"
			elseif realm == "Рок-Делар" then realm = "Rhok'delar"
			elseif realm == "ВестникРока" then realm = "Harbinger-of-Doom"
			end
			return "blizzard armory",
			string.format(E.Octo_Globals.baseArmoryUrl, locale, realm, name)
		end
	end
end
function E.Octo_Globals.altStrategies.GetRaiderIoUrl(dataSources)
	for _, strategy in pairs(strategies.armory) do
		local region, _, realm, name = strategy(dataSources)
		if region and realm and name then
			-- if realm == "СвежевательДуш" then realm = "Soulflayer"
			-- elseif realm == "Ревущий-фьорд" then realm = "howling-fjord"
			-- elseif realm == "Гордунни" then realm = "Gordunni"
			-- end
			if realm == "Гордунни" then realm = "Gordunni"
			elseif realm == "Король-лич" then realm = "Lich-King"
			elseif realm == "СвежевательДуш" then realm = "Soulflayer"
			elseif realm == "СтражСмерти" then realm = "Deathguard"
			elseif realm == "Подземье" then realm = "Deepholm"
			elseif realm == "Седогрив" then realm = "Greymane"
			elseif realm == "Галакронд" then realm = "Galakrond"
			elseif realm == "Ревущий-фьорд" then realm = "Howling-Fjord"
			elseif realm == "Разувий" then realm = "Razuvious"
			elseif realm == "ТкачСмерти" then realm = "Deathweaver"
			elseif realm == "Дракономор" then realm = "Fordragon"
			elseif realm == "Борейскаятундра" then realm = "Borean-Tundra"
			elseif realm == "Азурегос" then realm = "Azuregos"
			elseif realm == "Ясеневыйлес" then realm = "Ashenvale"
			elseif realm == "ПиратскаяБухта" then realm = "Booty-Bay"
			elseif realm == "ВечнаяПесня" then realm = "Eversong"
			elseif realm == "Термоштепсель" then realm = "Thermaplugg"
			elseif realm == "Гром" then realm = "Grom"
			elseif realm == "Голдринн" then realm = "Goldrinn"
			elseif realm == "ЧерныйШрам" then realm = "Blackscar"
			elseif realm == "Хроми" then realm = "Chromie"
			elseif realm == "Пламегор" then realm = "Flamegor"
			elseif realm == "Змейталак" then realm = "Wyrmthalak"
			elseif realm == "Рок-Делар" then realm = "Rhok'delar"
			elseif realm == "ВестникРока" then realm = "Harbinger-of-Doom"
			end
			return "raider.io",
			string.format(E.Octo_Globals.baseRaiderIoUrl, region, realm, name)
		end
	end
end
local function GetFromNameAndRealm(name, realm)
	if not realm or realm == '' then
		realm = GetRealmName()
	end
	if realm:find("'") then
		realm = realm:gsub("'", ""):lower()
	end
	realm = realm:gsub(" ", "-")
	local index = realm:find("%a%u")
	if index then
		realm = realm:sub(1, index) .. "-" .. realm:sub(index + 1)
	end
	local region = GetCurrentRegion()
	local locale = GetLocale()
	local isEu = region == 3
	if isEu and locale == "enUS" then
		locale = "enGB"
	end
	locale = locale:sub(1, 2) .. "-" .. locale:sub(3)
	return E.Octo_Globals.regions[region], locale, realm, name
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
	return GetFromNameAndRealm(strsplit("-", leader))
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
	return id, type
end
function strategies.wowhead.GetHyperlinkFromTooltip()
	for _, tooltip in pairs(tooltipStates) do
		if tooltip.hyperlink then
			return GetFromLink(tooltip.hyperlink)
		end
	end
end
function strategies.wowhead.GetAuraFromTooltip()
	for _, tooltip in pairs(tooltipStates) do
		if tooltip.aura then
			return tooltip.aura, "spell"
		end
	end
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
function strategies.wowhead.GetMountOrToyFromTooltip(data)
	if not data.tooltip then
		return
	end
	tooltipData = data.tooltip:GetTooltipData()
	if not tooltipData then
		return
	end
	if tooltipData.type == Enum.TooltipDataType.Mount and tooltipData.id then
		return select(2, C_MountJournal.GetMountInfoByID(tooltipData.id)), "spell"
	end
	if tooltipData.type == Enum.TooltipDataType.Toy and tooltipData.id then
		return tooltipData.id, "item"
	end
end
function strategies.wowhead.GetAchievementFromFocus(data)
	if not data.focus.id or not data.focus.DateCompleted then
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
	if (data.focus.id and not data.focus.module) or not data.focus:GetParent() then
		return
	end
	local parent = data.focus:GetParent()
	local id = data.focus.id or parent.id
	local focusName = data.focus:GetName()
	if parent.module == ACHIEVEMENT_TRACKER_MODULE or
	(focusName ~= nil and string.find(focusName, "^AchievementFrameCriteria") ~= nil) or
	(data.focus.module ~= nil and data.focus.module.friendlyName == "ACHIEVEMENT_TRACKER_MODULE") then
		return id, "achievement"
	end
	return id, "quest"
end
function strategies.wowhead.GetNpcFromTooltip(data)
	if not data.tooltip then
		return
	end
	local _, unit = data.tooltip:GetUnit()
	if not unit then
		return
	end
	return select(6, strsplit("-", UnitGUID(unit))), "npc"
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
	if not data.focus.petID and (not data.focus:GetParent() or not data.focus:GetParent().petID) then
		return
	end
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
	local selectedAppearance = C_TransmogCollection.GetAppearanceInfoBySource(data.focus.sourceID).appearanceID
	local selectedStyle = WardrobeCollectionFrame.tooltipSourceIndex
	local appearanceSources = C_TransmogCollection.GetAppearanceSources(selectedAppearance)
	CollectionWardrobeUtil.SortSources(appearanceSources, appearanceID, data.focus.sourceID)
	return appearanceSources[selectedStyle].itemID, "item"
end
function strategies.wowhead.GetRecipeFromFocus(data)
	if not data.focus.tradeSkillInfo then
		return
	end
	return data.focus.tradeSkillInfo.recipeID, "spell"
end
function strategies.wowhead.GetFactionFromFocus(data)
	if not data.focus.index or not data.focus.standingText then
		return
	end
	return select(14, GetFactionInfo(data.focus.index)), "faction"
end
function strategies.wowhead.GetCurrencyInTabFromFocus(data)
	if data.focus.isUnused == nil and (not data.focus:GetParent() or data.focus:GetParent().isUnused == nil) then
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
	local conduitData = C_Soulbinds.GetConduitCollectionData(conduitID)
	return conduitData.conduitItemID, "item"
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
	for _, tooltip in pairs(tooltipStates) do
		if tooltip.hyperlink then
			local id, type = GetFromLink(tooltip.hyperlink)
			if id and not type then
				return id
			end
		end
	end
end
function strategies.wowheadTradingPostActivity.GetTradingPostActivity(data)
	if not (data.focus.activityName and data.focus.requirementsList) then
		return
	end
	return data.focus.id
end
local function HookTooltip(tooltip)
	tooltipStates[tooltip] = {}
	hooksecurefunc(tooltip, "SetHyperlink",
		function(tooltip, hyperlink)
			tooltipStates[tooltip].hyperlink = hyperlink
	end)
	hooksecurefunc(tooltip, "SetRecipeReagentItem",
		function(tooltip, recipeId, reagentIndex)
			if C_TradeSkillUI.GetRecipeReagentItemLink then
				tooltipStates[tooltip].hyperlink = C_TradeSkillUI.GetRecipeReagentItemLink(recipeId, reagentIndex)
			end
	end)
	hooksecurefunc(tooltip, "SetUnitAura",
		function(tooltip, unit, index, filter)
			tooltipStates[tooltip].aura = select(10, UnitAura(unit, index, filter))
	end)
	tooltip:HookScript("OnTooltipCleared",
		function(tooltip)
			tooltipStates[tooltip] = {}
	end)
end
local eventHookFrame = CreateFrame("Frame")
eventHookFrame:Hide()
eventHookFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventHookFrame:SetScript("OnEvent",
	function(self, event, arg1)
		if event == "PLAYER_ENTERING_WORLD" then
			HookTooltip(GameTooltip)
			HookTooltip(ItemRefTooltip)
		end
end)
