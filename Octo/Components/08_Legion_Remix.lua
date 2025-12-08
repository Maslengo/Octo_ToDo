local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local categoryKey = 8
local expansionID = 7
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[categoryKey] = {}
E.OctoTables_Vibor[categoryKey] = {}
E.OctoTables_Vibor[categoryKey].icon = E.OctoTable_Expansions[expansionID].icon
E.OctoTables_Vibor[categoryKey].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].nameBlizzard.." (Remix)|r"
local function tempFunction(start)
	E.func_ResetOtrisovkaTables(categoryKey)
	if not start and not Octo_ToDo_DB_Vars.ExpansionToShow[categoryKey] then return end
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Currencies = {
		3292,3268,3252,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Items = {
		254267,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Reputations = {

	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].UniversalQuests = {

	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[categoryKey].Additionally = {
		"LegionRemixResearch",
	}
	----------------------------------------------------------------
end

table.insert(E.Components, tempFunction)


local function localfunc2()
	local OctoTable_Otrisovka_TextCenter = {}
	if Octo_ToDo_DB_Vars.ExpansionToShow[categoryKey] then
		table.insert(OctoTable_Otrisovka_TextCenter, function(CharInfo)
				----------------------------------------------------------------
				local IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation = nil, "", nil, "", nil, nil, nil, false, nil, nil
				TooltipKey = "LegionRemixResearch"
				if CharInfo.MASLENGO.LegionRemixData and CharInfo.MASLENGO.LegionRemixData.barValue and CharInfo.MASLENGO.LegionRemixData.barMax then
					local barValue = CharInfo.MASLENGO.LegionRemixData.barValue
					local barMax = CharInfo.MASLENGO.LegionRemixData.barMax
					local new_TextCenter = barValue.."/"..barMax
					if CharInfo.MASLENGO.LegionRemixData.TotalInfinityResearchQuests then
						new_TextCenter = barValue..E.Blue_Color.."("..CharInfo.MASLENGO.LegionRemixData.TotalInfinityResearchQuests..")|r" .."/"..barMax
					end
					TextCenter = new_TextCenter
				end
				----------------------------------------------------------------
				TextLeft = L["Infinite Research"]
				ColorLeft = E.OctoTable_Expansions[7].color
				SettingsType = "Other#".."LegionRemixResearch"
				----------------------------------------------------------------
				return IconLeft, TextLeft, ColorLeft, TextCenter, SettingsType, ColorCenter, TooltipKey, IsReputation, FirstReputation, SecondReputation
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_TextCenter
end