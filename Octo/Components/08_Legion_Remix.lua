local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local enable = true
if not enable then return end
----------------------------------------------------------------
local dropdownOrder = 8
local expansionID = 7
----------------------------------------------------------------
E.OctoTables_DataOtrisovka[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder] = {}
E.OctoTables_Vibor[dropdownOrder].icon = E.OctoTable_Expansions[expansionID].icon
E.OctoTables_Vibor[dropdownOrder].name = E.OctoTable_Expansions[expansionID].color..E.OctoTable_Expansions[expansionID].name.." (Remix)|r"
local function tempFunction(start)
	E.func_ResetOtrisovkaTables(dropdownOrder)
	if not start and not Octo_ToDo_DB_Vars.ExpansionToShow[dropdownOrder] then return end
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Currencies = {
		3292,3268,3252,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Items = {
		254267,
	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Reputations = {

	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].UniversalQuests = {

	}
	----------------------------------------------------------------
	E.OctoTables_DataOtrisovka[dropdownOrder].Additionally = {
		"LegionRemixResearch",
	}
	----------------------------------------------------------------
end

table.insert(E.Components, tempFunction)


local function localfunc2()
	local OctoTable_Otrisovka_textCENT = {}
	if Octo_ToDo_DB_Vars.ExpansionToShow[dropdownOrder] then
		table.insert(OctoTable_Otrisovka_textCENT, function(CharInfo)
				----------------------------------------------------------------
				local iconLEFT, textLEFT, colorLEFT, textCENT, settingsType, colorCENT, tooltipKey, isReputation, FIRSTrep, SECONDrep = nil, "", nil, "", nil, nil, nil, false, nil, nil
				tooltipKey = "LegionRemixResearch"
				if CharInfo.MASLENGO.LegionRemixData and CharInfo.MASLENGO.LegionRemixData.barValue and CharInfo.MASLENGO.LegionRemixData.barMax then
					local barValue = CharInfo.MASLENGO.LegionRemixData.barValue
					local barMax = CharInfo.MASLENGO.LegionRemixData.barMax
					local new_textCENT = barValue.."/"..barMax
					if CharInfo.MASLENGO.LegionRemixData.TotalInfinityResearchQuests then
						new_textCENT = barValue..E.Blue_Color.."("..CharInfo.MASLENGO.LegionRemixData.TotalInfinityResearchQuests..")|r" .."/"..barMax
					end
					textCENT = new_textCENT
				end
				----------------------------------------------------------------
				textLEFT = L["Infinite Research"]
				colorLEFT = E.OctoTable_Expansions[7].color
				settingsType = "Other#".."LegionRemixResearch"
				----------------------------------------------------------------
				return iconLEFT, textLEFT, colorLEFT, textCENT, settingsType, colorCENT, tooltipKey, isReputation, FIRSTrep, SECONDrep
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka_textCENT
end