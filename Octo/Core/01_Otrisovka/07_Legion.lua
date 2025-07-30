local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
----------------------------------------------------------------
local OCTOexpansionID = 7
function E:func_Otrisovka_07_Legion()
	local OctoTable_Otrisovka = {}
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID] then
		table.insert(OctoTable_Otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType = "", nil, "", {}, nil, {}
				----------------------------------------------------------------
				textCENT = E:func_textCENT_Items(CharInfo, 124124)
				myType = {"Item", 124124}
				----------------------------------------------------------------
				textLEFT = E:func_GetItemNameByID(124124)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID].color
				----------------------------------------------------------------
				return textLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT, myType
				----------------------------------------------------------------
		end)
		E:funcOtrisivka_CURRENCIES(OctoTable_Otrisovka, OCTOexpansionID)
		E:func_Universal(OctoTable_Otrisovka, OCTOexpansionID)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_Otrisovka
end